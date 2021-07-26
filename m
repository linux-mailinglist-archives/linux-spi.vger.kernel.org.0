Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E625C3D56F3
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhGZJUq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 05:20:46 -0400
Received: from phobos.denx.de ([85.214.62.61]:53070 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232617AbhGZJUq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Jul 2021 05:20:46 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 530B58329C;
        Mon, 26 Jul 2021 12:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1627293674;
        bh=xHCkLeepfSgbrEg/FwcqFIdBqcCvYwWJuVz3ZerCnRo=;
        h=From:To:Cc:Subject:Date:From;
        b=gRT4DM2wqW4iQtI8bF9RCfPsohEKJb7MAVtL6yLf75FgxeE6dfN/VtNhaOz3G6iwj
         X4IBBwlMpU6W4UyRazEzSCF4W+xGu9pf1FFYjSJ0ueDzMWDnnUxtloynNNuphshzIm
         +liVHeYpoLKQzGPd53qnIaspYnl11RkU2if8ZUeYI7QF9mI3289+O9ok4s2jrgwKjt
         AqdOBIGrVPiYXvmlEyj/dsVwRsPODS4EpWUpd2j8rYTXROh+hlecT/RB5HjTS7WB0g
         03UVnesrk9rqRfXaHbBVeqIyasnzQHUl70tzjrjtZvSlnkdqBUMt77cosEtMsPFe3P
         E9CEvuNz6r3Hg==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH V2] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
Date:   Mon, 26 Jul 2021 12:01:02 +0200
Message-Id: <20210726100102.5188-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi_imx->spi_bus_clk may be uninitialized and thus also zero in
mx51_ecspi_prepare_message(), which would lead to division by zero
in kernel. Since bitbang .setup_transfer callback which initializes
the spi_imx->spi_bus_clk is called after bitbang prepare_message
callback, iterate over all the transfers in spi_message, find the
one with lowest bus frequency, and use that bus frequency for the
delay calculation.

Note that it is not possible to move this CONFIGREG delay back into
the .setup_transfer callback, because that is invoked too late, after
the GPIO chipselects were already configured.

Fixes: 135cbd378eab ("spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>
---
V2: Add comment regarding all zero-frequency transfers
---
 drivers/spi/spi-imx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 593b63be73de8..cb9f7261c4385 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -505,7 +505,9 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 				      struct spi_message *msg)
 {
 	struct spi_device *spi = msg->spi;
+	struct spi_transfer *xfer;
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
+	u32 min_speed_hz = ~0U;
 	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
@@ -577,8 +579,20 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * be asserted before the SCLK polarity changes, which would disrupt
 	 * the SPI communication as the device on the other end would consider
 	 * the change of SCLK polarity as a clock tick already.
+	 *
+	 * Because spi_imx->spi_bus_clk is only set in bitbang prepare_message
+	 * callback, iterate over all the transfers in spi_message, find the
+	 * one with lowest bus frequency, and use that bus frequency for the
+	 * delay calculation. In case all transfers have speed_hz == 0, then
+	 * min_speed_hz is ~0 and the resulting delay is zero.
 	 */
-	delay = (2 * 1000000) / spi_imx->spi_bus_clk;
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->speed_hz)
+			continue;
+		min_speed_hz = min(xfer->speed_hz, min_speed_hz);
+	}
+
+	delay = (2 * 1000000) / min_speed_hz;
 	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
 		udelay(delay);
 	else			/* SCLK is _very_ slow */
-- 
2.30.2

