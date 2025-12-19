Return-Path: <linux-spi+bounces-12042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F3CD19F1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E4D130475D5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06709340A4D;
	Fri, 19 Dec 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M/3jeLfs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808E341645;
	Fri, 19 Dec 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172221; cv=none; b=Sfap4NL6Utv8SChUpz/dRkmeprN7Ol2Jfv6EFXVa1ZqtmvynpMeCQ8O7v0GxvGd1hUNU4HKB9eOP27M/YSv8lenLuI8PvvUE63oFP+M8bx8StNtct/jWfUHn2LxxeNV06VzIcnUbzOAsjNj+4/wgLQQ36jgRIjXQtfA/OWewgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172221; c=relaxed/simple;
	bh=P0oCxfjKcbTdXTynhII6+JbewiJeFDfz/e88uzcC+GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruIFeQ6ukAgX9TDq54MEJp9lDNi3a4IIQ1jXjFy2SH9M1m5aUlFTZ8cTnEg7lPZWYu9ZMsXdF7mydoS4244CMSSllpJW8uOw0u6eK5ZwPlqlF9Fjs2aBcjPGwQAaEtON9L0Kv7FqqOKompZXl0A2+mFWJgcC3ADCkdTAmLEDCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M/3jeLfs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 250204E40B7D;
	Fri, 19 Dec 2025 19:23:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF6F66071D;
	Fri, 19 Dec 2025 19:23:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7CFF102F0CDA;
	Fri, 19 Dec 2025 20:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vrDLpxHj859p8IRaJPL2VCFLfV/CO+dPXle53aPPG2k=;
	b=M/3jeLfso9QC3scrnbpbpxrwsUmwSgQLUO3qFkUgkza6vUkUB0aBGLOx3WGy3ZxGK7pxne
	4pKPRfjPP+b4FpoJG4HQMbSf+mD3EOLlFW3z5EOUrinJprCaFTWIjlV93akavKxIGKFom8
	0vEuUzUmqU6FrmJDSq0XUckPcOjjH0kppt9p7YmxMgCeoeYKKGaxof5DE0Pn+eOe6a0gi/
	IMGQt2Jy4MuTvntv24zhYq6W1+n0k1muwsc6c6flFXlxoM/oJWUJfh+XNfeyG/mg8VUS0V
	YhwRep+emxIZ1mWpObXwRXXQ6eJEhQSoWstNMYS8sIvdfIuXi5i9C86JKdek5w==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:15 +0100
Subject: [PATCH 13/13] ARM: dts: r9a06g032: Describe the QSPI controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-13-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a node describing the QSPI controller.
There are 2 clocks feeding this controller:
- one for the reference clock
- one that feeds both the ahb and the apb interfaces
As the binding expect either the ref clock, or all three (ref, ahb and
apb) clocks, it makes sense to provide the same clock twice.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index 8debb77803bb..a6f4670f5c45 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -66,6 +66,20 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		qspi0: spi@40005000 {
+			compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi", "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
+				 <&sysctrl R9A06G032_HCLK_QSPI0>;
+			clock-names = "ref", "ahb", "apb";
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0>;
+			status = "disabled";
+		};
+
 		rtc0: rtc@40006000 {
 			compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
 			reg = <0x40006000 0x1000>;

-- 
2.51.1


