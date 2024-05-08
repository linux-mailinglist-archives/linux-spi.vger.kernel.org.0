Return-Path: <linux-spi+bounces-2775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61E8BF8B1
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3260E285B28
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D2853E34;
	Wed,  8 May 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UvZaEocb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A454F8A;
	Wed,  8 May 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157437; cv=none; b=udw4R3rchyoVkSc+0l2SCDD+VB7ilei0iPuMBkitSvDw/LTxx7KO1tdnUGqQvnprjt84hNMfiUSds0hSZBJBAUU6FsFS5PzdstA+ZpcL1mdqZbtn2vgN8P/4yfUYzCrExg002+Br3INTxiQtfuCIPKD67Vx4wdTEoz0+xsihnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157437; c=relaxed/simple;
	bh=vDFjQ7BcZGAK1iu0delXWBX6h4SGx5UaKqCwfWofCW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULs7FZSU/WdaQuBZ5OK2cr/XdQB+H+LLV7ABDHYe6JnejG7c3RBWopuWqbsgytbMNMFnBagwzcanV98NhoBqWGbLoR/0w9J28LA9sv5Gk90BITQmFBEd23TnzWGw45kMx6E0LEvnDM7YVe3+JSCsb6z9K1z/XTLNFgjVUKyaZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UvZaEocb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44859Co3027437;
	Wed, 8 May 2024 08:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=hcEu2UT
	ZkgqLfLmgLZ2GWe7odf/oifasXb5MTzJKiJ4=; b=UvZaEocbf4DC9+Qm2p2Rmgn
	Tj8z8itSkbcFzF3IkPd8Ql7ms52h3mv1/0FVaRejzCK1T8TehXwjrlWc1CRQ25oA
	u3cg35TOdoZZ/RRN4UpZwtat1VQPtHeVkQl5QUw6tWZZmNK4YL88TH3cTznHoxSy
	exhmHrLYjepkz/S+lXxOJGHBymdVSy2aMzF8eq8p690tRJJFj3gxo0cd3ha1SCSL
	bnfDNFJUF/HaLVecHwtqbGsaclycsq9hprPZQdW+cIuiwBSXnypi7JuOCUM+cuDo
	zkpAg050+Aczftxpgngmg8CUpbY4PEapSFB7Ll/kzXzk8WuIxvrnUnw61NjmnZw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg8scxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4488af2a001207;
	Wed, 8 May 2024 08:36:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xwe3kwch5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:41 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4488aeGe001174;
	Wed, 8 May 2024 08:36:41 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4488aeFc001171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:40 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 13E71415E8; Wed,  8 May 2024 14:06:40 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com
Subject: [PATCH v5 3/7] mtd: rawnand: qcom: Add qcom prefix to common api
Date: Wed,  8 May 2024 14:06:33 +0530
Message-Id: <20240508083637.3744003-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j9JQ7DWVLT4FES-o2d47eD-FJ4Gcdg5c
X-Proofpoint-ORIG-GUID: j9JQ7DWVLT4FES-o2d47eD-FJ4Gcdg5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080060

Add qcom prefix to all the api which will be commonly
used by spi nand driver and raw nand driver.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
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

 drivers/mtd/nand/raw/qcom_nandc.c | 322 +++++++++++++++---------------
 1 file changed, 159 insertions(+), 163 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 6c886a72f5e4..d958b8fb5b68 100644
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
@@ -817,9 +817,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
  * for BAM. This descriptor will be added in the NAND DMA descriptor queue
  * which will be submitted to DMA engine.
  */
-static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
-				  struct dma_chan *chan,
-				  unsigned long flags)
+static int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				       struct dma_chan *chan, unsigned long flags)
 {
 	struct desc_info *desc;
 	struct scatterlist *sgl;
@@ -896,9 +895,9 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
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
@@ -936,9 +935,8 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 		bam_txn->bam_ce_start = bam_txn->bam_ce_pos;
 
 		if (flags & NAND_BAM_NWD) {
-			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
-						     DMA_PREP_FENCE |
-						     DMA_PREP_CMD);
+			ret = qcom_prepare_bam_async_desc(nandc, nandc->cmd_chan,
+							  DMA_PREP_FENCE | DMA_PREP_CMD);
 			if (ret)
 				return ret;
 		}
@@ -951,9 +949,8 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
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
@@ -972,8 +969,8 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
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
@@ -982,9 +979,9 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
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
@@ -1062,15 +1059,15 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
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
@@ -1082,18 +1079,18 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
 		first = dev_cmd_reg_addr(nandc, first);
 
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
+		return qcom_prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
 					     num_regs, flags);
 
 	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
 		flow_control = true;
 
-	return prep_adm_dma_desc(nandc, true, first, vaddr,
-				 num_regs * sizeof(u32), flow_control);
+	return qcom_prep_adm_dma_desc(nandc, true, first, vaddr,
+				      num_regs * sizeof(u32), flow_control);
 }
 
 /*
- * write_reg_dma:	prepares a descriptor to write a given number of
+ * qcom_write_reg_dma:	prepares a descriptor to write a given number of
  *			contiguous registers
  *
  * @vaddr:		contnigeous memory from where register value will
@@ -1102,8 +1099,8 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
  * @num_regs:		number of registers to write
  * @flags:		flags to control DMA descriptor preparation
  */
-static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
-			 int first, int num_regs, unsigned int flags)
+static int qcom_write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
+			      int first, int num_regs, unsigned int flags)
 {
 	bool flow_control = false;
 
@@ -1117,18 +1114,18 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
 		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
 
 	if (nandc->props->supports_bam)
-		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
-					     num_regs, flags);
+		return qcom_prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
+						  num_regs, flags);
 
 	if (first == NAND_FLASH_CMD)
 		flow_control = true;
 
-	return prep_adm_dma_desc(nandc, false, first, vaddr,
-				 num_regs * sizeof(u32), flow_control);
+	return qcom_prep_adm_dma_desc(nandc, false, first, vaddr,
+				      num_regs * sizeof(u32), flow_control);
 }
 
 /*
- * read_data_dma:	prepares a DMA descriptor to transfer data from the
+ * qcom_read_data_dma:	prepares a DMA descriptor to transfer data from the
  *			controller's internal buffer to the buffer 'vaddr'
  *
  * @reg_off:		offset within the controller's data buffer
@@ -1136,17 +1133,17 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
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
@@ -1154,13 +1151,13 @@ static int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
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
@@ -1171,14 +1168,14 @@ static void config_nand_page_read(struct nand_chip *chip)
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
@@ -1197,17 +1194,17 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
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
 
@@ -1231,11 +1228,11 @@ static void config_nand_page_write(struct nand_chip *chip)
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
@@ -1246,17 +1243,18 @@ static void config_nand_cw_write(struct nand_chip *chip)
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
@@ -1265,21 +1263,21 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 
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
@@ -1289,7 +1287,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		cookie = dmaengine_submit(desc->dma_desc);
 
 	if (nandc->props->supports_bam) {
-		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback = qcom_qpic_bam_dma_done;
 		bam_txn->last_cmd_desc->callback_param = bam_txn;
 
 		dma_async_issue_pending(nandc->tx_chan);
@@ -1307,7 +1305,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 err_unmap_free_desc:
 	/*
 	 * Unmap the dma sg_list and free the desc allocated by both
-	 * prepare_bam_async_desc() and prep_adm_dma_desc() functions.
+	 * qcom_prepare_bam_async_desc() and qcom_prep_adm_dma_desc() functions.
 	 */
 	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
 		list_del(&desc->node);
@@ -1326,10 +1324,10 @@ static int submit_descs(struct qcom_nand_controller *nandc)
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
@@ -1393,7 +1391,7 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int i;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < cw_cnt; i++) {
 		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -1420,13 +1418,13 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
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
@@ -1459,18 +1457,18 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 
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
@@ -1568,7 +1566,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < ecc->steps; i++, buf++) {
 		u32 flash, buffer, erased_cw;
@@ -1697,8 +1695,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		config_nand_cw_read(chip, true, i);
 
 		if (data_buf)
-			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
-				      data_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
+					   data_size, 0);
 
 		/*
 		 * when ecc is enabled, the controller doesn't read the real
@@ -1713,8 +1711,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			for (j = 0; j < host->bbm_size; j++)
 				*oob_buf++ = 0xff;
 
-			read_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				      oob_buf, oob_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					   oob_buf, oob_size, 0);
 		}
 
 		if (data_buf)
@@ -1723,7 +1721,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
 		return ret;
@@ -1744,7 +1742,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	int size;
 	int ret;
 
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 
 	size = host->use_ecc ? host->cw_data : host->cw_size;
 
@@ -1756,9 +1754,9 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 
 	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - 1);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret)
 		dev_err(nandc->dev, "failed to copy last codeword\n");
 
@@ -1844,14 +1842,14 @@ static int qcom_nandc_read_page(struct nand_chip *chip, u8 *buf,
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
@@ -1892,8 +1890,8 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	host->use_ecc = true;
 	set_address(host, 0, page);
@@ -1920,8 +1918,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 	set_address(host, 0, page);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -1942,8 +1940,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 			oob_size = ecc->bytes;
 		}
 
-		write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
-			       i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
+		qcom_write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
+				    i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
 
 		/*
 		 * when ECC is enabled, we don't really need to write anything
@@ -1955,8 +1953,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		if (qcom_nandc_is_last_cw(ecc, i)) {
 			oob_buf += host->bbm_size;
 
-			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				       oob_buf, oob_size, 0);
+			qcom_write_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					    oob_buf, oob_size, 0);
 		}
 
 		config_nand_cw_write(chip);
@@ -1965,7 +1963,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write page\n");
 		return ret;
@@ -1990,8 +1988,8 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		qcom_nandc_codeword_fixup(host, page);
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -2017,28 +2015,28 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
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
@@ -2068,7 +2066,7 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 		qcom_nandc_codeword_fixup(host, page);
 
 	host->use_ecc = true;
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
@@ -2083,11 +2081,10 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	update_rw_regs(host, 1, false, 0);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, data_size + oob_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, data_size + oob_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write oob\n");
 		return ret;
@@ -2114,7 +2111,7 @@ static int qcom_nandc_block_bad(struct nand_chip *chip, loff_t ofs)
 	 */
 	host->use_ecc = false;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	ret = copy_last_cw(host, page);
 	if (ret)
 		goto err;
@@ -2141,8 +2138,8 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/*
 	 * to mark the BBM as bad, we flash the entire last codeword with 0s.
@@ -2159,11 +2156,10 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	update_rw_regs(host, 1, false, ecc->steps - 1);
 
 	config_nand_page_write(chip);
-	write_data_dma(nandc, FLASH_BUF_ACC,
-		       nandc->data_buffer, host->cw_size, 0);
+	qcom_write_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, host->cw_size, 0);
 	config_nand_cw_write(chip);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to update BBM\n");
 		return ret;
@@ -2403,14 +2399,14 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
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
@@ -2610,7 +2606,7 @@ static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
 	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
 	u32 flash;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	do {
 		flash = le32_to_cpu(nandc->reg_read_buf[0]);
@@ -2650,23 +2646,23 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->exec = 1;
 
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
@@ -2707,8 +2703,8 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = q_op.addr1_reg;
@@ -2716,12 +2712,12 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->regs->chip_sel = nandc->props->supports_bam ? 0 : DM_EN;
 	nandc->regs->exec = 1;
 
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
@@ -2731,7 +2727,7 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
 
 err_out:
@@ -2767,20 +2763,21 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->exec = 1;
 
-	write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(nandc, &nandc->regs->cmd, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
+
 	if (q_op.cmd_reg == OP_BLOCK_ERASE)
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
@@ -2813,8 +2810,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = false;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = 0;
@@ -2857,8 +2854,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
 
 	if (!nandc->props->qpic_version2) {
-		write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
-		write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
+		qcom_write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
 	nandc->buf_count = len;
@@ -2866,17 +2863,16 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 
 	config_nand_single_cw_page_read(chip, false, 0);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
-		      nandc->buf_count, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, nandc->buf_count, 0);
 
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
@@ -3060,7 +3056,7 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
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


