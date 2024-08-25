-- Create the Dimensional Tables
CREATE TABLE borrower_dimension (
    borrower_id VARCHAR PRIMARY KEY,
    State VARCHAR,
    City VARCHAR,
    Zip_code INTEGER,
    Borrower_credit_score INTEGER
);

CREATE TABLE loan_dimension (
    Loan_id VARCHAR PRIMARY KEY,
    Borrower_id VARCHAR REFERENCES borrower_dimension (borrower_id),
    Date_of_release DATE,
    Term INTEGER,
    Interest_rate DECIMAL,
    Loan_amount DECIMAL,
    Down_payment DECIMAL,
    Payment_frequency VARCHAR,
    Maturity_date DATE
);

CREATE TABLE payment_schedule_dimension (
    Schedule_id VARCHAR PRIMARY KEY,
    Loan_id VARCHAR REFERENCES Dim_Loan(Loan_id),
    Expected_payment_date DATE,
    Expected_payment_amount DECIMAL
);

CREATE TABLE loan_payment_fact (
    Payment_id VARCHAR PRIMARY KEY,
    Loan_id VARCHAR REFERENCES Dim_Loan(Loan_id),
    Amount_paid DECIMAL,
    Date_paid DATE
);

CREATE TABLE fact_loan (
    Loan_id VARCHAR PRIMARY KEY,
    Borrower_Id VARCHAR REFERENCES borrower_dimension (borrower_Id),
    Loan_amount DECIMAL,
    Down_payment DECIMAL,
    Interest_rate DECIMAL,
    Payment_frequency VARCHAR,
    Term INTEGER,
    Maturity_date DATE,
    Expected_payment_date DATE,
    Expected_payment_amount DECIMAL,
    Amount_paid DECIMAL,
    Date_paid DATE,
    PAR_Days INTEGER
);
-- Calculate PAR Days
WITH UniqueRecords AS (
    SELECT DISTINCT ON (l.Loan_id) 
        l.Loan_id, 
        l.Borrower_id, 
        l.Loan_amount, 
        l.Down_payment, 
        l.Interest_rate, 
        l.Payment_frequency, 
        l.Term, 
        l.Maturity_date, 
        ps.Expected_payment_date, 
        ps.Expected_payment_amount, 
        lp.Amount_paid, 
        lp.Date_paid, 
        (lp.Date_paid - ps.Expected_payment_date)::integer AS PAR_Days
    FROM 
        loan_dimension l
    JOIN 
        payment_schedule_dimension ps ON l.Loan_id = ps.Loan_id
    JOIN 
        loan_payments_fact lp ON l.Loan_id = lp.Loan_id
    WHERE 
        lp.Date_paid > ps.Expected_payment_date
)
INSERT INTO Fact_Loan (Loan_id, Borrower_id, Loan_amount, Down_payment, Interest_rate, Payment_frequency, Term, Maturity_date, Expected_payment_date, Expected_payment_amount, Amount_paid, Date_paid, PAR_Days)
SELECT 
    Loan_id, 
    Borrower_id, 
    Loan_amount, 
    Down_payment, 
    Interest_rate, 
    Payment_frequency, 
    Term, 
    Maturity_date, 
    Expected_payment_date, 
    Expected_payment_amount, 
    Amount_paid, 
    Date_paid, 
    PAR_Days
FROM 
    UniqueRecords
ON CONFLICT (Loan_id) 
DO UPDATE SET
    Borrower_id = EXCLUDED.Borrower_id,
    Loan_amount = EXCLUDED.Loan_amount,
    Down_payment = EXCLUDED.Down_payment,
    Interest_rate = EXCLUDED.Interest_rate,
    Payment_frequency = EXCLUDED.Payment_frequency,
    Term = EXCLUDED.Term,
    Maturity_date = EXCLUDED.Maturity_date,
    Expected_payment_date = EXCLUDED.Expected_payment_date,
    Expected_payment_amount = EXCLUDED.Expected_payment_amount,
    Amount_paid = EXCLUDED.Amount_paid,
    Date_paid = EXCLUDED.Date_paid,
    PAR_Days = EXCLUDED.PAR_Days;
