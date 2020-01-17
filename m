Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7087D140E2D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 16:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAQPo5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 10:44:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgAQPoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jan 2020 10:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YZm/5f9wodQfID90hCH6kdu/JpRhW+QGeHbLTu7g0DM=; b=Wu4Px26QUDJX
        9BBVnJdZiujoKJDRPmgP7URAGeeMyS/2vWCDgNjtat6R+Jn/iNX6uDYsbaQoX2FpFED4ivBh0ykiy
        gWthDXylaQc0TVOl5Co7tjBTBLMpbclsVxl9c6jd3o8B7cq+SFdcTwtX8Hix9hiS2VevtxOixKqYe
        /084o=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnM-0006ua-JB; Fri, 17 Jan 2020 15:44:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4C87BD02A2A; Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, benjaminfair@google.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Subject: Applied "spi: npcm-pspi: fix 16 bit send and receive support" to the spi tree
In-Reply-To: <20200115162301.235926-2-tmaimon77@gmail.com>
Message-Id: <applied-20200115162301.235926-2-tmaimon77@gmail.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: npcm-pspi: fix 16 bit send and receive support

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

From 47416a5f27be0a0e815ef5f9f2f06618ae5e0470 Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 15 Jan 2020 18:22:58 +0200
Subject: [PATCH] spi: npcm-pspi: fix 16 bit send and receive support

Fixing NPCM BMC Peripheral SPI controller 16 bit
send and receive support by writing and reading
the SPI data in the right order.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Link: https://lore.kernel.org/r/20200115162301.235926-2-tmaimon77@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index fe624731c74c..c74611abe2a9 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -195,6 +195,7 @@ static void npcm_pspi_setup_transfer(struct spi_device *spi,
 static void npcm_pspi_send(struct npcm_pspi *priv)
 {
 	int wsize;
+	u16 val;
 
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
@@ -204,17 +205,18 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 
 	switch (wsize) {
 	case 1:
-		iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		val = *priv->tx_buf++;
+		iowrite8(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	case 2:
-		iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		val = *priv->tx_buf++;
+		val = *priv->tx_buf++ | (val << 8);
+		iowrite16(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return;
 	}
-
-	priv->tx_buf += wsize;
 }
 
 static void npcm_pspi_recv(struct npcm_pspi *priv)
@@ -230,18 +232,17 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 
 	switch (rsize) {
 	case 1:
-		val = ioread8(priv->base + NPCM_PSPI_DATA);
+		*priv->rx_buf++ = ioread8(priv->base + NPCM_PSPI_DATA);
 		break;
 	case 2:
 		val = ioread16(priv->base + NPCM_PSPI_DATA);
+		*priv->rx_buf++ = (val >> 8);
+		*priv->rx_buf++ = val & 0xff;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return;
 	}
-
-	*priv->rx_buf = val;
-	priv->rx_buf += rsize;
 }
 
 static int npcm_pspi_transfer_one(struct spi_master *master,
-- 
2.20.1

