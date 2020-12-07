Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAF2D0BD7
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLGIgr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:36:47 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:35591 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGIgr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:36:47 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2E7BA100FBFD2;
        Mon,  7 Dec 2020 09:36:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DDAACAEC5; Mon,  7 Dec 2020 09:36:05 +0100 (CET)
Message-Id: <369bf26d71927f60943b1d9d8f51810f00b0237d.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:10 +0100
Subject: [PATCH 10/17] spi: rb4xx: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
2.29.2

