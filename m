Return-Path: <linux-spi+bounces-5240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C099FBBF
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 00:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D628785C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 22:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD311D63DB;
	Tue, 15 Oct 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="oNVjaSMj"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260181D63CE
	for <linux-spi@vger.kernel.org>; Tue, 15 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032886; cv=none; b=chg6iJM0vKG1ZgHPE5ie5wfHsp9DHEi0fdGrkdQluWdDRJclrSOpwvyXonSY+ZMV3P+nx2zsugMCTc3rBNjKkj2d3saD7BaWyFPgGFSASNRMto6BLgscBzfMhRdPRniBTqQsfRCJ5o9swZ3FyGDadicuDW7JWeqUHAA578qyIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032886; c=relaxed/simple;
	bh=28Zjchui2mSdO9738LkYgtGhtVQn7Su3e1XQElMPXKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9dRYGoazL2QbjrbqV4JJTFBU2PesZZEu6xEig1eT8EChQwVZwB+xcTwPTsrtt0G+WduaaHXipHkBq9dEe+1KqRwOqBFKeTkx3lVQEKJE+Zs0IHeu/igPvy7qB4cEyCGeAuReEHi5bwrB5WQimJBpe557zHMWj1pwbg4JkQpj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=oNVjaSMj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D5BE12C038E;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729032880;
	bh=SKVV3WFx27irMp2sL011rkHXlnDlzmjudKsVpWH3D7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNVjaSMjK7HynGw79H/JeCeAsUy3oAArk1CBM+3bG/55Lm1UBmmuPLe+j+gFZr04g
	 MCtFcESNzqqS20vHQVbE56W/7a0dZTxU5/fppCdbmF/bf1he/EG91L6+e624MCYrxw
	 l8tZQdcRuNj9+bA6H/gl/IbGjE0qbAYCNqJGqo1DDqvY+fZj0y+YfJ420+pTHnTNfo
	 knG5oixH6R4QN5NkbB/U2F/+VUN6jC4VC3NRRsfLE6mUCPzx6NqB1/G2kYpu6rkafK
	 U2DEbmOXrLurQFliH/NgpefGRm0eyglBRl6KEFIm7TxQ2c2BnreRsereFFScT585My
	 19xigSjs4Kz4g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670ef2b00002>; Wed, 16 Oct 2024 11:54:40 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9D1A413EE9B;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 9AB4F28247E; Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	markus.stockhausen@gmx.de
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
Date: Wed, 16 Oct 2024 11:54:33 +1300
Message-ID: <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670ef2b0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=8sy3EPFDi6gx0CG-VEIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add the SPI-NAND controller on the RTL9300 family of devices. This
supports serial/dual/quad data width and DMA for read/program
operations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4 & v5:
    - none
    Changes in v3:
    - drop wildcard rtl9300-snand compatible
    - drop clock-names
    Changes in v2:
    - Add clocks

 arch/mips/boot/dts/realtek/rtl930x.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts=
/realtek/rtl930x.dtsi
index f271940f82be..b01a40ec3064 100644
--- a/arch/mips/boot/dts/realtek/rtl930x.dtsi
+++ b/arch/mips/boot/dts/realtek/rtl930x.dtsi
@@ -32,6 +32,8 @@ lx_clk: clock-175mhz {
 };
=20
 &soc {
+	ranges =3D <0x0 0x18000000 0x20000>;
+
 	intc: interrupt-controller@3000 {
 		compatible =3D "realtek,rtl9300-intc", "realtek,rtl-intc";
 		reg =3D <0x3000 0x18>, <0x3018 0x18>;
@@ -59,6 +61,17 @@ timer0: timer@3200 {
 		interrupts =3D <7>, <8>, <9>, <10>, <11>;
 		clocks =3D <&lx_clk>;
 	};
+
+	snand: spi@1a400 {
+		compatible =3D "realtek,rtl9301-snand";
+		reg =3D <0x1a400 0x44>;
+		interrupt-parent =3D <&intc>;
+		interrupts =3D <19>;
+		clocks =3D <&lx_clk>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		status =3D "disabled";
+	};
 };
=20
 &uart0 {
--=20
2.47.0


