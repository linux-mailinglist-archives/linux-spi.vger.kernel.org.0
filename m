Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6158D45AC37
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKWTal (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 14:30:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:55618 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhKWTak (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 14:30:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215821114"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215821114"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509179187"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2021 11:27:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 453FCB8; Tue, 23 Nov 2021 21:27:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH v1 1/3] ARM: pxa/lubbock: Replace custom ->cs_control() by GPIO lookup table
Date:   Tue, 23 Nov 2021 21:27:21 +0200
Message-Id: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI PXA2xx driver supports GPIO chipselect by querying for known
GPIO connection ID. Replace custom ->cs_control() by GPIO table,
so the driver will use generic approach on this platform.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/lubbock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 742d18a1f7dc..e2411971422d 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -211,16 +211,17 @@ static struct ads7846_platform_data ads_info = {
 	// .y_plate_ohms		= 500,	/* GUESS! */
 };
 
-static void ads7846_cs(u32 command)
-{
-	static const unsigned	TS_nCS = 1 << 11;
-	lubbock_set_misc_wr(TS_nCS, (command == PXA2XX_CS_ASSERT) ? 0 : TS_nCS);
-}
+static struct gpiod_lookup_table ads7846_cs_gpios = {
+	.dev_id		= "ads7846",
+	.table		= {
+		GPIO_LOOKUP("lubbock", 11, "cs", GPIO_ACTIVE_LOW),
+		{}
+	},
+};
 
 static struct pxa2xx_spi_chip ads_hw = {
 	.tx_threshold		= 1,
 	.rx_threshold		= 2,
-	.cs_control		= ads7846_cs,
 };
 
 static struct spi_board_info spi_board_info[] __initdata = { {
@@ -512,6 +513,8 @@ static void __init lubbock_init(void)
 	lubbock_flash_data[flashboot].name = "boot-rom";
 	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	gpiod_add_lookup_table(&ads7846_cs_gpios);
+
 	pxa2xx_set_spi_info(1, &pxa_ssp_master_info);
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 }
-- 
2.33.0

