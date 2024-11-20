Return-Path: <linux-spi+bounces-5773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD49D36AF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE9284543
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21419E806;
	Wed, 20 Nov 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IiHYByPq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86E19CCF5;
	Wed, 20 Nov 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094166; cv=none; b=kRCTJ4ep111z4jBESSHUxQ0sbJFgAeuDRnS0G/5Ngfr869AIExMBs29o05RDvoiyvJKLW5Jt8bKj20l+KXroTYN6SXFb4GGIMuSqajwMl2mKpmcxg/JFWtAxDPn+59E6Ah7WLhv1qIdirtEQFqu60mNRXqUX0W7mgCI4DOmRZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094166; c=relaxed/simple;
	bh=B5xrmpkKdFLGwnFjwgns2G9pKLX9GG6muCbzuO95pdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlr+2xgemJRTmeLI5fb6cY+5yuJlpwNoB09AQuDd6pwZRXPrkmdT+LLkHZ/yKM6moj9uhrj/f2rIqC5XxsqWAivzZlde3QhkddAch5YXN5O//WKVxba/FQxbMt2TpqY6X7H90jWgejLQeSnn6M8qqO2GuEisPouF8u+px2Y2FSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IiHYByPq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FR3B007912;
	Wed, 20 Nov 2024 09:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXNAFG3dShPn4Zw1SHGYPtMvs5c6OBQ5IChzsgg3U3c=; b=IiHYByPq4xIbsmNw
	G81FRh7I8dya+jsmgoesy1H2oEJHv1Rm4FecpblhnuAEEj5UM/BOcxN+Lw92GB4G
	HNi9EEEjSTexNITMUsslLm3cODQ4jibaNIioOZWTzrJuug2hg1HZorUDQgst1a5N
	jJi1oMpEJLOC8YuacxnvD0fGMNXLXm06y2/DYbPp0ztLSPkm+FCEGSPxSI3FzZCm
	jmOu+Ix5XVKronpXlyjqL9y2otghFjz7yg7qCnc4NSdKbaiSP5paANBqSNjyN72A
	ZNCH7MvTsnsNECogen+eRybQC8DJodV2M+3HkKyUAuN84TTz9ou9EmigqfWHl0MG
	I6wmqg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4318uvgm7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:15:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK9Fr4r025537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:15:53 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 01:15:48 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>
Subject: [PATCH v14 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
Date: Wed, 20 Nov 2024 14:45:03 +0530
Message-ID: <20241120091507.1404368-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zi5Ny2NB-px240dsXzghcuodg5Z0ygg0
X-Proofpoint-GUID: zi5Ny2NB-px240dsXzghcuodg5Z0ygg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200064

Use the bitfield macro FIELD_PREP, and GENMASK to
do the shift and mask in one go. This makes the code
more readable.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v14]

* No change

Change in [v13]

* Added Reviewed-by tag

Change in [v12]

* No change

Change in [v11]

* No change

Change in [v10]

* No change

Change in [v9]

* In update_rw_regs() api added cpu_to_le32() macro to fix compilation
  issue reported by kernel test bot
* In qcom_param_page_type_exec() api added cpu_to_le32() macro to fix
  compilation issue reported by kernel test bot  

Change in [v8]

* No change

Change in [v7]

* No change

Change in [v6]

* Added FIELD_PREP() and GENMASK() macro

Change in [v5]

* This patch was not included in [v1]

Change in [v4]

* This patch was not included in [v4]

Change in [v3]

* This patch was not included in [v3]

Change in [v2]

* This patch was not included in [v2]

Change in [v1]

* This patch was not included in [v1]

 drivers/mtd/nand/raw/qcom_nandc.c    | 97 ++++++++++++++--------------
 include/linux/mtd/nand-qpic-common.h | 31 +++++----
 2 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index dcb62fd19dd7..d2d2aeee42a7 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -281,7 +281,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 				(num_cw - 1) << CW_PER_PAGE);
 
 		cfg1 = cpu_to_le32(host->cfg1_raw);
-		ecc_bch_cfg = cpu_to_le32(1 << ECC_CFG_ECC_DISABLE);
+		ecc_bch_cfg = cpu_to_le32(ECC_CFG_ECC_DISABLE);
 	}
 
 	nandc->regs->cmd = cmd;
@@ -1494,42 +1494,41 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	host->cw_size = host->cw_data + ecc->bytes;
 	bad_block_byte = mtd->writesize - host->cw_size * (cwperpage - 1) + 1;
 
-	host->cfg0 = (cwperpage - 1) << CW_PER_PAGE
-				| host->cw_data << UD_SIZE_BYTES
-				| 0 << DISABLE_STATUS_AFTER_WRITE
-				| 5 << NUM_ADDR_CYCLES
-				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
-				| 0 << STATUS_BFR_READ
-				| 1 << SET_RD_MODE_AFTER_STATUS
-				| host->spare_bytes << SPARE_SIZE_BYTES;
-
-	host->cfg1 = 7 << NAND_RECOVERY_CYCLES
-				| 0 <<  CS_ACTIVE_BSY
-				| bad_block_byte << BAD_BLOCK_BYTE_NUM
-				| 0 << BAD_BLOCK_IN_SPARE_AREA
-				| 2 << WR_RD_BSY_GAP
-				| wide_bus << WIDE_FLASH
-				| host->bch_enabled << ENABLE_BCH_ECC;
-
-	host->cfg0_raw = (cwperpage - 1) << CW_PER_PAGE
-				| host->cw_size << UD_SIZE_BYTES
-				| 5 << NUM_ADDR_CYCLES
-				| 0 << SPARE_SIZE_BYTES;
-
-	host->cfg1_raw = 7 << NAND_RECOVERY_CYCLES
-				| 0 << CS_ACTIVE_BSY
-				| 17 << BAD_BLOCK_BYTE_NUM
-				| 1 << BAD_BLOCK_IN_SPARE_AREA
-				| 2 << WR_RD_BSY_GAP
-				| wide_bus << WIDE_FLASH
-				| 1 << DEV0_CFG1_ECC_DISABLE;
-
-	host->ecc_bch_cfg = !host->bch_enabled << ECC_CFG_ECC_DISABLE
-				| 0 << ECC_SW_RESET
-				| host->cw_data << ECC_NUM_DATA_BYTES
-				| 1 << ECC_FORCE_CLK_OPEN
-				| ecc_mode << ECC_MODE
-				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
+	host->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
+		     FIELD_PREP(UD_SIZE_BYTES_MASK, host->cw_data) |
+		     FIELD_PREP(DISABLE_STATUS_AFTER_WRITE, 0) |
+		     FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
+		     FIELD_PREP(ECC_PARITY_SIZE_BYTES_RS, host->ecc_bytes_hw) |
+		     FIELD_PREP(STATUS_BFR_READ, 0) |
+		     FIELD_PREP(SET_RD_MODE_AFTER_STATUS, 1) |
+		     FIELD_PREP(SPARE_SIZE_BYTES_MASK, host->spare_bytes);
+
+	host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
+		     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, bad_block_byte) |
+		     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 0) |
+		     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
+		     FIELD_PREP(WIDE_FLASH, wide_bus) |
+		     FIELD_PREP(ENABLE_BCH_ECC, host->bch_enabled);
+
+	host->cfg0_raw = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
+			 FIELD_PREP(UD_SIZE_BYTES_MASK, host->cw_size) |
+			 FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
+			 FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
+
+	host->cfg1_raw = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
+			 FIELD_PREP(CS_ACTIVE_BSY, 0) |
+			 FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
+			 FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
+			 FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
+			 FIELD_PREP(WIDE_FLASH, wide_bus) |
+			 FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
+
+	host->ecc_bch_cfg = FIELD_PREP(ECC_CFG_ECC_DISABLE, !host->bch_enabled) |
+			    FIELD_PREP(ECC_SW_RESET, 0) |
+			    FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, host->cw_data) |
+			    FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
+			    FIELD_PREP(ECC_MODE_MASK, ecc_mode) |
+			    FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, host->ecc_bytes_hw);
 
 	if (!nandc->props->qpic_version2)
 		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
@@ -1882,21 +1881,21 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->regs->addr0 = 0;
 	nandc->regs->addr1 = 0;
 
-	nandc->regs->cfg0 = cpu_to_le32(0 << CW_PER_PAGE |
-					512 << UD_SIZE_BYTES |
-					5 << NUM_ADDR_CYCLES |
-					0 << SPARE_SIZE_BYTES);
+	host->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, 0) |
+		     FIELD_PREP(UD_SIZE_BYTES_MASK, 512) |
+		     FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
+		     FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
 
-	nandc->regs->cfg1 = cpu_to_le32(7 << NAND_RECOVERY_CYCLES |
-					0 << CS_ACTIVE_BSY |
-					17 << BAD_BLOCK_BYTE_NUM |
-					1 << BAD_BLOCK_IN_SPARE_AREA |
-					2 << WR_RD_BSY_GAP |
-					0 << WIDE_FLASH |
-					1 << DEV0_CFG1_ECC_DISABLE);
+	host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
+		     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
+		     FIELD_PREP(CS_ACTIVE_BSY, 0) |
+		     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
+		     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
+		     FIELD_PREP(WIDE_FLASH, 0) |
+		     FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
 
 	if (!nandc->props->qpic_version2)
-		nandc->regs->ecc_buf_cfg = cpu_to_le32(1 << ECC_CFG_ECC_DISABLE);
+		nandc->regs->ecc_buf_cfg = cpu_to_le32(ECC_CFG_ECC_DISABLE);
 
 	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
 	if (!nandc->props->qpic_version2) {
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index 425994429387..e79c79775eb8 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -70,35 +70,42 @@
 #define	BS_CORRECTABLE_ERR_MSK		0x1f
 
 /* NAND_DEVn_CFG0 bits */
-#define	DISABLE_STATUS_AFTER_WRITE	4
+#define	DISABLE_STATUS_AFTER_WRITE	BIT(4)
 #define	CW_PER_PAGE			6
+#define	CW_PER_PAGE_MASK		GENMASK(8, 6)
 #define	UD_SIZE_BYTES			9
 #define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
-#define	ECC_PARITY_SIZE_BYTES_RS	19
+#define	ECC_PARITY_SIZE_BYTES_RS	GENMASK(22, 19)
 #define	SPARE_SIZE_BYTES		23
 #define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
 #define	NUM_ADDR_CYCLES			27
-#define	STATUS_BFR_READ			30
-#define	SET_RD_MODE_AFTER_STATUS	31
+#define	NUM_ADDR_CYCLES_MASK		GENMASK(29, 27)
+#define	STATUS_BFR_READ			BIT(30)
+#define	SET_RD_MODE_AFTER_STATUS	BIT(31)
 
 /* NAND_DEVn_CFG0 bits */
-#define	DEV0_CFG1_ECC_DISABLE		0
-#define	WIDE_FLASH			1
+#define	DEV0_CFG1_ECC_DISABLE		BIT(0)
+#define	WIDE_FLASH			BIT(1)
 #define	NAND_RECOVERY_CYCLES		2
-#define	CS_ACTIVE_BSY			5
+#define	NAND_RECOVERY_CYCLES_MASK	GENMASK(4, 2)
+#define	CS_ACTIVE_BSY			BIT(5)
 #define	BAD_BLOCK_BYTE_NUM		6
-#define	BAD_BLOCK_IN_SPARE_AREA		16
+#define	BAD_BLOCK_BYTE_NUM_MASK		GENMASK(15, 6)
+#define	BAD_BLOCK_IN_SPARE_AREA		BIT(16)
 #define	WR_RD_BSY_GAP			17
-#define	ENABLE_BCH_ECC			27
+#define	WR_RD_BSY_GAP_MASK		GENMASK(22, 17)
+#define	ENABLE_BCH_ECC			BIT(27)
 
 /* NAND_DEV0_ECC_CFG bits */
-#define	ECC_CFG_ECC_DISABLE		0
-#define	ECC_SW_RESET			1
+#define	ECC_CFG_ECC_DISABLE		BIT(0)
+#define	ECC_SW_RESET			BIT(1)
 #define	ECC_MODE			4
+#define	ECC_MODE_MASK			GENMASK(5, 4)
 #define	ECC_PARITY_SIZE_BYTES_BCH	8
+#define	ECC_PARITY_SIZE_BYTES_BCH_MASK	GENMASK(12, 8)
 #define	ECC_NUM_DATA_BYTES		16
 #define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
-#define	ECC_FORCE_CLK_OPEN		30
+#define	ECC_FORCE_CLK_OPEN		BIT(30)
 
 /* NAND_DEV_CMD1 bits */
 #define	READ_ADDR			0
-- 
2.34.1


