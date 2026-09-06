# On-Time Gift Delivery Decision & Performance Analysis

## Project Overview

This project analyzes historical gift-delivery performance to determine how reliably orders reach customers by their required occasion date.

The analysis focuses on identifying the main factors that influence on-time delivery and turning those findings into a customer decision-support framework.

## Business Problem

Customers ordering gifts for birthdays, weddings, anniversaries, festivals, and other occasions need to know whether an order is likely to arrive on time.

This project answers:

> Can historical delivery performance help support a customer decision about meeting a required occasion date?

## Key Findings

- Overall on-time delivery rate: **64.49%**
- Total orders analyzed: **12,000**
- Orders delivered late: **4,261**
- Orders delivered early: **6,307**
- Lead time is a major driver of delivery reliability.
- Orders placed **9+ days before the occasion date** have very high historical on-time performance.
- Longer delivery distances are associated with lower on-time performance.
- Backordered items have substantially lower historical on-time performance than in-stock items.
- Same-Day delivery has the highest historical on-time rate among delivery methods.

## Customer Decision Framework

| Lead Time | Historical On-Time Rate | Reliability |
|---|---:|---|
| 0–2 days | 12.22% | Very Low |
| 3–5 days | 40.12% | Low |
| 6–8 days | 73.15% | Moderate |
| 9–12 days | 95.28% | High |
| 13+ days | 100.00% | Very High |

### Business Conclusion

Historical delivery reliability is strongly influenced by **lead time and delivery distance**. Orders placed well in advance have substantially better historical on-time performance, while short lead times and long distances carry higher delivery risk.

This dashboard is a **historical decision-support analysis** and does not guarantee the delivery outcome of a future order.

## Tools Used

- **MySQL** — data analysis and SQL queries
- **Power BI** — interactive dashboard and visualization
- **Excel / CSV** — data preparation and validation
- **GitHub** — project documentation and portfolio presentation

## Dashboard

### Executive Dashboard

The executive dashboard summarizes overall delivery performance, lead-time reliability, distance effects, delivery-method performance, inventory impact, and the customer decision framework.

![Executive Dashboard](./screenshot/ON-TIME%20GIFT%20DELIVERY%20DECISION%20%26%20PERFORMANCE%20ANALYSIS.png)

### Delivery Deep Dive

The detailed dashboard explores monthly trends, delivery status, delivery methods, regions, warehouses, product categories, occasions, delivery types, and the combined effect of lead time and distance.

![Delivery Deep Dive](./screenshot/Delivery%20Deep%20Dive.png)
