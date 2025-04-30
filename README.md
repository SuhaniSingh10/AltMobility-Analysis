# ⚡ AltMobility Data Analysis

## 📊 Project Overview

This project is a comprehensive data-driven investigation into customer orders, payment behaviors, revenue trends, and customer lifetime value for AltMobility — a sustainable mobility solution provider. The analysis was carried out using structured SQL queries across four core business domains: **Orders**, **Payments**, **Customers**, and their **Interactions**.

> ✅ **Goal**: Uncover actionable insights that can drive growth, reduce payment friction, increase customer retention, and improve revenue predictability.

---

## 🧠 Business Questions Solved

### 🔹 Customer Analytics
- Who are our most loyal and high-value customers?
- What percentage of customers are at risk of churn?
- How do different customer segments behave?
- What’s our customer acquisition and retention trend over time?

### 🔹 Order & Sales Insights
- How much revenue are we generating over time?
- What is the average order value, and how does it change monthly?
- What proportion of revenue comes from the top 10% of orders?
- What are the daily/weekly patterns in ordering?

### 🔹 Payment Analytics
- What’s our payment success vs. failure rate?
- Which payment methods are most reliable?
- Are we facing overpayments or mismatched transactions?
- How much time passes between ordering and payment?

### 🔹 Combined Operational Insights
- Which orders are pending due to failed or missing payments?
- Are there customers who overpaid or paid partially?
- What are the average payment attempts per order?
- Which payment methods are preferred by high-value customers?

---

## 🛠️ Datasets Used

- `customer_orders`: Contains order-level data with customer, date, status, and amount.
- `payments`: Contains payment attempts, status, method, amount, and date.

---

## 🧮 Analytical Approach

### ✅ 1. Exploratory SQL Queries
Performed over 40 handcrafted SQL queries to:
- **Profile customers** (repeat vs. one-time, LTV, churn risk)
- **Track revenue and order trends** (monthly revenue, AOV, top orders)
- **Evaluate payment behavior** (delay, success rate, failed attempts)

### ✅ 2. KPI-Driven Design
The analysis was driven by business KPIs such as:
- Customer Retention Rate
- Churn Prediction
- Average Order Value (AOV)
- Payment Success Rate
- Revenue Growth %

### ✅ 3. Anomaly Detection
Identified edge cases including:
- Overpaid and underpaid orders
- Orders marked delivered but unpaid
- Orders with conflicting payment statuses

---

### 📊 4. Customer Retention Visualization

Here's a visualization of customer retention over a 6-month period:

![Customer Retention Chart]("C:\Users\Sagar\OneDrive\Desktop\Projects for Resume\AltMobility Data Analysis\Vizualization.pdf")


## 💡 Key Insights

| Insight | Impact |
|--------|--------|
| 📉 ~30% of customers placed only one order | Opportunity to improve retention |
| 📈 High-value customers prefer specific payment methods | Optimize payment UX for them |
| ⏱ Average delay between order and payment ~2.3 days | Improve payment conversion funnel |
| 🔁 Some orders have multiple failed payment attempts | Indicate friction in checkout |
| 💸 Over 12% of payments have mismatched or partial amounts | Financial reconciliation risk |

---

## 🙋‍♀️ Author

**Suhani Singh**  
Aspiring Data Analyst | Passionate about Data Storytelling  

