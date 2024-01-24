Return-Path: <linux-spi+bounces-724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDC83B035
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D07A1C259FD
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3597CF33;
	Wed, 24 Jan 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="i9+cPUf0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E88003A
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118074; cv=none; b=QgcoX82/r3+Ld8LNdC040KnRNDCi2NcBLufhRrbg677zTVToC9OSqlj7piMLNSUNV43zpu8vggPUUr65HyAJYg/tkdDcLQiefTlh0r+4m6Spokuf9dvk+HV7P8Dyv1DbDgAIdc+wEoEtmS0bELnof0p/wPLsUz0KBz8qUw6e/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118074; c=relaxed/simple;
	bh=72p4Kuscfbf3IVe6wX0vuLXgtQz14gxJe0bRADDXkaI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtPV3CqrYKp6hWMjuO/y/Mo22BeXGPA9SMjRg/zGblVPaxuVnh+gd2BAE4RhpFpxvEXjY+i+N2WRqqutcGN8P9/1i+S+g6yVQj+STXTLePeYdQ+kto5mx13eGiUW4L28FBwsg7sdF1NORDLGBRa9L8AlMCUrKAdYIywhGLIVmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=i9+cPUf0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O6RXDs022084;
	Wed, 24 Jan 2024 11:41:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	ns7IfrZLB38Af05wWO2cr1OH3bndTb5+XuA0J2Rf/Q=; b=i9+cPUf0w/Iudg9Gc
	Ti4flVzjUuqMWUcQv8mE/BiHmOjtYbb9OCKK2qoI5d/NG/tWKW04B0NiAh/Rp80k
	QEl2/Xci5wpfhH+M2ah47P9J0WxLrv5rFyFqveJvKilsiu/7Q1hp9Tv1vA9w/f1p
	ZD1ApYoTpAOx6lLr54pB8+RIMD7omO4eTgU2wLDKkBgR5oVyCG91XAtza1+/hXgr
	0pNWFUYOHuXHvxmijcU+9y8/8O+IvSqkLKXaE3TzpJDRS2g2TpZBiY+xZDN0MZ9T
	1OaRgM7ZYWtLSr87yOEnxYqlOPuTyr9o5HaHfSvi5+w7xrV/U/mZ0/hS+/tzaDRu
	9mdeQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9s6d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:41:02 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 17:41:01 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 17:41:01 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2915E820246;
	Wed, 24 Jan 2024 17:41:01 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: cs42l43: Handle error from devm_pm_runtime_enable
Date: Wed, 24 Jan 2024 17:41:01 +0000
Message-ID: <20240124174101.2270249-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UiYldDu7Y1TOnbXASJShSbkFyWkSBEaL
X-Proofpoint-ORIG-GUID: UiYldDu7Y1TOnbXASJShSbkFyWkSBEaL
X-Proofpoint-Spam-Reason: safe

As it devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


