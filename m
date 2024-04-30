Return-Path: <linux-spi+bounces-2645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E88B6B0E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 09:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E37B2183A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FE1BF5C;
	Tue, 30 Apr 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwvfhrWV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEEDDAA
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460638; cv=none; b=TjNq7eZD9qS/OdCrqcAX2x4kBP7GTsKx3s7JCDANBZ9PrT+RCoU81q++tFdusaKGf1mD0p9cObTCpMgEk8gThrd2orTROh3trojX2L57MsegI+Fd2bQnr3Suj7jo6n18wz/islNZ4ui4osRmBNuyaOpcrm4kbAVbnhJZCi7jC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460638; c=relaxed/simple;
	bh=OdoW269dMYChy3+DU+KNyzjUhldkA+9Km5hn1NUmvnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALwI1Q2gcSTI3CVyvMT05pNzl48C4sgZf/b3MU+3pTER+4tyjr36HvJyF11m6cm0KbagiG4+0YtodCrxJ5J6aaetp2PU8Q3yseV+s8k9y2tw+zReJrBfI+Wf4O1UIMU3dTswKhMwMl0hDKaxyk0HwnxMrvMTh9OgIC3GrfRoPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwvfhrWV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be4b986aaso12447877b3.3
        for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714460634; x=1715065434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0ixy7fv19ExAcreEswXg94DycLU86SeU2ojNLlxijk=;
        b=JwvfhrWVnLdHAtBPIoJ4h+1feKPUE6bgM1Bu+LTzh/Pd3QHdYMS3Y2Y1u5srHRxE0s
         XqJNaFDS25aHZEjP6OB8Iyg+6UhpIxB7LnfKQu7r1vrJCGrdObRZFebKm60uMYY6Nx0w
         Ly3WCu4ra6dVdlMsXnMRjNWAIDtI24oAoA0rQVea1fqnFI1p+iUzTupzFjvSEU7TTig2
         x6WXgKqZ6VqYq9FrYG++53Y8GRhV998H99lLAKqGfRrVJN7SVU27PaKqTz9UXhQKW7nH
         f2OP1opO0xUiTWeWmhbJ7otVPgAJSlCVrACK3aBYHPKs7MJNAFmPXU8psn5tkTBj4kAe
         z5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460634; x=1715065434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0ixy7fv19ExAcreEswXg94DycLU86SeU2ojNLlxijk=;
        b=k43IGDNGiA+YNF5dqn2avabJ82x5VBKVwhAkAmkh1JVStyYb1YMj5oxGONN/fNNb9e
         M0IR2swDyNspY2F+sQ4xuRbIMqU7crA7L9eIYVtnlxS6358aUCGWVH16C/rMg1fI+EyI
         Fzn6evSsjMODlulvdS3kpp+fq4bP4nfBF1/oOIXl8PX9iysA5TBd3/IGuCYiR9nA2buv
         LWNqzVL5RWei9WZd5DN9BiOEUoogc9K879VfrZGKGV5xnohrlwkRxBtkQe68NhLV2+vb
         HGeddz6BcFBaxOAVhsMEJIiHtgVdCK89LkCU9LrjwqCb7tJoIbec3f2kTwnZ7G0vJVG6
         rp/w==
X-Forwarded-Encrypted: i=1; AJvYcCWgy3zdpDvlYyR7ffbEfEkikA48lmna52waINCMNXCqRw8TkfdCA2PPDpHsfaQuC6zc2tC/+C0sRchgaRwsMpLeciYz5RdaHHqE
X-Gm-Message-State: AOJu0YzScMdibXv9TGLyDyj9BGnboyFAcgoJOYuyk5Z0MOZObX16lork
	NbE1wG1Qjo8MGFy9V/92BW7MWDX6SMzzHCpvosEWNtvWxONJWowIuBoqQJTyi1g=
X-Google-Smtp-Source: AGHT+IFhrTYVyGAxSgGpphlVFdD7358nVt142kj/csynXWwvRVabPFRJKNRP1Kglb24GmrH2zD4MsQ==
X-Received: by 2002:a05:690c:e:b0:61a:d2a0:5497 with SMTP id bc14-20020a05690c000e00b0061ad2a05497mr14316415ywb.8.1714460634450;
        Tue, 30 Apr 2024 00:03:54 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10610674qtx.18.2024.04.30.00.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:03:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Apr 2024 09:03:47 +0200
Subject: [PATCH 1/3] ARM: spitz: Convert Spitz board to GPIO descriptors
 for LEDs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-gpio-leds-miscarm-v1-1-9c94d7711f6c@linaro.org>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
In-Reply-To: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This makes the LEDs on the PXA Spitz board use GPIO
descriptors instead of hardcoded GPIOs from the global
numberspace.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/spitz.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index cc691b199429..36aec5ea7218 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -456,12 +456,21 @@ static struct gpio_led spitz_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
 		.default_trigger	= "sharpsl-charge",
-		.gpio			= SPITZ_GPIO_LED_ORANGE,
 	},
 	{
 		.name			= "spitz:green:hddactivity",
 		.default_trigger	= "disk-activity",
-		.gpio			= SPITZ_GPIO_LED_GREEN,
+	},
+};
+
+static struct gpiod_lookup_table spitz_gpio_leds_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_LED_ORANGE, NULL,
+				0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_LED_GREEN, NULL,
+				1, GPIO_ACTIVE_HIGH),
+		{ },
 	},
 };
 
@@ -480,6 +489,7 @@ static struct platform_device spitz_led_device = {
 
 static void __init spitz_leds_init(void)
 {
+	gpiod_add_lookup_table(&spitz_gpio_leds_table);
 	platform_device_register(&spitz_led_device);
 }
 #else

-- 
2.44.0


