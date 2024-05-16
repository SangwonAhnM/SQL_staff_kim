-- DAY 02
-- 01 데이터 가져오기
SELECT id FROM clerk;

SELECT id, staff_nm FROM clerk;

SELECT id, staff_nm, birth_dt FROM clerk;

SELECT * FROM clerk;

--text type -> date type
/*
ALTER TABLE clerk
	ALTER COLUMN birth_dt
	TYPE date
	USING TO_DATE(birth_dt, 'YYYY.MM.DD');
*/
-- 02 데이터 정렬하기
SELECT staff_nm, dep_nm
FROM clerk
ORDER BY 1;

SELECT staff_nm, dep_nm
FROM clerk
ORDER BY 2;

SELECT * FROM clerk2;

SELECT staff_nm, dep_nm
FROM clerk2
ORDER BY 2, 1;

SELECT emp_flag, gender, staff_nm, dep_nm
FROM clerk
ORDER BY 1,2,3,4;

SELECT birth_dt, staff_nm, dep_nm
FROM clerk
ORDER BY 1;

SELECT birth_dt, staff_nm, dep_nm
FROM clerk
ORDER BY 1 DESC;

SELECT emp_flag, gender, staff_nm
FROM clerk
ORDER BY 1 DESC, 2;

--실습
SELECT * FROM perf;

--text to numeric
/*
ALTER TABLE perf
	ALTER COLUMN sales_amt
	TYPE NUMERIC
	USING (REPLACE(sales_amt, ',', '')::NUMERIC);
*/
--금액 같은 것은 계산을 위해 numeric으로 바꾸는 것이 좋음.

--ALTER TABLE perf
--ALTER COLUMN cust_birth
--TYPE date
--USING TO_DATE(cust_birth, 'YYYY.MM.DD');

SELECT * FROM perf;

SELECT cust_id, cust_birth, visit_cnt
FROM perf
ORDER BY 2;
--전반적으로 연령이 높을수록 백화점 방문횟수가 많음.

SELECT cust_id, visit_cnt, sales_amt
FROM perf
ORDER BY 2 DESC;
--방문횟수가 높을수록 구입금액이 높음.
--최대한 많이 방문하는 마케팅 캠페인이 수익과 직결됨

--DAY 03
--01 SELECT문에서 많이 사용되는 키워드
SELECT * FROM emp;

SELECT DISTINCT position 
FROM emp;

SELECT DISTINCT position, grade
FROM emp;

SELECT id AS clerk_id, grade AS perf
FROM emp;

--실습
SELECT * FROM emp;

SELECT DISTINCT manager_id
FROM emp;

SELECT COUNT(DISTINCT manager_id) "cnt"
FROM emp;

SELECT COUNT(DISTINCT manager_id) cnt
FROM emp;

--DAY 04
--01 WHERE 조건절
SELECT * FROM ins_info;

--UPDATE ins_info
--SET cncl_dt = NULL
--WHERE cncl_dt = '?';

--ALTER TABLE ins_info
	--ALTER COLUMN cnrt_dt 
	--TYPE date
	--USING TO_DATE(cnrt_dt, 'YYYY.MM.DD'),
	--ALTER COLUMN cncl_dt
	--TYPE date
	--USING TO_DATE(cncl_dt, 'YYYY.MM.DD'),
	--ALTER COLUMN cnrt_amt
	--TYPE NUMERIC
	--USING (REPLACE(cnrt_amt, ',', '')::NUMERIC);

SELECT * FROM ins_info;

SELECT id, cnrt_no, cnrt_amt
FROM ins_info
WHERE cnrt_amt >= 1000000;

SELECT id, cnrt_dt, prdt_nm
FROM ins_info
WHERE prdt_nm = '다이렉트자동차보험'
ORDER BY 1;

SELECT id, cnrt_dt, prdt_nm
FROM ins_info
WHERE cnrt_dt >= '20130416'
ORDER BY 1;

SELECT * FROM purchase_tran;

--ALTER TABLE purchase_tran
	--ALTER COLUMN purchase_amt
	--TYPE NUMERIC
	--USING (REPLACE(purchase_amt, ',', '')::NUMERIC),
	--ALTER COLUMN last_amt
	--TYPE NUMERIC
	--USING (REPLACE(last_amt, ',', '')::NUMERIC);

SELECT * FROM purchase_tran;

SELECT id, purchase_amt
FROM purchase_tran
WHERE purchase_amt >= 1000000;

SELECT id, last_amt
FROM purchase_tran
WHERE last_amt >= 1000000 AND last_amt <= 50000000;

SELECT id, last_amt
FROM purchase_tran
WHERE last_amt BETWEEN 1000000 AND 50000000;

SELECT id, last_amt
FROM purchase_tran
WHERE numrange(1000000, 50000000, '[]') @> last_amt;
--numrange(1000000, 50000000, '[]') creates a numeric range from 1,000,000 to 50,000,000, where '[]' indicates that the range is inclusive of both ends.
--The @> operator checks if the last_amt falls within the specified range.

SELECT id, purchase_cnt, last_cnt
FROM purchase_tran
WHERE purchase_cnt > last_cnt
ORDER BY 1;

SELECT id, purchase_amt*0.1 AS income_amt
FROM purchase_tran;

SELECT id, purchase_amt/purchase_cnt AS ticket_size
FROM purchase_tran;

SELECT * FROM ins_info;

SELECT id, cnrt_no, cnrt_amt
FROM ins_info
WHERE cncl_dt IS NULL;

SELECT id, cnrt_no, cnrt_amt
FROM ins_info
WHERE cncl_dt IS NOT NULL;

--실습
SELECT * FROM card_tran_201311;

--ALTER TABLE card_tran_201311
	--ALTER COLUMN pif_amt
	--TYPE NUMERIC
	--USING (REPLACE(pif_amt, ',', '')::NUMERIC),
	--ALTER COLUMN inst_amt
	--TYPE NUMERIC
	--USING (REPLACE(inst_amt, ',', '')::NUMERIC),
	--ALTER COLUMN ovrs_amt
	--TYPE NUMERIC
	--USING (REPLACE(ovrs_amt, ',', '')::NUMERIC),
	--ALTER COLUMN cash_amt
	--TYPE NUMERIC
	--USING (REPLACE(cash_amt, ',', '')::NUMERIC);

SELECT * FROM card_tran_201311;

SELECT cmf, party_nm,
	(COALESCE(pif_amt,0) + COALESCE(inst_amt,0) + COALESCE(ovrs_amt,0) + COALESCE(cash_amt,0))
	AS tot_amt
FROM card_tran_201311
ORDER BY 3 DESC;

SELECT cmf, party_nm, inst_amt
FROM card_tran_201311
WHERE inst_amt IS NOT NULL;

SELECT cmf, party_nm, inst_amt
FROM card_tran_201311
WHERE inst_amt > 0;

SELECT cmf, party_nm, seg, pif_amt, pif_amt*0.1 AS reward_amt
FROM card_tran_201311
WHERE seg = 'PB'
ORDER BY 4 DESC;

--DAY 05
--01 AND, OR
SELECT * FROM brnch_info;

--ALTER TABLE brnch_info
	--ALTER COLUMN open_dt 
	--TYPE date
	--USING TO_DATE(open_dt, 'YYYY.MM.DD'),
	--ALTER COLUMN close_dt
	--TYPE date
	--USING TO_DATE(close_dt, 'YYYY.MM.DD');

SELECT * FROM brnch_info;

SELECT brnch_no, brnch_nm, brnch_num, brnch_perf
FROM brnch_info
WHERE brnch_num >= 10 AND brnch_perf = 'C';

SELECT brnch_no, brnch_nm, brnch_num, brnch_perf
FROM brnch_info
WHERE brnch_num >= 10
	AND brnch_perf = 'C'
	AND close_dt IS NOT NULL;

SELECT brnch_no, brnch_nm, brnch_num, brnch_perf
FROM brnch_info
WHERE brnch_num >= 10 OR brnch_perf = 'A';

SELECT brnch_no, brnch_nm, close_dt, brnch_num, brnch_perf
FROM brnch_info
WHERE brnch_num >= 10
	OR brnch_perf = 'A'
	OR close_dt IS NOT NULL;

--IN, NOT IN
SELECT brnch_no, brnch_nm, brnch_num, brnch_perf
FROM brnch_info
WHERE brnch_num IN (8,10)
	AND brnch_perf IN ('A', 'B');

SELECT brnch_no, brnch_nm, open_dt, close_dt, brnch_perf
FROM brnch_info
WHERE (close_dt IS NOT NULL OR open_dt < '20000101')
	AND brnch_perf NOT IN ('A');

--실습
SELECT * FROM perf_mast_201312;

--ALTER TABLE card_tran_201311
	--ALTER COLUMN tot_amt_1
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_1, ',', '')::NUMERIC),
	--ALTER COLUMN tot_amt_2
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_2, ',', '')::NUMERIC),
	--ALTER COLUMN tot_amt_3
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_3, ',', '')::NUMERIC);

SELECT * FROM perf_mast_201312;

SELECT *
FROM perf_mast_201312
WHERE COALESCE(tot_amt_1,0) <= 10000
	AND COALESCE(tot_amt_2,0) <= 10000
	AND COALESCE(tot_amt_3,0) <= 10000;

SELECT *
FROM perf_mast_201312
WHERE COALESCE(tot_amt_1,0) <= 10000
	AND COALESCE(tot_amt_2,0) <= 10000
	AND COALESCE(tot_amt_3,0) <= 10000
	AND seg IN ('PB');

SELECT *
FROM perf_mast_201312
WHERE COALESCE(tot_amt_1,0) + COALESCE(tot_amt_2,0) + COALESCE(tot_amt_3,0) >= 7000
  AND COALESCE(tot_amt_1,0) < COALESCE(tot_amt_2,0)
  AND COALESCE(tot_amt_2,0) < COALESCE(tot_amt_3,0);

--DAY 06
--01 텍스트 마이닝
SELECT * FROM customers_cust_info;

SELECT *
FROM customers_cust_info
WHERE city LIKE 'BER%';

SELECT *
FROM customers_cust_info
WHERE country LIKE '%NY';

SELECT *
FROM customers_cust_info
WHERE city LIKE '%ES%';

SELECT *
FROM customers_cust_info
WHERE country LIKE 'KORE_';

SELECT *
FROM customers_cust_info
WHERE name LIKE '_AM';

SELECT * 
FROM customers_cust_info
WHERE city LIKE 'B%N';

SELECT * FROM customers_cust_info;

SELECT id, name, city, country,
	city||'('||country ||')' AS addr
FROM customers_cust_info;

SELECT id, name, city, country,
	city||'('||TRIM (country)||')' AS addr
FROM customers_cust_info;

--실습
SELECT * FROM cust_perf;

--ALTER TABLE cust_perf
	--ALTER COLUMN tot_amt_1
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_1, ',', '')::NUMERIC),
	--ALTER COLUMN tot_amt_2
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_2, ',', '')::NUMERIC),
	--ALTER COLUMN tot_amt_3
	--TYPE NUMERIC
	--USING (REPLACE(tot_amt_3, ',', '')::NUMERIC);

SELECT * FROM cust_perf;

SELECT * 
FROM cust_perf
WHERE tot_amt_1 > 3000000
	AND tot_amt_2 > 3000000
	AND tot_amt_3 > 3000000
	AND city LIKE '%ES%';

SELECT 'Dear '||TRIM(name)||', Your segment is '||TRIM(seg)||' in our company.' 
	AS dm_de
FROM cust_perf
WHERE tot_amt_1 > 3000000
	AND tot_amt_2 > 3000000
	AND tot_amt_3 > 3000000
	AND city LIKE '%ES%';

--DAY 07
--문자/숫자/날짜 함수
SELECT * FROM vendor_info;

SELECT id, name, LOWER(name) AS name_small, country 
FROM vendor_info;

SELECT id, name, UPPER(name) AS name_cap, country
FROM vendor_info;

SELECT id, name, LENGTH(name) AS name_cnt
FROM vendor_info;

SELECT id, name, SUBSTR(name, 2, 3) AS name_str
FROM vendor_info;

SELECT * FROM prod_sales_prod_sell;

SELECT prod_id, total_sales,
	ROUND(total_sales,1) AS sales_rev
FROM prod_sales_prod_sell;

SELECT prod_id, total_sales,
	ROUND(total_sales,0) AS sales_rev
FROM prod_sales_prod_sell;

SELECT prod_id, total_sales,
	ROUND(total_sales,-1) AS sales_rev
FROM prod_sales_prod_sell;

SELECT prod_id, total_sales, sales_num,
	MOD(total_sales, sales_num) AS sales_balance
FROM prod_sales_prod_sell;

SELECT prod_id econ_income,
	ABS(econ_income) AS prft
FROM prod_sales_prod_sell;

SELECT * FROM clerk;

--SELECT id, birth_dt,
	--ADD_MONTHS(birth_dt,1) AS birth_p1
--FROM clerk;

SELECT birth_dt,
	(birth_dt + INTERVAL '1 month') AS birth_p1
FROM clerk;

--실습
SELECT * FROM cust_info;

--SELECT residence_id,
	--SUBSTR(residence_id, 7, 1) AS gender
--FROM cust_info;
	
--SUBSTR in postgreSQL doesn't support bigint type.
--so change to text.
SELECT residence_id,
       SUBSTR(residence_id::text, 7, 1) AS gender
FROM cust_info;

--PostgreSQL에서 주민번호 7번째 문자가 1이면 1로, 2면 2로 gender 변수를 만드는 방법
SELECT residence_id,
	CASE SUBSTR(residence_id::text, 7, 1)
			WHEN '1' THEN 'male'
			WHEN '2' THEN 'female'
			ELSE 'Other'
	END AS gender
FROM cust_info;

--00년대 이후 출생도 포함한다면...
SELECT residence_id, 
	CASE
		WHEN SUBSTR(residence_id::text, 7, 1) IN ('1', '3') THEN 'male'
		WHEN SUBSTR(residence_id::text, 7, 1) IN ('2', '4') THEN 'female'
		ELSE 'Other'
	END AS gender
FROM cust_info; 

--or
SELECT residence_id,
      CASE SUBSTR(residence_id::text, 7, 1)
          WHEN '1' THEN 'male'
          WHEN '2' THEN 'female'
          WHEN '3' THEN 'male'
          WHEN '4' THEN 'female'
          ELSE 'Other'
      END AS gender
FROM cust_info;

SELECT TRIM(last_nm)||', '||TRIM(first_nm) AS full_nm
FROM cust_info;

SELECT residence_id, ROUND(annl_perf,1) AS new_annl_perf
FROM cust_info;

--DAY 08
--01 숫자 데이터 요약하기
SELECT * FROM stud_score;

SELECT COUNT(*) AS cnt
FROM stud_score;

SELECT COUNT(music_score) AS music_cnt
FROM stud_score;

SELECT COUNT(DISTINCT eng_score) AS eng_cnt
FROM stud_score;

SELECT SUM(math_score) AS math_total
FROM stud_score;

SELECT AVG(music_score) AS music_avg
FROM stud_score;

SELECT AVG(COALESCE(music_score, 0)) AS music_avg
FROM stud_score;

SELECT MAX(math_score) AS max_score,
	MIN(math_score) AS min_score
FROM stud_score;

SELECT * FROM staff_sal;

--ALTER TABLE staff_sal
	--ALTER COLUMN current_sal
	--TYPE NUMERIC
	--USING (REPLACE(current_sal, ',', '')::NUMERIC);

SELECT id, job, current_sal,
	CASE 
		WHEN job = 'CLERK' THEN current_sal * 1.07
		WHEN job = 'OFFICER' THEN current_sal * 1.05
		WHEN job = 'MANAGER' THEN current_sal * 1.03
	END AS next_sal
FROM staff_sal;

SELECT id, job, current_sal,
	CASE
		WHEN job = 'CLERK' AND eng_score >= 80
			THEN current_sal * 1.07
		WHEN job = 'OFFICER' AND eng_score >= 80
			THEN current_sal * 1.05
		WHEN job = 'MANAGER' AND eng_score >= 80
			THEN current_sal * 1.03
		WHEN job = 'CLERK' AND eng_score < 80
			THEN current_sal * 1.06
		WHEN job = 'OFFICER' AND eng_score < 80
			THEN current_sal * 1.04
		WHEN job = 'MANAGER' AND eng_score < 80
			THEN current_sal * 1.02
		ELSE current_sal
	END AS next_sal
FROM staff_sal;

SELECT 
	(SUM(CASE 
			WHEN job = 'CLERK' AND eng_score >= 80
				THEN current_sal * 1.07
			WHEN job = 'OFFICER' AND eng_score >= 80
				THEN current_sal * 1.05
			WHEN job = 'MANAGER' AND eng_score >= 80
				THEN current_sal * 1.03
			WHEN job = 'CLERK' AND eng_score < 80
				THEN current_sal * 1.06
			WHEN job = 'OFFICER' AND eng_score < 80
				THEN current_sal * 1.04
			WHEN job = 'MANAGER' AND eng_score < 80
				THEN current_sal * 1.02
			ELSE current_sal
		END) - SUM(current_sal)) AS add_budget
FROM staff_sal;

--PostgreSQL doesn't support DECODE function. just use CASE WHEN
--SELECT id, job, current_sal
	--DECODE(job, 'CLERK', current_sal*1.07,
				--'OFFICER', current_sal*1.05,
				--'MANAGER', current_sal*1.03, current_sal) next_sal
--FROM staff_sal;

--실습
SELECT * FROM casa_201312;

--ALTER TABLE casa_201312
	--ALTER COLUMN balance_201311
	--TYPE NUMERIC
	--USING (REPLACE(balance_201311, ',', '')::NUMERIC),
	--ALTER COLUMN balance_201312
	--TYPE NUMERIC
	--USING (REPLACE(balance_201312, ',', '')::NUMERIC);

SELECT * FROM casa_201312;

--수신: 금융기관이 거래 관계에 있는 다른 금융기관이나 고객으로부터 받는 신용
--여기서는 고객이 금융기관에 예치한 돈의 규모를 말함

--01
/* offer_accept라는 새로운 열 이름 만들어서
오퍼를 제공해야 할 고객은 1, 그 외 고객은 0이라고 표시한 후
캠페인 성공 고객 확인하기.
- 오퍼: 12월 수신잔액이 11월보다 10퍼 증가 시 */
SELECT cust_id, cust_seg, balance_201311, balance_201312,
	CASE
		WHEN balance_201311*1.10 < balance_201312
			THEN 1
		ELSE 0
	END	AS offer_accept
FROM casa_201312;

--분석결과: 캠페인 성공 고객(오퍼를 제공해야할 고객)은 총 5명

--02
-- 이 캠페인에 대한 반응률 확인하기
-- 반응률(Response rate): 총 캠페인 시행 대상 중에 성공한 고객 수가 얼마나 되는지 알아보는 개념
-- 리드 수: 총 캠페인 시행 대상

SELECT COUNT(cust_id) AS lead_cnt,
	SUM(CASE
			WHEN balance_201311*1.10 < balance_201312
				THEN 1
			ELSE 0
		END) AS offer_accept,
	(SUM(CASE
			WHEN balance_201311*1.10 < balance_201312
				THEN 1
			ELSE 0
		END)*100 / COUNT(cust_id)) AS res_rate
FROM casa_201312;

--how to modify the res_rate calculation to ensure it returns results as numeric
/*
SELECT 
  COUNT(cust_id) AS lead_cnt,
  SUM(CASE
        WHEN balance_201311 * 1.10 < balance_201312
        THEN 1
        ELSE 0
      END) AS offer_accept,
  (SUM(CASE
          WHEN balance_201311 * 1.10 < balance_201312
          THEN 1
          ELSE 0
       END) * 100.0 / COUNT(cust_id)) AS res_rate
FROM casa_201312;
*/

/*
SELECT 
  COUNT(cust_id) AS lead_cnt,
  SUM(CASE
        WHEN balance_201311 * 1.10 < balance_201312
        THEN 1
        ELSE 0
      END) AS offer_accept,
  (SUM(CASE
          WHEN balance_201311 * 1.10 < balance_201312
          THEN 1
          ELSE 0
       END) * 100.0 / COUNT(cust_id))::numeric(5,2) AS res_rate
FROM casa_201312;
*/

--아래 res_rate가 0이 나오는 이유:
--정수 / 정수 = 정수로 소수점은 잘라내기 때문.
--따라서 먼저 100을 곱한 뒤 나눠야 함.
/*
SELECT COUNT(cust_id) AS lead_cnt,
	SUM(CASE
			WHEN balance_201311*1.10 < balance_201312
				THEN 1
			ELSE 0
		END) AS offer_accept,
	(SUM(CASE
			WHEN balance_201311*1.10 < balance_201312
				THEN 1
			ELSE 0
		END) / COUNT(cust_id) * 100) AS res_rate
FROM casa_201312;
*/

--분석결과: 마케팅 캠페인 리드 수는 9먕, 성공 고객은 5명, 반응률은 55%

--03
--캠페인 성과 측정하기: ROI(Return On Investment) 개념 사용
--ROI는 수익과 비용이라는 두 가지 요소로 구성됨. (수익 / 비용)
--일년 평균이익이 0.9%이고, 11월 대비 12월 증가 잔액이 1년동안 지속된다고 가정하면 수익은 어떻게 되는가?
SELECT SUM(balance_201311) AS bal_1311,
	SUM(balance_201312) AS bal_1312,
	SUM(balance_201312)-SUM(balance_201311) AS inc_bal,
	(SUM(balance_201312)-SUM(balance_201311))*0.009 AS rev
FROM casa_201312;

--분석결과: 캠페인 수익 30713원, 총 증가한 잔액은 3412510원

--04
--캠페인 비용 구하기
--LMS비용과 오퍼비용
--LMS cost는 건당 30원, segment별 쿠폰 지급됨. diamond = 5000, gold = 3000, silver=2000.
SELECT
	COUNT(cust_id)*30 AS lms_cost,
	SUM(CASE
			WHEN balance_201311*1.10 < balance_201312
			AND cust_seg = 'SILVER'
				THEN 2000
			WHEN balance_201311*1.10 < balance_201312
			AND cust_seg = 'GOLD'
				THEN 3000
			WHEN balance_201311*1.10 < balance_201312
			AND cust_seg = 'DIAMOND'
				THEN 5000
			ELSE 0
		END) AS offer_cost
FROM casa_201312;

--분석결과: LMS 비용은 270원, 오퍼 제공 비용은 14000원, 총 비용은 14270원
--수익은 30713원으로 결국 ROI는 약 2.2
--ROI > 1 이면 비용 대비 수익이 더 많다는 의미, ROI < 1 이면 비용 대비 수익이 적다는 의미임
--따라서 이 캠페인은 비용 대비 수익이 더 많다고 결론 지을 수 있음

--DAY 09
SELECT annl_rev FROM ppc_201312;
/*
ALTER TABLE ppc_201312
	ALTER COLUMN annl_rev
	TYPE NUMERIC
	USING (REPLACE(annl_rev, ',', '')::NUMERIC);
*/
SELECT * FROM ppc_201312;

SELECT seg, AVG(annl_rev) AS annl_rev 
FROM ppc_201312
GROUP BY seg;

SELECT seg, COUNT(*) AS cnt,
	SUM(card_flg) AS card_flg
FROM ppc_201312
GROUP BY 1;

SELECT card_flg, loan_flg, COUNT(*) AS cnt
FROM ppc_201312
GROUP BY 1,2;

--02
SELECT * FROM prod_sales_cust_buy;
/*
ALTER TABLE prod_sales_cust_buy
	ALTER COLUMN sales_amt
	TYPE NUMERIC
	USING (REPLACE(sales_amt, ',', '')::NUMERIC);
*/
SELECT cust_nm, COUNT(*) AS cnt
FROM prod_sales_cust_buy
GROUP BY 1
HAVING COUNT(*) > 1;

SELECT cust_nm, SUM(sales_amt) AS sales_amt
FROM prod_sales_cust_buy
GROUP BY 1
HAVING SUM(sales_amt) >= 70000;

SELECT cust_nm, AVG(sales_amt) AS sales_amt
FROM prod_sales_cust_buy
GROUP BY 1
HAVING AVG(sales_amt) >= 70000;

--실습
SELECT * FROM ppc_mast_201312;
/*
ALTER TABLE ppc_mast_201312
	ALTER COLUMN balance_amt
	TYPE NUMERIC
	USING (REPLACE(balance_amt, ',', '')::NUMERIC);
*/
--01
--자산과 부채 구하기
--대차대조표(B/S: Balance Sheet): 일정 시점에서 기업의 재정 상태를 나타낸 표. 자산, 부채, 자본 항목으로 나뉨.
--자산: 기업이 미래의 경제적 효용을 제공할 때
--자산 구입의 2가지 방법:
--1. 부채: 남에게 빌려서 자신을 구입
--2. 자본: 자기 돈으로 자산을 구입
--금융기관에서 자산은 여신. 즉 대출해준 돈 / 부채는 수신, 즉 고객이 예치해둔 돈임
SELECT
	CASE
		WHEN acct_cd IN (100, 110, 120, 130, 140)
			THEN 'liability'
		WHEN acct_cd IN (300, 310, 320, 330, 340)
			THEN 'asset'
	END AS balance_sheet,
	SUM(balance_amt) AS total_balance_amt
FROM ppc_mast_201312
GROUP BY 1
ORDER BY 1;

--02
--현재 고객들의 ppc 계산하기
--Product per Customer(PPC): 고객당 가입상품
--PPC가 많을수록 고객과의 관계를 심화할 수 있고 더 많은 세일즈 기회를 찾을 수 있음
SELECT ssn, COUNT(*) AS ppc
FROM ppc_mast_201312
GROUP BY 1
ORDER BY 1;

--03
--PPC가 3개 이상인 고객들 리스트 추출
SELECT ssn, COUNT(*) AS ppc
FROM ppc_mast_201312
GROUP BY 1
HAVING COUNT(*) >=3 
ORDER BY 1;

--04
SELECT ssn, COUNT(*) AS ppc, SUM(prft) AS prft
FROM ppc_mast_201312
GROUP BY 1
ORDER BY 1;

--DAY 10
SELECT * FROM addr;
SELECT * FROM mobile;

SELECT t1.*, t2.mobile_no
FROM addr t1, mobile t2
WHERE t1.cust_id = t2.cust_id;
SELECT * FROM customers_cust_ledger;
SELECT * FROM orders;

SELECT tmp1.cust_id, tmp1.cust_nm, tmp2.order_id
FROM customers_cust_ledger AS tmp1, orders AS tmp2
WHERE tmp1.cust_id = tmp2.cust_id;

SELECT tmp1.cust_id, tmp1.cust_nm, tmp2.order_id
FROM customers_cust_ledger tmp1 INNER JOIN orders tmp2
ON tmp1.cust_id = tmp2.cust_id;

SELECT * FROM employee;

SELECT tmp1.cust_id, tmp1.cust_nm, tmp2.order_id, tmp2.emp_id, tmp3.nm
FROM customers_cust_ledger tmp1, orders tmp2, employee tmp3
WHERE tmp1.cust_id = tmp2.cust_id 
	AND tmp2.emp_id = tmp3.emp_id
ORDER BY 3;

SELECT t1.cust_id, t1.cust_nm, t2.order_id
FROM customers_cust_ledger t1, orders t2;

SELECT t1.cust_id AS cust_id1, t1.home_addr1, t1.home_addr2,
	t2.cust_id AS cust_id2, t2.mobile_no
FROM addr1 AS t1
LEFT JOIN mobile1 AS t2
ON t1.cust_id = t2.cust_id
ORDER BY 3;

SELECT t1.cust_id cust_id1, t1.home_addr1, t1.home_addr2,
	t2.cust_id cust_id2, t2.mobile_no
FROM addr1 t1
RIGHT JOIN mobile1 t2
ON t1.cust_id = t2.cust_id;

SELECT t1.cust_id cust_id1, t1.home_addr1, t1.home_addr2,
	t2.cust_id cust_id2, t2.mobile_no
FROM addr1 t1
FULL JOIN mobile1 t2
ON t1.cust_id = t2.cust_id;

--Example 01.
SELECT * FROM customers_cust_ledger;
SELECT * FROM orders;
SELECT t1.cust_id, t1.cust_nm, t2.order_id,
	CASE
		WHEN t2.order_id IS NOT NULL THEN 1
		ELSE 0
	END AS order_flg
FROM customers_cust_ledger t1
LEFT JOIN orders t2
ON t1.cust_id = t2.cust_id
ORDER BY 1;

--Example 02.
SELECT 
	CASE
		WHEN t2.cust_id IS NOT NULL THEN 1
		ELSE 0
	END order_flg,
	COUNT(*) cnt
FROM customers_cust_ledger t1
LEFT JOIN orders t2
ON t1.cust_id = t2.cust_id
GROUP BY 1;

--Example 03.
SELECT * FROM employee;
SELECT * FROM orders;

SELECT t1.emp_id, t1.nm, t2.order_id,
	CASE
		WHEN t2.order_id IS NOT NULL THEN 1
		ELSE 0
	END sales_flg
FROM employee t1
	LEFT JOIN orders t2 ON t2.emp_id = t1.emp_id
ORDER BY 1;

--Example 04.
SELECT t1.emp_id, t1.nm, t2.order_id, t3.cust_id, t3.cust_nm
FROM employee t1
	LEFT JOIN orders t2
		ON t1.emp_id = t2.emp_id
	LEFT JOIN customers_cust_ledger t3
		ON t3.cust_id = t2.cust_id
ORDER BY 1;

--This is Outdated Join Syntax:
--You are using an old and non-standard join syntax (*=), which is an old SQL Server style join syntax for a left outer join. PostgreSQL does not support this syntax.
--You should use the ANSI SQL LEFT JOIN ... ON syntax for clarity and compatibility.
/* 
SELECT tmp1.emp_id, tmp1.nm, tmp2.order_id,
	CASE
		WHEN tmp2.cust_id IS NOT NULL THEN 1
		ELSE 0
	END AS sales_flg
FROM employee tmp1, orders tmp2
WHERE tmp1.emd_id *= tmp2.emp_id
ORDER BY 1;
*/

--Example 01.
SELECT cust_nm nm
FROM customers_cust_ledger
UNION
SELECT nm FROM employee
ORDER BY 1;

--Example 02.
SELECT cust_nm FROM customers_cust_ledger
UNION
SELECT nm FROM employee
ORDER BY 1;
--결과 열 header가 nm에서 cust_nm으로 변경됨.
--즉, 결과의 열 header는 첫 번째 문장의 열 이름으로 출력됨.

--Example 03
SELECT cust_id FROM customers_cust_ledger
UNION
SELECT cust_id FROM orders
ORDER BY 1;

--Example 01.
SELECT cust_id FROM customers_cust_ledger
UNION ALL
SELECT cust_id FROM orders
ORDER BY 1;

--Exercise
SELECT * FROM cust_party;
--SELECT * FROM rcpt_acct;
/*
ALTER TABLE rcpt_acct
	ALTER COLUMN rcpt_amt
	TYPE NUMERIC
	USING(REPLACE(rcpt_amt, ',', '')::NUMERIC);
*/

--01
--수신고객에 대한 정보 변경으로 안내문자 전송해야 함
--LEFT JOIN을 사용하여 현재 살아있는 계좌를 가지고 있는 고객들 및 휴대전화를 찾아보고
--살아있는 계좌 개수를 기준으로 오름차순 정렬

SELECT t1.ssn, t1.mobile_no, t2.cnt
FROM cust_party t1
	LEFT JOIN (SELECT ssn, COUNT(*) cnt FROM rcpt_acct
				WHERE cncl_dt IS NULL
				GROUP BY 1) t2
		ON t1.ssn = t2.ssn
WHERE cnt >= 1
ORDER BY 3;

--02
SELECT t1.ssn, t1.mobile_no, t2.acct_no
FROM cust_party t1
LEFT JOIN rcpt_acct t2
	ON t2.ssn = t1.ssn;
--한 고객이 두 개의 계좌를 가지고 있을 경우 동일한 주민등록번호와 휴대폰 번호 출력됨
--중복을 제거할 순 있지만, 문장이 복잡해지는 문제점이 발생함
--그러므로 테이블끼리 조인할 때는 가장 간단한 형태로 조인해야 함.
--SQL문장이 단순해질 뿐만 아니라 DBMS 데이터 처리 시간도 단축할 수 있어서 효율적이기 때문.

--03
--현재 살아있는 계좌 수가 2개 이상이고, 모든 수신잔액의 총합이 50만원 이상인 고객
--주번, 이름, 번호, 계좌 수, 수신잔액 총합 주번 기준으로 오름차순 정렬.
SELECT t1.ssn, t1.mobile_no, t2.cnt, t2.rcpt_amt
FROM cust_party t1
	LEFT JOIN (SELECT ssn, COUNT(*) cnt, SUM(rcpt_amt) rcpt_amt FROM rcpt_acct
				WHERE cncl_dt IS NULL
				GROUP BY 1) t2
	
		ON t1.ssn = t2.ssn
WHERE cnt >= 2 AND rcpt_amt >= 500000
ORDER BY 1;

--DAY 11
SELECT * FROM card_acct;

--Example 01.
