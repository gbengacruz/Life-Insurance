--------------------------------------------------------
--  DDL for Package Body PK_20_UW_POL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_20_UW_POL" AS

-- Author       : Gbenga Cruz 
-- Description  : Policy Management
-- Date         : January 18, 2017 
 
    --- Policy Creation
     PROCEDURE PC_20_UW_POL (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_prd       v_20_prd_info%ROWTYPE;
       v_cus       v_20_cus_info%ROWTYPE;
       v_val       BOOLEAN;
       v_cus_age    NUMBER;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
       CURSOR c_prd IS SELECT prd_fml, prd_tp FROM v_20_prd_info where r_k = p_uw_pol.prd_r_k;
     

         BEGIN
            
            FOR i IN  c_prd LOOP
            v_prd.prd_fml := i.prd_fml;
            v_prd.prd_tp  := i.prd_tp;
        
            END LOOP;
            
           
                                                                                                                 
            v_uw_pol.r_k            := p_uw_pol.r_k;
            v_uw_pol.pol_no         := v_prd.prd_fml ||'/'|| EXTRACT (YEAR FROM SYSDATE) ||'/'|| s_20_uw_pol_no.NEXTVAL;
            v_uw_pol.prd_r_k        := p_uw_pol.prd_r_k;
            v_uw_pol.prd_term       := p_uw_pol.prd_term;
            v_uw_pol.si_amt         := p_uw_pol.si_amt;
            v_uw_pol.mns_pymt       := p_uw_pol.mns_pymt;
            v_uw_pol.insr_r_k       := p_uw_pol.insr_r_k;
            v_uw_pol.pymt_feq       := p_uw_pol.pymt_feq;
            v_uw_pol.cus_r_k        := p_uw_pol.cus_r_k;
            v_uw_pol.prm_amt        := p_uw_pol.prm_amt;
            v_uw_pol.st_dt          := p_uw_pol.st_dt;
            v_uw_pol.en_dt          := p_uw_pol.en_dt;
            v_uw_pol.anl_inc        := p_uw_pol.anl_inc;
            v_uw_pol.inc_pr         := p_uw_pol.inc_pr;
            v_uw_pol.actl_dbft      := p_uw_pol.si_amt;
            v_uw_pol.apr_sta        := 0;
            v_uw_pol.pol_sta        := 11;
            v_uw_pol.sys_dtt        := SYSDATE;
            v_bus_dt                := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
            v_uw_pol.bus_dt         := v_bus_dt;
            v_uw_pol.grp_yn        := p_uw_pol.grp_yn;
            v_uw_pol.loc_r_k        := p_uw_pol.loc_r_k;

         
            IF v_prd.prd_tp IN (10, 11) THEN 
            
            v_val := PK_20_PRM_CAL.FN_20_POL_SI(v_uw_pol);
                      IF    v_val = FALSE THEN 
                            v_err.err_cd := '-20020';
                            p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
              END IF;
              
            END IF;
              
             v_val := PK_20_PRM_CAL.FN_20_INS_AGE(v_uw_pol);
                      IF    v_val = FALSE THEN 
                            v_err.err_cd := '-20021';
                            p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
              END IF;
              
              v_cus.r_k           := v_uw_pol.insr_r_k ;
              v_cus_age           := PK_20_PRM_CAL.FN_20_CUS_AGE(v_cus);
              
              v_uw_pol.en_dt      :=  PK_20_PRM_CAL.FN_20_POL_END_DT(v_uw_pol.prd_term ,v_uw_pol.prd_r_k,v_uw_pol.st_dt);
             
             IF v_prd.prd_tp IN (10, 11) THEN 
              v_uw_pol.prm_amt    :=  PK_20_PRM_CAL.FN_20_PRM_CAL(v_uw_pol.prd_r_k,v_uw_pol.si_amt,v_uw_pol.pymt_feq,v_uw_pol.prd_term ,v_cus_age);
             END IF;
             
           IF v_err.err_msg IS NULL THEN

               INSERT INTO t_20_uw_pol(r_k,pol_no,prd_r_k,prd_term,si_amt,mns_pymt,insr_r_k,pymt_feq,cus_r_k,prm_amt,st_dt,en_dt,anl_inc,inc_pr,actl_dbft,apr_sta,sys_dtt,bus_dt,grp_yn,loc_r_k,pol_sta)
                     VALUES
                    (v_uw_pol.r_k,v_uw_pol.pol_no,v_uw_pol.prd_r_k,v_uw_pol.prd_term,v_uw_pol.si_amt,v_uw_pol.mns_pymt,v_uw_pol.insr_r_k 
                      ,v_uw_pol.pymt_feq,v_uw_pol.cus_r_k,v_uw_pol.prm_amt,v_uw_pol.st_dt,v_uw_pol.en_dt,v_uw_pol.anl_inc,v_uw_pol.inc_pr,v_uw_pol.actl_dbft,v_uw_pol.apr_sta,v_uw_pol.sys_dtt,v_uw_pol.bus_dt,v_uw_pol.grp_yn,v_uw_pol.loc_r_k,v_uw_pol.pol_sta);

                COMMIT;

           END IF;

       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_UW_POL;

   
       --- Policy Approval
     PROCEDURE PC_20_UW_POL_APR (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_val        BOOLEAN;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
	   v_pymt_tran v_70_pymt_tran%ROWTYPE;
	   
       CURSOR c_pymt_tran IS SELECT MIN(due_dt) due_dt FROM v_70_pymt_tran WHERE apr_sta = 1 AND pol_r_k = p_uw_pol.r_k;
     

         BEGIN
            
             OPEN  c_pymt_tran;
			 FETCH c_pymt_tran INTO v_pymt_tran.due_dt;
			 CLOSE c_pymt_tran;
            
                 IF    v_pymt_tran.due_dt IS NULL THEN 
                            v_err.err_cd := '-20029';
                            p_err_msg := v_err.err_msg; 
                        raise_application_error(v_err.err_cd ,p_err_msg);
                 END IF; 
                                                                                                                 
            v_uw_pol.r_k            := p_uw_pol.r_k;
            v_uw_pol.apr_sta        := 1;
            v_uw_pol.sys_dtt        := SYSDATE;
            v_bus_dt                := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
            v_uw_pol.bus_dt         := v_bus_dt;
            v_uw_pol.apr_by         := V('APP_USER');
            v_uw_pol.apr_dt         := SYSDATE;
            v_uw_pol.pol_sta       := 22;
            
      
              
           IF v_err.err_msg IS NULL THEN

               UPDATE  t_20_uw_pol SET apr_sta =  v_uw_pol.apr_sta , apr_dt = v_uw_pol.apr_dt, bus_dt= v_uw_pol.bus_dt, sys_dtt = v_uw_pol.sys_dtt, apr_by = v_uw_pol.apr_by , pol_sta = v_uw_pol.pol_sta
			                       WHERE r_k = v_uw_pol.r_k;
                COMMIT;
           END IF;
           
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_UW_POL_APR;
    
    
    
 --- Beneficiary Creation
     PROCEDURE PC_20_CUS_BENF (p_cus_benf IN v_20_cus_benf%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

        v_cus_benf   v_20_cus_benf%ROWTYPE;
        v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt    v_99_ssu_pmv.v_d%TYPE;

        CURSOR c_cus_benf IS SELECT nvl(SUM(benf_perc),0) benf_perc FROM v_20_cus_benf WHERE pol_r_k = p_cus_benf.pol_r_k AND cus_r_k = p_cus_benf.cus_r_k;

         BEGIN

		  
		   
		     OPEN  c_cus_benf;
			 FETCH c_cus_benf INTO v_cus_benf.benf_perc;
			 CLOSE c_cus_benf;

             v_cus_benf.benf_perc := v_cus_benf.benf_perc + p_cus_benf.benf_perc;
			 
            
			IF v_cus_benf.benf_perc > 100  THEN
			
			
			     v_err.err_cd := '-20030';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
				 
				 
		     ELSE
			  			  
            v_cus_benf.r_k             := p_cus_benf.r_k;
            v_cus_benf.benf_nm         := p_cus_benf.benf_nm;
            v_cus_benf.benf_perc       := p_cus_benf.benf_perc;
            v_cus_benf.benf_rel        := p_cus_benf.benf_rel;
            v_cus_benf.benf_adr        := p_cus_benf.benf_adr;
            v_cus_benf.pol_r_k         := p_cus_benf.pol_r_k;
            v_cus_benf.cus_r_k         := p_cus_benf.cus_r_k;
      



           IF v_err.err_msg IS NULL THEN
           
                 INSERT INTO t_20_cus_benf(r_k,benf_nm,benf_perc,benf_rel,benf_adr,pol_r_k,cus_r_k )
                     VALUES
                    (v_cus_benf.r_k,v_cus_benf.benf_nm,v_cus_benf.benf_perc,v_cus_benf.benf_rel,v_cus_benf.benf_adr,v_cus_benf.pol_r_k, v_cus_benf.cus_r_k);
           
           END IF;
		 
		   END IF;
		   
       -- COMMIT;
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
    END PC_20_CUS_BENF;
    
    
    
     --- Beneficiary Validation
     PROCEDURE PC_20_CUS_BENF_VAL (p_cus_benf IN v_20_cus_benf%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

        v_cus_benf   v_20_cus_benf%ROWTYPE;
        v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt    v_99_ssu_pmv.v_d%TYPE;

        CURSOR c_cus_benf IS SELECT nvl(SUM(benf_perc),0) benf_perc FROM v_20_cus_benf WHERE pol_r_k = p_cus_benf.pol_r_k AND cus_r_k = p_cus_benf.cus_r_k;

         BEGIN

		  
		   
		     OPEN  c_cus_benf;
			 FETCH c_cus_benf INTO v_cus_benf.benf_perc;
			 CLOSE c_cus_benf;

			 
			 
			IF v_cus_benf.benf_perc != 100  THEN
			
			
			     v_err.err_cd := '-20030';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
			
				 
		   END IF;
		   
       -- COMMIT;
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
    END PC_20_CUS_BENF_VAL;

    
    
     --- Add Group Policy Member
     PROCEDURE PC_20_UW_POL_MEM (p_pol_mem IN v_20_uw_pol_mem%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_pol_mem       v_20_uw_pol_mem%ROWTYPE;
		v_err           v_99_ssu_log%ROWTYPE;
        v_bus_dt        v_99_ssu_pmv.v_d%TYPE;
        v_pol           v_20_uw_pol_mem.r_k%TYPE;
        
         CURSOR c_pol IS SELECT count(r_k) pol FROM v_20_uw_pol_mem WHERE r_k = p_pol_mem.r_k;

		BEGIN
        
        
        OPEN  c_pol;
        FETCH c_pol INTO v_pol;
        CLOSE c_pol;
           
           
		     v_pol_mem.r_k              := p_pol_mem.r_k;
			 ---v_pol_mem.bus_dt           := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     ---v_pol_mem.sys_dtt            := SYSDATE;
			 --v_pol_mem.apr_sta          := 0;
			 v_pol_mem.benf_nm          := p_pol_mem.benf_nm;
			 v_pol_mem.sex              := p_pol_mem.sex;
             v_pol_mem.dob              := p_pol_mem.dob;
             v_pol_mem.sal              := p_pol_mem.sal;
             v_pol_mem.si               := p_pol_mem.si;
             v_pol_mem.prm              := p_pol_mem.prm;
             v_pol_mem.pol_r_k          := p_pol_mem.pol_r_k;
             v_pol_mem.cus_r_k          := p_pol_mem.cus_r_k;

			 
			 IF v_err.err_msg IS NULL THEN
             
                 IF  v_pol = 0 THEN
			 
			         INSERT INTO t_20_uw_pol_mem(r_k, benf_nm, sex, dob,sal,si, prm, pol_r_k, cus_r_k) VALUES 
										 (v_pol_mem.r_k, v_pol_mem.benf_nm, v_pol_mem.sex, v_pol_mem.dob,v_pol_mem.sal,v_pol_mem.si, v_pol_mem.prm, v_pol_mem.pol_r_k, v_pol_mem.cus_r_k);
                                          
                                          ELSE
                                          
                     UPDATE t_20_uw_pol_mem SET benf_nm = v_pol_mem.benf_nm ,  sex = v_pol_mem.sex, dob = v_pol_mem.dob, 
                     sal = v_pol_mem.sal, si = v_pol_mem.si, prm = v_pol_mem.prm, cus_r_k = v_pol_mem.cus_r_k   WHERE r_k = v_pol_mem.r_k;
                                          
                END IF;
		  
			 
			 END IF;
			 COMMIT;
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
	END PC_20_UW_POL_MEM;
    
         --- Group Policy Creation
     PROCEDURE PC_20_UW_POL_GRP (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_prd       v_20_prd_info%ROWTYPE;
       v_cus       v_20_cus_info%ROWTYPE;
       v_val       BOOLEAN;
       v_cus_age    NUMBER;
       v_pol   NUMBER;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
       v_pymt_tran       v_70_pymt_tran%ROWTYPE;
        v_aud   v_99_ssu_aud%ROWTYPE;
       
       CURSOR c_prd IS SELECT prd_fml, prd_tp FROM v_20_prd_info where r_k = p_uw_pol.prd_r_k;
       CURSOR c_pol_mem IS SELECT sum(si) si, sum(prm) prm FROM v_20_uw_pol_mem WHERE pol_r_k = p_uw_pol.r_k; 
     CURSOR c_pol IS SELECT count(r_k) FROM v_20_uw_pol WHERE r_k = p_uw_pol.r_k;
         BEGIN
         
            OPEN c_pol_mem;
            FETCH c_pol_mem INTO  v_uw_pol.si_amt, v_uw_pol.prm_amt;
            CLOSE c_pol_mem;
            
            OPEN c_pol;
            FETCH c_pol INTO v_pol;
            CLOSE c_pol;

            FOR i IN  c_prd LOOP
            v_prd.prd_fml := i.prd_fml;
            v_prd.prd_tp  := i.prd_tp;
        
            END LOOP;
            
           
                                                                                                                 
            v_uw_pol.r_k            := p_uw_pol.r_k;
         --   v_uw_pol.pol_no         := v_prd.prd_fml ||'/'|| EXTRACT (YEAR FROM SYSDATE) ||'/'|| s_20_uw_pol_no.NEXTVAL;
            v_uw_pol.prd_r_k        := p_uw_pol.prd_r_k;
            v_uw_pol.prd_term       := p_uw_pol.prd_term;
           --  v_uw_pol.si_amt         := p_uw_pol.si_amt;
            v_uw_pol.mns_pymt       := p_uw_pol.mns_pymt;
            v_uw_pol.insr_r_k       := p_uw_pol.insr_r_k;
            v_uw_pol.pymt_feq       := p_uw_pol.pymt_feq;
            v_uw_pol.cus_r_k        := p_uw_pol.cus_r_k;
           -- v_uw_pol.prm_amt        := p_uw_pol.prm_amt;
            v_uw_pol.st_dt          := p_uw_pol.st_dt;
            v_uw_pol.en_dt          := p_uw_pol.en_dt;
            v_uw_pol.actl_dbft      := v_uw_pol.si_amt;
            v_uw_pol.apr_sta        := 0;
             v_uw_pol.pol_sta       := 11;
            v_uw_pol.sys_dtt        := SYSDATE;
            v_bus_dt                := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
            v_uw_pol.bus_dt         := v_bus_dt;
            v_uw_pol.grp_yn         := p_uw_pol.grp_yn;
            v_uw_pol.loc_r_k        := p_uw_pol.loc_r_k;
            v_uw_pol.prt_by        := p_uw_pol.prt_by;
            v_uw_pol.prt_v        := p_uw_pol.prt_v;
            v_uw_pol.prt_rt        := p_uw_pol.prt_rt;
      
           IF v_err.err_msg IS NULL THEN

               IF v_pol = 0 THEN
               

             
             
             
             v_uw_pol.pol_no         := v_prd.prd_fml ||'/'|| EXTRACT (YEAR FROM SYSDATE) ||'/'|| s_20_uw_pol_no.NEXTVAL;
             
               INSERT INTO t_20_uw_pol(r_k,pol_no,prd_r_k,prd_term,si_amt,mns_pymt,insr_r_k,pymt_feq,cus_r_k,prm_amt,st_dt,en_dt,anl_inc,inc_pr,actl_dbft,apr_sta,sys_dtt,bus_dt,grp_yn,loc_r_k,prt_by,prt_v,prt_rt,pol_sta)
                     VALUES
                    (v_uw_pol.r_k,v_uw_pol.pol_no,v_uw_pol.prd_r_k,v_uw_pol.prd_term,v_uw_pol.si_amt,v_uw_pol.mns_pymt,v_uw_pol.insr_r_k 
                      ,v_uw_pol.pymt_feq,v_uw_pol.cus_r_k,v_uw_pol.prm_amt,v_uw_pol.st_dt,v_uw_pol.en_dt,v_uw_pol.anl_inc,v_uw_pol.inc_pr,v_uw_pol.actl_dbft,v_uw_pol.apr_sta,v_uw_pol.sys_dtt,v_uw_pol.bus_dt,v_uw_pol.grp_yn,v_uw_pol.loc_r_k,v_uw_pol.prt_by,v_uw_pol.prt_v,v_uw_pol.prt_rt,v_uw_pol.pol_sta);

            ---- Generate Premium payment
             v_pymt_tran.pol_r_k  := v_uw_pol.r_k;
             
             	PK_70_PYMT_TRAN.PC_70_PYMT_TRAN(v_pymt_tran,v_uw_pol, v_err.err_msg);	
			   
               IF v_err.err_msg IS NOT NULL THEN
                 v_err.err_cd := '-20099';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
               END IF;
             
             ---Audit Trail
          --   v_aud.aud_code := v('APP_PAGE_ID');
             v_aud.aud_code := '2013_CREATE';
             v_aud.tran_r_k := v_uw_pol.r_k;
             PK_99_SSU_PMV.PC_99_SSU_AUD(v_aud, v_err.err_msg);
             
             ELSE
             
             UPDATE t_20_uw_pol SET  si_amt = v_uw_pol.si_amt, prm_amt = v_uw_pol.prm_amt, actl_dbft = v_uw_pol.si_amt , prd_term = v_uw_pol.prd_term,
             pymt_feq = v_uw_pol.pymt_feq, cus_r_k = v_uw_pol.cus_r_k, st_dt = v_uw_pol.st_dt,en_dt = v_uw_pol.en_dt,loc_r_k = v_uw_pol.loc_r_k,
             prt_by = v_uw_pol.prt_by ,prt_v = v_uw_pol.prt_v ,prt_rt = v_uw_pol.prt_rt

             WHERE r_k = v_uw_pol.r_k;
             
               ---- Generate Premium payment
             v_pymt_tran.pol_r_k  := v_uw_pol.r_k;
              
                PK_70_PYMT_TRAN.PC_70_PYMT_TRAN_DEL(v_pymt_tran,v_err.err_msg);
                
                IF v_err.err_msg IS NOT NULL THEN
                 v_err.err_cd := '-20099';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
               END IF;
                
             	PK_70_PYMT_TRAN.PC_70_PYMT_TRAN(v_pymt_tran,v_uw_pol, v_err.err_msg);	
			   
               IF v_err.err_msg IS NOT NULL THEN
                 v_err.err_cd := '-20099';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
               END IF;
             

                               
            END IF;
 COMMIT;
           END IF;

       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_UW_POL_GRP;
    
    
   --- Cancel Policy Approval
     PROCEDURE PC_20_UW_POL_APR_CNL (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_uw_pol    v_20_uw_pol%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_val        BOOLEAN;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
	   v_pymt_tran v_70_pymt_tran%ROWTYPE;
	   
       CURSOR c_uw_pol IS SELECT r_k,insr_r_k FROM v_20_uw_pol WHERE pol_sta NOT IN (99, 33) AND r_k = p_uw_pol.r_k;
     

         BEGIN
            
             OPEN  c_uw_pol;
			 FETCH c_uw_pol INTO v_uw_pol.r_k,v_uw_pol.insr_r_k;
			 CLOSE c_uw_pol;
            
                 IF    v_uw_pol.r_k IS NULL THEN 
                            v_err.err_cd := '-20033';
                            p_err_msg := v_err.err_msg; 
                        raise_application_error(v_err.err_cd ,p_err_msg);
                 END IF; 
                                                                                                                 
          ---  v_uw_pol.r_k            := p_uw_pol.r_k;
            v_uw_pol.sys_dtt        := SYSDATE;
            v_bus_dt                := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
            v_uw_pol.bus_dt         := v_bus_dt;
            v_uw_pol.apr_by         := V('APP_USER');
            v_uw_pol.apr_dt         := SYSDATE;
            v_uw_pol.pol_sta       := 99;
            
             ---- Cancel Premium payment
             v_pymt_tran.pol_r_k  := v_uw_pol.r_k;
             v_pymt_tran.cus_r_k  := v_uw_pol.insr_r_k;
             
             	PK_70_PYMT_TRAN.PC_70_PYMT_TRAN_APR_CNL(v_pymt_tran, v_err.err_msg);	
           
              IF v_err.err_msg IS NOT NULL THEN
                 v_err.err_cd := '-20099';
                 p_err_msg := v_err.err_msg; 
                 raise_application_error(v_err.err_cd ,p_err_msg);
               END IF;
              
           IF v_err.err_msg IS NULL THEN

               UPDATE  t_20_uw_pol SET   bus_dt= v_uw_pol.bus_dt, sys_dtt = v_uw_pol.sys_dtt, pol_sta = v_uw_pol.pol_sta
			                       WHERE r_k = v_uw_pol.r_k;
                COMMIT;
           END IF;
           
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_UW_POL_APR_CNL;
    
    
    	 --- Validate Policy update
    FUNCTION FN_20_POL_EDT_VAL (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN AS 
       v_pol          v_20_uw_pol.apr_sta%TYPE;
       v_err             v_99_ssu_log%ROWTYPE;
	   v_pymt       v_70_pymt_tran.apr_sta%TYPE;
	   
       CURSOR c_pol IS SELECT apr_sta FROM v_20_uw_pol WHERE r_k = p_uw_pol.r_k AND grp_yn = p_uw_pol.grp_yn;
	   CURSOR c_pymt IS  SELECT  count(r_k) sta_val FROM v_70_pymt_tran WHERE pol_r_k = p_uw_pol.r_k AND apr_sta = 1 ;
        
            BEGIN
			     
				 OPEN  c_pol;
				 FETCH c_pol INTO v_pol;
				 CLOSE c_pol;
                 				 
				 OPEN  c_pymt;
				 FETCH c_pymt INTO v_pymt;
				 CLOSE c_pymt;
            
              IF  v_pol = 0  AND v_pymt = 0 THEN 
                     RETURN TRUE; 
                 ELSE 
 				     RETURN FALSE; 
              END IF;
               
     END FN_20_POL_EDT_VAL;
     
     
     	

    --- Validate Policy type
    FUNCTION FN_20_POL_TP_VAL (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN NUMBER AS 
       v_pol          v_20_uw_pol.apr_sta%TYPE;
       v_err             v_99_ssu_log%ROWTYPE;
	   
       CURSOR c_pol IS SELECT grp_yn FROM v_20_uw_pol where r_k = p_uw_pol.r_k;
        
            BEGIN
			     
				 OPEN  c_pol;
				 FETCH c_pol INTO v_pol;
				 CLOSE c_pol;
        
         RETURN v_pol;
               
     END FN_20_POL_TP_VAL;
     
     
     
     
    
END PK_20_UW_POL;

/
