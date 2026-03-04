#!/usr/bin/env python3
"""compare-plots.py -- Generate ACL vs SBCL comparison plots.

Usage:
    python3 Q-Batch-SBCL/Graph/compare-plots.py

Reads CI data from Q-Batch/Graph/ (ACL) and Q-Batch-SBCL/Graph/ (SBCL)
and produces PDF comparison plots in Q-Batch-SBCL/Graph/.

Requires: matplotlib (pip install matplotlib)
"""

import os
import sys

try:
    import matplotlib
    matplotlib.use('Agg')  # non-interactive backend
    import matplotlib.pyplot as plt
except ImportError:
    print("matplotlib not installed. Install with: pip install matplotlib")
    sys.exit(1)


def read_ci_dat(filepath):
    """Read a CI data file: noise  mean  lower  upper."""
    noise, mean, lower, upper = [], [], [], []
    with open(filepath) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split()
            if len(parts) >= 4:
                noise.append(int(parts[0]))
                mean.append(float(parts[1]))
                lower.append(float(parts[2]))
                upper.append(float(parts[3]))
    return noise, mean, lower, upper


def plot_comparison(acl_file, sbcl_file, output_pdf, title):
    """Plot ACL vs SBCL CI comparison."""
    fig, ax = plt.subplots(figsize=(10, 6))

    acl_n, acl_m, acl_lo, acl_hi = read_ci_dat(acl_file)
    sbcl_n, sbcl_m, sbcl_lo, sbcl_hi = read_ci_dat(sbcl_file)

    # ACL error bars
    acl_err_lo = [m - lo for m, lo in zip(acl_m, acl_lo)]
    acl_err_hi = [hi - m for m, hi in zip(acl_m, acl_hi)]
    ax.errorbar(acl_n, acl_m, yerr=[acl_err_lo, acl_err_hi],
                fmt='s-', color='#0000AA', markersize=4, capsize=3,
                label='ACL (original)', linewidth=1.5, alpha=0.8)

    # SBCL error bars
    sbcl_err_lo = [m - lo for m, lo in zip(sbcl_m, sbcl_lo)]
    sbcl_err_hi = [hi - m for m, hi in zip(sbcl_m, sbcl_hi)]
    ax.errorbar(sbcl_n, sbcl_m, yerr=[sbcl_err_lo, sbcl_err_hi],
                fmt='o-', color='#CC0000', markersize=4, capsize=3,
                label='SBCL (M4 Mac)', linewidth=1.5, alpha=0.8)

    ax.set_xlabel('Program statements (noise level)')
    ax.set_ylabel('Constraint checks (TCC)')
    ax.set_title(title)
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 1050)

    fig.tight_layout()
    fig.savefig(output_pdf, dpi=150)
    plt.close(fig)
    print(f"  {output_pdf}")


def plot_all_comparison(graph_dir):
    """Plot all experiments overlaid: ACL (dashed) vs SBCL (solid)."""
    fig, ax = plt.subplots(figsize=(12, 7))

    series = [
        ('ij2', 'Memory-CSP: BT + FCDR w/ adv sort', '#0000AA'),
        ('ij3', 'Memory-CSP: Both FCDR w/ adv sort', '#CC0000'),
        ('ij4', 'MAP-CSP: FCDR w/ adv sort', '#008800'),
    ]

    for name, label, color in series:
        acl_file = f"Q-Batch/Graph/{name}-ci.dat"
        sbcl_file = f"Q-Batch-SBCL/Graph/{name}-ci.dat"

        if os.path.exists(acl_file):
            acl_n, acl_m, _, _ = read_ci_dat(acl_file)
            ax.plot(acl_n, acl_m, '--', color=color, linewidth=1.2, alpha=0.6,
                    marker='s', markersize=3, label=f'ACL {name} ({label})')

        if os.path.exists(sbcl_file):
            sbcl_n, sbcl_m, _, _ = read_ci_dat(sbcl_file)
            ax.plot(sbcl_n, sbcl_m, '-', color=color, linewidth=1.8,
                    marker='o', markersize=3, label=f'SBCL {name} ({label})')

    ax.set_xlabel('Program statements (noise level)')
    ax.set_ylabel('Constraint checks (TCC)')
    ax.set_title('All experiments: ACL (dashed) vs SBCL (solid)')
    ax.legend(fontsize=8)
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 1050)
    ax.set_ylim(0, 250000)

    fig.tight_layout()
    output = os.path.join(graph_dir, "compare-all.pdf")
    fig.savefig(output, dpi=150)
    plt.close(fig)
    print(f"  {output}")


def main():
    graph_dir = "Q-Batch-SBCL/Graph"

    print("=== Generating comparison plots ===")

    for name, title in [
        ("ij2", "ij2: Memory-CSP BT + FCDR w/ adv sort"),
        ("ij3", "ij3: Memory-CSP Both FCDR w/ adv sort"),
        ("ij4", "ij4: MAP-CSP FCDR w/ adv sort"),
    ]:
        acl_file = f"Q-Batch/Graph/{name}-ci.dat"
        sbcl_file = f"{graph_dir}/{name}-ci.dat"
        output = f"{graph_dir}/compare-{name}-ci.pdf"

        if os.path.exists(acl_file) and os.path.exists(sbcl_file):
            plot_comparison(acl_file, sbcl_file, output, f"{title} -- ACL vs SBCL")
        else:
            missing = acl_file if not os.path.exists(acl_file) else sbcl_file
            print(f"  SKIP {name}: missing {missing}")

    print("\n=== Generating combined overlay plot ===")
    plot_all_comparison(graph_dir)

    print("\nDone.")


if __name__ == "__main__":
    main()
