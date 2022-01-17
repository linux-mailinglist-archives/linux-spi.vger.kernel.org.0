Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19709490679
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jan 2022 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiAQLGI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jan 2022 06:06:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:34294 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiAQLGE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jan 2022 06:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642417564; x=1673953564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OOEiOzJYOr2rjLZtIJaPl6yuaJhJGBub8XFzhK4pAzA=;
  b=NGYOlai7I9al1eK3QFV+hNn6e1w7XKjlszObdRZDT4pnDJ8GqhRQVoOg
   ziGGKqiCcy+xWJPEvzutt0pFP2aBUStiLaw1HP3NnvFRWSUuoxDrE8kOA
   cgh8weYY3kE2NYKxEFBBwSRM/qIn6/x4tBhkM2K8aSfOEgwOAmKw2XMV+
   0xZA98umUOglKmCY+Hj/Qshe2juWlb4rgFHaADAszQmZOVvUCpP+OK5Kz
   v/U3QCTVUPo43Y4rfwrrhPZVKhP677vzBA344Kw+aANew66EoB4pKq2HF
   6KVRQdZ4zLjlgKZRb6AbYb58zaTrdCc7Uce7iozVUyKG7frLKNWXpwxMB
   w==;
IronPort-SDR: FFZlhqqrm0wOQIzZ3IZKHYXtwdx+9Z/1I5gQa2bWJsegpf0wk16Xz7I541Blmt/htA75huoZiC
 v2fS09K0mOnIYCGFCqLQhFYjqQNUUFJzYxFKZ6RmxaRmmgMqKwCba1EtrPZYkMSmvIgE8vaMyU
 1ZgW+EI0nVHmERAhNI7xvqkk4ExvMR252oC/tfbDTliZ15g7s7XvPo2aeI0G4FOXESP8TqxOyK
 JqVBbcrDalow6ZE9dozyxzyxgh7UTwIYg7bCQk71yXN58quZ/3ckHDNc6p3Il3J+WPloMlFBd7
 08DOuEMEqsFtXgvs56ddiR1x
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="145638398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2022 04:06:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 17 Jan 2022 04:06:02 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 17 Jan 2022 04:05:56 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <geert@linux-m68k.org>,
        <bin.meng@windriver.com>, <heiko@sntech.de>,
        <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>
Subject: [PATCH v4 02/14] dt-bindings: soc/microchip: add services as children of sys ctrlr
Date:   Mon, 17 Jan 2022 11:07:43 +0000
Message-ID: <20220117110755.3433142-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117110755.3433142-1-conor.dooley@microchip.com>
References: <20220117110755.3433142-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add mpfs-rng and mpfs-generic-services as children of the system
controller.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../microchip,mpfs-sys-controller.yaml        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
index f699772fedf3..b69386b1a3e1 100644
--- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
@@ -13,13 +13,45 @@ description: |
   The PolarFire SoC system controller is communicated with via a mailbox.
   This document describes the bindings for the client portion of that mailbox.
 
-
 properties:
   mboxes:
     maxItems: 1
 
   compatible:
-    const: microchip,mpfs-sys-controller
+    items:
+      - const: microchip,mpfs-sys-controller
+
+  rng:
+    type: object
+
+    description: |
+      The hardware random number generator on the Polarfire SoC is
+      accessed via the mailbox interface provided by the system controller
+
+    properties:
+      compatible:
+        const: microchip,mpfs-rng
+
+    required:
+      - compatible
+
+  sysserv:
+    type: object
+
+    description: |
+      The PolarFire SoC system controller is communicated with via a mailbox.
+      This binding represents several of the functions provided by the system
+      controller which do not belong in a specific subsystem, such as reading
+      the fpga device certificate, all of which follow the same format:
+        - a command + optional payload sent to the sys controller
+        - a status + a payload returned to Linux
+
+    properties:
+      compatible:
+        const: microchip,mpfs-generic-service
+
+    required:
+      - compatible
 
 required:
   - compatible
@@ -29,7 +61,13 @@ additionalProperties: false
 
 examples:
   - |
-    syscontroller: syscontroller {
+    syscontroller {
       compatible = "microchip,mpfs-sys-controller";
       mboxes = <&mbox 0>;
+      rng: rng {
+        compatible = "microchip,mpfs-rng";
+      };
+      sysserv: sysserv {
+        compatible = "microchip,mpfs-generic-service";
+      };
     };
-- 
2.32.0

