Return-Path: <linux-spi+bounces-749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7D83BEF5
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A71C20866
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258821CAA5;
	Thu, 25 Jan 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BaI3eVgN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B89C2C68A
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178873; cv=none; b=mEbUdczB502Jzvna7gj9eD/QxJNoGFqzrZPgEVPPQwwhfQigFrBc/uQALekFVGLF2Q73VqSFPLGqkkbN9z9z8RJLikb+iJtYs1kWpwyYgN1a3pXWWr+/meM/NDpbBXNSaJh/eNFxwBStT8/w4xXV/KDCQIIiEizDO/ebOhde8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178873; c=relaxed/simple;
	bh=YWtOHQQ7t2VXiqjHq/GU+98TrwZd9oUTMpc7Q5w2H9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyT1F5/nYrt9M6VEMTd0cqwjiLsl4mQ6MOj5+R22RHajmwFp36sqVyLS6qR4JK/5R39uGtn+1lwtUU3bwF1JTjw7JBpbGD7R/D3GIrnaMmuQns+179ScFo6ZeOdwWs9QuM2j4HeQCp/x1lYxUY7LeuZmAhZLu1sWgzYUylv656Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BaI3eVgN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P70H41017510;
	Thu, 25 Jan 2024 04:34:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=B
	cs/87LvPelkHk21dQ9vyYU2UDaPA8MDbkS+ZSLEb50=; b=BaI3eVgN/gopuTNX1
	hP2MFW5SnC4qTxZ225S+oVB7kuPhfVIPY+gBQzeUw8hxMoOuTNn1np7kT/ra9x8l
	Bn1KJEdHBuqy0Ry9WZ78myAAcH4SBCdToHtc8Vcc5+v3rWevMaxnsWZSFtPYZdjn
	zi9fGGnUCjhp0zlQv0Gg1EXsHQUIBvK4rS7DmzQnCAqw4b2H5oDBHoGhMQcTDq15
	pdSriKqGzKb2b1BsnesPtJsMPEWBg6OlgFv/GHkQhIMX2MB5SAVbYtW6akLwf/zn
	xRJ+qrIvssTMNeUp0CX1xkxAE+yNtwWPezDJHWii5NEMBF2dt2D6KAUDTpx0gKMz
	JDtLg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:34:28 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:34:26 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:34:26 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 718A2820246;
	Thu, 25 Jan 2024 10:34:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2] spi: cs42l43: Handle error from devm_pm_runtime_enable()
Date: Thu, 25 Jan 2024 10:34:26 +0000
Message-ID: <20240125103426.2622549-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QOQUF46GP6uVmBEMMeByrJ9oR0UrPHXW
X-Proofpoint-ORIG-GUID: QOQUF46GP6uVmBEMMeByrJ9oR0UrPHXW
X-Proofpoint-Spam-Reason: safe

As it devm_pm_runtime_enable() can fail due to memory allocations, it
is best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Added () after funcs in commit message

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index f13073e125936..b24190526ce96 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -244,7 +244,10 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	priv->ctlr->use_gpio_descriptors = true;
 	priv->ctlr->auto_runtime_pm = true;
 
-	devm_pm_runtime_enable(priv->dev);
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_idle(priv->dev);
 
 	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
-- 
2.30.2


