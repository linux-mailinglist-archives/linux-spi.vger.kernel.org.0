Return-Path: <linux-spi+bounces-9542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76167B2D714
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4705A730F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CC2D24AD;
	Wed, 20 Aug 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FkK986tG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344722D9ED0;
	Wed, 20 Aug 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679857; cv=none; b=MS7+PXrgKJilDHNQQJvd5ogu44UD5wlNxYMLPhOfJtDGU7vYIdeQAS01RMMehv5K2mUlPPz11Ul1ckkQ7OVGXHysJkp68/Fz9rlw6WKMCxgw/xLPRCJxa/IP/dZIMlZ0dBgGtmxTCpxfTEzRzi05CyeSHFAvpZLQfZmmeIhB2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679857; c=relaxed/simple;
	bh=DGN16H4IRg8rut2+1xYh5AWMXaZkabwUNnbhnl/apG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcwsqzkS5b8oaWa8HVTUnH5nTSNUlzJeeQ8/zhZ9Zgb/UkyItLKVxZHwXmvm1DI3pDJ55O+5HV2clTHNQSzJ0qCAhU7vzrh4vNgdN27DWVCWrhP1RMyz1sxKG9VPR3gH2R74nRcaf6+lKfOpmkRHp5ufjyw/kZXyFBYJio9cvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FkK986tG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ocsn006132;
	Wed, 20 Aug 2025 08:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PDhUYR3sEIfa/680HsEZglzFXFg/RoJHufmml9cCY1I=; b=FkK986tG8uTZtqQU
	edqSiNpGsxofQUuc3Rla0ExXf0VhuhBeVjGjC3f4GXzRuAG9QzqxMqH4/NasvM96
	cCicTjs30aJL9oxjqEmGfTbwNrwccJWmDmiP2F/uCtTXlDCWWya4BkID+Ao7eqy9
	+oumot8qvu1d7g+/Yq6evnD4m0g5od0qhLqHHjOnonKRPhz96UOTqiFdt/HlK1MV
	EgIO4YP4KD1h1Vkduj2zWnp303kPwCCeeOXGA4n57qBOlUsTZrpSzWFfjBCXtK0U
	qklHuVu8hRuFMkkLw/cTr+LQn1y0ZjjMEnEEEjPbHQ6QyLXmCWXbIlAlC8nCGh18
	GysA2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57K8ofF3004942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:41 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 01:50:38 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [PATCH v4 1/3] virtio: Add ID for virtio SPI
Date: Wed, 20 Aug 2025 16:49:42 +0800
Message-ID: <20250820084944.84505-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820084944.84505-1-quic_haixcui@quicinc.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a58c62 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=KqJd8QcNxZFF0aacHC0A:9 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: BZTcXPoPtV-mEsrt46ZTJ7zMnVW2iGWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyZRf6nET3pZp
 6yl2UwmNXQsGz272ilbAlSU20kClwOiFqrIuL+BnsQT0UcX7mSPfkUBth88biBdRsNqUK/FxYri
 c19mQ+jaCEcXR0yAWHyS8TKB2flcpZGtag3oypbsMtCJzHsiBpJO9cK/E3bRpZFmHXyu48j8rBj
 jjGZD54pJXEFp5tbd078z/rHTsB+lUGwqhKqzNJsMU7tkLNJKWv4STtW3DFFJS4hB51YLeIGeXC
 LtOM+LwI97yzx3wiuFbtrIXcn4t1ypJMAc+ig4T6vprKDuh/VFWaN1TlUluILBu0c4FRwvooJV6
 ip7ltau9+4C4Vq9ATIGDUm1X/NFyhI7veRY49eg+0lZgbBoanrdft1KX/ZOt5bumNqVbPpTj4up
 joXQe5ZR9YhrD/S4XiurVf3W8UE48w==
X-Proofpoint-GUID: BZTcXPoPtV-mEsrt46ZTJ7zMnVW2iGWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

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


