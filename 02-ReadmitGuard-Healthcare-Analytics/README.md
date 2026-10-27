# ReadmitGuard: Hospital Readmission Analytics

Analysis of 101,766 diabetic patient encounters that identifies readmission patterns and supports a self-service Power BI dashboard.

➡️ **The full write-up, with screenshots and insights, is in the [main portfolio README](../README.md#02--readmitguard-hospital-readmission-analytics).**

## Files

| Folder | File | What it contains |
|--------|------|------------------|
| `data/` | [diabetic_data.csv](data/diabetic_data.csv) | Raw dataset: Diabetes 130-US Hospitals, 1999–2008 (101,766 rows × 50 columns) |
| `data/` | [descriptive_statistics.csv](data/descriptive_statistics.csv) | Summary statistics exported by the Python notebook |
| `excel/` | [diabetic_data.xlsx](excel/diabetic_data.xlsx) | PivotTables and charts: 30-day readmissions by age and gender, race distribution, readmission categories |
| `sql/` | [readmitguard_analysis.sql](sql/readmitguard_analysis.sql) | MySQL table definition and 8 analysis queries |
| `python/` | [readmitguard_eda.ipynb](python/readmitguard_eda.ipynb) | Missing-value audit, descriptive statistics, distributions, correlations, IQR outliers |
| `powerbi/` | [ReadmitGuard_Dashboard.pbix](powerbi/ReadmitGuard_Dashboard.pbix) | Interactive dashboard: 3 DAX KPI cards, 4 visuals, 6 slicers |
| `images/` | `excel/`, `python/`, `powerbi/` | Screenshots used in the README |

## Run the notebook

```bash
pip install -r ../requirements.txt
cd python && jupyter notebook readmitguard_eda.ipynb
```

The notebook reads its data from `../data/diabetic_data.csv`.
