Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13D112E84
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfLDPcu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 10:32:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25132 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728282AbfLDPcu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 10:32:50 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FRKQ9030262;
        Wed, 4 Dec 2019 16:32:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+9lWQkEjqwkPOyurtTV3ZM+qwwYATmvlvAbyD5XGBKo=;
 b=h+3Z8EjpO5BwBlzIcXyd9b3IfjghkL8YihNVQ3PAd57zsp6lABUkHl5ShNcow8Ajh+M/
 4lBqQm7pP4/ByMNK13fpA1sj3i0FMV8OtCFDuL0eGKbZ1a4/7hL1Q9FcxUtwf/TP5FGa
 OoYjdB/oB6/c+dKg8xbeMZitig+OZJNj5H1AkO3AV57GJEb5udRS4Z70rjjO86DqdrWc
 muZLyv1UfTNAcO0u66SHFRcsHAlc1OXbrpM9iQzBtqQIWSmABiN3/e1ONT2egGDWQchs
 W1Rrv79sptz5V3MAPkbJkctYcMrG3OgmgvRlrc0cGOFJO4VDV4Ntpx5GCNfVrCTQMWpB PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeea65fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:32:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E68B010002A;
        Wed,  4 Dec 2019 16:32:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFEA02C38CF;
        Wed,  4 Dec 2019 16:32:38 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 16:32:38
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Erwan Leray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] dt-bindings: spi: Convert stm32 spi bindings to json-schema
Date:   Wed, 4 Dec 2019 16:32:33 +0100
Message-ID: <20191204153233.791-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the STM32 spi binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Erwan Leray <erwan.leray@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/spi/spi-stm32.txt          |  62 ------------
 .../devicetree/bindings/spi/st,stm32-spi.yaml      | 105 +++++++++++++++++++++
 2 files changed, 105 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
deleted file mode 100644
index d82755c63eaf..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-STMicroelectronics STM32 SPI Controller
-
-The STM32 SPI controller is used to communicate with external devices using
-the Serial Peripheral Interface. It supports full-duplex, half-duplex and
-simplex synchronous serial communication with external devices. It supports
-from 4 to 32-bit data size. Although it can be configured as master or slave,
-only master is supported by the driver.
-
-Required properties:
-- compatible: Should be one of:
-  "st,stm32h7-spi"
-  "st,stm32f4-spi"
-- reg: Offset and length of the device's register set.
-- interrupts: Must contain the interrupt id.
-- clocks: Must contain an entry for spiclk (which feeds the internal clock
-	  generator).
-- #address-cells:  Number of cells required to define a chip select address.
-- #size-cells: Should be zero.
-
-Optional properties:
-- resets: Must contain the phandle to the reset controller.
-- A pinctrl state named "default" may be defined to set pins in mode of
-  operation for SPI transfer.
-- dmas: DMA specifiers for tx and rx dma. DMA fifo mode must be used. See the
-  STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt.
-- dma-names: DMA request names should include "tx" and "rx" if present.
-- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
-  Documentation/devicetree/bindings/spi/spi-bus.txt
-
-
-Child nodes represent devices on the SPI bus
-  See ../spi/spi-bus.txt
-
-Optional properties:
-- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
-		  delay in nanoseconds inserted between two consecutive data
-		  frames.
-
-
-Example:
-	spi2: spi@40003800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "st,stm32h7-spi";
-		reg = <0x40003800 0x400>;
-		interrupts = <36>;
-		clocks = <&rcc SPI2_CK>;
-		resets = <&rcc 1166>;
-		dmas = <&dmamux1 0 39 0x400 0x01>,
-		       <&dmamux1 1 40 0x400 0x01>;
-		dma-names = "rx", "tx";
-		pinctrl-0 = <&spi2_pins_b>;
-		pinctrl-names = "default";
-		cs-gpios = <&gpioa 11 0>;
-
-		aardvark@0 {
-			compatible = "totalphase,aardvark";
-			reg = <0>;
-			spi-max-frequency = <4000000>;
-			st,spi-midi-ns = <4000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
new file mode 100644
index 000000000000..57ef3a0f57e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,stm32-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 SPI Controller bindings
+
+description: |
+  The STM32 SPI controller is used to communicate with external devices using
+  the Serial Peripheral Interface. It supports full-duplex, half-duplex and
+  simplex synchronous serial communication with external devices. It supports
+  from 4 to 32-bit data size.
+
+maintainers:
+  - Erwan Leray <erwan.leray@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+  - if:
+      properties:
+        comptatible:
+          constains:
+            st,stm32f4-spi
+    then:
+      properties:
+        st,spi-midi-ns: false
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-spi
+      - st,stm32h7-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    description: |
+      DMA specifiers for tx and rx dma. DMA fifo mode must be used. See
+      the STM32 DMA bindings Documentation/devicetree/bindings/dma/stm32-dma.txt.
+    items:
+      - description: rx DMA channel
+      - description: tx DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+patternProperties:
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
+    type: object
+    # SPI slave nodes must be children of the SPI master node and can
+    # contain the following properties.
+    properties:
+      st,spi-midi-ns:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Only for STM32H7, (Master Inter-Data Idleness) minimum time
+          delay in nanoseconds inserted between two consecutive data frames.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    spi@4000b000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "st,stm32h7-spi";
+      reg = <0x4000b000 0x400>;
+      interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&rcc SPI2_K>;
+      resets = <&rcc SPI2_R>;
+      dmas = <&dmamux1 0 39 0x400 0x05>,
+             <&dmamux1 1 40 0x400 0x05>;
+      dma-names = "rx", "tx";
+      cs-gpios = <&gpioa 11 0>;
+
+      aardvark@0 {
+        compatible = "totalphase,aardvark";
+        reg = <0>;
+        spi-max-frequency = <4000000>;
+        st,spi-midi-ns = <4000>;
+      };
+    };
+
+...
-- 
2.15.0

