Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9770C12A8D0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 19:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLYSWL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 13:22:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYSWL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Dec 2019 13:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UKIzY/f7TEOv+J/m6RziwCjTAcsKJQY2fq1YwH7qCkc=; b=Nis59cQ1Tik8
        OSg3Jtaov5pmmqW4ljSB+N2IyyzY+b6hwNUl56dZH/vS6SmmTgKGJg+gSSaY0MycIkwGbe/rztQUb
        ntoCFO5AAH/l2Y+XUhq0qizSzlPW4AV9GjSRI/a8eP0NaBxbX5oFhoGtsYiQ5FDerLcmg53Agv4dk
        wOcW0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikBIN-0001ox-5P; Wed, 25 Dec 2019 18:22:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A8F0FD01A47; Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhengbin13@huawei.com
Subject: Applied "spi: tegra114: use true,false for bool variable" to the spi tree
In-Reply-To: <1577159526-33689-4-git-send-email-zhengbin13@huawei.com>
Message-Id: <applied-1577159526-33689-4-git-send-email-zhengbin13@huawei.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: use true,false for bool variable

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

From 0d9c75481a8e0129f82e0b09a5e36eb1cc76c2b8 Mon Sep 17 00:00:00 2001
From: zhengbin <zhengbin13@huawei.com>
Date: Tue, 24 Dec 2019 11:52:06 +0800
Subject: [PATCH] spi: tegra114: use true,false for bool variable

Fixes coccicheck warning:

drivers/spi/spi-tegra114.c:272:2-17: WARNING: Assignment of 0/1 to bool variable
drivers/spi/spi-tegra114.c:275:2-17: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Link: https://lore.kernel.org/r/1577159526-33689-4-git-send-email-zhengbin13@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index fc40ab146c86..83edabdb41ad 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -269,10 +269,10 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	if ((bits_per_word == 8 || bits_per_word == 16 ||
 	     bits_per_word == 32) && t->len > 3) {
-		tspi->is_packed = 1;
+		tspi->is_packed = true;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-		tspi->is_packed = 0;
+		tspi->is_packed = false;
 		tspi->words_per_32bit = 1;
 	}
 
-- 
2.20.1

