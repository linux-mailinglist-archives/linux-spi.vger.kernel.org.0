Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE0D1576
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2019 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJIRWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Oct 2019 13:22:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbfJIRWj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Oct 2019 13:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qwYGtHKf1oxew2wsPDFUdsgZ8Gr3ylaMLpyV8cLQrdA=; b=ovbHdnBrp+9c
        +dDER4Fgl9qWdD8CXhLeqfiuc/ZWDdmYGkBy1ibOUQ2Z3cPw5uHzoSmuUg9LynjJWZJM1y7MSd8AJ
        5/oeFldL9SJ2EyJ2fnL7x3dK2KYd10n0yHfFn9eXYHvJOr6mDejIBoqXVJBG1kMKgjnyvacEgGpmZ
        rWUp8=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFfU-0005Kt-J8; Wed, 09 Oct 2019 17:22:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 316F7D03ED4; Wed,  9 Oct 2019 18:22:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     broonie@kernel.org, geert@linux-m68k.org,
        Hulk Robot <hulkci@huawei.com>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, zhengbin13@huawei.com
Subject: Applied "spi: omap-100k: Remove set but not used variable 'dataH'" to the spi tree
In-Reply-To: <1570581437-104549-2-git-send-email-zhengbin13@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172217.316F7D03ED4@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:22:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: omap-100k: Remove set but not used variable 'dataH'

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

From 944be39bd47cf0d45e50eb45b487031dde8569e5 Mon Sep 17 00:00:00 2001
From: zhengbin <zhengbin13@huawei.com>
Date: Wed, 9 Oct 2019 08:37:16 +0800
Subject: [PATCH] spi: omap-100k: Remove set but not used variable 'dataH'

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/spi/spi-omap-100k.c: In function spi100k_read_data:
drivers/spi/spi-omap-100k.c:140:6: warning: variable dataH set but not used [-Wunused-but-set-variable]

It is not used since commit 35c9049b2704 ("Add OMAP spi100k driver")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Link: https://lore.kernel.org/r/1570581437-104549-2-git-send-email-zhengbin13@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap-100k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b955ca8796d2..43a4785fc89b 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -128,7 +128,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 
 static int spi100k_read_data(struct spi_master *master, int len)
 {
-	int dataH, dataL;
+	int dataL;
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
 
 	/* Always do at least 16 bits */
@@ -146,7 +146,7 @@ static int spi100k_read_data(struct spi_master *master, int len)
 	udelay(1000);
 
 	dataL = readw(spi100k->base + SPI_RX_LSB);
-	dataH = readw(spi100k->base + SPI_RX_MSB);
+	readw(spi100k->base + SPI_RX_MSB);
 	spi100k_disable_clock(master);
 
 	return dataL;
-- 
2.20.1

