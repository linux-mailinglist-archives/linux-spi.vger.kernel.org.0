Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2D11140
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfEBCTb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEBCTZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KTIDym5n89YyjI0B6fj5PPyt5UVebD97uh8Y7isROPg=; b=UzaDtAYjlDmk
        Dh0Z1QvcQAZAEYeIrILZUmjAgo77u+f4qhX+JKAbUf/B/K8+e+i/2HCxIGSMsWiQg37OTjKYVeQvD
        e5RFV4Ci0pJRp5Wp0acUUjI8L9LCsog8xS4lA3q/3VuYMz3BLAIhonklcokZl0DXEMeiRWEMnC6pO
        mO5XA=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Jh-0005xI-Tm; Thu, 02 May 2019 02:19:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7C052441D3C; Thu,  2 May 2019 03:19:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Remove one needless transfer speed fall back case" to the spi tree
In-Reply-To:  <20190412132551.2167-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021918.7C052441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:18 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Remove one needless transfer speed fall back case

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

From 76d2f7ee68b669c5825435bad204f3d9b4b55d18 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Fri, 12 Apr 2019 16:25:51 +0300
Subject: [PATCH] spi: Remove one needless transfer speed fall back case

Falling back to maximum speed of the controller in case of SPI slave
maximum speed is not set is needless. It already defaults to maximum
speed of the controller since commit 052eb2d49006 ("spi: core: Set
max_speed_hz of spi_device default to max_speed_hz of controller").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf4027b54a19..86a31340ad03 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3084,8 +3084,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (!xfer->speed_hz)
 			xfer->speed_hz = spi->max_speed_hz;
-		if (!xfer->speed_hz)
-			xfer->speed_hz = ctlr->max_speed_hz;
 
 		if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
 			xfer->speed_hz = ctlr->max_speed_hz;
-- 
2.20.1

