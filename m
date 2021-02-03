Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03E30DBB1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Feb 2021 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhBCNrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Feb 2021 08:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhBCNrc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Feb 2021 08:47:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5DC0613ED
        for <linux-spi@vger.kernel.org>; Wed,  3 Feb 2021 05:46:47 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i9so5296421wmq.1
        for <linux-spi@vger.kernel.org>; Wed, 03 Feb 2021 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmTxJHAG7BsEX/Yjqdov/BgOcZ1IzcMMUHM38mX2sec=;
        b=qB0oDq1RTsfWgvowujAcezLYRLxOtpcsrCVoX3XJi8oCmR/CberX0JRL59qfNpVuDV
         aQSkX6rpmB98Hy1XqGiANoIn+BG9XfOu5Px7ajIEu1kUNhVdrcKLL6Kg18g8S6ZArOwc
         r7pSkfSkuFN6LCuD9rTgxuz6JNeQenXMZk+WIAapYlGyh52pllzEx7jbOp6X9XEPbMew
         /YXD9LUQtHP0jZseBMh2BbOuDXLReHO8+2wTAm1GD/PNPTmF70Y1xYiVALnzy9csnyNS
         tvKgeMHHLO1G86DVj6oaJcBkFLmqRTA4yPahKOj3mqSJVWqJyyv3ciUkRpcO7rMRApdC
         fl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mmTxJHAG7BsEX/Yjqdov/BgOcZ1IzcMMUHM38mX2sec=;
        b=FBUZY7+KNVuggacUamAc8iXmbvX8MU1HJhrv8R88qG/ON080JaAcOtmtCo6I2tyTIJ
         J4ILt1Iug3dqSv1af/0Zx1sDujEXbwqDNtFxbAwgqs4Eo4/lzAKeIPSiApQmPEXhgo+d
         E45PCtRvQoiqu3WwoCY1/hTgPIerwSR8bhKaLmFi/30VihfFU4cXB4KkLrPin+wd9uMU
         SEXDDq6ZE4mTRZSjbuLJITrQCswgZxxnyWiu538EPuhBG+ttFziHPjaPq82XNJMG1yRl
         RkyVWz5+wV43F5WhlzHH4A/WdPbil9GNjwUIGNiaoaNfGUB/9iyd3IrH+5pkLbPEuoAa
         UwwA==
X-Gm-Message-State: AOAM530nyvorLIbabIgiiXuo2YQe3Yi9MLLOP68FuXurocgoqHMyRhW5
        C8jQIl9LybGwLZk3ODcLAS5wmg==
X-Google-Smtp-Source: ABdhPJx3KQn2TI1gBNF9KqD1+7cVwPChsoEAyCpczLY2Qqbxi76gjEbrSX8g4yz+pmbo9toW6rB51g==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr2911595wmb.180.1612360006519;
        Wed, 03 Feb 2021 05:46:46 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f7sm3513534wre.78.2021.02.03.05.46.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Feb 2021 05:46:45 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml
Date:   Wed,  3 Feb 2021 14:46:44 +0100
Message-Id: <22ca0a9a15ccdf4b520baacc5ed837f6d3a3f781.1612360002.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert spi-zynq-qspi.txt to yaml.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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
index 000000000000..03269a7433b3
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
+additionalProperties: true
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

