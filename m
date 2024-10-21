Return-Path: <linux-spi+bounces-5275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A89A6748
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DC61F21975
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F0F1EBA05;
	Mon, 21 Oct 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ddEJEAzd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71F1EABDC;
	Mon, 21 Oct 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511834; cv=none; b=D0n82NVsXjuDZm4SFdab6pBY2rIaJK/qQhkp80Emas7I6TQDqn+917/ZiEvGrGlDZqXE7qS1TN1WGuA1iJCnELi5vVv6n+KHMvBHB/06IcO8g1ZsnxwQ1iplzX0sZypaZftz1Ke9Dcq5DdTa6vuuz5PPE2nq/qqctsZE8mU4fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511834; c=relaxed/simple;
	bh=51x3AcgNE6knN3JL4FV0VEN0tzQ5t0GhzuKmfzabkSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSjaPR9jdctRF+KNw5PqEdV+l7efZGWUyH/KzPVWAr4AK40SG+N9fd9raLneAh67Mw+32Mkk1y3WvD+K2yRfESzRHmBJlNkxiSRcB0AAD3HgyS3gaKT/tYaQbnI1o+V/xY8nRgRguY09Hl0CQQNpIA8dzb1Cd6kxQOVSGHcE1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ddEJEAzd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LA8DLQ028004;
	Mon, 21 Oct 2024 11:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8qARQ5ET4SVRLWZrOecbzoZkInWNkYpaQaAMmCZMiA=; b=ddEJEAzdyh1Pm2Bo
	qeT1UA72mmWdRaUtAEHaWo0y3pQsUlUXC7b6O9ekwTBBwBY1+Hi1mCOHi2K9SsIO
	6ZfbSdFkC9WgmIRIwtxMD+mOtRc6ALwRlnA2Hd9nmWZZbpfg9ZWF93lrBN9oQhzz
	oHK5z+Oxq+cVqT2sTVJ2MyJi+x7pWeVFe+2Q+PoDY5uNR3HY9tA00/rAYWnouvc+
	nJYSngPAfJ+YP29/QNlYjmDm2hwrCQ/sVB8W7Ul0L3CWF6P9ktkpAEhrta6IODcD
	ZvOOtGJ870t1XssIMyZyT3eBUL7f/H6dc+6l9UXk1wbnpwPUY4grePw6GlFM3F8F
	wzjhIA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc4mqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:56:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LBuuwn016501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:56:56 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 04:56:51 -0700
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
Subject: [PATCH v12 3/8] mtd: rawnand: qcom: Add qcom prefix to common api
Date: Mon, 21 Oct 2024 17:26:15 +0530
Message-ID: <20241021115620.1616617-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
References: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: -BdS078Mc7V91OFVOesFiG2mAxktyGjC
X-Proofpoint-ORIG-GUID: -BdS078Mc7V91OFVOesFiG2mAxktyGjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210085

Add qcom prefix to all the api which will be commonly
used by spi nand driver and raw nand driver.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v12]

* No change

Change in [v11]

* No change

Change in [v10]

* No change

Change in [v9]

* No change

Change in [v8]

* No change

Change in [v7]

* No change

Change in [v6]

* No change

Change in [v5]

* Add qcom_ prefix to all common API.

Change in [v4]

* This patch was not included in [v4]

Change in [v3]

* This patch was not included in [v3]

Change in [v2]

* This patch was not included in [v2]

Change in [v1]

* This patch was not included in [v1]

 drivers/mtd/nand/raw/qcom_nandc.c | 320 +++++++++++++++---------------
 1 file changed, 160 insertions(+), 160 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index d134329330fe..daf8f73b25bc 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -53,7 +53,7 @@
 #define	NAND_READ_LOCATION_LAST_CW_2	0xf48
 #define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
 
-/* dummy register offsets, used by write_reg_dma */
+/* dummy register offsets, used by qcom_write_reg_dma */
 #define	NAND_DEV_CMD1_RESTORE		0xdead
 #define	NAND_DEV_CMD_VLD_RESTORE	0xbeef
 
@@ -211,7 +211,7 @@
 
 /*
  * Flags used in DMA descriptor preparation helper functions
- * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
+ * (i.e. qcom_read_reg_dma/qcom_write_reg_dma/qcom_read_data_dma/qcom_write_data_dma)
  */
 /* Don't set the EOT in current tx BAM sgl */
 #define NAND_BAM_NO_EOT			BIT(0)
@@ -550,7 +550,7 @@ struct qcom_nandc_props {
 };
 
 /* Frees the BAM transaction memory */
-static void free_bam_transaction(struct qcom_nand_controller *nandc)
+static void qcom_free_bam_transaction(struct qcom_nand_controller *nandc)
 {
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
@@ -559,7 +559,7 @@ static void free_bam_transaction(struct qcom_nand_controller *nandc)
 
 /* Allocates and Initializes the BAM transaction */
 static struct bam_transaction *
-alloc_bam_transaction(struct qcom_nand_controller *nandc)
+qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc)
 {
 	struct bam_transaction *bam_txn;
 	size_t bam_txn_size;
@@ -595,7 +595,7 @@ alloc_bam_transaction(struct qcom_nand_controller *nandc)
 }
 
 /* Clears the BAM transaction indexes */
-static void clear_bam_transaction(struct qcom_nand_controller *nandc)
+static void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc)
 {
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
@@ -614,7 +614,7 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
 }
 
 /* Callback for DMA descriptor completion */
-static void qpic_bam_dma_done(void *data)
+static void qcom_qpic_bam_dma_done(void *data)
 {
 	struct bam_transaction *bam_txn = data;
 
@@ -644,7 +644,7 @@ static inline void nandc_write(struct qcom_nand_controller *nandc, int offset,
 	iowrite32(val, nandc->base + offset);
 }
 
-static inline void nandc_dev_to_mem(struct qcom_nand_controller *nandc, bool is_cpu)
+static inline void qcom_nandc_dev_to_mem(struct qcom_nand_controller *nandc, bool is_cpu)
 {
 	if (!nandc->props->supports_bam)
 		return;
@@ -824,9 +824,9 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
  * for BAM. This descriptor will be added in the NAND DMA descriptor queue
  * which will be submitted to DMA engine.
  */
-static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
-				  struct dma_chan *chan,
-				  unsigned long flags)
+static int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				       struct dma_chan *chan,
+				       unsigned long flags)
 {
 	struct desc_info *desc;
 	struct scatterlist *sgl;
@@ -903,9 +903,9 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
  * NAND_BAM_NEXT_SGL will be used for starting the separate SGL
  * after the current command element.
  */
-static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
-				 int reg_off, const void *vaddr,
-				 int size, unsigned int flags)
+static int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+				      int reg_off, const void *vaddr,
+				      int size, unsigned int flags)
 {
 	int bam_ce_size;
 	int i, ret;
@@ -943,9 +943,9 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 		bam_txn->bam_ce_start = bam_txn->bam_ce_pos;
 
 		if (flags & NAND_BAM_NWD) {
-			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
-						     DMA_PREP_FENCE |
-						     DMA_PREP_CMD);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->cmd_chan,
+							  DMA_PREP_FENCE |
+							  DMA_PREP_CMD);
 			if (ret)
 				return ret;
 		}
@@ -958,9 +958,8 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
  * Prepares the data descriptor for BAM DMA which will be used for NAND
  * data reads and writes.
  */
-static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
-				  const void *vaddr,
-				  int size, unsigned int flags)
+static int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+				       const void *vaddr, int size, unsigned int flags)
 {
 	int ret;
 	struct bam_transaction *bam_txn = nandc->bam_txn;
@@ -979,8 +978,8 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
 		 * is not set, form the DMA descriptor
 		 */
 		if (!(flags & NAND_BAM_NO_EOT)) {
-			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
-						     DMA_PREP_INTERRUPT);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->tx_chan,
+							  DMA_PREP_INTERRUPT);
 			if (ret)
 				return ret;
 		}
@@ -989,9 +988,9 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
 	return 0;
 }
 
-static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
-			     int reg_off, const void *vaddr, int size,
-			     bool flow_control)
+static int qcom_prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+				  int reg_off, const void *vaddr, int size,
+				  bool flow_control)
 {
 	struct desc_info *desc;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -1069,15 +1068,15 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
 }
 
 /*
- * read_reg_dma:	prepares a descriptor to read a given number of
+ * qcom_read_reg_dma:	prepares a descriptor to read a given number of
  *			contiguous registers to the reg_read_buf pointer
  *
  * @first:		offset of the first register in the contiguous block
  * @num_regs:		number of registers to read
  * @flags:		flags to control DMA descriptor preparation
  */
-static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
-			int num_regs, unsigned int flags)
+static int qcom_read_reg_dma(struct qcom_nand_controller *nandc, int first,
+			     int num_regs, unsigned int flags)
 {
 	bool flow_control = false;
 	void *vaddr;
@@ -1089,18 +1088,18 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
 		first = dev_cmd_reg_addr(nandc, first);
 
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
+		return qcom_prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
 					     num_regs, flags);
 
 	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
 		flow_control = true;
 
-	return prep_adm_dma_desc(nandc, true, first, vaddr,
+	return qcom_prep_adm_dma_desc(nandc, true, first, vaddr,
 				 num_regs * sizeof(u32), flow_control);
 }
 
 /*
- * write_reg_dma:	prepares a descriptor to write a given number of
+ * qcom_write_reg_dma:	prepares a descriptor to write a given number of
  *			contiguous registers
  *
  * @vaddr:		contnigeous memory from where register value will
@@ -1109,8 +1108,8 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
  * @num_regs:		number of registers to write
  * @flags:		flags to control DMA descriptor preparation
  */
-static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
-			 int first, int num_regs, unsigned int flags)
+static int qcom_write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
+			      int first, int num_regs, unsigned int flags)
 {
 	bool flow_control = false;
 
@@ -1124,18 +1123,18 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
 		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
 
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
+		return qcom_prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
 					     num_regs, flags);
 
 	if (first == NAND_FLASH_CMD)
 		flow_control = true;
 
-	return prep_adm_dma_desc(nandc, false, first, vaddr,
+	return qcom_prep_adm_dma_desc(nandc, false, first, vaddr,
 				 num_regs * sizeof(u32), flow_control);
 }
 
 /*
- * read_data_dma:	prepares a DMA descriptor to transfer data from the
+ * qcom_read_data_dma:	prepares a DMA descriptor to transfer data from the
  *			controller's internal buffer to the buffer 'vaddr'
  *
  * @reg_off:		offset within the controller's data buffer
@@ -1143,17 +1142,17 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
  * @size:		DMA transaction size in bytes
  * @flags:		flags to control DMA descriptor preparation
  */
-static int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
-			 const u8 *vaddr, int size, unsigned int flags)
+static int qcom_read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			      const u8 *vaddr, int size, unsigned int flags)
 {
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
+		return qcom_prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
 
-	return prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
+	return qcom_prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
 }
 
 /*
- * write_data_dma:	prepares a DMA descriptor to transfer data from
+ * qcom_write_data_dma:	prepares a DMA descriptor to transfer data from
  *			'vaddr' to the controller's internal buffer
  *
  * @reg_off:		offset within the controller's data buffer
@@ -1161,13 +1160,13 @@ static int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
  * @size:		DMA transaction size in bytes
  * @flags:		flags to control DMA descriptor preparation
  */
-static int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
-			  const u8 *vaddr, int size, unsigned int flags)
+static int qcom_write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			       const u8 *vaddr, int size, unsigned int flags)
 {
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
+		return qcom_prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
 
-	return prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
+	return qcom_prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
 }
 
 /*
@@ -1178,14 +1177,14 @@ static void config_nand_page_read(struct nand_chip *chip)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	write_reg_dma(nandc, &nandc->regs->addr0, NAND_ADDR0, 2, 0);
-	write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
 	if (!nandc->props->qpic_version2)
-		write_reg_dma(nandc, &nandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1, 0);
-	write_reg_dma(nandc, &nandc->regs->erased_cw_detect_cfg_clr,
-		      NAND_ERASED_CW_DETECT_CFG, 1, 0);
-	write_reg_dma(nandc, &nandc->regs->erased_cw_detect_cfg_set,
-		      NAND_ERASED_CW_DETECT_CFG, 1, NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->erased_cw_detect_cfg_clr,
+			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->erased_cw_detect_cfg_set,
+			   NAND_ERASED_CW_DETECT_CFG, 1, NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1204,17 +1203,17 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
 		reg = &nandc->regs->read_location_last0;
 
 	if (nandc->props->supports_bam)
-		write_reg_dma(nandc, reg, NAND_READ_LOCATION_0, 4, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, reg, NAND_READ_LOCATION_0, 4, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
 	if (use_ecc) {
-		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
-		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-			     NAND_BAM_NEXT_SGL);
+		qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
+		qcom_read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
 	} else {
-		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+		qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 	}
 }
 
@@ -1238,11 +1237,11 @@ static void config_nand_page_write(struct nand_chip *chip)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	write_reg_dma(nandc, &nandc->regs->addr0, NAND_ADDR0, 2, 0);
-	write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
 	if (!nandc->props->qpic_version2)
-		write_reg_dma(nandc, &nandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1,
-			      NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1,
+				   NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1253,17 +1252,18 @@ static void config_nand_cw_write(struct nand_chip *chip)
 {
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, &nandc->regs->clrflashstatus, NAND_FLASH_STATUS, 1, 0);
-	write_reg_dma(nandc, &nandc->regs->clrreadstatus, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->clrflashstatus, NAND_FLASH_STATUS, 1, 0);
+	qcom_write_reg_dma(nandc, &nandc->regs->clrreadstatus, NAND_READ_STATUS, 1,
+			   NAND_BAM_NEXT_SGL);
 }
 
 /* helpers to submit/free our list of dma descriptors */
-static int submit_descs(struct qcom_nand_controller *nandc)
+static int qcom_submit_descs(struct qcom_nand_controller *nandc)
 {
 	struct desc_info *desc, *n;
 	dma_cookie_t cookie = 0;
@@ -1272,21 +1272,21 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 
 	if (nandc->props->supports_bam) {
 		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
 			if (ret)
 				goto err_unmap_free_desc;
 		}
 
 		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
-						   DMA_PREP_INTERRUPT);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->tx_chan,
+							  DMA_PREP_INTERRUPT);
 			if (ret)
 				goto err_unmap_free_desc;
 		}
 
 		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
-			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
-						   DMA_PREP_CMD);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->cmd_chan,
+							  DMA_PREP_CMD);
 			if (ret)
 				goto err_unmap_free_desc;
 		}
@@ -1296,7 +1296,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		cookie = dmaengine_submit(desc->dma_desc);
 
 	if (nandc->props->supports_bam) {
-		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback = qcom_qpic_bam_dma_done;
 		bam_txn->last_cmd_desc->callback_param = bam_txn;
 
 		dma_async_issue_pending(nandc->tx_chan);
@@ -1314,7 +1314,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 err_unmap_free_desc:
 	/*
 	 * Unmap the dma sg_list and free the desc allocated by both
-	 * prepare_bam_async_desc() and prep_adm_dma_desc() functions.
+	 * qcom_prepare_bam_async_desc() and qcom_prep_adm_dma_desc() functions.
 	 */
 	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
 		list_del(&desc->node);
@@ -1333,10 +1333,10 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 }
 
 /* reset the register read buffer for next NAND operation */
-static void clear_read_regs(struct qcom_nand_controller *nandc)
+static void qcom_clear_read_regs(struct qcom_nand_controller *nandc)
 {
 	nandc->reg_read_pos = 0;
-	nandc_dev_to_mem(nandc, false);
+	qcom_nandc_dev_to_mem(nandc, false);
 }
 
 /*
@@ -1400,7 +1400,7 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int i;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < cw_cnt; i++) {
 		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -1427,13 +1427,13 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_version2)
 		raw_cw = ecc->steps - 1;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	set_address(host, host->cw_size * cw, page);
 	update_rw_regs(host, 1, true, raw_cw);
 	config_nand_page_read(chip);
@@ -1466,18 +1466,18 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 
 	config_nand_cw_read(chip, false, raw_cw);
 
-	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
+	qcom_read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
 
-	read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
+	qcom_read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
 	reg_off += oob_size1;
 
-	read_data_dma(nandc, reg_off, data_buf + data_size1, data_size2, 0);
+	qcom_read_data_dma(nandc, reg_off, data_buf + data_size1, data_size2, 0);
 	reg_off += data_size2;
 
-	read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
+	qcom_read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read raw cw %d\n", cw);
 		return ret;
@@ -1575,7 +1575,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < ecc->steps; i++, buf++) {
 		u32 flash, buffer, erased_cw;
@@ -1704,8 +1704,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		config_nand_cw_read(chip, true, i);
 
 		if (data_buf)
-			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
-				      data_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
+					   data_size, 0);
 
 		/*
 		 * when ecc is enabled, the controller doesn't read the real
@@ -1720,8 +1720,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			for (j = 0; j < host->bbm_size; j++)
 				*oob_buf++ = 0xff;
 
-			read_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				      oob_buf, oob_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					   oob_buf, oob_size, 0);
 		}
 
 		if (data_buf)
@@ -1730,7 +1730,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
 		return ret;
@@ -1751,7 +1751,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	int size;
 	int ret;
 
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 
 	size = host->use_ecc ? host->cw_data : host->cw_size;
 
@@ -1763,9 +1763,9 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 
 	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - 1);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret)
 		dev_err(nandc->dev, "failed to copy last codeword\n");
 
@@ -1851,14 +1851,14 @@ static int qcom_nandc_read_page(struct nand_chip *chip, u8 *buf,
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = true;
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true, 0);
 
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	return read_page_ecc(host, data_buf, oob_buf, page);
 }
@@ -1899,8 +1899,8 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	host->use_ecc = true;
 	set_address(host, 0, page);
@@ -1927,8 +1927,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 	set_address(host, 0, page);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -1949,8 +1949,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 			oob_size = ecc->bytes;
 		}
 
-		write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
-			       i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
+		qcom_write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
+				    i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
 
 		/*
 		 * when ECC is enabled, we don't really need to write anything
@@ -1962,8 +1962,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		if (qcom_nandc_is_last_cw(ecc, i)) {
 			oob_buf += host->bbm_size;
 
-			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				       oob_buf, oob_size, 0);
+			qcom_write_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					    oob_buf, oob_size, 0);
 		}
 
 		config_nand_cw_write(chip);
@@ -1972,7 +1972,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write page\n");
 		return ret;
@@ -1997,8 +1997,8 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		qcom_nandc_codeword_fixup(host, page);
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -2024,28 +2024,28 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
 		}
 
-		write_data_dma(nandc, reg_off, data_buf, data_size1,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, data_buf, data_size1,
+				    NAND_BAM_NO_EOT);
 		reg_off += data_size1;
 		data_buf += data_size1;
 
-		write_data_dma(nandc, reg_off, oob_buf, oob_size1,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, oob_buf, oob_size1,
+				    NAND_BAM_NO_EOT);
 		reg_off += oob_size1;
 		oob_buf += oob_size1;
 
-		write_data_dma(nandc, reg_off, data_buf, data_size2,
-			       NAND_BAM_NO_EOT);
+		qcom_write_data_dma(nandc, reg_off, data_buf, data_size2,
+				    NAND_BAM_NO_EOT);
 		reg_off += data_size2;
 		data_buf += data_size2;
 
-		write_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
+		qcom_write_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
 		oob_buf += oob_size2;
 
 		config_nand_cw_write(chip);
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write raw page\n");
 		return ret;
@@ -2075,7 +2075,7 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 		qcom_nandc_codeword_fixup(host, page);
 
 	host->use_ecc = true;
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
@@ -2090,11 +2090,11 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	update_rw_regs(host, 1, false, 0);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, data_size + oob_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC,
+			    nandc->data_buffer, data_size + oob_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write oob\n");
 		return ret;
@@ -2121,7 +2121,7 @@ static int qcom_nandc_block_bad(struct nand_chip *chip, loff_t ofs)
 	 */
 	host->use_ecc = false;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	ret = copy_last_cw(host, page);
 	if (ret)
 		goto err;
@@ -2148,8 +2148,8 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/*
 	 * to mark the BBM as bad, we flash the entire last codeword with 0s.
@@ -2166,11 +2166,11 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	update_rw_regs(host, 1, false, ecc->steps - 1);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, host->cw_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC,
+			    nandc->data_buffer, host->cw_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to update BBM\n");
 		return ret;
@@ -2410,14 +2410,14 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
 	/* Free the initially allocated BAM transaction for reading the ONFI params */
 	if (nandc->props->supports_bam)
-		free_bam_transaction(nandc);
+		qcom_free_bam_transaction(nandc);
 
 	nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
 				     cwperpage);
 
 	/* Now allocate the BAM transaction based on updated max_cwperpage */
 	if (nandc->props->supports_bam) {
-		nandc->bam_txn = alloc_bam_transaction(nandc);
+		nandc->bam_txn = qcom_alloc_bam_transaction(nandc);
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
@@ -2617,7 +2617,7 @@ static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
 	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
 	u32 flash;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	do {
 		flash = le32_to_cpu(nandc->reg_read_buf[0]);
@@ -2657,23 +2657,23 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->exec = cpu_to_le32(1);
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting status descriptor\n");
 		goto err_out;
 	}
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < num_cw; i++) {
 		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -2714,8 +2714,8 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = q_op.addr1_reg;
@@ -2723,12 +2723,12 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->regs->chip_sel = cpu_to_le32(nandc->props->supports_bam ? 0 : DM_EN);
 	nandc->regs->exec = cpu_to_le32(1);
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting read id descriptor\n");
 		goto err_out;
@@ -2738,7 +2738,7 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
 
 err_out:
@@ -2774,20 +2774,20 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->exec = cpu_to_le32(1);
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
 	if (q_op.cmd_reg == cpu_to_le32(OP_BLOCK_ERASE))
-		write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->cfg0, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
 
-	write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting misc descriptor\n");
 		goto err_out;
@@ -2820,8 +2820,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = false;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = 0;
@@ -2864,8 +2864,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
 
 	if (!nandc->props->qpic_version2) {
-		write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
-		write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
+		qcom_write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
 	nandc->buf_count = len;
@@ -2873,17 +2873,17 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 
 	config_nand_single_cw_page_read(chip, false, 0);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
-		      nandc->buf_count, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
+			   nandc->buf_count, 0);
 
 	/* restore CMD1 and VLD regs */
 	if (!nandc->props->qpic_version2) {
-		write_reg_dma(nandc, &nandc->regs->orig_cmd1, NAND_DEV_CMD1_RESTORE, 1, 0);
-		write_reg_dma(nandc, &nandc->regs->orig_vld, NAND_DEV_CMD_VLD_RESTORE, 1,
-			      NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->orig_cmd1, NAND_DEV_CMD1_RESTORE, 1, 0);
+		qcom_write_reg_dma(nandc, &nandc->regs->orig_vld, NAND_DEV_CMD_VLD_RESTORE, 1,
+				   NAND_BAM_NEXT_SGL);
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure in submitting param page descriptor\n");
 		goto err_out;
@@ -3067,7 +3067,7 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		 * maximum codeword size
 		 */
 		nandc->max_cwperpage = 1;
-		nandc->bam_txn = alloc_bam_transaction(nandc);
+		nandc->bam_txn = qcom_alloc_bam_transaction(nandc);
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
-- 
2.34.1


