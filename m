Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5889AD8D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2019 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfHWKqU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Aug 2019 06:46:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389133AbfHWKqU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Aug 2019 06:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vMxwaeECDuLY4X7b/ub+NP1qFx7pA5yp8GiXy0T0uKE=; b=pyr0jeXHPBHS
        Is2HNReV0ZhM/m3KveCZTy/vHXVUggZ4DENVrRUgFNiRwSwWPhhzAoXB4sR5ey6aNrb82WCMmnFje
        dN/ZsGoHiO4m4BKqYXwTnw1R6xKW0aApo+0+etKO4fYIfwGiULcU6xZT3rx0jKWOoa/Q6TuKL3IP5
        ANY6s=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i175G-0002tX-L5; Fri, 23 Aug 2019 10:46:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5C92FD02CD0; Fri, 23 Aug 2019 11:46:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours" to the spi tree
In-Reply-To: <20190822212450.21420-2-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190823104618.5C92FD02CD0@fitzroy.sirena.org.uk>
Date:   Fri, 23 Aug 2019 11:46:18 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours

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

From 421f4579df345166ec61020eb453f65d6107bfec Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 23 Aug 2019 00:24:50 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not
 ours

The DSPI interrupt can be shared between two controllers at least on the
LX2160A. In that case, the driver for one controller might misbehave and
consume the other's interrupt. Fix this by actually checking if any of
the bits in the status register have been asserted.

Fixes: 13aed2392741 ("spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190822212450.21420-2-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..545fc8189fb0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -886,9 +886,11 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 					trans_mode);
 			}
 		}
+
+		return IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-- 
2.20.1

