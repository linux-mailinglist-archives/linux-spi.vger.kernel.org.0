Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C122D0BF1
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLGIqt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:46:49 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:45423 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLGIqt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:46:49 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 989483000627F;
        Mon,  7 Dec 2020 09:45:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1C3E7ACE8; Mon,  7 Dec 2020 09:46:08 +0100 (CET)
Message-Id: <9ae62f4e1cfe542bec57ac2743e6fca9f9548f55.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:16 +0100
Subject: [PATCH 16/17] spi: npcm-fiu: Disable clock in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to devm_spi_register_master() fails on probe of the NPCM FIU
SPI driver, the clock "fiu->clk" is erroneously not unprepared and
disabled.  Fix it.

Fixes: ace55c411b11 ("spi: npcm-fiu: add NPCM FIU controller driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.4+
Cc: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-fiu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 1cb9329de945..b62471ab6d7f 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -677,7 +677,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	struct npcm_fiu_spi *fiu;
 	void __iomem *regbase;
 	struct resource *res;
-	int id;
+	int id, ret;
 
 	ctrl = devm_spi_alloc_master(dev, sizeof(*fiu));
 	if (!ctrl)
@@ -735,7 +735,11 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = fiu->info->max_cs;
 	ctrl->dev.of_node = dev->of_node;
 
-	return devm_spi_register_master(dev, ctrl);
+	ret = devm_spi_register_master(dev, ctrl);
+	if (ret)
+		clk_disable_unprepare(fiu->clk);
+
+	return ret;
 }
 
 static int npcm_fiu_remove(struct platform_device *pdev)
-- 
2.29.2

