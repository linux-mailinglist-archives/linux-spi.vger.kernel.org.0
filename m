Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9326322C429
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXLOq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:46 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45300 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLOq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589285; x=1627125285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBzRkBtozG5b3/15vheeXwwh85YdJj3g7EowRXnUGZc=;
  b=IIjGwtB4USZ1pwrMcCi5aOT3Wri+E7HQyr2DFNeMoouAqE4Grrq9ZaHL
   q0e03TDb839k0jVSQQMsIoA2/E9aCIvTN1nIUnd7Zv8tc/XPG/FgOWUUD
   sGB6JbRuNn87B4v3QURWdmwk1C8sTS2+6cqZMs4O2pn8P+3k5YO+igtWF
   JVvkijhruL/uAm2DN7acroJyHrJcWg2lDR5lv6GLhWY9IRvTgEA23EuLv
   dXEerb7MYJiZsVQ+UGr0VJaavv5Z5dTrDs8uUXTS7nOYnC771oamg3DBj
   gIsjbtqCiIl+NYjXE6a+4EXtNG6zG5KFPS78Jde3VVHh7bTyNwuexyMB2
   A==;
IronPort-SDR: /rBGc9Tr0FIte778itXE+wvm354k0raUzpaI+9rkTaX4tPBrFoEX3QlDLQYz5xZFLR3l9RK8YG
 YHCKLBiVLho3zzDrAf6YSdOAume/6/Hr64AXCgsPZtCVawqRjw1Y1oTdgJKBSHejiZSklpfqSQ
 OIXkfXUOdd/nLVm5kMFtcPqCU1sHtG9m09MUChciTi2+Of+DkoO4+en6F55b2h5lL88DXAbFc6
 qFg9AzEgLuyNKpV+ganbTwc65Y+pp1fxNzpMLZqFCuLiS6ieHHVVLetpLtVv1bJRdRQ2qRmIJ3
 Y00=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="81158468"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:14:02 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:14:02 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property
Date:   Fri, 24 Jul 2020 13:14:02 +0200
Message-ID: <20200724111404.13293-5-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724111404.13293-1-lars.povlsen@microchip.com>
References: <20200724111404.13293-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This has the following changes for the snps,dw-apb-ss DT bindings:

- Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
  controller

- Add the property "rx-sample-delay-ns"

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index c62cbe79f00dd..c0adaad1aa695 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -36,6 +36,8 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
           - const: snps,dw-apb-ssi
+      - description: Microchip Sparx5 SoC SPI Controller
+        const: microchip,sparx5-spi
       - description: Amazon Alpine SPI Controller
         const: amazon,alpine-dw-apb-ssi
       - description: Renesas RZ/N1 SPI Controller
@@ -93,6 +95,12 @@ properties:
       - const: tx
       - const: rx
 
+  rx-sample-delay-ns:
+    description: Default value of the rx-sample-delay-ns property.
+      This value will be used if the property is not explicitly defined
+      for a SPI slave device. Default value is 0. See below.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
@@ -107,6 +115,13 @@ patternProperties:
       spi-tx-bus-width:
         const: 1
 
+      rx-sample-delay-ns:
+        description: SPI Rx sample delay offset, unit is nanoseconds.
+          The delay from the default sample time before the actual
+          sample of the rxd input signal occurs. The "rx_sample_delay"
+          is an optional feature of the designware controller, and the
+          upper limit is also subject to controller configuration.
+
 unevaluatedProperties: false
 
 required:
@@ -129,5 +144,11 @@ examples:
       num-cs = <2>;
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
+      rx-sample-delay-ns = <3>;
+      spi-flash@1 {
+        compatible = "spi-nand";
+        reg = <1>;
+        rx-sample-delay-ns = <7>;
+      };
     };
 ...
-- 
2.27.0

