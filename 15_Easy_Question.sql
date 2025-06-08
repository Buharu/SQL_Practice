
----------------------------------------------------------------------- EASY QUERIES -----------------------------------------------------------------------
/* 15. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton' */

select
	first_name
    , last_name
    , allergies
from patients
where city = 'Hamilton'
and	allergies is not null

/* 14. write a query to find the first name, last name and birth date of patients who has height greater than 160 and weight greater than 70 */

select
	first_name
    , last_name
    , birth_date
from patients
where height > 160
AND weight > 70

/* 13. Based on the cities that our patients live in, show unique cities that are in province_id 'NS' */

select
	distinct city
from patients
where province_id = 'NS'

/* 12. Show the patient id and the total number of admissions for patient_id 579 */

select
	patient_id
    , count(*)
from admissions
where patient_id = 579
group by patient_id

/* 11. Show all the columns from admissions where the patient was admitted and discharged on the same day */

select
	*
from admissions
where admission_date = discharge_date

/* 10. Show the total number of admissions */

select
	COUNT(*) AS total_admissions
from admissions

/* 9. Show all columns for patients who have one of te following patients_ids: 1,45, 534, 879, 1000 */

select
	*
from patients
where patient_id IN (1,45, 534, 879, 1000)

/* 8. Show the first name, last name, and height of the patient with the greates height */

select
	first_name
    , last_name
    , height
from patients
WHERE height = (select mAx(height) from	patients)

/* 7. show how many patients have a birth_date with 2010 as the birth year */

select
	COUNT(*)
FRom patients
WHERE	YEAR(birth_date) = 2010

/* 6. Show first name, last name, and the full provice name of each patient */

select
	first_name
    , last_name
    , province_name
from patients AS p
INNER JOIN province_names AS pr ON pr.province_id = p.province_id

/* 5. Show first name and last name concatinated into one column to show their full name */

select
	CONCAT(first_name, ' ', last_name) AS full_name
FROM patients

/* 4. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */

update patients
SET allergies = 'NKA' 
where allergies is null	

/* 3. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)*/

select
	first_name
    , last_name
from patients
where weight between 100 AND 120

/* 2. Show first name of patients that start with the letter 'C' */
SELECT
	first_name
from patients
WHERE first_name LIKE 'C%'

-- or
select
	first_name
from patients
where substring(first_name, 1, 1) = 'C'

/* 1. Show first name and last name of patientes who does not have allergies*/
SELECT
	first_name
    , last_name
FROM patients
WHERE allergies is NULL