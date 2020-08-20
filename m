Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8222D24AE6B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 07:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgHTF2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHTF2e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 01:28:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E94C061757
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 22:28:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so484855pjd.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkqRaEwUdqUnb95WVdVlCchzd1qlKL9sLuvpdnztiiE=;
        b=HEfyNLiUb9BwML/beUT//mZWp7qHeGG07YaD02RicYRn6Bl0q7qQyZZ4/8niITC+nE
         n6OazTrtuuQpthpqGLbS+6gdm8SLsftJZqgSW0uL5xbLqeg9d+BZHWRYA2XL7D7xm9an
         V23P3cIGtpKRCKyPxZY6SBHZtZqtDs4xuZlnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkqRaEwUdqUnb95WVdVlCchzd1qlKL9sLuvpdnztiiE=;
        b=sSQw0e1l/MMWVdYdSeUUsLmHyBRdct+1IOaGy2TCrB8UwihDkMU2/5HgTgS7YbEFNn
         9b/xWRG1v5TlthZ8/k+UeBKvztP0/RWEde6u+vmLaWJ4eRdEbC2AYIdBrHqKhgZs9FZY
         xzDJ01o9mDKOpBNiQUKOF1dfHrvsN769jhBy15Dm9olRjwdEnSKuISW/+0wLogaTIvs6
         R4NsEuDAH3rCCVvXbkfVimFuvAzm7jBH/8Ucty6XjuCe/p4OPq94l0XOaQqwnVeQocIf
         nPW5pCJVbX81vjqOjmXT3IosQmkghGaMduqBA6n40t6GNumZe2JP7v6JijDanOWkDU9e
         7GWg==
X-Gm-Message-State: AOAM531eyyy4FswpHnslL1v9gIinAo15HBE1RZjuN8q0CKsHBwoAspQG
        U+mkQgpTRX3y5KfmVbv9n2U9uQ==
X-Google-Smtp-Source: ABdhPJzG23peNv1YpN3uI1M3H6MtjjsKVYg0YIfEoz+DOlg57gm3MMONcE+5PjCcUZgPUVW9OXt/ow==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr1089145pjs.163.1597901314127;
        Wed, 19 Aug 2020 22:28:34 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id j198sm1110740pfd.205.2020.08.19.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 22:28:33 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] dt-bindings: spi: Convert spi-mtk-nor to json-schema
Date:   Thu, 20 Aug 2020 13:28:27 +0800
Message-Id: <20200820052827.2642164-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert Mediatek ARM SOC's serial NOR flash controller binding
to json-schema format.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 82 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mtk-nor.txt   | 47 -----------
 2 files changed, 82 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mtk-nor.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
new file mode 100644
index 000000000000..1e4bcf691539
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-mtk-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Serial NOR flash controller for MediaTek ARM SoCs
+
+maintainers:
+  - Bayi Cheng <bayi.cheng@mediatek.com>
+  - Chuanhong Guo <gch981213@gmail.com>
+
+description: |
+  This spi controller support single, dual, or quad mode transfer for
+  SPI NOR flash. There should be only one spi slave device following
+  generic spi bindings. It's not recommended to use this controller
+  for devices other than SPI NOR flash due to limited transfer
+  capability of this controller.
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-nor
+              - mediatek,mt2712-nor
+              - mediatek,mt7622-nor
+              - mediatek,mt7623-nor
+              - mediatek,mt7629-nor
+          - enum:
+              - mediatek,mt8173-nor
+      - items:
+          - const: mediatek,mt8173-nor
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used for spi bus
+      - description: clock used for controller
+
+  clock-names:
+    items:
+      - const: "spi"
+      - const: "sf"
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      nor_flash: spi@1100d000 {
+        compatible = "mediatek,mt8173-nor";
+        reg = <0 0x1100d000 0 0xe0>;
+        interrupts = <&spi_flash_irq>;
+        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+        clock-names = "spi", "sf";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "jedec,spi-nor";
+          reg = <0>;
+        };
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
deleted file mode 100644
index 984ae7fd4f94..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Serial NOR flash controller for MediaTek ARM SoCs
-
-Required properties:
-- compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
-		  and it's the fallback compatible for other Soc.
-		  For every other SoC, should contain both the SoC-specific compatible
-		  string and "mediatek,mt8173-nor".
-		  The possible values are:
-		  "mediatek,mt2701-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
-		  "mediatek,mt8173-nor"
-- reg: 		  physical base address and length of the controller's register
-- interrupts:	  Interrupt number used by the controller.
-- clocks: 	  the phandle of the clocks needed by the nor controller
-- clock-names: 	  the names of the clocks
-		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
-		  and "sf" is used for controller, these are the clocks witch
-		  hardware needs to enabling nor flash and nor flash controller.
-		  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- #address-cells: should be <1>
-- #size-cells:	  should be <0>
-
-There should be only one spi slave device following generic spi bindings.
-It's not recommended to use this controller for devices other than SPI NOR
-flash due to limited transfer capability of this controller.
-
-Example:
-
-nor_flash: spi@1100d000 {
-	compatible = "mediatek,mt8173-nor";
-	reg = <0 0x1100d000 0 0xe0>;
-	interrupts = <&spi_flash_irq>;
-	clocks = <&pericfg CLK_PERI_SPI>,
-		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
-	clock-names = "spi", "sf";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
-};
-
-- 
2.28.0.220.ged08abb693-goog

