Return-Path: <linux-spi+bounces-11043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A038C36626
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 399F54FDF29
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA1336ED1;
	Wed,  5 Nov 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kZwNeC7V"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B433321BF;
	Wed,  5 Nov 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356278; cv=none; b=Wok4yR8GBqmUEdh/ppRI2So/ancZuBkjeJAKqG0AGbAmjdIe5W27EFraY6gYDaeFAUJVMjuiU18g4aBSxQzThFZivh6eL49f2YlS+t9O97Iw6Hc0i1uV0FNbyZljPymvvqNzaN5g9Pc0Z5gD8GrXrVG7VG8s049D+0AQ8UrO33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356278; c=relaxed/simple;
	bh=gUnRf6n8ndiHI4YW1DJPBaLZYDQ9YnYfxMEEpRNdoGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyJIEWt+CoGxjOt+zKnDev0FBcspuOxDcxEUDuZR5sUaSxJaHZh8JeGgX4nLv1x5zG1qBeYQFPN0W8ozlXWcofLxRbyHr3Gbh/UjiBce2cdFNewLqgU8bGMmLZoIlNftubFdJKcfZvFrLXXzUfqz/eK8F9W3MDCoD6wj8uONjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kZwNeC7V; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762356276; x=1793892276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUnRf6n8ndiHI4YW1DJPBaLZYDQ9YnYfxMEEpRNdoGY=;
  b=kZwNeC7V/R0bVunI3jVEjzKnNCiQAVVlyHMf4YTNDiFRbcAOk+eIv8GH
   EET+qFZVuSmvP82bHJkKXmrwjUHY/F5ZLulEIxjNyKyQf5qcrNrBuhyRo
   qQ1GRPcElCfjdiWi6vxWldBz4HF14JXuyHfBv8xwHE0WB4hqeLUeMBco2
   3wYLKbm8e+Ex2ytkwFUq2OFvs+dksxXitnLXSiP+cTGAnUrhtTkVmzbic
   iW0ue0GVzWrr16ts9WCsgNBLBcz/iUlt5R/av6UR2CkAth3YvAvUpSWUK
   A/PIKknJ2+Sz3GnKM19K/CujsYESCOC9RnPKVwE/UadDp/oafuzj8X2F5
   Q==;
X-CSE-ConnectionGUID: yWuSuPPyQzGntaE7tSBgAw==
X-CSE-MsgGUID: vmskSxkiSSmFxyt7qDsRSQ==
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="48083051"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2025 08:24:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 5 Nov 2025 08:23:55 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 5 Nov 2025 08:23:53 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 2/3] spi: dt-binding: document Microchip CoreSPI
Date: Wed, 5 Nov 2025 15:28:22 +0000
Message-ID: <20251105152823.730422-3-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
References: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree bindings for Microchip's CoreSPI controller.

CoreSPI is a "soft" IP core intended for FPGA implementations. Its
configurations are set in Libero. These properties represent
non-discoverable configurations determined by Verilog parameters to the
IP.

Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/spi/microchip,mpfs-spi.yaml      | 70 ++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 62a568bdbfa0..636338d24bdf 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -21,11 +21,13 @@ properties:
               - microchip,mpfs-qspi
               - microchip,pic64gx-qspi
           - const: microchip,coreqspi-rtl-v2
-      - const: microchip,coreqspi-rtl-v2 # FPGA QSPI
+      - enum:
+          - microchip,coreqspi-rtl-v2 # FPGA QSPI
+          - microchip,corespi-rtl-v5 # FPGA CoreSPI
+          - microchip,mpfs-spi
       - items:
           - const: microchip,pic64gx-spi
           - const: microchip,mpfs-spi
-      - const: microchip,mpfs-spi
 
   reg:
     maxItems: 1
@@ -39,6 +41,45 @@ properties:
   clocks:
     maxItems: 1
 
+  microchip,apb-datawidth:
+    description: APB bus data width in bits.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16, 32]
+    default: 8
+
+  microchip,frame-size:
+    description: |
+      Number of bits per SPI frame, as configured in Libero.
+      In Motorola and TI modes, this corresponds directly
+      to the requested frame size. For NSC mode this is set
+      to 9 + the required data frame size.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 4
+    maximum: 32
+    default: 8
+
+  microchip,protocol-configuration:
+    description: CoreSPI protocol selection. Determines operating mode
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - motorola
+      - ti
+      - nsc
+    default: motorola
+
+  microchip,motorola-mode:
+    description: Motorola SPI mode selection
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 3
+
+  microchip,ssel-active:
+    description: |
+      Keep SSEL asserted between frames when using the Motorola protocol.
+      When present, the controller keeps SSEL active across contiguous
+      transfers and deasserts only when the overall transfer completes.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -71,6 +112,31 @@ allOf:
         num-cs:
           maximum: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,corespi-rtl-v5
+    then:
+      properties:
+        num-cs:
+          minimum: 1
+          maximum: 8
+          default: 8
+
+        fifo-depth:
+          minimum: 1
+          maximum: 32
+          default: 4
+
+    else:
+      properties:
+        microchip,apb-datawidth: false
+        microchip,frame-size: false
+        microchip,protocol-configuration: false
+        microchip,motorola-mode: false
+        microchip,ssel-active: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


