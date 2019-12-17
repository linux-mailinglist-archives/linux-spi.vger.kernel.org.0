Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA16122750
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 10:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfLQJHl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 04:07:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfLQJHk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Dec 2019 04:07:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH94A7E005597;
        Tue, 17 Dec 2019 10:07:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=41mvUSOwuAhruiHu99TAoHez/M+143fLkG4jSCqmno8=;
 b=DYjCY3iMb3XomGOBSJb3DIIBH1iAFGaxNgrnV5mAt3JVS0oLVdFwgBXgxlQ/YePFsseD
 JHdgin5HBp8CiJDGHEqMma/lDCd5y69flPFJ2rhTJLq7Qm54C0+CWvUwD554kVPfyMrw
 akg0fxXi6OzjHaCLbJ5wFNpDIikq8E/tXEK7lRfQcKHZ49o1AXQcqWtbNFI5uT3kNUnS
 JIBLNd/RQBY280Ea8q0V2KhdRPKTkq0T51uhE3nFbbEo7qhePCtvx6gOR7yI/3fIdqxS
 30rRXmk2OjnhMDroOEGYXVpy7/rh3VaYf70sSeW0Ru9bdrYZzXnWEFVdWUjA8bhtX9Co IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp36wwta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:07:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BDE1A10003D;
        Tue, 17 Dec 2019 10:07:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B8D42A5785;
        Tue, 17 Dec 2019 10:07:18 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 10:07:17
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
Subject: [PATCH v2] dt-bindings: spi: Convert stm32 spi bindings to json-schema
Date:   Tue, 17 Dec 2019 10:07:15 +0100
Message-ID: <20191217090715.13334-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
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
changes in version 2:
- fix typo in if block (compatible + contains)
  The boths typos weren't detected by checkpatch.
- remove type for st,spi-midi-ns property but not add upper limit
  because the driver compute a delay (expressed in SPI clock cycles periods)
  from this value (expressed in nanoseconds) and all that depends of the SPI
  bus clock.
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
index 000000000000..f0d979664f07
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
+        compatible:
+          contains:
+            const: st,stm32f4-spi
+
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

