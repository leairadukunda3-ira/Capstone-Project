# RetailVC: Customer & Marketing Campaign Analytics

Analysis of 2,240 retail customers that explains who responds to marketing campaigns and how to improve promotion ROI.

➡️ **The full write-up, with screenshots and insights, is in the [main portfolio README](../README.md#01--retailvc-customer--marketing-campaign-analytics).**

## Files

| Folder | File | What it contains |
|--------|------|------------------|
| `docs/` | [problem_statement.pdf](docs/problem_statement.pdf) | Original business brief and task list |
| `data/` | [marketing_campaign.csv](data/marketing_campaign.csv) | Raw dataset (2,240 rows × 30 columns) |
| `excel/` | [RetailVC_Retail_Analytics.xlsx](excel/RetailVC_Retail_Analytics.xlsx) | Statistical summary, enrolments by year, Response × Education cross-tab, income box plot, age histogram, Response × Marital Status |
| `sql/` | [retailvc_retail_analytics.sql](sql/retailvc_retail_analytics.sql) | MySQL schema, data loading and cleaning, 12 analysis queries |
| `python/` | [retailvc_marketing_eda.ipynb](python/retailvc_marketing_eda.ipynb) | Cleaning, imputation, feature engineering, outlier capping, encoding, correlation, t-test |
| `images/` | `excel/`, `python/` | Screenshots used in the README |

## Run the notebook

```bash
pip install -r ../requirements.txt
cd python && jupyter notebook retailvc_marketing_eda.ipynb
```

The notebook reads its data from `../data/marketing_campaign.csv`.
