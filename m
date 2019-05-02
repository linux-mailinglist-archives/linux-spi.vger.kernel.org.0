Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADA61114E
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEBCUA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:20:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEBCTS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kwVSEmX+7xvH0oZqkLgASzSDaFzaBNv6TP0vPiT1Y8g=; b=Wb5CNEaEpR9v
        lLpyZa1vpc4V8fMaqpjEintFLvcfrJ3nymkDSv8qcxvd3FPj2LO6EDH3OuwYeSlq4Y7JKJFcm+k6n
        C6hKaLiiFnfY+gXSJkQHfkBbXfbg0doMbSyKlcc/ViFh/GmvRYOJJzJris2UmMSQmmeF+nF6n2jvk
        XZQgw=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JY-0005wf-RC; Thu, 02 May 2019 02:19:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B70A2441D3E; Thu,  2 May 2019 03:19:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Add support for Intel Comet Lake" to the spi tree
In-Reply-To:  <20190416032743.180517-1-evgreen@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190502021909.B70A2441D3E@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Comet Lake

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

From 41a918026407be4ca2727cd0d6243fe6cdbfc4ed Mon Sep 17 00:00:00 2001
From: Evan Green <evgreen@chromium.org>
Date: Mon, 15 Apr 2019 20:27:43 -0700
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake

Add PCI IDs for SPI on Comet Lake.

Signed-off-by: Evan Green <evgreen@chromium.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3e6811ef37e8..f5546eeaebe4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1454,6 +1454,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
+	/* CML-LP */
+	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1

