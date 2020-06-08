Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC191F1647
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgFHKEt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgFHKEs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 06:04:48 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E7C08C5C5
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 03:04:48 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by laurent.telenet-ops.be with bizsmtp
        id oZzi2200R0R8aca01ZzisA; Mon, 08 Jun 2020 11:59:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007PB-EI; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007xF-Cg; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/8] spi: rspi: Increase bit rate accuracy on RZ/A
Date:   Mon,  8 Jun 2020 11:59:36 +0200
Message-Id: <20200608095940.30516-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

rspi_rz_set_config_register() favors high values of "brdv" over high
values of "spbr".  As "brdv" is not a plain divider, but controls a
power-of-two divider, this may cause the selection of non-optimal
divider values.  E.g. on RSK+RZA1, when 3.8 MHz is requested, the actual
configured bit rate is 2.08 MHz (spbr = 1, brdv = 3), while 3.7 MHz
would be possible (spbr = 8, brdv = 0).

Fix this by only resorting to higher "brdv" values when really needed.
This makes the driver always pick optimal divider values on RZ/A.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 450a42ec2141a895..ad4ac867170b101a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -298,15 +298,13 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	clksrc = clk_get_rate(rspi->clk);
-	while (brdv < 3) {
-		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
-			break;
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
+	while (spbr > 255 && brdv < 3) {
 		brdv++;
-		clksrc /= 2;
+		spbr = DIV_ROUND_UP(spbr + 1, 2) - 1;
 	}
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
 
-- 
2.17.1

