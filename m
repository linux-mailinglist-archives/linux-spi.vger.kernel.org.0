Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59AD1C37FF
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEDLYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 07:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLYO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:24:14 -0400
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC7C061A0E
        for <linux-spi@vger.kernel.org>; Mon,  4 May 2020 04:24:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4E7A6101E69A5;
        Mon,  4 May 2020 13:15:57 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CA9D560F2900;
        Mon,  4 May 2020 13:15:56 +0200 (CEST)
X-Mailbox-Line: From 689f29a359718dab4f5de9ee66c02ea97b3bd9e8 Mon Sep 17 00:00:00 2001
Message-Id: <689f29a359718dab4f5de9ee66c02ea97b3bd9e8.1588590210.git.lukas@wunner.de>
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:02 +0200
Subject: [PATCH 2/5] spi: amd: Pass probe errors back to driver core
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If probing fails, the AMD SPI driver pretends success to the driver core
by returning 0.  Return the errno instead.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 65b53eee5be9..a4248b97b67e 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -294,7 +294,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 err_free_master:
 	spi_master_put(master);
 
-	return 0;
+	return err;
 }
 
 static int amd_spi_remove(struct platform_device *pdev)
-- 
2.26.2

