Return-Path: <linux-spi+bounces-9010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C6DAF61A1
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9429B3B8AAD
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523E2F6F9C;
	Wed,  2 Jul 2025 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WgWn0EPl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F731551E
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481603; cv=none; b=p8mbkq+26LkPa+4wZ+1sLVrXe+vz3qGPzf1B1AfKZxD8OYX1d8Se3fJRzvC/q3xE0bnkwDw3cffU1yxoXD09tx6Rsd4wXazWMw0SYIemJWEMr5NJfVT5AWszOCw6YcrnxGYe6S04oafg1B4IkMWiAqF0fDdvnqTCOx6EyR49j2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481603; c=relaxed/simple;
	bh=ufOVlqAt3uI1zr6bmRH+USzQKY4G3SQiQndGTVQ2HBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUDzV2UYdLkzyubf4zGMCXLYFOItAaabZRFqpQf8bh5NjdeF0XXnVV8cAFYYWxfGFXqd5jCftzQP7qrYrR3Dgg77yaayibBOOBp7t8CX3X2JGGFlz49Xh+W7v3C2O2w/33gfD8mr4+e2r2eYVG7UHv9xR/OfE3e1l2UWU+/TNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WgWn0EPl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234c5b57557so48239685ad.3
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481600; x=1752086400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=WgWn0EPl4z9gSviEI9KEWNs4eztRqIE0YqYE8ajxkBtXvP3Wf0dGq6hnqL2G95//LY
         cpis32hI+BvVHFzMxWYvFqxhCvm90IA8ceAUBEEStj8fr0Qhoh5E2owuvpCeulrgCmAS
         zwsRsqtxi2kOVnTXmZgN53Tvei9GjOh6QYSOTjOK5pUOYU2jLGZujsXZBio26anN4Bhr
         1GwyzQwQ0vymmFyzaOD6AFnYJjpPd5iTduf6u68XBY8J1c8HJM55khjJ1ysW+AgV6bCk
         Jq9QFyMIeyC8mDdL2TgAzuq7Jb948wUtdxvyxN838xnWYYVx82Ru1LT4jHiJsYd1q0AZ
         zAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481600; x=1752086400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=A8baCLg5SCKZlG7EOzirXkyMV0fTZdTmi4nYVpGreyj9hUG1GzUe0isvDum6ILq01i
         99j0ufPL2+tJmHbQLGBSymirTotrNAPvNRc435TCt+4yqSIOC6JTLu4OKvl7pgjDgFFq
         L974czb/MRjKmt7XY7L8zNQmeSjKJ2oIhVxRs+X1o/qTPmj8VVzfz6DUQGkfpnEPTTM2
         I78IUfuet4wQdEQ4aaDWHO5EGRsSNS29gPdCWhNmTLQtDo/i62D30jQmwxmdCdg6nxzv
         0XCjmp9zTfvrTrE4vYVmJL4UPbiyr04WzVbdwaIHLvRqO435NNWtymN2/dn36jlWtPVh
         MAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjzYRgkkGB5n+PfuhaZMelUF8q+4MFsPXVhJVp8qLXktxO0lZkRGLbTJ/1/w059l0vUoqBx6TXwOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHc/H0UtN2dUH7Q+ln5RNz0gGkYQjQPuKWnLvXO10mRt4Q8kI
	9X/u3s9DttcGhecd+TDLzu2iZCznB72/TvjlHA7FZ+t9e+yV+NbNIBwTQ9gOpHJnRf0=
X-Gm-Gg: ASbGncsNec6i18/bIbzgaF2WoLBQ34n0z7ni+N+ZiZIlhp4pW+shncyhJkYKhv5MNti
	RTKXiJeQmntkCp9U82WPA2xU/6yv2RobhnKgXyENOH24ScNPz4Eq8htjpTB/hjI3yrmrOLWquF9
	P74KcTP/ZFdsgYRfhheMLc8BDbm81+gBfWsmznB8NMTM1xFqeJathdFCaWUOQNW6x73LC3dyANs
	2k6yNgGgjPkcA7RzLw61wPWgAZN5RIS/dSTlx/0VsYZG0KYSdJPAYp7H+KCnvsHzSW4WGZtZhJe
	CNXUfcnkvJb8yZXKs21Ozkhb+OhBxLN5lvdKDpdSivOEquSao2as3qyx39RSUScnjFj5wTxQqAd
	+o29mkbRkRUdScjWYKNroLpqRkBi6qK16dQ==
X-Google-Smtp-Source: AGHT+IHb5I71nz8YJIIhY789TZ8DXVSueuTS+Cp9Lta7fg4qamQr3ZvWLBc2y6VdIoWci5wbIzzqcQ==
X-Received: by 2002:a17:903:3204:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23c7965da40mr5474425ad.16.1751481599876;
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
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
Subject: [PATCH v8 07/10] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:05 +0200
Message-ID: <20250702183856.1727275-8-robert.marko@sartura.hr>
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
index 0a4ecccd1851..0101529c80a9 100644
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
2.50.0


