Return-Path: <linux-spi+bounces-7517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F4A8400A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A106F4A7CCF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE427CB1C;
	Thu, 10 Apr 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LePuoBgL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453827CB0C;
	Thu, 10 Apr 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279309; cv=none; b=Bi0tp2Y1QbOKMHONxlMh7h7eJN5Y2PDIFDqkV1MNVMlTQGpwOY29uug7H4Hmj7zJIXZOt9e1+I/C6of1SJDJd3MUHcEX97VWYVQVeksYiGOpD8GfjUOn7Ch3Tu6rAy3K7JFMDsINgvxXo3xEHfE4nwYSQckjYxRpsw86FkgCaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279309; c=relaxed/simple;
	bh=ufisdiNDX2kbckBaBkROgsADiMWw7UyDYfdN1lAigv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qthrf7s6lxw4ISxA3SIdHPGHxRhFMUDYM2Y7v5UTiiJ2H16Bbjznvqu4kjq5g4qjmAPlI9ncw/pqcHlv4SGGlbngLaQjwBk5skD8axNTBS8rl9xgAnpm4qhEoMpLlmtjfyn8QKGA4/BrxnGVtXtxtkUY5WHhMjbFFaWn+8zBcb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LePuoBgL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75i09008467;
	Thu, 10 Apr 2025 10:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URnznISBws8uPYFQJhZ98DHW0fVznarurCoz5NYitIk=; b=LePuoBgL8x3OzrII
	9hIpRzpTTysc/+kV1/ccfiL/tFl0YBrAyKsM4QtVfMCokSDl2k2Cq/Z6MbHvTYGR
	meoY6R2jxsPmzGys7IOxF3SM9aOOXOaL+7fdYviTKs9erNntIDbz4NY9Z55LIFTz
	wK65/sslp2HuHkf58dYT9dgctZ5tXH08kN87T2rP1ok6afUxhTToL/NzlZE4LXGt
	REF3+2Y3M/OcZUgWMzjrjkjK+5YjVKxLlqNipANz3obiMRXEJ2RSNR/X7jvcqSea
	fx3Gt6IebYsQ0VdNgBnkUejOCgKAoLSUM7FnmGNSjBosxPjULc6XKp/nujlXbs15
	tMdPyw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd06kax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AA0ipc004469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:44 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 03:00:40 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <broonie@kernel.org>,
        <absahu@codeaurora.org>, <bbrezillon@kernel.org>,
        <architt@codeaurora.org>, <quic_srichara@quicinc.com>,
        <quic_mdalam@quicinc.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v4 1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM base
Date: Thu, 10 Apr 2025 15:30:17 +0530
Message-ID: <20250410100019.2872271-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: P_Bb2ceIJS_dBv6vsRfwO6LiipfVlyXQ
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f796cd cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=r2DdmP78tLIatbETvAUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P_Bb2ceIJS_dBv6vsRfwO6LiipfVlyXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100075

The BAM command descriptor provides only 18 bits to specify the NAND
register offset. Additionally, in the BAM command descriptor, the NAND
register offset is supposed to be specified as "(NANDc base - BAM base)
+ reg_off". Since, the BAM controller expecting the value in the form of
"NANDc base - BAM base", so that added a new field 'bam_offset' in the NAND
properties structure and use it while preparing the command descriptor.

Previously, the driver was specifying the NANDc base address in the BAM
command descriptor.

Cc: stable@vger.kernel.org
Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/qpic_common.c       | 8 ++++----
 drivers/mtd/nand/raw/qcom_nandc.c    | 4 ++++
 drivers/spi/spi-qpic-snand.c         | 1 +
 include/linux/mtd/nand-qpic-common.h | 4 +---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
index e0ed25b5afea..4dc4d65e7d32 100644
--- a/drivers/mtd/nand/qpic_common.c
+++ b/drivers/mtd/nand/qpic_common.c
@@ -236,21 +236,21 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 	int i, ret;
 	struct bam_cmd_element *bam_ce_buffer;
 	struct bam_transaction *bam_txn = nandc->bam_txn;
+	u32 offset;
 
 	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
 
 	/* fill the command desc */
 	for (i = 0; i < size; i++) {
+		offset = nandc->props->bam_offset + reg_off + 4 * i;
 		if (read)
 			bam_prep_ce(&bam_ce_buffer[i],
-				    nandc_reg_phys(nandc, reg_off + 4 * i),
-				    BAM_READ_COMMAND,
+				    offset, BAM_READ_COMMAND,
 				    reg_buf_dma_addr(nandc,
 						     (__le32 *)vaddr + i));
 		else
 			bam_prep_ce_le32(&bam_ce_buffer[i],
-					 nandc_reg_phys(nandc, reg_off + 4 * i),
-					 BAM_WRITE_COMMAND,
+					 offset, BAM_WRITE_COMMAND,
 					 *((__le32 *)vaddr + i));
 	}
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5eaa0be367cd..ef2dd158ca34 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2360,6 +2360,7 @@ static const struct qcom_nandc_props ipq806x_nandc_props = {
 	.supports_bam = false,
 	.use_codeword_fixup = true,
 	.dev_cmd_reg_start = 0x0,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq4019_nandc_props = {
@@ -2367,6 +2368,7 @@ static const struct qcom_nandc_props ipq4019_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x0,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq8074_nandc_props = {
@@ -2374,6 +2376,7 @@ static const struct qcom_nandc_props ipq8074_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props sdx55_nandc_props = {
@@ -2382,6 +2385,7 @@ static const struct qcom_nandc_props sdx55_nandc_props = {
 	.nandc_part_of_qpic = true,
 	.qpic_version2 = true,
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 };
 
 /*
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index a2af731049d4..89c774bf85a6 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1605,6 +1605,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 
 static const struct qcom_nandc_props ipq9574_snandc_props = {
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 	.supports_bam = true,
 };
 
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index cd7172e6c1bb..e8462deda6db 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -199,9 +199,6 @@
  */
 #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
 
-/* Returns the NAND register physical address */
-#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
-
 /* Returns the dma address for reg read buffer */
 #define reg_buf_dma_addr(chip, vaddr) \
 	((chip)->reg_read_dma + \
@@ -454,6 +451,7 @@ struct qcom_nand_controller {
 struct qcom_nandc_props {
 	u32 ecc_modes;
 	u32 dev_cmd_reg_start;
+	u32 bam_offset;
 	bool supports_bam;
 	bool nandc_part_of_qpic;
 	bool qpic_version2;
-- 
2.34.1


