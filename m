Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA035DCD54
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505763AbfJRSHQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45248 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505743AbfJRSHP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t/gffXnLEnapErkIM7XMWv5utc8YEivVkOgKwMKPBdM=; b=hHurjcxQzNRI
        6WpaH4hMHMHxuU3WbZPyQtbF3fAjI53z84Il8FNt9q0I7+xo5gTNBvTxQgqzxj/LXMOI+o9v093xa
        cNwhP4WaCg79z8VWNwQK0zs/zeXhDHaGMfyjr2jsuC5FCDVpoJq+4QqPwgtg8sL/GPugjQqO+ikyQ
        znL8o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeb-0004HQ-U5; Fri, 18 Oct 2019 18:07:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 490C22743276; Fri, 18 Oct 2019 19:07:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Replace of_device.h with mod_devicetable.h and of.h" to the spi tree
In-Reply-To: <20191018105429.82782-5-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180709.490C22743276@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Replace of_device.h with mod_devicetable.h and of.h

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

From ae8fbf1d2403bc187a5d8fe82fbf2205d89cdb60 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:29 +0300
Subject: [PATCH] spi: pxa2xx: Replace of_device.h with mod_devicetable.h and
 of.h

There is nothing in use from of_device.h. The definitions and macros
are available thru mod_devicetable.h and of.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 684a5585ac7f..443c1f4d2a9a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -18,7 +18,8 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.20.1

