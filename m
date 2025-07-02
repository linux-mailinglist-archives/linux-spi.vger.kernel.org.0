Return-Path: <linux-spi+bounces-9005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEEAF617C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D78173580
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878672F5301;
	Wed,  2 Jul 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="GhLtnOfv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D4301135
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481568; cv=none; b=hbqKfRfAnGwKqeS82MttgCOcP+GhImWWghQyxZlI4m1AquSZRrmZMlQ5C5zA7a3mDhEp1RH9XVs5R5UnR1ZRfRRZWhdLD23ytUH8nJ9mx5EK+YAtTfnJF3ttHM/dPpttRVxG6ZJd6FP8cDG0BbHWihNR0kG/a2ZSDVY/FhPjrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481568; c=relaxed/simple;
	bh=pWc/eD8EhDRsDdlnhyulEE6WLssNw7EFTkXiniULJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9nbSBFCGBaVxgC3beHUTtH5YgJQWH1cDqOxqxK4VhmlESKHb5Hx8rcCgpgqkrIPGJBTezO0qsqtZp156sZRV9LKnTOFBJ/9JxvSqX8cikAL206uTEmox9HIGiCgQuIx26f7aJODPyb0D5dmpEriTLnCfmg0fyAX7W4zaQFk+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=GhLtnOfv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00easo58190215ad.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481566; x=1752086366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=GhLtnOfvNZLfbHR5QS+Vwm1vvaC+govuXOeE92Xd2wE32ADB1kD1rvcM662lwzHbC8
         Y76IljoRQYOoGp1vtFSBR5saKfQFJZuQ0t/YLBgGKGrlHdGWT8Ex1JTdIweJfXHDBLXu
         ntK7ktCyGWjYmkleXtsGQvvL5E06SOD8dw171T0JkWKzievyYLwRYKT4zr8M+Wdx7uiz
         wuv4Yi45xw8tlpHPoIOoi1raEyfn1rnVqymHt6caR3F4uH2h3o7iQLCxqgx6XqI4Qi5F
         S92xP1MEA884K2SySSyPsb3mvKWo2Jo/WgFG7NO+8VajzDCjzqCwDWJorr7ePoCIh1iC
         M6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481566; x=1752086366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=XIf5WAtdph5ADyRRSygr0rZJ32wDIXXLznda4UdL4rNX/Z97cDVk5oNLJBhrLbMpi1
         IEV14FGTnjoFl6umqigVM9l8M8HL2a5huoUu04MScuSEZuhfcpYiXcrylE+SrgTUsQos
         Ufql3RAPG1ti83wY8jiISZpkWEoaNVCQtELhunEjfreFgUrnv3iCqkvPJ3qgOgUG50u9
         QgG/VJjd90v9Oxrax52d89HWzf2nq+T/x4gqi2s0ZoH5BO1McPV50DmR9m1XkFiJGY4A
         kOgt7BzsIHTuj962Wcz0JuSN1YhKsEW2k7ikWkTcaqguSoy9XX7h14pZTCp3jRGUcm1V
         iLhA==
X-Forwarded-Encrypted: i=1; AJvYcCW/tgFN3NrZwi1TSiUS2SYPwmzdpdwR93kGhE1UWsQHRbddbHGFs2cWRcaR0NHbquG6+ABzbn+3ycI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjPemc9KCF2owXtLMZw4PDVDm/mkKR0g91jtUMViccdWTh+Xf
	EMI2Nor8LYOPf4Hk0u0W9DKl/Yzjq7IxzX/LU6WQcFTkFd39/2V3f/HWbVFY0mZfEDI=
X-Gm-Gg: ASbGnctUwm2670P2t1abpUkfm4OVOOIXYy3g7GiULoa2Dl29tedsXEHRYk7K2szYoRx
	UutOv5s3l8MaQEw8P5OJV+NWChtb4AteK1aS2sjFmaFKwkMbGQNvvxhYR5HkalfdXkgzg59aPaP
	4KACYkpkiHQQPfoJrGmyz5Q8eih/mbc8aBEtN5xAaNCcZ07b0vUlfx8qCj57f3pLee9hG7qehak
	62B02/56h6F7eIn3DF4NG/6DUu1SSQrhPbVjTP2bZdWu/XOpOBwmRhBVItfXJlXZ/BY7fTfLJWK
	3Gvo7d9G3CPqmj97fkX+U4KqzuuVdV39s5B7A9D9YFw5bCqqtxqVZl2sozIGwgLe+q4cpx8AUK8
	wv8uXmqXGnk7TnJqb/ZXyNyA=
X-Google-Smtp-Source: AGHT+IHRiK65iyeejNhxV2BsQ0zei81m23wsBqj5xXwWoUN5V5PxEC+r38Kfp0CXgbxe6/9g9H5UFg==
X-Received: by 2002:a17:903:46cf:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23c79692071mr5155225ad.29.1751481565983;
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
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
Subject: [PATCH v8 02/10] ARM: at91: select ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:00 +0200
Message-ID: <20250702183856.1727275-3-robert.marko@sartura.hr>
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

Like with the ARM64 Microchip platforms, lets add a generic ARCH_MICROCHIP
symbol and select it so that drivers that are reused for multiple product
generation or lines, can just depend on it instead of adding each SoC
symbol as their dependencies.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-at91/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04bd91c72521..c5ef27e3cd8f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config ARCH_MICROCHIP
+	bool
+
 menuconfig ARCH_AT91
 	bool "AT91/Microchip SoCs"
 	depends on (CPU_LITTLE_ENDIAN && (ARCH_MULTI_V4T || ARCH_MULTI_V5)) || \
@@ -8,6 +11,7 @@ menuconfig ARCH_AT91
 	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
+	select ARCH_MICROCHIP
 
 if ARCH_AT91
 config SOC_SAMV7
-- 
2.50.0


