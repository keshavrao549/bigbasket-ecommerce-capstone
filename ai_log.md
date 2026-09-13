# AI-Assisted Prompt #1 (RCTCF)

## Role

Act as a SQL data analyst experienced with SQLite and BigQuery.

## Context

I am working on a BigBasket Category Revenue Analysis project. The database contains orders, products, customers, and category target data. The orders table contains order_id, order_date, customer_name, city, category, product_id, quantity, amount_inr, payment_mode, status, and rating. I need a monthly-by-category revenue report using only Delivered orders.

## Task

Write a SQL query that returns category, month, order_count, total_revenue, and avg_revenue, grouped by category and month.

## Constraints

Use only Delivered orders. The month should be in YYYY-MM format. The output must contain exactly these five columns: category, month, order_count, total_revenue, avg_revenue. Order the results by category and then month.

## Format

Return only the SQL query in a code block and briefly explain what it does.

## Verification Performed

I ran the AI-assisted query in BigQuery against the BigBasket dataset and checked the result. The original category values contained inconsistent capitalization and extra spaces, so I debugged the query by applying `TRIM`, `LOWER`, and `INITCAP` to standardize the category names. I then ran the corrected query and verified that it returned exactly 36 rows, representing 6 categories across 6 months, with the required five columns: `category`, `month`, `order_count`, `total_revenue`, and `avg_revenue`.


# ==============================================================================
# STEP 1: DATA PREPARATION & TYPE CASTING
# ==============================================================================

# Ensure products.csv and customers.csv metadata are merged into df_clean
if 'city' not in df_clean.columns:
    df_clean = df_clean.merge(customers[['customer_id', 'city']], on='customer_id', how='left')

if 'supplier' not in df_clean.columns or 'category' not in df_clean.columns:
    df_clean = df_clean.merge(products[['product_id', 'category', 'supplier']], on='product_id', how='left')

# Cast amount_inr to float to avoid Pandas dtype assignment warnings during capping
df_clean['amount_inr'] = df_clean['amount_inr'].astype(float)


# ==============================================================================
# STEP 2: IQR OUTLIER DETECTION & CAPPING
# ==============================================================================

# Mask for Delivered orders with valid amount_inr
delivered_mask = (df_clean['status'] == 'Delivered') & (df_clean['amount_inr'].notna())

# Calculate Q1, Q3, IQR, and Upper Fence on Delivered orders
q1 = df_clean.loc[delivered_mask, 'amount_inr'].quantile(0.25)
q3 = df_clean.loc[delivered_mask, 'amount_inr'].quantile(0.75)
iqr = q3 - q1
upper_fence = q3 + 1.5 * iqr

# Count extreme values and apply upper fence capping
capped_rows_count = (df_clean.loc[delivered_mask, 'amount_inr'] > upper_fence).sum()
df_clean.loc[delivered_mask, 'amount_inr'] = df_clean.loc[delivered_mask, 'amount_inr'].clip(upper=upper_fence)

print(f"--- Outlier Capping Audit ---")
print(f"Q1: {q1:.2f} | Q3: {q3:.2f} | Upper Fence: {upper_fence:.2f}")
print(f"Rows Capped: {capped_rows_count}\n")


# ==============================================================================
# STEP 3: PARSE DATES & FEATURE ENGINEERING
# ==============================================================================

# Parse date and extract temporal attributes
df_clean['order_date'] = pd.to_datetime(df_clean['order_date'])
df_clean['month'] = df_clean['order_date'].dt.month
df_clean['month_name'] = df_clean['order_date'].dt.month_name()

# Calculate unit economics and fulfillment flag
df_clean['revenue_per_unit'] = df_clean['amount_inr'] / df_clean['quantity']
df_clean['is_delivered'] = df_clean['status'] == 'Delivered'


# ==============================================================================
# STEP 4: REVENUE AGGREGATION & CROSS-VALIDATION
# ==============================================================================

# Isolate completed orders for revenue reporting
df_delivered = df_clean[(df_clean['is_delivered']) & (df_clean['amount_inr'].notna())]

# (a) Total Revenue per Category
cat_rev = (
    df_delivered.groupby('category')['amount_inr']
    .sum()
    .reset_index()
    .sort_values(by='amount_inr', ascending=False)
)

# (b) Total Revenue per Supplier
sup_rev = (
    df_delivered.groupby('supplier')['amount_inr']
    .sum()
    .reset_index()
    .sort_values(by='amount_inr', ascending=False)
)

print("================ (a) REVENUE BY CATEGORY ================")
print(cat_rev.to_string(index=False))

print("\n================ (b) REVENUE BY SUPPLIER ================")
print(sup_rev.to_string(index=False))
