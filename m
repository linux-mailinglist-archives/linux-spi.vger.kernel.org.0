Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0F2120CC
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgGBKOy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:14:54 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55429 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgGBKOl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684881; x=1625220881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8ti72N/kPmTe//KJjZaDbS1jxKg9TXG3r5s9TRcE6E=;
  b=eibkzKtQYY/B3FBSX4vWv0yieY1wikVNhjjUQ503v9cfL0LxZ4nX+zKh
   mMoC22O+eqp+i+JecvFcPdBxF8nmUEBxNqKDmnJkCPzMQ0SPicdIRyWdq
   RO6C2+mM7tlTwQhxmjQjN1WXzheQ6g0biEfqPS07RuezNChy0AGTv9mk3
   BptWyFhXcb3HDJIKXPoko1VKk7iHYsZS4VSRdYfsyvte7CJB9Xb3MmbJV
   3Fv63I5guiQTmVzyjFW91GjtSornzkZx3/pQvs4gM6OGveZM9zmbRGjdh
   yAD0BF9CVY7Rk7ce6qkyeR6P03/BESC/kbMecFAAUNkN1TPbrkDRvs/iQ
   w==;
IronPort-SDR: FCIeI9nI6414nJ7ksSRxJS2d4awbwnDfmW5mcNChBuvks4bbmqF2IsOPpo6eXjXRwdRRxjSmaR
 KAoH4M0zfg3ll5n7w3zPaD7UkhezRadn/zdwKLcZrkUF9WPBU7R8GAeXu42Eq7B4uTJjQ16/F1
 IMXoeQNi7vqXj69PGAHVeMMibjwiw2sBBJ6bYWEs4+lfWVUjszomyASpWoSXACRi3nlu/a8zkb
 2lGs0UoRbWk8LIZ3cxRuzrKyo7uFG3+VJmiA5YeeVRQc9x16EJAbrRqaoPyF4auOXyJwg2/RpM
 2zY=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="85979780"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:40 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:14:17 -0700
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
Subject: [PATCH v3 6/8] dt-bindings: microchip,sparx5-spi-mux: Add Sparx5 SPI mux driver bindings
Date:   Thu, 2 Jul 2020 12:13:29 +0200
Message-ID: <20200702101331.26375-7-lars.povlsen@microchip.com>
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

The Microchip Sparx5 SPI controller has two bus segments, and use this
mux to control the bus interface mapping for any chip selects. This
decribes the bindings used to configure the mux driver.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../mux/microchip,sparx5-spi-mux.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
new file mode 100644
index 0000000000000..b0ce3b15a69e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mux/microchip,sparx5-spi-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 SPI mux
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+description: |
+  The Microchip Sparx5 SPI controller has two bus segments. In order
+  to switch between the appropriate bus for any given SPI slave
+  (defined by a chip select), this mux driver is used. The device tree
+  node for the mux will define the bus mapping for any chip
+  selects. The default bus mapping for any chip select is "0", such
+  that only non-default mappings need to be explicitly defined.
+
+properties:
+  compatible:
+    enum:
+      - microchip,sparx5-spi-mux
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#mux-control-cells':
+    const: 0
+
+required:
+  - compatible
+
+additionalProperties: false
+
+patternProperties:
+  "^mux@[0-9a-f]$":
+    type: object
+
+    properties:
+      reg:
+        description:
+          Chip select to define bus mapping for.
+        minimum: 0
+        maximum: 15
+
+      microchip,bus-interface:
+        description:
+          The bus interface to use for this chip select.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+
+    required:
+      - reg
+      - microchip,bus-interface
+
+examples:
+  - |
+    mux: mux-controller {
+      compatible = "microchip,sparx5-spi-mux";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #mux-control-cells = <0>;
+      mux@e {
+        reg = <14>;
+        microchip,bus-interface = <1>;
+      };
+    };
--
2.27.0
