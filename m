Return-Path: <linux-spi+bounces-9008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647FAF6192
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6619F1C283F9
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB032F5C20;
	Wed,  2 Jul 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="g0arqI0K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4202F508D
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481588; cv=none; b=T9s4jeZ/cRIeiBWXmSHkaJQyhmvKhhrpq5FcEOssIzpOKDHAcxdPR9xNyg1dYpx6oM5+8WB1xGdFZHwtNT95uEC8/1jkOufGlKT8du09eptYHo6L4SYmgCGrstPY7bHBVKVVpq15cjPMIt0IbkmgYRa5/fYw4XjGJV5b/M5CTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481588; c=relaxed/simple;
	bh=fqtQu82ipUIUs/6YYFaGB1bjUo7+49dZ1md5F4GSAkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZoPYPrLYnyjHe2lKNno5fs2MQ6baAEO3Fm2RlFaWPYMtv7I+xZGAg8i3LZyDT9YmnItKs5JaDnq15GUr7eg8y2yv1HtfszfrDAEtwCZ8yXh3tt8aF04tUeQbafk6O5e4mvdX7G5MCLLbucpVN7O+nPWJGHCJG6VIpi+cojnN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=g0arqI0K; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c76ed4a7fso5557885ad.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481586; x=1752086386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=g0arqI0K1V691fmhoa1EpltuXizcKRN1OyRP/KBM9ZRaX3YOBMI2zKAXJBhzFCzFhr
         WO5N0jssLXPmXbMOTIqqSK4UR86LOs9Lvpwr0TI7NuUmc0mOBXauNhtpN2ETK4CD1lu6
         vHCCYjQEx9t+yzl5HHHPaCw/mMOXwWTWyhZI27LmKtZbH+sB0EVm4ADZgkZAvowb6C7W
         heZ20gkCblgO9MVTm2qDDlEhTr5CrEjSfKv/2gM+HkDqKN6jGGtcJTU67nkCErRdbPtm
         BlJg7ocObuis82DQPPPxJPXOZRdhlMIQ1KHKE7UM983B+sJRelc9NPnF3/13ajETdV7n
         e+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481586; x=1752086386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=I7m7ARc64SQE75wwlAT8ZB7QH6Tj4XnM0QwVvk6x35udv3Kj7jXvONHwOzA6hZJSXa
         RYhOkpmOx5nFuyW1f3WSo0VB9unllqnWB8hd3qMdDUiWq0ANaJ6duVWkOmFNoUJR+3Eh
         LYPtsMZ0TOIm73K+cYrQ9wsRA8EQNKw08tbpMP3aRtNy9wVYWGnS6j7Rq3vn/jQh8ZaM
         7KyWAB1AEO4cH4vRr2FvbcpNwL+vwNVnPv//293mPnd7W/uagLechBcLr48obfE9/deq
         lGhO8VeGySHf1jPgQxzpwYH+FS/qnse5AaBvxNE7Yfa1rZaTRsE+xLr1rwvZg0G79Ktu
         5y1A==
X-Forwarded-Encrypted: i=1; AJvYcCWlgeo8ZWWB2I7Ntvvhx917wuXm5zMxKfHbTnNld4keDMoamwKEaB4xL1IkvnTQJb7B1Z3jMxulWA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaP1KeRzF7G7SFY3Lu53N9McvnOoGZEU1Mh0SEnA+AKR9qYZr
	y4r4ZNlgDvmCg15A7v/1v/vl9zpwLFTQs9IVQelcZnB9qgI6TWZ1h5x6JASo+3zOKbs=
X-Gm-Gg: ASbGncumIeh9XaLMCviSHdXRME7CeZtXkg2vubL0oW5BzoCe4Ha4OTY4/ohW21ltUR0
	gItwLA1HfuLWleUZLn93AZOzgarinpnKBFR636Slm3tbmzxKY64DR5E3Kv2JXLJfwYGxf1k+yof
	buSPHGzZkq9fcyLMaz50wXrY2WnjWYakSq9SCKTpR9I9OY0vA3tyo4zQIr+do6nsSulWnzBgjOy
	+r9IR5nRbN8mCxZlo7ZSrQqX+7XcmLb2oegCdDXtoyBX7Aq1qXqlM3PuitB0LbJeatg7Tb0IUDO
	4w5uO9UqtO5V04fUqcZVU4+2IGYuE3ejZGlh2Vr1cQDqXmLaEmPbhU87R/iWWIW+TLvqllGLyr0
	eN5LOBkBsCvEg9451wmo36OA=
X-Google-Smtp-Source: AGHT+IFtjc9wQbx0mnTEIHCa/COpi03QJubyVPHdKqzZsjHI9di0hrmvji1zsNLaFfpKOtfqcICExA==
X-Received: by 2002:a17:903:40d1:b0:234:9375:e07c with SMTP id d9443c01a7336-23c6e558b2fmr47599345ad.46.1751481586359;
        Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:45 -0700 (PDT)
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
Subject: [PATCH v8 05/10] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:03 +0200
Message-ID: <20250702183856.1727275-6-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 79a8186d3361..c33fc6f16d31 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.50.0


