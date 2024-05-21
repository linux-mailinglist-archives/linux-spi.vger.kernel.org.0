Return-Path: <linux-spi+bounces-2971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FB8CACD5
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF76628552F
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08D76405;
	Tue, 21 May 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CWt7wYEE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA778757FC;
	Tue, 21 May 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288961; cv=none; b=EunqAnAn9B2VpuvZs52HsVr7o7Qbl3nbqEfdmg3zMNwRZlkjA3LQWwLGem4K7C3fpTT856ajKRZwYXOZWKRDAlLZQRxjJu7WaAOxsyWf/T7hPMvm2okxUCQgTZ9QV5ddv/PMOte7nMoXEJYsKTKAbGSEfCKONg1CwpQQXTlKkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288961; c=relaxed/simple;
	bh=e8Lmm/G3KHiwDcfMbg+EQjmTHI0jYoiscjJWeGQwKf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGdT+t1jdNLGIHdi5035JX90QpgPgjTtmlOXcZoG1CjBTX893FPB/BcLyYGcU8OX3NfbyEhV6BnUm0FJvPAVgL9rUHdY+SEWgQKR4uzvA88d/0j/piA0tIy+2sQJOHcGLSV6HNFhXKxrm79HSEODwz62sZN7brO2dtrVxKnhXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CWt7wYEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L4vQHH032376;
	Tue, 21 May 2024 10:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=223KGTr
	csFBFEhhBbq9RgYZbruTGt0fHyuJCbF/lWcI=; b=CWt7wYEEfLBRsM9ZVXoO3MP
	PIS4jO2ht0fqSIntvzl8bpA3KvH8YSuQ9girrZUInS5iX4mdt7/3nCBzq2iSAy6f
	G3et9BMIbDIta/r91Fm5kNXtS1T5dUMY1xuCyK+qxNw5Mzyct96w+azOGCuXLVz/
	e7zbokCXOb/B2BUZZ4nHT1K/SrhkpIo8kKqCGNF4UoYDXb7rAiI5LbT9bldzRhgJ
	fyR0H17NFiWLKInbYDhovTBl2J5LhaztWn4m1VB7HROKLjaCMNtT5hLTzYOUHWgO
	aVDptt9Yf0KSQHn7Sky15ISkKaPWTYVCxG3o+CimJs6kRHk/GH2/IDSpwY8rvCA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n45nmfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:55:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44LAtZnc024604;
	Tue, 21 May 2024 10:55:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3y6ndkytmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:55:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LAtaab024635;
	Tue, 21 May 2024 10:55:36 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44LAta6J024627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:55:36 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 3DABB4166E; Tue, 21 May 2024 16:25:34 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com
Subject: [PATCH v6 8/8] arm64: dts: qcom: ipq9574: Disable eMMC node
Date: Tue, 21 May 2024 16:25:32 +0530
Message-Id: <20240521105532.1537845-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 7agHEvbHamyF6OIs8Vj1iB1ZgmzAIx_9
X-Proofpoint-ORIG-GUID: 7agHEvbHamyF6OIs8Vj1iB1ZgmzAIx_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_06,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=909 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210082

Disable eMMC node for rdp433, since rdp433
default boot mode is norplusnand

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
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


