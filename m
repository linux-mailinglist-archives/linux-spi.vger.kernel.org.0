Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05D73C5EB7
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhGLPFg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 11:05:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhGLPFg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 11:05:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E8A11F425C8
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4300A4800C7; Mon, 12 Jul 2021 17:02:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv6 1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
Date:   Mon, 12 Jul 2021 17:02:40 +0200
Message-Id: <20210712150242.146545-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712150242.146545-1-sebastian.reichel@collabora.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
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

