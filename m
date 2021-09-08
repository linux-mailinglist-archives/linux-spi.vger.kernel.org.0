Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48BF4038D5
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349286AbhIHLgL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:11 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:30360 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349200AbhIHLgG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mnu005982;
        Wed, 8 Sep 2021 06:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=QjOOiJsJyu51IX6wxFev1VBwtRJSWCphxb41J5pTuhU=;
 b=owh6B204/vpLCeMAVtlmj0IioGVPRFobkotDSAWyxC6diDYTMpl9V5ipNAg7tADLWF4a
 WRWqCMOjSp0NcUFuAtHY8MTvWZsIwcOQE93oqYq/Hp2DO5EA1UTZ9QgsL9nEShyklUAR
 FIdTi9TJZs9ta9LdiIzSuj/Kp5mGVk6UhLpFC/pouJGgTEQJG7GqwfM4Br8om268csig
 lQAJIugOjer9qjHzQJ985kmmxIjBhneHlXNfenzOefE/yTTLm5esQhP0p8/L17Vy6ely
 rt6w0UAoZ8UhnRtWfBs6FayW+g1Njq39/A12a8qFFZo8Mp+aF4F59pkAj/1QjnStAFQ3 KA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:54 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1EB52B2F;
        Wed,  8 Sep 2021 11:34:54 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 02/10] regmap: spi: Check raw_[read|write] against max message size
Date:   Wed, 8 Sep 2021 12:34:43 +0100
Message-ID: <20210908113450.788452-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DzaAA0zDnKaCbhqbc9cc3h5VkjOWhMIZ
X-Proofpoint-ORIG-GUID: DzaAA0zDnKaCbhqbc9cc3h5VkjOWhMIZ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

regmap-spi will split data and address between two transfers
in the same message, so max_[read|write] must include space
for the address and padding

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-spi.c |  4 ++++
 drivers/base/regmap/regmap.c     | 15 +++++++++++++++
 include/linux/regmap.h           |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 0e6552e57ecf..1434c502e340 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -123,6 +123,10 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 		bus->free_on_exit = true;
 		bus->max_raw_read = max_size;
 		bus->max_raw_write = max_size;
+
+		if (spi_max_message_size(spi) != SIZE_MAX)
+			bus->max_combined_rw = spi_max_message_size(spi);
+
 		return bus;
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..1cd936e097b0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -718,6 +718,7 @@ struct regmap *__regmap_init(struct device *dev,
 	struct regmap *map;
 	int ret = -EINVAL;
 	enum regmap_endian reg_endian, val_endian;
+	size_t reg_pad_size;
 	int i, j;
 
 	if (!config)
@@ -815,6 +816,20 @@ struct regmap *__regmap_init(struct device *dev,
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
 		map->max_raw_write = bus->max_raw_write;
+		if (bus->max_combined_rw) {
+			reg_pad_size = map->format.reg_bytes + map->format.pad_bytes;
+
+			if (map->max_raw_read + reg_pad_size > bus->max_combined_rw)
+				map->max_raw_read -= reg_pad_size;
+			if (map->max_raw_write + reg_pad_size > bus->max_combined_rw)
+				map->max_raw_write -= reg_pad_size;
+
+			if (map->max_raw_read  < map->format.buf_size ||
+			    map->max_raw_write < map->format.buf_size) {
+				ret = -EINVAL;
+				goto err_hwlock;
+			}
+		}
 	}
 	map->dev = dev;
 	map->bus = bus;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f5f08dd0a116..53620c70ae5e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -504,6 +504,8 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
  * @free_on_exit: kfree this on exit of regmap
+ * @max_combined_rw: Max size for raw_read + raw_write, when they are issued
+ *                   together as part of the same message
  */
 struct regmap_bus {
 	bool fast_io;
@@ -521,6 +523,7 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 	size_t max_raw_read;
 	size_t max_raw_write;
+	size_t max_combined_rw;
 	bool free_on_exit;
 };
 
-- 
2.33.0

