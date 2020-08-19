Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB10F249F22
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHSNHU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgHSM7t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:59:49 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F1C06134E
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:15 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id HQz62300D4C55Sk01Qz62a; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bt-3x; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0005Sp-2z; Wed, 19 Aug 2020 14:59:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 6/7] spi: rspi: Fill in spi_transfer.effective_speed_hz
Date:   Wed, 19 Aug 2020 14:59:03 +0200
Message-Id: <20200819125904.20938-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fill in the effective bit rate used for transfers, so the SPI core can
calculate instead of estimate delays.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 38c0cd7febabf114..2b5334e22ae421b5 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -262,6 +262,7 @@ static void rspi_set_rate(struct rspi_data *rspi)
 
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
+	rspi->speed_hz = DIV_ROUND_UP(clksrc, (2U << brdv) * (spbr + 1));
 }
 
 /*
@@ -344,6 +345,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	clksrc = clk_get_rate(rspi->clk);
 	if (rspi->speed_hz >= clksrc) {
 		spbr = 0;
+		rspi->speed_hz = clksrc;
 	} else {
 		spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz);
 		while (spbr > 255 && brdv < 3) {
@@ -351,6 +353,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 			spbr = DIV_ROUND_UP(spbr, 2);
 		}
 		spbr = clamp(spbr, 0, 255);
+		rspi->speed_hz = DIV_ROUND_UP(clksrc, (2U << brdv) * spbr);
 	}
 	rspi_write8(rspi, spbr, RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
@@ -698,6 +701,8 @@ static int rspi_common_transfer(struct rspi_data *rspi,
 {
 	int ret;
 
+	xfer->effective_speed_hz = rspi->speed_hz;
+
 	ret = rspi_dma_check_then_transfer(rspi, xfer);
 	if (ret != -EAGAIN)
 		return ret;
@@ -853,6 +858,7 @@ static int qspi_transfer_one(struct spi_controller *ctlr,
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
 
+	xfer->effective_speed_hz = rspi->speed_hz;
 	if (spi->mode & SPI_LOOP) {
 		return qspi_transfer_out_in(rspi, xfer);
 	} else if (xfer->tx_nbits > SPI_NBITS_SINGLE) {
-- 
2.17.1

