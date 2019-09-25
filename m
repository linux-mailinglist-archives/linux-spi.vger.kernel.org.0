Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5874BE2C5
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392112AbfIYQrY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 12:47:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392099AbfIYQrY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Sep 2019 12:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SldDdMCvb42kOlw4xzQW7gVTJLjho+01MgP87kKdXpk=; b=axofkkkgudCy
        wW1h64JlpzlwI9A+1kf4uxowV0hE6LS4aZnPVwdGiz26DHaspPObyClnZmIt5pwQJTpM9vDkQyx+y
        8UyIzr92Z8lcASQSvjiu//j5k/5PvvyP5cycd+QFa5SKEKyxpMhrCeQaPHCfFIdIxLFEmRZI/4Bcy
        7liZ0=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDARf-0007uX-Ka; Wed, 25 Sep 2019 16:47:15 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 18588D01BD1; Wed, 25 Sep 2019 17:47:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     kbuild test robot <lkp@intel.com>, krzk@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add call to spi_slave_abort() function when spidev driver is released" to the spi tree
In-Reply-To: <20190925091143.15468-2-lukma@denx.de>
X-Patchwork-Hint: ignore
Message-Id: <20190925164714.18588D01BD1@fitzroy.sirena.org.uk>
Date:   Wed, 25 Sep 2019 17:47:14 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add call to spi_slave_abort() function when spidev driver is released

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 9f918a728cf86b2757b6a7025e1f46824bfe3155 Mon Sep 17 00:00:00 2001
From: Lukasz Majewski <lukma@denx.de>
Date: Wed, 25 Sep 2019 11:11:42 +0200
Subject: [PATCH] spi: Add call to spi_slave_abort() function when spidev
 driver is released

This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
in the slave mode (like NXP's dspi driver for Vybrid SoC).

When SPI HW works in this mode - the master is responsible for providing
CS and CLK signals. However, when some fault happens - like for example
distortion on SPI lines - the SPI Linux driver needs a chance to recover
from this abnormal situation and prepare itself for next (correct)
transmission.

This change doesn't pose any threat on drivers working in master mode as
spi_slave_abort() function checks if SPI slave mode is supported.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Link: https://lore.kernel.org/r/20190924110547.14770-2-lukma@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20190925091143.15468-2-lukma@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..3ea9d8a3e6e8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -627,6 +627,9 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		if (dofree)
 			kfree(spidev);
 	}
+#ifdef CONFIG_SPI_SLAVE
+	spi_slave_abort(spidev->spi);
+#endif
 	mutex_unlock(&device_list_lock);
 
 	return 0;
-- 
2.20.1

