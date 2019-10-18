Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE5DCD5C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634526AbfJRSHZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634507AbfJRSHZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TAo9yk+ODQykf7+bvZAj2kUivCR7dyFpgBIQM5brJ9k=; b=ZmQnt+eEhkgg
        O7IKbdWy0MryxJyt34EqbHmcbksgpM6MmIzy4n76aL9Q2RwyO8wpduItQCcLmbmg4qHvpbkOvQjvC
        ahQbZVkzauus1zyoLirnxxlaNkMjFAmwi8swdiSS8BByuP8A0i92hMMrj4xuSbVI7HlxKNL/NU5HO
        JePJ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWec-0004Hl-Db; Fri, 18 Oct 2019 18:07:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DC1D52743273; Fri, 18 Oct 2019 19:07:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Sort headers" to the spi tree
In-Reply-To: <20191018105429.82782-2-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180709.DC1D52743273@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Sort headers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5ce2570513bc012020e1faaa20333a6955845f06 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:26 +0300
Subject: [PATCH] spi: pxa2xx: Sort headers

Sort the headers in alphabetic order in order to ease the maintenance
for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 59d1406a9c96..670734b3d56a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -4,27 +4,27 @@
  * Copyright (C) 2013, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
-#include <linux/init.h>
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/ioport.h>
-#include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/pm_runtime.h>
-#include <linux/acpi.h>
-#include <linux/of_device.h>
 
 #include "spi-pxa2xx.h"
 
-- 
2.20.1

