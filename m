Return-Path: <linux-spi+bounces-1159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD484CA52
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505081F2A6B7
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819F5C900;
	Wed,  7 Feb 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS4nqEmd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27C5B5B0
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307497; cv=none; b=oXGtG7r0fybUfyVB088pNVHct++QjVae8v+GuF556YbXKza4DHfS9LhKuJnaipOLVzsCAhg02a/Dtq6X5Klzzn2h23GxZZX74w5mzBe6uVOV5njBcADHODJlbU9k0ek5EUSLigKlHbm7HH9DJWpEVHvUYleZlu1SkxyH6vDgZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307497; c=relaxed/simple;
	bh=OIp9JH/BebRZSk0u8jiRPSS3x+B/WlpXIe18LZxE+e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAT5RfC6d053hHSkewxQq8NgrPpS1TyUQnRiKxXSN6C29mmMYhTdvJfDi9Kvo1uqYc0xLrH2ovWTfdSv0uffeXVyMGedVGGI9kGugCnyFXcWRQVkEjv3s6uOuMnQZwXW972zwGVncvdyp1/O63OPFXQHxjE4xP7N+7mb/YXVIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mS4nqEmd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b18099411so405867f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307491; x=1707912291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6pV2GvkwiGM8sZS3wOj9QdqoXevBRStq9r4pHeBHjM=;
        b=mS4nqEmd4esmINx3t5Ynvx3+BTOB4c9Ne3lZQx75bHZiEZbhOyhpOTnZfUailb6b+T
         F+5ENTZkIMAvJRhueXHlHmO/i/tfpaM73mLjm6JCYedZp2giECtcCVs3SJdbpiS2ebfA
         VujsDNdw/9GCLRVZnBVs5vDhfB3KxmpH2ItHGOFgzb58ZN1qBxKWZ3+SkbTlqXgTK71A
         V5apmOpxJ56EfymnuXNHk8ngQSrWIE6lfuxvE/i7Y9cJoDStZ0cu8Qy13mcioQvxnzDW
         3bTJZxeYpFhRQwTU1vTJjflWjVzCDAWCkkJ2wMBS7U6RtJowPDC7zicy8R/I71tjjqoV
         VTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307491; x=1707912291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6pV2GvkwiGM8sZS3wOj9QdqoXevBRStq9r4pHeBHjM=;
        b=lSV5uv4iH/iovgvn6E6xlUlFfBhlpWuqdLIjaUvsVSRTyuxVMqEZcUhAtJP9K4i7wi
         mTceKz7wzg4PE6tJljz507I7YFVg008NLK1OCs4W4TvMswAZCGtOBLMF+qjpT0LM3e4p
         Lsdys0nHewuelEcFHWSkasdZZMCjybLPwxDRfh6aROgVKYKtRIlgvyVdFAJbg/layL4U
         3I2YHdKcvqoVB7jHzOETy7HG5VHpeVVharC34IPeQplR/S82jaT30rTeY8xGETrRtmAb
         w1aP8Wb0OD51V8ZNEh0NrtxXwEmhuE07MCOj9d8lJZ4NznTiS06RXYlfUx3Jm5xo/176
         s0bA==
X-Gm-Message-State: AOJu0Yx1GFv3I96+5nPsVO12vqQgbpN3kkqcCxUDlHN5E+PmdCvNlhBh
	xlF81qW8WKWlgfOSuKbo4ZdD1ABjS9bsVyS381KxAZk1HhKDOj6DApBJbDEiib0=
X-Google-Smtp-Source: AGHT+IEdlw8JH/QSRtZd610quS8/RIT1PIG99ZFWjrLwu4MmQXZ8BT3xN451LK0X9PBzhn/DnxzkDw==
X-Received: by 2002:adf:ffce:0:b0:33a:e9b5:b14d with SMTP id x14-20020adfffce000000b0033ae9b5b14dmr2977897wrs.65.1707307491634;
        Wed, 07 Feb 2024 04:04:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9mcRhUWoZkdqVD1YlZ6mDdMCTzp1K/WKzzPN4YOBL5kh2SFeTNNxJZf1WDk1W6nxUSQmICF1O6KtpyZarM4cbiucm88AXeVYKYiuI+uqjA8Pp05Bpm64G2BCdofnYzEG6DmG4KqN191ATxgJWReswzMyc/nnJOCseTlvj5o1G73v8XSCr6Kx8veIaeF1Z+id3kC3qqBTdRl2yOfTQM1p94DZmpY3FQ9wcR/Y588JOHAwabMZL4posJJnzDTijw3mPQUcOkXyqiD7jO5vbiUIJBCa8kHXNZfsIVsmyvpmdoM3HTA74Vq42TkhtIfbdVfqqKjMsVLNyuap1GuNGx6TiXFGmZ5lRD89Bd5vXETxVKdGLQI1Vu5KPVRl4eZ76GKjumcZbNppknmACOU9ujo7bcbtowkHm5azyJVZeIaGECyW9I9fYYtiKufG6vZouxyW0geiFIuOBN1JW0rkOb90zn/G8qizQ5DO4UnNTzuQAHLQ3Jt7VwVy4cfR1yA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:51 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 14/17] spi: s3c64xx: drop blank line between declarations
Date: Wed,  7 Feb 2024 12:04:28 +0000
Message-ID: <20240207120431.2766269-15-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the blank line and move the logical operation in the body of the
function rather than in initialization list.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bcc00cb5e0d1..d257c4f5623e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1360,8 +1360,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
+	int ret;
 
-	int ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
-- 
2.43.0.687.g38aa6559b0-goog


