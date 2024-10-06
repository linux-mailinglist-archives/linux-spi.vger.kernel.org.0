Return-Path: <linux-spi+bounces-5114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941299224C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DC1B20FFB
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8518BC31;
	Sun,  6 Oct 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="p7hqd6dt"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193416F908
	for <linux-spi@vger.kernel.org>; Sun,  6 Oct 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257636; cv=none; b=FEpJgODkmIbRD+rEVAQiJa5F0N6eee4BGS7+7PzK59QgVC3MsaS0umRHGwfBcCW7T1o2CvCu4O32iZetb1gZgUn9iI7sIUBu/keeGH9dqW3msBrBhcpa83ENn6mCfHprXEUrj4Pa7rZqnTA8jptZxjquWOlVO7Rc0Dc+XQ1vbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257636; c=relaxed/simple;
	bh=suy/TciQ5F4yGeGmpv38NTqyGqkAx+AXpwzelfsiJs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqmOmL8C469lQAzX67IQ1XSxVUVuRGaY7yzBlgdv4lvgE6nTrldiCcV7leGbkorxK9eZAOMRTZdor5yiqfcuvVsatjpQUovbS9eO5okyCOSTWmTyl0eAIQAyezX+e64rbPwpvfe2+4opgdwNhZLQscAVrelPhGrlhzOJNeg2W8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=p7hqd6dt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 081F42C06BE;
	Mon,  7 Oct 2024 12:33:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728257632;
	bh=NLl4vFdgyWu/Kevg/F09IZgtqafcPxFw/5wOVDaZduk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7hqd6dtMxR3rIBW054w6W+kkAUSeJmcNw4LedE77IA9w+UWwwYB7pht27OMdQsnZ
	 3uNwjuZ6QZN3ZYolRvr+jkSZYb3IaoN9Dwmt8lj+3lPtYlkh+pkofFCDHkNTTR8HvE
	 U3Mp7sXzjPK/a0JGHi4g81JbMrBWslAHiQwXAvkl+jmRw4k65ZUr0FNnrxm5mUdEzd
	 QHOP99huYy72rTWi0lsw9/9YrnRRltgVmY1RQG//gVJ62xDg9EgrxWExr7CSbTaEIX
	 NWu5nJ5wdgx5agjDW1CTV7au84DGCHY1PYCXGpSE3S9fdbzDTh2yKcNprA8xGVww4u
	 MbBs5ZTfpuzmw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67031e5f0002>; Mon, 07 Oct 2024 12:33:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B727813EE9B;
	Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id B9C16280442; Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
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
Subject: [PATCH 2/3] mips: dts: realtek: Add SPI NAND controller
Date: Mon,  7 Oct 2024 12:33:46 +1300
Message-ID: <20241006233347.333586-3-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67031e5f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=8sy3EPFDi6gx0CG-VEIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add the SPI-NAND controller on the RTL9300 family of devices. This
supports serial/dual/quad data width and DMA for read/program
operations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/mips/boot/dts/realtek/rtl930x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts=
/realtek/rtl930x.dtsi
index f271940f82be..aab1823139e1 100644
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
@@ -59,6 +61,16 @@ timer0: timer@3200 {
 		interrupts =3D <7>, <8>, <9>, <10>, <11>;
 		clocks =3D <&lx_clk>;
 	};
+
+	snand: spi@1a400 {
+		compatible =3D "realtek,rtl9302c-snand", "realtek,rtl9300-snand";
+		reg =3D <0x1a400 0x44>;
+		interrupt-parent =3D <&intc>;
+		interrupts =3D <19>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		status =3D "disabled";
+	};
 };
=20
 &uart0 {
--=20
2.46.2


