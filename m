Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE02325905
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfEUUdR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 16:33:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfEUUdQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 16:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sByoT6kwfKLoPmlh4sQ+/u/QxYVQA9jsGiWj5JWD1SM=; b=f3XaqYoGdLaB
        ybUEFKseMeFobiIM7fzIQlSMs/ybCgbCVR8b76Zt07g3B0IThZZR0pLRh2Ew6lDESywUKnA5tp3Wp
        du6nRwo+6Xy64RLWs/iJtbEuWJJa7MuW1eLWMn+DVPHTlE8/y3WtYd2JbR94p4RipWS/u2022DpuR
        UMJoc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRg-00022i-Gk; Tue, 21 May 2019 20:33:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A48CA1126D18; Tue, 21 May 2019 21:33:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     broonie@kernel.org, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev: Add dhcom-board to compatibility list" to the spi tree
In-Reply-To: <20190516110149.6165-1-cniedermaier@dh-electronics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203309.A48CA1126D18@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:33:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev: Add dhcom-board to compatibility list

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

From 9783da2384c5623d376e4641bbce9339be1001eb Mon Sep 17 00:00:00 2001
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Date: Thu, 16 May 2019 13:01:49 +0200
Subject: [PATCH] spi: spidev: Add dhcom-board to compatibility list

Prepare to use devices on the external SPI interface
on a DH electronics Development Board.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index ce9142d87f41..df4c0a9b34dd 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -672,6 +672,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
+	{ .compatible = "dh,dhcom-board" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.20.1

