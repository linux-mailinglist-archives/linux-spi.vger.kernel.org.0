Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0303F5C44
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhHXKlu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36010 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236379AbhHXKls (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:48 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17OA050R016652;
        Tue, 24 Aug 2021 05:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=wmJd13U/MiNXR0MpF3vqHT3p3GrmbatpUhQguV8vWF8=;
 b=ovOIWCkxW7yRmTHDYJc5kamF/EeyASI8hn+fQrRPmDZDP1y/X25XsTOpCHLaLqX+bVaA
 ixOO6cb+Fj9Ii5YxeEzEUxmWhGaolfFytfO8HCaia0S83GSxuOJWtOpDJ4BauV4P+3U9
 Q8yz7UfC/H/JMs0uwMIMX8Kog/wmuP5TwxYxKMowiEggh4vjNJccg4KnCE8vGKVhbpE/
 We51CI3UGaH2iZ5z/IfbbCFICRM9/bqSefbMdyd+/awvmR/LxEwNcbdG09+disygX4B7
 yomFbZtTWchXG09FqEKeYuOF4UXytCyTNHRbpVhtqcvZxD663UeTG5wIOasnCF7ZvWJJ dQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3amjmq8wmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:40:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:40:59 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 431BC2BA;
        Tue, 24 Aug 2021 10:40:59 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 3/9] regmap: spi: SPI_CONTROLLER_CS_PER_TRANSFER affects max read/write
Date:   Tue, 24 Aug 2021 11:40:35 +0100
Message-ID: <20210824104041.708945-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pxnmr8H-9zsF7uLpZWYAKrXmKDKXbhu7
X-Proofpoint-GUID: pxnmr8H-9zsF7uLpZWYAKrXmKDKXbhu7
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

regmap-spi will split data and address between two transfers in the
same message so use addr_affects_max_raw_rw to flag that the number
bytes to read or write should be a little less (address + padding size),
so that the SPI controller can merge the entire message into a single
CS period

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-spi.c | 14 ++++++++++++--
 drivers/base/regmap/regmap.c     |  9 +++++++++
 include/linux/regmap.h           |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 603a4c1c2066..0c1f2e51c0c7 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -115,12 +115,22 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 	struct spi_master *master = spi->master;
 	struct regmap_bus *bus = NULL;
 
-	if (master->max_transfer_size) {
+	if (master->max_transfer_size || (master->flags & SPI_CONTROLLER_CS_PER_TRANSFER)) {
 		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
 		if (!bus)
 			return ERR_PTR(-ENOMEM);
 		bus->free_on_exit = true;
-		bus->max_raw_read = bus->max_raw_write = master->max_transfer_size(spi);
+
+		/* regmap-spi will split data and address between two transfers in the same message
+		 * so use addr_affects_max_raw_rw to flag that the number bytes to read or write
+		 * should be a little less (address + padding size), so the controller can
+		 * fit both transfers in a single CS period
+		 */
+		bus->addr_affects_max_raw_rw = master->flags & SPI_CONTROLLER_CS_PER_TRANSFER;
+
+		if (master->max_transfer_size)
+			bus->max_raw_read = bus->max_raw_write = master->max_transfer_size(spi);
+
 		return bus;
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6ad41d0720ba..31d0949b6c2f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -815,6 +815,15 @@ struct regmap *__regmap_init(struct device *dev,
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
 		map->max_raw_write = bus->max_raw_write;
+		if (bus->addr_affects_max_raw_rw) {
+			if (map->max_raw_read  < map->format.buf_size ||
+			    map->max_raw_write < map->format.buf_size) {
+				ret = -EINVAL;
+				goto err_name;
+			}
+			map->max_raw_read -= (map->format.reg_bytes + map->format.pad_bytes);
+			map->max_raw_write -= (map->format.reg_bytes + map->format.pad_bytes);
+		}
 	}
 	map->dev = dev;
 	map->bus = bus;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 77755196277c..a90d1e270b1f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -504,6 +504,7 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
  * @free_on_exit: kfree this on exit of regmap
+ * @addr_affects_max_raw_rw: max_raw_[read|write] must include the address and padding preamble
  */
 struct regmap_bus {
 	bool fast_io;
@@ -522,6 +523,7 @@ struct regmap_bus {
 	size_t max_raw_read;
 	size_t max_raw_write;
 	bool free_on_exit;
+	bool addr_affects_max_raw_rw;
 };
 
 /*
-- 
2.33.0

