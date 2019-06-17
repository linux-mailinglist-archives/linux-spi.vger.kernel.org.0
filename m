Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336B548707
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFQPY5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 11:24:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfFQPY5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 11:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iOqLgkdilFnLHLMJQ5zYUD9aMZOdA8/Ai44+vLhw43M=; b=U4DyaRpwUUlq
        06jKxh/d2tR3etJYlIU4yw2f0bTHgbO4HsJl5ZsogHv/x1Yl4hOnTQyJgGMxwF2ahhfeKrGLudMEm
        fv7GSfxr1aK7F0zV5ztE4oL8BcNdI3iAVPrR8BEFCyyVhXnFWjLCQMXMLhnH6JNfTjHc/JtdSWN0b
        DtY94=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctV7-000201-Pv; Mon, 17 Jun 2019 15:24:53 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5B4C4440046; Mon, 17 Jun 2019 16:24:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: No need to assign dummy value in spi_unregister_controller()" to the spi tree
In-Reply-To: <20190615174135.86181-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190617152453.5B4C4440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: No need to assign dummy value in spi_unregister_controller()

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

From ebc37af5e0a134355ea2b62ed4141458bdbd5389 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 15 Jun 2019 20:41:35 +0300
Subject: [PATCH] spi: No need to assign dummy value in
 spi_unregister_controller()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The device_for_each_child() doesn't require the returned value to be checked.
Thus, drop the dummy variable completely and have no warning anymore:

drivers/spi/spi.c: In function ‘spi_unregister_controller’:
drivers/spi/spi.c:2480:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
  int dummy;
      ^~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 498f9b7419a4..e71881afe475 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2559,7 +2559,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 {
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
-	int dummy;
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
@@ -2573,7 +2572,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&ctlr->dev, NULL, __unregister);
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-- 
2.20.1

