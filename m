Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F23F5C3E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhHXKlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13026 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236339AbhHXKlp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9TXwm032200;
        Tue, 24 Aug 2021 05:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Urxhl4Qb0IuVZhyqVJZPru/u7ztljcpWWn3GCaoqzrA=;
 b=fCOn+upUJU9gVw2WB92CuVqbvmpUMO3HsTKsQ15NG2z9Jjnu51hPYffsS+Rf6kYhKydA
 k0HSvZeUrT7UZKLbQZulHI877wnT5cFhS1PextT6i/rRNBU8a+sQ6aXMPXTGjTQpu7FI
 bxIVXxBlzCxbgpzqtcQfbMRcvDRtW/XtAFkGBh9FxVUhQ5UYx8N6eNxvZH/m1oHA1VR3
 X3ZkWHNXEqDmG4Klh/eaNU8h4EBJiidAuvnF5OI2qr3C6xYmUfLDjapC87w7IS47D7MO
 yy35D+Kka3psjKeWXFam+NeLUgDJi82unm7i0zvNC67SH/kl3VW+XrLjrricc7VA1atj Qw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3amjmq8wmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:40:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:40:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:40:55 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 23E072BA;
        Tue, 24 Aug 2021 10:40:49 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 1/9] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Tue, 24 Aug 2021 11:40:33 +0100
Message-ID: <20210824104041.708945-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oMLmr4mPeWacfxMOAEzYu65nb8i0--Dd
X-Proofpoint-GUID: oMLmr4mPeWacfxMOAEzYu65nb8i0--Dd
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set regmap raw read/write from spi max_transfer_size
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-spi.c | 34 ++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c1894e93c378..603a4c1c2066 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -109,13 +109,35 @@ static const struct regmap_bus regmap_spi = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
+						   const struct regmap_config *config)
+{
+	struct spi_master *master = spi->master;
+	struct regmap_bus *bus = NULL;
+
+	if (master->max_transfer_size) {
+		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
+		if (!bus)
+			return ERR_PTR(-ENOMEM);
+		bus->free_on_exit = true;
+		bus->max_raw_read = bus->max_raw_write = master->max_transfer_size(spi);
+		return bus;
+	}
+
+	return &regmap_spi;
+}
+
 struct regmap *__regmap_init_spi(struct spi_device *spi,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name)
 {
-	return __regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
-			     lock_key, lock_name);
+	const struct regmap_bus *bus = regmap_get_spi_bus(spi, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&spi->dev, bus, &spi->dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_spi);
 
@@ -124,8 +146,12 @@ struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name)
 {
-	return __devm_regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
-				  lock_key, lock_name);
+	const struct regmap_bus *bus = regmap_get_spi_bus(spi, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&spi->dev, bus, &spi->dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spi);
 
-- 
2.33.0

