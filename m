Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC9649BC
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGJPfL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 11:35:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfGJPe4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jul 2019 11:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7QYvFls9cFFESC1iCFjHNVMcABi/vx5KKko2y+ogruc=; b=DCTWJJmqSBmc
        Cg/2D57XqG2bNMWH+/z9If72M7H90alUmHKY3e9c6j1/+lRKN4s6EColac2SYyUKff/GYuQNU2VNa
        K/a5wqetVmYCREYGAqrxPv2DOK2JWZWcXqx+po0mBGD7H+p0vw/ZBCgci4yiOCi0PEnJ+ieTi+ZlB
        8DybQ=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcQ-00083v-8X; Wed, 10 Jul 2019 15:34:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id F057BD02D84; Wed, 10 Jul 2019 16:34:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Applied "spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg" to the spi tree
In-Reply-To: <20190709192631.16394-1-robh@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190710153453.F057BD02D84@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg

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

From 43167bb1f6bb7efa73adc40d2dd700bb6546cc2c Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2019 13:26:31 -0600
Subject: [PATCH] spi: dt-bindings: spi-controller: remove unnecessary
 'maxItems: 1' from reg

Mixing array constraints like 'maxItems' and string or integer value
constraints like 'minimum' don't make sense. Also, with only value
constraints, it is implied we have a single value. So lets remove
'maxItems: 1'.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20190709192631.16394-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 876c0623f322..a02e2fe2bfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -73,7 +73,6 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        maxItems: 1
         minimum: 0
         maximum: 256
         description:
-- 
2.20.1

