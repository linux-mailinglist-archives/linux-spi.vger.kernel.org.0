Return-Path: <linux-spi+bounces-8682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF36AE1247
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 06:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435A01BC4B45
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37E1FFC54;
	Fri, 20 Jun 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UuBJ6Y1m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB711FCFE2;
	Fri, 20 Jun 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392800; cv=none; b=WphSPDVh7lzw0QtxmFkxNccECsD83t2a3TjgQRCsSVL5cYGM+SAX9AfybhZzuL7627PYZstGGwsno5SSvIchkQUeVxGrcZQtJM21Qg32ic6rANtwNvltGI5IHvmPrvH/osLlhssliYJT4sBLVYjZdke0OMP4JRrreq9ZWbMpaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392800; c=relaxed/simple;
	bh=7wJzoEv8YDNZyYETeC8ZRHjCTW6ZM17M2gsTP78Urss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY2QMXdFlKDteEiHC+doO6iwt81/FrErVncBeOwijJRw/qZO7RefP/2S7ywcgaLI90UXoKdbjmCQQ7y50uUYpeaiNzE3gRjrvYfpYd+yp7dRC1FMUW9Vx6auNJ99+Dno23RrHaTkGYe5gEGzubmF7HED83fvAaWsHfbyxBY7N1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UuBJ6Y1m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JIe3E7024378;
	Fri, 20 Jun 2025 04:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65cKja2++68EnoivUXPMGbaeXz7WwEYJdjlAIZT1PpA=; b=UuBJ6Y1m5FKHOxaV
	VVquOzTZrKnofTUxAWQYyl2JOkKzO8FVvNXCn48bdn0qFCIL6ksm/9hBYimNWIxC
	7ZfoUw3SiyZtLGHmcUbPOh2O2NiRgH4ucXC7Q5oWIElYIo0DjsLLZk+GV1R0dIzp
	jdKUIgh45Aq4c339qfSmJEWuFMtn9etRn2aepd1WnSA3n5L64rkVUrfOMdQ33UlT
	k1kpmBWoUuLzYm2x0uXqrAICVJ4zgOnxe2xp95/WJ7U7QPAhecdKw9jFgx2Yzv3k
	HL88k2vdfkc6Fg32btBJb3MiSF6t6DtHs25TA/I+95oRGkTGIj0kjPp6mY8SUrmT
	3lp27A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47bw13e095-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 04:13:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55K4D4ZS014874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 04:13:04 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Jun 2025 21:13:02 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Subject: [RFC PATCH v5 1/3] virtio: Add ID for virtio SPI
Date: Fri, 20 Jun 2025 12:12:28 +0800
Message-ID: <20250620041230.731504-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620041230.731504-1-quic_haixcui@quicinc.com>
References: <20250620041230.731504-1-quic_haixcui@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=QbBmvtbv c=1 sm=1 tr=0 ts=6854dfd1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=KqJd8QcNxZFF0aacHC0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1CVezG6BQlDKWsGyVdRqCdiGYthjtn7n
X-Proofpoint-GUID: 1CVezG6BQlDKWsGyVdRqCdiGYthjtn7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAyOSBTYWx0ZWRfXzY0etZ4TJsHm
 1MvvoRHa7g4zxTqdZ1bawGpPT2Ju5o9wibWfDORtVIx9enVz8CbxO8kDL65CnpCrwzTZhXgm3QO
 251bF3N/VxE+igeB99ewyRGLVBrszcGjmEK6HuHO78pdplKRM+g9LGYJNVrwalpOXBQK66K9ANU
 uKaj/7tc3J+qgy+t4AoIbMkQcyCL1xGQZhaYzkw/YpySFLLSPbIYI6Ky1n/SRotH0o29+Y5KZsD
 i0MXEABEhTrAUxG+zg2qV7zdh/p0NQgwjr2y7nEwHt8/ix5sYlFXfrWvK/ZYG5xZbaIOi0K+YCr
 526Gr7iENku8SPXvzdHzF7oBq/8kb07jynHXVij9AWu3T0QfyhyX9iyLdM88C8CKv0xeJr7SCLV
 LE+d2S7RFJ/VKJO9SnzrWwaBrZWum7smKien6czVQ//suMROm+nKFGKzwVAHj7Dj/9a5+y84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=732 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200029

Add VIRTIO_ID_SPI definition for virtio SPI.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
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


