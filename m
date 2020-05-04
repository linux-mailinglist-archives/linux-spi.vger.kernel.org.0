Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3B1C37D1
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDLQ4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:16:56 -0400
X-Greylist: delayed 282 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 May 2020 04:16:55 PDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3696C061A0E
        for <linux-spi@vger.kernel.org>; Mon,  4 May 2020 04:16:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id C1DD610044AA5;
        Mon,  4 May 2020 13:16:53 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 980B660F2900;
        Mon,  4 May 2020 13:16:53 +0200 (CEST)
X-Mailbox-Line: From 499f8ad4759c2ff0f586e0459fb9a293faecff6d Mon Sep 17 00:00:00 2001
Message-Id: <499f8ad4759c2ff0f586e0459fb9a293faecff6d.1588590210.git.lukas@wunner.de>
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:03 +0200
Subject: [PATCH 3/5] spi: amd: Drop duplicate driver data assignments
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The AMD SPI driver calls platform_set_drvdata() on probe even though
it's already been set by __spi_alloc_controller().  Likewise, it calls
platform_set_drvdata() on remove even though it's going to be set by
__device_release_driver().  Drop the duplicate assignments.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index a4248b97b67e..d3e3516ef957 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -287,7 +287,6 @@ static int amd_spi_probe(struct platform_device *pdev)
 		dev_err(dev, "error %d registering SPI controller\n", err);
 		goto err_free_master;
 	}
-	platform_set_drvdata(pdev, amd_spi);
 
 	return 0;
 
@@ -303,7 +302,6 @@ static int amd_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(amd_spi->master);
 	spi_master_put(amd_spi->master);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
2.26.2

