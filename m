Return-Path: <linux-spi+bounces-9683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E21B3985D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 11:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C981418972BF
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457C2DF6F4;
	Thu, 28 Aug 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KECyoKtF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832922F74D;
	Thu, 28 Aug 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373731; cv=none; b=Rdg3nOPjMrssaWl+KVSGzak4flUeHbf6kBgB3ZTpdQpiOLnbScWqpc+Kp3pOJCH6Dpf5EfVSjbFSQJpRObweGE7AMhI8ErRSMqlI7HR94QCDPnIJZFfX60338G57wXZa1JYuUwnWiQO9Xur6IrXhbb4pR1S4M2T6HK8tl3/IWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373731; c=relaxed/simple;
	bh=DGN16H4IRg8rut2+1xYh5AWMXaZkabwUNnbhnl/apG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdhoW3Zd5KHgO2fm4h20H3is5hz0p0xXpZbkSN+uwkuww3OhSIrjrE4fE/tJ/1LtnXlSTzVMfOQyTJx01D5dXo3syADuFj9AujFOfnUHj/C172qRLdlkaKSJZwDOJodpA8DdIAckPLoQLB16VU1gOGBmw991Zm5TCghcr3DM3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KECyoKtF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5V6aS027635;
	Thu, 28 Aug 2025 09:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PDhUYR3sEIfa/680HsEZglzFXFg/RoJHufmml9cCY1I=; b=KECyoKtFUdWnjypG
	BE1oQzOq0DERh9b7eS2UUew1+xULf9FWY2eCqvKLjx+Si35jIgjbwaUZTtY7Os7k
	wdYygsrlQxEs3DmqnoXkNOSBe98xJX7FPoFwE2SEsZTrqHaLQNjownh4hLkxCecO
	NxfTaSZnHPnWsPYcSfsGCra4MGJVT9khoTJ6kVzG3u1uM8m4fvc9C58uL/+hfGG1
	E73idZuMH+fIw2IjrYMdhAMuFyPnEWE9Vi49dTz/gj6IUYJIweOEig0au7HRdjoH
	tVZB+bhevH53z0Quv+hM/k+FQxt9yjNxtEpySGJgvK66kfQjiYaG2vPFuwGyg+yB
	+Ter+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16xqx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 09:35:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57S9ZFit024856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 09:35:15 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 02:35:11 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v9 1/3] virtio: Add ID for virtio SPI
Date: Thu, 28 Aug 2025 17:34:49 +0800
Message-ID: <20250828093451.2401448-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tFGuqXjx6WurPJXiOdV0BWdafFtvj1lM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfXz9QeY24ok9II
 Z7jA/L6Y3NJY/bNnNy6zDIAIjvV2i2fT4T8tsH441OM6w/NfWL5uduDIByKrVqtboQ5uLfIVn+g
 F+tUYgUbq3w+i9bGGDgR3mVXjC+YWl+6t1fcT7kzO/ymHrGSbeMQuFGvjrLH+YmPgVWtuYTSQvq
 raySOaZ9UcooklZ7Z0Xg5dSP6BAT7JcDgtm2ZgUUAEi/Ex6LVl3yV+EGeyLF52YbTqSwwfdilyf
 XD84QNnY9UEDYtj1hyXSn9W3c7WF0/xVopdhSWT2S40Km3CzmCzYBXleoMRYkRbg4Ixg73UAC8+
 NnI90VWJ1qTuz+fPBiubQdPeRLNOYk5ZHbuxoN67A0PcMOa6GNYuK9Ji1teK1qxR4/aIVwMSSvv
 019ttCRy
X-Proofpoint-ORIG-GUID: tFGuqXjx6WurPJXiOdV0BWdafFtvj1lM
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68b022d6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=KqJd8QcNxZFF0aacHC0A:9 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

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


