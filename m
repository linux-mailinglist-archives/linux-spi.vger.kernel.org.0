Return-Path: <linux-spi+bounces-8366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7BACD8BB
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC2C3A476A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4A238D2B;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2odtzX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5422D780;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022853; cv=none; b=HatBeB+MW4TBlVKwS0U+sN0+g8ST/lxcRhX180+elwdq9lxf/nYz5wpdCekt2O726VHxRFVUGCE1bN83xt2GDr4iFfH6PxrONkHXVQeD9zYwavMQI/TeaDecbySbsmwNDRSNHGxJC63qW87ky6TaUaCnH4vRSTYtwzn6ZDLA1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022853; c=relaxed/simple;
	bh=rnNGz1GGn6PYOQnsZwE6bvO/8t20BGjGItt9vuXTLJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubRWPw0tKY1T+NP3PlyoA7aVV4XHm2XuguR4BNr/yMabDwPO2ep1xObzHe5JAuvm0EQiO/pIi4cnYK6hRBAwA5b60nHwA+xb03WmyROjo0/5PdxXI2SfFeJ3Dl6O+DykkQQCoP9hQ4n6Iskx2t4VQ5p+n+JrNS/+mvEWEmlR4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2odtzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E44CC4CEE7;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022853;
	bh=rnNGz1GGn6PYOQnsZwE6bvO/8t20BGjGItt9vuXTLJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ig2odtzXCY68fEB55GXo4JCps7EuIcpr0zGMJODQ1oLZDoceL/WnwT6SqcmjNKl5o
	 PpcLlk28ZPhDty+DGlwwNVNld+UPHAfV6UeFrgSPePmHmGMI8GzY9xjyzdiGtT+PnU
	 Y301QvXrhoB/MVs5xCj0Da3ljI75A5pXJf/rd+zLpmVQtZKdjgrBqahsnOMZ0OiiN3
	 rnrydIGE2/spo5xyQGUULFkSyQ4RN1KJUgskGIDh5/8frGnJ0nJ9No+Xr734+AhMi4
	 REpFu0N6mtS2Lfq3Izo2UzxG4ub5g1ZFaMUQ63IzdYsIohm4aNVXZu22MEddaE67yN
	 RktlEK68GEl9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69DC5B555;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 04 Jun 2025 15:40:51 +0800
Subject: [PATCH 1/3] dt-bindings: spi: Add binding document of Amlogic
 SPISG controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-spisg-v1-1-5893dbe9d953@amlogic.com>
References: <20250604-spisg-v1-0-5893dbe9d953@amlogic.com>
In-Reply-To: <20250604-spisg-v1-0-5893dbe9d953@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749022851; l=1826;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=JpIA8EXgX4qGdcEsZY4R8K9pmoEKnmQU577yskBQ4WM=;
 b=WU0+PjqZQ/YG3zcsD8IQTOQXyB0iue0WTGEdFfz/pwvDZorVTn0IbaEYldYwpEZemlC5h/eNM
 FKk2xjt93mJBvihUKpic4zerxQ1YFa9LjXaqt/T1TFF4OxnjcAQBvKI
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Sunny Luo <sunny.luo@amlogic.com>

The SPISG is a new communication oriented SPI controller of Amlogic, which
supports PIO, block DMA and scatter-gather DMA three operation modes.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
new file mode 100644
index 000000000000..8d4d4606ff48
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amlogic,a4-spisg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic SPI Scatter-Gather Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Sunny Luo <sunny.luo@amlogic.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a4-spisg
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@50000 {
+        compatible = "amlogic,a4-spisg";
+        reg = <0x50000 0x38>;
+        interrupts = <0 183 4>;
+        clocks = <&clkc 37>,
+                 <&clkc 93>;
+        clock-names = "core", "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.37.1



