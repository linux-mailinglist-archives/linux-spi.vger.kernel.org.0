Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956392120CF
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgGBKPc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:15:32 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55417 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGBKOg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684876; x=1625220876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fRQlCAqtmjl9D0MMfywPaDVRoYsm/XyLPUVVnHATv4=;
  b=07oSXWMfJVz5YAmuPvMhJu/ikGI5+4Yy0IGG3IfrBhHXZp2FJZNpVrS4
   s08Pvp6jhfVO1c6D/Qfn5p/HKR/UdCDV3TUR6AW62wDUd5WikBQzvvF3e
   TaEF+1TV5MqswAilbyGkteBGLeBtt4Kj/2Rg+xxbY8ET/ij7h2qZ570p9
   oTUTkKfRuB++1xUgVraiMiiofNhOdF6SzYpjhj9NfkiQ9F+1DTatbD69w
   uLL5jyPhKTIc3Y4o+8F8L23pukAJJbEvGWIvhXjn/08z7G6A1b/x2JyKV
   uW4mWOGFKTkYX1bEAiAC8sVImx2OPntl0vMHf1Y1ia6SHawGIAbT1y7n5
   Q==;
IronPort-SDR: AUxi5ygMh+VCaZXTiASENeY2b8P0ktt6TBi8nn6qn9d9o2aJ+xiJjfefObwTKQdIOvzTPXBR9F
 6El1DDNxl7IlteS63iPLLI+rJgbpSPN55yA/3yNwTpu1z2Nsb1h88+tzc4W3Yv+QqCMM3IpbzJ
 fWyt4EoGlyeuFToyLW4mrWVUFYyGwFsEzQp0pNSfXUHC/CQRrSpb/EgohZuIGIdjDOn1Dh4e1/
 UAUcVTot791wVC8mv0BCJy9++pZpWSyQOmEVCj+O9uNS7hxvP46siAzz4yRpvcKwbccNlsV5Lg
 sNs=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="85979770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:35 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:14:12 -0700
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
Subject: [PATCH v3 5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus snps,rx-sample-delay-ns property
Date:   Thu, 2 Jul 2020 12:13:28 +0200
Message-ID: <20200702101331.26375-6-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
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

- Add the property "mux-controls" for the above compatible string

- Add the property "snps,rx-sample-delay-ns" for SPI slaves

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index c62cbe79f00dd..9d9208391fae3 100644
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
@@ -93,6 +95,19 @@ properties:
       - const: tx
       - const: rx

+if:
+  properties:
+    compatible:
+      contains:
+        const: microchip,sparx5-spi
+
+then:
+  properties:
+    mux-controls:
+      description: A mux controller node for selecting SPI bus interface.
+      maxItems: 1
+      $ref: '/schemas/types.yaml#/definitions/phandle'
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
@@ -107,6 +122,14 @@ patternProperties:
       spi-tx-bus-width:
         const: 1

+      snps,rx-sample-delay-ns:
+        description: SPI Rx sample delay offset, unit is nanoseconds.
+          The delay from the default sample time before the actual
+          sample of the rxd input signal occurs. The "rx_sample_delay"
+          is an optional feature of the designware controller, and the
+          upper limit is also subject to controller configuration.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
 unevaluatedProperties: false

 required:
@@ -129,5 +152,10 @@ examples:
       num-cs = <2>;
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
+      spi-flash@1 {
+        compatible = "spi-nand";
+        reg = <1>;
+        snps,rx-sample-delay-ns = <7>;
+      };
     };
 ...
--
2.27.0
