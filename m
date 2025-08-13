Return-Path: <linux-spi+bounces-9392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1DB25269
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F0C1C803D1
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626B29AB09;
	Wed, 13 Aug 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mNv1D5ob"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF129A31A
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107271; cv=none; b=lSw1nlFb5W6hAeOgB52P1fZXGLnFG/AWgYiqmahO//EJYJSeoOSxQcoLuT61thk6i36ju0uI9E4qA48gKBU7g7JmflOB/EK9TS56kg1010KhOuT4pscsm1htQnkn6NibfgjfI0bXtN06EneSR/8OtqST3Ptuzk2q5QANR7nBsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107271; c=relaxed/simple;
	bh=NjkCLYlKNtoy8P9olWmXk+TqDYwsdfQMHQyLM1GRmZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJxiIWZdNJ06NEyZuK8nOLDoaqwJMPDmnQf4lIJH97Z1fYXH4M4nofe/gAMB4fsTYxyA1wZuawWC/F1v6JMWnxGV3mPg/yVchxl8e8H1WCcG3NUorpsSspVkioyhWHrmimPaYiDLuiGqhxxjLpwSimFDDH1Ti80Fd4oSDH2j9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mNv1D5ob; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704b7a3dso7915685a.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107268; x=1755712068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89Z3Tvde06t5dQQQh9zIDgC5mMNPPytOaR1RQ792KEo=;
        b=mNv1D5obEG4SaFdPd9z4BvIddwABLZHkEmCbZ4IN6bo+cbYp5uHVe4+c5aYjeiYYo3
         3ir1V3M2Thdw2yOXoiol56knnhK8z3sTnqI9mLJKKHHx888cQhFq8OkHEpTW9iR8f9VQ
         fOQ5fLu/XqduHBxrqruun3UUkmVzBbWdedZZLo50fI3XTChwNcKhrLgX8/cjez7aWpb8
         c8SYkLQ3Xl470U3DPQOizAxK/6JjixekndsdsUHLdfpJzvnVXjwEOLCkYjdBqby1764F
         x+qN8zNzF5GHdVmAJQySlXwjXMM9Qv+DlhN64VxJcqqZj0GMdGvHQFeGsZtIDfiGwuvU
         YPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107268; x=1755712068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89Z3Tvde06t5dQQQh9zIDgC5mMNPPytOaR1RQ792KEo=;
        b=KXu8Lbzil8eZ6HCyke3eOdLAtJ4BOY0EVquXh5lKEs4OEPiPvGLSBJwF56Zu1KHSG6
         ZhyDqcARKFi4LZ7HJI/s4LFGlzx3uEtc+QUQhHHfZkFxeLVHgDyi6Dt4elQqMcAy0E3j
         5X0SYLd3JSGKnKrxXn+jDEGzjJPOXYVqsjHAteLDJ3JKp71ztRqKvEY0h4Zyk9ESYv8f
         HB3JPEF/F6YY/OtB7ZyA/x26LtqYGU6skvtCP/naCjc3JUvAAhhI86pd6ZP3a/6NCftj
         yzgce6ZEWTaYsYASbUF0vhdCNxYNOTtJhqawLUBZSTkkBEwkH1QMtMBKzbhvqmO5hfOz
         Gc2A==
X-Forwarded-Encrypted: i=1; AJvYcCUVIdYgnkv9ywycXULxSmuNmUG6463R5CmLb/xlCtN3cSLwli1OptResxMsDxrdz8FzBDhIzftzWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdZaTXlkUU4FUnGpggEKgrkbmQ/3GPwruiRommFTzeySDRk/4
	23474MeR2JKvtzJ9h99erHkgRk0aSuOLPqVgqKrAp33sXwj0phsO5lhHhH5yFAArSj4=
X-Gm-Gg: ASbGncvLxyO+zy9EPhuOY58HnBT+WlChruNy4xr2m7xx44Jg1z89TKbWO9E/RrhEADF
	YICaGRNcGRvL2OG++Cah247ABiGaoYGtxh5sLJvsBLV0xuJvFzTFtSi5vy+9pc4vnFW9S3oZjXJ
	VCowIYO/+Rr2c/Uda3EihrEsNTTdRhxRLVrWMbgo1W1NPol7omySzvjPL4FYE1zD2wNk1m0CK+B
	8S7t7uesOhvTB8cN2+9cnEhHzfAsDLDcIuXIcapVae/8RPHxeuJG5cUXxXCyeEFibX7oJSWX5Eq
	OfJUxpzrlddEhvTz0st7EB0poIPcObJUeWbgD6/yZbuDsSRDuRyAglWOxJjxNjRd1GDMJ6Zgmjp
	KxTtJm4iFwCg75aGdYMLX67PWexAgvGBabL1WGL1MKA==
X-Google-Smtp-Source: AGHT+IGsrPLNHuA2IU7WyavWdRjRrE/0nv7LFlmwkMJjixgV0JmRbdVoxVuLJtki1CHgdv8HoJD2vg==
X-Received: by 2002:a05:620a:470e:b0:7e8:66b9:f337 with SMTP id af79cd13be357-7e87031d036mr36261785a.26.1755107268237;
        Wed, 13 Aug 2025 10:47:48 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:47 -0700 (PDT)
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
Subject: [PATCH v9 4/9] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:40 +0200
Message-ID: <20250813174720.540015-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1..8f11b2df1470 100644
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
2.50.1


