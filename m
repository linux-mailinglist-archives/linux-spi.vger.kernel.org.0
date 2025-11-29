Return-Path: <linux-spi+bounces-11667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246DC9407F
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C231E3A6DF6
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18971189B84;
	Sat, 29 Nov 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdRrBw1p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57411CAF;
	Sat, 29 Nov 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764429465; cv=none; b=bHVlwEoeNlujXnGs7cNjzwWEos3oh5FrcGLC7xKJR81MWPkIZq84wAW/EgDV8kf92n+/bKGHNdfmu9LBuH2yJnvfUxOPeyie+Bu3JLyxFjbZ811Yee8r80g03q5SA59ysXkvaThQ11AVuP1oLLvV7zmH5eZCJxeuyUEhh8cwVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764429465; c=relaxed/simple;
	bh=k/I12v9aK8O39KnbB62x7HH6WOGkjYDwZYDpQmeflS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNx8PwidDu1FkXLEdRqpHse+W6Uqz0uriUeGPaGnoDV9ztfayDM38WdzBWHYSH94b+75Gq2ULpN0YStIheuP8C2RZc46vsp7yzSNHpWpdDnB0BL8DjOovgEA1LWfxhz2TxoWkTYZFB6Y9dIyExo8oUxTycOA0sg7WDhxnGjPnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdRrBw1p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764429464; x=1795965464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k/I12v9aK8O39KnbB62x7HH6WOGkjYDwZYDpQmeflS0=;
  b=PdRrBw1p7ypi8Zd35w80Kc4ikrWpO++68s2mt8ts/gVGkbOHMUG5aTii
   m8HZNb/BZgRNCV+6rxCJ5pjFuxTvaR2S+M+cQJNID9ldvGpvKvslFtt0u
   XrXSPz5GTqwlO+bYtwRymE5pzHPzGebsVri9ZNz2NJmXl5B16gdNyed9h
   K5BWIU4sqyYWX/xgezI4agJtlN0DG/rYCQ7VaxKXNytCaRHh3HiwPhH4N
   9fvIb3nLy5T8aS1MJ/tQKrPVOt2jm1xY3nVr1hTT4z2TZSQ5NJr0ZX44a
   2brGX/WoYBgMWm1mpujstZgsIrMnqiqQ4rRyk+OvPhOlZ3iuUm2RdnEUl
   g==;
X-CSE-ConnectionGUID: qftSHEiWTyCC3SCCRKEJ3Q==
X-CSE-MsgGUID: iHMN6kecRQ++Pt7QrYmmWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="69013523"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="69013523"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 07:17:43 -0800
X-CSE-ConnectionGUID: /h2Td2MQQ36/E+0qSdFoxg==
X-CSE-MsgGUID: BCFb3YTtSEyS7cVKXvA7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="193794009"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 29 Nov 2025 07:17:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0533793; Sat, 29 Nov 2025 16:17:40 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
Date: Sat, 29 Nov 2025 16:17:39 +0100
Message-ID: <20251129151739.3998668-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ACPI specific calls to get device property with the agnostic one.
The code looses the direct dependency to the ACPI APIs and get cleaner.
This doesn't change functionality.

While at it, drop now unneeded acpi.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-cadence-xspi.c | 36 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3fc5d8e37a9e..72384d90d113 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,7 +2,6 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -21,6 +20,7 @@
 #include <linux/limits.h>
 #include <linux/log2.h>
 #include <linux/bitrev.h>
+#include <linux/util_macros.h>
 
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
@@ -774,19 +774,15 @@ static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
 	return ret;
 }
 
-#ifdef CONFIG_ACPI
 static bool cdns_xspi_supports_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
 	struct spi_device *spi = mem->spi;
-	const union acpi_object *obj;
-	struct acpi_device *adev;
+	struct device *dev = &spi->dev;
+	u32 value;
 
-	adev = ACPI_COMPANION(&spi->dev);
-
-	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
-				   &obj)) {
-		switch (obj->integer.value) {
+	if (!device_property_read_u32(dev, "spi-tx-bus-width", &value)) {
+		switch (value) {
 		case 1:
 			break;
 		case 2:
@@ -799,16 +795,13 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 			spi->mode |= SPI_TX_OCTAL;
 			break;
 		default:
-			dev_warn(&spi->dev,
-				 "spi-tx-bus-width %lld not supported\n",
-				 obj->integer.value);
+			dev_warn(dev, "spi-tx-bus-width %u not supported\n", value);
 			break;
 		}
 	}
 
-	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
-				   &obj)) {
-		switch (obj->integer.value) {
+	if (!device_property_read_u32(dev, "spi-rx-bus-width", &value)) {
+		switch (value) {
 		case 1:
 			break;
 		case 2:
@@ -821,9 +814,7 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 			spi->mode |= SPI_RX_OCTAL;
 			break;
 		default:
-			dev_warn(&spi->dev,
-				 "spi-rx-bus-width %lld not supported\n",
-				 obj->integer.value);
+			dev_warn(dev, "spi-rx-bus-width %u not supported\n", value);
 			break;
 		}
 	}
@@ -833,7 +824,6 @@ static bool cdns_xspi_supports_op(struct spi_mem *mem,
 
 	return true;
 }
-#endif
 
 static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
@@ -846,17 +836,13 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
-#ifdef CONFIG_ACPI
-	.supports_op = cdns_xspi_supports_op,
-#endif
+	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
 
 static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
-#ifdef CONFIG_ACPI
-	.supports_op = cdns_xspi_supports_op,
-#endif
+	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
 	.exec_op = marvell_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
-- 
2.50.1


