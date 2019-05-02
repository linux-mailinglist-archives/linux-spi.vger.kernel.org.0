Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77011165
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEBCTE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfEBCTE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4fhd/0syLJHO39pBd25DiW4kVIh2bbJroccFTqLRB8s=; b=c9sEe6AueoLh
        gyB3gQFzi7qMehbkzRuT7jLIdkiQskoifwsAZeHkJNWGutpxyIiSaeQf+eJDKUMUAdbyrL8ntvDNk
        2eEsq3UZNxjyLbuF8oHjH90+jgp8v6YvE9cNFa0CZlrv077jULrilgXL6ULSOKMTslSFQFfqRnnBP
        2XusI=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JI-0005uQ-Kk; Thu, 02 May 2019 02:18:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B91EA441D56; Thu,  2 May 2019 03:18:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hoan Nguyen An <na-hoan@jinso.co.jp>
Cc:     broonie@kernel.org, cv-dong@jinso.co.jp, geert+renesas@glider.be,
        h-inayoshi@jinso.co.jp, kuninori.morimoto.gx@renesas.com,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        magnus.damm@gmail.com, Mark Brown <broonie@kernel.org>,
        na-hoan@jinso.co.jp, yoshihiro.shimoda.uh@renesas.com
Subject: Applied "spi: rspi: Fix handling of QSPI code when transmit and receive" to the spi tree
In-Reply-To: <1556011161-10847-1-git-send-email-na-hoan@jinso.co.jp>
X-Patchwork-Hint: ignore
Message-Id: <20190502021853.B91EA441D56@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Fix handling of QSPI code when transmit and receive

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From 7e95b16625a3659a75c0ba4d5b0802324d16be13 Mon Sep 17 00:00:00 2001
From: Hoan Nguyen An <na-hoan@jinso.co.jp>
Date: Tue, 23 Apr 2019 18:19:21 +0900
Subject: [PATCH] spi: rspi: Fix handling of QSPI code when transmit and
 receive

Process handling QSPI when transmit/receive at qspi_trigger_transfer_out_in() as follows:
Setting the trigger, is the number of bytes in the FIFO buffer to determine
when there is an interrupt. Then check if the value of triggering number is
32-bytes or 1-byte, there will be corresponding processing
Handling (if (n == QSPI_BUFFER_SIZE) esle) this is unnecessary, leads to the
same processing of data transmission or reception, The difference here are with
ret = rspi_wait_for_tx_empty(rspi);
ret = rspi_wait_for_rx_full(rspi);

When the nummber trigger is 32 bytes, we only write into FIFO when the FIFO is completely empty
(interrupt transmission), and only receive if FIFO is full of 32 bytes of data.

In the case of a nummber trigger that is 1 byte, in principle we still need to process
rspi_wait_for_tx_empty/full so that FIFO is empty only with the amount of data we need to write to
or equal to the number of bytes we need to receive, There is currently no processing of this.
And in the current case with this patch, at this time it only needs at least 1 byte received in
FIFO that has interrupt received, or FIFO at least 1bytes free can be written into FIFO,
This patch therefore does not affect this processing.
So we need to eliminate unnecessary waste processing (if (n == QSPI_BUFFER_SIZE) esle),
more precisely in waiting for FIFO status.
The same with handling in qspi_transfer_out()/qspi_transfer_in().

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 71 +++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 3be8fbe80b08..15f5723d9f95 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -739,27 +739,22 @@ static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 	while (len > 0) {
 		n = qspi_set_send_trigger(rspi, len);
 		qspi_set_receive_trigger(rspi, len);
-		if (n == QSPI_BUFFER_SIZE) {
-			ret = rspi_wait_for_tx_empty(rspi);
-			if (ret < 0) {
-				dev_err(&rspi->ctlr->dev, "transmit timeout\n");
-				return ret;
-			}
-			for (i = 0; i < n; i++)
-				rspi_write_data(rspi, *tx++);
+		ret = rspi_wait_for_tx_empty(rspi);
+		if (ret < 0) {
+			dev_err(&rspi->ctlr->dev, "transmit timeout\n");
+			return ret;
+		}
+		for (i = 0; i < n; i++)
+			rspi_write_data(rspi, *tx++);
 
-			ret = rspi_wait_for_rx_full(rspi);
-			if (ret < 0) {
-				dev_err(&rspi->ctlr->dev, "receive timeout\n");
-				return ret;
-			}
-			for (i = 0; i < n; i++)
-				*rx++ = rspi_read_data(rspi);
-		} else {
-			ret = rspi_pio_transfer(rspi, tx, rx, n);
-			if (ret < 0)
-				return ret;
+		ret = rspi_wait_for_rx_full(rspi);
+		if (ret < 0) {
+			dev_err(&rspi->ctlr->dev, "receive timeout\n");
+			return ret;
 		}
+		for (i = 0; i < n; i++)
+			*rx++ = rspi_read_data(rspi);
+
 		len -= n;
 	}
 
@@ -796,19 +791,14 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 
 	while (n > 0) {
 		len = qspi_set_send_trigger(rspi, n);
-		if (len == QSPI_BUFFER_SIZE) {
-			ret = rspi_wait_for_tx_empty(rspi);
-			if (ret < 0) {
-				dev_err(&rspi->ctlr->dev, "transmit timeout\n");
-				return ret;
-			}
-			for (i = 0; i < len; i++)
-				rspi_write_data(rspi, *tx++);
-		} else {
-			ret = rspi_pio_transfer(rspi, tx, NULL, len);
-			if (ret < 0)
-				return ret;
+		ret = rspi_wait_for_tx_empty(rspi);
+		if (ret < 0) {
+			dev_err(&rspi->ctlr->dev, "transmit timeout\n");
+			return ret;
 		}
+		for (i = 0; i < len; i++)
+			rspi_write_data(rspi, *tx++);
+
 		n -= len;
 	}
 
@@ -833,19 +823,14 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 
 	while (n > 0) {
 		len = qspi_set_receive_trigger(rspi, n);
-		if (len == QSPI_BUFFER_SIZE) {
-			ret = rspi_wait_for_rx_full(rspi);
-			if (ret < 0) {
-				dev_err(&rspi->ctlr->dev, "receive timeout\n");
-				return ret;
-			}
-			for (i = 0; i < len; i++)
-				*rx++ = rspi_read_data(rspi);
-		} else {
-			ret = rspi_pio_transfer(rspi, NULL, rx, len);
-			if (ret < 0)
-				return ret;
+		ret = rspi_wait_for_rx_full(rspi);
+		if (ret < 0) {
+			dev_err(&rspi->ctlr->dev, "receive timeout\n");
+			return ret;
 		}
+		for (i = 0; i < len; i++)
+			*rx++ = rspi_read_data(rspi);
+
 		n -= len;
 	}
 
-- 
2.20.1

