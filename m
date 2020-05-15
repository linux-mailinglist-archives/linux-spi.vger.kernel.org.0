Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C361D5554
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEOP67 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:58:59 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:60287 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgEOP66 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 11:58:58 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id AAEE110041625;
        Fri, 15 May 2020 17:58:56 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 7462660AA8C2;
        Fri, 15 May 2020 17:58:56 +0200 (CEST)
X-Mailbox-Line: From 8aaf9d44c153fe233b17bc2dec4eb679898d7e7b Mon Sep 17 00:00:00 2001
Message-Id: <8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de>
In-Reply-To: <cover.1589557526.git.lukas@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 15 May 2020 17:58:01 +0200
Subject: [PATCH 1/5] spi: Fix controller unregister order
To:     Mark Brown <broonie@kernel.org>
Cc:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When an SPI controller unregisters, it unbinds all its slave devices.
For this, their drivers may need to access the SPI bus, e.g. to quiesce
interrupts.

However since commit ffbbdd21329f ("spi: create a message queueing
infrastructure"), spi_destroy_queue() is executed before unbinding the
slaves.  It sets ctlr->running = false, thereby preventing SPI bus
access and causing unbinding of slave devices to fail.

Fix by unbinding slaves before calling spi_destroy_queue().

Fixes: ffbbdd21329f ("spi: create a message queueing infrastructure")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.4+
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c083ee3995e4..d32bdc6cbf66 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2761,6 +2761,8 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
+
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_master_idr, id);
@@ -2773,7 +2775,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
-	device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-- 
2.26.2

