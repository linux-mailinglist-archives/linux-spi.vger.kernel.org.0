Return-Path: <linux-spi+bounces-5132-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A313993BB2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 02:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9DA2850EC
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 00:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229320ED;
	Tue,  8 Oct 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RSF/+Gpe"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8079FE
	for <linux-spi@vger.kernel.org>; Tue,  8 Oct 2024 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347003; cv=none; b=V+/z/2kkd+GVCdS2ypjW7hyaWnoYhRRGE9MMRkr9DaiA/cHaPcE6+NU163SY4MLUdXOTCUeWCw9yR82ZbbAudUp/C8+yVeM1GSGuuCdFHBvsMJEnUn65TaCa3mLfLHPhqs6vd/p03AIqdHEYAD5N5EI/ZZsPOq4/xX11GQrJvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347003; c=relaxed/simple;
	bh=70pgbID7KJjs3Pi1xZSu8sfymNQK5fE3VqHOaP8Akmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GppnW7hlpwvSJjppuXdZ7FiW6U5E7mhQxmAOysGP9hELOlFBCiVOXhzGpyD2ZHCNmaP7NpajYaV5xnyCT/766pLBXwEML13FgUcpvdsf/4A50OloeoylvTusy4Pg+v70Q+kq8cLmwI2Tcs5YlcDgpHEi7mjPwgQmI8wRfavHqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=RSF/+Gpe; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C223A2C0E2B;
	Tue,  8 Oct 2024 13:23:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728346991;
	bh=gjZS9Diq05TzQ1FpgZmaT4xdTf72iJglnanMipfthQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSF/+GpeSEn1oTVzCuwNUPyw5e/SrLiAZlE8Hi8DK1crU7Ow3j58i/3ganewKJy2i
	 4FjfiMOMpQPy463QGhcRtfNUXkQKpSrGjfZspco3ldKf6nQqHWhkTii9rJzS4Ojk96
	 bBv1ZxFQBkjVnsZ/pKT4GnbDgWSaB9SWluSztiN6hhMfUkxzNs8UtZCyA8GcqYdqPX
	 LuI7BgzYBtqTUpBUHlgBpZR+cR9T76UnetJ4S6xnasxMWNq2a5k01qbb5cg3pakQFD
	 UbV2zE/Qp5zHt3e+cogbRx5S3oDn+q8bky3mUHTDXcDSBGrzZp66+/iB3n7JU2EJuM
	 taG70m7fgFihw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67047b6f0001>; Tue, 08 Oct 2024 13:23:11 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 7A9B313EE4F;
	Tue,  8 Oct 2024 13:23:11 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 7692B280493; Tue,  8 Oct 2024 13:23:11 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Date: Tue,  8 Oct 2024 13:23:05 +1300
Message-ID: <20241008002308.1149983-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008002308.1149983-1-chris.packham@alliedtelesis.co.nz>
References: <20241008002308.1149983-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67047b6f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=LDMcNrMx3qfY-b3KP34A:9 a=3ZKOabzyN94A:10 a=oGKThFDb_VfU6udzmvRc:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
controller supports
 * Serial/Dual/Quad data with
 * PIO and DMA data read/write operation
 * Configurable flash access timing

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Add clocks
    - For now I've kept realtek,rtl9300-snand to identify the IP block us=
ed
      in the various rtl930x chips. If the consensus is to drop this I ca=
n
      send a v3 with an updated driver to add the chip specific complatib=
les.

 .../bindings/spi/realtek,rtl9300-snand.yaml   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300=
-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.=
yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
new file mode 100644
index 000000000000..2d01464e85e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description:
+  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It suppo=
rts
+  typical SPI-NAND page cache operations in single, dual or quad IO mode=
.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - realtek,rtl9301-snand
+          - realtek,rtl9302b-snand
+          - realtek,rtl9302c-snand
+          - realtek,rtl9303-snand
+      - const: realtek,rtl9300-snand
+
+  reg:
+    items:
+      - description: SPI NAND controller registers address and size
+
+  interrupts:
+    items:
+      - description: SPI NAND controller interrupt
+
+  clocks:
+    items:
+      - description: SPI NAND controller reference clock
+
+  clock-names:
+    items:
+      - const: spi
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@1a400 {
+      compatible =3D "realtek,rtl9302c-snand", "realtek,rtl9300-snand";
+      reg =3D <0x1a400 0x44>;
+      interrupt-parent =3D <&intc>;
+      interrupts =3D <19>;
+      clocks =3D <&lx_clk>;
+      clock-names =3D "spi";
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      flash@0 {
+        compatible =3D "spi-nand";
+        reg =3D <0>;
+      };
+    };
--=20
2.46.2


