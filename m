Return-Path: <linux-spi+bounces-7145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EECA60E4D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259B617724A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7C1F236B;
	Fri, 14 Mar 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeQh5Txs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015B1F30CC
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947033; cv=none; b=Xpb1hRP6UTa1/KySaaDcgZAfLyDEMZszy+E0qZ/3alfFGF5QNRm66Hz5tn0Sl4ZuQLT5rnmdSz/uhOHu2iw/jCD3MJPmlxmB/aMcubFJ/1reT2IC0QrnS94WuERvZUnbml9p/RAmKh2Tj4o4K4U5Ec6Yw2LDpgBV6oHdh4Ev20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947033; c=relaxed/simple;
	bh=BcXDWjNDH9NxBSFwCKcCR4CNXdHbwnkXYntrn0DgUxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u0H4xDCVvT+KC2trmHcdfB9iWnG31uqRMWEmywu247JiOceDrfv5bKObGbYNltn5RlEpsHTXxBhhkiU6U97A1fQnPs9L8O7xlguD6FuQpeNLLaUGjNgiX8dGkFpq6MmRu4yOZG0Ds8FRInj1YLZ71DXqssHkoHF0sibaiJh1W1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeQh5Txs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso12635155e9.3
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947030; x=1742551830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yH/A8g/K36DzReQ5QPIAfNlm2z6G0ua2f9/UOEVNfA=;
        b=yeQh5TxsE/Zn0ovKKnABzxT5d1YlflNH1uxPrW5qwwFMmW4lZUo3rUxfBqKgJYv4t+
         kFajJBom1SGitl2Bd9/FajND4CGfl6da9G9zctTlWtt7Os221Cck0uDNmecv2/FQBpYH
         5qwYpmcUX0NRHkOcuvTazjjjnGO/d4gq7dUwUOMoAa4f+Ka7q8f/DpB4aGHHOu+DH0nb
         Q9EV0lq2Kt9rtaONO+3yLY3RVjrlfok1J6eT0volhFE8cJETATN/KymTCEje9HZuPqud
         9UpxMGL8ONEkyV8p7cp3Lp5/hAiExbgcpsbOrZYl9cXznnC1vSlaRYxMyZLoXI83t7YY
         x0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947030; x=1742551830;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yH/A8g/K36DzReQ5QPIAfNlm2z6G0ua2f9/UOEVNfA=;
        b=bmBQ02iPmYhok52rRViGlLMxPNCPcaWzw1gQDuj1SS+Bf7QWh1LWGmEq5gdQhu7L9/
         lI0xuygFovCDgQtw1LHDRgNl6NS945J+DucjqMr7snREooHZgLiusGs3Jamn7I5fONDQ
         CIGCIlwf4ZJtlutQNYiA4TueKh08Xreiotg0U7xOSELaNd7ZB6YwleEC+Ut+XM6tpAtw
         wH3onb0SI+HkgpDRwyvLSjw5ekUxkHqDudVvdvWx/2WPIg/PD9D/GYqgSOqpZlhYn3bI
         XYf879RiYZ+inwu1/XTH7xJ8UqPBUGQj3xxeR1+mX+U10pm6hFsggF4QiELmDspv/Bik
         MKOg==
X-Forwarded-Encrypted: i=1; AJvYcCV4zCOXf6Y7xjjkdAmxfDvgx2HUZqYDnSaAqluQ285RyMYXMUN2L9tUtYV5zzGBx/QhZao2YzN+hmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicQIAhz2jKTJkLspjAn7sAETf+298D6ih4/JdzLSNR3E+UEWS
	gPuKqyIvATHZEzVKyKG8cKxDqU3QC+1G2JRMXQl5t+raFdIFqW12Ycg396vUmWY=
X-Gm-Gg: ASbGncv0v87f+CyaXIRNtR8yhmxZXKlFW6y9faOcDeM9h0qhk8+CBVwhbwJFbDigN74
	n6ntcHfVlKZtOxdLdFJeayleBW1GEH80T3Q16U+F1Pit/NzghouA0/HZ0vi2eJDXDhBhZU8qemz
	SMjzCHvXiHzMIXm+xjlhd03AwIhmJxEaSRcKFPv04vbToJ+3wEUyn6zOpms9n+4/xwwNFJSOU4+
	aRqAaGIZMtyrOD/fNFfsE7J1lavH3BYF+lAS7OE1I/YOE5K6gKdElCZd/hvTjnfGim3ycIoZAC5
	J5j2r4Gm4DiV9wdkFrBYHE8KGFEZz8IHwGSGVa2LeoHOSRIStw==
X-Google-Smtp-Source: AGHT+IEECOLyJp5NIeQvulNAkbhsGSs7V93hbdXM58mYrb+Q+2KYj17/lCT2jxHZ53RSu/8bRhtopA==
X-Received: by 2002:a05:600c:3592:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43d1ec86200mr26793325e9.14.1741947030009;
        Fri, 14 Mar 2025 03:10:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c8975d65sm5143965f8f.56.2025.03.14.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:10:29 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: sg2044-nor: fix uninitialized variable in probe
Message-ID: <d343921b-16b8-429b-888a-f51bb6f2edc8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>

The "base" pointer is uninitialized.  It should be "spifmc->io_base"
instead.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-sg2044-nor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index baa4cf677663..97d6b3a21d54 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -427,7 +427,6 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
 	struct sg2044_spifmc *spifmc;
-	void __iomem *base;
 	int ret;
 
 	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
@@ -447,8 +446,8 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	spifmc->ctrl = ctrl;
 
 	spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(spifmc->io_base))
+		return PTR_ERR(spifmc->io_base);
 
 	ctrl->num_chipselect = 1;
 	ctrl->dev.of_node = pdev->dev.of_node;
-- 
2.47.2


