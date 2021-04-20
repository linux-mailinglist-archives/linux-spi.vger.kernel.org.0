Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9673659C2
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDTNTI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 09:19:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:49009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhDTNTH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 09:19:07 -0400
IronPort-SDR: EcVCUp8m9mfkRnS6Hq9Z0rFRyoJdzbseQocJdR0NNZsXyKltUYaamG+xXbQQutmmIYbvBiDtRM
 RoUaNGrpaJyw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195059301"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195059301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:18:36 -0700
IronPort-SDR: 6enxqoQb8b4+CtRA6VKuHmGSMcfF1QyHYNS0T2lUBM3FiFBzEn0JNYY+2/0s/RJPSESj96yWqz
 8ERsgnkb2RRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="534484698"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2021 06:18:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 865631A1; Tue, 20 Apr 2021 16:18:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Rename enable1 to activate in spi_set_cs()
Date:   Tue, 20 Apr 2021 16:18:46 +0300
Message-Id: <20210420131846.75983-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The enable1 is confusing name. Change it to clearly show what is
the intention behind it. No functional changes.

Fixes: 25093bdeb6bc ("spi: implement SW control for CS times")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..74b2b1dd358b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -797,7 +797,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
-	bool enable1 = enable;
+	bool activate = enable;
 
 	/*
 	 * Avoid calling into the driver (or doing delays) if the chip select
@@ -812,7 +812,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
 	    !spi->controller->set_cs_timing) {
-		if (enable1)
+		if (activate)
 			spi_delay_exec(&spi->controller->cs_setup, NULL);
 		else
 			spi_delay_exec(&spi->controller->cs_hold, NULL);
@@ -825,8 +825,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		if (!(spi->mode & SPI_NO_CS)) {
 			if (spi->cs_gpiod)
 				/* polarity handled by gpiolib */
-				gpiod_set_value_cansleep(spi->cs_gpiod,
-							 enable1);
+				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
 			else
 				/*
 				 * invert the enable line, as active low is
@@ -844,7 +843,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
 	    !spi->controller->set_cs_timing) {
-		if (!enable1)
+		if (!activate)
 			spi_delay_exec(&spi->controller->cs_inactive, NULL);
 	}
 }
-- 
2.30.2

