Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A979D1F1619
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgFHJ7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgFHJ7p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 05:59:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8CC08C5C8
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 02:59:44 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by michel.telenet-ops.be with bizsmtp
        id oZzi2200B0R8aca06Zziom; Mon, 08 Jun 2020 11:59:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007P1-Ak; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007x6-9C; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/8] spi: rspi: Remove useless .set_config_register() check
Date:   Mon,  8 Jun 2020 11:59:33 +0200
Message-Id: <20200608095940.30516-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Not implementing spi_ops.set_config_register() is a driver bug that
would prevent the driver from working at all.
Hence remove the run-time check.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 06192c9ea8132911..0e786af546c9f513 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1247,13 +1247,6 @@ static int rspi_probe(struct platform_device *pdev)
 			ctlr->num_chipselect = 2; /* default */
 	}
 
-	/* ops parameter check */
-	if (!ops->set_config_register) {
-		dev_err(&pdev->dev, "there is no set_config_register\n");
-		ret = -ENODEV;
-		goto error1;
-	}
-
 	rspi = spi_controller_get_devdata(ctlr);
 	platform_set_drvdata(pdev, rspi);
 	rspi->ops = ops;
-- 
2.17.1

