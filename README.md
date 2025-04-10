\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage{hyperref}
\usepackage{xcolor}
\definecolor{blue}{RGB}{0,82,155}

\begin{document}

\title{\color{blue}\textbf{Data Warehouse Implementation with Medallion Architecture}}
\author{Luke Yeo}

\section*{Overview}
This project implements a \textbf{modern data warehouse} using SQL Server following the \textbf{Medallion Architecture} (Bronze-Silver-Gold layers). It demonstrates end-to-end ETL pipelines, data modeling with star schema, and SQL-based analytics for sales data from ERP \& CRM systems.

\subsection*{Key Features}
\begin{itemize}
    \item \textbf{3-Layer Architecture}: Raw ingestion (Bronze) → Cleaned/standardized (Silver) → Business-ready star schema (Gold)
    \item \textbf{ETL Best Practices}: Bulk loading, error handling, stored procedures, and performance timing
    \item \textbf{Data Quality Checks}: Null/duplicate detection, value standardization, business rule validation
    \item \textbf{Dimensional Modeling}: Implemented fact \& dimension tables for analytics
\end{itemize}

\section*{Credits \& Attribution}
\begin{itemize}
    \item \textbf{Original Project Concept}: \href{https://datawithbaraa.substack.com/p/build-a-data-warehouse-from-scratch}{Data With Baraa} by Baraa Khatib Salkini
    \item \textbf{Notion Plan Reference}: \href{https://thankful-pangolin-2ca.notion.site/SQL-Data-Warehouse-Project-16ed041640ef80489667cfe2f380b269}{SQL Data Warehouse Project} (Not owned by me)
    \item \textbf{Implementation Guidance}: Followed walkthrough by Luke Yeo (MIT License)
\end{itemize}

\section*{Technical Highlights}
\subsection*{Data Architecture}
\begin{itemize}
    \item \textbf{Bronze Layer}: Raw CSV ingestion with source-system naming conventions
    \item \textbf{Silver Layer}: Data cleansing, standardization, and integrity checks
    \item \textbf{Gold Layer}: Star schema with \texttt{dim\_customer}, \texttt{dim\_product}, and \texttt{fact\_sales} views
\end{itemize}

\subsection*{What I Learned}
As a fresh graduate, this project helped me develop:
\begin{itemize}
    \item \textbf{ETL Pipeline Design}: From extraction (bulk inserts) to transformation (data quality rules)
    \item \textbf{SQL Optimization}: Stored procedures with error handling and timing metrics
    \item \textbf{Data Modeling}: Translating business requirements into dimensional models
    \item \textbf{Documentation}: Clear schema designs and naming conventions
\end{itemize}

\section*{Project Structure}
\begin{verbatim}
DataWarehouse/
├── Bronze/           # Raw data tables (crm_cust_info, erp_loc_a101, etc.)
├── Silver/           # Cleaned tables with metadata columns
├── Gold/             # Star schema views for analytics
├── Scripts/          # SQL scripts for ETL processes
└── Documentation/    # Architecture diagrams
\end{verbatim}

\section*{How to Reproduce}
\begin{enumerate}
    \item Download datasets from \href{https://datawithbaraa.substack.com}{Data With Baraa}
    \item Execute SQL scripts in order: Bronze → Silver → Gold
    \item Connect Power BI to Gold layer views for analytics
\end{enumerate}

\section*{Job Hunting Value}
This project showcases my ability to:
\begin{itemize}
    \item \textbf{Implement industry-standard architectures} (Medallion)
    \item \textbf{Solve real data quality issues} (e.g., null handling, value standardization)
    \item \textbf{Bridge technical and business needs} via dimensional modeling
    \item \textbf{Document and communicate} complex data workflows
\end{itemize}

\begin{center}
    \textit{Note: This is my implementation of the original project concept.}\\
    \textbf{Connect with me on LinkedIn:} \href{https://linkedin.com/in/yourprofile}{yourprofile}
\end{center}

\end{document}
