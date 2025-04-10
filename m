Return-Path: <linux-spi+bounces-7526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1BA843F3
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418C719E2754
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3826A1B9;
	Thu, 10 Apr 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WB20BA6j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECD26A1D0;
	Thu, 10 Apr 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290164; cv=none; b=eBdY8jvKDEs6wOx2Dd3NEqvo7LMuO8/LOXq/MqrXSG9X/rCVWjkYo0jZZC9LZddf4p+65QGLrFyaYSyPL6zpjfI5jcFQUjca358jq6OPflLitxELpWT4UYcKTr1Voqqf6e1yNVv99KMNsstm53ROdv/GBgmqyw9CeefhSgPSa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290164; c=relaxed/simple;
	bh=0IzK1GaqJSOEk7/gJbwTksW3Z40WfQCCpHt0WvWAOjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgTZ+ADWdE/Wz67jV0Xxqb8zyID3rsQc935xUnmZ9QwDvdO9zrn4omUrmfRSpOzOBC3V+q1sTMCKPROh4ekfZ0K4v7+EJkVm/C6zsjsP1zPwU4LMFAB5vVHuahurjgScm79pqOLUt67sMtWnbHzlmeRpF4hZTh/qeA+PkQG3gBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WB20BA6j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75KHe032531;
	Thu, 10 Apr 2025 13:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eDjJTamfxfsyMrd9Ovbt+ZI9usmPrYbuC0F
	aitGEEM4=; b=WB20BA6jb7NVn5a22kE8fI3eOpY2Zkn7fdOdXJHv5gW1N/gmwiF
	IGZP1uYCEXHd8gVXMpKyBUPY6lq+WoDD5UCCrREOs6OzWPSXR8O1H47EaFwuSbAJ
	Q9/0QcnOTeCVX+R1ZUGhC7zpUZ9mArcJO9AKUIhE4RzF6bQKMLkPZ87v0qQeHtLi
	CeOfHAlswXslagFc6IPMXkM1omTxGmWYrG2SPMRr4bQVfq1eY4YrbNwalumnofVh
	0aJppqb4cAblyC0/6lFlKLQi7EliTEvrXB+0hwZCV+JF38OyMfJzISYEeRkLvRj8
	BNP+moRsIxhcS9xuj71vGtdBCcaucI2TIew==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkptee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:02:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AD2ZEo029902;
	Thu, 10 Apr 2025 13:02:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 45ue7g4x69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:02:35 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53AD2Zc3029897;
	Thu, 10 Apr 2025 13:02:35 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 53AD2Y0q029895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:02:35 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id F241D2406E; Thu, 10 Apr 2025 18:32:33 +0530 (+0530)
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_tdas@quicinc.com, andersson@kernel.org, konradybcio@kernel.org,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Subject: [PATCH RESEND v2] spi: Add support for Double Transfer Rate (DTR) mode
Date: Thu, 10 Apr 2025 18:32:07 +0530
Message-Id: <20250410130207.3688117-1-quic_msavaliy@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: TiUPzrwlfOm_R7-8Ocg2-6KglXSylhM5
X-Proofpoint-ORIG-GUID: TiUPzrwlfOm_R7-8Ocg2-6KglXSylhM5
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f7c16e cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=L_hmj3AzAEoXzwg3iu4A:9 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100094

Introduce support for protocol drivers to specify whether a transfer
should use single or dual transfer mode. Currently, the SPI controller
cannot determine this information from the user, leading to potential
limitations in transfer capabilities.

Add a new field `dtr_mode` in the `spi_transfer` structure. The `dtr_mode`
field allows protocol drivers to indicate if Double Transfer Rate (DTR)
mode is supported for a given transfer. When `dtr_mode` is set to true,
the SPI controller will use DTR mode; otherwise, it will default to single
transfer mode.

Introduce another field `dtr_caps` to indicate if the QSPI controller is
capable of supporting DTR mode (SDR and DDR). By default, both `dtr_caps`
and `dtr_mode` will be false. These flags manage the QSPI controller's DTR
mode capabilities within the SPI framework.

The QSPI controller driver uses these flags to configure single or double
transfer rates using the controller register.

The existing spi-mem driver helps configure the DTR mode but is limited to
memory devices. There is no support available to set DTR mode for non-memory
devices, e.g., touch or any generic SPI sensor. This change is backward
compatible and doesn't break existing SPI or QSPI drivers.

Changes include:
- Addition of `dtr_mode` and `dtr_caps` fields in the `spi_transfer`
  structure.
- Documentation updates to reflect the new `dtr_mode` and `dtr_caps` fields.

Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
---
Link to v1: https://lore.kernel.org/all/fbad733f-d034-4d63-ab82-ed867f0ed5d4@linaro.org/T/

Changes in V2:
 - Added dtr_caps flag to expose controllers capability and validate the
   dtr_mode against it.
---
---
 drivers/spi/spi.c       |  7 +++++++
 include/linux/spi/spi.h | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 27fc30fa39d6..d9ef785cb266 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4092,6 +4092,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		if (__spi_validate_bits_per_word(ctlr, xfer->bits_per_word))
 			return -EINVAL;
 
+		/* DDR mode is supported only if controller has dtr_caps=true.
+		 * default considered as SDR mode for SPI and QSPI controller.
+		 * Note: This is applicable only to QSPI controller.
+		 */
+		if (xfer->dtr_mode && !ctlr->dtr_caps)
+			return -EINVAL;
+
 		/*
 		 * SPI transfer length should be multiple of SPI word size
 		 * where SPI word size should be power-of-two multiple.
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0ba5e49bace4..c454abbda910 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -503,6 +503,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	found.
  * @put_offload: release the offload instance acquired by @get_offload.
  * @mem_caps: controller capabilities for the handling of memory operations.
+ * @dtr_caps: true if controller has dtr(single/dual transfer rate) capability.
+ *	QSPI based controller should fill this based on controller's capability.
  * @unprepare_message: undo any work done by prepare_message().
  * @target_abort: abort the ongoing transfer request on an SPI target controller
  * @cs_gpiods: Array of GPIO descriptors to use as chip select lines; one per CS
@@ -746,6 +748,9 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	/* SPI or QSPI controller can set to true if supports SDR/DDR transfer rate */
+	bool			dtr_caps;
+
 	struct spi_offload *(*get_offload)(struct spi_device *spi,
 					   const struct spi_offload_config *config);
 	void (*put_offload)(struct spi_offload *offload);
@@ -998,6 +1003,7 @@ struct spi_res {
  *	processed the word, i.e. the "pre" timestamp should be taken before
  *	transmitting the "pre" word, and the "post" timestamp after receiving
  *	transmit confirmation from the controller for the "post" word.
+ * @dtr_mode: true if supports double transfer rate.
  * @timestamped: true if the transfer has been timestamped
  * @error: Error status logged by SPI controller driver.
  *
@@ -1049,6 +1055,9 @@ struct spi_res {
  * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
  * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
  *
+ * User may also set dtr_mode to true to use dual transfer mode if desired. if
+ * not, default considered as single transfer mode.
+ *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
@@ -1083,6 +1092,7 @@ struct spi_transfer {
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
 	unsigned	timestamped:1;
+	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */
-- 
2.25.1


