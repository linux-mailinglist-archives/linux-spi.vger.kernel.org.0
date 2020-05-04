Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C061C37EC
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEDLVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLVo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:21:44 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 May 2020 04:21:44 PDT
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02049C061A0E
        for <linux-spi@vger.kernel.org>; Mon,  4 May 2020 04:21:44 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 53C8E10189AD9;
        Mon,  4 May 2020 13:14:42 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 1A23A60F2900;
        Mon,  4 May 2020 13:14:42 +0200 (CEST)
X-Mailbox-Line: From 497cc38ae2beb7900ae05a1463eb83ff96e2770e Mon Sep 17 00:00:00 2001
Message-Id: <497cc38ae2beb7900ae05a1463eb83ff96e2770e.1588590210.git.lukas@wunner.de>
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:01 +0200
Subject: [PATCH 1/5] spi: amd: Fix duplicate iounmap in error path
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The AMD SPI driver uses devm_ioremap_resource() to map its registers, so
they're automatically unmapped via device_release() when the last ref on
the SPI controller is dropped.  The additional iounmap() in the ->probe()
error path is thus unnecessary.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-amd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c7cfc3dc20b1..65b53eee5be9 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -285,14 +285,12 @@ static int amd_spi_probe(struct platform_device *pdev)
 	err = spi_register_master(master);
 	if (err) {
 		dev_err(dev, "error %d registering SPI controller\n", err);
-		goto err_iounmap;
+		goto err_free_master;
 	}
 	platform_set_drvdata(pdev, amd_spi);
 
 	return 0;
 
-err_iounmap:
-	iounmap(amd_spi->io_remap_addr);
 err_free_master:
 	spi_master_put(master);
 
-- 
2.26.2

