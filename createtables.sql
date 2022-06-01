CREATE TABLE reviews (
Review_ID INT PRIMARY KEY,
Rating INT,
Year_Month TEXT,
Reviewer_Location TEXT,
YYYY_MM DATE
);

CREATE TABLE park_data (
date_id DATE PRIMARY KEY,
max_temp INT,
min_temp INT,
crowd_level INT,
Year_Month TEXT
);