Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3942E12A51E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 01:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLYAJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Dec 2019 19:09:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLYAJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Dec 2019 19:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qYw0hFHqV+Vl3T2a5+H9tmgzv/YFIJ5rUZWsEqa4kjM=; b=jFYpm02i2bxr
        freAE6sTbc05Z+WQUBYgfOFTPI3ixkGTDCeURqCaPV4N2fjsNO9Vk41GD5IhAsrQcDMa2Y96w1Md5
        YXJ4ISLhy4GMELV6vHTe7c4U8QN9zxTSCoQsFikwQY5MlG1BaxRxtEj5PpQaw4M2otXs++AYbdVVX
        ofAro=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEp-0007N3-K2; Wed, 25 Dec 2019 00:09:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 19413D01A1C; Wed, 25 Dec 2019 00:09:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Applied "spi: uniphier: Fix FIFO threshold" to the spi tree
In-Reply-To: <1577149107-30670-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <applied-1577149107-30670-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:19 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: Fix FIFO threshold

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

From 9cd34efbd3012171c102910ce17ee632a3cccb44 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:23 +0900
Subject: [PATCH] spi: uniphier: Fix FIFO threshold

Rx threshold means the value to inform the receiver when the number of words
in Rx FIFO is equal to or more than the value. Similarly, Tx threshold means
the value to inform the sender when the number of words in Tx FIFO is equal
to or less than the value. The controller triggers the driver to start
the transfer.

In case of Rx, the driver wants to detect that the specified number of words
N are in Rx FIFO, so the value of Rx threshold should be N. In case of Tx,
the driver wants to detect that the same number of spaces as Rx are in
Tx FIFO, so the value of Tx threshold should be (FIFO size - N).

For example, in order for the driver to receive at least 3 words from
Rx FIFO, set 3 to Rx threshold.
   +-+-+-+-+-+-+-+-+
   | | | | | |*|*|*|
   +-+-+-+-+-+-+-+-+

In order for the driver to send at least 3 words to Tx FIFO, because
it needs at least 3 spaces, set 8(FIFO size) - 3 = 5 to Tx threshold.
   +-+-+-+-+-+-+-+-+
   |*|*|*|*|*| | | |
   +-+-+-+-+-+-+-+-+

This adds new function uniphier_spi_set_fifo_threshold() to set
threshold value to the register.

And more, FIFO counts by 'words', so this renames 'fill_bytes' with
'fill_words', and fixes the calculation using bytes_per_words.

Fixes: 37ffab817098 ("spi: uniphier: introduce polling mode")
Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-2-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 47cde1864630..ce9b30112e26 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -290,25 +290,32 @@ static void uniphier_spi_recv(struct uniphier_spi_priv *priv)
 	}
 }
 
-static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
+static void uniphier_spi_set_fifo_threshold(struct uniphier_spi_priv *priv,
+					    unsigned int threshold)
 {
-	unsigned int fifo_threshold, fill_bytes;
 	u32 val;
 
-	fifo_threshold = DIV_ROUND_UP(priv->rx_bytes,
-				bytes_per_word(priv->bits_per_word));
-	fifo_threshold = min(fifo_threshold, SSI_FIFO_DEPTH);
-
-	fill_bytes = fifo_threshold - (priv->rx_bytes - priv->tx_bytes);
-
-	/* set fifo threshold */
 	val = readl(priv->base + SSI_FC);
 	val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
-	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, fifo_threshold);
-	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, fifo_threshold);
+	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, SSI_FIFO_DEPTH - threshold);
+	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, threshold);
 	writel(val, priv->base + SSI_FC);
+}
+
+static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
+{
+	unsigned int fifo_threshold, fill_words;
+	unsigned int bpw = bytes_per_word(priv->bits_per_word);
+
+	fifo_threshold = DIV_ROUND_UP(priv->rx_bytes, bpw);
+	fifo_threshold = min(fifo_threshold, SSI_FIFO_DEPTH);
+
+	uniphier_spi_set_fifo_threshold(priv, fifo_threshold);
+
+	fill_words = fifo_threshold -
+		DIV_ROUND_UP(priv->rx_bytes - priv->tx_bytes, bpw);
 
-	while (fill_bytes--)
+	while (fill_words--)
 		uniphier_spi_send(priv);
 }
 
-- 
2.20.1

