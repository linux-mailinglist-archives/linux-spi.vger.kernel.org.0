Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6D15B58B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 00:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBLX6d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 18:58:33 -0500
Received: from foss.arm.com ([217.140.110.172]:39856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgBLX6c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 18:58:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F9FA101E;
        Wed, 12 Feb 2020 15:58:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885CC3F68E;
        Wed, 12 Feb 2020 15:58:31 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:58:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "dt-bindings: spi: Document binding for generic SPI multiplexer" to the spi tree
In-Reply-To: <20200204032838.20739-2-chris.packham@alliedtelesis.co.nz>
Message-Id: <applied-20200204032838.20739-2-chris.packham@alliedtelesis.co.nz>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: spi: Document binding for generic SPI multiplexer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From d548ed71cb8862c96a1a8d17861bb5dabd1e2299 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Tue, 4 Feb 2020 16:28:37 +1300
Subject: [PATCH] dt-bindings: spi: Document binding for generic SPI
 multiplexer

Add binding documentation for the spi-mux driver. This allows a generic
multiplexer to be used to provide access to multiple SPI devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200204032838.20739-2-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-mux.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
new file mode 100644
index 000000000000..0ae692dc28b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SPI Multiplexer
+
+description: |
+  This binding describes a SPI bus multiplexer to route the SPI chip select
+  signals. This can be used when you need more devices than the SPI controller
+  has chip selects available. An example setup is shown in ASCII art; the actual
+  setting of the multiplexer to a channel needs to be done by a specific SPI mux
+  driver.
+
+        MOSI /--------------------------------+--------+--------+--------\
+        MISO |/------------------------------+|-------+|-------+|-------\|
+         SCL ||/----------------------------+||------+||------+||------\||
+             |||                            |||      |||      |||      |||
+      +------------+                        |||      |||      |||      |||
+      | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
+      |      |||   |                      | dev |  | dev |  | dev |  | dev |
+      |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
+      |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
+      |   +------+ |       +--+---+\\\-------/   CS-1 |        |        |
+      |            |          |    \\\----------------/   CS-2 |        |
+      |   +------+ |          |     \\-------------------------/   CS-3 |
+      |   | ?    +-|----------/      \----------------------------------/
+      |   +------+ |
+      +------------+
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: spi-mux
+
+  mux-controls:
+    maxItems: 1
+
+required:
+   - compatible
+   - reg
+   - spi-max-frequency
+   - mux-controls
+
+examples:
+   - |
+     #include <dt-bindings/gpio/gpio.h>
+     mux: mux-controller {
+       compatible = "gpio-mux";
+       #mux-control-cells = <0>;
+
+       mux-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+     };
+
+     spi {
+       #address-cells = <1>;
+       #size-cells = <0>;
+       spi@0 {
+         compatible = "spi-mux";
+         reg = <0>;
+         #address-cells = <1>;
+         #size-cells = <0>;
+         spi-max-frequency = <100000000>;
+
+         mux-controls = <&mux>;
+
+         spi-flash@0 {
+           compatible = "jedec,spi-nor";
+           reg = <0>;
+           #address-cells = <1>;
+           #size-cells = <0>;
+           spi-max-frequency = <40000000>;
+         };
+
+         spi-device@1 {
+           compatible = "lineartechnology,ltc2488";
+           reg = <1>;
+           #address-cells = <1>;
+           #size-cells = <0>;
+           spi-max-frequency = <10000000>;
+         };
+       };
+     };
-- 
2.20.1

