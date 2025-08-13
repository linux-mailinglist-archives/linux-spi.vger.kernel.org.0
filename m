Return-Path: <linux-spi+bounces-9397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2CB2528C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2479A178C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73B2BD59C;
	Wed, 13 Aug 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="RHGKGg6p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8A295D99
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107292; cv=none; b=PlLrRXyuUmihpNhIFs/QcqW7RFgyqvDTEqmR+mCwNyfox89o76q0NsBtJ58caf0ThAnyS/n78lQFkXM6yUK2mh409QQDuEo2PzecRbwC96eui8V4mNxa5WTAxEB6u5I+BQUxDFPjFI/rDZJkHO/cTrmqg21wT5RoVBJMzNSxrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107292; c=relaxed/simple;
	bh=T33t/nZb8rPEuHbl7ykIT2YVRu2WYufkasb9fh7PUw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV2iVZbv3tCKVE3Mc8byTaGoE4qNkQ6hkhS2SJjfhHWCbduEJkxj5YvqLTECNlp0Hx066edd37CxtGumIEEGBsLA4rhY3KE9xSeV5mYIjBcEWcIykhiWwX8UzC2ZkodR3PjsZMG5LRw1ANmppksqji+9nDhUic3V8R3Qtt7QjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=RHGKGg6p; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8706ac44eso8414785a.3
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107289; x=1755712089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfHoKyNgBhJf0xtcpDC78WNK1W92/OSNj7SkF7mLTxc=;
        b=RHGKGg6pWWWwGZyN1/VLZTN+J8FKwO4j9Kvft5ViY8Umia4pgGQbTVGBO32i83NtPR
         Ai/yBD8ntcE9zSXYd2kvaG2eb/iioi8FcrxiqyN8CtkDVrGHgy6iB197wT+V3NtgMaNH
         JR388ruL1yrCgfKJllvhs4gPNWM5ZhmqA5Pz1hBPymRrd3Q0Usklj0WZvp+2+uaamdzZ
         yPSlTf3XqYVk+qO/mI/6N6EBvT9pluGTfQQoSAjcQ4Swi+9MFDvZc5ESt/L/x9PgWCu6
         KOGdZM5lMecuQ6CN57p0ww/pnW/zwS9CwnBZQRILYSe9k7jtUivNh27E6cZs3ONlu8Ue
         PZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107289; x=1755712089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfHoKyNgBhJf0xtcpDC78WNK1W92/OSNj7SkF7mLTxc=;
        b=fu4/KcJ8BpskC0cka15iy6al7/2dXau088K8Ss0x9GJ26NniIKr7GGud3qYaUYiRE8
         yaB1jEqE8si52NOazkl2YXCc/SZ6ZMSiAXOLvr6QJwuFzBZkamYwZX9txUt5FKrdQnA0
         agbotR8to+i1mFA7If/28XKHNBTvv74RAlCXlGzOSmg6ycxIfJUlSYNydvB8EvMQJIXm
         LIcH3tfEErRTCq9/NVcVbml/fprQi0CsxUaLbeIHvJy9+OWsHvpOcL09aUfyeGEZWdET
         dp1/ky0imOrG9sONJRyvOz/ZVz9OltFSsa1AmUzcQ4n45uVbpHb0/fvfw0OroAEVW9Ig
         +1dA==
X-Forwarded-Encrypted: i=1; AJvYcCVehTNs4umJFJ7nsvERTWKOuvcBSVNCvsRc51j0u5dWHlKn4ShTL19oOp1pvtVPM+fC+zbPPDWalXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XziqngnyUoKeJVajMKu/+5lvlQQPjcN5Nx9HlM1qvyPeKNFO
	6TVaZP5Fb7uChs3hM5W5OKVnLkWFdYOA1bfUcM2tct8XzUQ23DEWMoS6tmbWQBQBLro=
X-Gm-Gg: ASbGnct16UDt2c8LoMMPiZFY0lO785LE5Nulpx/4ctIEn+ydNQSBMQ8Z72Oz6BWY8v0
	Zdr32OH5bJuVRLazYLNhCgb/bhnUHJMc4pdISfkPhagWR/s4GBlPC/+l/v4LPpM75mJlrYWf6vx
	mPfmX65wwEYUZ5+raf1r1QoqkmA8z+csf7Ra4tnULhVx6zsd6Pl/zhQGB42SRTXDxLYWnDCR7Mo
	NpjGDaYLoG3MIaVVqjS2FCdPLTjNTZvUOl3rE1ZNwIDI1P09f7FopEELW8zoVXr/jn/Y6CEBRCS
	utEg76DZVArgP5hZyZ/4Y9Ei2OxusMOOtWwFBV3ztVR813qb2lLM2Uma7tMI6MBCkSR0DIs22ck
	mVJXENwpgQ4kdWRvhvL6gJ5viT+f98DYVCI0JljfrNA==
X-Google-Smtp-Source: AGHT+IHk3Ep3PYhhUjUrzxiC9a3/t8LEKcJKp9X+LDRevsQvizEm3+mPb4XnpdaTjxQtoytK8PcKqg==
X-Received: by 2002:a05:620a:1791:b0:7e7:fdd2:cc58 with SMTP id af79cd13be357-7e870473db6mr37537485a.15.1755107284284;
        Wed, 13 Aug 2025 10:48:04 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:48:03 -0700 (PDT)
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
Subject: [PATCH v9 8/9] char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:44 +0200
Message-ID: <20250813174720.540015-9-robert.marko@sartura.hr>
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

LAN969x uses the Atmel HWRNG, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..e316cbc5baa9 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on (ARCH_MICROCHIP || COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.50.1


