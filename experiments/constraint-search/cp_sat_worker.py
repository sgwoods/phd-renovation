"""Optional CP-SAT backend over the validated Lisp model bridge; no source-code inference."""
import json
import platform
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent


def valid_assignment(model, assignment):
    """Check original model data, not compiled CP-SAT constraints."""
    if set(assignment) != {v["id"] for v in model["variables"]}:
        return False
    if any(assignment[v["id"]] not in v["domain"] for v in model["variables"]):
        return False
    for c in model["constraints"]:
        values = [assignment[key] for key in c["scope"]]
        if c["kind"] == "ALL-DIFFERENT":
            if len(set(values)) != len(values):
                return False
        elif c["kind"] == "TABLE":
            if values not in c["tuples"]:
                return False
        else:
            raise ValueError("Unsupported constraint kind")
    return True


def solve(model, mode, seconds):
    import ortools
    from ortools.sat.python import cp_model

    if mode not in ("all", "first") or seconds < 0:
        raise ValueError("Invalid solve configuration")
    started = time.monotonic()
    cp = cp_model.CpModel()
    # A global object map is essential: equal objects must share an integer even
    # when two variable domains list them in different orders.
    objects = sorted({value for v in model["variables"] for value in v["domain"]})
    codes = {value: index for index, value in enumerate(objects)}
    variables = {}
    for v in model["variables"]:
        if not v["domain"]:
            cp.add(False)
            variables[v["id"]] = cp.new_int_var(0, 0, v["id"])
        else:
            variables[v["id"]] = cp.new_int_var_from_domain(
                cp_model.Domain.from_values([codes[value] for value in v["domain"]]), v["id"])
    for c in model["constraints"]:
        scope = [variables[key] for key in c["scope"]]
        if c["kind"] == "ALL-DIFFERENT":
            cp.add_all_different(scope)
        elif c["kind"] == "TABLE":
            cp.add_allowed_assignments(scope, [[codes[value] for value in row] for row in c["tuples"]])
        else:
            raise ValueError("Unsupported constraint kind")
    encoded = time.monotonic()
    solver = cp_model.CpSolver()
    solver.parameters.num_search_workers = 1
    solver.parameters.random_seed = 0
    solver.parameters.max_time_in_seconds = seconds
    solver.parameters.enumerate_all_solutions = mode == "all"
    solutions = []

    class Collector(cp_model.CpSolverSolutionCallback):
        def on_solution_callback(self):
            solutions.append({key: objects[self.value(var)] for key, var in variables.items()})
            if mode == "first":
                self.stop_search()

    status = solver.solve(cp, Collector())
    finished = time.monotonic()
    if status == cp_model.MODEL_INVALID:
        raise ValueError(cp.validate())
    complete = status == cp_model.INFEASIBLE or (mode == "all" and status == cp_model.OPTIMAL)
    if not all(valid_assignment(model, assignment) for assignment in solutions):
        raise ValueError("CP-SAT returned a witness invalid under the original model")
    keys = lambda rows: {tuple(sorted(a.items())) for a in rows}
    if len(keys(solutions)) != len(solutions):
        raise ValueError("Duplicate CP-SAT solutions")
    parity = None
    if complete and model["oracle_complete"]:
        parity = keys(solutions) == keys(model["oracle_solutions"])
        if not parity:
            raise ValueError("CP-SAT/Lisp oracle solution sets differ")
    return {
        "schema_version": 1, "instance_id": model["id"], "provenance": model["provenance"],
        "status": "SAT" if solutions else "UNSAT" if complete else "UNKNOWN",
        "complete": complete, "termination": "EXHAUSTED" if complete else "FIRST-WITNESS" if solutions and mode == "first" else "SOLVER-LIMIT",
        "solution_count": len(solutions), "solutions": solutions, "parity": parity,
        "witnesses_valid": True if solutions else None,
        "oracle_complete": model["oracle_complete"], "oracle_solution_count": len(model["oracle_solutions"]),
        "ortools_version": ortools.__version__, "backend_raw_status": solver.status_name(status),
        "backend_python_version": platform.python_version(),
        "encoding_seconds": encoded - started, "solve_seconds": finished - encoded,
        "verification_seconds": time.monotonic() - finished,
        "backend_branches": solver.num_branches, "backend_conflicts": solver.num_conflicts,
    }


def main():
    try:
        path, mode, seconds = sys.argv[1:]
        bridge = subprocess.run(["sbcl", "--script", str(HERE / "dump-model.lisp"), path],
                                capture_output=True, text=True, timeout=30)
        if bridge.returncode:
            raise ValueError(bridge.stderr)
        model = json.loads(bridge.stdout)
        print(json.dumps(solve(model, mode, int(seconds)), sort_keys=True))
        return 0
    except (ImportError, ValueError, OSError, subprocess.TimeoutExpired) as error:
        print(json.dumps({"status": "ERROR", "reason": str(error), "complete": False, "parity": None}))
        return 1


if __name__ == "__main__":
    sys.exit(main())
