Return-Path: <linux-spi+bounces-6855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ACEA39CDA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA41893D3F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727F26A1C7;
	Tue, 18 Feb 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z2P8946Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38532690FC;
	Tue, 18 Feb 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883760; cv=none; b=YL312gbgKc6N+/Pa4UBlQ1E62I92DCiM1saupfGKLOWJXjTtVbNHaX238qCW6/uxWWV3s4r8q3IwTYB+2eKNhw7QcRGIpS4DsHSSrUMCxOAUbayasanrXpqRtXR9b5tyn842ml6pSZF/UN7lKmuyilnVTze7w6W7sVMRvpuzrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883760; c=relaxed/simple;
	bh=EMtu0FkQ0LwpXYJ063w9gIszbQuKUIDXnA6NiUwwaZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqIWdYjpEr34O0plp5GXKVGXPZKPKgRDhlF7o9hs5L8184LuK6S1jdB6v7C603dEYALHNPvm3j4fhr4RdfVW0cznxuZR1lIPg2+d/PoTvMFOYWQSvbTrL8f+p66z/7KU/vNABF4pkYI3NJ6PDrRoRUVjNW0JL8RLEkzMx+byu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z2P8946Z; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ICTPPZ005901;
	Tue, 18 Feb 2025 14:02:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zi9sWfS4AcvcvOsYJDRFzll/+wt+aEfG/kF8n5iSU4w=; b=Z2P8946Z84ttpeId
	dDg8F7SaSx2BZFL7AYXb6FEwIRITKxLspZTEH+W8sS1sL+lHQK8EP/T/pHuTVG+4
	TzzFNbnxa3t4U5rzVgT0+esxnhev8xgBPryBIZRfEa2nhqQmdjjJbVv5AFYcUYPS
	llCrcbR1lf3786G5iW4ychDWYgj0ZZ0Fio6PCnsOvWD9knnYoTgoDnWOlToefbAC
	tp9YKyjlqoKefPPBZeOdQgqVnYOZJwD578Jj7Lcc9F2F+6HDfaMqfcXcTQnhXXv6
	a5Y7m5x4i8xOCDd7hDvhW/nZ2icAphVPuz2cb3BPmwgH6DTsUlptCs1Bz4SIEJVu
	3kxxcA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44u5c3t959-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:02:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 11E4D40046;
	Tue, 18 Feb 2025 14:01:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC532327694;
	Tue, 18 Feb 2025 14:00:03 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 14:00:03 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH v4 1/8] dt-bindings: spi: Add STM32 OSPI controller
Date: Tue, 18 Feb 2025 13:59:53 +0100
Message-ID: <20250218130000.87889-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218130000.87889-1-patrice.chotard@foss.st.com>
References: <20250218130000.87889-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_05,2025-02-18_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add device tree bindings for the STM32 OSPI controller.

Main features of the Octo-SPI controller :
  - support sNOR / sNAND / HyperRAM™ and HyperFlash™ devices.
  - Three functional modes: indirect, automatic-status polling,
    memory-mapped.
  - Up to 4 Gbytes of external memory can be addressed in indirect
    mode (per physical port and per CS), and up to 256 Mbytes in
    memory-mapped mode (combined for both physical ports and per CS).
  - Single-, dual-, quad-, and octal-SPI communication.
  - Dual-quad communication.
  - Single data rate (SDR) and double transfer rate (DTR).
  - Maximum target frequency is 133 MHz for SDR and 133 MHz for DTR.
  - Data strobe support.
  - DMA channel for indirect mode.
  - Double CS mapping that allows two external flash devices to be
    addressed with a single OCTOSPI controller mapped on a single
    OCTOSPI port.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 .../bindings/spi/st,stm32mp25-ospi.yaml       | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml

diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
new file mode 100644
index 000000000000..5f276f27dc4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,stm32mp25-ospi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Octal Serial Peripheral Interface (OSPI)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp25-ospi
+
+  reg:
+    maxItems: 1
+
+  memory-region:
+    description:
+      Memory region to be used for memory-map read access.
+      In memory-mapped mode, read access are performed from the memory
+      device using the direct mapping.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: phandle to OSPI block reset
+      - description: phandle to delay block reset
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  st,syscfg-dlyb:
+    description: configure OCTOSPI delay block.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: phandle to syscfg
+      - description: register offset within syscfg
+
+  access-controllers:
+    description: phandle to the rifsc device to check access right
+      and in some cases, an additional phandle to the rcc device for
+      secure clock control.
+    items:
+      - description: phandle to bus controller
+      - description: phandle to clock controller
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - st,syscfg-dlyb
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    spi@40430000 {
+      compatible = "st,stm32mp25-ospi";
+      reg = <0x40430000 0x400>;
+      memory-region = <&mm_ospi1>;
+      interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+      dmas = <&hpdma 2 0x62 0x00003121 0x0>,
+             <&hpdma 2 0x42 0x00003112 0x0>;
+      dma-names = "tx", "rx";
+      clocks = <&scmi_clk CK_SCMI_OSPI1>;
+      resets = <&scmi_reset RST_SCMI_OSPI1>, <&scmi_reset RST_SCMI_OSPI1DLL>;
+      access-controllers = <&rifsc 74>;
+      power-domains = <&CLUSTER_PD>;
+      st,syscfg-dlyb = <&syscfg 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-rx-bus-width = <4>;
+        spi-max-frequency = <108000000>;
+      };
+    };
-- 
2.25.1


