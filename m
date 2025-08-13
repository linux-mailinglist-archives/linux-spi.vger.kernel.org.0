Return-Path: <linux-spi+bounces-9395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A3B25288
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5C887343
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AA29E118;
	Wed, 13 Aug 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JNF06wX6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68429E0F0
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107282; cv=none; b=u93O4/uXZYJBdWAOmW5T4dlPgDzsDG92yb1Hw88hcMK8omNA1e0ZqeyJrBUcJCDDfqAPvX8ejiPsoARwFhHNpkF734ra37Iaj9SbNmcxIpScKK+MJwFZsbwhdtIRhtyInAJRLm47Dlu3r7A1w8crr3X3CL+nsiQ0YDRIo/kFINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107282; c=relaxed/simple;
	bh=ONd4Qs9MdmtR2emzr2R9EQwalmRVkxN82kEJbRPVoKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOh7BP5PrjqAX0r1kH4CpVBu/tIht8d+YYfSqe9VN1P8Nt8oZ3HjmgqZ8wMQKlbL4wY8n4t4kRh799tqMQMugR7Zl0xc7+mXUJsxHwXNClgPID7647WzFNVFxJiE7xQvBh9UacnFYo/VDqONlB5HXTO6XaQ/IkB6KtewEqJbz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JNF06wX6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e870636870so6403185a.2
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107280; x=1755712080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=JNF06wX6gz39a09M7XuaKCZW3/otWAO4pMw9c0PAncCcsbSayAeyfWFwUmKsOnYlAG
         v3gtNyeV8KSFPs1YjW8t0Ky1f3IVP1iQ5rcvbHy/YlecSDNZebO6QsfatVp6vFJKViXh
         fSmyyXZxUOJhjs/R3cH1YwlxmtTbQa8ThKI3UHXri7lpI1mAOIch3Mhv/QkL4f3hvN76
         R+Rp5rmnr1ThB6h7iTevYKSp/MSwsd5bwBBBt9OOuvRjqYFAVUNUqU/C5DXypohSERtx
         /4uzV8DzmpfHf4M9cJLlzhvDGormIM+qeyluC6jXzuVLzpHHBdzU8hveYSKEt4htd9Gt
         naYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107280; x=1755712080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=OEAJED+9Tt7c1hcuErkkWPr1tk4IDHesB8H2EcvbyqYu5X3g6k4AEt/qPQNw8i3inA
         Z4LGCXQ3dYLnumpwz3gtqIMiVI/tN6uprMt0IaX44o9tPusIVR+ShfEOjOQsmm2pJhnD
         9I3GY9B3cNKslrKaqer9gPZd/2znqC36gL3Vja5BAt6SYHwXydWv3D/SMizE0WrAx3VR
         5DjqlWmYx2hat1ZKwuBm1BCSFa08dPSSCnGWERK6SLhiAqUDbvdRdW2Wr0puQA6GXq5Q
         hk6e4AdJObWBgM5S1FUqznZIa6BeBQDSTNwSojQzOqfr4ZjS1crYbsF+2Kuam8lKF/mD
         Kgqw==
X-Forwarded-Encrypted: i=1; AJvYcCXL+s8IpWl3J2LQE9X/yF949WA54Tv+UMFPqqxNdws6QWPTOjmboda6suiW1vJIDQyqSDJjM6LxFPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsNMCgEH0bDv7lhdyaDpFCifrJdIXf+eGezNqoetQKyj9bBuv
	VsAM7v3B9lmsmFNxInKivyEh51v5vpQ64axBlQLZEVdzDAZ2ogm+ZXZsHxv+27iUUzk=
X-Gm-Gg: ASbGncstIDGrcrOoxL8JITIYOX9fjkeyLFDY8s5MVviNGIpniysATh5Ul1gWsYG7blq
	ieNDPUzXGohrVpnHaTUe/AfUsjB+9vcWZ8H7ue80xxqwBQKlO2D/q6yjzC2dNqAjiPsYQht51U0
	ZTAXJll1RkltqHGEg0E/5t5bhTQWaDTvTT7cB5eSfucmAWZTP3v2Fq+mmt9eJG7dvzOIGTF8UFp
	DLTqV488jEIbV6Ae0J9fK8SQLPbWenz6F+mwUUUNMKK3Rdm04jJwjF85bta1AfauEfDvIkieVmx
	lYBcJ9Was9VvUAHj8flUV1fZIz/C+TzZZPkOMNrmdb7rdxH4+qx+ByRsyIep670iTfnZPrfOQef
	ukASguXqSPY2QRCObqutIrqGyv1lNXu/+S0cT8tpdLA==
X-Google-Smtp-Source: AGHT+IG/snJ5W/RG0E/erOkIvUu/WH4PIM7qXx4xAitymXiD3NRL3HZn1ijMkWxa/MDJZoHs07TE8A==
X-Received: by 2002:a05:620a:270b:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e87041fe25mr33631785a.16.1755107280240;
        Wed, 13 Aug 2025 10:48:00 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:59 -0700 (PDT)
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
Subject: [PATCH v9 7/9] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:43 +0200
Message-ID: <20250813174720.540015-8-robert.marko@sartura.hr>
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

LAN969x uses the Atmel TWI I2C, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 070d014fdc5d..c0aea0920f61 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -414,7 +414,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.50.1


