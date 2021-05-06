Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B73754D1
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhEFNg4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhEFNgz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 09:36:55 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D9C061574
        for <linux-spi@vger.kernel.org>; Thu,  6 May 2021 06:35:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f434:20f9:aa9e:b80c])
        by laurent.telenet-ops.be with bizsmtp
        id 1Rbs250020ZPnBx01RbsF0; Thu, 06 May 2021 15:35:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1leeAR-003HD6-K4; Thu, 06 May 2021 15:35:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lecYu-00GzOY-JF; Thu, 06 May 2021 13:53:00 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: spi: dw-apb-ssi: Integrate Renesas RZ/N1 SPI controller
Date:   Thu,  6 May 2021 13:52:59 +0200
Message-Id: <aef15aa119ed02487ded4691141678bc1040c3b4.1620301936.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Originally, the Renesas RZ/N1 SPI Controller DT bindings were not
integrated in the main DT bindings for the Synopsys DesignWare
Synchronous Serial Interface, but in its own file, as the RZ/N1
controller has additional registers for software CS control and DMA.

As so far DMA is not supported on RZ/N1, and json-schema can handle any
possible differences fine, integrate the RZ/N1 compatible values in the
main DT bindings for the Synopsys DW SSI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
There are no upstream users of this binding, but it validates the
following (modified) example taken from the RZ/N1 BSP[1] fine:

    spi0: spi@50005000 {
	    compatible = "renesas,r9a06g032-spi", "renesas,rzn1-spi";
	    reg = <0x50005000 0x400>;
	    interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
	    clock-names = "ssi_clk", "pclk";
	    clocks = <&sysctrl R9A06G032_CLK_SPI0>, <&sysctrl R9A06G032_HCLK_SPI0>;
	    #address-cells = <1>;
	    #size-cells = <0>;
	    spi-max-frequency = <12500000>;
	    num-cs = <4>;
    };

[1] https://github.com/renesas-rz/rzn1_linux/blob/rzn1-stable-v4.19/arch/arm/boot/dts/rzn1.dtsi
---
 .../devicetree/bindings/spi/renesas,rzn1-spi.txt      | 11 -----------
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      |  6 ++++++
 2 files changed, 6 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt b/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
deleted file mode 100644
index fb1a6728638d3e2f..0000000000000000
--- a/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Renesas RZ/N1 SPI Controller
-
-This controller is based on the Synopsys DW Synchronous Serial Interface and
-inherits all properties defined in snps,dw-apb-ssi.txt except for the
-compatible property.
-
-Required properties:
-- compatible : The device specific string followed by the generic RZ/N1 string.
-   Therefore it must be one of:
-   "renesas,r9a06g032-spi", "renesas,rzn1-spi"
-   "renesas,r9a06g033-spi", "renesas,rzn1-spi"
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 4825157cd92e8262..ca91201a99269750 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -67,6 +67,12 @@ properties:
         const: baikal,bt1-sys-ssi
       - description: Canaan Kendryte K210 SoS SPI Controller
         const: canaan,k210-spi
+      - description: Renesas RZ/N1 SPI Controller
+        items:
+          - enum:
+              - renesas,r9a06g032-spi # RZ/N1D
+              - renesas,r9a06g033-spi # RZ/N1S
+          - const: renesas,rzn1-spi   # RZ/N1
 
   reg:
     minItems: 1
-- 
2.25.1

