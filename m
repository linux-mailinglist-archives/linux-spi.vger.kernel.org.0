Return-Path: <linux-spi+bounces-4242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FAC9584F7
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1728BC4F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5500B18E76A;
	Tue, 20 Aug 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dm6gnCQ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA118E75C;
	Tue, 20 Aug 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150620; cv=none; b=q5kQlFoz/Pa4KTs3ZJQ43niPokfvirjj3jcomVTGhbBXaG7AuiFtEg2rJo8p9NiYnfy16jW/bmJk8qC4SIW8VkrC6UKMpQsXpIWWbfXQx3O+cFcaQuQh6npfOHWjAfV4rZJag1fBDNwP2tucKHSSZTYw0F8c6152pX8XdPDyyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150620; c=relaxed/simple;
	bh=VSxBsu5/6Mkxl7sYpFvzJ+eqtUAZL4QkU8ei7aBBmGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbwicfCTJTlOHeUpSD+ne0CjwEGcLpYHbnG7UwytLnQYtndhAHlr0lP3/Ybt2hA6WmsviQWXsqqtNhkzIhLHfWUZ0qME8uIdcCNE6W4pF5oqi+ThPnzAeYKOr3O9MQgTXgCBd99hNm+Md4+QNh5hbriw9dEanN3VYSj1Xg7RhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dm6gnCQ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KA5BAJ011674;
	Tue, 20 Aug 2024 10:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etNRtmm33K2qGaHKfb9Rjd3NKsrYtG65kqLeMkSnlKo=; b=Dm6gnCQ9P9U8lGf6
	amtThyPsJtppL4v5TrOFKJfBr6FNoXNudf+dzkxLsyoC5Gnf5g20i7V27GAStzyi
	yAl0zhUXwZwrutD8UHWCeA8gwQuxnQRqpQxt+lTBMuoELpG801BcgTFKIrFBkUEG
	Vv76SnQvR6dsuJ+WpOIrwbrMD837AJisYOwEM/reM7dKOBQMyTRRwaK/hIL59PGY
	X0FKYoUzU4QJCqjXyd43Gxq4nLyV3fMyyO1uB/yJhZNweNAeMRgx3Rv9VjmWOrHM
	imDvnf772OCfg+99J1gmmV7UkZlcZTU+zheqm6hJ1CrMtZEOzcCt8ziTQ1eovTlD
	4iUSvA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414j571cjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KAhCkX024349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:12 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 03:43:07 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH v8 3/8] mtd: rawnand: qcom: Add qcom prefix to common api
Date: Tue, 20 Aug 2024 16:12:34 +0530
Message-ID: <20240820104239.1774600-4-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ap0EIfvd4EcK-Jcm2aqDbq9rzPtEbfuG
X-Proofpoint-GUID: Ap0EIfvd4EcK-Jcm2aqDbq9rzPtEbfuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200079

Add qcom prefix to all the api which will be commonly
used by spi nand driver and raw nand driver.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
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

 drivers/mtd/nand/raw/qcom_nandc.c | 322 +++++++++++++++---------------
 1 file changed, 159 insertions(+), 163 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a7df6169f74a..48f065aa40da 100644
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
@@ -819,9 +819,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
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
@@ -898,9 +897,9 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
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
@@ -938,9 +937,8 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
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
@@ -953,9 +951,8 @@ static int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
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
@@ -974,8 +971,8 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
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
@@ -984,9 +981,9 @@ static int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
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
@@ -1064,15 +1061,15 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
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
@@ -1084,18 +1081,18 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
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
@@ -1104,8 +1101,8 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
  * @num_regs:		number of registers to write
  * @flags:		flags to control DMA descriptor preparation
  */
-static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
-			 int first, int num_regs, unsigned int flags)
+static int qcom_write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
+			      int first, int num_regs, unsigned int flags)
 {
 	bool flow_control = false;
 
@@ -1119,18 +1116,18 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
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
@@ -1138,17 +1135,17 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
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
@@ -1156,13 +1153,13 @@ static int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
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
@@ -1173,14 +1170,14 @@ static void config_nand_page_read(struct nand_chip *chip)
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
@@ -1199,17 +1196,17 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
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
 
@@ -1233,11 +1230,11 @@ static void config_nand_page_write(struct nand_chip *chip)
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
@@ -1248,17 +1245,18 @@ static void config_nand_cw_write(struct nand_chip *chip)
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
@@ -1267,21 +1265,21 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 
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
@@ -1291,7 +1289,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		cookie = dmaengine_submit(desc->dma_desc);
 
 	if (nandc->props->supports_bam) {
-		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback = qcom_qpic_bam_dma_done;
 		bam_txn->last_cmd_desc->callback_param = bam_txn;
 
 		dma_async_issue_pending(nandc->tx_chan);
@@ -1309,7 +1307,7 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 err_unmap_free_desc:
 	/*
 	 * Unmap the dma sg_list and free the desc allocated by both
-	 * prepare_bam_async_desc() and prep_adm_dma_desc() functions.
+	 * qcom_prepare_bam_async_desc() and qcom_prep_adm_dma_desc() functions.
 	 */
 	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
 		list_del(&desc->node);
@@ -1328,10 +1326,10 @@ static int submit_descs(struct qcom_nand_controller *nandc)
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
@@ -1395,7 +1393,7 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int i;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < cw_cnt; i++) {
 		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
@@ -1422,13 +1420,13 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
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
@@ -1461,18 +1459,18 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 
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
@@ -1570,7 +1568,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	for (i = 0; i < ecc->steps; i++, buf++) {
 		u32 flash, buffer, erased_cw;
@@ -1699,8 +1697,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		config_nand_cw_read(chip, true, i);
 
 		if (data_buf)
-			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
-				      data_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
+					   data_size, 0);
 
 		/*
 		 * when ecc is enabled, the controller doesn't read the real
@@ -1715,8 +1713,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			for (j = 0; j < host->bbm_size; j++)
 				*oob_buf++ = 0xff;
 
-			read_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				      oob_buf, oob_size, 0);
+			qcom_read_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					   oob_buf, oob_size, 0);
 		}
 
 		if (data_buf)
@@ -1725,7 +1723,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
 		return ret;
@@ -1746,7 +1744,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	int size;
 	int ret;
 
-	clear_read_regs(nandc);
+	qcom_clear_read_regs(nandc);
 
 	size = host->use_ecc ? host->cw_data : host->cw_size;
 
@@ -1758,9 +1756,9 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 
 	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - 1);
 
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
+	qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret)
 		dev_err(nandc->dev, "failed to copy last codeword\n");
 
@@ -1846,14 +1844,14 @@ static int qcom_nandc_read_page(struct nand_chip *chip, u8 *buf,
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
@@ -1894,8 +1892,8 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	host->use_ecc = true;
 	set_address(host, 0, page);
@@ -1922,8 +1920,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 	set_address(host, 0, page);
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -1944,8 +1942,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 			oob_size = ecc->bytes;
 		}
 
-		write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
-			       i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
+		qcom_write_data_dma(nandc, FLASH_BUF_ACC, data_buf, data_size,
+				    i == (ecc->steps - 1) ? NAND_BAM_NO_EOT : 0);
 
 		/*
 		 * when ECC is enabled, we don't really need to write anything
@@ -1957,8 +1955,8 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		if (qcom_nandc_is_last_cw(ecc, i)) {
 			oob_buf += host->bbm_size;
 
-			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
-				       oob_buf, oob_size, 0);
+			qcom_write_data_dma(nandc, FLASH_BUF_ACC + data_size,
+					    oob_buf, oob_size, 0);
 		}
 
 		config_nand_cw_write(chip);
@@ -1967,7 +1965,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const u8 *buf,
 		oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
+	ret = qcom_submit_descs(nandc);
 	if (ret) {
 		dev_err(nandc->dev, "failure to write page\n");
 		return ret;
@@ -1992,8 +1990,8 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		qcom_nandc_codeword_fixup(host, page);
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
@@ -2019,28 +2017,28 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
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
@@ -2070,7 +2068,7 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 		qcom_nandc_codeword_fixup(host, page);
 
 	host->use_ecc = true;
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
@@ -2085,11 +2083,10 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
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
@@ -2116,7 +2113,7 @@ static int qcom_nandc_block_bad(struct nand_chip *chip, loff_t ofs)
 	 */
 	host->use_ecc = false;
 
-	clear_bam_transaction(nandc);
+	qcom_clear_bam_transaction(nandc);
 	ret = copy_last_cw(host, page);
 	if (ret)
 		goto err;
@@ -2143,8 +2140,8 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	/*
 	 * to mark the BBM as bad, we flash the entire last codeword with 0s.
@@ -2161,11 +2158,10 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
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
@@ -2405,14 +2401,14 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
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
@@ -2612,7 +2608,7 @@ static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
 	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
 	u32 flash;
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 
 	do {
 		flash = le32_to_cpu(nandc->reg_read_buf[0]);
@@ -2652,23 +2648,23 @@ static int qcom_read_status_exec(struct nand_chip *chip,
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
@@ -2709,8 +2705,8 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	nandc->buf_start = 0;
 	host->use_ecc = false;
 
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = q_op.addr1_reg;
@@ -2718,12 +2714,12 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
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
@@ -2733,7 +2729,7 @@ static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subo
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_dev_to_mem(nandc, true);
+	qcom_nandc_dev_to_mem(nandc, true);
 	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
 
 err_out:
@@ -2769,20 +2765,21 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
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
@@ -2815,8 +2812,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc->buf_count = 0;
 	nandc->buf_start = 0;
 	host->use_ecc = false;
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	qcom_clear_read_regs(nandc);
+	qcom_clear_bam_transaction(nandc);
 
 	nandc->regs->cmd = q_op.cmd_reg;
 	nandc->regs->addr0 = 0;
@@ -2859,8 +2856,8 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
 
 	if (!nandc->props->qpic_version2) {
-		write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
-		write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+		qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
+		qcom_write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
 	nandc->buf_count = len;
@@ -2868,17 +2865,16 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 
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
@@ -3062,7 +3058,7 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
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


