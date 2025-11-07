Return-Path: <linux-spi+bounces-11115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C308C3FDFF
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 13:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F29C44ECFD8
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206B2836AF;
	Fri,  7 Nov 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mWRHA9UY"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA31F3BA4;
	Fri,  7 Nov 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517845; cv=none; b=VNjjLirvRi89Y95oC7R/4f0KejRLk2wtplt537G7TDQdPY6mKOZ1eno5ennHXR+edLRYQ3rPRCerBdDmYoSY96wngoWPp4iHGgP+sJAP6o9xP8sBGzAF4x5ZRrIhvrA6MCFy6XLfogz22g5UEesoFiHM8Zr5N12ML/Jzm56/5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517845; c=relaxed/simple;
	bh=gUnRf6n8ndiHI4YW1DJPBaLZYDQ9YnYfxMEEpRNdoGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL+XB1eO48VK0m/a6cHzVwC+HP8593O5ZzDLNFrZNXoSOJnN6LbFAhX9uzFq58ukVEP+Urtea9e8UGwb/GoJARofT8k3iXLvELvYfU0AkVXzqe154LHHkZfdk4vr1XNhbRW5bD6dhliA9Sna2BxcRUIkEfxrPEbs7QoRvVK1WuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mWRHA9UY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762517844; x=1794053844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUnRf6n8ndiHI4YW1DJPBaLZYDQ9YnYfxMEEpRNdoGY=;
  b=mWRHA9UY11baox0W8gTnSUY3YjTnkVbECiQJ4GwWoyul+mTz0pskY2G3
   +mZ47DnPZu3FodjhtI53Nc28hEOKL5cnW2HUpZDv9S5TrowHFM7uG+WYo
   JRGK9kMUBElr8FmISVzb+/uza6BT8XIv5UNE70ovEC1AjRc+tYW1Ix+Rj
   F7dATtD3pmQB45zfPuS0uV7b/UOXK+423idPPmCigSn+HuKYxdvypN2FP
   1qpDPWXxlFO1Sw86A4sqW/IsWvfdbt3s44HGih6wEdzQWnIl9v9lJ26k4
   HIiejhz41zt2Rdn8+VihrgBIWv3VjcHNKbq5D+AIRKSTGt8gmtfB1B+X7
   g==;
X-CSE-ConnectionGUID: sUAnbxRLSU+qM77z5K7SQw==
X-CSE-MsgGUID: mQ2FtkYrQPSnKguOdAN9ZQ==
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="55218277"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2025 05:17:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 7 Nov 2025 05:16:42 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 7 Nov 2025 05:16:40 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v3 2/3] spi: dt-binding: document Microchip CoreSPI
Date: Fri, 7 Nov 2025 12:21:03 +0000
Message-ID: <20251107122104.1389301-3-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
References: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
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


