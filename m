Return-Path: <linux-spi+bounces-8966-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C733BAF05BA
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 23:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8535F7B2066
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95126E17F;
	Tue,  1 Jul 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vY1msg12"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2F30204B
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405977; cv=none; b=Y4FAZuaknc662Z0S1U07oMb5MyNfHssxzYeOrkLDDzmIs/SgFoCLDD1KKvseG+azImWAwQK7/Qp0J9INtzYAMQJYCfV4wrCQuTyZSS87Zn4TXAnYyTEhDKFffDlP/fIgVA05DYj6ZTiVemFUclU/cgDkB4Vi5yaAYXssF8ptVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405977; c=relaxed/simple;
	bh=eX4YHp/dtOegV1BsNpjg29XkjKcYwdbRuJEkdrbboOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilYEXSZ22waI+mYMXrZ91wV2cXnXBw+roC7Ogm83Sp3vSNEdMH+T4cM/a92CAb4cQt48uWSzdL0q+khTw3HE2dzPoZQNR9ozgFKZ3RAb8troTot/dJ+xufsnyhbOYypPaU2O6tmipOYkANmkrohPdKVps6T5erI8d0YZMKKAOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vY1msg12; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c47631b4cso2776107a34.1
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405974; x=1752010774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2FCNKCwh9PvjlU7ijHy+Usg9/eSYsjcOSLSWrMIa7U=;
        b=vY1msg12b2q0qoGp2IQQRIZAZqnbeIqJwZFDdEw5J2y7zJkC7JFZzxkQ5lBHqvek9J
         q7sxz6h21zwnSqu47YAOJqy2uOzoLkLRk4gUvEz+ezkYMgp5UxuMADQ5Vr+2t7LmFZC7
         pWJOChk1PH7fNy3symV+X9QhmUt6xBWFYk/Yb9IdMvrosVNdI84gkKu8n3ta5KFuf6Gk
         KgtGKW7pgAtVaFlp/AHRtUrTstpFtOiwYbkuRCKaMUqV5eWy/nyuN0uX2okiVwOIBimJ
         yVqH6F6daGESvoZhaGG85nWMNqcl7iZTLdYpNSDn/sb594zeFdkwZ86wZskjLgemqx85
         VNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405974; x=1752010774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2FCNKCwh9PvjlU7ijHy+Usg9/eSYsjcOSLSWrMIa7U=;
        b=gRt9dYI3r4YtdvxfNL9Pa4w4suNrsgrgRdrG+j7ofyvhiZj88XNm1hm6W7n9EpiZMU
         JGt40x9c93Kse58pAXZezBoJXl2V3fOr8DPrkQaTP07rAILd5Bf35fzHkFZSmw/DjuhP
         URVV3IdBRge4N0vwlhGZG9IViLbKMS45V0RWujQYRDet5rAzeRC0REANGXYWxUC0MJf3
         OYP5hqhiaT1Ve+6wOs2xMqwtr7gbF3Q97M8LSJMAQyQvQWWJqJt/zMu2NpCywJVh+yUu
         61ymSC4n97Th6vDCUXm6ImGFeV+1wffRotj5mSsynVaSfd1gh89JQHxbb8827X9dGjaS
         QK9w==
X-Forwarded-Encrypted: i=1; AJvYcCX5TzapIjitAPK4YowcGrcZ7rQkTEfo108GwZAvRHTHbU07CKztHDofGb8g9KZgJsNyqAJBgfqleyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5O2u69o+imZChaXITKMr2kojmo3Uc01xf50UaSDw1gbWLS5j3
	1JXNrGOkipfdbtOjPBAKENarddHkItiNxjHkTG9vYn40WcqqH5EhRlAbt705NeCRNQU=
X-Gm-Gg: ASbGncsra2tdtrHX6CQ1s2FhQIXWeLBdrbQvAhMuPvaTFWOv/Q7K9otydPRajQ6adGx
	J1uQ9BWebVH3RvOrdAr19M6THMnQBt/0QuA9zKafBqw36lmPVpIAhT30AWFdp3immHZsTYNlPPQ
	SF8iWLXYYjIVx+aWR3tZj0FDU3UcuPRU6juOWyv16R3Jd05nuotCmkqJIVEdD3F2PvRJTRNsjon
	JFE7QVYS2JUspAWxjRWYyOMATI6baAn5FFIlzw0RtaXKvpruVJ/QqbHbR2CmhLL23HH5a64kQS9
	nYunJ3gEEKqaosuS5FPbjRxb8OhPGFjuwWJ+gPgRCyifbxjCuHfUNuqbBV30dklbf6xtUY7xyGw
	BHZs=
X-Google-Smtp-Source: AGHT+IFOQRYfDvwgeMufDGbyUL583xaYoWA3vjZvR3oblGtKTc0TAcnFq1Nd8Z9bQbtdkT2H72dBdA==
X-Received: by 2002:a05:6808:1405:b0:3fe:aecb:5c49 with SMTP id 5614622812f47-40b88816bf2mr246009b6e.21.1751405973985;
        Tue, 01 Jul 2025 14:39:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:52 -0500
Subject: [PATCH v3 04/12] iio: adc: ad_sigma_delta: use sizeof() in ALIGN()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-4-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=eX4YHp/dtOegV1BsNpjg29XkjKcYwdbRuJEkdrbboOc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVUsg9stveBrxGDVhLGZYC8y44lXhmauYRD5
 IOfBQIKOY2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVVAAKCRDCzCAB/wGP
 wDRfB/0UmeaGt77fPnm8zNrtXCMu1IImtJf/qesmSMZ5xa9lv965FBpPpUNNECXWK2qxmuLyg2w
 y7HGG4Mj6VDqWba3HrXZC/u3JlxaKEmKh4vRp5aPypfP3Rul637HMZekXc5uFp9SHwLe8HZIYC3
 ApAzK+RpJGXFEsypw4xhYK8qo/4rS0R/WlmdX2g2SI05t2i5Bv7qshKVvBTsMLNOidHkLI0D4R7
 nt82jABxuHUEMyY1jE6wsSKqZ1AkNG8R8ZqwCp6mn6dolf0V+rbXnz8DaovNXJMXqkTvUyynsUC
 r5WCT+vOdLgFtuaLWePSV+aehgWr6My2A+YtlD+Abbewn+dm
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use sizeof() instead of hardcoding the size of the timestamp in the
ALIGN() macro. This makes it a bit more obvious what the intention of
the code is.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5362157966d89cbf0e602716aaaf0b78f3921b11..dd15c357d1494bf5718e50e50a514cb4d4556f2b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -488,7 +488,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
+	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8,
+				 sizeof(s64));
 	samples_buf_size += sizeof(s64);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);

-- 
2.43.0


