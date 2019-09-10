Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164E1AE432
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2019 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfIJHDj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Sep 2019 03:03:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35114 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfIJHDi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Sep 2019 03:03:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so3182265plp.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Sep 2019 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x8676vaAMOMU0xS9ZBzOGK+O3nkLRs05V8sfia4T0io=;
        b=E1yMmjSYYd3SJOl+n5kBSPDt6WFLc78WrSf3sphfdotTh1RZBV7Wc2tjPZQ8px9Lig
         HIziAgXnNgmbIGwEZTBIwWFVvZyQHTmvuM5p5CxbaRm5SowE78u3iYJ/VsbfSugaN8jf
         NnlXJpbwcuB2cssMweuqo0+B1jpuvP2nzsTqzmKMtrl8C7M85iNm/k7zRCX4y7EdEqf3
         zFlfzHcT4mMotiXCMV6H4wM1ZqRLhS9zy8PV7yFjQZPpFgvdpOWnMx0T6R5N5kIMCVPa
         7F2JORo1xbDQps6U/RVRm7iIU80SWnXDaFWzFmmPz8v9wdKankZFOVw9XTCgudVlGMT4
         nClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8676vaAMOMU0xS9ZBzOGK+O3nkLRs05V8sfia4T0io=;
        b=I2jBUB/kIW8ieQHZRaHj+djiUTWltCAUu5Pb0+yGImKYkQDxNqzXSWUnmrRTDVN5jv
         Qpy//UxC7TZce0Hxn8yXr6yop2KJn3VrXTVg006vhA5xcX2pS0DHUNwbVHrBN/8IeO5P
         hdUfAf2sibujxu4JB4e6SjwPw+6hEUhLL/5CT1CK4mKaVqbd6i3oTgWTJWinZznY2u0g
         ujgM9kjXM9z7QzxG1deV4wQF/EQrNcyDyee1/ku31cUdVCI5lR438wqCMDkMXLNyTA6l
         nnU3sagRxkcs30cDQGKm/8flDD3FnY4kWqfHo3zzaY+f/J1fqCAg72gkbfiCHNLSRHyx
         unMQ==
X-Gm-Message-State: APjAAAVXq7KVgn0dRAz47wCu5o/wwBP7UfGa7klInF+FKPG9si6hmlff
        6wMo2yGY+4ZJOW++mbEhoLDf+g==
X-Google-Smtp-Source: APXvYqzf295XBYzMkJ2GP3vZ3dUOjLqYHN6ex68DBrUFlhgOofOjYtZwSxq9PB4LXBeat1GxDUDaAw==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr29467918plo.152.1568099017311;
        Tue, 10 Sep 2019 00:03:37 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id q30sm1387383pja.18.2019.09.10.00.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 00:03:36 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Convert spi-sifive binding to json-schema
Date:   Tue, 10 Sep 2019 12:32:51 +0530
Message-Id: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the spi-sifive binding to DT schema format.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
 .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
deleted file mode 100644
index 3f5c6e4..0000000
--- a/Documentation/devicetree/bindings/spi/spi-sifive.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-SiFive SPI controller Device Tree Bindings
-------------------------------------------
-
-Required properties:
-- compatible		: Should be "sifive,<chip>-spi" and "sifive,spi<version>".
-			  Supported compatible strings are:
-			  "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
-			  onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
-			  SPI v0 IP block with no chip integration tweaks.
-			  Please refer to sifive-blocks-ip-versioning.txt for details
-- reg			: Physical base address and size of SPI registers map
-			  A second (optional) range can indicate memory mapped flash
-- interrupts		: Must contain one entry
-- interrupt-parent	: Must be core interrupt controller
-- clocks		: Must reference the frequency given to the controller
-- #address-cells	: Must be '1', indicating which CS to use
-- #size-cells		: Must be '0'
-
-Optional properties:
-- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
-- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
-
-SPI RTL that corresponds to the IP block version numbers can be found here:
-https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
-
-Example:
-	spi: spi@10040000 {
-		compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
-		interrupt-parent = <&plic>;
-		interrupts = <51>;
-		clocks = <&tlclk>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sifive,fifo-depth = <8>;
-		sifive,max-bits-per-word = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
new file mode 100644
index 0000000..368f5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive SPI controller
+
+maintainers:
+  - Pragnesh Patel <pragnesh.patel@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-spi
+      - const: sifive,spi0
+
+    description:
+      Should be "sifive,<chip>-spi" and "sifive,spi<version>".
+      Supported compatible strings are -
+      "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
+      onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
+      SPI v0 IP block with no chip integration tweaks.
+      Please refer to sifive-blocks-ip-versioning.txt for details
+
+      SPI RTL that corresponds to the IP block version numbers can be found here -
+      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
+
+  reg:
+    maxItems: 1
+
+    description:
+      Physical base address and size of SPI registers map
+      A second (optional) range can indicate memory mapped flash
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+    description:
+      Must reference the frequency given to the controller
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  sifive,fifo-depth:
+    description:
+      Depth of hardware queues; defaults to 8
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  sifive,max-bits-per-word:
+    description:
+      Maximum bits per word; defaults to 8
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    spi: spi@10040000 {
+      compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+      reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+      interrupt-parent = <&plic>;
+      interrupts = <51>;
+      clocks = <&tlclk>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sifive,fifo-depth = <8>;
+      sifive,max-bits-per-word = <8>;
+    };
+
+...
-- 
2.7.4

