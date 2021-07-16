Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884263CBB50
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGPRmj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhGPRmi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 13:42:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED1C06175F
        for <linux-spi@vger.kernel.org>; Fri, 16 Jul 2021 10:39:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4RoH-0002Nt-8e; Fri, 16 Jul 2021 19:39:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4RoF-0000TI-6X; Fri, 16 Jul 2021 19:39:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4RoF-0001ZW-5S; Fri, 16 Jul 2021 19:39:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: imx: Simplify logic in spi_imx_push()
Date:   Fri, 16 Jul 2021 19:39:27 +0200
Message-Id: <20210716173927.2050620-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=mbrmtykSJpXNlW/9qZDduLMIcAv8JdqYsOoLB4AYFWg=; m=59nJEohcM75f+Fb76f1O4u/kImGNUs8q+ffQ4kVfihs=; p=T/dybc7RTkYg1WN1YITBe00xuxiGgmSfzxnWd8JhOdA=; g=0f05cbaedc3a5c414b9ddd6f4032287b1be62159
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDxxAUACgkQwfwUeK3K7AlIEAf5AfV q7kjMUYKS9BTdn9ugM9AmIqLJRTvwrAOE+jzTdPQRrXVjEPHdrzmoY/OvNuTboKfeE7D2EiAiE5F+ MjHdp5oQTUxnqsftIenIAihKbQtB6tZxY6ri3e8CaMyLLqddjyNeQzHTHMkF5m2UWOL7tdOUrFmGE jIYSXrMcECeJ64ZPvMc5TKORQ/2erFzQ3ns0X4Vo+o4iHkYmJm6eNNZjpjAIidMNUuYqjLwMufAFU UI13kWVVZKjnKWezS9jc2oqk80cvql4QmGDoBwkVeueyxNdxJdOXmR9u/jy4rb7wG3kPX8/Mm2IG3 tAqYHvvRCMBaV4me7zc8DeS8SeHBKeA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For each usage of fifo_words it is clear if ->dynamic_burst is true or
not. This can be used to simplify the function a bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-imx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 39dc02e366f4..c171765d05b1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1032,52 +1032,47 @@ static void spi_imx_set_burst_len(struct spi_imx_data *spi_imx, int n_bits)
 
 	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
 	ctrl |= ((n_bits - 1) << MX51_ECSPI_CTRL_BL_OFFSET);
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	unsigned int burst_len, fifo_words;
+	unsigned int burst_len;
 
-	if (spi_imx->dynamic_burst)
-		fifo_words = 4;
-	else
-		fifo_words = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 	/*
 	 * Reload the FIFO when the remaining bytes to be transferred in the
 	 * current burst is 0. This only applies when bits_per_word is a
 	 * multiple of 8.
 	 */
 	if (!spi_imx->remainder) {
 		if (spi_imx->dynamic_burst) {
 
 			/* We need to deal unaligned data first */
 			burst_len = spi_imx->count % MX51_ECSPI_CTRL_MAX_BURST;
 
 			if (!burst_len)
 				burst_len = MX51_ECSPI_CTRL_MAX_BURST;
 
 			spi_imx_set_burst_len(spi_imx, burst_len * 8);
 
 			spi_imx->remainder = burst_len;
 		} else {
-			spi_imx->remainder = fifo_words;
+			spi_imx->remainder = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 		}
 	}
 
 	while (spi_imx->txfifo < spi_imx->devtype_data->fifo_size) {
 		if (!spi_imx->count)
 			break;
 		if (spi_imx->dynamic_burst &&
-		    spi_imx->txfifo >= DIV_ROUND_UP(spi_imx->remainder,
-						     fifo_words))
+		    spi_imx->txfifo >= DIV_ROUND_UP(spi_imx->remainder, 4))
 			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
 
 	if (!spi_imx->slave_mode)
 		spi_imx->devtype_data->trigger(spi_imx);
 }
 
-- 
2.30.2

