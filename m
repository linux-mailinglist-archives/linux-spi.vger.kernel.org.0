Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083D42B3ED2
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgKPIg2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:36:28 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:42919 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgKPIg2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:36:28 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 2BFDC10189A37;
        Mon, 16 Nov 2020 09:36:26 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id DBFCF6035EEE;
        Mon, 16 Nov 2020 09:36:25 +0100 (CET)
X-Mailbox-Line: From bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20 Mon Sep 17 00:00:00 2001
Message-Id: <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:05 +0100
Subject: [PATCH for-5.10] spi: rpc-if: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

rpcif_spi_remove() accesses the driver's private data after calling
spi_unregister_controller() even though that function releases the last
reference on the spi_controller and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.9+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.9+
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 drivers/spi/spi-rpc-if.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index ed3e548227f4..3579675485a5 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -134,7 +134,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	struct rpcif *rpc;
 	int error;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*rpc));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -159,13 +159,8 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	error = spi_register_controller(ctlr);
 	if (error) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto err_put_ctlr;
+		rpcif_disable_rpm(rpc);
 	}
-	return 0;
-
-err_put_ctlr:
-	rpcif_disable_rpm(rpc);
-	spi_controller_put(ctlr);
 
 	return error;
 }
-- 
2.28.0

