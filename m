Return-Path: <linux-spi+bounces-9013-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97177AF61B4
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63D64E2AC3
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7872F7CFC;
	Wed,  2 Jul 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bpKlO2zr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2712F7CE4
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481623; cv=none; b=ExETMbsCxKdnFLzGcm+j+QkD96bnX2O4tECHNu/Aswx6lvBkzwBCuhay1HvKSRmtEbanMp9w1O02Gedk11HEX45U6bPNBIPUk5NX2gsoy/ve8Pi8SfmLhlHcuXAdqlMuZGgTK6bsq8PK6l9UWK/ME42TVr+SWhClqecTGJW4keA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481623; c=relaxed/simple;
	bh=uR10k/MNsD2KTqxwxNLmNVi+dmMLfNBNQQvEqJsmDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZccIBIugJ78L+Eew0XU81GKpj6AMcbFP/YRYeIwsspO/B0BTe/kPUop8VYTv343W6NOLMvmD1uJKtIWlnWhMKKpcQCZys1a65uKFsD3DVYImP9qBfXAgpnOEoSgPMVPWUGuRQld680HQjXznarvfZkKUx4vqoHXrLNsb/yJAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bpKlO2zr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so45084705ad.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481620; x=1752086420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbnTNMFdG2kGnp4zBFs5MgPMup5zL0Zfe8VUfuWUBv8=;
        b=bpKlO2zreZ4Dw49+XpbddUTu/s8vYAQrprCuWs4FMzPVmKsaPdOuGCsWR7P1CqUmbg
         aQXF8g30FFZD5HNZyapB4pHSUbOyYpShNABIOSJeF7xGeUWbj4AX/3ZV1HDR54SHW6Rb
         Z3I2jzQ9kzZ7gNPHpWswVYvPn+vp4X6sGWtxGhoDSfhtEvRs+TdGQdFYGEl399uTOuM9
         q4F0gD+M1bd1ywcOJgEP3AkYT573RvKvzsJjjUXed9oHnxqOHG3qpQ6WfelMU9UwhLBc
         5m0gvn/DJ+suKGPTJMvaf7teqS/TEBabuLP2Y/uTeE7cMjkuNPOo6sGA8HYDgDcceTdF
         kQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481620; x=1752086420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbnTNMFdG2kGnp4zBFs5MgPMup5zL0Zfe8VUfuWUBv8=;
        b=Rpk2NcfsPwDDyBMiaIhxBh75weoAVqqoe+jcmGnBpaCowCE+TgIAeX4RAEeNJBVuzV
         m9ifKFdC2fYAgV9KC6a6OUrLVHE4JMitpsi0tPyexLInlzCUqKUdOjQMbMEzbdbJUEQz
         0WoQmmW4+F4uoFYE5AmfftM6NDrUr0KQ5lj5J8I8/5sWqrEgZUzFMjvrmbMVeWCeVypQ
         5rp9NaNWw6YpBzAL5R1bZPZThPc712PIXbTK6MXJ3MPKB5288hISRYUOCOKRDgsINgoP
         fIEhLAh9kbOlksVL6VBqP4nMzpkCAPnQ0X0fYDmNXBkYzTx7fHlJjRJ0mNyfSPKNoZtj
         ZKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXjcsYUKOyw1rd6O7/UVfhn7jomrkgyiTT29nsGfTHSBCbLivq9WxdTCmd+8hom5aHE0KLG3f0GP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIswG+YLlkfuFdDC2JbDDgea9c0aclKVv2tBXuHjx/qS+HsjA
	gdIbe4e1avZeE7vGKbbC5kvHKr7rreBDe9mN7APWqI1EjtyMPRGWLVoLw5+R5w+TOxM=
X-Gm-Gg: ASbGnctBU3RQSF67r9/m/SkFULitTMMzbtKbYvz9OE5HwUKmpp9toHA2L25cUT+Bde4
	ZJSjRzQtbUi3LRXSOG+qw/A3xw6ujfPApjjI8TqxnLUZMxt/2nHUcZTM4mHc/2cMQ/SxT1kaGyZ
	BX1qxxItUkLbncjqTAtXKilG2FNtGJkf4oP52ATzHYr5YBAEvs80QCL8JlJybKlMq3280Y0fhAd
	CHtHRRZZ8mJHIi22XJHqd4BYlc9Gvc2rkQOzdbeoJuV3co9n7k2+j1ossYGCBq0RS3UcwZ8BD0b
	AW9zosu/Jb3UqfhlqIMw4xcl2dC1NQuEkrskxgl6dr4ldPIWej51JvMhWFEf8eHNbjeAjP64iQI
	YCJ9bGsXNb1/xxbII86O2IVI=
X-Google-Smtp-Source: AGHT+IG4Ha6X6nXWuDRiiAtD/IybzMavhr6X2melJ3MACMJlG77wfbwOcD6VvpmvkGPoSxTpUxzwhg==
X-Received: by 2002:a17:902:e751:b0:235:2403:77c7 with SMTP id d9443c01a7336-23c797b92e4mr4443315ad.37.1751481620268;
        Wed, 02 Jul 2025 11:40:20 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:40:19 -0700 (PDT)
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
Subject: [PATCH v8 10/10] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:08 +0200
Message-ID: <20250702183856.1727275-11-robert.marko@sartura.hr>
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

LAN969x uses the Atmel crypto, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..7c1717c35b76 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -439,7 +439,7 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-- 
2.50.0


