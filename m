Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B72B3F13
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKPIrk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgKPIrj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:47:39 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EDC0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:47:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 850C11018982B;
        Mon, 16 Nov 2020 09:47:38 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 1372D6035EEE;
        Mon, 16 Nov 2020 09:47:38 +0100 (CET)
X-Mailbox-Line: From 48e6a396526bcd0a26e970036dbe3207cce57ea6 Mon Sep 17 00:00:00 2001
Message-Id: <48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:13 +0100
Subject: [PATCH for-5.10] media: netup_unidvb: Don't leak SPI master in probe
 error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Kozlov Sergey <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to spi_register_master() fails on probe of the NetUP
Universal DVB driver, the spi_master struct is erroneously not freed.

Likewise, if spi_new_device() fails, the spi_controller struct is
not unregistered.  Plug the leaks.

While at it, fix an ordering issue in netup_spi_release() wherein
spi_unregister_master() is called after fiddling with the IRQ control
register.  The correct order is to call spi_unregister_master() *before*
this teardown step because bus accesses may still be ongoing until that
function returns.

Fixes: 52b1eaf4c59a ("[media] netup_unidvb: NetUP Universal DVB-S/S2/T/T2/C PCI-E card driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.3+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.3+
Cc: Kozlov Sergey <serjk@netup.ru>
---
@Mauro Carvalho Chehab:
This patch needs to go in through the spi tree because it depends on
commit 5e844cc37a5c, which is on the spi/for-5.10 branch.
Please ack (barring any objections).  Thanks!

 drivers/media/pci/netup_unidvb/netup_unidvb_spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
index d4f12c250f91..526042d8afae 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
@@ -175,7 +175,7 @@ int netup_spi_init(struct netup_unidvb_dev *ndev)
 	struct spi_master *master;
 	struct netup_spi *nspi;
 
-	master = spi_alloc_master(&ndev->pci_dev->dev,
+	master = devm_spi_alloc_master(&ndev->pci_dev->dev,
 		sizeof(struct netup_spi));
 	if (!master) {
 		dev_err(&ndev->pci_dev->dev,
@@ -208,6 +208,7 @@ int netup_spi_init(struct netup_unidvb_dev *ndev)
 		ndev->pci_slot,
 		ndev->pci_func);
 	if (!spi_new_device(master, &netup_spi_board)) {
+		spi_unregister_master(master);
 		ndev->spi = NULL;
 		dev_err(&ndev->pci_dev->dev,
 			"%s(): unable to create SPI device\n", __func__);
@@ -226,13 +227,13 @@ void netup_spi_release(struct netup_unidvb_dev *ndev)
 	if (!spi)
 		return;
 
+	spi_unregister_master(spi->master);
 	spin_lock_irqsave(&spi->lock, flags);
 	reg = readw(&spi->regs->control_stat);
 	writew(reg | NETUP_SPI_CTRL_IRQ, &spi->regs->control_stat);
 	reg = readw(&spi->regs->control_stat);
 	writew(reg & ~NETUP_SPI_CTRL_IMASK, &spi->regs->control_stat);
 	spin_unlock_irqrestore(&spi->lock, flags);
-	spi_unregister_master(spi->master);
 	ndev->spi = NULL;
 }
 
-- 
2.28.0

