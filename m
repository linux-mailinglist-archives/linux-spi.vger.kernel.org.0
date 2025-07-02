Return-Path: <linux-spi+bounces-9007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F207AAF618C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E11C28401
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6F2BE642;
	Wed,  2 Jul 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lNxRuD3y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBB2BE622
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481583; cv=none; b=um92qDP/oRBki6mO36CB7arN8g90bHizLQKyoK1Te/tx7l0eqJhYHSelPAPn95vl4WIYdWca6XlQ8WBEmLleSmtzNmOf6UND15Mzq5oj8gKERiBUlJFO2Hyvtdjhznk8e+sSLMzE8hzyGBoT7K91tN3G2fCmCXf/lsPIaH6LbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481583; c=relaxed/simple;
	bh=oaGmzUZUXJWd6raW4UkBJCtJB/M94OwXRkxkbmWDquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US+ijGU4qaM2In5bBibBBvt60pzxC4RYPvrriRVJboHKq8icJSwbZDxbwwyqhUcTWV5CKCjHHwrApyjW6P9FyFjRZxvDxRbIouE/m42J9d2bdoNq4qsw9zghZ/mAnwFyLFjmy+nU6UF9j0m11scCT4ulFFnBW8Yt4CKQ7m9pq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lNxRuD3y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33677183so63014765ad.2
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481579; x=1752086379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKtbK/2WRQ+wXXbB4rZi2px+YsVtXfxGP3mE8Odmzx4=;
        b=lNxRuD3yBHUYnLAht+u0unHI3QeT9wuRbR6j22Z8+QsYiDExKq3z+lSq5Sacv9xjj0
         M5G46it8COb7NHT+BFekYkiDIHKl8tcROIpLQsM94Mxn8fQw/TLrBAq+Bk3oISHBke/r
         Yjmm0pbmdND0bIZietxF7HbBc/JxpuaUQRQhGE17lnhXMpnVTtXt6dl7w8QZoXjE0Dnu
         FmAOGCGf7A8nGM7qP1G0NU6d7Fimf8yF+7cGj8WML10aVvtWsjvzAAFkvl1DQnLClmkP
         ApL/n7WMvqOuRgBCTaAQmpYUgHGfGRBf6lAszdtVSK5X7x3OZUdRCiGXvg6gwkQefyoT
         x3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481579; x=1752086379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKtbK/2WRQ+wXXbB4rZi2px+YsVtXfxGP3mE8Odmzx4=;
        b=v2varaT6CGikG5FFTdyW+xx+8Hz9ICz+JBaIQ0m0tXfk5rzX9IXR361sUc+tEHZfb2
         Pasijy/RT7TIFWzlwk2/zbscD1nDCD+/KrVLoUZ1dZMFgZUEkKpbrFN9/haYKjeZylju
         cwGyqj98DuqCl5slK/MECigJ4SijkXTEHNdrJr0jvDLtS6myyBjNxazIIbcUeOnTLUK0
         t+kq36G2X+aTscxEuVmbRjFETsFk+mQT/ZZMRMAasPcn6ysKgBUvCXTw7UzDFSVPe2Ya
         EU/1/oxUQlV6yU3RvXbK8g5Fv6NXz4NxQ8sTfj9n3KVlOtqwf2ksizVc1vyzNwnXWLah
         Ojdg==
X-Forwarded-Encrypted: i=1; AJvYcCUXnBvZQZ3c5i5CtXfvzBi3GHl0WGy3c9g7O3zw+1dCZimkTw7mEfbjmv6X76g0VEwwIElDPDhRGYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1g8AzaQ3EttfXez5DU/7cAdxQtdM8Bf1jEq7XUl6n9npv9NR6
	FM14hQgY6j0AlzW8JbiihhV7gE5syX4FdYlCtiY4aVGrpvikvR9cSUGy4cQVi7r/28o=
X-Gm-Gg: ASbGncuh9OtKjAkrBqToPyEUxBKyvvCer6qdlINRfpenYE+bCOUfLYJTXc+n8eV7V4+
	kX5+v04PPgbGe6UgXKmJAWHNLPPfXpcW0k3aMk7ko3ELOt/GHOctojNxJqtAWWIyLzNT4hPdqZZ
	jV8Qy8FcL6RJzHSyDVS4otBrEVeTAQ+XNUBypC+CEEoZrUMHjwlj4fYcD6yhZ9wMsw2xhq6nYJq
	9ifdeonaFyHfNIWjgGhUHR6gTTKGQXDNV4SINNovXZ7TbtEGNpQq9kHcslai7KGxJHBZ8XpaQFo
	Cehblxo0+1F4ejagQonRiYzpwymCmfeipwDg/MlthnHz3R7ZhqLyeFiu0f8iSxoR8dzPwbILzrX
	VFm6CkUIwUDyZr1A4jBPddot5E+7j33mxQg==
X-Google-Smtp-Source: AGHT+IFMiw5zVlKSlo142PqqKAhtgqF1TVkOxw4N8sD11BQn40MJ5BTx7e9G7Jb+TWyMfU9vkgJvWA==
X-Received: by 2002:a17:902:e5c1:b0:235:91a:31 with SMTP id d9443c01a7336-23c796a1c47mr5430865ad.8.1751481579607;
        Wed, 02 Jul 2025 11:39:39 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:39 -0700 (PDT)
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
Subject: [PATCH v8 04/10] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:02 +0200
Message-ID: <20250702183856.1727275-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6fb3768e3d71..0ea3a97bb93d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.50.0


