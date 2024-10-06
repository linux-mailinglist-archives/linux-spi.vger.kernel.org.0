Return-Path: <linux-spi+bounces-5115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84899224B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 01:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331FD1F21409
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FDF16F908;
	Sun,  6 Oct 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1D/6x8pA"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4818BC1C
	for <linux-spi@vger.kernel.org>; Sun,  6 Oct 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257637; cv=none; b=P3Xh9Zp487xCi9yFy2C3Bwd6vPHEnVqkTNAHg8ztWpfirH+E8vYOq7qFWtqa3rsHY1RnMNJyAL+i7HBnfgN+ZcQ+AaCwlrLp92b/cgKe/ObWw65DiFeJ4uIT1k2dmv1JcZkrALtugKH2SkbyME1hzL4VmQkIIKZ3WFAyRS+Fydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257637; c=relaxed/simple;
	bh=KthkDb1UFmtj2oTwsYRZLQioN6f+e0gU6CdlIK7ZAL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifXI4AsQd4oJtysT1H+coqMeRDKQupffVGbPkcKZn+pGQJ+K9RdipsVEfak32v1K0ZdiO1IS1LkbMVoGpARdLcNuOUeBMVqZDQeELbzgRethFKQfUEyx5MfiOQVqrn6XzgAOY+0dk0Kr2wdWeJ+Lp3/O5RAI9uzuS1RydBrQHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=1D/6x8pA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0EA6D2C0707;
	Mon,  7 Oct 2024 12:33:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728257632;
	bh=+R6D7ViTGwaxMF9Hs1GX2HIMGxVFsKvIND8pTMhd5hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1D/6x8pAhaU2Yt43AUTqdB1x/MHWZ0hdjqZ5E8CcT4oczx0GEQouSg4vRweNd3FIU
	 AsA36fHRWWeF921OelmpsUJdHDFZpkdzSqJnwPl74anllHhCRhN0BHW7nROabnOAQ7
	 14m9rktjaG0IE+DBOg8fLzNFHaaW9goSMyLlhFH8xhhbCUBEn4+Llh0OoapxVCv7jN
	 wuXaq0ptJgXgRk0+hERkk/pWIrJfjOVZVuMA/rkcprLNWxdSR63dyDCvmdK/LurOAP
	 qDjNuzO13VbLpmfSR6rRwTi/5IjkGCRkyzy1EX5KEFksTJInp/KdU3EOVJz56JVkG+
	 wNsZ3klqQVA2Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67031e5f0001>; Mon, 07 Oct 2024 12:33:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B40DA13EE4F;
	Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id B3FB0280442; Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
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
Subject: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Date: Mon,  7 Oct 2024 12:33:45 +1300
Message-ID: <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67031e5f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=LDMcNrMx3qfY-b3KP34A:9 a=3ZKOabzyN94A:10 a=vAzDVtvKHO3qMBxtK9C2:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
controller supports
 * Serial/Dual/Quad data with
 * PIO and DMA data read/write operation
 * Configurable flash access timing

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../bindings/spi/realtek,rtl9300-snand.yaml   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300=
-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.=
yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
new file mode 100644
index 000000000000..c66aea24cb35
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
@@ -0,0 +1,58 @@
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
+required:
+  - compatible
+  - reg
+  - interrupts
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


