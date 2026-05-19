# 🚀 Swiggy Business Performance Dashboard
<p align="center"> 
  <img src="https://img.shields.io/badge/Tool-Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/> 
  <img src="https://img.shields.io/badge/Database-SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Platform-Microsoft%20Fabric-742774?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Model-Star%20Schema-orange?style=for-the-badge"/> 
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge"/>
</p>

**📊 Project Overview**:
An end-to-end data analytics project built to analyze Swiggy’s business performance across sales, customer behavior, and restaurant trends.

This dashboard enables data-driven decision-making by providing insights into order patterns, revenue distribution, and customer preferences.

---

**🎯 Problem Statement**

To analyze food delivery data to identify trends in revenue, customer behavior, and restaurant performance, and build a dashboard to support business decision-making.

**⏯️How to Use**
- Download the .pbix file from the repository
- Open in Power BI Desktop
- Use filters and visuals to explore insights

---

**🎯 Key Highlights:**

- ✨ Built a complete analytics pipeline using Microsoft Fabric + SQL + Power BI
- ✨ Designed a star schema data model for performance optimization
- ✨ Developed an interactive dashboard with dynamic filters
- ✨ Delivered actionable business insights from raw data

---

**🧮 Key Metrics:** 
| Metric	             | Value         |
|----------------------|---------------|
| -💰 Total Sales      |	 ₹5.30 Cr    |
| -🛒 Total Orders	   |  1.97 Lakh    |
| -📊 Avg Order Value	 |  ₹269         |
| -⭐ Avg Rating	     |  4.3          |
| -👍 Rating Count	   |  55.9 Lakh    |

---

**📌 Features and Analysis**
**📈 Sales & Order Trends**
  - Monthly trend analysis to identify peak demand periods
  - Detects seasonal fluctuations in orders
---
**📅 Daily & Weekly Insights**
  - Higher sales observed on weekends
  - Consistent weekday ordering behavior
---
**🍽️ Food Category Analysis**
  - Veg vs Non-Veg distribution
  - Veg dominates with ~71% share
---
**🏆 Top Restaurants**
Leading contributors:
  - KFC
  - McDonald's
  - Pizza Hut
  - Burger King
  - Domino’s
---
**🌍 Regional Performance**
  - Top-performing states by revenue
  - Karnataka leads overall sales
---
**🎛️ Interactive Filters**
  - City
  - Food Type
  - Quarter
  - Restaurant Name
---

**🗂️ Dataset Information and Source:**

The dataset used in this project is a transformed hybrid dataset built using publicly available Swiggy data. It has been modeled into a star schema for analytical purposes.
As real-world transactional data is not publicly available, synthetic order-level data has been generated to simulate a realistic data warehouse environment.

- https://www.kaggle.com/datasets/nikhilmaurya1324/swiggy-restaurant-data-india?resource=download&select=swiggy_all_menus_india.csv
- https://www.kaggle.com/datasets/ashishjangra27/swiggy-restaurants-dataset?utm_source=chatgpt.com&select=swiggy.csv
- https://www.kaggle.com/datasets/lokeshparab/swiggy-restraurant-and-item-full-datasets?utm_source=chatgpt.com&select=Swiggy.csv

---

**💡 Business Insights**

- ✔️ Strong demand with ~197K orders generating ₹5Cr+ revenue
- ✔️ Weekend peaks indicate leisure-driven consumption
- ✔️ Veg food preference dominates customer behavior
- ✔️ Top brands significantly influence total sales
- ✔️ Regional trends highlight high-growth markets

---

**🔹 Data Model:**

⭐ Star Schema Implementation
- Fact Table: Orders
- Dimension Tables:
  - Date
  - Location
  - Restaurant
  - Dishes

---

**🛠️ Tech Stack:**
|Layer	           | Tools                          |
|------------------|--------------------------------|
| Data Storage	   | Microsoft Fabric Lakehouse     |
| Data Processing	 | SQL                            |
| Data Modeling	   | Star Schema                    |
| Visualization	   | Power BI                       |


### To Show Date Style Codes: -
https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver17
---

**⚡ Enhancements & Customizations:**
- 📊 Multi-level trend analysis (Monthly, Weekly, Daily)
- 🎨 Custom Swiggy-themed dashboard design
- ⚙️ Optimized data model for performance
- 🎯 Business-focused KPI creation
- 🔍 Interactive filtering for better exploration
- 🎯 Business Use Case

---

This dashboard can be used by:

- 📊 Business Analysts → Identify trends & KPIs
- 📈 Managers → Track performance & revenue
- 🍽️ Operations Teams → Optimize restaurant performance
- 🎯 Strategy Teams → Make data-driven decisions

---

👨‍💻 Author

Shubham Kakade

📌 Aspiring Data Analyst | Power BI | SQL | Microsoft Fabric

---
