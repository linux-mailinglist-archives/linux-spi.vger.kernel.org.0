Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCE1F1648
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFHKEt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgFHKEs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 06:04:48 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDCC08C5C4
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 03:04:48 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by laurent.telenet-ops.be with bizsmtp
        id oZzi2200W0R8aca01ZzisD; Mon, 08 Jun 2020 11:59:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007PK-II; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007xO-Gl; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/8] spi: rspi: Fill in spi_transfer.effective_speed_hz
Date:   Mon,  8 Jun 2020 11:59:39 +0200
Message-Id: <20200608095940.30516-8-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fill in the effective bit rate used for transfers, so the SPI core can
calculate instead of estimate delays.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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

