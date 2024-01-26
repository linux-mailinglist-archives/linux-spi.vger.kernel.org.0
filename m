Return-Path: <linux-spi+bounces-856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABEE83DFB9
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E07F1C227CA
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288D1EF1C;
	Fri, 26 Jan 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmT5LQtA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817B2137D
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289362; cv=none; b=goWxZktSE0KRppLSgEvdKG3fKWIttermpWJQN93YLbLiM2ATP4pVKZYPvhC4Mgkm4iVaO4NfT8Y+tQR2jzJKds23kPUv329br1u/JwzROT+aNRalFsanctlCMg9HxQDMjaRtMQnwYMzmcUneI4Ikwm4oZhaDz0fCtVlsglokYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289362; c=relaxed/simple;
	bh=y75/9iSo2GkpRcJq4gCYqWsRblkSJbNeMc1hgIQCUgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTQlzVd7pe974L8zf4QDQ0cxeyzDvMhsxSAZZh3eYo1bBZ2jCoz3qxlaRFgb931rQiRvDmOj9xBB0Ua2/wWWFW5sVYSrBpkv2EugBFCk2lS0A2J25HDcRT6FgwwIcatitegG2JecIf38kqBCP5TQ78AsH2edD7/uHBaFWh6qcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EmT5LQtA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-339231c062bso700196f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289358; x=1706894158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PFQQe5L+S81TOMoMYxe1V5Ktq0fN4GeqljJCUbv5w0=;
        b=EmT5LQtAItRO7ZXqYBMW7rIn24QTq+SsoQPYpwRWmd+xFmG6h6tJsuA6YlpK0AlvUe
         vKwdnIpNse8PGM3q7gXB3PT0V02knPQfppEOuxPrrvwjFA7IK9KrYIagRFm7orOYhYs7
         9DB0q3d59jAvhjHYYbzvVrlFBcDCJ8txEz0YezTv9uCL4W9osrcTKWshoaHKqt44ccw/
         EXuQplMpKu68q/65diFVFTsw8PTrPF8sivLmrghVJv/IGUMdUKhgMBEZSovEHmIYSxJN
         dIhEix2B5nftI/59xoDrIvYWSrGA7xkAxiO5YZlPNyi5a/3PnHBq97V7qLGK+U5qxZdV
         TF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289358; x=1706894158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PFQQe5L+S81TOMoMYxe1V5Ktq0fN4GeqljJCUbv5w0=;
        b=pm6BeDh9g34VWR9Rvzy7UyBuN8NVOnUywGWYPGr/6LKz7r1X9S8yIHLGYZhPxUUzEO
         DVPDJwlV7o+pl7N8DBKRFpbyYxN1gjUzR+uoyAS65+qpN/485apBbCURJOOGIE4g/jFg
         LY46zQc1tG92IMUSga+Re6WcDMRI4lJDI4hb32LoqsOSpBzjsRmVpp0YLVxEt7LsinH3
         x283LnLcZDDMRXew02yNbRKgXUiMZYHy9n0ApoDMzHgPaofBm1+C0u2XUqnRtfa8U8ZW
         1Be47jjrKLgEQnrUr0SIs3TrQNnZkOYl4xtN7IwKRf6hQXCQvmKf+iqcPTzgtVp2UEaK
         CP5A==
X-Gm-Message-State: AOJu0Ywovablx+oVp3B0Yz+ju3CE4d/sRJKjKAyLRIzasEA2BNMsfsFY
	QtRGDcyd1QUM37VGoixaQl/oGSIQjl31xPYQy7wPBlY30txZcStBNRhAtdi90yY=
X-Google-Smtp-Source: AGHT+IEdSfPk+mvqdxvejpoS55NReR4Yc3ryLjfI8k+oBOGs8er5l4B2FW/n7fLGQj8APyuuYj1CgQ==
X-Received: by 2002:a05:600c:1d1b:b0:40e:60c3:c327 with SMTP id l27-20020a05600c1d1b00b0040e60c3c327mr97121wms.1.1706289358674;
        Fri, 26 Jan 2024 09:15:58 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:58 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 09/17] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Fri, 26 Jan 2024 17:15:37 +0000
Message-ID: <20240126171546.1233172-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bbbc4795bcbf..6268790bbcff 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -302,7 +302,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
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


