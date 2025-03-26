Return-Path: <linux-spi+bounces-7305-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340FA712DA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 09:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443323B4EA3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038219AA5D;
	Wed, 26 Mar 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KsW/rGab"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAB18C031;
	Wed, 26 Mar 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978410; cv=none; b=efjhz5PPpvdSPlFxtmCXLTiybaNoP6reR3pvWYp4bIe7R6zBIvh7s6WaY9VWvEa3b8Kj7pinumfm5u/bn2ngmAmbq/6yuYbbnyD/C0uV8hrM3SKqwqhn6ikOjRHw5ifgAM8d8nG84fjuCtEF8ShSan50DcusA/NRXBLaY+Ljeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978410; c=relaxed/simple;
	bh=yIt+M7uOO+mgzZtFsWE5czw7q0k+Yi6Iv5h3TlA7gV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P1jxCPTrP1hAwFjDfh7xbgJg0G7pEQer9SG0BB/9yRd+s7PvMjl1Svlncc7CsWiDs4+1bMfjE3CSJ80ZlnRqfhxJ0Sv4ZHNGKa5hsTF6qdMt2qAJpkDxXdG+826tBG3ZUWKfck4Ij0QNLWb/DnUm6NX+IL7oIG8ybs9QMWGInTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KsW/rGab; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73ADp014514;
	Wed, 26 Mar 2025 08:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xs4w0gEe6MCwCPXnB/2dBMpr1bX6UUfU7tM
	Hiwt++EE=; b=KsW/rGabHR5bvZqguawbORshSJTGgd8VBtFBiovqdYIp3PQouwi
	+EJEgnDhBAX9z/EY2SzM5qP3JPhAJUsFLQNPigrM4QLL/xOD10YAICNbkG4AzrTP
	C7Gjznx3Sj1H/rsI0GzLXtAqbALG2OAGdOvjaASM+qgNTIS4wrKy84Llpv08/Syg
	oJBJmm6YDsEJguhModnIN7AlFcLBgopSXcL3pFMkOvmRbWHwy8wXLaf0tctBHIHl
	4efuk4ISb6wCjWwpPZqPmxa3vwCPqXdfsCUMyQmHu687WG3C6cvDWM96XUQUYTY6
	OxzV9MM09fMp7zGFQ8TrmepbG9GUTysxAXQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9mrg78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 08:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q8dxFY003700;
	Wed, 26 Mar 2025 08:39:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45hp9mbppy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 08:39:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52Q8dx1s003694;
	Wed, 26 Mar 2025 08:39:59 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 52Q8dwVp003692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 08:39:59 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id 1CF8F22886; Wed, 26 Mar 2025 14:09:58 +0530 (+0530)
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Subject: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
Date: Wed, 26 Mar 2025 14:09:54 +0530
Message-Id: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e3bd63 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=AXjDKuDS1RE16Qb0dB8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MShBbftaXfVz1vnplNkg03AJqp9WeoQg
X-Proofpoint-ORIG-GUID: MShBbftaXfVz1vnplNkg03AJqp9WeoQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260051

There is no support for protocol drivers to specify whether a transfer
should use single or dual transfer mode. As a result, the SPI controller
has no way to determine this information from the user, leading to
potential limitations in transfer capabilities.

This change introduces a new field `dtr_mode` in the `spi_transfer`
structure. The `dtr_mode` field allows protocol drivers to indicate if
Double Transfer Rate (DTR) mode is supported for a given transfer. When
`dtr_mode` is set to true, the SPI controller will use DTR mode
otherwise, it will default to single transfer mode.

The QSPI controller driver uses this flag and configures single or double
transfer rate using the controller register.

The existing spi-mem driver helps configure the DTR mode but is limited
to memory devices. There is no support available to set DTR mode for
non-memory devices, e.g., touch or any generic SPI sensor. This change
is backward compatible and doesn't break existing SPI or QSPI drivers.

Changes include:
- Addition of `dtr_mode` field in `spi_transfer` structure.
- Documentation updates to reflect the new `dtr_mode` field.

Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
---
 include/linux/spi/spi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0ba5e49bace4..4e1152de82cd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -998,6 +998,7 @@ struct spi_res {
  *	processed the word, i.e. the "pre" timestamp should be taken before
  *	transmitting the "pre" word, and the "post" timestamp after receiving
  *	transmit confirmation from the controller for the "post" word.
+ * @dtr_mode: true if supports double transfer rate.
  * @timestamped: true if the transfer has been timestamped
  * @error: Error status logged by SPI controller driver.
  *
@@ -1049,6 +1050,9 @@ struct spi_res {
  * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
  * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
  *
+ * User may also set dtr_mode to true to use dual transfer mode if desired. if
+ * not, default considered as single transfer mode.
+ *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
@@ -1083,6 +1087,7 @@ struct spi_transfer {
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
 	unsigned	timestamped:1;
+	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */
-- 
2.25.1


