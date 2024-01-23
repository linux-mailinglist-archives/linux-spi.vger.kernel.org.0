Return-Path: <linux-spi+bounces-648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D0483930D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30295286FF8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D5612E8;
	Tue, 23 Jan 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioSmhcqz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54860BB8
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024080; cv=none; b=bjrsdOu+0sy3BdrMjLmJVJvvjiFgx/m+a5tdyrxEblfnhnMNzrKCHrAHOVAQHGikupPtHK6HJW23JJo+gk/CFB47QsAnLO835/f/d2SwTaUmW6DCgm2YqOSpQU/AiQ7cRJN2LyqxgLlpKsI6/Q9k58JLmrVvwNYPAIdSLcsB+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024080; c=relaxed/simple;
	bh=ABSBo8ChnyWfSDmKV7SkQrHMoHBUlI2Sroam7dwUzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdfxBu6LwUhNqccq59oda1K/W1tfIJUn+lBh5hJxfmh0rdx/yT2egzRTPcPp7g9s4Afdma13vidtIJh12Z4gg4aNNJ4OKb8SpwAI8CcnUrHapw9wZQuDsq2W1n1BLNpmLPb+v/kYHQYKSqVdRyJXMfrSyaihApbJIvmjiXIRTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ioSmhcqz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso17924675e9.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024075; x=1706628875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB2Xa0B54slaxQ4TFzJZkt9rUGgpa6L4k5N0BA4Wago=;
        b=ioSmhcqzk9xBOnliJ7fe26EMcL/uk3BWE065odkQ3uhog+Hdo+usdhF6y+om+3azGz
         8ghhpKTmxwmwXkFR7D2YMYeg2+zJI6O3Ku+8PAQIgqsXuAe4YKV126pqFHCzAr9ettA4
         aiO+PVbRxZzFd2Arip+1QZcw1gpI/TJOk+wmoSFpKKAnCriPuts+P+TeKxfQtb9/HEBC
         i1nBcLeHA3BFpsoFgK9wKMDdRMz7/wt1AAElxC5dpebnVsg/qS3S+7u2NsVmd8lGguvn
         ZLAT/RrOqe03noggtPYV2klFHpdn/ISZRQbmsy7OIy+O/ZjcsOtaTPes70WOByUPBHth
         2Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024075; x=1706628875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB2Xa0B54slaxQ4TFzJZkt9rUGgpa6L4k5N0BA4Wago=;
        b=N+xhzz8C1zwx9CWQdUtdB9M6DjChE01cd5njnkNyTZEMb2ZvsmIgEEQE4NJHWD9AjN
         CD9vVt4gkatYWzC/yJW1JXDEwbHItPdA/XZ7gcOCvbhmGFDVyXdB5ter+5XpUZSZNxST
         Gka5aJ2eg0UqwZUSf/oFBdxiJLImIJYf78d+QaQS9rOmp70dGWV9KOAqxHu3tlgLzA/r
         jSTVVSzjyVGC2VE0AIL7FlW4gSRdhQPZbu8HyeEQ4uu+eNz8cvyXGXNujInCZi8dYfxD
         9P7Y80PeEqmDScTkLP4lHCp5nbbb21sErZTCbuEB1PTOVEI9PxT+OQt7V+KICzVzc9yr
         NHIA==
X-Gm-Message-State: AOJu0YzAqzMaluvekT9wCGKeNInfwViJr/lzjEo78fskTGmFWsyfyyW+
	MpHkbSWYgrBzBkMVSLrRlAZtr94uyclUjy3gGFyhrapblMM/jyXd7fYoT1MPL4o=
X-Google-Smtp-Source: AGHT+IEp2Ri4s9MSjNV1VlE0RaiDM1zebT1VTZlSVw5LZqKCz7pZak2vpPPA7KZ21bzUs72y5miHDg==
X-Received: by 2002:a05:600c:2108:b0:40e:62c9:9e6f with SMTP id u8-20020a05600c210800b0040e62c99e6fmr241876wml.184.1706024075595;
        Tue, 23 Jan 2024 07:34:35 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:34 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 11/21] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Tue, 23 Jan 2024 15:34:10 +0000
Message-ID: <20240123153421.715951-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4b13252da8b8..cc33647eab14 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -296,7 +296,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		config.dst_maxburst = 1;
 	}
 	config.direction = dma->direction;
-	dmaengine_slave_config(dma->ch, &config);
+	ret = dmaengine_slave_config(dma->ch, &config);
+	if (ret)
+		return ret;
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


