Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9044E11146
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEBCTW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57114 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEBCTV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=C9XRTvvku7YohEoOselFNompaVQM73w7LtDDtIUkluY=; b=wJ3NgXseGvrx
        iT+1+Lz86m37j/B8N7zsETj6gF1yNMJPOnMGLyfYsa0eyGk26tu1pgcPCFFkSOYQ6bg0RoKSwh6SK
        5lF7hwsuu7fMpSqi3tl1Ro6DiXr4bqSkQfPXdxeD8wMuGFxIf4w+mRPBeoDAXNsDnqF9CGu5cPCI5
        GJ2RE=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JQ-0005vW-3J; Thu, 02 May 2019 02:19:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EAF91441D41; Thu,  2 May 2019 03:19:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org, dwmw2@infradead.org,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        Mark Brown <broonie@kernel.org>, michals@xilinx.com,
        nagasuresh12@gmail.com, richard@nod.at, vigneshr@ti.com
Subject: Applied "spi: spi-mem: zynq-qspi: Fix build error on architectures missing readsl/writesl" to the spi tree
In-Reply-To: <1555918009-13172-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021900.EAF91441D41@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:00 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-mem: zynq-qspi: Fix build error on architectures missing readsl/writesl

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ba3ce8cb3808cad0f9b8303fad4bd1c887834c82 Mon Sep 17 00:00:00 2001
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Date: Mon, 22 Apr 2019 12:56:49 +0530
Subject: [PATCH] spi: spi-mem: zynq-qspi: Fix build error on architectures
 missing readsl/writesl

Alpha and some of the architectures are missing readsl/writesl functions.
so the zynq-qspi driver won't be able to build on these arches. hence use
ioread32_rep()/iowrite32_rep() instead of readsl()/writesl().

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 8079d0062d03..c6bee67decb5 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -407,8 +407,8 @@ static void zynq_qspi_write_op(struct zynq_qspi *xqspi, int txcount,
 		count = txcount;
 
 	if (xqspi->txbuf) {
-		writesl(xqspi->regs + ZYNQ_QSPI_TXD_00_00_OFFSET,
-			xqspi->txbuf, count);
+		iowrite32_rep(xqspi->regs + ZYNQ_QSPI_TXD_00_00_OFFSET,
+			      xqspi->txbuf, count);
 		xqspi->txbuf += count * 4;
 	} else {
 		for (k = 0; k < count; k++)
@@ -433,8 +433,8 @@ static void zynq_qspi_read_op(struct zynq_qspi *xqspi, int rxcount)
 	if (count > rxcount)
 		count = rxcount;
 	if (xqspi->rxbuf) {
-		readsl(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET,
-		       xqspi->rxbuf, count);
+		ioread32_rep(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET,
+			     xqspi->rxbuf, count);
 		xqspi->rxbuf += count * 4;
 	} else {
 		for (k = 0; k < count; k++)
-- 
2.20.1

