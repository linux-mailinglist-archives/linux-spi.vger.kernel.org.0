Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003D110FF7E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCN7t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 08:59:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLCN7t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 08:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ORw0Cl9o5Bk5k3Jl51OZt5GqsGF0YHxVY+GeEG4+wjY=; b=nbMGEFk/Fs3h
        F4zoKmON2NajONNGgaN1IatrkG3EzJsKEmewdz3GM4f6hPwF4eSvGAa26c4DokqH+eikigpJ/N5yu
        wfvFW3DzUjL04zbfCv2tiRMw9cQpK9NOT8/bpmmz5B541xH2diX/MrmZG+TVblsGqAFu5ppvOru4G
        +iPns=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic8iO-0002c1-K7; Tue, 03 Dec 2019 13:59:44 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5A95ED002FA; Tue,  3 Dec 2019 13:59:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bgolaszewski@baylibre.com, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "gpiolib: of: Make of_gpio_spi_cs_get_count static" to the spi tree
In-Reply-To: <20191130012828.14504-1-yuehaibing@huawei.com>
Message-Id: <applied-20191130012828.14504-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Date:   Tue,  3 Dec 2019 13:59:44 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   gpiolib: of: Make of_gpio_spi_cs_get_count static

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

From a1f4c96b799b80118b50bd47320deb9013b7ff40 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 30 Nov 2019 09:28:28 +0800
Subject: [PATCH] gpiolib: of: Make of_gpio_spi_cs_get_count static

Fix sparse warning:

drivers/gpio/gpiolib-of.c:35:5: warning:
 symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191130012828.14504-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4b19e7e26b90..f90a161ca97a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -32,7 +32,7 @@
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 {
 	struct device_node *np = dev->of_node;
 
-- 
2.20.1

