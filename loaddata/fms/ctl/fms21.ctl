LOAD DATA 
    CHARACTERSET ZHS16GBK 
    TRUNCATE INTO TABLE TID_AP_INVOICE_TMP 
    WHEN (1:3)<>'|||' 
    FIELDS TERMINATED BY ' | ' 
    TRAILING NULLCOLS
(
	SEQ_NO                     "trim(:SEQ_NO)",
	FILLER_2                   FILLER,
	INVOICE_TYPE               "trim(:INVOICE_TYPE)",
	INVOICE_NO                 "trim(:INVOICE_NO)",
	FILLER_5                   FILLER,
	FILLER_6                   FILLER,
	FILLER_7                   FILLER,
	GL_DATE                    "trim(:GL_DATE)",
	FILLER_9                   FILLER,
	PROVIDER_CODE              "trim(:PROVIDER_CODE)",
	PROVIDER_NAME              "trim(:PROVIDER_NAME)",
	PROVIDER_ADDR_CODE         "trim(:PROVIDER_ADDR_CODE)",
	PROVIDER_ADDR_NAME         "trim(:PROVIDER_ADDR_NAME)",
	FILLER_14                   FILLER,
	FILLER_15                   FILLER,
	INVOICE_AMT                "trim(:INVOICE_AMT)",
	FILLER_17                   FILLER,
	INVOICE_CANCEL_STATE       "trim(:INVOICE_CANCEL_STATE)",
	INVOICE_CANCEL_DATE        "trim(:INVOICE_CANCEL_DATE)",
	PAY_WAY                    "trim(:PAY_WAY)",
	FILLER_21                   FILLER,
	FILLER_22                   FILLER,
	CNT_NUM                    "trim(:CNT_NUM)",
	PAY_ID                     "trim(:PAY_ID)",
	IAP_PROVIDER_NAME          "trim(:IAP_PROVIDER_NAME)",
	FILLER_26                   FILLER,
	FILLER_27                   FILLER,
	FILLER_28                   FILLER,
	IAP_ACT_NO                 "trim(:IAP_ACT_NO)",
	FILLER_30                   FILLER,
	IVROW_SEQNO                "trim(:IVROW_SEQNO)",
	INVOICE_ROW_TYPE           "trim(:INVOICE_ROW_TYPE)",
	IVROW_AMT                  "trim(:IVROW_AMT)",
	FILLER_34                   FILLER,
	INVOICE_IVROW_STATE        "trim(:INVOICE_IVROW_STATE)",
	CANCEL_INVOICE_ID          "trim(:CANCEL_INVOICE_ID)",
	FILLER_37                   FILLER,
	FEE_DEPT                   "trim(:FEE_DEPT)",
	CGL_CODE                   "trim(:CGL_CODE)",
	REFERENCE                  "trim(:REFERENCE)",
	FILLER_42                   FILLER,
	FILLER_43                   FILLER,
	SPECIAL                    "trim(:SPECIAL)",
	FILLER_44                   FILLER,
	FILLER_45                   FILLER,
	PO_NUMBER                  "trim(:PO_NUMBER)",
	PO_LINENO                  "trim(:PO_LINENO)",
	FILLER_48                   FILLER,
	FILLER_49                   FILLER,
	FILLER_50                   FILLER,
	FILLER_51                   FILLER,
	FILLER_52                   FILLER,
	FILLER_53                   FILLER,
	FILLER_54                   FILLER,
	FILLER_55                   FILLER,
	FILLER_56                   FILLER,
	FILLER_57                   FILLER,
	FILLER_58                   FILLER,
	FILLER_59                   FILLER,
	FILLER_60                   FILLER
)
