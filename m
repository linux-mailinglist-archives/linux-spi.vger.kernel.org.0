Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76C23CCAC4
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jul 2021 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGRVPA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Jul 2021 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhGRVPA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Jul 2021 17:15:00 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65CC061764
        for <linux-spi@vger.kernel.org>; Sun, 18 Jul 2021 14:12:02 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 446BE8039B;
        Sun, 18 Jul 2021 23:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626642718;
        bh=RnL8tsozyL6Bve4j50rckfH6owIjSzf/D+6WFFg7akA=;
        h=From:To:Cc:Subject:Date:From;
        b=PcUs/mfyt9afc5SlC+/K0ko42F/i97c24c61y7KRw8NSQAOiRdXhGNzp/33jc3L2a
         aC+Y6fHO2qL52hZrfGZpGgvIpQN/Sqo+AnbEIS/McvWPOW8uDDG7kUqurxyAfQsA5e
         CeuwuIn+HQPeIT41xzUQG2jY+mFRu0JOcDnzWhaRe0eKGec9tP+N0X5tbHtfyge+YV
         s8pOgA9/4WVPdA3vA0apYnNBr64EZfErnTv+iXw2ffS9KiwBKnnIrgGfAZP9/30mNW
         Ze8lN4aFIBEFPSXSOrH/98lmGsFXbLjp1NPq2hbjOD99eXhsX/OScj+wfz8Why/xtl
         tkPWxGf093blw==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
Date:   Sun, 18 Jul 2021 23:11:43 +0200
Message-Id: <20210718211143.143557-1-marex@denx.de>
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
Sigh ...
---
 drivers/spi/spi-imx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4aee3db6d6df..e18338fc3108 100644
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
 
@@ -578,7 +580,13 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * the SPI communication as the device on the other end would consider
 	 * the change of SCLK polarity as a clock tick already.
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

