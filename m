Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54C2D0BE0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLGIjg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGIjg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:39:36 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE65C0613D1
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:38:56 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A18C830000CFA;
        Mon,  7 Dec 2020 09:38:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2585E10A8; Mon,  7 Dec 2020 09:38:55 +0100 (CET)
Message-Id: <c4c24f333fc7840f4a3db24789e6e10dd660bede.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:12 +0100
Subject: [PATCH 12/17] media: netup_unidvb: Don't leak SPI master in probe
 error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: <stable@vger.kernel.org> # v4.3+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.3+
Cc: Kozlov Sergey <serjk@netup.ru>
---
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
2.29.2

