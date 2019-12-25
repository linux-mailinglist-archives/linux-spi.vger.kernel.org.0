Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1639512A8D1
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLYSWM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 13:22:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfLYSWL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Dec 2019 13:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yNeFxbY6ktE6pdGxR4Z7NfgPDZEau3aG7QfcsaLQcd8=; b=QEcbc3GZxdup
        0sqDZB7YIgMi1GWl+DQ9q68Kv9PN81/m9Fy2VbzpbqT4mQgmDQ5eUe5ZC5z5DPGPnLn+nJLO5Cy3A
        WLDXfO2AcwZ/Jhbjyt61149ZCcS7euNJUA4GFOF17hPIy4mwGinAqmD/6AOhnVVT5tKHIhgG65p1z
        VNE0E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikBIN-0001oy-8w; Wed, 25 Dec 2019 18:22:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id C3EC3D01A4F; Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhengbin13@huawei.com
Subject: Applied "spi: imx: use true,false for bool variable" to the spi tree
In-Reply-To: <1577159526-33689-3-git-send-email-zhengbin13@huawei.com>
Message-Id: <applied-1577159526-33689-3-git-send-email-zhengbin13@huawei.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: imx: use true,false for bool variable

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From e6a8b2cc514ccacb9e1885dcc7be0a3251ab4843 Mon Sep 17 00:00:00 2001
From: zhengbin <zhengbin13@huawei.com>
Date: Tue, 24 Dec 2019 11:52:05 +0800
Subject: [PATCH] spi: imx: use true,false for bool variable

Fixes coccicheck warning:

drivers/spi/spi-imx.c:1233:2-17: WARNING: Assignment of 0/1 to bool variable
drivers/spi/spi-imx.c:1235:2-17: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Link: https://lore.kernel.org/r/1577159526-33689-3-git-send-email-zhengbin13@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 49f0099db0cb..f4f28a400a96 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1230,9 +1230,9 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	}
 
 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
-		spi_imx->usedma = 1;
+		spi_imx->usedma = true;
 	else
-		spi_imx->usedma = 0;
+		spi_imx->usedma = false;
 
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
-- 
2.20.1

