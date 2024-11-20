Return-Path: <linux-spi+bounces-5777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F29D36C3
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2941BB274EA
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378621A08AF;
	Wed, 20 Nov 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S0sx+fN5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0619D08A;
	Wed, 20 Nov 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094182; cv=none; b=luLeDykMrGvAcolIk7/KVdomlcI0UnJ8KH5YIJadU/g2DRB8xMUJRA5xKShE6O663+b+DRkk9IH052ncnETTHPHkBFm8dHx0t34uoycQ5DPsCRXfXOLoxHalzObjY5SZ/PNkVyU9/PePSspPaMfCQzPCuNg9U/3Gf4gz+5ADAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094182; c=relaxed/simple;
	bh=BXO0i/olassXjf5QP9iGzjPNaUrAKvWFnPg1PlGscHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKpGkIfwPvaT7v7hg16sPSIDSrB0rhHN/+bOZfcWp1dMfKY4urFjaGSG6zmiCeBCQO0JNdCw123ihFoQMj3Elhq3C0KZMIpdoBrabm44UoT32SkbVrmYW0a/tL2vhzAa5NWz+6OJgNhn6TcmMFAhbWEm1F6IE6bVJGVgfpfyzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S0sx+fN5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FT6q005756;
	Wed, 20 Nov 2024 09:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHudzkMWQLn1eKAU5QPjN02Itk1xATGbZE50HDFL+a4=; b=S0sx+fN5ORiMKEkW
	bpGTpGxLHpulXb2vHXh5ts7LdVhh236hPH17HaOOOrD5YPtJ4Cw/jltA7AtXhL17
	xMLjitdj7EeZJG/nDLpvzTOKqldw865TqoYqDNFGPV2gYCwMwgAYjrc3s4ND5zRx
	AcyVP1rWq+f0YXGwkgI1aoRYCwp8DAZ39ln8g5tqiuewkTICwhyANZNYCxxe1sT8
	k7qXmWuZT/T20kDv9xCv9LE1bg1wOkFKilyRGw4f+19Om2XfmVgsIMKS7PNZCL9/
	Jr9dbRiNNeFOHNGa5bmNreDDx6vNbUNxV5ehc29MsaQT1uMIjDOSlkgUbClrrALz
	TNrrbg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7wbmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:16:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK9G9se025864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:16:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 01:16:03 -0800
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
Subject: [PATCH v14 8/8] arm64: dts: qcom: ipq9574: Remove eMMC node
Date: Wed, 20 Nov 2024 14:45:06 +0530
Message-ID: <20241120091507.1404368-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jczrqZ75UdeT7EsE3bJY8ac7Ep_5OGff
X-Proofpoint-GUID: jczrqZ75UdeT7EsE3bJY8ac7Ep_5OGff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=957 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411200064

Remove eMMC node for rdp433, since rdp433
default boot mode is norplusnand

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v14]

* No change

Change in [v13]

* No change

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


