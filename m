Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7219C4CEBD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFTNcr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 09:32:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59530 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfFTNcq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 09:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rZMUmhqov9N+WKT0f0ZFqk9rcPF4Vvdn8EoZRYcyfSY=; b=bKyOqOaxRPHA
        t0lXYbkRosLnZUwQOjpVPrwQdwvbcKKV2R7FedEaegNwj28iyaacwGyx+RACKAr5+vzZZbc8LweHn
        WYfF/Mmt+xihYe9zZaEkQlPJrdUHXl46czsKPig8FaQ62dCS2TrG08fQNLiU/1UToeEQE6wRbxxja
        y49+g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdxB7-0000ku-97; Thu, 20 Jun 2019 13:32:37 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id C9BA0440049; Thu, 20 Jun 2019 14:32:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     ard.biesheuvel@linaro.org, broonie@kernel.org,
        jaswinder.singh@linaro.org, kbuild-all@01.org,
        kbuild test robot <lkp@intel.com>, linux-spi@vger.kernel.org,
        lkp@intel.com, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-synquacer: Fixed build on architectures missing readsl/writesl series" to the spi tree
In-Reply-To: <20190620082426.14530-1-masahisa.kojima@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190620133236.C9BA0440049@finisterre.sirena.org.uk>
Date:   Thu, 20 Jun 2019 14:32:36 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-synquacer: Fixed build on architectures missing readsl/writesl series

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

From 51c711f2c38a412aaeda43c8167fe41877cf414d Mon Sep 17 00:00:00 2001
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 20 Jun 2019 17:24:26 +0900
Subject: [PATCH] spi: spi-synquacer: Fixed build on architectures missing
 readsl/writesl series

kbuild test reported that alpha and some of the architectures
are missing readsl/writesl series.
Use more portable ioread32_rep()/iowrite32_rep() series.

Fixes: b0823ee35cf9b ("spi: Add spi driver for Socionext SynQuacer platform")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-synquacer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index c8c8d9cdd4b3..f99abd85c50a 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -150,14 +150,16 @@ static int read_fifo(struct synquacer_spi *sspi)
 	case 8: {
 		u8 *buf = sspi->rx_buf;
 
-		readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread8_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			    buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
 	case 16: {
 		u16 *buf = sspi->rx_buf;
 
-		readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread16_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			     buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
@@ -166,7 +168,8 @@ static int read_fifo(struct synquacer_spi *sspi)
 	case 32: {
 		u32 *buf = sspi->rx_buf;
 
-		readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread32_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			     buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
@@ -191,14 +194,16 @@ static int write_fifo(struct synquacer_spi *sspi)
 	case 8: {
 		const u8 *buf = sspi->tx_buf;
 
-		writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite8_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			     buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
 	case 16: {
 		const u16 *buf = sspi->tx_buf;
 
-		writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite16_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			      buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
@@ -207,7 +212,8 @@ static int write_fifo(struct synquacer_spi *sspi)
 	case 32: {
 		const u32 *buf = sspi->tx_buf;
 
-		writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite32_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			      buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
-- 
2.20.1

