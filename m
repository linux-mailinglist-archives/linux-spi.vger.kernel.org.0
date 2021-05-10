Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67B379068
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhEJORC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 10:17:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:10138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhEJOMu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 10:12:50 -0400
IronPort-SDR: +u92cO7pzw8ynL9XLMYZmrzHMwHMYdpTM5+5pCqcLJvVdZNWs/UQXnKXt9283Qf7aJHzr+BYQq
 CIV00EQ3xdSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186339099"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186339099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:10:14 -0700
IronPort-SDR: KdH8su/4ZReo1i+QeV41PtXxu8f9iw/aS1LKiy9zYCDJvmMlKAFvO2X5wdH2TpvZes/DOKszOT
 IDrl1Sc0inuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="536427303"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2021 07:10:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A50C6142; Mon, 10 May 2021 17:10:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Xin Hao <xhao@linux.alibaba.com>
Subject: [PATCH v1 1/1] spi: Assume GPIO CS active high in ACPI case
Date:   Mon, 10 May 2021 17:10:22 +0300
Message-Id: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently GPIO CS handling, when descriptors are in use, doesn't
take into consideration that in ACPI case the default polarity
is active high and can't be altered. Instead we have to use the
per-chip definition provided by SPISerialBus() resource.

Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
Cc: Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc: Jay Fang <f.fangjian@huawei.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
---
 drivers/spi/spi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 956dce3aafca..f56e0212ee97 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -820,12 +820,23 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
 		if (!(spi->mode & SPI_NO_CS)) {
+			/*
+			 * Historically ACPI has no means of the GPIO polarity and thus
+			 * the SPISerialBus() resource defines it on the per-chip basis.
+			 * In order to avoid a chain of negations, the GPIO polarity is
+			 * considered being Active High. Even for the cases when _DSD()
+			 * is involved (in the updated versions of ACPI) the GPIO CS
+			 * polarity must be defined Active High to avoid ambiguity.
+			 * That's why we use enable, that takes SPI_CS_HIGH into account.
+			 */
+			bool value = has_acpi_companion(&spi->dev) ? !enable : activate;
+
 			if (spi->cs_gpiod)
-				/* polarity handled by gpiolib */
-				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
+				/* Polarity handled by GPIO library */
+				gpiod_set_value_cansleep(spi->cs_gpiod, value);
 			else
 				/*
-				 * invert the enable line, as active low is
+				 * Invert the enable line, as active low is
 				 * default for SPI.
 				 */
 				gpio_set_value_cansleep(spi->cs_gpio, !enable);
-- 
2.30.2

