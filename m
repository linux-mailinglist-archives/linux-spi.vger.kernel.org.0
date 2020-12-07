Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4C2D0BE8
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgLGInZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGInZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:43:25 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A009C0613D0
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:42:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E8D4C280001A5;
        Mon,  7 Dec 2020 09:42:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 23463CD2; Mon,  7 Dec 2020 09:42:44 +0100 (CET)
Message-Id: <72b680796149f5fcda0b3f530ffb7ee73b04f224.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:14 +0100
Subject: [PATCH 14/17] spi: mt7621: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to device_reset() or devm_spi_register_controller() fail on
probe of the MediaTek MT7621 SPI driver, the spi_controller struct is
erroneously not freed.  Fix by switching over to the new
devm_spi_alloc_master() helper.

Additionally, there's an ordering issue in mt7621_spi_remove() wherein
the spi_controller is unregistered after disabling the SYS clock.
The correct order is to call spi_unregister_controller() *before* this
teardown step because bus accesses may still be ongoing until that
function returns.

All of these bugs have existed since the driver was first introduced,
so it seems fair to fix them together in a single commit.

Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Stefan Roese <sr@denx.de>
Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.17+
---
 drivers/spi/spi-mt7621.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index e227700808cb..b4b9b7309b5e 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -350,7 +350,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
 	if (!master) {
 		dev_info(&pdev->dev, "master allocation failed\n");
 		clk_disable_unprepare(clk);
@@ -382,7 +382,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, master);
+	ret = spi_register_controller(master);
 	if (ret)
 		clk_disable_unprepare(clk);
 
@@ -397,6 +397,7 @@ static int mt7621_spi_remove(struct platform_device *pdev)
 	master = dev_get_drvdata(&pdev->dev);
 	rs = spi_controller_get_devdata(master);
 
+	spi_unregister_controller(master);
 	clk_disable_unprepare(rs->clk);
 
 	return 0;
-- 
2.29.2

