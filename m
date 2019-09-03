Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED41A67E7
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfICL5y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 07:57:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICL5v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 07:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xg0WTUeN+jYfK1+m1b37wnEGgFLPO5Z6ot6Ky5LT0BA=; b=TfBXTvCdKIWZ
        Hva3PRAuAZ8jsJG/NaWDs3y5/SYSq2uRT8NchmWsLqrfXlIK8BEAo4WZeag6+2CmZ/da57YqQaqkS
        l0avL7MuTuuzGxqeu4oYzYvaf4oJqOMXVdgRta7neF2HzbRngssD5rLanFr0utVJjfcusP8ZU/B5T
        7Nx/k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57RV-0008Lx-3W; Tue, 03 Sep 2019 11:57:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A1DA72742D32; Tue,  3 Sep 2019 12:57:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt" to the spi tree
In-Reply-To: <20190903105708.32273-1-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190903115748.A1DA72742D32@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 12:57:48 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From e327364948492f6a4e866417d3d4d17d95fed285 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 3 Sep 2019 13:57:08 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt

When the driver is working in TCFQ/EOQ mode (i.e. interacts with the SPI
controller's FIFOs directly) the following sequence of operations
happens:

- The first byte of the tx buffer gets pushed to the TX FIFO (dspi->len
  gets decremented). This triggers the train of interrupts that handle
  the rest of the bytes.

- The dspi_interrupt handles a TX confirmation event. It reads the newly
  available byte from the RX FIFO, checks the dspi->len exit condition,
  and if there's more to be done, it kicks off the next interrupt in the
  train by writing the next byte to the TX FIFO.

Now the problem is that the wait queue is woken up one byte too early,
because dspi->len becomes 0 as soon as the byte has been pushed into the
TX FIFO. Its interrupt has not yet been processed and the RX byte has
not been put from the FIFO into the buffer.

Depending on the timing of the wait queue wakeup vs the handling of the
last dspi_interrupt, it can happen that the main SPI message pump thread
has already returned back into the spi_device driver. When the rx buffer
is on stack (which it can be, because in this mode, the DSPI doesn't do
DMA), the last interrupt will perform a memory write into an rx buffer
that has been freed. This manifests as stack corruption.

The solution is to only wake up the wait queue when dspi_rxtx says so,
i.e. after it has processed the last TX confirmation interrupt and
collected the last RX byte.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190903105708.32273-1-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 77db43f1290f..bec758e978fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -710,9 +710,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
 		return IRQ_NONE;
 
-	dspi_rxtx(dspi);
-
-	if (!dspi->len) {
+	if (dspi_rxtx(dspi) == 0) {
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
 	}
-- 
2.20.1

