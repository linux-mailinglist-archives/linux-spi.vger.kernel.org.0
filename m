Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604621749E
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEHJJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:09:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57566 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHJJP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ARyarbQXXt2rh3Gfkn7QkFHlxg+cXwdPNsSN9TTkaLg=; b=s6z74lrhbdoY
        +NfCWqa2+U3CBFgpEhiDoeGTdj+nCW5Le8+K3poovDTKygim2q4sl1Ik8+OciIEldlTGON+53g1k7
        CRo5IKTsEnOBEa+zagcAsrDBppYsMW5ycJ5jFsnPQ+EH3AfORWfbRXn25rxS2aHQJsxIyl7FogFMi
        Te3VA=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZP-0007gF-Jx; Wed, 08 May 2019 09:09:03 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9A734440035; Wed,  8 May 2019 10:08:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Applied "spi: bcm2835: make the polling duration limits configurable" to the spi tree
In-Reply-To: <20190423201513.8073-5-kernel@martin.sperl.org>
X-Patchwork-Hint: ignore
Message-Id: <20190508090854.9A734440035@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: make the polling duration limits configurable

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From ff245d90ebed8d4da6751dfee1bc76e4a5e94257 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:11 +0000
Subject: [PATCH] spi: bcm2835: make the polling duration limits configurable

Under some circumstances the default 30 us polling limit is not optimal
and may lead to long delays because we are waiting on an interrupt.
with this patch we have the possibility to influence this policy.

So make this limit (in us) configurable via a module parameters
(but also modifyable via /sys/modules/...)

This replicates similar code found in spi-bcm2835aux.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 0d8c97502f14..3230d37fa89a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -73,14 +73,18 @@
 
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_POLLING_JIFFIES	2
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
 #define DRV_NAME	"spi-bcm2835"
 
+/* define polling limits */
+unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us,
+		 "time in us to run a transfer in polling mode\n");
+
 /**
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
@@ -711,8 +715,8 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	 */
 	bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
 
-	/* set the timeout */
-	timeout = jiffies + BCM2835_SPI_POLLING_JIFFIES;
+	/* set the timeout to at least 2 jiffies */
+	timeout = jiffies + 2 + HZ * polling_limit_us / 1000000;
 
 	/* loop until finished the transfer */
 	while (bs->rx_len) {
@@ -747,8 +751,8 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long spi_used_hz;
+	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
+	unsigned long hz_per_byte, byte_limit;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* set clock */
@@ -795,9 +799,11 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	 * per byte per polling limit.  E.g., we can transfer 1 byte in 30 us
 	 * per 300,000 Hz of bus clock.
 	 */
-#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_SPI_POLLING_LIMIT_US)
+	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
+	byte_limit = hz_per_byte ? spi_used_hz / hz_per_byte : 1;
+
 	/* run in polling mode for short transfers */
-	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
+	if (tfr->len < byte_limit)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right
-- 
2.20.1

