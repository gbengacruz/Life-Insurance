--------------------------------------------------------
--  DDL for Package Body PK_70_CUS_ACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_CUS_ACT" AS

-- Author       : Gbenga Cruz 
-- Description  : Customer Account Management
-- Date         : January 18, 2017 
 
     
    --- Validate Customer Account
    FUNCTION FN_70_CUS_ACT (p_cus_act IN v_70_cus_act%ROWTYPE) RETURN BOOLEAN AS 
       v_uw_pol    v_70_cus_act%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       
    
	   v_cus_cnt    NUMBER;
       
       CURSOR c_cus IS SELECT count(r_k) FROM v_70_cus_act where cus_r_k = p_cus_act.cus_r_k;
        
            BEGIN
			     
			     OPEN c_cus;
                 FETCH c_cus INTO v_cus_cnt;
                 CLOSE c_cus;
                 
                
            
              IF  v_cus_cnt  > 0 THEN 
                     RETURN FALSE; 
                 ELSE 
 				     RETURN TRUE; 
              END IF;
               
     END FN_70_CUS_ACT;
     
     
     
     --- GET Customer Numner
    FUNCTION FN_70_CUS_ACT_GET (p_cus IN NUMBER) RETURN NUMBER AS 
       v_err       v_99_ssu_log%ROWTYPE;
       
       v_cus    NUMBER;
       
       CURSOR c_cus IS SELECT CUS_R_K FROM v_70_cus_act where r_k = p_cus;
        
            BEGIN
			     
			     OPEN c_cus;
                 FETCH c_cus INTO v_cus;
                 CLOSE c_cus;
                 
          RETURN v_cus;
    
    END FN_70_CUS_ACT_GET;
               
               
                    
     --- GET Customer Name
    FUNCTION FN_70_CUS_ACT_NM_GET (p_cus IN NUMBER) RETURN VARCHAR2 AS 
       v_err       v_99_ssu_log%ROWTYPE;
       
       v_cus    VARCHAR2(512);
       
       CURSOR c_cus IS SELECT CUS_NM FROM v_70_cus_act_dtl where r_k = p_cus;
        
            BEGIN
			     
			     OPEN c_cus;
                 FETCH c_cus INTO v_cus;
                 CLOSE c_cus;
                 
          RETURN v_cus;
    
    END FN_70_CUS_ACT_NM_GET;
               
 
 
    --- Customer Account Creation
     PROCEDURE PC_70_CUS_ACT (p_cus_act IN v_70_cus_act%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_cus_act   v_70_cus_act%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_val_cus   BOOLEAN;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
       v_comp      v_99_ssu_pmv.v_c%TYPE;
       v_curr      v_99_ssu_pmv.v_c%TYPE;
     

         BEGIN
         
             v_bus_dt                   := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;                
             v_comp                     := PK_99_SSU_PMV.FN_99_SS_PMV_COMP;
             v_curr                     := PK_99_SSU_PMV.FN_99_SS_PMV_CURR; 
             v_cus_act.r_k              := p_cus_act.r_k;
             v_cus_act.cus_r_k          := p_cus_act.cus_r_k;
             v_cus_act.bus_dt           := v_bus_dt;
             v_cus_act.sys_dtt          := SYSDATE;
             v_cus_act.apr_sta          := 0;
             v_cus_act.dept_r_k         := p_cus_act.dept_r_k;
             v_cus_act.loc_r_k          := p_cus_act.loc_r_k;
             v_cus_act.comp_r_k         := v_comp;
             v_cus_act.curr_r_k         := v_curr;
             v_cus_act.tran_bal         := 0;
      
              
              
             v_val_cus := PK_70_CUS_ACT.FN_70_CUS_ACT(v_cus_act);
                      IF    v_val_cus = FALSE THEN 
                            v_err.err_cd := '-20022';
                            p_err_msg := v_err.err_msg; 
                         raise_application_error(v_err.err_cd ,p_err_msg);
                      END IF;
                      
           IF v_err.err_msg IS NULL THEN

               INSERT INTO t_70_cus_act(r_k ,cus_r_k ,bus_dt ,sys_dtt ,apr_sta ,dept_r_k ,loc_r_k ,comp_r_k ,curr_r_k ,tran_bal)
                     VALUES
                    (v_cus_act.r_k ,v_cus_act.cus_r_k ,v_cus_act.bus_dt ,v_cus_act.sys_dtt, v_cus_act.apr_sta, v_cus_act.dept_r_k ,v_cus_act.loc_r_k ,v_cus_act.comp_r_k ,v_cus_act.curr_r_k ,v_cus_act.tran_bal);

              --  COMMIT;

           END IF;

       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_CUS_ACT;
    

  --- Approve Customer Account Creation
     PROCEDURE PC_70_CUS_ACT_APR (p_cus_act IN v_70_cus_act%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_cus_act   v_70_cus_act%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_val_cus   BOOLEAN;
       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
     

         BEGIN
                            
             v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;    
             
             v_cus_act.r_k              := p_cus_act.r_k;
             v_cus_act.apr_sta          := 1;
             v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
             v_cus_act.bus_dt           := v_bus_dt;
             v_cus_act.sys_dtt          := SYSDATE;
             v_cus_act.apr_by           := V('APP_USER');
             v_cus_act.apr_dt           := SYSDATE;
             
         
           
                                
             IF v_err.err_msg IS NULL THEN

                UPDATE t_70_cus_act SET apr_sta = v_cus_act.apr_sta, bus_dt = v_cus_act.bus_dt, apr_by =  v_cus_act.apr_by, apr_dt = v_cus_act.apr_dt  WHERE r_k = v_cus_act.r_k;

               -- COMMIT;

             END IF;

       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_CUS_ACT_APR;
    
    	 --- Customer Deposit
     PROCEDURE PC_70_CUS_ACT_TRAN (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_act_tran  v_70_cus_act_tran%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;

         CURSOR c_cus_act IS SELECT r_k FROM v_70_cus_act WHERE cus_r_k = p_act_tran.cus_r_k AND apr_sta =1 ;

         BEGIN
		 
		     OPEN c_cus_act;
			 FETCH c_cus_act INTO v_act_tran.act_r_k;
			 CLOSE c_cus_act;
             
             
              IF    v_act_tran.act_r_k IS NULL THEN 
                            v_err.err_cd := '-20026';
                            p_err_msg := v_err.err_msg; 
                    raise_application_error(v_err.err_cd ,p_err_msg);
              END IF;
         
             v_act_tran.r_k         := p_act_tran.r_k;
			 v_act_tran.cus_r_k     := p_act_tran.cus_r_k;
			 v_act_tran.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			 v_act_tran.sys_dtt     := SYSDATE;
			 v_act_tran.apr_sta     := 0;
			 v_act_tran.tran_desc   := p_act_tran.tran_desc;
			 v_act_tran.tran_amt    := p_act_tran.tran_amt;
			 v_act_tran.ref_no      := p_act_tran.ref_no;
             v_act_tran.mode_pymt   := p_act_tran.mode_pymt;
             v_act_tran.tran_srce   := p_act_tran.tran_srce;
             v_act_tran.dr_cr       := p_act_tran.dr_cr;
             v_act_tran.tran_r_k    := p_act_tran.tran_r_k;
             
                                        
                         
                 IF v_err.err_msg IS NULL THEN

                     INSERT INTO T_70_CUS_ACT_TRAN ( r_k, cus_r_k, act_r_k, bus_dt, sys_dtt, apr_sta, tran_desc,tran_amt, ref_no,mode_pymt,tran_srce,dr_cr,tran_r_k)
					              VALUES ( v_act_tran.r_k, v_act_tran.cus_r_k, v_act_tran.act_r_k, v_act_tran.bus_dt,
        								  v_act_tran.sys_dtt, v_act_tran.apr_sta, v_act_tran.tran_desc, v_act_tran.tran_amt, v_act_tran.ref_no,v_act_tran.mode_pymt,v_act_tran.tran_srce,v_act_tran.dr_cr,v_act_tran.tran_r_k);
                   
                 END IF;
		 
              
        -- COMMIT;
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_CUS_ACT_TRAN;
    
        	 --- Customer Deposit deletion
     PROCEDURE PC_70_CUS_ACT_TRAN_DEL (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_act_tran  v_70_cus_act_tran%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;
		 
		 CURSOR c_act_tran IS SELECT apr_sta FROM  v_70_cus_act_tran WHERE r_k = p_act_tran.r_k;


         BEGIN
		 
             OPEN c_act_tran;
			 FETCH c_act_tran INTO v_act_tran.apr_sta;
			 CLOSE c_act_tran;
			 
             v_act_tran.r_k         := p_act_tran.r_k;

             IF  v_act_tran.apr_sta = 1 THEN
			             v_err.err_cd := '-20027';
                         p_err_msg := v_err.err_msg; 
                         raise_application_error(v_err.err_cd ,p_err_msg);
             END IF;
			 
                 IF v_err.err_msg IS NULL THEN
 raise_application_error(-20001,v_act_tran.r_k);
                     DELETE FROM T_70_CUS_ACT_TRAN  WHERE r_k = v_act_tran.r_k ;
                 END IF;
		 
              
         COMMIT;
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_CUS_ACT_TRAN_DEL;
    
     --- Customer Deposit Update
     PROCEDURE PC_70_CUS_ACT_TRAN_UPD (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_act_tran  v_70_cus_act_tran%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;
		 
		  CURSOR c_cus_act IS SELECT r_k FROM v_70_cus_act WHERE cus_r_k = p_act_tran.cus_r_k AND apr_sta =1;
		  CURSOR c_act_tran IS SELECT apr_sta FROM  v_70_cus_act_tran WHERE r_k = p_act_tran.r_k;


         BEGIN
		     
			 OPEN c_cus_act;
			 FETCH c_cus_act INTO v_act_tran.act_r_k;
			 CLOSE c_cus_act;
		 
             OPEN c_act_tran;
			 FETCH c_act_tran INTO v_act_tran.apr_sta;
			 CLOSE c_act_tran;
			 
			        IF    v_act_tran.act_r_k IS NULL THEN 
                            v_err.err_cd := '-20026';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;

                    IF   v_act_tran.apr_sta = 1 THEN
			                v_err.err_cd := '-20027';
                            p_err_msg := v_err.err_msg; 
                         raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;
			 
			 
			     
			 
			 v_act_tran.r_k         := p_act_tran.r_k;
			 v_act_tran.cus_r_k     := p_act_tran.cus_r_k;
			 v_act_tran.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			 v_act_tran.sys_dtt     := SYSDATE;
			 v_act_tran.tran_desc   := p_act_tran.tran_desc;
			 v_act_tran.tran_amt    := p_act_tran.tran_amt;
			 v_act_tran.ref_no      := p_act_tran.ref_no;
             v_act_tran.mode_pymt   := p_act_tran.mode_pymt;

                 IF v_err.err_msg IS NULL THEN
                    
					UPDATE T_70_CUS_ACT_TRAN SET r_k = v_act_tran.r_k , cus_r_k = v_act_tran.cus_r_k , act_r_k = v_act_tran.act_r_k, 
					                            bus_dt = v_act_tran.bus_dt, sys_dtt = v_act_tran.sys_dtt, tran_desc = v_act_tran.tran_desc,
												tran_amt = v_act_tran.tran_amt , ref_no = v_act_tran.ref_no , mode_pymt = v_act_tran.mode_pymt
												WHERE r_k = v_act_tran.r_k ;
                 
				 END IF;
		 
              
         COMMIT;
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_CUS_ACT_TRAN_UPD;
    
     --- Customer Credit Approval
     PROCEDURE PC_70_CUS_ACT_TRAN_APR (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_act_tran  v_70_cus_act_tran%ROWTYPE;
         v_cus_act   v_70_cus_act%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;
		 
		  CURSOR c_cus_act_tran IS SELECT apr_sta, tran_amt FROM v_70_cus_act_tran WHERE r_k = p_act_tran.r_k AND apr_sta =0;
          CURSOR c_cus_act IS SELECT r_k, nvl(tran_bal,0) FROM v_70_cus_act WHERE cus_r_k = p_act_tran.cus_r_k AND apr_sta =1;
         BEGIN
		     
			 OPEN  c_cus_act_tran;
			 FETCH c_cus_act_tran INTO v_act_tran.apr_sta, v_act_tran.tran_amt;
			 CLOSE c_cus_act_tran;
             
             OPEN  c_cus_act;
			 FETCH c_cus_act INTO v_cus_act.r_k, v_cus_act.tran_bal;
			 CLOSE c_cus_act;
		 
			
			        IF    v_act_tran.apr_sta IS NULL THEN 
                            v_err.err_cd := '-20028';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;

			        IF    v_cus_act.r_k IS NULL THEN 
                            v_err.err_cd := '-20026';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;
			 
			     
			 
			     v_act_tran.r_k         := p_act_tran.r_k;
		         v_act_tran.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			     v_act_tran.sys_dtt     := SYSDATE;
			     v_act_tran.apr_by      := V('APP_USER');
			     v_act_tran.apr_dt      := SYSDATE;
				 v_act_tran.apr_sta     := 1;
                 v_act_tran.dr_cr       := p_act_tran.dr_cr;
                 
                
	             
			 
                 IF v_err.err_msg IS NULL THEN
                    
					UPDATE t_70_cus_act_tran SET  bus_dt = v_act_tran.bus_dt, sys_dtt = v_act_tran.sys_dtt, apr_sta = v_act_tran.apr_sta,
												apr_by = v_act_tran.apr_by ,apr_dt = v_act_tran.apr_dt 
												WHERE r_k = v_act_tran.r_k ;
                                                
                    IF v_act_tran.dr_cr = 'C' THEN 
                    UPDATE t_70_cus_act SET tran_bal = v_cus_act.tran_bal + v_act_tran.tran_amt, bus_dt = v_act_tran.bus_dt WHERE r_k = v_cus_act.r_k;
                    END IF;
                    
                    IF v_act_tran.dr_cr = 'D' THEN 
                    UPDATE t_70_cus_act SET tran_bal = v_cus_act.tran_bal - v_act_tran.tran_amt , bus_dt = v_act_tran.bus_dt WHERE r_k = v_cus_act.r_k;
                    END IF;
                    
				 END IF;
		 
              
        -- COMMIT;
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
           -- raise_application_error(v_err.err_cd ,p_err_msg);
    END PC_70_CUS_ACT_TRAN_APR;
    

     
     
END PK_70_CUS_ACT;

/
