Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2813D1575
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2019 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfJIRWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Oct 2019 13:22:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRWj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Oct 2019 13:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=S3E8sWo9Y4EEsmfb0K6m1eYSNfhLzAUmTecuhOwaYQk=; b=NwzmEUDAZsBo
        p/aQ5lOcBMDNIe7/PUEZueRqX3mkIsVmHVXPvNkQ0YSyLK9BXD/22PtEW/+is2Bypmi5JAp0oNwoA
        vny/pIxJf9RpNPAL6WqjvJfRoriwsAmLv8Q7iKKlyo6DDZz/LwnSC0wIuuj/6VIPgzGA7EWYvbFe6
        VoLRE=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFfU-0005Ks-JA; Wed, 09 Oct 2019 17:22:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 15B1ED03ED3; Wed,  9 Oct 2019 18:22:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     broonie@kernel.org, geert@linux-m68k.org,
        Hulk Robot <hulkci@huawei.com>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, zhengbin13@huawei.com
Subject: Applied "spi: npcm: Remove set but not used variable 'val'" to the spi tree
In-Reply-To: <1570581437-104549-3-git-send-email-zhengbin13@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172217.15B1ED03ED3@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:22:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: npcm: Remove set but not used variable 'val'

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

From c46652ee6cacc42513e4f555f0050db2d537dab6 Mon Sep 17 00:00:00 2001
From: zhengbin <zhengbin13@huawei.com>
Date: Wed, 9 Oct 2019 08:37:17 +0800
Subject: [PATCH] spi: npcm: Remove set but not used variable 'val'

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/spi/spi-npcm-pspi.c: In function npcm_pspi_handler:
drivers/spi/spi-npcm-pspi.c:296:6: warning: variable val set but not used [-Wunused-but-set-variable]

It is not used since commit 2a22f1b30cee ("spi:
npcm: add NPCM PSPI controller driver")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Link: https://lore.kernel.org/r/1570581437-104549-3-git-send-email-zhengbin13@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index b191d57d1dc0..fe624731c74c 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -293,7 +293,6 @@ static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
 static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
 {
 	struct npcm_pspi *priv = dev_id;
-	u16 val;
 	u8 stat;
 
 	stat = ioread8(priv->base + NPCM_PSPI_STAT);
@@ -303,7 +302,7 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
 
 	if (priv->tx_buf) {
 		if (stat & NPCM_PSPI_STAT_RBF) {
-			val = ioread8(NPCM_PSPI_DATA + priv->base);
+			ioread8(NPCM_PSPI_DATA + priv->base);
 			if (priv->tx_bytes == 0) {
 				npcm_pspi_disable(priv);
 				complete(&priv->xfer_done);
-- 
2.20.1

