Return-Path: <linux-spi+bounces-5280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FDF9A6762
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 13:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B701C22108
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C91F130F;
	Mon, 21 Oct 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FDAmz3LM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438DA1E9067;
	Mon, 21 Oct 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511857; cv=none; b=qnjlRE6ashupa5Fr13MHmM4qhNGH71AXyEIe84yLvFxH0PXBPFR3wt/1WhLV03Ve3H9qvmTRuWnJblNQRqMrQIbxSBRbjY8Ikg5jSfpoalNYovRMj1GfFLEFn8p9w5bHo5ozGC1cLgS7BDMT8RBCw9FwU1vlk3RW1RAktTKIKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511857; c=relaxed/simple;
	bh=2y1GCQZBRBYZS1sVf+pkOo6lue4Idv5rJvJjFwqyFw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNGSJYp18jdIcIh/iPuCn0/4/tq3NsCTI4TJwjF33tcVECYYk5MwzpiB6MQq7dC4q2+DdVPGRGZgL7Ts6/mtcQGMXRwFHkeRN+QBUAMwaFSgXe3KwanlVQ/eAAaQCkxsj5YKvMrLoY9YPKv91juyUObhksiLCxDJbBPlg3wSzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FDAmz3LM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAfqPV026569;
	Mon, 21 Oct 2024 11:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbr+kpcekDk7H3+i3QQpglOu11PBbfEMDlaz70GM/2g=; b=FDAmz3LM97pdH7gp
	whQLv2sQI/OKGeZuW72cosXYn3OMLnVv8rotYLRAYOz09AjhfZLyX05f8eug5htt
	vHBqtnrwbgBrSFBrODPDwjwwtOSym8hBaweeUcX9hs8HhNpOYxjKR+Gtn9BFnr7Y
	4DKe4sMeLXbmCREYDnalL1/ys4qA5Jnev1XrdpYEliU/xDP/xpEzF7sBvfkwm39Z
	Wvx4B2ezbCMc3tHWkeFo3shw78g0fXsSeKt0z1Vw3kSxYAEf0TiXZXwoHtl9rFrQ
	xsHCwf16kA6D0t4AfxwEcYz3yjk3lSaISwwrbTcbRvYhjEYPcpzwGvCgHUzVC1Ru
	jNEjqQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tsmgvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:57:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LBvNwN017333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:57:23 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 04:57:18 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>
Subject: [PATCH v12 8/8] arm64: dts: qcom: ipq9574: Remove eMMC node
Date: Mon, 21 Oct 2024 17:26:20 +0530
Message-ID: <20241021115620.1616617-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
References: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 3FzxB4XtOctpp5BDsjpEZKdYGyjPQyFn
X-Proofpoint-ORIG-GUID: 3FzxB4XtOctpp5BDsjpEZKdYGyjPQyFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=991 phishscore=0 adultscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210085

Remove eMMC node for rdp433, since rdp433
default boot mode is norplusnand

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v12]

* Updated commit header and commit message

* Removed sdhci node from rdp433.dts file
 
Change in [v11]

* No change

Change in [v10]

* No change

Change in [v9]

* No change

Change in [v8]

* No change

Change in [v7]

* No Change

Change in [v6]

* Updated commit message

Change in [v5]

* No Change

Change in [v4]

* No change

Change in [v3]

* Removed co-developed by 

Change in [v2]

* Posted as initial eMMC disable patch

Change in [v1]

* This patch was not included in v1

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1bb8d96c9a82..7b5e417f9b8d 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -15,18 +15,6 @@ / {
 	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
 };
 
-&sdhc_1 {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	max-frequency = <384000000>;
-	bus-width = <8>;
-	status = "okay";
-};
-
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
-- 
2.34.1


