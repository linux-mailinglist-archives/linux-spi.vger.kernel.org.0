Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB62007D4
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgFSLbx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:31:53 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55736 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgFSLbo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566304; x=1624102304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19MOvcR0nsnDT3YcIrCLwDvMaCViNOXGoQ4rVMNBvY4=;
  b=kkoPteQsHXiH1ra+E/09PgpxmI1J7u8qlofZlFomtx03hulqH2BAyKO8
   7wZ/VxJq+tcGkq4uk2b1h7RzViBtcAplHAoMNwXKYLJV3J44j/gVZNKF9
   b6uXGGuh+dsxAqvr/FZVT4USNtSbueF4xDj6ji2HBC1XlJElXUDwSsBhj
   XQc3lxRgGWshrV7/ME0F7LMuinuEGH2IX7MK1xtcQPoxTyZnYRO0IXJAU
   d0Y1jJl0+uTl/lcZEQkKHq8+uDMm4w/ufBMj2NoAFcHFL3UOyTXYNWQGs
   JDrOrYtzmygATuzjU88WQlfS4HigEoX8GLDSAamSl53Xr3q9FM/55LLRW
   g==;
IronPort-SDR: 4/WxqRybhw55PExWHGU3OtD0Qo5/Em9m9d04aQhoExdrQpP6eUWA5wEoCVpw/t8voZLxwrZJMF
 R1MQAKHfHNC9x6w77HA5QieZl160Qu3Fhq2EZKgmcErKBfv3/rnCDVlXAqA+KhAVd0MYjrKoEI
 paAfOTjbbTszwLBGUky9JGq18C7OTQQ1sThBdLCWMSQBqXP+yFSKcpdYLz5+x+l2QSpb9Mc5Sx
 LtYx7OSwJVLAS1VRPnrZOhh8Rt9BWlVoIIUBehTN8FaWxm/dzzDXNpc+MkvEzTxpPqobsYKQNM
 2jw=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="77162027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:35 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:33 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5, SPI slave snps,rx-sample-delay-ns and microchip,spi-interface2 properties.
Date:   Fri, 19 Jun 2020 13:31:19 +0200
Message-ID: <20200619113121.9984-5-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619113121.9984-1-lars.povlsen@microchip.com>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This has the following changes for the snps,dw-apb-ss DT bindings:

- Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
controller,

- Add the property "snps,rx-sample-delay-ns" for SPI slaves

- Add the property "microchip,spi-interface2" for SPI slaves

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index c62cbe79f00dd..5bca4f0493bdf 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -36,6 +36,11 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
           - const: snps,dw-apb-ssi
+      - description: Microchip Sparx5 SoC SPI Controller
+        items:
+          - enum:
+              - microchip,sparx5-spi
+          - const: snps,dw-apb-ssi
       - description: Amazon Alpine SPI Controller
         const: amazon,alpine-dw-apb-ssi
       - description: Renesas RZ/N1 SPI Controller
@@ -107,6 +112,19 @@ patternProperties:
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
+      microchip,spi-interface2:
+        description: indicates the spi device is placed on a special
+          controller interface of the "microchip,sparx5-spi" controller.
+        type: boolean
+
 unevaluatedProperties: false

 required:
@@ -129,5 +147,11 @@ examples:
       num-cs = <2>;
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
+        spi-flash@1 {
+          compatible = "spi-nand";
+          reg = <1>;
+          microchip,spi-interface2;
+          snps,rx-sample-delay-ns = <7>;
+        };
     };
 ...
--
2.27.0
