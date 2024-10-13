Return-Path: <linux-spi+bounces-5216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241999BC9A
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 00:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33871C20DB7
	for <lists+linux-spi@lfdr.de>; Sun, 13 Oct 2024 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16D1482F6;
	Sun, 13 Oct 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gzf+XLoK"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CF13CA9C
	for <linux-spi@vger.kernel.org>; Sun, 13 Oct 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728859154; cv=none; b=gOLpeD6XL+rmVPhvwlBinimbdQsIx13qVf1O5Q4XPu65eU5iIMHx8PEUSMDEzLLNmWw7/yOJq+fGDakGbYukDy9HdbM9j9WK9UboYlVpKzJv5YPpXCo0mMomLdnPdYb2O7OMF3ZiySEZfqgsjys0xXCaRA1CLV19as4VRCNk8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728859154; c=relaxed/simple;
	bh=CQ1SJQfHB349z3eoXaoCITosdazrsz1tojdbBeVoSgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcmWNSnuuy6KioSZndK9Qw0cfh4IET4+s3NiAe9cU6WA8IXCQyLTVf7qXRiHJic4mO/GK7PseF+IioBMC1i6YeXaq4KvhPxkcmD4wrq5WkKvT9opGQtWT2tIQX3AGIuE7+EPdLRG5Almcz5hQSm7Fu80pgTQQy0xLz3UhLPemZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=gzf+XLoK; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D094F2C0613;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728859149;
	bh=oVfnUKZpM2XysBJBD7+aisc9BB+u/P2M5oTvHoScG7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzf+XLoKwLCUmQ5Cy1wyOmVYmsM5WtU2F6jpUg1ypyPhdAjMRocXOjhrY1juxZrX7
	 KHevZM+Y90+5KBs0EQryqqUfwbXCq8qkQqaCiIJU1VdY1lhYx2P3tlla6UklswVbBu
	 a2+HlK73aA0Lq6fNscm+Z+NJRjJ6vmQhnfiV/UzVzJMatvdE4DXRUdSXDl5PE54Cyl
	 /mcvxb9eF/2+tq0AhTF+88oijT0D1/u4JtB3oSkV/jY2BgESpH0AMs25VPFV5E3kcc
	 5k9Q6LZV9wLf7s2bkvQLI2W+Og/MxQW2UW8JmppLo/1YI4xgg1Gowlm81LhMpAlsei
	 j4iKAOWbiEynw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c4c0d0001>; Mon, 14 Oct 2024 11:39:09 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 83AFF13EE85;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 814D32802D7; Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
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
Subject: [PATCH v3 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Date: Mon, 14 Oct 2024 11:39:05 +1300
Message-ID: <20241013223907.2459099-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013223907.2459099-1-chris.packham@alliedtelesis.co.nz>
References: <20241013223907.2459099-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c4c0d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=LDMcNrMx3qfY-b3KP34A:9 a=3ZKOabzyN94A:10 a=oGKThFDb_VfU6udzmvRc:22 a=sptkURWiP4Gy88Gu7hUp:22
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


