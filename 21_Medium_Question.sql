---------------------------------------------------------------------- MEDIUM QUERIES ----------------------------------------------------------------------


/* 21. Display the total amount of patients for each provice. Order by descending */

SELECT
	province_name
    , count(patient_id) AS total_patientes
from patients
inner join province_names ON province_names.province_id = patients.province_id
group by province_name
order by total_patientes DESC


/* 20. For each doctor, display their id, full name, and the first and last admission date they attended */

select
	doctor_id
	, CONCAT(first_name, ' ', last_name) AS full_name
    , MIN(admissions.admission_date) As first_admission_date
    , max(admissions.admission_date) As last_admission_date
from doctors
LEFT join admissions ON admissions.attending_doctor_id = doctors.doctor_id
group by first_name, last_name
order by doctor_id

/* 19. Show first name, last name and the total number of admissions attented for each doctor */

select
	first_name
    , last_name
    , count(patient_id) as total_admissions
from doctors
inner join admissions ON admissions.attending_doctor_id = doctors.doctor_id
group by first_name
    , last_name


/* 18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attenting_doctor_in is either 1, 5, or 19
2. attending_doctor_id containts a 2 and the lenght of patient_id is 3 characters.
*/

select
	patient_id
    , attending_doctor_id
    , diagnosis
from admissions
where
	(patient_id % 2 <> 0 AND attending_doctor_id in (1, 5, 19)) 
    OR (attending_doctor_id LIKE '%2%' and len(patient_id) = 3)

/* 17. Show all columns for patient_id  = 542's most recent admission_date*/

select
 *
from admissions
where patient_id = 542
order by admission_date DESC
LIMIT 1

/* 16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day.
Sort by the day with most admissions to least admissions */

select
	day(admission_date) As day_admission
    , count(*) AS num_admissions
FRom admissions
group by day_admission
ORDER BY num_admissions DESC

/* 15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'*/

select
	MAX(weight) - MIN(weight) AS weight_delta
from patients
where last_name = 'Maroni'

/* 14. show the province_id(s), sum of height;
where the total sum of its patient's height is greater than or equal to 7,000 */

select
	province_id
    , sum(height) as sum_height
from patients
group by province_id
having  sum_height >= 7000

/* 13. We want to display eac pacient's full name in a single column.
their last name in all upper letters must appers first, then first name in all lower case letters.
separate the last name and first name with a comma. order the list by first name in decending order */

select
	CONCAT(upper(last_name), ',', lower(first_name)) AS new_name_format
from patients
order by first_name desc

/* 12. Show all patient's first name, last name and birth date who were born in the 1970s decade.
sort the list starting from the earliest birth date*/

select
	first_name
    , last_name
    , birth_date
from patients
where substring(birth_date, 1,3) = '197'
order by birth_date asc

/* 11. Show all allergies ordered by popularity. Remove NULL values from query */

select
	allergies
    , Count(*) as total_diagnosis
from patients
where allergies IS NOT NULL
group by allergies
order by total_diagnosis DESC

/* 10. Show first name, last name and role of every person that is either patient or doctor.
the roles are either 'Patient' or 'Doctor' */

select
	p.first_name
    , p.last_name
	, 'Patient'
from patients as p
	UNION ALL
select
	first_name
    , last_name
    , 'Doctor'
from doctors

/* 9. Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending. */

select
	city
    , count(*) As total_patients
from patients
group by city
order by total_patients DESC, city asc

/* 8. show patient_id, diagnosis from admissions. 
Find patients admitted multiple times for the same diagnosis */

select
	a.patient_id
    , a.diagnosis
from admissions AS a
group by
	a.patient_id
    , a.diagnosis
having
	count(*) > 1

/* 7. Show first name and last name, allergies from patients which have allergies to either 'Penicillin'
or 'Morphine'. Show results ordered ascending by allergies then by first name then by last name*/

select
	first_name
    , last_name
    , allergies
from patients
where allergies IN ('Penicillin', 'Morphine')
order by allergies asc, first_name, last_name

/* 6. Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.*/

select
(
  select COUNT(*)
  from patients
  where gender = 'M'
) AS male_count
, (
  select count(*)
  from patients
  where gender = 'F'
) AS female_count

-- or
select
	SUM(gender = 'M') As male_count_v2
    , SUM(gender = 'F') AS female_count_v2
from patients

/* 5. Display every patient's first name. 
Order the list by the lenght of each name and then by alphabetically*/

select
	first_name
from patients
order by len(first_name), first_name

/* 4. show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */

select
	p.patient_id
    , p.first_name
    , p.last_name
from patients AS p
iNNER join admissions as a ON a.patient_id = p.patient_id
where a.diagnosis = 'Dementia'



/* 3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long */

select
	patient_id
    , first_name
from patients
where first_name like 'S%'
and first_name like '%s'
and len(first_name) >= 6

-- or

select
	patient_id
    , first_name
from patients
where first_name like 's_____%s'

/* 2. Show unique first names from the patients table which only occurs one in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
if only 1 person is named 'Leo' then include them in the output. */

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1

/* 1. Show unique birth years from patients and order then by ascending */

select
	distinct Year(birth_date)
from patients
order by birth_date asc