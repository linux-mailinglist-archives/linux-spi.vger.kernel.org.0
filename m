Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B0249F21
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgHSNHU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgHSNAO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:00:14 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF160C06135A
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:15 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id HQz6230034C55Sk01Qz6d4; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bi-1P; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0005Sg-0U; Wed, 19 Aug 2020 14:59:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/7] spi: rspi: Increase bit rate accuracy on RZ/A
Date:   Wed, 19 Aug 2020 14:59:00 +0200
Message-Id: <20200819125904.20938-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
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
v2:
  - No changes.

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

