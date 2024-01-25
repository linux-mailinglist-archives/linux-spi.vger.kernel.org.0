Return-Path: <linux-spi+bounces-760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6983C558
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A10F1F27129
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D0745EF;
	Thu, 25 Jan 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu4YonSw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982A73186
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194218; cv=none; b=AEvuy9sovueefvC2yrdb80WwRd8BrYZDyHPQlnftp2Q/2f+xAn71qRwxlMTDIi87GSdX5ZsqTZyUx0MTsQBt76pLPSLgouAWxsRX0liiRORqVLMgxKMKXmOqg53tq4COYnS9zT0nzUqWZVoJSn249pI4ProoKtoy5mKG53c8DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194218; c=relaxed/simple;
	bh=kM3TvYJuXO/2fu3NMZYphC4cXulYUhqSFXQCMxVbb5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFLN0QU7Jt3REoc17qi/7K4mX/9sV3rRGn9lvMdjlpiogA6ZlKJVd4VC5O+ojuMXUZt6SIgZat05+ci3mLol/UfskI9VA2KcLb3jugxUsdEbeUcTLKAzGYJtULzyvMMImXUtI6xoEn5HPiE48Qrdr8GQcmDBQQzYsHAy43uA9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu4YonSw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso54900265e9.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194214; x=1706799014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF19RJft8z+RVxLTw4w4Iz/5TESrFLzi3P4+GrCzRsY=;
        b=eu4YonSwpVXoKhkxJ0gK+4tjqKJGpZCK0qBz/9qjzD9zks7xpcvnNk9rkOhSeh4AYZ
         DrgpTEHG6XFGFVr8hKQsSkNIbmpNHBfVhBPhVtQ/QLl4eH1/Uk9MTxqVBvQp9KagLZZT
         99pocgqmQILOZ7QoS2eEOWHFpSGFHvBRe4Ic6dQ20O7g52rht75D0KentimB8JunnoT1
         /MH1zw2xweGhMnApcmInQKiN0BxgdeQG9/gnw8zBWhThNBLpk856H3mUohAgjMQYQmTH
         8djT7+/KT0emeYnFqeXu+KKZNSn5PfZXcLdvMXX9Ht+mY//BcvOaGR/CtHn2X9jg9cIY
         dNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194214; x=1706799014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF19RJft8z+RVxLTw4w4Iz/5TESrFLzi3P4+GrCzRsY=;
        b=juWtC9aTf1u0AnYdUYfR7BKeYu4tNheT0z5MEA2L8+IFYSx9OTfMIm+bTWmUgbZaOg
         3mZJssHr+/G8Hvlq0/nF+h0iI6qEshV/hDkTnWeNySp0KT0eY4h0PfEbrWnQoRLByJ/6
         //atNR4Mf23An/OLqVErzi/o+89DNEmNyO4Zj8ZjoKotp8lynN6raTSkfgH7b2T0h/ty
         Qxt7pJ+ofQZjNPZn+oMBKzH/swdXzhkEaTMSoux1QrJCOeAL0Xq3SLwWqMqLoq7ZboAy
         kZZeiOCO/M9jC9QOtAYrJ1yFshaVaT76IJ4o9uTzIxQwYi7mLjhhMiVNe+BnUgnGO7dl
         bCpQ==
X-Gm-Message-State: AOJu0Yz3PbRVLLlgnBc/Cj9kOF1qNHX36p5ij1D0i19eD8jBHrNRKy/8
	FkpF0+Uqe9MMcE+HYKSi8jYNekDAfd1ecTfwhtCsYRvV/Clsse4GiD7R7ECXPxM=
X-Google-Smtp-Source: AGHT+IEHoREsOegc3WurYtU5U/rBHZhVnyI3Hhay3VuRSOXGnBpm1+f1t0k7hs57nCO7FwSA9TxYig==
X-Received: by 2002:a1c:7c19:0:b0:40e:67e9:ae0 with SMTP id x25-20020a1c7c19000000b0040e67e90ae0mr366973wmc.235.1706194214090;
        Thu, 25 Jan 2024 06:50:14 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:13 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/28] spi: dt-bindings: samsung: add google,gs101-spi compatible
Date: Thu, 25 Jan 2024 14:49:42 +0000
Message-ID: <20240125145007.748295-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "google,gs101-spi" dedicated compatible for representing SPI of
Google GS101 SoC.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index f71099852653..2f0a0835ecfb 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-spi
           - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
-- 
2.43.0.429.g432eaa2c6b-goog


