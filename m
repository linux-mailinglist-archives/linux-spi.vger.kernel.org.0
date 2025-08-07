Return-Path: <linux-spi+bounces-9307-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF3B1D355
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924A856641A
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FE23F417;
	Thu,  7 Aug 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C7wbD26T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85223E324;
	Thu,  7 Aug 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551828; cv=none; b=Im/MMVHj4UIx53Til8lHEJ3C81oNH3B3+BsoKubstYAEDz2sJ8rexfFGhatzCXbNDAgMDi/33XGcG9BL7DDlHFD2b1CM7bp28Wye6ABehK7trEbid4y4rv1b8LPuOFPYgat5Il8LbY1xYGyWbRlmIAf+rOkIjFpvLid7wqqCcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551828; c=relaxed/simple;
	bh=DGN16H4IRg8rut2+1xYh5AWMXaZkabwUNnbhnl/apG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC1+m65zOSj+wkAy46ZBXJT6od53+I7EaqBkMhRXsoeIzOKUjUqvIV18Zyf596+JB4GCxlfF2XaU76bz08kfK8i8iOK1ndrdCLAAFJKYp+JY1zeahgviZyOZ3JXOCzTKeVy4T26CI/aPPaQOgQF1vWJ/ky/u6SQ168GPY19EI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C7wbD26T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57724GQo004660;
	Thu, 7 Aug 2025 07:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PDhUYR3sEIfa/680HsEZglzFXFg/RoJHufmml9cCY1I=; b=C7wbD26TauxlycBZ
	Gz/KxuUaPO5+1AULCNddYnMNOljbEmIH2wqUmgHlQsvbIR5wAg1hcLd/OXKSLhBQ
	oV7KPBsNsUvvuYPGDzGAe9hCOPX0Rlp4bKN4rqM6lsrx7T6C/yX2HwLy1lPsQeCt
	qYRN7fpxZMYNJPulXPx24sH+0lABTmgGoGsFVi4HLjMQIxceXX1nl7EFps9RBhqT
	htcw6LH0X4utRgnaRh4hfEyu3AtjOmwKY51bE1hZ1R+S2pYj8q954OfbyoFKHUq8
	YVqLtPY+tYTnQT8GJZ21GQM3X8OpQuRjbQ2n9Q5Wb+IO8Qlwc/Zm5s5qykJNQUjz
	LnfhpA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6wecj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:30:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5777UChJ002854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 07:30:12 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 7 Aug 2025 00:30:09 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v8 1/3] virtio: Add ID for virtio SPI
Date: Thu, 7 Aug 2025 15:29:34 +0800
Message-ID: <20250807072936.4155687-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807072936.4155687-1-quic_haixcui@quicinc.com>
References: <20250807072936.4155687-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I5NTIaNoRq687Mzx8X4dTK3cE4wDsb7W
X-Proofpoint-GUID: I5NTIaNoRq687Mzx8X4dTK3cE4wDsb7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7AFWe4La0NKc
 CbEsUz6cKA4xi1PVCJM6l6QOqaKqPsRj0rQn86eFqeuNI2ob/7YWnY7NwWR1Cq130TM2CyDD1FJ
 6Q9XcuCVCpe1dUjX+xNlIq3v8xxzMvwQacaiWDsrqyhI/78ZV8VRrtlvL72oG6ocwTNmL4ahGx5
 psNBBGY21SCV6lQBI+BpV+G/MJY6l6HjcShLQ8wdahp/o2SwSI6jgiT4faB0B8Y83vzkqa4JA4Q
 YJGG+LyzCEsxWuEw5BrE7SR+AEctiSFfFbwQLH99BjuoJpqp+2hjo2AFjeAHOrOEQmJirhJrHNo
 Y7yYTzNlOT6Awb7ODkz4XoIz9MzfRZoLlMNYma2jFPV1sAqSj4KXXN2/y2W9m1WXjB5V+L2ZNww
 y2F9dJ/Y
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68945605 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=KqJd8QcNxZFF0aacHC0A:9 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

Add VIRTIO_ID_SPI definition for virtio SPI.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6c12db16faa3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SPI			45 /* virtio spi */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1


