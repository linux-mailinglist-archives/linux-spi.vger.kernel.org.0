Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2937F5EB
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392361AbfHBLWP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 07:22:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33016 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfHBLWP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 07:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=l+cdVxJJSsoYTIo1hdmIkEORvCQ55GeiYI8+8B98XqQ=; b=dXvvPxpfC25i
        D6TrZfqTuwHRIyqVSr9Om5QOeJwz6kNW1m15/+S1Rc2RjjantA1alSOuELRa0mbqpEOo5fACurNJX
        uDSIc01y1NkxrCBtvbt1DoYJEGempyrKGxb5F6Whj9yBnMBhaHEE3jwKJpsTVAHvPBMAQawXxXI3H
        iWHmA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVdS-0007SB-70; Fri, 02 Aug 2019 11:22:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8C8F32742E44; Fri,  2 Aug 2019 12:22:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Add support for Intel Tiger Lake" to the spi tree
In-Reply-To: <20190801134901.12635-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190802112209.8C8F32742E44@ypsilon.sirena.org.uk>
Date:   Fri,  2 Aug 2019 12:22:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Tiger Lake

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

From a4127952859a869cf3fc5a49547dbe2ffa2eac89 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Thu, 1 Aug 2019 16:49:01 +0300
Subject: [PATCH] spi: pxa2xx: Add support for Intel Tiger Lake

Intel Tiger Lake -LP LPSS SPI controller is otherwise similar than
Cannon Lake but has more controllers and up to two chip selects per
controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190801134901.12635-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 22513caf2000..bb6a14d1ab0f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1457,6 +1457,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* TGL-LP */
+	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0de), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0df), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1

