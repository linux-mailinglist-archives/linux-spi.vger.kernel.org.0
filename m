Return-Path: <linux-spi+bounces-9393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D7B25264
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817645A532A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668228C84C;
	Wed, 13 Aug 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nAJWGwUR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15F28BAB5
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107275; cv=none; b=dexC8+5kr1BkaBncRNpS9IWgM0/cZmtPn8UTUNuQwDlA+vAUlMNb/2Bjlr+GlQmV8szUk1G5GuqCVOIYca+luesckbFIuRh8j9kUpFLiOBWyXoGVac35mECdSR3PDaqP5q8JWvh1TCUg7CdvTz9cbbVv1PnUNu6QmOX9R+Mot8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107275; c=relaxed/simple;
	bh=/+oZqZHI1h9WgghpCqBvJzy9LGRR42vTOm/KVnlDk38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwFZiuLLZ90/IKdDR7shwYPPOU8EajYHX72KMoxIs0AQwHKR3Q/iZQudKhIQjwDqZUiKvPor2MFQyVjnfWnDhlnyQCd796p2QqNIr3RJgRdbkJk0T7ASZIuvbTIQkd67NufGX64Z63+MFYmF4z7miIQDjEhrZtXdfF+89Nie3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nAJWGwUR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8706ac44eso8366985a.3
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107273; x=1755712073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=nAJWGwURLnmY6WKhuRwHnmZIy+mWrdeME+GG5IjxC5FCKJyyJiX1pH4t3rfJFyIqck
         3/CReItnkvy+uaVMAmIvZKabkMFl2j4B7Ys32jiaQZPrIiY+Q/Kesz+1lTAkfG/NPRnC
         XcVFz3Ff1xblhDU9LCp8Q4hN844uqOzFpyA72iDAqk49EgrcnIqQwb0CtrTnGBsec/C4
         yQAU2MxApSD+33hjPXvsF7cAZXHlE1ivP6YeHaXJRhMXOpnc/GVV7Tznd6y2paQF0C8K
         IMO5WANAlKfMnTnKAz/D1kmE3spi0SodhRRosCt1iSNJr4ea9Z9BbEOUssf+zR/7SrSt
         CKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107273; x=1755712073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=JaPWeLZtK64tkI7PY9vop4qnxrRIXgjqa3GbueLVCdpXShwsGzFAAKeDLE2sTikEC+
         MLZEkL/hMe2rzz0mMKwzJ+A3bGWFjlR2mG8ym0x2P3RH0/6/pTphM6ka09LlfuWLLQIO
         9jvUgrcn5terLZMGA7zN0/iiFiBiKXbhmXFAFHb63swtlaMyOkhE21BmBg85viwcxgs0
         dA1G6KVrrX4TSrWPSRHkOPmuAG8VXaty9Ihb2wgK54MNp9fBBXmS5YKtKMcjUCqXm7Tw
         jy99hxuwVWrWwUyFKR6BN14fUUwYJcqBRPEcPo2BIZKrxublwWDialtJZblAg607V2tR
         NFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1bxWyjyt5LCT/jFurwVGKbznxTsKgGNJYPZKIDVmexiNQ3kAjvD3h6sCW7B5DoBO8YpSAG/qpxmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKap7yKuDyf9lFgtpcDEeQynMiu6082tedQNWKpE7ww540qQRd
	86IiHnNHvI8uwoK1MCdpY/LBQ5UzWwGI49HC71/oDDH6vRl8ovzXypkjPIvA0ndJNCg=
X-Gm-Gg: ASbGncvyNujQ5wd7zk4sbh5DZU/9SdIaQCDfEZt1T6qa8qkSsSvTCsC+JVsNIc4nNEJ
	VsVQL+IzAXNX5oe9aCc4ptCOrI6vjd8I3RYKpISwxQTv/8bb+X5m235n9YWR6HblUBWE5iW52c3
	alByEz8oQLCogdcRUGNauZtTZxno5G5AjMcpXF9diLEID/jSORs1d3utUb5phbvoNTqo/wxg4fx
	k4f02/OL0j/dSs4zq9NV7dy4cCLxQo31cZqydZtcFdxUC7UD1e6ttDQ0czVR6Owh6+dnL0piagW
	MTho5HrqNdoen5MRxn6mF1sh2XT+hAAKAIzFLdJFilaDPj6sxi6wpuxjTjCsi8Oh1LlYFCz94LF
	poRyHrMq6245MNQuskpKyOhUlc3sKx46OScFr/ENd3KZSX+L051N9gratq/qFheo=
X-Google-Smtp-Source: AGHT+IFBbRD05COD+4uOC97ucvpHyx0jBQqfnQDIsz8+GmCzNdE1TPU770o9CrOuegUdmCbSDq2ITA==
X-Received: by 2002:a37:f50d:0:b0:7e6:5ef5:c7e4 with SMTP id af79cd13be357-7e8705d2e04mr26126585a.64.1755107272247;
        Wed, 13 Aug 2025 10:47:52 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:51 -0700 (PDT)
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
Subject: [PATCH v9 5/9] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:41 +0200
Message-ID: <20250813174720.540015-6-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..724ad4f3cbee 100644
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
2.50.1


