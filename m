Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615CC3D573B
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhGZJep (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhGZJeo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Jul 2021 05:34:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF647C061757
        for <linux-spi@vger.kernel.org>; Mon, 26 Jul 2021 03:15:13 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2B74482DA1;
        Mon, 26 Jul 2021 12:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1627294510;
        bh=nu7Fk0FSYDLaaMdoR+8aQw9z0dX/a+nATiQe9WSV7JM=;
        h=From:To:Cc:Subject:Date:From;
        b=jxLgsooptsazq0h9+CdRnlWu0IxBVe/OQMgJ8t9kpWYvEqJRSp9WTkGJJ2XN/afoz
         N0yTYzUVGmWdmoaNqBngR2nK7RDbPV/KVjHtkUm93tVKVVgB9yAN74fqvYIz+ZMXxx
         HO202Ekofs6rX9eusTsi1Ckv0Muyh14BRJsPdB/TrjXE2t9sAQr4KKG7xV9rbKm4Du
         B4IECITs39CxK7Ecda1EMT/gI7FYRUiSRW4UPeyxXyL1ulAuFEkfIaDDJIOB3Jskeq
         HH1/LxfWHBIKmnwdGczirx+oDhe6K+cIdKusDKooEbOuWf9nDpghiG1SWL6H7gzQxw
         kY5oc/VPRIOLw==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Date:   Mon, 26 Jul 2021 12:15:02 +0200
Message-Id: <20210726101502.6803-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
the min_speed_hz must above 222222. Update the comment. No functional
change.

Fixes: 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK operation at low speeds")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>
---
Note: Drop the Fixes if it makes no sense to backport this.
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cb9f7261c4385..f474f76753bc1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -593,7 +593,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	}
 
 	delay = (2 * 1000000) / min_speed_hz;
-	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
+	if (likely(delay < 10))	/* SCLK is faster than 222.2 kHz */
 		udelay(delay);
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
-- 
2.30.2

