🚀 Swiggy Business Performance Dashboard

<p align="center"> 
  <img src="https://img.shields.io/badge/Tool-Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/> 
  <img src="https://img.shields.io/badge/Database-SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white"/> 
  <img src="https://img.shields.io/badge/Platform-Microsoft%20Fabric-742774?style=for-the-badge"/> 
  <img src="https://img.shields.io/badge/Model-Star%20Schema-orange?style=for-the-badge"/> 
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge"/> 
</p>

**📊 Project Overview**

This project analyzes Swiggy’s business performance using an end-to-end data analytics approach.

The dashboard provides insights into:

-  Sales performance
- Customer ordering behavior
- Restaurant trends
- Regional performance

It enables stakeholders to make data-driven decisions through interactive visualizations.

🎯 Problem Statement

Analyze food delivery data to identify trends in revenue, customer behavior, and restaurant performance, and build a dashboard to support business decision-making.

🧮 Key Metrics
Metric	Value
Total Sales	₹5.30 Cr
Total Orders	1.97 Lakh
Avg Order Value	₹269
Avg Rating	4.3
Total Ratings Count	55.9 Lakh
🖥️ Dashboard Preview
<p align="center"> <img src="Screenshots/dashboard.png" alt="Swiggy Dashboard" width="95%"> </p>
📌 Features & Analysis
📈 Sales & Order Trends
Monthly order trends to identify peak demand
Helps understand seasonality
📅 Daily & Weekly Insights
Higher sales observed on weekends
Stable weekday ordering patterns
🍽️ Food Category Analysis
Veg vs Non-Veg distribution
Veg orders contribute ~71%
🏆 Top Restaurants
Top performers include:
KFC
McDonald's
Pizza Hut
Burger King
Domino’s
🌍 Regional Performance
State-wise sales comparison
Karnataka contributes highest revenue
🎛️ Filters & Interactivity
City
Food Type
Quarter
Restaurant Name
💡 Key Insights
Strong revenue generation of ₹5Cr+ from ~197K orders
Weekend demand is significantly higher
Veg food dominates customer preference
Top brands drive major order volume
Certain states consistently outperform others
🧱 Data Architecture
<p align="center"> <img src="Architecture/architecture.png" width="80%"> </p>
Data Model
Star Schema Implementation
Fact Table: Orders
Dimension Tables:
Date
Location
Restaurant
Dishes
🛠️ Tech Stack
Layer	Tools
Data Storage	Microsoft Fabric Lakehouse
Data Processing	SQL
Data Modeling	Star Schema
Visualization	Power BI
⚡ Enhancements Implemented
Multi-level trend analysis (Monthly, Weekly, Daily)
Interactive dashboard filters
Optimized data model using star schema
Business-focused KPI design
Clean and structured dashboard layout
🔮 Future Improvements
Add delivery performance metrics (Avg Delivery Time, On-Time %)
Analyze order cancellation trends
Create restaurant-level drill-through page
Add geo-spatial map visualization
Implement sales forecasting
Perform customer segmentation
▶️ How to Use
Download the .pbix file from the repository
Open in Power BI Desktop
Use filters and visuals to explore insights
📁 Repository Structure
Swiggy-Data-Analytics/
│
├── Dataset/
├── SQL/
├── PowerBI/
├── Screenshots/
├── Architecture/
└── README.md
🎯 Business Use Case

This dashboard helps:

Analyze sales and order trends
Identify top-performing restaurants
Understand customer behavior
Support strategic decision-making
👨‍💻 Author

Shubham Kakade
Aspiring Data Analyst | Power BI | SQL | Microsoft Fabric
