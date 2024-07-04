Return-Path: <linux-spi+bounces-3744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F74927763
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76711C21EB8
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2F1AE84A;
	Thu,  4 Jul 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WlCDewYo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C431822E2
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100740; cv=none; b=s0BJcFRLspWNO+Il88qkF8aP/t5KxX14g7CBt8zlZ5Agu31c2mwcRj3HAbRw0yQgQsWTEm15S2z556nJuKvEg9oVx0GZpByMAWUXDOSipFI8FjKu7dIu/+5tz7y4xljoiuF52by8Afg2oU/7BZgwn09LDqQRfcHwZsNAXHYuZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100740; c=relaxed/simple;
	bh=RrtTVpvwS/DE30xyPPUREkIz/Gyd1lqUJrSjAxJi4hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JJz3mhbeUeaxBB1jDgg8H7D2SlhFkURXlPstjJJupFPT1YL5TgKada/8DtFXFTqIVcVFO4fAOi1HNPJEJJe73bvvwIbhDdK9Z6SGbmZTxf+0fW2CSefwsvN6MkIYt0pe+H6BqTN0sf+NxXTZpbK47Dg83TImPMJXT+srbpue3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WlCDewYo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464D0KtF003575;
	Thu, 4 Jul 2024 09:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fFkN0
	zoZ55TaLNEL1zq0ORFIEK3OjrjS8Z8pNP3h0is=; b=WlCDewYoieCFXJr3Nlawh
	cdjpP7EcHkwnvLnps7RRkdf0SkuMP4RlDNHK6THEly/St4P3qAPdQWAjW1I/cUsi
	nPoO+saK3L/r4q8JBogtbNQprvTTVGQh8RLHuvdxc4hWqM/v2XgObGabrnAaYGNl
	84HsFu57Z3qoMVf5ygkgugxY19uU+GntIAxQRueilBwy5v2ELAJKvrQojCKac6TV
	vcdpSR7bHl0e2Kf5hLV2A1TjV8kKPhbyNKf7wPQpDcOl4LcBPCD7yRL6YLvvZrA0
	Aqc61/YpLs4zKoN3l+dgCr83GbNz9CCOLbuH9w7YA6OR8wUzg/xlYRoaGGTSzdiT
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7nbjmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:45:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 464DjZlG000913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 09:45:35 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 09:45:34 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 464DjPu1032622;
	Thu, 4 Jul 2024 09:45:31 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 15:49:13 +0200
Subject: [PATCH 2/4] spi: xcomm: make use of devm_spi_alloc_host()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-spi-xcomm-gpiochip-v1-2-653db6fbef36@analog.com>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
In-Reply-To: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
To: <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720100959; l=937;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=RrtTVpvwS/DE30xyPPUREkIz/Gyd1lqUJrSjAxJi4hM=;
 b=g8Y36Hsb5MbzRiPPoHflVSTcQ+eeXgqqdjw0P2xoRkxyWxd9pU8yoPbtsaMQqsk1GBUjKn7ku
 jd3kql9hrYsCJvZmipWGzMXzAS6PPeTy+czP97mn0plhPwuR9NrMduy
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 0GSUtJqCJ7zs9SRIgj3qznRxlSbvpcCU
X-Proofpoint-GUID: 0GSUtJqCJ7zs9SRIgj3qznRxlSbvpcCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=593 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040098

Use devm_spi_alloc_host() so that there's no need to call
spi_controller_put() in the error path.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 358e0b84ee60..5a27eaed4183 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -261,7 +261,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	struct spi_controller *host;
 	int ret;
 
-	host = spi_alloc_host(&i2c->dev, sizeof(*spi_xcomm));
+	host = devm_spi_alloc_host(&i2c->dev, sizeof(*spi_xcomm));
 	if (!host)
 		return -ENOMEM;
 
@@ -278,7 +278,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 
 	ret = devm_spi_register_controller(&i2c->dev, host);
 	if (ret < 0)
-		spi_controller_put(host);
+		return ret;
 
 	return spi_xcomm_gpio_add(spi_xcomm);
 }

-- 
2.45.2


