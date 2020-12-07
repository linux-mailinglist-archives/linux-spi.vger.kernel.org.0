Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E62D0BB6
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgLGI0k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:26:40 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:58561 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGI0k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:26:40 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1B31B30000D04;
        Mon,  7 Dec 2020 09:25:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9451E369; Mon,  7 Dec 2020 09:25:58 +0100 (CET)
Message-Id: <6d97628b536baf01d5e3e39db61108f84d44c8b2.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:04 +0100
Subject: [PATCH 04/17] spi: spi-sh: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_sh_remove() accesses the driver's private data after calling
spi_unregister_master() even though that function releases the last
reference on the spi_master and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: 680c1305e259 ("spi/spi_sh: use spi_unregister_master instead of spi_master_put in remove path")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v3.0+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v3.0+
Cc: Axel Lin <axel.lin@ingics.com>
---
 drivers/spi/spi-sh.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 20bdae5fdf3b..15123a8f41e1 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -440,7 +440,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "spi_alloc_master error.\n");
 		return -ENOMEM;
@@ -458,16 +458,14 @@ static int spi_sh_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "No support width\n");
-		ret = -ENODEV;
-		goto error1;
+		return -ENODEV;
 	}
 	ss->irq = irq;
 	ss->master = master;
 	ss->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (ss->addr == NULL) {
 		dev_err(&pdev->dev, "ioremap error.\n");
-		ret = -ENOMEM;
-		goto error1;
+		return -ENOMEM;
 	}
 	INIT_LIST_HEAD(&ss->queue);
 	spin_lock_init(&ss->lock);
@@ -477,7 +475,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	ret = request_irq(irq, spi_sh_irq, 0, "spi_sh", ss);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request_irq error\n");
-		goto error1;
+		return ret;
 	}
 
 	master->num_chipselect = 2;
@@ -496,9 +494,6 @@ static int spi_sh_probe(struct platform_device *pdev)
 
  error3:
 	free_irq(irq, ss);
- error1:
-	spi_master_put(master);
-
 	return ret;
 }
 
-- 
2.29.2

