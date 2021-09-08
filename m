Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE374038D6
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349307AbhIHLgM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:12 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:24582 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349197AbhIHLgG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188696pD006454;
        Wed, 8 Sep 2021 06:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=lYP8FSmBUjs8SycWJ3rt3zCuR4OjzNIaYSJ1r1nSyW8=;
 b=TNGVljtyZLgj1zHbe1uRGDCGb3yxi0eYM115eITXLV0VljQY7bfSdJwAgPOTx6OtLmVf
 kNXqcI83VH+Z3XGWSaoteTBjdO/t35MZzA+hFU6mYh4yVo89HenxGUXzdkqO/EU9+avQ
 fTArRU8E2ScvgB+VsStDI6NvVDYR+PtyMXn/Una73fRZi0etI4m1mLOno8cNUcwas1JM
 Uf+n3YX3yI+VOLeP5RXpJB+++SYk3xlFLUMNRQEukYTkJGdRZJ7sqiJ+jqfqIcmlhXq0
 +XWkYCIplVpJSJ/7rKLwW4y3R2KWg20uXvKw1Ct5oUo3VEAODcrzWvgjPIesxxJdBIF4 Iw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:54 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CEBBC2BA;
        Wed,  8 Sep 2021 11:34:53 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 01/10] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Wed, 8 Sep 2021 12:34:42 +0100
Message-ID: <20210908113450.788452-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5JH76MzFIRS97VJE7QeL0SPHl6wuzbYF
X-Proofpoint-ORIG-GUID: 5JH76MzFIRS97VJE7QeL0SPHl6wuzbYF
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set regmap raw read/write from spi max_transfer_size
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-spi.c | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c1894e93c378..0e6552e57ecf 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -109,13 +109,37 @@ static const struct regmap_bus regmap_spi = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
+						   const struct regmap_config *config)
+{
+	struct spi_master *master = spi->master;
+	struct regmap_bus *bus = NULL;
+	size_t max_size = spi_max_transfer_size(spi);
+
+	if (max_size != SIZE_MAX) {
+		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
+		if (!bus)
+			return ERR_PTR(-ENOMEM);
+		bus->free_on_exit = true;
+		bus->max_raw_read = max_size;
+		bus->max_raw_write = max_size;
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
 
@@ -124,8 +148,12 @@ struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
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

