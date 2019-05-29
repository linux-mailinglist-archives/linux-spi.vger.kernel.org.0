Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E402E172
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2019 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2Ppo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 May 2019 11:45:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Ppn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 May 2019 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SFUcAWGUAUUKHowTC8cn4GA1KTcSwBBPNRW8bn19lAw=; b=Wy3QBNQTbVDl
        bHx0tVLK8+dOlAkde8Sz2vUNDc8tFDuo8aXT46PXdYW+8qxHhh+2qZPbqR6vkAqC7TmOgPRXqoFbW
        eFkT9T5nepZkAFhSe+9rrOwDswg8UhCxWmW6YT37XMsMZz3WDtLxQ+WtrD3VZAee0JwuC3XnrjP61
        sFd5Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hW0lo-000528-1K; Wed, 29 May 2019 15:45:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 527A5440046; Wed, 29 May 2019 16:45:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spidev: Add M53Menlo CPLD compatible" to the spi tree
In-Reply-To: <20190529102451.4548-1-marex@denx.de>
X-Patchwork-Hint: ignore
Message-Id: <20190529154539.527A5440046@finisterre.sirena.org.uk>
Date:   Wed, 29 May 2019 16:45:39 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spidev: Add M53Menlo CPLD compatible

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

From c6e2d2c7ca4e6d09bc07ab5ced2e687cc842a860 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Wed, 29 May 2019 12:24:51 +0200
Subject: [PATCH] spidev: Add M53Menlo CPLD compatible

Add compatible string for Menlosystems CPLD present on the M53Menlo
board. This CPLD is used to communicate with various custom sensors.

Signed-off-by: Marek Vasut <marex@denx.de>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index df4c0a9b34dd..30498cf25f3b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -673,6 +673,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
 	{ .compatible = "dh,dhcom-board" },
+	{ .compatible = "menlo,m53cpld" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.20.1

