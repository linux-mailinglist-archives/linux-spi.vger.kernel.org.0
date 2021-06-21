Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD03AF422
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFUSGv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhFUSD6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 14:03:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F02C061D7E;
        Mon, 21 Jun 2021 10:54:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BFF4C1F42686
Received: by jupiter.universe (Postfix, from userid 1000)
        id 10A954800DC; Mon, 21 Jun 2021 19:54:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv5 3/5] dt-bindings: misc: ge-achc: Convert to DT schema format
Date:   Mon, 21 Jun 2021 19:53:57 +0200
Message-Id: <20210621175359.126729-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621175359.126729-1-sebastian.reichel@collabora.com>
References: <20210621175359.126729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the binding to DT schema format. Also update the binding
to fix shortcomings

 * Add "nxp,kinetis-k20" fallback compatible
 * add programming SPI interface and reset GPIO
 * add main clock
 * add voltage supplies
 * drop spi-max-frequency from required properties,
   driver will setup max. frequency

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/misc/ge-achc.txt      | 26 --------
 .../devicetree/bindings/misc/ge-achc.yaml     | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml

diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
deleted file mode 100644
index 77df94d7a32f..000000000000
--- a/Documentation/devicetree/bindings/misc/ge-achc.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* GE Healthcare USB Management Controller
-
-A device which handles data aquisition from compatible USB based peripherals.
-SPI is used for device management.
-
-Note: This device does not expose the peripherals as USB devices.
-
-Required properties:
-
-- compatible : Should be "ge,achc"
-
-Required SPI properties:
-
-- reg : Should be address of the device chip select within
-  the controller.
-
-- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should be
-  1MHz for the GE ACHC.
-
-Example:
-
-spidev0: spi@0 {
-	compatible = "ge,achc";
-	reg = <0>;
-	spi-max-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/misc/ge-achc.yaml b/Documentation/devicetree/bindings/misc/ge-achc.yaml
new file mode 100644
index 000000000000..ff07aa62ed57
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ge-achc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright (C) 2021 GE Inc.
+# Copyright (C) 2021 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/ge-achc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GE Healthcare USB Management Controller
+
+description: |
+  A device which handles data acquisition from compatible USB based peripherals.
+  SPI is used for device management.
+
+  Note: This device does not expose the peripherals as USB devices.
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: ge,achc
+      - const: nxp,kinetis-k20
+
+  clocks:
+    maxItems: 1
+
+  vdd-supply:
+    description: Digital power supply regulator on VDD pin
+
+  vdda-supply:
+    description: Analog power supply regulator on VDDA pin
+
+  reg:
+    items:
+      - description: Control interface
+      - description: Firmware programming interface
+
+  reset-gpios:
+    description: GPIO used for hardware reset.
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi@1 {
+            compatible = "ge,achc", "nxp,kinetis-k20";
+            reg = <1>, <0>;
+            clocks = <&achc_24M>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.30.2

