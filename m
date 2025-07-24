Return-Path: <linux-spi+bounces-9165-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA686B1065B
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 11:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A24AE44BA
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFD28B419;
	Thu, 24 Jul 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d4Yw8Dc/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38728D85C;
	Thu, 24 Jul 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349302; cv=none; b=pZjPVeeHxgzaRdsqRF+wfAsxmSlZLiAJusDWvnd+uPuMaphlRoMN9HhQnUhqdbIlP6IGPbfKp5QhXWXWXie1VMiMePdoiH0XZq5p1w7/0Uo51ShHj6g2ZF60qWouUmnJScC4A8AwOgODKjx5Xw4oSwmsmcDt/Ef6JPOkLeNP5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349302; c=relaxed/simple;
	bh=7wJzoEv8YDNZyYETeC8ZRHjCTW6ZM17M2gsTP78Urss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUxdkspbR0yhDDG4ql6q1oPjKKE1Hc9Yu3cJbxkLVOOTicP47KJJQ9IS/6nmiDTNm5PperJ6x2LLO3bLaMXIKO+x0d6xahNP0Fvg/VzOQEkR5lJ+zzWINrG0sQ/EEPs6VD9lMrXuHB3kVVY1sj9QgzNDs+zNXxy+jDlBOvPNXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d4Yw8Dc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NNsxnP006839;
	Thu, 24 Jul 2025 09:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65cKja2++68EnoivUXPMGbaeXz7WwEYJdjlAIZT1PpA=; b=d4Yw8Dc/1Zyz43nJ
	UGc3jzGTSBxjw9dLPMo3T4hldY7tse0PO9OppDr+s96AQ8gJwgVFPbSS+Q7FJ3SU
	UQtgHO+vDJ1blRPB1lVy0lFUKYjrZ7tzmXZdUwWRQXMWyl8e2VxNwuiY/YodmBKd
	UZVAg6qQ0lFBK7Iaas9B+EN4tWPKtbghWO8e+pfRG9Fg6gPwzeTkcLY1Wl6NX1T7
	+pDTZ2lGF7vzlbzIi/Cy4Rwt1pnOMO6W7BnUQ1Sw1sGCumkB0o0J/8afbQE5NOJc
	K8AbawsYYBm8YGiXwVHeexwnxHy30VNxgCuLVN7oyZ6Uj0r5/gkoQcMq7b7ywAbh
	cgg2ig==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6tbnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 09:28:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O9S7Ah024508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 09:28:07 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 02:28:04 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v6 1/3] virtio: Add ID for virtio SPI
Date: Thu, 24 Jul 2025 17:27:44 +0800
Message-ID: <20250724092746.1297608-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
References: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6881fca8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=KqJd8QcNxZFF0aacHC0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dY08A8xdfczXxpBTs6pMZnNLo0b89kPF
X-Proofpoint-GUID: dY08A8xdfczXxpBTs6pMZnNLo0b89kPF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MCBTYWx0ZWRfX8SnWJNjowVb/
 rFwu3yj+LI8RavN2cstCB5Db/OdOnyuQ3bfclnC39S5bgdTTTEeeZ+b5orelOqGUMWZvz7qybBo
 07ZfN7VQBTNlVklXzzAGwJN/tBFYTH67Pnz/hBtaYfxbxc3WJEcuWkznPqSta3IY/nXb8eO0bbL
 veQhTtQgNZ3EU/lBh8U5oO02pCDWKGEP1K7xzelB33ObJNLifZvWLxivuuGjiRDch83Y7OHVRs0
 iOukVVkcyZBCzSlWRnHhhyPZq+Wua0WA/Ths1RQs9OfMyf+Z0Y3I1m0pZuTsCIRmXyErLjM8nTG
 bMGQ7cK4FkWmZU0VnaRoGs6hQq3vKZBrzxvlou89KM2YDie8Zr0dBzkNuoPuTW+ZipOK+XVVNW4
 c4uKG3eWay4+XnF/ASeqHvYcypWtr4OcgL0ykV5+eCQG6usuSi2wjzIWgWce9v/4zyLkidtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=743 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240070

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


