Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9CE0B41
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfJVSP7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 14:15:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfJVSP7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 14:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PkF5cxjifQUvmm3oKr2fqU6er/70xYD8bLL1kTg2wkE=; b=dnbCzf3SGkEO
        pp8nbTv7nPmEc0VQvEvUMfdCqW90NfuuLDzp7lrHmwCtbdxi1maglK9vKCmnow0H3LjNw7qefDasn
        gXLYVsjffKiZY7c5X6LgQMYVMB0fpYkJary1ahPc9DrRZsVkw+Nx1sTC/e+cAjI0DOCTdlXv6bL2T
        UQUco=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMyhG-0007Ck-2C; Tue, 22 Oct 2019 18:15:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7B4392743259; Tue, 22 Oct 2019 19:15:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Applied "spi: dw-pci: Fix Chip Select amount on Intel Elkhart Lake PSE SPI" to the spi tree
In-Reply-To: <20191018132131.31608-3-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191022181553.7B4392743259@ypsilon.sirena.org.uk>
Date:   Tue, 22 Oct 2019 19:15:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-pci: Fix Chip Select amount on Intel Elkhart Lake PSE SPI

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

From c97905cae914ad955b79212a454016a68c7a1a21 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Fri, 18 Oct 2019 16:21:31 +0300
Subject: [PATCH] spi: dw-pci: Fix Chip Select amount on Intel Elkhart Lake PSE
 SPI

Intel(R) Programmable Services Engine (Intel(R) PSE) SPI controllers in
Intel Elkhart Lake have two Chip Select signals instead of one.

Reported-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20191018132131.31608-3-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 1cddecea2715..12c131b5fb4e 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -36,7 +36,7 @@ static struct spi_pci_desc spi_pci_mid_desc_2 = {
 };
 
 static struct spi_pci_desc spi_pci_ehl_desc = {
-	.num_cs = 1,
+	.num_cs = 2,
 	.bus_num = -1,
 	.max_freq = 100000000,
 };
-- 
2.20.1

