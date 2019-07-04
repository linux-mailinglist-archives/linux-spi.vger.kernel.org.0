Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6A5F808
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2019 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfGDMZR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jul 2019 08:25:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGDMZR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jul 2019 08:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YbneCSzLtsJnB6By++bZkSMpwaM/CYnrFwY41uFPXsQ=; b=awGKWgixSsW6
        Drn+KGJYsUoLqAYa49wV6Beu/Xs3kJoPUuednvPLZ4my4CVYMeePwd8Kty9S95zPl53iT71RXk2JE
        IGSipqNH+d1c2wuifz8jPqTzIppaaKVbA15T9AyTnz0oh9xQUoEtWZ7FIT89Or0DdeIfquzInrWBv
        mBJXE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0nY-0000js-TU; Thu, 04 Jul 2019 12:25:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 67968274388A; Thu,  4 Jul 2019 13:25:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Add support for Intel Elkhart Lake" to the spi tree
In-Reply-To: <20190703114603.22301-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190704122512.67968274388A@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 13:25:12 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Elkhart Lake

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

From 8cc7720470a17558bd6f8d67df63361600e46c55 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Wed, 3 Jul 2019 14:46:03 +0300
Subject: [PATCH] spi: pxa2xx: Add support for Intel Elkhart Lake

Intel Elkhart Lake has the same LPSS than Intel Broxton. Add support for
it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190703114603.22301-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 259c20f7a542..fc7ab4b26880 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1437,6 +1437,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x34aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x34ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x34fb), LPSS_CNL_SSP },
+	/* EHL */
+	{ PCI_VDEVICE(INTEL, 0x4b2a), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4b2b), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4b37), LPSS_BXT_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.20.1

