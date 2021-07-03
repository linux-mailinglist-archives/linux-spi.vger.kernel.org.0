Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11573BA6B1
	for <lists+linux-spi@lfdr.de>; Sat,  3 Jul 2021 04:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhGCCZt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jul 2021 22:25:49 -0400
Received: from phobos.denx.de ([85.214.62.61]:37324 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhGCCZs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Jul 2021 22:25:48 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 58FB9800BF;
        Sat,  3 Jul 2021 04:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1625278994;
        bh=6AaGcBREHILhesjSditkRBcx0BAPIZA5AC0VESrVGEo=;
        h=From:To:Cc:Subject:Date:From;
        b=R/pOos5r84vAPv1i2SvVZ/hlaJnkFour2kGUGxK+tMy+EMfBecivfc7IVpATHcgrk
         tagYW/oiVQ8Fcv68FJyS5BhfwEIKLnW1dusHxYuIxUGn2fxKz1GBJGoXo7RmmMcN/x
         ZExcYZE5uD+s2TmaPnPK22uY3o29hR0/ajMAg74H5mMdnb5pQz53uLJu7H9B0fbodJ
         tRPwTktfHshHWc6b1SznDsUcxtZ8Y1Ss7OocaV8H+qp1pjkcXG6iATNAv803863m4d
         j8pcNzkrqTPVGvlm/Qd4eYrS4wof4OnlJzhpcdsUNWtM5K8ZqlVIAfy+CZFzM90kT2
         jNcpF3PyqRiHg==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
Date:   Sat,  3 Jul 2021 04:23:00 +0200
Message-Id: <20210703022300.296114-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since 00b80ac935539 ("spi: imx: mx51-ecspi: Move some initialisation to
prepare_message hook."), the MX51_ECSPI_CONFIG write no longer happens
in prepare_transfer hook, but rather in prepare_message hook, however
the MX51_ECSPI_CONFIG delay is still left in prepare_transfer hook and
thus has no effect. This leads to low bus frequency operation problems
described in 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK
operation at low speeds") again.

Move the MX51_ECSPI_CONFIG write delay into the prepare_message hook
as well, thus reinstating the low bus frequency fix.

Fixes: 00b80ac935539 ("spi: imx: mx51-ecspi: Move some initialisation to prepare_message hook.")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 39dc02e366f4b..4aee3db6d6df0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -506,7 +506,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 {
 	struct spi_device *spi = msg->spi;
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
-	u32 testreg;
+	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/* set Master or Slave mode */
@@ -567,6 +567,23 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
+	/*
+	 * Wait until the changes in the configuration register CONFIGREG
+	 * propagate into the hardware. It takes exactly one tick of the
+	 * SCLK clock, but we will wait two SCLK clock just to be sure. The
+	 * effect of the delay it takes for the hardware to apply changes
+	 * is noticable if the SCLK clock run very slow. In such a case, if
+	 * the polarity of SCLK should be inverted, the GPIO ChipSelect might
+	 * be asserted before the SCLK polarity changes, which would disrupt
+	 * the SPI communication as the device on the other end would consider
+	 * the change of SCLK polarity as a clock tick already.
+	 */
+	delay = (2 * 1000000) / spi_imx->spi_bus_clk;
+	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
+		udelay(delay);
+	else			/* SCLK is _very_ slow */
+		usleep_range(delay, delay + 10);
+
 	return 0;
 }
 
@@ -574,7 +591,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				       struct spi_device *spi)
 {
 	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	u32 clk, delay;
+	u32 clk;
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
@@ -596,23 +613,6 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
-	/*
-	 * Wait until the changes in the configuration register CONFIGREG
-	 * propagate into the hardware. It takes exactly one tick of the
-	 * SCLK clock, but we will wait two SCLK clock just to be sure. The
-	 * effect of the delay it takes for the hardware to apply changes
-	 * is noticable if the SCLK clock run very slow. In such a case, if
-	 * the polarity of SCLK should be inverted, the GPIO ChipSelect might
-	 * be asserted before the SCLK polarity changes, which would disrupt
-	 * the SPI communication as the device on the other end would consider
-	 * the change of SCLK polarity as a clock tick already.
-	 */
-	delay = (2 * 1000000) / clk;
-	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
-		udelay(delay);
-	else			/* SCLK is _very_ slow */
-		usleep_range(delay, delay + 10);
-
 	return 0;
 }
 
-- 
2.30.2

