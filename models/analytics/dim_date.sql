with dim_date as (
  SELECT
    *
  FROM UNNEST(GENERATE_DATE_ARRAY('2010-01-01', '2030-12-31', INTERVAL 1 DAY)) as _date
    )


SELECT
  FORMAT_DATE('%F', _date) as date,
  date_trunc(_date, YEAR) AS year,
  extract(YEAR from _date) as year_number,
  date_trunc(_date, MONTH) AS month,
  extract(MONTH from _date) as month_number,
  EXTRACT(DAY FROM _date) AS day,
  FORMAT_DATE('%A', _date) AS day_of_week,
  left(FORMAT_DATE('%A', _date),3) as day_of_week_short,
  (CASE 
    WHEN left(FORMAT_DATE('%A', _date),3) IN ('Mon', 'Tue','Wed','Thu','Fri') THEN 'Weekday'
    WHEN left(FORMAT_DATE('%A', _date),3) IN ('Sun', 'Sat') THEN 'Weekend'
    ELSE "Error/ Invalid"
    END) AS is_weekday_or_weekend,
FROM dim_date