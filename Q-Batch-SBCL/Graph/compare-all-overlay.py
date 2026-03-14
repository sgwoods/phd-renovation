#!/usr/bin/env python3
"""compare-all-overlay.py -- Plot ACL vs SBCL results for ij2, ij3, ij4 with CI bands."""

import math
import os
import subprocess
from collections import defaultdict
from datetime import datetime

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

T_CRITICAL = {
    1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776, 5: 2.571,
    6: 2.447, 7: 2.365, 8: 2.306, 9: 2.262, 10: 2.228,
    19: 2.093, 29: 2.045,
}

def t_crit(n):
    df = n - 1
    if df in T_CRITICAL:
        return T_CRITICAL[df]
    return 1.96

def ci(values):
    n = len(values)
    if n < 2:
        return values[0], values[0], values[0]
    mean = sum(values) / n
    var = sum((x - mean) ** 2 for x in values) / (n - 1)
    se = math.sqrt(var / n)
    margin = t_crit(n) * se
    return mean, mean - margin, mean + margin


def read_acl_ci(path):
    data = {}
    with open(path) as f:
        for line in f:
            p = line.split()
            if len(p) >= 4:
                data[int(p[0])] = (float(p[1]), float(p[2]), float(p[3]))
    return data


def extract_sbcl_memory(src_dir, series):
    """Extract non-zero TCC 'both' lines from memory-search output files."""
    by_noise = defaultdict(list)
    for fname in sorted(os.listdir(src_dir)):
        with open(os.path.join(src_dir, fname)) as f:
            for line in f:
                parts = line.split()
                if len(parts) >= 16 and parts[7] == 'both':
                    tcc = int(parts[9])
                    if tcc > 0:
                        by_noise[int(parts[0])].append(tcc)
    return {n: ci(v) for n, v in sorted(by_noise.items())}


def extract_sbcl_ij4(src_dir):
    """Extract TCC from direct adt output files."""
    by_noise = defaultdict(list)
    for fname in sorted(os.listdir(src_dir)):
        if not fname.startswith('Test-ij4'):
            continue
        with open(os.path.join(src_dir, fname)) as f:
            for line in f:
                parts = line.split()
                if len(parts) >= 16:
                    try:
                        noise = int(parts[0])
                        tcc = int(parts[9])
                        by_noise[noise].append(tcc)
                    except ValueError:
                        continue
    return {n: ci(v) for n, v in sorted(by_noise.items())}


def plot_series(ax, acl, sbcl, title, ylabel_fmt='k'):
    """Plot one ACL vs SBCL comparison on given axes."""
    shared = sorted(set(acl) & set(sbcl))

    # ACL
    a_noise = shared
    a_mean = [acl[n][0] for n in shared]
    a_lo = [acl[n][1] for n in shared]
    a_hi = [acl[n][2] for n in shared]
    ax.plot(a_noise, a_mean, 'o-', color='#2166ac', linewidth=2, markersize=4,
            label='ACL (Allegro CL, SPARC)', zorder=3)
    ax.fill_between(a_noise, a_lo, a_hi, alpha=0.20, color='#2166ac', zorder=1)

    # SBCL
    s_all = sorted(sbcl)
    s_mean = [sbcl[n][0] for n in s_all]
    s_lo = [sbcl[n][1] for n in s_all]
    s_hi = [sbcl[n][2] for n in s_all]
    ax.plot(s_all, s_mean, 's--', color='#b2182b', linewidth=2, markersize=4,
            label='SBCL (M4 Mac)', zorder=3)
    ax.fill_between(s_all, s_lo, s_hi, alpha=0.20, color='#b2182b', zorder=1)

    ax.set_title(title, fontsize=12)
    ax.set_xlabel('Extraneous Statements (Noise)', fontsize=10)
    ax.set_ylabel('Total Constraint Checks', fontsize=10)
    ax.legend(fontsize=9, loc='upper left')
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 1050)
    ax.set_ylim(bottom=0)

    if ylabel_fmt == 'k':
        ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1000:.0f}k'))


def git_version():
    """Return git short hash + dirty flag, e.g. 'c780cc5' or 'c780cc5-dirty'."""
    try:
        desc = subprocess.check_output(
            ['git', 'describe', '--always', '--dirty'], text=True).strip()
        return desc
    except Exception:
        return 'unknown'


def main():
    version = git_version()
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M')
    stamp = f'{timestamp}  |  {version}'

    # --- ij2 ---
    acl_ij2 = read_acl_ci('Q-Batch/Graph/ij2-ci.dat')
    sbcl_ij2 = extract_sbcl_memory('Q-Batch-SBCL/ij2', 'ij2')

    # --- ij3 ---
    acl_ij3 = read_acl_ci('Q-Batch/Graph/ij3-ci.dat')
    sbcl_ij3 = extract_sbcl_memory('Q-Batch-SBCL/ij3', 'ij3')

    # --- ij4 ---
    acl_ij4 = read_acl_ci('Q-Batch/Graph/ij4-ci.dat')
    sbcl_ij4 = extract_sbcl_ij4('qcsp3/ADT-Batch')

    # --- Individual plots ---
    for series, acl, sbcl, desc in [
        ('ij2', acl_ij2, sbcl_ij2, 'Memory-Search Baseline (BT only)'),
        ('ij3', acl_ij3, sbcl_ij3, 'Memory-Search + FC/DR/Advance-Sort'),
        ('ij4', acl_ij4, sbcl_ij4, 'Direct ADT + FC/DR/Advance-Sort'),
    ]:
        fig, ax = plt.subplots(figsize=(10, 6))
        plot_series(ax, acl, sbcl, f'{series}: {desc} — ACL vs SBCL\n95% Confidence Intervals')
        fig.text(0.99, 0.01, stamp,
                 ha='right', va='bottom', fontsize=8, color='#888888')
        plt.tight_layout()
        out = f'Q-Batch-SBCL/Graph/compare-{series}-overlay.png'
        plt.savefig(out, dpi=150, bbox_inches='tight')
        plt.close()
        print(f'Saved: {out}')

    # --- Combined 3-panel figure ---
    fig, axes = plt.subplots(1, 3, figsize=(18, 6))
    for ax, (series, acl, sbcl, desc) in zip(axes, [
        ('ij2', acl_ij2, sbcl_ij2, 'ij2: Memory-Search\n(BT only)'),
        ('ij3', acl_ij3, sbcl_ij3, 'ij3: Memory-Search\n(FC/DR/Advance-Sort)'),
        ('ij4', acl_ij4, sbcl_ij4, 'ij4: Direct ADT\n(FC/DR/Advance-Sort)'),
    ]):
        plot_series(ax, acl, sbcl, desc)

    fig.suptitle('ACL (SPARC, 1996) vs SBCL (M4 Mac, 2026) — 95% CI Comparison',
                 fontsize=14, fontweight='bold', y=1.02)
    fig.text(0.99, -0.02, stamp,
             ha='right', va='bottom', fontsize=8, color='#888888')
    plt.tight_layout()
    out = 'Q-Batch-SBCL/Graph/compare-all-overlay.png'
    plt.savefig(out, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'Saved: {out}')


if __name__ == '__main__':
    main()
