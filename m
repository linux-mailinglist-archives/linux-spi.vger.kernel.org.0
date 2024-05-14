Return-Path: <linux-spi+bounces-2844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7388C50C5
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E51C20383
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20413762C1;
	Tue, 14 May 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lPPws2YO"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201346542;
	Tue, 14 May 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683677; cv=none; b=GL1YCCaNpwKaA/SL6s0u5k4bQIf5Xyygj63bMw1c7R60Azd1LMxmsTe36k/qULSq5pDSJrz9Ji/oekmr6NBamc3FQxKJ+7QknOpmB4H0EzQ/Hp/qNahqlEBK4aaIgMfgYB2O+a9YmiTvJhSq5MsXYRPnPh1V2KyyaPHmDp67V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683677; c=relaxed/simple;
	bh=yHGgknwXW0O8OB9OmVvJHciQo5Z0+ha+LxvoCItjQ/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFEjS9vqZTZxHn3wVbLsASVshBqrLeuCPMbuesh9+YWpXRX3BnHTU8AIwWR2exvl6zkuDJrP4Dr4wxz4MovPNDz2fTut3G7xfND/fxw1JbLHpBL2dJx0Zs0TaAxGjexyGaJfqwo1ioNYumgaQSy011HqwHnplGGk9L6Wol8vhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lPPws2YO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715683675; x=1747219675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHGgknwXW0O8OB9OmVvJHciQo5Z0+ha+LxvoCItjQ/g=;
  b=lPPws2YO5DyhHK/TOvDRDak5gPVeUE1uskagvuF3KJU6l0k0UDNi1h8/
   pnjqisg87nA2uwlaVHHbkFSIczNozkdmWuWY8y7sXbziHaXHa/SAjJIPZ
   Up101TR18ksLS0aGgjbLCbrPLh4Q34M+DzS23Mp2Cz4jC9DgVX6m9V5Gl
   QL3d6q3jXTkZTClwtLv+SiODzocoGL6AEHASiRHTJBYA4d0Q21oeZg1Gz
   Cj2FHyTOAbFvpsmD2o/nC8blwuIYb95yuNzRCcoFFecrAC/wpLB5ZTCx5
   bVCjPwY4NDePKL+5vQ6fsehdV4zJPIuyw4niG9A2+d+Pbdn0prJLid2P3
   A==;
X-CSE-ConnectionGUID: N9mxCvhER5eXal035+dGRg==
X-CSE-MsgGUID: xjBThKMUSH2OGeJyx9odVg==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="24661010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 03:45:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:44:56 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 03:44:54 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>,
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 1/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Date: Tue, 14 May 2024 11:45:06 +0100
Message-ID: <20240514104508.938448-2-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PolarFire SoC SPI "hard" controller supports eight CS lines, out of
which only one CS line is physically wired. The default value of
'num-cs' was never set and it did not didn't impose a maximum value.

To reflect this hardware limitation in the device tree, the binding
enforces that the 'num-cs' property cannot exceed 1 unless additional
CS lines are explicitly defined using GPIO descriptors.

Fixes: 2da187304e55 ("spi: add bindings for microchip mpfs spi")
Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 .../bindings/spi/microchip,mpfs-spi.yaml      | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 74a817cc7d94..ffa8d1b48f8b 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -13,9 +13,6 @@ description:
 maintainers:
   - Conor Dooley <conor.dooley@microchip.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -43,6 +40,32 @@ required:
   - interrupts
   - clocks
 
+allOf:
+  - $ref: spi-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mpfs-spi
+    then:
+      properties:
+        num-cs:
+          default: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mpfs-spi
+      not:
+        required:
+          - cs-gpios
+    then:
+      properties:
+        num-cs:
+          maximum: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


