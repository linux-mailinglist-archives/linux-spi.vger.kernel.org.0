Return-Path: <linux-spi+bounces-4243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD79584FD
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946931C21419
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511F18EFDE;
	Tue, 20 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="my8qTOW8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20318EFD4;
	Tue, 20 Aug 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150627; cv=none; b=UgMSqKIJ10befGdf+e5Oz1uWFcOJWb525MkNTn86pBGUiZ6ZwNisQec4Cau4sLzAB6cr/0cg9nrVgkIBrV5dBiXlFnbB4l3gJ4zIPFlFZtk9XXbGY67O2sNYcCbsrAG/iNfZR2IRgU5qbf250g1leTzMvi+DzDLi/Ew6WhIoH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150627; c=relaxed/simple;
	bh=GkJGWJoXGExsWRURYz+l1/e33wZ+o5QUhQ6IuFb945U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlzrtdHxSj4OCYOyP1BMDxDIvJA2SX6/2JEDdBEm/mk1g3nR/4Sd8R6rU9CQPGt1WDsfH9m5zAFvY0crcokOsCSelB6inNVOyHzJAfwcwjtvlrKhoXNNG92NctFVuJGiDozv0/QBXKtM94Fu1+B5woQWBSlYsWSUmLqLBERnpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=my8qTOW8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KAUXOt000881;
	Tue, 20 Aug 2024 10:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYh39Rl3X7c4nIKoF0TntCWSkCJIszdjJNKJ9w9ROjE=; b=my8qTOW8evs+y/yt
	R9NLtAdNDRq0vPXXz83rZmwtgWqyu/2HFz+OUS7WFRoFtC4KCMN96SdmNCN9U/DA
	waHA5rS5wvWtWlBcoJ+OoRLDlH3zJ1Wnbvg1rmp44DtIBnMK/Jo0Uvid24QzKDFh
	f4z25vWGiewHgqYrJO/DpLluEqAkKbW9LAomjP2BdbNKu/ycDFksvp8Oe4mx0mab
	OhoBPXALvTyT++dZLRc5txVHTV+xXr0VkMpmBIPfcVDIxf2imOmzfcvNhAcm8yDV
	6bc6UhqsvF9U8a1S/0Ck3w7nDtEjtLW9nR4tNvMhZPxO8PQbbRNkU88lKAOc7sBT
	ApPtjA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4145ywb75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KAhLUm024811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:21 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 03:43:16 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH v8 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
Date: Tue, 20 Aug 2024 16:12:36 +0530
Message-ID: <20240820104239.1774600-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vCz5lVXFcKUIBC7MzkgbiZqpguga6tjU
X-Proofpoint-GUID: vCz5lVXFcKUIBC7MzkgbiZqpguga6tjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200079

Use the bitfield macro FIELD_PREP, and GENMASK to
do the shift and mask in one go. This makes the code
more readable.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
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
index 01583535bc81..087e1188fc68 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -276,7 +276,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 				(num_cw - 1) << CW_PER_PAGE;
 
 		cfg1 = host->cfg1_raw;
-		ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+		ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 	}
 
 	nandc->regs->cmd = cmd;
@@ -1487,42 +1487,41 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
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
@@ -1876,21 +1875,21 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->regs->addr0 = 0;
 	nandc->regs->addr1 = 0;
 
-	nandc->regs->cfg0 = 0 << CW_PER_PAGE
-			    | 512 << UD_SIZE_BYTES
-			    | 5 << NUM_ADDR_CYCLES
-			    | 0 << SPARE_SIZE_BYTES;
+	host->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, 0) |
+		     FIELD_PREP(UD_SIZE_BYTES_MASK, 512) |
+		     FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
+		     FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
 
-	nandc->regs->cfg1 = 7 << NAND_RECOVERY_CYCLES
-			    | 0 << CS_ACTIVE_BSY
-			    | 17 << BAD_BLOCK_BYTE_NUM
-			    | 1 << BAD_BLOCK_IN_SPARE_AREA
-			    | 2 << WR_RD_BSY_GAP
-			    | 0 << WIDE_FLASH
-			    | 1 << DEV0_CFG1_ECC_DISABLE;
+	host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
+		     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
+		     FIELD_PREP(CS_ACTIVE_BSY, 0) |
+		     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
+		     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
+		     FIELD_PREP(WIDE_FLASH, 0) |
+		     FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
 
 	if (!nandc->props->qpic_version2)
-		nandc->regs->ecc_buf_cfg = 1 << ECC_CFG_ECC_DISABLE;
+		nandc->regs->ecc_buf_cfg = ECC_CFG_ECC_DISABLE;
 
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


