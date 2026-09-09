# 🛒 E-Commerce Performance Analytics: End-to-End Data Project

## 📌 Project Overview (نظرة عامة على المشروع)
This is an end-to-end data analysis portfolio project demonstrating the complete data lifecycle. The goal of this project is to analyze the performance of an e-commerce platform by transforming raw database tables into an interactive, modern Power BI dashboard. 

The project showcases skills in **Relational Database Modeling**, **Data Cleaning using SQL**, **DAX Formula Creation**, and **Advanced UI/UX Dashboard Design**.

---

## 🛠️ Tools & Technologies (التقنيات المستخدمة)
* **SQL:** For data cleaning, string manipulation, handling nulls, and assigning Primary/Foreign Keys.
* **Data Modeling:** Entity-Relationship Diagram (ERD) design.
* **Power BI:** Data visualization, DAX measures, and interactive reporting.
* **Design System:** "Modern & Clean" UI principles (Custom Color Palette: #F8F9FA, #0F172A, #2563EB).

---

## 🚀 Project Workflow (مراحل العمل)

### 1. Data Modeling (نمذجة البيانات)
The foundation of the project relies on a robust relational database. I designed the schema connecting `orders`, `customers`, `products`, `sellers`, `order_items`, `payments`, `shipments`, and `reviews`.
<img width="1624" height="734" alt="01_Database_ER_Diagram png" src="https://github.com/user-attachments/assets/4d99d9c8-c705-4cee-84df-3d44311af47d" />

*(Note: A detailed view of the schema is also available in `01_Database_ER_Diagram.png.PNG`)*

### 2. Data Cleaning & Transformation via SQL (تنظيف البيانات)
To ensure high data quality before visualization, several SQL operations were performed:
* **Cleaning Customers Data:** Standardized email addresses, handled missing names, and formatted phone numbers.
 <img width="851" height="286" alt="02_Cleaning_Customers_Data" src="https://github.com/user-attachments/assets/9bb0428c-e7a9-4cb0-bdb8-dd419ab9c09c" />

* **Cleaning Products & Sellers:** Handled missing product names, corrected negative quantities/prices using `ABS()`, and filtered out outliers.
  <img width="962" height="204" alt="02_Cleaning_Products_And_Sellers" src="https://github.com/user-attachments/assets/a215aa8b-0924-44fc-b943-f145085b8010" />

* **Defining Relationships:** Established data integrity by enforcing Primary Keys and Foreign Keys constraints across all tables.
  <img width="808" height="308" alt="03_Primary_Keys_Assignment" src="https://github.com/user-attachments/assets/9d440583-43a2-4673-ab45-522a0daa384e" />

  <img width="960" height="446" alt="03_Foreign_Keys_Relationships" src="https://github.com/user-attachments/assets/1578f8c8-9c3d-44e0-a23e-8cda000fb2ea" />


### 3. Cleaned Data Ready for Analysis (عينة من البيانات المنظفة)
After executing the SQL scripts, the data was perfectly structured and ready to be imported into Power BI.
<img width="1445" height="535" alt="04_Cleaned_Data_Preview" src="https://github.com/user-attachments/assets/b8fe721d-192d-444c-a385-fa1cdd2b3108" />


### 4. Data Visualization & Dashboard (تصميم لوحة التحكم)
The final deliverable is an interactive Power BI dashboard designed to provide executives with clear, actionable insights.
<img width="1347" height="767" alt="04_E-Commerce_Performance_Dashboard" src="https://github.com/user-attachments/assets/ecb26376-3ef3-4cbb-9151-a4afd6dcd23c" />


---

## 📊 Key Dashboard Features (أهم مؤشرات لوحة التحكم)
1. **Executive KPIs:** High-level metrics including Total Revenue ($403.30M), Total Orders (135K), and Average Order Value ($2.98K).
2. **Revenue by Category:** A clustered bar chart utilizing conditional formatting to highlight top-performing categories (e.g., Decor & Furniture).
3. **Hero Product Identification:** A Top 5 Products chart that clearly identifies the "Cash Cow" product driving the majority of sales.
4. **Geographic Distribution (Treemap):** Analyzed revenue by city/region using a Treemap to provide immediate visual weight to top markets (Cairo, Riyadh, Doha).
5. **Order Status Breakdown:** A customized Donut Chart categorizing revenue by order status (Completed, Shipped, Pending, Cancelled) using a logical color progression.

---

## 💡 Technical Challenges Overcome (تحديات تقنية تم حلها)
* **DAX Context Transition:** Resolved a filtering issue where date dimensions were not interacting correctly with sales logic by refactoring the `SUMX` measure and encapsulating it within a proper `CALCULATE` context.
* **Visual Workarounds:** Successfully substituted deprecated map visuals with a highly effective **Treemap** to maintain spatial and volumetric analysis of regional sales without compromising the dashboard's stability.

---
*If you find this project useful, feel free to give it a ⭐!*
