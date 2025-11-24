import pandas as pd
import numpy as np

# Create date range
start_date = '2019-01-01'
end_date = '2022-12-31'
dates = pd.date_range(start=start_date, end=end_date, freq='D')

# Create DataFrame
df = pd.DataFrame({'date': dates})

# Add colums
df['date_sk'] = np.arange(1, len(df)+1)  # surrogate key ( use number from 0 or use yyyyMMdd as key)
df['year'] = df['date'].dt.year
df['quarter'] = df['date'].dt.quarter
df['month'] = df['date'].dt.month
df['day_of_week'] = df['date'].dt.weekday + 1  # 1=Monday, 7=Sunday
df['is_weekend'] = df['day_of_week'].apply(lambda x: 1 if x >=6 else 0)

# Order columns
df = df[['date_sk', 'date', 'year', 'quarter', 'month', 'day_of_week', 'is_weekend']]
# Output file CSV
df.to_csv('public.date.csv', index=False)

print("Create sucessful with", len(df), "rows")
