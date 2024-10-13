Return-Path: <linux-spi+bounces-5218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A299BC9D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 00:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92F91F21367
	for <lists+linux-spi@lfdr.de>; Sun, 13 Oct 2024 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F91537AA;
	Sun, 13 Oct 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VRBuzzWh"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3914AD3D
	for <linux-spi@vger.kernel.org>; Sun, 13 Oct 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728859154; cv=none; b=RODf93dxUhkTPG6gCC4G6vJB2RkIHSzLnsIYb6We0gC6CdaaBXu6sfQEOM8xxg8NJEzQQZN7VFU6eRS4H0zPzdA3plgHsRDc6VsrAohc5yo9GqMq8J/a75V7vcLjmbGYKeHw09nJfphN24+aoWum1+CwqJA3rPPbpzyhgOC/oAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728859154; c=relaxed/simple;
	bh=mFeyav5QddduTYIUvFeiLPSQs1Gt0Ly4xwRgt5dqZqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l14IYRQMEnYmQwcTjJC7mJ2C7UoVwgUVTriYU65PKJe4tQz9kTGSHTcACmOI3BL3Z4nhlZ6TYnm7gOEjNBnCXybri9jLnFqgmTWW4vBDtQbSX32pFpVfZOtd+ZhKLTZqQ/34M9V4jfyx0gBAgClgIjGGqJK6NnBmxUVmEMHb18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=VRBuzzWh; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D47D42C06BA;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728859149;
	bh=cqj3hdXBlO1Y2UUkU9a3psR9aKY4yQajoN2+PShqqVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRBuzzWhhq1IgTP5sF8UDnDg16wbrJforWQv/hVUljXF1XggFwghJWc7+zN4zPzw+
	 mocDggnX0sfWIuggstGKx6DQcUyDrmOUbhnBv5na7bOYCMLF4YTr3rBvj18yIaM9+d
	 7FW+PrKeM2h0vutJhjck7tToGC/HHVstikY2Tft88DRXJVW6BMrJ1fHWsi/LJEjKr5
	 uCzyohKcbhtOhscBmBjkWbc0P2VEKAZVsjtCs7RXFDHeKppM3PWlp6iw+J1lqKrtAp
	 qHbR7m6dXvkC9Id6FIZ8gqbn2gxy0P1D984zLXnSJIdcnORu425b6cUKDOJoGNQzxF
	 0MGRi7gvB87cw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c4c0d0002>; Mon, 14 Oct 2024 11:39:09 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8525F13EE9B;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 831B6280456; Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
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
Subject: [PATCH v3 2/3] mips: dts: realtek: Add SPI NAND controller
Date: Mon, 14 Oct 2024 11:39:06 +1300
Message-ID: <20241013223907.2459099-3-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c4c0d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=8sy3EPFDi6gx0CG-VEIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add the SPI-NAND controller on the RTL9300 family of devices. This
supports serial/dual/quad data width and DMA for read/program
operations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
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


