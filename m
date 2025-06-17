Return-Path: <linux-spi+bounces-8612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9EADBF4E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35115173946
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4E22CBD3;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjp4t/GG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD20194098;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128523; cv=none; b=fmQd8GGcRowaeaJ8C++APG8gq+YjriIWu+JPU7C6uuBmaMusS0Sj9j8TJywdoTeKmNravmzrdigrH1EcVDnanI/2q1jyvWzujL+j3PGZ6AgqLqCigE7eWqRzEs+Z7K4Fdhottx814PM3j6aA75fvdh5G36LY/nZrtYwTdxwdldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128523; c=relaxed/simple;
	bh=rnNGz1GGn6PYOQnsZwE6bvO/8t20BGjGItt9vuXTLJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fM0uHx4Snwloj5qEqPNYeyZc9s7Ci5DrhbXkQlpOVKKr7+J8l7CSkeqo9VMrdJlWPX8fVIEPKtknicflX+/wlkixvJtF6D3vCnVRBMATMvfGtF4jtNf51nzPbr3iSlcd+mMd8ZHVZQLxd4NFYiKgQE4+9Ytji6EyepSIifqaU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjp4t/GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24853C4CEF0;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750128523;
	bh=rnNGz1GGn6PYOQnsZwE6bvO/8t20BGjGItt9vuXTLJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cjp4t/GGKIlEqYSJHRLSDI0tVws/2555jyE1xXCqj1A1Y4ONemwKPrzPdzomSuf3+
	 4Rp6yzJ76AjdJP7ybb+EP755uujZip/T4TvYoAO23ra97j2er04gE2y25QMx00plQf
	 6ZtHFryM+cPRaymRoK8+n8HYxL18K4xhkhTR2iu6aMdIoAuP+VTbgm6hCpte1DtrFT
	 e4kJTYgJYRJVVPAgb54u02CZPr4lwrAbXLtAisyZK/GNttrh01xwvfLhRZWA1FxOwo
	 i2U5RQojMegs4i92FmJ0dMYRfDfHrWh+XvnBv/yPH/9GE/IjOA91dCBz5BzFGd+Iha
	 C5mfKvIMEPcGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB80C71159;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 17 Jun 2025 10:48:36 +0800
Subject: [PATCH v2 1/3] dt-bindings: spi: Add binding document of Amlogic
 SPISG controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-spisg-v2-1-51a605a84bd5@amlogic.com>
References: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
In-Reply-To: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750128521; l=1826;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=JpIA8EXgX4qGdcEsZY4R8K9pmoEKnmQU577yskBQ4WM=;
 b=nNM3ujG1VQZ9WC2DYfKB+EJEwcC3or6QNHqNpCPMOUAENe7aC+EaeU2S4DBIJnuwLsB2XQAvR
 8hL9j0/UX4nA59U3zq2q4USGIUJq2FuhOD2xKpHkzjXMWhhqwVmxVnQ
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



