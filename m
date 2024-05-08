Return-Path: <linux-spi+bounces-2776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896338BF8B4
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5531C212DA
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699254FAB;
	Wed,  8 May 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mFGvNTpE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93605D732;
	Wed,  8 May 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157438; cv=none; b=n/86FRzGJ52mrEBJxleVIWEAUUEUMJNwXfy9liNu7YltCcn3Z88x3Q/f5GC/J0gK54LvOBO2Dy0Nerp3Otd1RNr8OeQaGvRFpwOHPkxLEOtxDXJVOgpK+cs+wIZeQd7cjGWbjMTJrWFxKM7WYkLyv4y8Im+5Vd0FPQKHAlmcKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157438; c=relaxed/simple;
	bh=zk+rkZQRNPNENcRoaZO225vmxvmSCHyFLazmRlrdsX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A24H+oppTz0a9/yNIEEObVQwKJxC7Tz9jGLrrUjHRWV/WoSTy3pFQkBfHrAe8GzuMHAL5Xj7Ty3aNoY9l5ChA1r3mvdTO2lIgsSydanPaOJvUq9ROVY/7ZE1D4xsONeIpm1Q1BLtDVycSKZ5YeLdvjc/tPj49HNeemCjg0h8eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mFGvNTpE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4484HvOD024112;
	Wed, 8 May 2024 08:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=Zw+N9iI
	jWC73KP9lJ+Uo6L8wPhpEl8DKptpUJ/uaTQw=; b=mFGvNTpEEBkL6xaEDDa9wm3
	uwP01KXvJ1hxXTF90kyyxJN796RbYWD1Mwh7vwo2er748a3zjNr8LlE5DjbKeYUD
	S5/aw+jdojcfCkyspc1YPFPI3TT2htqM0KqZgNgI2LdhtPyVmqQG1Cqhe9yBNPc5
	9zfn9izFgKM3S+Xdufas8B5AqL2gCXr1lACJk1gJX+G+KjwVO5WlTyppdEE8gRav
	uD+Kjbgk2Ci/G3dZfZ30NuLrQoSY+9nOHPtLaMEmK0iXSnsUjzwbuBSkN2NTKgDr
	xJmawg8Cxr3Bv1l6TJWRpJMqiv8v29Lp8N8RRCer4U9IjHVFpgyG6fNnjOG/ZFQ=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyspmsatb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4488aQJh000652;
	Wed, 8 May 2024 08:36:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xwe3kwchs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4488ZBqx032296;
	Wed, 8 May 2024 08:36:42 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4488afBQ001246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:41 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 2418B41652; Wed,  8 May 2024 14:06:40 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v5 7/7] arm64: dts: qcom: ipq9574: Disable eMMC node
Date: Wed,  8 May 2024 14:06:37 +0530
Message-Id: <20240508083637.3744003-8-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K2uWBybd-erkSIcDoIiW7b90CwWA2Ytb
X-Proofpoint-ORIG-GUID: K2uWBybd-erkSIcDoIiW7b90CwWA2Ytb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 mlxlogscore=718 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080060

Disable eMMC node

Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
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

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1bb8d96c9a82..e33e7fafd695 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -24,7 +24,7 @@ &sdhc_1 {
 	mmc-hs400-enhanced-strobe;
 	max-frequency = <384000000>;
 	bus-width = <8>;
-	status = "okay";
+	status = "disabled";
 };
 
 &tlmm {
-- 
2.34.1


