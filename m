Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E25184D34
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMRGt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 13:06:49 -0400
Received: from foss.arm.com ([217.140.110.172]:33294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMRGt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Mar 2020 13:06:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CF5B31B;
        Fri, 13 Mar 2020 10:06:49 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B3F3F534;
        Fri, 13 Mar 2020 10:06:48 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:06:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Applied "spi: dt-bindings: spi-controller: Fix #address-cells for slave mode" to the spi tree
In-Reply-To:  <20200306085038.8111-2-geert+renesas@glider.be>
Message-Id:  <applied-20200306085038.8111-2-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dt-bindings: spi-controller: Fix #address-cells for slave mode

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

From a079ff858cc0831f5bbad205016bfd88bf992bb1 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 6 Mar 2020 09:50:37 +0100
Subject: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode

Currently, the DT bindings for an SPI controller specify that
"#address-cells" must be fixed to one.  However, that applies to an SPI
controller in master mode only.  When running in SPI slave mode,
"#address-cells" should not be specified.

Fix this making "#address-cells" mutually-exclusive with "spi-slave".

Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200306085038.8111-2-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64b..0ebaf6677ac4 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -52,6 +52,12 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
+oneOf:
+  - required:
+      - "#address-cells"
+  - required:
+      - spi-slave
+
 patternProperties:
   "^slave$":
     type: object
-- 
2.20.1

