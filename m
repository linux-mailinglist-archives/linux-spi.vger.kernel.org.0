Return-Path: <linux-spi+bounces-5554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8B9B62F4
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094F82820EE
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C671EF92C;
	Wed, 30 Oct 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LkGONrG6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2861EF0AE;
	Wed, 30 Oct 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290838; cv=none; b=ucG01XGGsNIyDHRp1HeM2gYRxzBgiiGsmp9GmfYWFV6qLk56Q9J0qnyRqWTkupx86EeXkgHrQJL2kLUUf/ApxKeoR9raucucLe9PkTxSe8NiYDlPaKj1qh7sRuroo1LNiJc3iLmnufkUaNOB4i1EtdUL5lsl3eGSrYHrK0GWHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290838; c=relaxed/simple;
	bh=esnZ/WUMhCBQXUMRbAGWMLNa7kL8sal0QQHDsx1Izx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpvQ7ZahNNtkQVMiWeOk6Nn0/nmPAjQpcb5fjkjTWCbrYBFHBAsAVAcso8U4NA0D97dcUP9jdSNwdcNEpbTMSYLVvtoNWRVzBpLUaGBOFSQMmNJ7NXiPL/FQBYcIT8nUpssF99wdjgvcljb7jsAkr/FaQDp3PKkqgW6X6Uafujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LkGONrG6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UCH968019847;
	Wed, 30 Oct 2024 12:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IuB0eUQbkbzpEAymP4QNA7JJ5H04aMJuPqmc51iNaR0=; b=LkGONrG66CIkMlXt
	lssRhWARJoZ9KYAXYVCqijIDTf5r1mg4hUn6Al8dkMMzkPhm/h3RyOnYmFrjn4ok
	wzNR7+vePfnZyoUUHFSVo9rh+vcINbB98hVgT77oYbgVOTzG83RRh9UgJ1VS/XPI
	MigcoWyG8g4gNG+93MqIQAq1Lx3Mji615zdBQKM0MPwzVDu6DdYiS3lOUG1GaBRA
	9vNJqdbjzVf6bUh2Las/Pn6ZmAZeBZTSRISY2UWnHEwXMeh2xAhdIU8kAPt9aAOM
	GMpcsDQ/DuuPPmX4jQuLc5eFTEHNJSZgPdLe5tG7kUqvMut+wFfNljSEmo4V6ICx
	98vytw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmp0g098-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:20:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCKQ2w015344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:20:26 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:20:21 -0700
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
Subject: [PATCH v13 8/8] arm64: dts: qcom: ipq9574: Remove eMMC node
Date: Wed, 30 Oct 2024 17:49:19 +0530
Message-ID: <20241030121919.865716-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030121919.865716-1-quic_mdalam@quicinc.com>
References: <20241030121919.865716-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R0ZnfBVhFRSpJuKJKFpd_1eh7D_schIY
X-Proofpoint-ORIG-GUID: R0ZnfBVhFRSpJuKJKFpd_1eh7D_schIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=986
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300096

Remove eMMC node for rdp433, since rdp433
default boot mode is norplusnand

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


