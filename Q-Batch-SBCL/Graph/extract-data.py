#!/usr/bin/env python3
"""extract-data.py -- Extract raw data and compute CIs from Q-Batch experiment outputs.

Usage:
    python3 Q-Batch-SBCL/Graph/extract-data.py

Reads output files from Q-Batch-SBCL/ij2/, ij3/, ij4/ and produces:
    Q-Batch-SBCL/Graph/ij2-raw.dat, ij2-ci.dat, ij2-ci-time.dat
    Q-Batch-SBCL/Graph/ij3-raw.dat, ij3-ci.dat, ij3-ci-time.dat, ij3-other-ci.dat
    Q-Batch-SBCL/Graph/ij4-raw.dat, ij4-ci.dat, ij4-ci-time.dat

Also generates comparison data overlaying original ACL results from Q-Batch/Graph/.
"""

import os
import re
import math
import glob
from collections import defaultdict

# t-distribution critical values for 95% CI (two-tailed, alpha=0.05)
# t(0.025, n-1) for small samples
T_CRITICAL = {
    1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776, 5: 2.571,
    6: 2.447, 7: 2.365, 8: 2.306, 9: 2.262, 10: 2.228,
    11: 2.201, 12: 2.179, 13: 2.160, 14: 2.145, 15: 2.131,
    19: 2.093, 29: 2.045, 99: 1.984,
}

def t_crit(n):
    """Get t-critical value for n-1 degrees of freedom."""
    df = n - 1
    if df in T_CRITICAL:
        return T_CRITICAL[df]
    # Approximate for large df
    return 1.96

def confidence_interval(values):
    """Compute mean, lower CI, upper CI for 95% confidence."""
    n = len(values)
    if n == 0:
        return 0, 0, 0
    if n == 1:
        return values[0], values[0], values[0]
    mean = sum(values) / n
    variance = sum((x - mean) ** 2 for x in values) / (n - 1)
    std_err = math.sqrt(variance / n)
    margin = t_crit(n) * std_err
    return mean, mean - margin, mean + margin

# Column layout in output files:
# noise  bt/ T/ NIL/ T/ T  ident  phase/dsize  NCC  TCC  BT / V  AP  S  Total  NumS  BJ  TypA/B  FCcost  DRcost  ASort/AStime  ConsSort
#
# We parse by splitting on whitespace. The key fields after splitting:
# For ij2/ij3 "both" lines:
#   [0]=noise [1-5]=mode [6]=ident [7]="both" [8]=NCC [9]=TCC [10]=BT [11]="/" [12]=V
#   [13]=AP [14]=S [15]=Total ...
# For ij4 data lines:
#   [0]=noise [1-5]=mode [6]=ident [7]=dsize [8]=NCC [9]=TCC [10]=BT [11]="/" [12]=V
#   [13]=AP [14]=S [15]=Total ...

def parse_data_line(line):
    """Parse a data line, return (noise, ident, tcc, total_time) or None."""
    line = line.strip()
    if not line or line.startswith('>') or line.startswith(';') or line.startswith('Size'):
        return None
    parts = line.split()
    if len(parts) < 16:
        return None
    try:
        noise = int(parts[0])
        ident = parts[6]
        tcc = int(parts[9])
        total_time = float(parts[15])
        return noise, ident, tcc, total_time
    except (ValueError, IndexError):
        return None


def extract_ij2_ij3(series, src_dir, graph_dir):
    """Extract data from memory-search output files (3 lines per run)."""
    raw_lines = []
    raw_all_lines = []
    raw_p1_lines = []
    data_by_noise_tcc = defaultdict(list)
    data_by_noise_time = defaultdict(list)

    noise_levels = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
                    550, 600, 650, 700, 750, 800, 850, 900, 950, 1000]
    suffixes = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "99"]

    for noise in noise_levels:
        noise_label = f"0{noise}" if noise < 100 else str(noise)
        for suffix in suffixes:
            filename = os.path.join(src_dir, f"{series}-{noise_label}.{suffix}")
            if not os.path.exists(filename):
                continue
            with open(filename) as f:
                lines = f.readlines()
            for line in lines:
                line = line.strip()
                if not line or not line[0].isdigit():
                    continue
                parts = line.split()
                if len(parts) < 16:
                    continue
                phase = parts[7]
                raw_all_lines.append(line)
                if phase == "phase1":
                    raw_p1_lines.append(line)
                elif phase == "both":
                    # Convert to raw.dat format: replace "both" with "0.000000", add @
                    parsed = parse_data_line(line)
                    if parsed:
                        noise_val, ident, tcc, total = parsed
                        data_by_noise_tcc[noise_val].append(tcc)
                        data_by_noise_time[noise_val].append(total)
                        # Reconstruct raw.dat line with @ marker
                        dat_line = line.replace("both", "0.000000", 1)
                        dat_parts = dat_line.split(None, 1)
                        dat_line = f"{dat_parts[0]}  @    {dat_parts[1]}"
                        raw_lines.append(dat_line)

    # Write raw files
    header = "Size\tMo/NC /AC /FC /DR   Ident\tDsize\tNCC\tTCC\tBT / V\t      AP      S\t     Total    NumS    BJ   TypA/B    FCcost    DRcost    ASort/AStime ConsSort\n"

    with open(os.path.join(graph_dir, f"{series}-raw.all"), 'w') as f:
        f.write(header + "\n")
        for line in raw_all_lines:
            f.write(line + "\n")

    with open(os.path.join(graph_dir, f"{series}-raw.dat"), 'w') as f:
        f.write(header + "\n")
        for line in raw_lines:
            f.write(line + "\n")

    with open(os.path.join(graph_dir, f"{series}-raw.p1"), 'w') as f:
        for line in raw_p1_lines:
            f.write(line + "\n")

    # Compute CIs
    write_ci(data_by_noise_tcc, os.path.join(graph_dir, f"{series}-ci.dat"))
    write_ci(data_by_noise_time, os.path.join(graph_dir, f"{series}-ci-time.dat"))

    return data_by_noise_tcc, data_by_noise_time


def extract_ij3_other(src_dir, graph_dir):
    """Extract phase1-only CI for ij3 (the 'other' comparison without memory)."""
    data_by_noise_tcc = defaultdict(list)

    noise_levels = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
                    550, 600, 650, 700, 750, 800, 850, 900, 950, 1000]
    suffixes = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "99"]

    for noise in noise_levels:
        noise_label = f"0{noise}" if noise < 100 else str(noise)
        for suffix in suffixes:
            filename = os.path.join(src_dir, f"ij3-{noise_label}.{suffix}")
            if not os.path.exists(filename):
                continue
            with open(filename) as f:
                lines = f.readlines()
            for line in lines:
                line = line.strip()
                if not line or not line[0].isdigit():
                    continue
                parts = line.split()
                if len(parts) < 16:
                    continue
                phase = parts[7]
                if phase == "phase1":
                    parsed = parse_data_line(line)
                    if parsed:
                        noise_val, ident, tcc, total = parsed
                        data_by_noise_tcc[noise_val].append(tcc)

    write_ci(data_by_noise_tcc, os.path.join(graph_dir, "ij3-other-ci.dat"))
    return data_by_noise_tcc


def extract_ij4(src_dir, graph_dir):
    """Extract data from direct adt output files (1 data line per run)."""
    raw_lines = []
    data_by_noise_tcc = defaultdict(list)
    data_by_noise_time = defaultdict(list)

    noise_levels = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
                    550, 600, 650, 700, 750, 800, 850, 900, 950, 1000]
    suffixes = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "99"]

    for noise in noise_levels:
        noise_label = f"0{noise}" if noise < 100 else str(noise)
        for suffix in suffixes:
            filename = os.path.join(src_dir, f"Test-ij4-{noise_label}.{suffix}")
            if not os.path.exists(filename):
                continue
            with open(filename) as f:
                lines = f.readlines()
            for line in lines:
                line = line.strip()
                if not line or not line[0].isdigit():
                    continue
                parsed = parse_data_line(line)
                if parsed:
                    noise_val, ident, tcc, total = parsed
                    data_by_noise_tcc[noise_val].append(tcc)
                    data_by_noise_time[noise_val].append(total)
                    # Add @ marker for raw.dat format
                    parts = line.split(None, 1)
                    raw_lines.append(f" {parts[0]}   @  {parts[1]}")

    with open(os.path.join(graph_dir, "ij4-raw.dat"), 'w') as f:
        for line in raw_lines:
            f.write(line + "\n")

    write_ci(data_by_noise_tcc, os.path.join(graph_dir, "ij4-ci.dat"))
    write_ci(data_by_noise_time, os.path.join(graph_dir, "ij4-ci-time.dat"))

    return data_by_noise_tcc, data_by_noise_time


def write_ci(data_by_noise, filename):
    """Write CI data file: noise  mean  lower  upper."""
    with open(filename, 'w') as f:
        for noise in sorted(data_by_noise.keys()):
            values = data_by_noise[noise]
            mean, lower, upper = confidence_interval(values)
            f.write(f"{noise}   {mean:f}   {lower:f}   {upper:f}\n")


def main():
    sbcl_ij2_dir = "Q-Batch-SBCL/ij2"
    sbcl_ij3_dir = "Q-Batch-SBCL/ij3"
    sbcl_ij4_dir = "qcsp3/ADT-Batch"
    graph_dir = "Q-Batch-SBCL/Graph"

    os.makedirs(graph_dir, exist_ok=True)

    print("=== Extracting ij2 (memory-search baseline) ===")
    ij2_tcc, ij2_time = extract_ij2_ij3("ij2", sbcl_ij2_dir, graph_dir)
    for noise in sorted(ij2_tcc.keys()):
        n = len(ij2_tcc[noise])
        mean, lo, hi = confidence_interval(ij2_tcc[noise])
        print(f"  noise={noise:4d}  n={n:2d}  TCC mean={mean:10.1f}  CI=[{lo:.1f}, {hi:.1f}]")

    print("\n=== Extracting ij3 (memory-search + FC/DR/advance-sort) ===")
    if os.path.exists(sbcl_ij3_dir) and os.listdir(sbcl_ij3_dir):
        ij3_tcc, ij3_time = extract_ij2_ij3("ij3", sbcl_ij3_dir, graph_dir)
        extract_ij3_other(sbcl_ij3_dir, graph_dir)
        for noise in sorted(ij3_tcc.keys()):
            n = len(ij3_tcc[noise])
            mean, lo, hi = confidence_interval(ij3_tcc[noise])
            print(f"  noise={noise:4d}  n={n:2d}  TCC mean={mean:10.1f}  CI=[{lo:.1f}, {hi:.1f}]")
    else:
        print("  (no ij3 output files yet)")

    print("\n=== Extracting ij4 (direct adt + FC/DR/advance-sort) ===")
    if os.path.exists(sbcl_ij4_dir) and os.listdir(sbcl_ij4_dir):
        ij4_tcc, ij4_time = extract_ij4(sbcl_ij4_dir, graph_dir)
        for noise in sorted(ij4_tcc.keys()):
            n = len(ij4_tcc[noise])
            mean, lo, hi = confidence_interval(ij4_tcc[noise])
            print(f"  noise={noise:4d}  n={n:2d}  TCC mean={mean:10.1f}  CI=[{lo:.1f}, {hi:.1f}]")
    else:
        print("  (no ij4 output files yet)")

    # Summary
    print("\n=== Output files ===")
    for f in sorted(glob.glob(os.path.join(graph_dir, "*.dat"))):
        lines = sum(1 for _ in open(f) if _.strip())
        print(f"  {f}  ({lines} data lines)")


if __name__ == "__main__":
    main()
