Return-Path: <linux-spi+bounces-7080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4042A593D1
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 13:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E761890AD1
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A1227B9A;
	Mon, 10 Mar 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ps4eWNJi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680822156F;
	Mon, 10 Mar 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608587; cv=none; b=j+lCNQWXlirH9ZrmXWeCJLUIrQpIG+v99CcgohwOVEMwf1BTk4CrjZYei8hYR5ArBwtOxfrweiAOZo+jCurx30WxXeHsh9rkMtN/1gTBFAm3mL68x3vs84UxMY4wpOF3IuNyi+TL85XUL4MkEWPrHJQZVyf60575BEaxiGMD69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608587; c=relaxed/simple;
	bh=RATihl00ifnEEub10r70xUN32uo8hJFRPkXzX848030=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqYfkc16B4trOCh4eqTXWCbv4l206KZasGXJHZhr95iGS5tt7LsS2oijjL/sSzfIcd3TIqjLNm5TqKojn3C80a7xZu/9J661Fn7gOlSh+Zw/10Paf/v9ZjMOWW6qWpML8aSLrk1z5cNRkAFnO6pss0XgiVmeyhZYCzwmdtACuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ps4eWNJi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A8m2Lu027354;
	Mon, 10 Mar 2025 12:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	adN+4ikcEN3NAUucAWLR4IlKG1TfU+4qY+hNlC2pQdc=; b=Ps4eWNJiUZGalMzc
	W//N8eNrpQCMe3+Rdjg7/g+4l4Z8GtJ7WjT5SkSGW8Q2iz6RjlvGxJ1qcZiCC6wP
	KqhQcArqxTFjoldQUhW7Zsx1o6tIRRyLEm7hQmD1Z2Mb50f8D4XmWsuPhzTvOiiD
	nc9wWohMjc4OaRTFMKCxs13yAeBDhTUF406pX4YS1ueAGmrU5MIz0DOki5FQHFbl
	w9Hp+fyqVjsOXHlCEUq7jh07ZNJfojb1FtnZcj5bKHyScZQo66P191lEqz+X10i2
	SbIqodXq6+Yl3LiGdWo/TavNYDeqZJqQH8A2OHX4VhTUw4SMB4T4O+jVXr3xPmA5
	V5/qow==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f6actcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52AC9RI4011451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:27 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 05:09:24 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC base address to BAM
Date: Mon, 10 Mar 2025 17:39:03 +0530
Message-ID: <20250310120906.1577292-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WsDRMcfv c=1 sm=1 tr=0 ts=67ced678 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ftwAy63A9X0dtpR3FuYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pBTgiuc2HvEDG6vqffZlw-CwldyI3vfk
X-Proofpoint-ORIG-GUID: pBTgiuc2HvEDG6vqffZlw-CwldyI3vfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100096

Currently we are configuring lower 24 bits of address in descriptor
whereas QPIC design expects 18 bit register offset from QPIC base
address to be configured in cmd descriptors. This is leading to a
different address actually being used in HW, leading to wrong value
read.

the actual issue is that the NANDc base address is different from the
QPIC base address. But the driver doesn't take it into account and just
used the QPIC base as the NANDc base. This used to work as the NANDc IP
only considers the lower 18 bits of the address passed by the driver to
derive the register offset. Since the base address of QPIC used to contain
all 0 for lower 18 bits (like 0x07980000), the driver ended up passing the
actual register offset in it and NANDc worked properly. But on newer SoCs
like SDX75, the QPIC base address doesn't contain all 0 for lower 18 bits
(like 0x01C98000). So NANDc sees wrong offset as per the current logic

The address should be passed to BAM 0x30000 + offset. In older targets
the lower 18-bits are zero so that correct address being paased. But
in newer targets the lower 18-bits are non-zero in QPIC base so that
0x300000 + offset giving the wrong value.

SDX75 : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
SDX55 : QPIC_QPIC | 0x1B00000 (Lower 18 bits are zero) Same for
older targets.

Cc: stable@vger.kernel.org
Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Updated commit message
* Removed dev_cmd_reg_start = 0 , which
  was wrongely got added

Change in [v2]

* Updated commit message

* Added Fixes tag

* Added stable kernel tag

* Renamed the variable from offset_from_qpic to nandc_offset

Change in [v1]

* Preliminary correction for the register address forwarded to BAM

 drivers/mtd/nand/raw/qcom_nandc.c    | 4 ++++
 include/linux/mtd/nand-qpic-common.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5eaa0be367cd..5443cb918e0b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2360,6 +2360,7 @@ static const struct qcom_nandc_props ipq806x_nandc_props = {
 	.supports_bam = false,
 	.use_codeword_fixup = true,
 	.dev_cmd_reg_start = 0x0,
+	.nandc_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq4019_nandc_props = {
@@ -2367,6 +2368,7 @@ static const struct qcom_nandc_props ipq4019_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x0,
+	.nandc_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq8074_nandc_props = {
@@ -2374,6 +2376,7 @@ static const struct qcom_nandc_props ipq8074_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x7000,
+	.nandc_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props sdx55_nandc_props = {
@@ -2382,6 +2385,7 @@ static const struct qcom_nandc_props sdx55_nandc_props = {
 	.nandc_part_of_qpic = true,
 	.qpic_version2 = true,
 	.dev_cmd_reg_start = 0x7000,
+	.nandc_offset = 0x30000,
 };
 
 /*
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index cd7172e6c1bb..6268f08b9d19 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -200,7 +200,7 @@
 #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
 
 /* Returns the NAND register physical address */
-#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
+#define nandc_reg_phys(chip, offset)  ((nandc)->props->nandc_offset + (offset))
 
 /* Returns the dma address for reg read buffer */
 #define reg_buf_dma_addr(chip, vaddr) \
@@ -458,6 +458,7 @@ struct qcom_nandc_props {
 	bool nandc_part_of_qpic;
 	bool qpic_version2;
 	bool use_codeword_fixup;
+	u32 nandc_offset;
 };
 
 void qcom_free_bam_transaction(struct qcom_nand_controller *nandc);
-- 
2.34.1


