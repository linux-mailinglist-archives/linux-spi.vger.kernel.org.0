Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F61CC211
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2019 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbfJDRww (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Oct 2019 13:52:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbfJDRwv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Oct 2019 13:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=icF1PnfaBIU2wuXv0YbLmQz3SxUsELWwRB6fPKw37KE=; b=Wjnnd151pMcb
        epSb5ND2XSeyUmu/xmByfs7NfzcFT0jmyvjgmQYbCkGORIdSlWIhx2jbcDJuePesoWYNn5kZpGhuD
        3zgjomxvbwfxbTgLI1ffz18hKsKTsQQamhFI4LX4eZ57BxUCei+d4oUK16l5Ulzes+8dBeycvd1GE
        t7Fgc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGRl3-0003xC-Gn; Fri, 04 Oct 2019 17:52:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 06BDF2741EF2; Fri,  4 Oct 2019 18:52:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode" to the spi tree
In-Reply-To: <20191001205216.32115-1-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191004175249.06BDF2741EF2@ypsilon.sirena.org.uk>
Date:   Fri,  4 Oct 2019 18:52:48 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 3c0f9d8bcf47ed33f479cf9dc933d405020aefe4 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 1 Oct 2019 23:52:16 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode

With this patch, the "interrupts" property from the device tree bindings
is ignored, even if present, if the driver runs in TCFQ mode.

Switching to using the DSPI in poll mode has several distinct
benefits:

- With interrupts, the DSPI driver in TCFQ mode raises an IRQ after each
  transmitted word. There is more time wasted for the "waitq" event than
  for actual I/O. And the DSPI IRQ count can easily get the largest in
  /proc/interrupts on Freescale boards with attached SPI devices.

- The SPI I/O time is both lower, and more consistently so. Attached to
  some Freescale devices are either PTP switches, or SPI RTCs. For
  reading time off of a SPI slave device, it is important that all SPI
  transfers take a deterministic time to complete.

- In poll mode there is much less time spent by the CPU in hardirq
  context, which helps with the response latency of the system, and at
  the same time there is more control over when interrupts must be
  disabled (to get a precise timestamp measurement, which will come in a
  future patch): win-win.

On the LS1021A-TSN board, where the SPI device is a SJA1105 PTP switch
(with a bits_per_word=8 driver), I created a "benchmark" where I
periodically transferred a 12-byte message once per second, for 120
seconds. I then recorded the time before putting the first byte in the
TX FIFO, and the time after reading the last byte from the RX FIFO. That
is the transfer delay in nanoseconds.

Interrupt mode:

  delay: min 125120 max 168320 mean 150286 std dev 17675.3

Poll mode:

  delay: min 69440 max 119040 mean 70312.9 std dev 8065.34

Both the mean latency and the standard deviation are more than 50% lower
in poll mode than in interrupt mode, and the 'max' in poll mode is lower
than the 'min' in interrupt mode. This is with an 'ondemand' governor on
an otherwise idle system - therefore running mostly at 600 MHz out of a
max of 1200 MHz.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20191001205216.32115-1-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 2c0f211eed87..c61074502145 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -707,7 +707,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
+	if (!(spi_sr & SPI_SR_EOQF))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0) {
@@ -1134,6 +1134,9 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi_init(dspi);
 
+	if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE)
+		goto poll_mode;
+
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		dev_info(&pdev->dev,
-- 
2.20.1

