Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961A21D5574
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEOQC4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOQC4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 12:02:56 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B26C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 09:02:56 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 16052101712C1;
        Fri, 15 May 2020 18:02:54 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CE8AD6029E64;
        Fri, 15 May 2020 18:02:53 +0200 (CEST)
X-Mailbox-Line: From d0dcbd098401b5d2a486eee7cf2f9dcabacf9605 Mon Sep 17 00:00:00 2001
Message-Id: <d0dcbd098401b5d2a486eee7cf2f9dcabacf9605.1589557526.git.lukas@wunner.de>
In-Reply-To: <cover.1589557526.git.lukas@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 15 May 2020 17:58:05 +0200
Subject: [PATCH 5/5] spi: Document devm_spi_register_controller() gotcha
To:     Mark Brown <broonie@kernel.org>
Cc:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As a rule, devm_spi_register_controller() must not be used if the
driver's ->remove() hook performs teardown steps which shall be
performed after unbinding of slaves.

Dozens of drivers are doing it wrong.  Document this gotcha to
hopefully prevent further misuse.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d32bdc6cbf66..e1a35aa7eeb8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2714,6 +2714,13 @@ static void devm_spi_unregister(struct device *dev, void *res)
  * Register a SPI device as with spi_register_controller() which will
  * automatically be unregistered and freed.
  *
+ * Be aware that a managed SPI controller and the attached slaves are
+ * unregistered after the driver's ->remove() callback has been executed.
+ * So the SPI slaves may still access the bus during and after ->remove().
+ * Thus, devm_spi_register_controller() may only be used if there is no
+ * ->remove() callback at all or if it does not perform teardown steps
+ * which render the bus inaccessible.
+ *
  * Return: zero on success, else a negative error code.
  */
 int devm_spi_register_controller(struct device *dev,
-- 
2.26.2

