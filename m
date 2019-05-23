Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB127EB1
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfEWNtM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 May 2019 09:49:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45170 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbfEWNtL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 May 2019 09:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7sCHop0H5XL2JvcfwbrF/6GSO7hndzC8ThEqyQa9vc8=; b=uBeQDnqiLoPs
        rf2C2BXw1YYoD/9Xlqf4aOqHuFFUVluHU5yVr/fvmDlT7tGs53mUBaQgSaa6lqhBCrlouSXOoBHb6
        6snSGYY0B8xGUQyW9vxUswggI+bzGikaS+tb4Ck5Qjs4hM4NYBV2NgohTKvwxCc01ZWhe6pLb/zVI
        etKyk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTo5j-0000FL-J9; Thu, 23 May 2019 13:49:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1E3611126D28; Thu, 23 May 2019 14:49:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Super Liu <supercjliu@google.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: abort spi_sync if failed to prepare_transfer_hardware" to the spi tree
In-Reply-To: <20190522063014.50688-1-supercjliu@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20190523134907.1E3611126D28@debutante.sirena.org.uk>
Date:   Thu, 23 May 2019 14:49:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: abort spi_sync if failed to prepare_transfer_hardware

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From f3440d9a0da292dc4998d9393162fcfb996fd671 Mon Sep 17 00:00:00 2001
From: Super Liu <supercjliu@google.com>
Date: Wed, 22 May 2019 14:30:14 +0800
Subject: [PATCH] spi: abort spi_sync if failed to prepare_transfer_hardware

There is no chance to wait spi message complete if failed to
prepare_transfer_hardware(). Therefore, finalize this message and abort
transfer with corresponding return status to release this block case.

Logs:

[17400.283005] c7   3267 PM: PM: suspend entry 2019-05-04 03:01:14.403097147 UTC
[17400.283013] c7   3267 PM: suspend entry (deep)
[17400.283016] c6   3267 PM: Syncing filesystems ... done.
[17400.584395] c1    753 spi_geni 890000.spi: spi_geni_prepare_transfer_hardware:Error enabling SE resources -13
[17400.584404] c1    753 spi_master spi1: failed to prepare transfer hardware
[17400.664611] c4   3267 PM: PM: suspend exit 2019-05-04 03:01:15.235273018 UTC

Flow:

__spi_sync@spi.c
|    if (status == 0) {
|        /* Push out the messages in the calling context if we
|         * can.
|         */
|        if (ctlr->transfer == spi_queued_transfer) {
|            SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics,
|		spi_sync_immediate);
|            SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics,
|		spi_sync_immediate);
|		__spi_pump_messages(ctlr, false);
|        }
|
|        wait_for_completion(&done);	<== stuck here!!!
|        status = message->status;
|    }
|    message->context = NULL;
|    return status;
|
-->	__spi_pump_messages@spi.c
	|    if (!was_busy && ctlr->prepare_transfer_hardware) {
	|        ret = ctlr->prepare_transfer_hardware(ctlr);
	|        if (ret) {
	|            dev_err(&ctlr->dev,
	|		"failed to prepare transfer hardware\n");
	|
	|        if (ctlr->auto_runtime_pm)
	|            pm_runtime_put(ctlr->dev.parent);
	|            mutex_unlock(&ctlr->io_mutex);
	|            return;
	|        }
	|    }
	|
	-->	spi_geni_prepare_transfer_hardware@spi-geni-qcom.c
		|    ret = pm_runtime_get_sync(mas->dev);
		|    if (ret < 0) {
		|        dev_err(mas->dev,
		|		"%s:Error enabling SE resources %d\n",
		|		__func__, ret);
		|    pm_runtime_put_noidle(mas->dev);
		|    goto exit_prepare_transfer_hardware;

Signed-off-by: Super Liu <supercjliu@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..5e4654032bfa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1307,10 +1307,15 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		ret = ctlr->prepare_transfer_hardware(ctlr);
 		if (ret) {
 			dev_err(&ctlr->dev,
-				"failed to prepare transfer hardware\n");
+				"failed to prepare transfer hardware: %d\n",
+				ret);
 
 			if (ctlr->auto_runtime_pm)
 				pm_runtime_put(ctlr->dev.parent);
+
+			ctlr->cur_msg->status = ret;
+			spi_finalize_current_message(ctlr);
+
 			mutex_unlock(&ctlr->io_mutex);
 			return;
 		}
-- 
2.20.1

