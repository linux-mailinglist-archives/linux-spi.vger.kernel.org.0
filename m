Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EAF3A5AAD
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jun 2021 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhFMVp3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Jun 2021 17:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhFMVp3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Jun 2021 17:45:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCEC061574
        for <linux-spi@vger.kernel.org>; Sun, 13 Jun 2021 14:43:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w31so4589229pga.6
        for <linux-spi@vger.kernel.org>; Sun, 13 Jun 2021 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4FYr9FDMOpvwo3Zr3hfKXs3t7amppDGZQ7mivsffqA=;
        b=TH0/0eKS4H6Ui936WKWhp7XjjY1XT2YWMJ80xz8p3SQWgtVyHwKkcOZRlAAiAvP4NV
         nAz5sNz03gsSLLX7yFtqyXqZtQ/XGEu9167mSpjbj82O40LQWepesux0yk4up+cOsAa+
         mLen7TPkfzbPmy83wwYg29MRCah5Y8k0lbPBlEAp+9dnmcE9/1YM0IxLYbXHuRpZMP5Q
         WuVvNQDGt/5fNlYHTI236iDTFW2jD+jXFpJoe3pV4GnQPPshffPaxHzJT3YY2+lMr9tI
         F5rLAVw0e40gX+C3CZ4ZAUbWwdmiimrXLI6ZoAERiCcC2y9dMWyCZBAQBY3JkIXV8RnZ
         xlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4FYr9FDMOpvwo3Zr3hfKXs3t7amppDGZQ7mivsffqA=;
        b=Bkyjm7usI62MIzfu+yQ29nYhNCGVvCxljscnFHzsWWI22XQyu+Y/EkX+dmN4Lbu8QS
         GLrfZi0NgVYlArpkOOj8nYfVL1pNj6NKRc/PzCN1Cgy3G8GDIn4707HMiqVwT7fElsjq
         WfH4NBrvcrNA6f5MXU+JmhRTrED4IbuL43MMQ1uerSIuWiH/zpBqbmifjsX0PkeTv8tK
         naQoqLvLq/SegtlytcTwuEPrf3o7tXkrdf8Ybm94mZFvoVxkZiiCTdQlEuNBf+/yIodI
         WIP9seoxETQPpCJPoIUsaNkVKLx6oFFRnSU1tQKs6T/hJRi2vM8ea6Q0GiMElgK6MTaw
         Hk7g==
X-Gm-Message-State: AOAM533gj3OXgwJPuvz42eREOg6iwcruGzPDT3uyGIYXPCbZPoOjRsRD
        Gx5BlpBF0JK6x+/zqDPGZHTv
X-Google-Smtp-Source: ABdhPJzPRCfWhO+6To0aOkO3oRK33VeKw3NdpVVaElBJxQWRhZ11AI2176yVIa3vwrqMB1jbpu/fSg==
X-Received: by 2002:a63:d455:: with SMTP id i21mr14200610pgj.263.1623620606663;
        Sun, 13 Jun 2021 14:43:26 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id u1sm10730938pfu.160.2021.06.13.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 14:43:26 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh+dt@kernel.org, broonie@kernel.org, michal.simek@xilinx.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML
Date:   Mon, 14 Jun 2021 06:43:17 +0900
Message-Id: <20210613214317.296667-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert spi for Xilinx Zynq UltraScale+ MPSoC GQSPI bindings
documentation to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../bindings/spi/spi-zynqmp-qspi.txt          | 25 ---------
 .../bindings/spi/spi-zynqmp-qspi.yaml         | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
deleted file mode 100644
index 0f6d37ff541c4b..00000000000000
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
--------------------------------------------------------------------
-
-Required properties:
-- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
-- reg			: Physical base address and size of GQSPI registers map.
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
-	qspi: spi@ff0f0000 {
-		compatible = "xlnx,zynqmp-qspi-1.0";
-		clock-names = "ref_clk", "pclk";
-		clocks = <&misc_clk &misc_clk>;
-		interrupts = <0 15 4>;
-		interrupt-parent = <&gic>;
-		num-cs = <1>;
-		reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
new file mode 100644
index 00000000000000..ea72c8001256fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-zynqmp-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-qspi-1.0
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: pclk
+
+  clocks:
+    maxItems: 2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      qspi: spi@ff0f0000 {
+        compatible = "xlnx,zynqmp-qspi-1.0";
+        clocks = <&zynqmp_clk QSPI_REF>, <&zynqmp_clk LPD_LSBUS>;
+        clock-names = "ref_clk", "pclk";
+        interrupts = <0 15 4>;
+        interrupt-parent = <&gic>;
+        reg = <0x0 0xff0f0000 0x0 0x1000>,
+              <0x0 0xc0000000 0x0 0x8000000>;
+      };
+    };
-- 
2.32.0

