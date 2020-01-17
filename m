Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1375140E1B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAQPo3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 10:44:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgAQPo2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jan 2020 10:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OLiRkTiNsNVQz0cnhObQmj3OE8SFBdDA+rkocfifZkg=; b=GsXZfwNyhAHn
        0Cz1GAmoeQrP1sj5NQkAPr33KLfcFyITH0YQFLdjkVJk78+UwZJ6b5Aybxn+xANHcEi1xyGejQZea
        YbZrPNBosCVt37C+Q0mmByRhe9+YcAQEzdVMLaqim4lYYvut6zH5D8xWWoRolE29XGmYGl2EwRlqg
        mhFFQ=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnM-0006uf-NG; Fri, 17 Jan 2020 15:44:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6EDCED02BD9; Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Add support for Intel Comet Lake PCH-V" to the spi tree
In-Reply-To: <20200116091035.575175-1-jarkko.nikula@linux.intel.com>
Message-Id: <applied-20200116091035.575175-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Comet Lake PCH-V

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

From 6157d4c255609da28f5a271ec1d56d74beb4c8be Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Thu, 16 Jan 2020 11:10:35 +0200
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake PCH-V

Add support for Intel Comet Lake PCH-V which has the same LPSS than on
Intel Kaby lake unlike other Intel Comet Lake PCH variants that are based
on Intel Cannon Lake PCH LPSS.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Link: https://lore.kernel.org/r/20200116091035.575175-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d58791d92c73..8114d3289fdc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1423,6 +1423,9 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* KBL-H */
 	{ PCI_VDEVICE(INTEL, 0xa2a9), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa2aa), LPSS_SPT_SSP },
+	/* CML-V */
+	{ PCI_VDEVICE(INTEL, 0xa3a9), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa3aa), LPSS_SPT_SSP },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
-- 
2.20.1

