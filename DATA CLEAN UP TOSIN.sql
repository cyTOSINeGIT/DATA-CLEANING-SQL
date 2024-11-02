SELECT*
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT*
FROM layoffs_staging;

INSERT layoffs_staging
SELECT*
FROM layoffs;

-- To remove duplicates

SELECT*
FROM layoffs_staging;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY Company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY Company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY Company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte
WHERE row_num > 1;

SELECT*
FROM layoffs_staging
WHERE company= 'casper';


 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off`int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT*
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER() OVER(PARTITION BY Company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging;

SELECT*
FROM layoffs_staging2
WHERE row_num >1;

SET SQL_SAFE_UPDATES = 0;



DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT*
FROM layoffs_staging2
WHERE row_num > 1;

SELECT*
FROM layoffs_staging2;

-- STANDARDIZING Data

SELECT DISTINCT (COMPANY)
FROM layoffs_staging2;

SELECT DISTINCT (TRIM(Company))
FROM layoffs_staging2;

SET SQL_SAFE_UPDATES = 0;

SELECT company, TRIM (Company)
FROM layoffs_staging2;
