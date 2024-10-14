Return-Path: <linux-spi+bounces-5223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7299BD75
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 03:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E183B217B8
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0D17BD3;
	Mon, 14 Oct 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="byFr+NDw"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BC1C687
	for <linux-spi@vger.kernel.org>; Mon, 14 Oct 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870777; cv=none; b=u6SwOQhHtvYcm7IiiQI05BfCUWuN27l2LOH6c9ANUd2rpd1GMkDLwrfMS+KCSF1sAvJaefTHUs/kw8bSPwPIqkHqyUzfSYmQjX/lk17uU9bqRNEmiWQBNu7b2I5nhGTud9GwatDm2Fq1o8h0YtC6COQfAPRMHTzwQiZM2Aukz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870777; c=relaxed/simple;
	bh=S9HWYfVFTXMiCfNIu9JOAd3alV4YEtDBkhbiHNtKfWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7jcl2AiznYkOWHK4SteSOWWEle2D4zS3ag+Q6h9bxZPsvb/rJ50GOFNMGwQxk0oLScwKczDc0l5imqfEmkud7/8Q819+UdQWH5CZoQoiG+y/vJsGpwsFRI8GCtvhMte6MRODc9pgJm7S+h6c91s00AmywQfE5tRLkLn4wEnY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=byFr+NDw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E2EA52C0613;
	Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728870771;
	bh=ny+jLclbBvrXtEWrR6m/M0iCqJKgjpE/esBS/USbUzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byFr+NDwZMtMnMKeUNaCPkRr9eakMPOuAPFvJY6FL3lnDOdYmsWFrOLdW/8N8E7qJ
	 yykFzUSlc50Qznhaia+IOORqGl1fXvO8kEoTtKxtcbVDramg9WHJaR1JNxVUx++PPK
	 oMf7Ms0FcZ9Vw2dIN4NgIcCGj6Icjk7wQ7F3MKhLeOfPit8D7pEOjq/709KSdSNWpe
	 Y7YspI7BJKskLD9mYKP5wI3TKE7dgl7x+xCvQh24oP7JIr0secFF/GfxJ+oq2XLR6I
	 gz+dU/2i1pdwymmxo9Sa/CqbbEDiapM9+ADeyLlmGmBqhaTejp1W/5sxToQRgPCK6p
	 A6DpGB4GtZgug==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c79730001>; Mon, 14 Oct 2024 14:52:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 873D613EE85;
	Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 866BC280090; Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
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
Subject: [PATCH v4 1/3] dt-bindings: spi: Add realtek,rtl9301-snand
Date: Mon, 14 Oct 2024 14:52:43 +1300
Message-ID: <20241014015245.2513738-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
References: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c7973 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=LDMcNrMx3qfY-b3KP34A:9 a=3ZKOabzyN94A:10 a=oGKThFDb_VfU6udzmvRc:22 a=sptkURWiP4Gy88Gu7hUp:22
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
    Changes in v4:
    - Adjust commit message subject to refer to one of the used compatibl=
es
    Changes in v3:
    - drop wildcard rtl9300-snand
    - drop redundant descriptions
    - drop clock-names
    Changes in v2:
    - Add clocks
    - For now I've kept realtek,rtl9300-snand to identify the IP block us=
ed
      in the various rtl930x chips. If the consensus is to drop this I ca=
n
      send a v3 with an updated driver to add the chip specific complatib=
les.

 .../bindings/spi/realtek,rtl9301-snand.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9301=
-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.=
yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
new file mode 100644
index 000000000000..397b32b41e86
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,rtl9301-snand.yaml#
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
+    enum:
+      - realtek,rtl9301-snand
+      - realtek,rtl9302b-snand
+      - realtek,rtl9302c-snand
+      - realtek,rtl9303-snand
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
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
+      compatible =3D "realtek,rtl9301-snand";
+      reg =3D <0x1a400 0x44>;
+      interrupt-parent =3D <&intc>;
+      interrupts =3D <19>;
+      clocks =3D <&lx_clk>;
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      flash@0 {
+        compatible =3D "spi-nand";
+        reg =3D <0>;
+      };
+    };
--=20
2.47.0


