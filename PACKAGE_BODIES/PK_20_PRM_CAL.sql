--------------------------------------------------------
--  DDL for Package Body PK_20_PRM_CAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_20_PRM_CAL" AS
-- Author       : Gbenga Cruz 
-- Description  : Premium Calculation
-- Date         : January 18, 2017 
  

    --Premium Calculation
    FUNCTION FN_20_PRM_CAL(p_prd_R_K NUMBER, p_si NUMBER,  p_pymnt_r_k NUMBER, p_prd_term NUMBER,p_cus_age NUMBER) RETURN NUMBER AS 
    
        v_prm  NUMBER;
        v_pr  VARCHAR(4000);
        v_prd  v_20_prd_info%ROWTYPE;
        v_pymt v_20_pymt_feq%ROWTYPE;
        v_si   NUMBER;
        v_dec  v_99_ssu_pmv.v_v%TYPE;
        v_prd_rt v_20_prd_rt.prd_rt%TYPE;
        
        CURSOR c_prd_rt IS SELECT prd_rt FROM v_20_prd_rt WHERE prd_r_k = p_prd_R_K AND cus_age = p_cus_age AND prd_term = p_prd_term AND nvl(pymt_r_k,p_pymnt_r_k) = p_pymnt_r_k;
        
        CURSOR c_prd IS SELECT r_k, prd_code, prd_desc, min_si, max_si, prd_rt, min_age, max_age, med_exm, fee_amt , si_div,prd_fml,prm_fml,prd_tp FROM v_20_prd_info
                 WHERE ius_yn = 1 AND r_k = p_prd_R_K;
        CURSOR c_pymnt IS SELECT r_k , pymt_rt, pymt_id FROM v_20_pymt_feq WHERE r_k =  p_pymnt_r_k AND ius_yn = 1;
        
        CURSOR c_pmv IS SELECT v_v FROM v_99_ssu_pmv WHERE r_k =  70 AND v_yn = 1;
        
            BEGIN
          
             v_si := p_si;
             
             OPEN  c_prd_rt;
             FETCH c_prd_rt INTO v_prd_rt;
             CLOSE c_prd_rt;
             
             OPEN  c_pmv;
             FETCH c_pmv INTO v_dec;
             CLOSE c_pmv;
             
            --  v_prd.prd_rt := v_prd_rt;
              
             FOR i IN c_prd LOOP 
             
                 v_prd.r_k      := i.r_k;
                 v_prd.fee_amt  := i.fee_amt;
                 v_prd.si_div   := i.si_div;
                 v_prd.prd_fml  := i.prd_fml;
                 v_prd.prm_fml  := i.prm_fml;
                 v_prd.prd_tp   := i.prd_tp;
                 v_prd.prd_rt   := i.prd_rt;
            
             END LOOP;
             
             
             FOR i IN c_pymnt LOOP 
             
                 v_pymt.r_k      := i.r_k;
                 v_pymt.pymt_rt  := i.pymt_rt;
                 v_pymt.pymt_id  := i.pymt_id;
                 
            
             END LOOP;
          
                 IF v_prd.prd_tp = 10 THEN
                 
                     v_prm := (v_prd_rt * v_si) /  v_prd.si_div ;
                     v_prm := v_prm + v_prd.fee_amt;
                     v_prm := ROUND(((v_prm + (v_prm * v_pymt.pymt_rt))/v_pymt.pymt_id),v_dec);
                     
                 END IF;
                 
                   IF v_prd.prd_tp = 11 THEN
                 
                     v_prm := (v_prd.prd_rt * v_si) /  v_prd.si_div ;
                      v_prm := v_prm + v_prd.fee_amt;
                     v_prm := ROUND(v_prm ,v_dec);
                     
                 END IF;
                 -- RETURN v_prd.prd_rt;
                  RETURN v_prm;
       
    END FN_20_PRM_CAL;
    
    
    
    --Premium Calculation for group life
    FUNCTION FN_20_PRM_CAL_GRP(p_prd_R_K NUMBER, p_si NUMBER,  p_pymnt_r_k NUMBER, p_prd_term NUMBER,p_cus_age NUMBER, p_term_tp NUMBER, p_prt_by NUMBER, p_prt_v NUMBER, p_prt_rt NUMBER) RETURN NUMBER AS 
    
        v_prm  NUMBER;
        v_pr  VARCHAR(4000);
        v_prd  v_20_prd_info%ROWTYPE;
        v_pymt v_20_pymt_feq%ROWTYPE;
        v_si   NUMBER;
        v_dec  v_99_ssu_pmv.v_v%TYPE;
        v_prd_rt v_20_prd_rt.prd_rt%TYPE;

        v_term_tp NUMBER; 
        v_prt_by  NUMBER;
        v_prt_v   NUMBER; 
        v_prt_rt  NUMBER;
        
        CURSOR c_prd_rt IS SELECT prd_rt FROM v_20_prd_rt WHERE prd_r_k = p_prd_R_K AND cus_age = p_cus_age AND prd_term = p_prd_term AND nvl(pymt_r_k,p_pymnt_r_k) = p_pymnt_r_k;
        
        CURSOR c_prd IS SELECT r_k, prd_code, prd_desc, min_si, max_si, prd_rt, min_age, max_age, med_exm, fee_amt , si_div,prd_fml,prm_fml,prd_tp FROM v_20_prd_info
                 WHERE ius_yn = 1 AND r_k = p_prd_R_K;
        CURSOR c_pymnt IS SELECT r_k , pymt_rt, pymt_id FROM v_20_pymt_feq WHERE r_k =  p_pymnt_r_k AND ius_yn = 1;
        
        CURSOR c_pmv IS SELECT v_v FROM v_99_ssu_pmv WHERE r_k =  70 AND v_yn = 1;
        
            BEGIN


             v_term_tp := p_term_tp; 
             v_prt_by  := p_prt_by;
             v_prt_v   := p_prt_v; 
             v_prt_rt  := p_prt_rt;
             
              v_si := p_si;
          
            IF v_term_tp = 20 THEN

                 
             
                 OPEN  c_prd_rt;
                   FETCH c_prd_rt INTO v_prd_rt;
                 CLOSE c_prd_rt;
             
                 OPEN  c_pmv;
                  FETCH c_pmv INTO v_dec;
                 CLOSE c_pmv;
             
            --  v_prd.prd_rt := v_prd_rt;
              
                 FOR i IN c_prd LOOP 
             
                     v_prd.r_k      := i.r_k;
                     v_prd.fee_amt  := i.fee_amt;
                     v_prd.si_div   := i.si_div;
                     v_prd.prd_fml  := i.prd_fml;
                     v_prd.prm_fml  := i.prm_fml;
                     v_prd.prd_tp   := i.prd_tp;
                     v_prd.prd_rt   := i.prd_rt;
            
                 END LOOP;
             
             
                 FOR i IN c_pymnt LOOP 
             
                     v_pymt.r_k      := i.r_k;
                     v_pymt.pymt_rt  := i.pymt_rt;
                     v_pymt.pymt_id  := i.pymt_id;
                 
            
                 END LOOP;
          
                 IF v_prd.prd_tp = 10 THEN
                 
                     v_prm := (v_prt_rt * v_si) /  v_prd.si_div ;
                     v_prm := v_prm + v_prd.fee_amt;
                     v_prm := ROUND(((v_prm + (v_prm * v_pymt.pymt_rt))/v_pymt.pymt_id),v_dec);
                     
                 END IF;
                 
                   IF v_prd.prd_tp = 11 THEN
                 
                     v_prm := (v_prd.prd_rt * v_si) /  v_prd.si_div ;
                     v_prm := v_prm + v_prd.fee_amt;
                     v_prm := ROUND(v_prm ,v_dec);
                     
                     END IF;
                 -- RETURN v_prd.prd_rt;
             END IF;
            

            IF v_term_tp = 21 THEN
            
                 OPEN  c_pmv;
                  FETCH c_pmv INTO v_dec;
                 CLOSE c_pmv;
            
               FOR i IN c_prd LOOP 
             
                     v_prd.r_k      := i.r_k;
                     v_prd.fee_amt  := i.fee_amt;
                     v_prd.si_div   := i.si_div;
                     v_prd.prd_fml  := i.prd_fml;
                     v_prd.prm_fml  := i.prm_fml;
                     v_prd.prd_tp   := i.prd_tp;
                     v_prd.prd_rt   := i.prd_rt;
            
                 END LOOP;
            
                   v_prm := (v_prt_rt * v_si) /  v_prd.si_div ;
                   
                   v_prm := v_prm + v_prd.fee_amt;
                   v_prm   := v_prm * (v_prt_v / v_prt_by);
                   v_prm := ROUND(v_prm ,v_dec);   
--raise_application_error(-20001,v_prm);

            END IF;

                  RETURN v_prm;
       
    END FN_20_PRM_CAL_GRP;
    
    
    ---Age @ Next Birthady
    FUNCTION FN_20_CUS_AGE (p_cus IN v_20_cus_info%ROWTYPE) RETURN NUMBER AS 
        v_cus     v_20_cus_info%ROWTYPE;
        v_nxt_dob v_20_cus_info.dob%TYPE;
        CURSOR c_cus_age IS SELECT dob FROM v_20_cus_info WHERE r_k = p_cus.r_k;
        
            BEGIN
            
            OPEN c_cus_age;
            FETCH c_cus_age INTO v_cus.dob;
            CLOSE c_cus_age;
            
            IF p_cus.DOB IS NOT NULL THEN
            
            v_cus.dob  :=p_cus.DOB;
            
            END IF;    
            
            v_nxt_dob   := to_date(SUBSTR(v_cus.dob, 1, 7)|| EXTRACT(YEAR FROM SYSDATE));
          -- raise_application_error(-20001, v_nxt_dob);
         IF to_date(v_nxt_dob) > SYSDATE THEN
         
               v_cus.nxt_age :=  TRUNC((v_nxt_dob - v_cus.dob)/365);
         
                ELSE
         
               v_nxt_dob :=  ADD_MONTHS(v_nxt_dob, 12);
               
               v_cus.nxt_age :=  TRUNC((v_nxt_dob - v_cus.dob)/365);
         
         END IF;
            
              RETURN   v_cus.nxt_age;    
     END FN_20_CUS_AGE;
     
     --- Policy Enddate
        FUNCTION FN_20_POL_END_DT (p_term_r_k IN NUMBER, p_prd_r_k IN NUMBER,p_start_dt IN DATE) RETURN DATE AS 
        v_term_id        v_20_prd_term.term_id%TYPE;
        v_pol_end_dt     DATE; 
        v_pol_start_dt   DATE; 
        v_mon_yr         NUMBER:=12;
        CURSOR c_prd_term IS SELECT term_id FROM v_20_prd_term WHERE r_k = p_term_r_k AND prd_r_k = p_prd_r_k AND ius_yn = 1;
        
            BEGIN
            
            v_pol_start_dt := p_start_dt;
            OPEN c_prd_term;
            FETCH c_prd_term INTO v_term_id;
            CLOSE c_prd_term;
            v_pol_end_dt := ( add_months(v_pol_start_dt,(v_term_id * v_mon_yr) ) -1) ;
            
              RETURN  v_pol_end_dt;    
     END FN_20_POL_END_DT;
     
      --- Policy Enddate for prorate premium
         FUNCTION FN_20_POL_END_DT_PRT (p_prt_by IN NUMBER,p_prt_v IN NUMBER, p_start_dt IN DATE) RETURN DATE AS 
        v_term_id        v_20_prd_term.term_id%TYPE;
        v_pol_end_dt     DATE; 
        v_pol_start_dt   DATE; 
        v_mon_yr         NUMBER:=12;
        v_prt_by         NUMBER;
        v_prt_v          NUMBER;
            BEGIN
            
            v_pol_start_dt := p_start_dt;
            v_prt_by       := p_prt_by;
            v_prt_v        := p_prt_v;

            IF v_prt_by = 12 THEN
            v_pol_end_dt := ( add_months(v_pol_start_dt,(v_prt_v) ) -1) ;
            END IF;
            
            IF v_prt_by = 365 THEN 
             v_pol_end_dt := ((v_pol_start_dt + (v_prt_v) ) -1) ;
            END IF;

              RETURN  v_pol_end_dt; 
                
     END FN_20_POL_END_DT_PRT;
     
     --- Validate sum insured
    FUNCTION FN_20_POL_SI (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN AS 
       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_prd       v_20_prd_info%ROWTYPE;
	   
       CURSOR c_prd IS SELECT min_si, max_si FROM v_20_prd_info where r_k = p_uw_pol.prd_r_k;
        
            BEGIN
			     
			     FOR i IN  c_prd LOOP
                  v_prd.min_si  := i.min_si;
                  v_prd.max_si  := i.max_si;
                 END LOOP;
                 
                 v_uw_pol.prd_r_k := p_uw_pol.prd_r_k;
                 v_uw_pol.si_amt :=  p_uw_pol.si_amt;
            
            
              IF  v_uw_pol.si_amt  BETWEEN v_prd.min_si AND v_prd.max_si THEN 
                     RETURN TRUE; 
                 ELSE 
 				     RETURN FALSE; 
              END IF;
               
     END FN_20_POL_SI;
     
     
          --- Validate insured age
    FUNCTION FN_20_INS_AGE (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN AS 
       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_prd       v_20_prd_info%ROWTYPE;
       v_cus     v_20_cus_info%ROWTYPE;
	   v_cus_age    NUMBER;
       
       CURSOR c_prd IS SELECT min_age, max_age FROM v_20_prd_info where r_k = p_uw_pol.prd_r_k;
        
            BEGIN
			     
			     FOR i IN  c_prd LOOP
                  v_prd.min_age  := i.min_age;
                  v_prd.max_age  := i.max_age;
                 END LOOP;
                 
                 v_uw_pol.prd_r_k  := p_uw_pol.prd_r_k;
                 v_cus.r_k := p_uw_pol.insr_r_k;
                 
                 v_cus_age := PK_20_PRM_CAL.FN_20_CUS_AGE(v_cus);
            
            
              IF  v_cus_age  BETWEEN v_prd.min_age AND v_prd.max_age THEN 
                     RETURN TRUE; 
                 ELSE 
 				     RETURN FALSE; 
              END IF;
               
     END FN_20_INS_AGE;
     
          
        --- Product Type
        FUNCTION FN_20_PRD_TP (p_prd_r_k IN NUMBER) RETURN NUMBER AS 
        v_prd_tp         v_20_prd_info.prd_tp%TYPE;
      
	
		CURSOR c_prd_tp IS SELECT  prd_tp FROM v_20_prd_info WHERE  r_k = p_prd_r_k AND ius_yn = 1;
        
            BEGIN
          
            OPEN c_prd_tp;
            FETCH c_prd_tp INTO v_prd_tp;
            CLOSE c_prd_tp;
            
              RETURN  v_prd_tp;    
        END FN_20_PRD_TP;
        
END PK_20_PRM_CAL;

/
