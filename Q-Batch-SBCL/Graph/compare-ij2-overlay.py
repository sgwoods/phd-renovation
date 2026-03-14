#!/usr/bin/env python3
"""compare-ij2-overlay.py -- Plot ACL vs SBCL ij2 results with CI bands."""

import math
import os
from collections import defaultdict

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

T_CRITICAL = {9: 2.262}

def ci(values):
    n = len(values)
    mean = sum(values) / n
    var = sum((x - mean) ** 2 for x in values) / (n - 1)
    se = math.sqrt(var / n)
    margin = T_CRITICAL.get(n - 1, 1.96) * se
    return mean, mean - margin, mean + margin


def read_acl_ci(path):
    """Read pre-computed ACL CI data."""
    data = {}
    with open(path) as f:
        for line in f:
            p = line.split()
            if len(p) >= 4:
                data[int(p[0])] = (float(p[1]), float(p[2]), float(p[3]))
    return data


def extract_sbcl_ij2(src_dir):
    """Extract non-zero TCC 'both' lines from SBCL ij2 output files."""
    by_noise = defaultdict(list)
    for fname in sorted(os.listdir(src_dir)):
        with open(os.path.join(src_dir, fname)) as f:
            for line in f:
                parts = line.split()
                if len(parts) >= 16 and parts[7] == 'both':
                    tcc = int(parts[9])
                    if tcc > 0:
                        by_noise[int(parts[0])].append(tcc)
    result = {}
    for noise in sorted(by_noise):
        result[noise] = ci(by_noise[noise])
    return result


def main():
    acl = read_acl_ci('Q-Batch/Graph/ij2-ci.dat')
    sbcl = extract_sbcl_ij2('Q-Batch-SBCL/ij2')

    # Shared noise levels
    shared = sorted(set(acl) & set(sbcl))
    sbcl_only = sorted(set(sbcl) - set(acl))

    fig, ax = plt.subplots(figsize=(10, 6))

    # ACL: mean line + CI band
    a_noise = [n for n in shared]
    a_mean = [acl[n][0] for n in shared]
    a_lo = [acl[n][1] for n in shared]
    a_hi = [acl[n][2] for n in shared]

    ax.plot(a_noise, a_mean, 'o-', color='#2166ac', linewidth=2, markersize=5,
            label='ACL (Allegro CL, SPARC)', zorder=3)
    ax.fill_between(a_noise, a_lo, a_hi, alpha=0.20, color='#2166ac', zorder=1)

    # SBCL: mean line + CI band (all noise levels)
    s_all = sorted(sbcl)
    s_mean = [sbcl[n][0] for n in s_all]
    s_lo = [sbcl[n][1] for n in s_all]
    s_hi = [sbcl[n][2] for n in s_all]

    ax.plot(s_all, s_mean, 's--', color='#b2182b', linewidth=2, markersize=5,
            label='SBCL (M4 Mac)', zorder=3)
    ax.fill_between(s_all, s_lo, s_hi, alpha=0.20, color='#b2182b', zorder=1)

    ax.set_xlabel('Extraneous Statements (Noise)', fontsize=12)
    ax.set_ylabel('Total Constraint Checks (TCC)', fontsize=12)
    ax.set_title('ij2: Memory-Search Baseline — ACL vs SBCL\n95% Confidence Intervals (n=10 per noise level)',
                 fontsize=13)
    ax.legend(fontsize=11, loc='upper left')
    ax.grid(True, alpha=0.3)

    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1000:.0f}k'))
    ax.set_xlim(0, 1050)
    ax.set_ylim(bottom=0)

    plt.tight_layout()
    out = 'Q-Batch-SBCL/Graph/compare-ij2-overlay.png'
    plt.savefig(out, dpi=150)
    print(f'Saved: {out}')


if __name__ == '__main__':
    main()
