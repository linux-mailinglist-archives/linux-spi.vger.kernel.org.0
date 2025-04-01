Return-Path: <linux-spi+bounces-7373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC737A77302
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 05:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D362B3ACC2C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071091D2F53;
	Tue,  1 Apr 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/cOfNPH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060233F6;
	Tue,  1 Apr 2025 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478628; cv=none; b=SA3UaPTgGqZP5zomf67PuVnB67ZhzMmIE70H0kuSoHNASMjRineAVkDJgPBHz5xAscUDnoXs/tcZkG3y5wgNqeYQ1RAmEQKby20SyXXemaKMd9bqzUlEwJo4opWUxlJbXAxB8SELjOmpeYkiHegn6BNQOOzQ1QvoMQsgsXPecko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478628; c=relaxed/simple;
	bh=xu/ZfzLjehCRWQridKnZI1nmh7CNlcYlnQZyyMWhJBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5IhnJjBb4DczDwlZVhOXOu9XQReHVwQ44CihM4S8F5LlVZErZbDUNpMBcVfYyqRn3m5CAj1NdNstVwK1fv/nImDuFm5LwfHq5kcJrpEBbd9ldQegfd4e9I6+pwh1J3bWvwJN9q0NhWXmasy9zfhn9YBeF0f4c8s+zVGjyaZOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/cOfNPH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VG8SBC031909;
	Tue, 1 Apr 2025 03:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBeOARODkAJeqSRUVJV29txY2qPxnEMOEmuD0asvTZs=; b=i/cOfNPHeAP4/flj
	YcbeVwSwuF0OY767AKDnOy8a7CaJHKBRrd7YXtyLB6l5A1nrcvi0NEk7eQBZ8mdQ
	vXjKrbDpIZb2iRSaLv0QmV7+0M4ItWtc6SWA6J2uftBRcPE9ER6BTUI0aivkVwR0
	2dXjZb9nujJk48wYYgoXTNKpHsDC7LLhD9j+iZgl5AvBm0xA0SNqnWt9cIHjoijY
	QqhfBRVKn0OwuzUsC36FAYniFdq3cSNRCon36RSJ5BaWNZ/Svqgi6PxvKNQXvLjl
	lFeWYHzTBTzLyYWTKTGtS4NtLI5b4MYOfJi/VXeCoBLqT19aXabD4FgvmYUy4JhE
	dZj3Xw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45qxa7sc1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 03:37:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5313axN9032704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 03:36:59 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 31 Mar 2025 20:36:56 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v4 1/3] virtio: Add ID for virtio SPI
Date: Tue, 1 Apr 2025 11:36:19 +0800
Message-ID: <20250401033621.1614194-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AxMM4RSBy42DQoWg5pEbqZhKVspyE31J
X-Proofpoint-GUID: AxMM4RSBy42DQoWg5pEbqZhKVspyE31J
X-Authority-Analysis: v=2.4 cv=J9Oq7BnS c=1 sm=1 tr=0 ts=67eb5f5c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=KqJd8QcNxZFF0aacHC0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=692 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010023

Add VIRTIO_ID_SPI for virtio SPI.

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


