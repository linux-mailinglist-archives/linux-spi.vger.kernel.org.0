Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE71541F6E7
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJAV3V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJAV3U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 17:29:20 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A5C061775;
        Fri,  1 Oct 2021 14:27:36 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EDCFD22234;
        Fri,  1 Oct 2021 23:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633123653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hs1kuhtnkFaEUv7FOtmkbn3il4fEyf/TubyN0s51Qjs=;
        b=pY8czqpPVJDZp88B7bjcqtt/r683duydVxmmZkByi2uSi32S31xjFE+UkddFCo3cXZhbnt
        3z5xNjGI67Q9WWaKyr6AtW4bq2/u6j5qdGEPl6fwTTMYomICeMEfEFREXDcSM/gSDU+mT5
        Xc0jrMvGo/Izvm+ySanQp1ahvTfboN4=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name erratum workaround
Date:   Fri,  1 Oct 2021 23:27:26 +0200
Message-Id: <20211001212726.159437-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit 7e71b85473f8 ("arm64: dts: ls1028a: fix node name for the
sysclk") the sysclk node name was renamed and broke the erratum
workaround because it tries to fetch a device tree node by its name,
which is very fragile in general. We don't even need the sysclk node
because the only possible sysclk frequency input is 100MHz. In fact, the
erratum says it applies if SYS_PLL_RAT is 3, not that the platform clock
is 300 MHz. Make the workaround more reliable and just drop the unneeded
sysclk lookup.

For reference, the error during the bootup is the following:
[    4.898400] nxp-fspi 20c0000.spi: Errata cannot be executed. Read via IP bus may not work

Fixes: 82ce7d0e74b6 ("spi: spi-nxp-fspi: Implement errata workaround for LS1028A")
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/spi/spi-nxp-fspi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a66fa97046ee..2b0301fc971c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -33,6 +33,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -315,6 +316,7 @@
 #define NXP_FSPI_MIN_IOMAP	SZ_4M
 
 #define DCFG_RCWSR1		0x100
+#define SYS_PLL_RAT		GENMASK(6, 2)
 
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
@@ -926,9 +928,8 @@ static void erratum_err050568(struct nxp_fspi *f)
 		{ .family = "QorIQ LS1028A" },
 		{ /* sentinel */ }
 	};
-	struct device_node *np;
 	struct regmap *map;
-	u32 val = 0, sysclk = 0;
+	u32 val, sys_pll_ratio;
 	int ret;
 
 	/* Check for LS1028A family */
@@ -937,7 +938,6 @@ static void erratum_err050568(struct nxp_fspi *f)
 		return;
 	}
 
-	/* Compute system clock frequency multiplier ratio */
 	map = syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
 	if (IS_ERR(map)) {
 		dev_err(f->dev, "No syscon regmap\n");
@@ -948,23 +948,11 @@ static void erratum_err050568(struct nxp_fspi *f)
 	if (ret < 0)
 		goto err;
 
-	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio */
-	val = (val >> 2) & 0x1F;
-	WARN(val == 0, "Strapping is zero: Cannot determine ratio");
+	sys_pll_ratio = FIELD_GET(SYS_PLL_RAT, val);
+	dev_dbg(f->dev, "val: 0x%08x, sys_pll_ratio: %d\n", val, sys_pll_ratio);
 
-	/* Compute system clock frequency */
-	np = of_find_node_by_name(NULL, "clock-sysclk");
-	if (!np)
-		goto err;
-
-	if (of_property_read_u32(np, "clock-frequency", &sysclk))
-		goto err;
-
-	sysclk = (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
-	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
-
-	/* Use IP bus only if PLL is 300MHz */
-	if (sysclk == 300)
+	/* Use IP bus only if platform clock is 300MHz */
+	if (sys_pll_ratio == 3)
 		f->devtype_data->quirks |= FSPI_QUIRK_USE_IP_ONLY;
 
 	return;
-- 
2.30.2

