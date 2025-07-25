Return-Path: <linux-spi+bounces-9181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A90BB11B06
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435423BA973
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F772D375F;
	Fri, 25 Jul 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UgDHtOB7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50712291C0C;
	Fri, 25 Jul 2025 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436551; cv=none; b=a9xJukqJc40JzrE419Q4Itx5rEVhUSno9UhJyo37xjLuaioYbC63KoCaZGBFKlZN2iFEDUKdcSWM3oMLhZQ2b7O+3zNvQO+Dg4WYHGkTiq4O6D/0/aW57le5/LQdMSzGRCxK4Z+xynlJi/pvyXU4X0xr3oHA81xomgUVSL2HwXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436551; c=relaxed/simple;
	bh=/IBb7+LTP6cmj5/A4mrj2PGqsR8Iyl2GnppMuW6apLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6F06OS/G7rD/xMOqBjZtBK+Ek6tMeh7J4kkwxEjaH24Kry5//bkcQCMUfj1LNVYBNsjzHyPoxO7OpintQ6huRM7zD6eFFB9YUk5xTA6prGdFcocN1fEnQyPl0B/zu+k95qrxFABjRqn+kjnaNhUn8HNnqtvI9qabQthPNvb6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UgDHtOB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8Zi0s020198;
	Fri, 25 Jul 2025 09:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ybT1jZUipKFwWrgjpU3Ns1hxDG+VuQirLlnNaCMzV2E=; b=UgDHtOB7TY++Q+nc
	RtLOrzO3SqJaj8XwBdl0+3fgrtDFCU1r6p2MALsW1Vnj3jqct3ZxA9Zvzlcsk4oy
	D3u7IiZ9ve4UOUIDj497I0Zc+l/1eTX51BOH4YizJM/aHoDyxXgRBf+Q1s/5/OjN
	f5uK63+oI+u25WdjtviDqH+eT8nMBa5Sjk/AKOhMGMOV9ogVeWCBUHblz08Oci/t
	+twWDzozF6Dgoy9q4knSutwgDoa0RAb4V1COeF2i7a+ov5kHxG7Jff8TTc5t0VZf
	Mrba/lzDr+xG1LjTrjHH2ww4LoREsNt+Od+03gH/WsT/ZpHugB8CbcOARqBjDCfT
	UX/KOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2whm96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56P9gFt2016985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:15 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Jul 2025 02:42:13 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v7 1/3] virtio: Add ID for virtio SPI
Date: Fri, 25 Jul 2025 17:41:42 +0800
Message-ID: <20250725094144.1783243-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
References: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-GUID: 0pFjAUbbbjT3FG5yx18-3MEpo07rwCbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MSBTYWx0ZWRfXxdcMLrLiE6vP
 J/IbB4CYicpePgmkPWpeK2z75n12dD3HnPLRvVf2yfFlIi+9fuNzzTJryIcPGearwV5OZgzr/nz
 ldZ98EowcxWLzfejEs6JQq3/b4BKQyMMXetwYdeg6LOwV4nj9iYJIX/uEbRJh5AuMI1LVDxLxt2
 mLc6OzUmg7+zRLdab06lSuSiNrsdoLDjdViI/sq7qBp6F3fw5Hg/uZzvYpP7riZbfzhdzMJXPVr
 KetE+3W+33XwrXHCbiEk/OCtHlCs9IjQQ7/UretVMnaD4xiyMb0YxO+YJsGGX34+AjxzjueTRGO
 uIypG6kb2fdT9h4HxM2qL2uzK1iXmNBcc7IN+4DX8547JCkBCFolCl7GpcrYCOKZrHrkSFt8VoR
 wt9ZRYqGCBCMXbWH9hcvDKhYx+3/SItcg4/IvZs/pyKdhi9ZGyc7s9h86V+K6RDiyqxHhPTz
X-Authority-Analysis: v=2.4 cv=d8b1yQjE c=1 sm=1 tr=0 ts=68835178 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=bs-e4Z8cAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=KqJd8QcNxZFF0aacHC0A:9 a=YFpLQiK6rFjqGb8m0bXF:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0pFjAUbbbjT3FG5yx18-3MEpo07rwCbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=898 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250081

Add VIRTIO_ID_SPI definition for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
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


