Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528581A79BF
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgDNLkP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 07:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439437AbgDNLkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 07:40:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF832076B;
        Tue, 14 Apr 2020 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586864411;
        bh=debxG6bzDjQdxVdojohF7AMnypZ9G0PLFfnJmNnNq9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P7GiCHi8dZN63BaV9Rbh4ZE6dwEtsaWch+t43qdLhoVG3VCAcAxz2p44QsEIQmX3o
         fZi152dqHCwKmDwhaq47wtn5mvomJp/bV/J5IJsG5drlplDOEYEU+bvlpi2vWP/J1+
         NZRTWPK2OS/WnIkyTRtI1ha+slYPjnUpVacfDxN0=
Date:   Tue, 14 Apr 2020 12:40:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     broonie@kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sc18is602: Fix a typo in MODULE_DESCRIPTION" to the spi tree
In-Reply-To:  <20200413154043.23064-1-christophe.jaillet@wanadoo.fr>
Message-Id:  <applied-20200413154043.23064-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sc18is602: Fix a typo in MODULE_DESCRIPTION

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 6d75145bf6b6558dea5ce3b4f83f3f66444bcac0 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 13 Apr 2020 17:40:43 +0200
Subject: [PATCH] spi: sc18is602: Fix a typo in MODULE_DESCRIPTION

This should be 'SC18IS602', not 'SC18IC602'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20200413154043.23064-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 5497eeb3bf3e..ee0f3edf49cd 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -345,6 +345,6 @@ static struct i2c_driver sc18is602_driver = {
 
 module_i2c_driver(sc18is602_driver);
 
-MODULE_DESCRIPTION("SC18IC602/603 SPI Master Driver");
+MODULE_DESCRIPTION("SC18IS602/603 SPI Master Driver");
 MODULE_AUTHOR("Guenter Roeck");
 MODULE_LICENSE("GPL");
-- 
2.20.1

