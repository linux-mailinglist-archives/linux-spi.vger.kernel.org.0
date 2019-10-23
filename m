Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7301DE22D0
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfJWS4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 14:56:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59578 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWS4V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 14:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nqE1Nk5jK5NBgKvImTRJ9R6aAstixqJMTF9OOA+og7g=; b=Vexv1cNQUf9I
        mrd4DfiwTlILHTQvYNCvftxFl9PvVNuU3eLFrdkxD1WNsUTLJu+DTDlnUBYefUR2eSBvMEGxsWVrF
        dp5crNrJK0yIs2OZz4eM6o2cEOjatSI7TUTmfwMUSSFefStFOC3LNyilrm6zhBwwcK3C50nQgF73C
        xA29g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLnu-0001Cj-67; Wed, 23 Oct 2019 18:56:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A624E274326D; Wed, 23 Oct 2019 19:56:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix spelling in the comments" to the spi tree
In-Reply-To: <20191023121643.25237-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185617.A624E274326D@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Fix spelling in the comments

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

From be73e323aee4e10eccef2b0f862c0196f392f012 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 23 Oct 2019 15:16:43 +0300
Subject: [PATCH] spi: Fix spelling in the comments

Two spelling mistakes are being fixed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191023121643.25237-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5414a10afd65..5ba19ef809c2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -92,7 +92,7 @@ static ssize_t driver_override_store(struct device *dev,
 	if (len) {
 		spi->driver_override = driver_override;
 	} else {
-		/* Emptry string, disable driver override */
+		/* Empty string, disable driver override */
 		spi->driver_override = NULL;
 		kfree(driver_override);
 	}
@@ -469,7 +469,7 @@ static LIST_HEAD(board_list);
 static LIST_HEAD(spi_controller_list);
 
 /*
- * Used to protect add/del opertion for board_info list and
+ * Used to protect add/del operation for board_info list and
  * spi_controller list, and their matching process
  * also used to protect object of type struct idr
  */
-- 
2.20.1

