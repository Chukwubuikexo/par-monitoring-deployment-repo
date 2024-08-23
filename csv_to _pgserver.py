#pip install psycopg2

#%%
import pandas as pd
from sqlalchemy import create_engine
#%%
# Connect to PostgreSQL
engine = create_engine('postgresql://postgres:xxxxX@localhost:5432/autochek')

#Load datasets
borrowers_df = pd.read_csv(r"C:\Users\mabne\Documents\Autochek\Borrower_table.csv")
loans_df = pd.read_csv(r"C:\Users\mabne\Documents\Autochek\Loan_table.csv")
payment_schedule_df = pd.read_csv(r"C:\Users\mabne\Documents\Autochek\Payment_schedule.csv")
loan_payments_df = pd.read_csv(r"C:\Users\mabne\Documents\Autochek\Loan_payment.csv")

# Transform and Load data into PostgreSQL
borrowers_df.to_sql('borrower_dimension', engine, if_exists='replace', index=False)
loans_df.to_sql('loan_dimension', engine, if_exists='replace', index=False)
payment_schedule_df.to_sql('payment_schedule_dimension', engine, if_exists='replace', index=False)

# Join data to get scheduled payment amounts in loan payments fact
loan_payments_df = loan_payments_df.merge(payment_schedule_df[['loan_id', 'expected_payment_amount']], on='loan_id', how='left')

# Load data
loan_payments_df.to_sql('loan_payments_fact', engine, if_exists='replace', index=False)

# %%
