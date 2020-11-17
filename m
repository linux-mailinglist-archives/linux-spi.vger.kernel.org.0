Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DBF2B5BE7
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKQJlE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 04:41:04 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:41582 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQJlE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 04:41:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 591598030718;
        Tue, 17 Nov 2020 09:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S30F3aBmHmzX; Tue, 17 Nov 2020 12:41:00 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Set transfer handler before unmasking the IRQs
Date:   Tue, 17 Nov 2020 12:40:54 +0300
Message-ID: <20201117094054.4696-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It turns out the IRQs most like can be unmasked before the controller is
enabled with no problematic consequences. The manual doesn't explicitly
state that, but the examples perform the controller initialization
procedure in that order. So the commit da8f58909e7e ("spi: dw: Unmask IRQs
after enabling the chip") hasn't been that required as I thought. But
anyway setting the IRQs up after the chip enabling still worth adding
since it has simplified the code a bit. The problem is that it has
introduced a potential bug. The transfer handler pointer is now
initialized after the IRQs are enabled. That may and eventually will cause
an invalid or uninitialized callback invocation. Fix that just by
performing the callback initialization before the IRQ unmask procedure.

Fixes: da8f58909e7e ("spi: dw: Unmask IRQs after enabling the chip")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2e50cc0a9291..0b2236ade412 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -357,11 +357,11 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_TXFTLR, level);
 	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
 
+	dws->transfer_handler = dw_spi_transfer_handler;
+
 	imask = SPI_INT_TXEI | SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI |
 		SPI_INT_RXFI;
 	spi_umask_intr(dws, imask);
-
-	dws->transfer_handler = dw_spi_transfer_handler;
 }
 
 /*
-- 
2.29.2

