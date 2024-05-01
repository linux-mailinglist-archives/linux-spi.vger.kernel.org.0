Return-Path: <linux-spi+bounces-2678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8848B8BAA
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0084E1C21332
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9012EBF8;
	Wed,  1 May 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs+tu1vl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40112EBD4;
	Wed,  1 May 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572417; cv=none; b=V5eshf4p12EUPNdnMXLF59TADF+2RoIv0vZQd9rhyUWRQwAbdx1Hyg0H+0WnDu+K0GJzsXoi0+8kXt2kY1QGzAJ+DETw48fQg3N53S4C7c7nwWUCN4XbFJ8n9zkQ7S+5Qx9+xuB9GNfuZfncSwROUMBLE8nG/3qYkIAOKM/66lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572417; c=relaxed/simple;
	bh=+qp19hqkCM2/AO2+QMyoh5ytKn54dQ89zQGpEFAUzDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Ky6hjRkiYEMRYDj9+NdxdtBuIK2IgeLVeaymc7RxY5kAJY07lnltKx/DnYNtXRvoNSSseALz403Ho9e9mvhuWX3xpmEhgv0TjGqVFRs0zGD3FiYsfFRpwUTLk2G2f5WBykskO0TeCQGu+G4v42XSnydS5ljdDDaYREAh46QHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs+tu1vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5E0C072AA;
	Wed,  1 May 2024 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572417;
	bh=+qp19hqkCM2/AO2+QMyoh5ytKn54dQ89zQGpEFAUzDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bs+tu1vlyJg5Y+cRMg7enqa8jTE+RK5RMrr8L+S6Bp/ubKl62ER03a0Kz9rJ3VqkX
	 y1cjU1bnlgR9+3H2FGdXHk3jy2Qj07YclE79e3pXWPo3orEOS0YT5P5NJ0swwLUsLb
	 VDNJwfmCifqKhdo1Urp5arzCk2G0jC7/73gEY8MElQ34X9r9or7YLk/gMoNQDznxtw
	 xjqhJ/prYYbB8NNZJqh3KCIkW2vRRu9W3XbJrMjH4ZXuE1wt7hLr+2krNC58nCSxOg
	 axOTSCmwmI9z/e3N21FFYbGgepcfVMdTBerEK5eJyVwe/ser+yNpO2pjheaptE2Sig
	 rI877cbJALiLA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	conor@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: [PATCH v6 1/3] spi: dt-bindings: Add binding doc for spi-airoha-snfi
Date: Wed,  1 May 2024 16:06:41 +0200
Message-ID: <595aa3c35591367fcad730aa5541c86e78c737e8.1714571980.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714571980.git.lorenzo@kernel.org>
References: <cover.1714571980.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device-tree binding documentation for Airoha EN7581 SPI-NAND
Flash Interface.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/spi/airoha,en7581-snand.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
new file mode 100644
index 000000000000..b820c5613dcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,en7581-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND flash controller for Airoha ARM SoCs
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-snand
+
+  reg:
+    items:
+      - description: spi base address
+      - description: nfi2spi base address
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: spi
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@1fa10000 {
+        compatible = "airoha,en7581-snand";
+        reg = <0x0 0x1fa10000 0x0 0x140>,
+              <0x0 0x1fa11000 0x0 0x160>;
+
+        clocks = <&scuclk EN7523_CLK_SPI>;
+        clock-names = "spi";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "spi-nand";
+          reg = <0>;
+          spi-tx-bus-width = <1>;
+          spi-rx-bus-width = <2>;
+        };
+      };
+    };
-- 
2.44.0


