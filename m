Return-Path: <linux-spi+bounces-4729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56BB9713C9
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938192837B0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013A1B3B2F;
	Mon,  9 Sep 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ypA+EAIw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3021B3B04;
	Mon,  9 Sep 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874295; cv=none; b=fWKEkwJqBj6gITRvBs9WhhMKSG66l1tAWo2rC3haKCFFmA4pofFMl4+pZDZ1n19gUH9gHrlkADIeRC2uYCyMA8kendTWTncn/LxwjY5tFJMVLvaG330g/iPDzMwvXtiTLisDWVUKMr3564szMb79wBE+fsG1LlHS1MzFe82ZSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874295; c=relaxed/simple;
	bh=XA3DdfL2XYRpx2/k7njmsw5YNThkxocb9+WoSA1CKBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVOF0y8bq4+4KVpzRPFMfhh9xiTWfDlPfXybUkHkkidG8RbYMt5PUTu95YAXTcflqZ9cYfEZLXRx6ci/iR/PjQbSXcLa4L+zjGFFSUZxzkgnZm0wrJxWoI+QbZ8McR1af8kO/nCiMle6tpULwuHeXMAYYoYrBHoobFAi2orZgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ypA+EAIw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4896PlLf023531;
	Mon, 9 Sep 2024 05:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Nbc8Qz61PBSxjwHg1MCXxzPaBnQ
	nQlM2CqiqLfPkmxk=; b=ypA+EAIwSvratQ7z8wMQBvxMFNvk8lxoXPsR3RyeMwN
	CRBX5hGA1hmwubWAr2p9eTV6L7Z4QD1VhTp6A4uKPT7rPGikuWxdva0VI7gwN6rS
	5doPJj6sA8Nug87L7NSGw4Hj4K3OfqMobdowZNCMknteES9hNiw1ckx1CJ8DFCFh
	qJRtGOgsbi7ajpI7XgpZUL93D7eYYXcBZAwX5agGLh7+pgzkjpN1M7212bbzgjBl
	DiBe6KsVh7NwfHkUERdQvsXXbqsAF78QlU5i0nySp415u9ye4HQyOJzXx0ETR8y8
	TL5TReTAyO47nXn4UcCUzFlbgnxNZvizzjdpduS7Esw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41gybdce80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4899VM0i004586
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Sep 2024 05:31:22 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 9 Sep 2024 05:31:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 9 Sep 2024 05:31:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 9 Sep 2024 05:31:20 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4899V8G0019340;
	Mon, 9 Sep 2024 05:31:11 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Mark Brown" <broonie@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 1/3] input: touchscreem: ad7877: add match table
Date: Mon, 9 Sep 2024 12:30:11 +0300
Message-ID: <20240909093101.14113-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kMkMEO2tDqRxyFi7GEkmFG9vFh_964JA
X-Proofpoint-ORIG-GUID: kMkMEO2tDqRxyFi7GEkmFG9vFh_964JA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090075

Add match table for the ad7877 driver and define the compatible string.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/input/touchscreen/ad7877.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index a0598e9c7aff..7886454a19c6 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -805,10 +805,17 @@ static int ad7877_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
 
+static const struct of_device_id ad7877_of_match[] = {
+	{ .compatible = "adi,ad7877", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7877_of_match);
+
 static struct spi_driver ad7877_driver = {
 	.driver = {
 		.name		= "ad7877",
 		.dev_groups	= ad7877_groups,
+		.of_match_table = ad7877_of_match,
 		.pm		= pm_sleep_ptr(&ad7877_pm),
 	},
 	.probe		= ad7877_probe,
-- 
2.46.0


