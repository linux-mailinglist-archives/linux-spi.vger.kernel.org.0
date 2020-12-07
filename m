Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87F2D0BBE
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLGIbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:31:01 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49875 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGIbB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:31:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0169E100E4165;
        Mon,  7 Dec 2020 09:30:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B5BC3AEA0; Mon,  7 Dec 2020 09:30:19 +0100 (CET)
Message-Id: <c5da472c28021da2f6517441685cef033d40b140.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:06 +0100
Subject: [PATCH 06/17] spi: rpc-if: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
Cc: Sergei Shtylyov <s.shtylyov@omprussia.ru>
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
2.29.2

