Return-Path: <linux-spi+bounces-9389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A17B2527B
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF166263AC
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C51D63C5;
	Wed, 13 Aug 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lsWU4LcE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F128C84A
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107260; cv=none; b=AQdsCyT34QMaCBIPuwQU+4peGxw9WTrftPmDc7GmHE2uMLhjNu93wKfm761C7JRAaZKISaXn24030PppOsqxvzZ2A1MDeQGE2ZWbqquGz/6Qp+5qgwiL2GufDSgzrEoY+4yV+MC0MRcgKebxurc99kaejR9/yaexCESnxkfI+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107260; c=relaxed/simple;
	bh=nisRlxMdlxNBw0kJu7miBzfQrgmKYtOuzeITlICZH2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KluV93Pg8lp4ww4pUXJlZVR6B9lPXmNdWfH5kA18kqkIMu4p63v77iiVHEj+VA4KpiMgXuvRlWhJK3gwuZ2q6wljov3KJyUzmZMwUMHBxJrveFiGtY72bH9PZb7IS6bp3sLmR5zoDEuzqNkDopMtnkNfBNEWX6L6ntPxB/tNDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lsWU4LcE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8705415ceso7839685a.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107256; x=1755712056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB7OCoBKq4sEt4VQQvcl3aOmJkQhrsxuhQkNyl7xRNw=;
        b=lsWU4LcE3tyz9SS0aasoM8PuG4+iIDidI4UAAow4D6K8+3iib4hXh/PfQMrkCbMBsx
         +VWHz2piy4F/K8zOyjL4PPSM4PjBH+GjokhrvzXGXAwzKO8L+SYo14Q++jSH2/VRrcj/
         M8JZjQ94RAqmJYpgNa5PM3SJk1T36V/MGjqI6cmX6rW/0c3dpWZdJXILFAxP7xSdf5RR
         ZbusLUke962yAgHFgcn8oMTQN4gJ5znPcja1IwgGVpedcTFKICuk7SyUCrXDKXAbF0yK
         oVEK3IDXKt+mjqBe/V0rUkzY2n/TUkDiYbgjQhUQmYlqX6k1Qm86jIbzW5Y1yNBDgQYr
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107256; x=1755712056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB7OCoBKq4sEt4VQQvcl3aOmJkQhrsxuhQkNyl7xRNw=;
        b=ghpYSrbF9XImgaQyu/pxzEw7pPz5eH1W1jxBcf/8mFnv5i/Nk7B9aFUXktJcp69lV6
         zeM2P+4FoiOolAmGshD5btUofKMVNfArvG4Mm8jkE7xK1ZI8XQkE4xUWo5LHaOm8GP/n
         k+YOfq05S4T88KKckSzq3L8YnJeV/1g0Tq0wwodAqfo5pxSxEdJJg1uyxrUVMs8jj6bd
         0bf2uYb/niN413LdXoaqixmC7M3Csv/jQkMwn661f+bQWdyYRuoTT75sKGkK2uK5745r
         b46npxCWR+CZzgAkAvKtpug1nhcIT45WR9Wsaj6SynFHoa9C2AynSfzfUqak7bcscUpA
         pYsA==
X-Forwarded-Encrypted: i=1; AJvYcCWATO5MIr+N+xZN37GZ5F79Iml1/s4Ba6vq8mrtwsf1YOM8zYI30myWYduq28XrAprmkM+thOE2qxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYj9GnL7JY0KZoTQs1i6nEUG4YUAHYEUj629/vITNKzTsU1FnJ
	pMyqpb2As7Fl6vFxI3w+yDhaDRPiREaTOfZ8NzMEK1dGtOwqnUdXQx5c1GaXAR4Xm00=
X-Gm-Gg: ASbGncvJhv2hSVVvyWHXvCwHYxItOg3eTu48xOQCaz64JEdbF4uZwYi6sbPwSvhrQbb
	sTEJ7Yhb0tEcGRmTpf3OO6xUUP1x/FSxcBwx84GxvkejZ/u2JnNKfRqtnWq7l3DNSwYv3zka1vM
	zD65G4oi/Ti8ampxpci7klEK7hoWILUta9GJRihZdoXeaBBA9IePSPB5vgG5xLpIlFx2N5rom6R
	/4mVStqFiBlcKA0hJ7hlf2N4IURSyBTsTP/0NmUCwnkhPVhE/DGYZaXUyiQanZ9cSbXXVR6A7us
	rJ8Lu70x2UsLIIkFWHnPG825XaFIp63PIJxtrtzyjh+8+IjB+gTwhzWL9rFpzLe6cPWWymjcp/W
	iyoYI6pDrpQiuw3QF/gK0n1s3dChFNXZ1W5v2z/8qkw==
X-Google-Smtp-Source: AGHT+IEToP13G1zvLikrKvReC+w/kXfMQkt8g35fYQ5sGrJ+PpG+DgIXPbBl9bQ7Qc9/37ctzeq7lQ==
X-Received: by 2002:a05:620a:5e14:b0:7d4:4a26:4065 with SMTP id af79cd13be357-7e870496376mr26868585a.58.1755107255712;
        Wed, 13 Aug 2025 10:47:35 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:35 -0700 (PDT)
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
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 1/9] arm64: Add config for Microchip SoC platforms
Date: Wed, 13 Aug 2025 19:44:37 +0200
Message-ID: <20250813174720.540015-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
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
Changes in v9:
* Make ARCH_MICROCHIP hidden symbol that is selected by SparX-5 directly,
this avoids breaking existing configs with ARCH_SPARX5

 arch/arm64/Kconfig.platforms | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a88f5ad9328c..bfea380100a6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -131,20 +131,6 @@ config ARCH_EXYNOS
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
@@ -186,6 +172,28 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+menu "Microchip SoC support"
+
+config ARCH_MICROCHIP
+	bool
+
+config ARCH_SPARX5
+	bool "Microchip Sparx5 SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	select ARCH_MICROCHIP
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
+endmenu
+
 config ARCH_MMP
 	bool "Marvell MMP SoC Family"
 	select PINCTRL
-- 
2.50.1


