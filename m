Return-Path: <linux-spi+bounces-9004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A0AF6174
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F425179DD0
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C892F50A2;
	Wed,  2 Jul 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Bn0x1cDx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C8315508
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481561; cv=none; b=U7qnsCv42op5Z1Nix8vePWEFoQaVQWcAnKUTo0wBa34/PRwb4AYeFNm0ZXRm9HnRgMsg5BPBFlFCZC9jeKyDxzdoUxz98GE4OSH+9C7rI5rv0ReU+X0YrVfoTsBJ6Dy4uIrsk6xN5i7LbjFQyqdKa5Nk1NmlCUE39eqQ8+tNgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481561; c=relaxed/simple;
	bh=tW7URZQhTrd/hdL2o5zWTneayhc03kpXskiuPVh90E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpme8Om+tzkdLPMcMci294mIps/kLMHCHomDiCEpSya1ja4ZsXOn1se7WvEu1zDablL93YNZoGFC80Ah5FeMh98Tz/G20S3kc2IqdetJuuj5aRHKQ9vLyO4manJlicgzQmeYgihIGsakmEEXdiqDeGKBIx6/UCtrUbYa5Mdg0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Bn0x1cDx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235f9e87f78so49253115ad.2
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481559; x=1752086359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31LeQoPU5Tg6LIkWzfs/F/Xva89TsnkgnR1vxDISxQ=;
        b=Bn0x1cDxkzNZ3yMlNr80ct/PezqcXXpfItvYdING9ImrNE54igkwtZOReT7iHnHD/f
         85YLaxH2sDZffo3xGF82Vg4Y1CQFgw1q5iV9ZRiJxSxSrzINinChHg7f0XTzWVWrYCwR
         koohqbkRup3DfHZYQENTJtMIfTHwUnDhEswXqavLJt8ilt5d8G64skyehxlvpZCgqvVB
         TAX/RL/FRr/TQCE1m59oUxgmRrVZPHD2SHfIaFLm3G41GbqAoWMtq8l5VysU23eIjczv
         jdgfPNAbl7AmYQ/kwloBtR8ljEEnUMPDXNnBhTrC/HcQPYWAsoHOT3HBMvkoSR4JUBGc
         207Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481559; x=1752086359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q31LeQoPU5Tg6LIkWzfs/F/Xva89TsnkgnR1vxDISxQ=;
        b=DgAVNMuFMcO3VwJepUO4yRm0sjVBRkq94gAV6Tw4V9Zy2y/mQx1z7J4oNM9b6iP912
         /y13Td5iPEwkSSgm5YMpz52M+QcGmU4tQG2K4iz1caWhQc7QYceqr6nouJkofMhh7ewq
         xCzrIfeNp9yKIvISyAnCjCjGNsFiRocKoaFd8umxhHLW9ZY+3emL75rOhQT63o8YMjp5
         r21yWRmpew7si9JzdAJRK0VNEdzpFT12IpJigeawJt1xL5MBnRyoc7Bq7vufKnIyV171
         +foKdQpHskx6j9x+YCtNP2Rp7eg0tGOWJcypu4l4+NZTYEJtlgi/sKOg/2mqwQ7PNgU2
         g+xg==
X-Forwarded-Encrypted: i=1; AJvYcCWqdgaSZDT0Nm71GBGzqlPGf8cEOYJc6WcvJiQxRGwO96kNfX+6aTXXwc9jvyRDHCsFQiU4OAtVI/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjJ3p0BYV3x9c/BLStdllSsFeP7M+s+KUoVSfcqH6EOIUT5ox
	eNNd9D8pWkv10vg35MC9CI2g5B7/04MhAnCqjAjXlfesuahAgwLIgTrCYpElz83kxRc=
X-Gm-Gg: ASbGncvKIyNybbsIa6KRoOhmAOlXaoX5IZ9qmEyf3/svOmkrMaEDbXgxQ/7qsiUklEo
	HH2Czkv+kAjyrrGJSb1FmCRX3rVuE8QHdyncPfs9RCQpVOjtTdWhwLf2vqVUbmoUGeAoA8sJjgs
	8ww8yqTYc/JxlacmbUYG2H3pf0LISfIDKhK0/GYrjzgwQ+c+Co7cAd1OUX4w3eXocwS1XRVabtI
	ctCtxh6MN55bqCQMSspblPkMyXOJzBcRq8GQGDkKlzWH8rJqIBS5NFsi39PXj5mYfyYRCajyHnw
	TvhVp6hBwj0DlxOaQhr+glK5Us8/S4i1CEuof5hfx25fIjPh8xVJTEyZx5ofnltE6qNuRuXHvGB
	p4um11wGP5xpWHDw43Q93YGU=
X-Google-Smtp-Source: AGHT+IG8v0jcBzSkhpF+tlpiIqvrqXtsy8Ix2HiJIAVnZ48c1CRxrkpXzqoHja1AlwcLL8cW97LJSQ==
X-Received: by 2002:a17:903:f90:b0:235:ea29:28da with SMTP id d9443c01a7336-23c7963ede5mr5982695ad.17.1751481559247;
        Wed, 02 Jul 2025 11:39:19 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:18 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 01/10] arm64: Add config for Microchip SoC platforms
Date: Wed,  2 Jul 2025 20:35:59 +0200
Message-ID: <20250702183856.1727275-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, Microchip SparX-5 SoC is supported and it has its own symbol.

However, this means that new Microchip platforms that share drivers need
to constantly keep updating depends on various drivers.

So, to try and reduce this lets add ARCH_MICROCHIP symbol that drivers
could instead depend on.

LAN969x is being worked on and it will be added under ARCH_MICROCHIP.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/Kconfig.platforms | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fc353dab2cf6..f2d5d7af89bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -119,20 +119,6 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
-config ARCH_SPARX5
-	bool "Microchip Sparx5 SoC family"
-	select PINCTRL
-	select DW_APB_TIMER_OF
-	help
-	  This enables support for the Microchip Sparx5 ARMv8-based
-	  SoC family of TSN-capable gigabit switches.
-
-	  The SparX-5 Ethernet switch family provides a rich set of
-	  switching features such as advanced TCAM-based VLAN and QoS
-	  processing enabling delivery of differentiated services, and
-	  security through TCAM-based frame processing using versatile
-	  content aware processor (VCAP).
-
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select SOC_TI
@@ -174,6 +160,27 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+menuconfig ARCH_MICROCHIP
+	bool "Microchip SoC support"
+
+if ARCH_MICROCHIP
+
+config ARCH_SPARX5
+	bool "Microchip Sparx5 SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip Sparx5 ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The SparX-5 Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
+endif
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
-- 
2.50.0


