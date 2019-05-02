Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF911166
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEBCTE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEBCTE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aQcIAK37ePlgZcojTuUqaapKxWplc+a2fIA7ntOLNqQ=; b=WPJXVK9drn2H
        lb6xQTDJ1sqtC+XaPIyyg1wAdLSuP57zQ57lymjKGpzwf9iiRrlak0P18gu9+8HPNb3wvGBWH7YIi
        LaXt5zXzKEZi46mW1mzZZ3Zd2tngmCdfazb2g+RpExUEl1dOBJIgJLnVg+9/pdQbclcxjWnmgO/jR
        lYbJo=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JL-0005v0-Ll; Thu, 02 May 2019 02:18:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AF9DE441D3D; Thu,  2 May 2019 03:18:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: fix PIO transfer" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190502021856.AF9DE441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:56 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: fix PIO transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From cc1b69fc5f9f52cf18295db05cad57187cee1c1d Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 15 Apr 2019 14:30:26 -0700
Subject: [PATCH] spi: tegra114: fix PIO transfer

This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 register.
Current driver uses DMA_EN instead of PIO bit.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b57f10182fae..21e4fdad013f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
 	tspi->is_curr_dma_xfer = false;
 
-	val |= SPI_DMA_EN;
-	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
+	val = tspi->command1_reg;
+	val |= SPI_PIO;
+	tegra_spi_writel(tspi, val, SPI_COMMAND1);
 	return 0;
 }
 
-- 
2.20.1

