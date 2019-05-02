Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4B11135
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEBCTQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEBCTQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=R2j1F1wG65fNXhdJylyMnKqAApoSPDTfJTSPsQzYInI=; b=oLzyp+d1FTxd
        XFjAxkD/AxSEaW4Wk1USCkF73J1VnldM6Cae4/6zjUCOnIKUEHQ/mD8Dcrm8WFs/CFAUEVdDps4Av
        KAarUqzYoYLU8GEOs3Z2c7rDQ+1EubOQX0x7BrLhD/+sKI+D8u4yCXFf8WDwDGAlS81cx1gKG9mll
        oV9Xg=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JQ-0005vZ-Hf; Thu, 02 May 2019 02:19:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5D8EE441D3D; Thu,  2 May 2019 03:19:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, dagmcr@gmail.com,
        javier@dowhile0.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        lars@metafoo.de, lgirdwood@gmail.com, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "spi: AD ASoC: declare missing of table" to the spi tree
In-Reply-To: <1555960353-8836-1-git-send-email-dagmcr@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021900.5D8EE441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:00 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: AD ASoC: declare missing of table

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

From 2a168e10d6db7b77190c55d994e42fc5a58fc8e5 Mon Sep 17 00:00:00 2001
From: Daniel Gomez <dagmcr@gmail.com>
Date: Mon, 22 Apr 2019 21:12:33 +0200
Subject: [PATCH] spi: AD ASoC: declare missing of table

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

After this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          of:N*T*Cadi,adau1979C*
alias:          of:N*T*Cadi,adau1979
alias:          of:N*T*Cadi,adau1978C*
alias:          of:N*T*Cadi,adau1978
alias:          of:N*T*Cadi,adau1977C*
alias:          of:N*T*Cadi,adau1977
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977-spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/adau1977-spi.c b/sound/soc/codecs/adau1977-spi.c
index 84ffbde9583f..2baf61567b59 100644
--- a/sound/soc/codecs/adau1977-spi.c
+++ b/sound/soc/codecs/adau1977-spi.c
@@ -10,6 +10,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
 
@@ -54,9 +56,18 @@ static const struct spi_device_id adau1977_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1977_spi_ids);
 
+static const struct of_device_id adau1977_spi_of_match[] = {
+        { .compatible = "adi,adau1977" },
+        { .compatible = "adi,adau1978" },
+        { .compatible = "adi,adau1979" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, adau1977_spi_of_match);
+
 static struct spi_driver adau1977_spi_driver = {
 	.driver = {
 		.name = "adau1977",
+		.of_match_table = of_match_ptr(adau1977_spi_of_match),
 	},
 	.probe = adau1977_spi_probe,
 	.id_table = adau1977_spi_ids,
-- 
2.20.1

