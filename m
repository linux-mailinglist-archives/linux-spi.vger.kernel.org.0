Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110671D16C6
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgEMOA6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:58 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48473 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388790AbgEMOA5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378457; x=1620914457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaO/GETf8z+ABiKcnmBIXRkSMrzTv7Y0Bt8RBuG3pBE=;
  b=1i6RQ+TKaI71/CH22THmpfAWlWwIw0sG9Z9+D8KQewdSvrsfLPjDVo6A
   pM2Ucq/uq5NjvC3XK07FzPfqGNJ95PHzFH5/VsyZIT9d7FYTXUcqFKTsN
   EYydxQXXugDvwOjziAnrU1Ar4dm6Uf9B++PBSYesGIVsM+bXJOBdqInXW
   YUIRtp0TzuVnpCD8MlercT7GBL6RZrzEMNBdeMIVA5IxBJhdOBWBLR9x0
   MIvtIvWY8zCxfTtfcRxOi9Kpk43Dfe7Ppr51lqIGpKPc6rYJSX3wStqqg
   0umVAG4zGM0bviyraaVv1yrOeZtcO56YnfVoEJ8ZvehOWayiyogZ8MVO4
   A==;
IronPort-SDR: sw7/+Xl09HJPBB3WW6IIefnitHCp5+tjOGx6sM6RkNeZoJSIntXCAfjjBR62S4wTzy6ugH94Gg
 bfgIDneKlZZhULpZV3vmc4uAzmk310dee5pWvaJ0wmNA6tEYz9Cy2jfKp3DPu4R22gArmCam4S
 JxdSCru1oe/jNhAqTXe/yaRS63Q1182oBqfQ6iZ8/kMFOb/rz2mfUPrpDW5Hr8BH+Nr4rpmqjZ
 egSu78qhKxdJ8RcWuLdUKFe52moXN0aTf6iho2dHUa0H8Bodhir/lju4/83rwVwDsM5r/LVatJ
 PCA=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="79447556"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:57 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:52 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/10] dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
Date:   Wed, 13 May 2020 16:00:27 +0200
Message-ID: <20200513140031.25633-7-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This add DT bindings for the Sparx5 SPI driver.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/mscc,ocelot-spi.yaml         | 49 +++++++++++++++----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
index a3ac0fa576553..8beecde4b0880 100644
--- a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
@@ -23,15 +23,23 @@ properties:
     enum:
       - mscc,ocelot-spi
       - mscc,jaguar2-spi
+      - microchip,sparx5-spi

   interrupts:
     maxItems: 1

   reg:
     minItems: 2
-    items:
-      - description: Designware SPI registers
-      - description: CS override registers
+    maxItems: 3
+    oneOf:
+      - items:
+          - description: Designware SPI registers
+          - description: CS override registers (Not sparx5).
+      - items:
+          - description: Designware SPI registers
+          - description: CS override registers (Not sparx5).
+          - description: Direct mapped SPI read area. If provided, the
+              driver will register spi_mem_op's to take advantage of it.

   clocks:
     maxItems: 1
@@ -43,6 +51,23 @@ properties:
        enum: [ 2, 4 ]
     maxItems: 1

+  spi-rx-delay-us:
+    description: |
+      The delay (in usec) of the RX signal sample position. This can
+      be used to tne the RX timing in order to acheive higher
+      speeds. This is used for all devices on the bus.
+    default: 0
+    maxItems: 1
+
+  interface-mapping-mask:
+    description: |
+      On the Sparx5 variant, two different busses are connected to the
+      controller. This property is a mask per chip-select, indicating
+      whether the CS should go to one or the other interface.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -50,11 +75,15 @@ required:

 examples:
   - |
-    spi0: spi@101000 {
-      compatible = "mscc,ocelot-spi";
-      #address-cells = <1>;
-      #size-cells = <0>;
-      reg = <0x101000 0x100>, <0x3c 0x18>;
-      interrupts = <9>;
-      clocks = <&ahb_clk>;
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi0: spi@600104000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "microchip,sparx5-spi";
+        reg = <0x00104000 0x40>, <0 0>, <0x3000000 0x4000000>;
+        num-cs = <16>;
+        reg-io-width = <4>;
+        reg-shift = <2>;
+        clocks = <&ahb_clk>;
+        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
     };
--
2.26.2
