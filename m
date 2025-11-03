Return-Path: <linux-spi+bounces-10980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D5C2CFCA
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EB31895C2D
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1D314D18;
	Mon,  3 Nov 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TkUzgttH"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7D314B90;
	Mon,  3 Nov 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185667; cv=none; b=k1Ose5ZlWS6s15X+WS9Z2CJosI1pyLVQNcDWvpLL+Wa7HPCUSF5JtrjoaTbILd+uafCo4GX6OXRSYQiP+FDd4L/5RyXPAwjlxkLXu5Z8qEAYB/mrMcp+I5Yjx0BUvksKY0ZjtSQa88Syo31b8yWcDxT31p5WqV0onIiiImxF4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185667; c=relaxed/simple;
	bh=NFFi4xajt1Ti9S2x8Bd4i+ehy+CjIzgxpfhHR5gc3oM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/3W4BjVSzQsvHbkls/IKgSWt5/Uiw906kz20k04N9swXARk+A6HvPNXG8lay5TjLbhR2jixAFcwQHzfJFD9HV4eI/Y4mXE3XT5D4iRrzbtX0YxQs3UgeCNtG9pxnHjBFmmC1s5Ovo4Pr1cOnL2IgrTdGh4shaKsVpWvz5Xzexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TkUzgttH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762185665; x=1793721665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFFi4xajt1Ti9S2x8Bd4i+ehy+CjIzgxpfhHR5gc3oM=;
  b=TkUzgttHCUazYJ8pD1jDz0laTpt0t2V/LI4MmNi8UMXcFJSGE0J0mthq
   yM2Hx8ucDY8VEbuBAwfCKostWHD7C6CTf9N7Z5huN33roYADIOyzInGRi
   wQEmRGdF2+AXDghPl+evnClWZbHDjSWvTWyadvtxCeoKQzyFP+xfsL8Ce
   Mx+1FCQsNpVZ3DCUDRroM+3z/NgWbI+KXo18TbP0prs+uHQW2XWKOHv6h
   6eKO4JH/i9FvhbjbPhFv8yqlNACnvqa8omo/521bgFhSSQ5qwO912Ns9u
   NkIk2UFxe5Eg/jLeFAotjzxvNe10tEpoiMJ2bUzzYKlyPsB/C1rWpp+cs
   Q==;
X-CSE-ConnectionGUID: ppzothk7SMW2txU3EdHy0g==
X-CSE-MsgGUID: k1xPJT3BShm3cZo6sa1jDQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="215955468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 09:00:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 3 Nov 2025 09:00:43 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 09:00:41 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v1 2/3] spi: dt-binding: document Microchip CoreSPI
Date: Mon, 3 Nov 2025 16:05:14 +0000
Message-ID: <20251103160515.412706-3-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
References: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
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
---
 .../bindings/spi/microchip,mpfs-spi.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 62a568bdbfa0..62c38d0c93e7 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -26,6 +26,7 @@ properties:
           - const: microchip,pic64gx-spi
           - const: microchip,mpfs-spi
       - const: microchip,mpfs-spi
+      - const: microchip,corespi-rtl-v5 # FPGA CoreSPI
 
   reg:
     maxItems: 1
@@ -39,6 +40,45 @@ properties:
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
@@ -71,6 +111,31 @@ allOf:
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


