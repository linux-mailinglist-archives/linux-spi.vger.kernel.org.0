Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566662B3F02
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgKPIpk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgKPIpj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:45:39 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E29C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:45:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 972811008908A;
        Mon, 16 Nov 2020 09:45:38 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 5881A6035EEE;
        Mon, 16 Nov 2020 09:45:38 +0100 (CET)
X-Mailbox-Line: From 7ea28322f0295201ecd93253600b613fdc588d17 Mon Sep 17 00:00:00 2001
Message-Id: <7ea28322f0295201ecd93253600b613fdc588d17.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:11 +0100
Subject: [PATCH for-5.10] spi: rb4xx: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Bert Vermeulen <bert@biot.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to devm_clk_get(), devm_spi_register_master() or
clk_prepare_enable() fail on probe of the Mikrotik RB4xx SPI driver,
the spi_master struct is erroneously not freed.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: 05aec357871f ("spi: Add SPI driver for Mikrotik RB4xx series boards")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.2+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.2+
Cc: Bert Vermeulen <bert@biot.com>
---
 drivers/spi/spi-rb4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 8aa51beb4ff3..9f97d18a05c1 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -143,7 +143,7 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(spi_base))
 		return PTR_ERR(spi_base);
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rbspi));
 	if (!master)
 		return -ENOMEM;
 
-- 
2.28.0

