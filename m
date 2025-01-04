Return-Path: <linux-spi+bounces-6219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F4A016DD
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775D2162B62
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD41D79A9;
	Sat,  4 Jan 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqBLnas0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2041D63D5
	for <linux-spi@vger.kernel.org>; Sat,  4 Jan 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024090; cv=none; b=I0lSELTrbLWRzecJsrF9vknU9SJ4eEqbW/7IEWC2aYQwWlcQyL+ZoJIrGi50KlxIBX7CdqSmixtoCFoKt7pjy9aYXsrdbELH28ART9wD6QbJV4h7v/h4W73eizP9lnQnp1cM0XJeS5MgPA4VDG5T+mTgWo+QnyXS220E/tSpDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024090; c=relaxed/simple;
	bh=OVi515b6fvB1D8FMPWpdYGP+XIs4Du8HE+mgPE8IwMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QASe1hjH/6C+hBtJHYAcFP7UOdp71wimdOf/XnVVIiSkHEe0DRhAXqC+/EYpxqfOxaZdyQ3NJs7XpriSmAadBsD/lQHa7u05CPLkRXTaBnvdH4+cu+Rl8LwbZUi+nVARQjuFlyPnAuTC093aEcabdi7FqoVi5bIPDRAcn+Li9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqBLnas0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3ea2a5a9fso1976585a12.2
        for <linux-spi@vger.kernel.org>; Sat, 04 Jan 2025 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736024086; x=1736628886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5tKgeyFg00MgtfGaAYBuFBjwqBNpORNVJY5iBPqbW0=;
        b=OqBLnas0b3u2iphRWe03NbjI9mEC+QoYFvHc7vHsBTCAdTqXB09dyuMPCIS8LbA0/j
         0MOEz5wCDpMW+v6WZ6XLrrgzkUkC1BKicdJIChrjeDRv2Em+iEtSAzfyIG+BbTBDE6hk
         fzfEvzyelEUH3Z2Ypa9v3zbQYTFBe+ZBJCPuhldNbksJdpFqrZRChtgu1m61RVC+sJ2Y
         1DOxw9V9xxpKchaynbwuBVdJUlnED9WJtewEzwis3lo5GlIhWO1cCflU51ecb8ng70Bk
         iod3rOndeUw1e/Kx2WffdCIsK+fZstD5VIkhepAokhf1B3nBDBBlt1JWgOc29uEPvykc
         JTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024086; x=1736628886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5tKgeyFg00MgtfGaAYBuFBjwqBNpORNVJY5iBPqbW0=;
        b=lpNJt+wl4klYaqNY6U/JkCTQfSnw3rz3ru54jmwUENELXfGdZiUcaLXdhSQDBD/f1+
         irKQwgV8cv1LXY8ry2zdrRutsRaUd/0aVv/OfvCfc24WbG9xiVVZsE4qbHbwT/U3AZf1
         IqBYGjD4jVd3eRoe+Bw2DmvbUf4vLeJd/iFiDS8FXcvviMvXbd5/+axcxmT0oZgWu7i0
         mIRV7EOOiwAuPemMV6Ekg8YqOGTdK3NKwI6R7Y7g4u/s7mluWFC03JOCuxEamaLTC33m
         urejRJ9yO20d32qprBf9mvarUiRNzebbHZRp1+K5MzJstDaAzj+DjOQOxvdFZCaACFVo
         OiBw==
X-Forwarded-Encrypted: i=1; AJvYcCWDhsf5v7fRGu5ssSi7CWMhZzf4MYZl7s6TZT1eAcuy5JjM1QrJJpKuRyiMlzZhJqKKMLwG8FPlR/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eE2lgt1twk5fdTo0EjTcwJ/Y86yh9qczimtE8mY/I0WbUWJJ
	ic6vF5dBaUUr4q47hlyf7GySKkjgKTqfsvr2GP9FYLDVsM8E9R+8hp3XwyG3kmY=
X-Gm-Gg: ASbGncuqOJQGcZQCn6MNNv2eQjrKwazsxBUWUPGarN3rqIZU+lezii5/BVHcY3GuE6f
	iFcYPYQW5BjL2BDZT77k+NaKe7S5RmsidM6rPdNExu1FgtP0I9viLWMHpGWURkzKNVMLSIRgTc9
	EYUVLRNAB3o0QU1OGrJ9Viow/V/QIfoMAsIfRETBx01/rI0ozhRj9J5n1etQK+ZaZrAq5CfTjYq
	qebT7HxnXiyhvqKDstuQcGFvcC1h5xoHDKtISDP46V81KUorTUZTIpwy0N3ODnuvfSqgaU=
X-Google-Smtp-Source: AGHT+IFYBTBJPclwUSGwCj06Or/uq4VGv6lfISakgOmL+cPEXrHfIpLkbx2RfKlkxwiJ7dN0dGBBQQ==
X-Received: by 2002:a05:6402:2349:b0:5d0:214b:96b4 with SMTP id 4fb4d7f45d1cf-5d81dd5a17dmr16470255a12.1.1736024086537;
        Sat, 04 Jan 2025 12:54:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf4a841749sm839666666b.137.2025.01.04.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:54:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] spi: cs42l43: Make handling missing spk-id GPIOs explicit
Date: Sat,  4 Jan 2025 21:54:36 +0100
Message-ID: <20250104205437.184782-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
References: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpiod_get_array_optional() for spk-id GPIOs can return NULL, if they are
missing, so do not pass the value to PTR_ERR but instead explicitly
treat NULL as acceptable condition.  The old code was correct, but
misleading because PTR_ERR usually is used on errors.

Reported by Smatch:
  drivers/spi/spi-cs42l43.c:241 cs42l43_get_speaker_id_gpios() warn: passing zero to 'PTR_ERR'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index ceefc253c549..90180662c4c2 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -237,7 +237,9 @@ static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
 	int i, ret;
 
 	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
-	if (IS_ERR_OR_NULL(descs))
+	if (!descs)
+		return 0;
+	else if (IS_ERR_OR_NULL(descs))
 		return PTR_ERR(descs);
 
 	spkid = 0;
-- 
2.43.0


