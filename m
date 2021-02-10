Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C531636A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 11:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBJKNv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Feb 2021 05:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBJKLM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Feb 2021 05:11:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E4C06178A
        for <linux-spi@vger.kernel.org>; Wed, 10 Feb 2021 02:10:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g10so2259104eds.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Feb 2021 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZiMzhLdfVQZkFKa2UC3/BywnaDXeDau8xmJtr8dU38=;
        b=DNbGyFxx3kCS9/j20Y9P0rU42KGYEhzoemRvo9Xx5kJTEHtH6dOpjcAMB2ApFDSSZ6
         w+KePPGz15wBLKrgmQBv/viHii4cJ+ZfOBVKKMR02WAC48aYjp7NcjbGIKfP7NQ8LPk0
         SSb4J4KKneDpKCbvsFqZASyTdtAFDyf5jcdwI7oSx/rA8dWPbG3dckmKRjY7Q6e9557K
         /SheqyDEz6J+MxjG0oAaodZtA/Dn3uKhw6UCdJdaSLL+xC8lCnhs86plQIWDtdLE4Wez
         Q5OanvDfJPW2jYJ83gBUDaaBcTvRloH4HjwfJwmAsFuRawX8ZMXEbcZRHgW7fXa9s0P+
         osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IZiMzhLdfVQZkFKa2UC3/BywnaDXeDau8xmJtr8dU38=;
        b=ceEl4dvLWSEICSIMqKL69FTi4zq9ImeODG+xFegIIt6HS8F3NbiIG/DrCudvOk1fui
         N/g9WiJAQodetIwaMUfFCqlmZ5kgMNmYfIooRDLnKupk+MkdpYUT9UDg+9IuXBLKUfsW
         6LYCJihbjVsqhRj5SIBkIurnCgmwIphL2u3FAQTYB/wGzUUvhmafGCV7RfNvDOFKQEpm
         A4Kb6aSJQhWnfeWJFn3xp8PXx/ATiwCZjamqokrqmiKWb50yL6LZ8BFUyzncBKLwber8
         Eu0jqn7hZPibq6RvBTu9oQSI5+iBD/lZ8X3bubiBpSgQ/BMWtsEb1JzsA0acCi55Ec0I
         c1AA==
X-Gm-Message-State: AOAM533tuX4/7MJoIG+Dvs30L85kozzQYzsFMabtrhV5I4wQyRNjEp41
        jFd3+lbWRMQQqArjpmCIXwkaDQ==
X-Google-Smtp-Source: ABdhPJw3ICAK3+bqwsi4GntjzrrX6z/adbvvxabg48+ANL9VVY9BCW0wN267ea/MDJrlA67o/2HPQw==
X-Received: by 2002:aa7:d790:: with SMTP id s16mr2447249edq.294.1612951830768;
        Wed, 10 Feb 2021 02:10:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x25sm789313ejc.33.2021.02.10.02.10.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Feb 2021 02:10:30 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml
Date:   Wed, 10 Feb 2021 11:10:25 +0100
Message-Id: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert spi-zynq-qspi.txt to yaml.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- s/additionalProperties: true/unevaluatedProperties: false/

 .../devicetree/bindings/spi/spi-zynq-qspi.txt | 25 --------
 .../bindings/spi/xlnx,zynq-qspi.yaml          | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 60 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
deleted file mode 100644
index 16b734ad3102..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Xilinx Zynq QSPI controller Device Tree Bindings
--------------------------------------------------------------------
-
-Required properties:
-- compatible		: Should be "xlnx,zynq-qspi-1.0".
-- reg			: Physical base address and size of QSPI registers map.
-- interrupts		: Property with a value describing the interrupt
-			  number.
-- clock-names		: List of input clock names - "ref_clk", "pclk"
-			  (See clock bindings for details).
-- clocks		: Clock phandles (see clock bindings for details).
-
-Optional properties:
-- num-cs		: Number of chip selects used.
-
-Example:
-	qspi: spi@e000d000 {
-		compatible = "xlnx,zynq-qspi-1.0";
-		reg = <0xe000d000 0x1000>;
-		interrupt-parent = <&intc>;
-		interrupts = <0 19 4>;
-		clock-names = "ref_clk", "pclk";
-		clocks = <&clkc 10>, <&clkc 43>;
-		num-cs = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
new file mode 100644
index 000000000000..1f1c40a9f320
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/xlnx,zynq-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq QSPI controller
+
+description:
+  The Xilinx Zynq QSPI controller is used to access multi-bit serial flash
+  memory devices.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    const: xlnx,zynq-qspi-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: reference clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@e000d000 {
+        compatible = "xlnx,zynq-qspi-1.0";
+        reg = <0xe000d000 0x1000>;
+        interrupt-parent = <&intc>;
+        interrupts = <0 19 4>;
+        clock-names = "ref_clk", "pclk";
+        clocks = <&clkc 10>, <&clkc 43>;
+        num-cs = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..e494b061dcd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2766,6 +2766,7 @@ W:	http://wiki.xilinx.com
 T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/block/xsysace.c
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.30.0

