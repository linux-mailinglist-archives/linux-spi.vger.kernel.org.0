Return-Path: <linux-spi+bounces-1043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE7849AD8
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D255A284849
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB383D99A;
	Mon,  5 Feb 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVBxkbVf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429937709
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137136; cv=none; b=GWaDJUKlxjIVGf/segdSHFG5qJwjS7oQxSiTIY7/Bs4J0nXvWJAVZ9MNOaW2F4cD1PRJB+HuMaSjC71LmMPk45k0cBT0AyjZXLCOXaHDBR4EfdDYWs8x1140a2OgomAx2IppCCjD+4y085NUHh1JlzGTOIxe2FLwoLkgejlvL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137136; c=relaxed/simple;
	bh=pcCRvLVnc0tf2pnRSFEh9MBfccVf+WuKitDBj59DJ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkn9mCvplqZyXyMQo6p+Vg47OnZvthV6YLH4yB5PvK1pGhxgF5sXWP2OwGoTwBliLvaSxEoR/Bs62Io8bWMJobcN0aI3biXdzWMh1+2zqHu7GbChRXvgagR32NrfdpM/BFU1D6Df/kF7OVwpiobYrYAZx3ZvNYreR4asc1MH1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVBxkbVf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so28233315e9.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137132; x=1707741932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTE/0vC7WxQ0ABd9oJxLbbsyqbh1xb/MkKSY0UL7qyA=;
        b=FVBxkbVfzVMLv85O573n67blq7BXn81h9AvQqXIwy+pfbB73S9l8Ila5cm4GUTrpBx
         CkBzyvMYWb0fetwC23knjzNPMRB5G1rKf+QdmPfKfocZPVM+yJHK+zdsXhpNHIZbaH9G
         yCXar5CVmBA8d9xKdy3ve0XrZaq6YcMe50l4Ss45BI3WJqWen/xO4oJVZuDe16CEmqNw
         MPHyDqJCPbAW05iGRxdqm8bp5UdKHzCyp1ssEik20nw9L9FVf9c3Nfw3ZIGPoAwypUAR
         18juVE91uodiPgrzWYI3yC3kORSU7iRBLd8F3nprolKy57wBykA6bQhVv8CPcae1bDua
         ifqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137132; x=1707741932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTE/0vC7WxQ0ABd9oJxLbbsyqbh1xb/MkKSY0UL7qyA=;
        b=TVYkwU/Mt9nPEXT37/YwYvJcwLHc5hKnq6i+LZOCcFwL2VAkHTghDfdR99YVbnKA9e
         DfMMVTQ+59HOX0FLxbM9LlXNYruBW62nfeJHF4TgDY9s4IT3xYoBoKLAWQXXx9RHr9PI
         7rlGqtyD+8ggGA+aHBKS6Y3MqsMfTdi/i8ezDsovndVnY19DHPAWSjEJxoCt0gdlL6jK
         cUN4Di1Z7wd3UV67Yrpt7bhn1RAbYWekq4fjFSZJctlk3faPTUpmPquRxOiFPkO8uX9I
         wisYyaYon872mdi1ytvGjqGdfWmCTNaDQf06BhO9aLMeyOosHWuDv+7EIYJlR430SRpc
         2bWA==
X-Gm-Message-State: AOJu0Yxq6xX5DVNHbCuslIhPUxEKR9tkeWJ+WciiKcvYbHNblkSxwO1c
	TjaatbIF2uwvWYLu5lCkUo4t/QbfhORUO6+lQhT+R7v2I34W1rdpkPG1yGzeKdU=
X-Google-Smtp-Source: AGHT+IHtAALc9fR7T8Hi/V4r24s8Ve4SlEF7nzbMB27mSpni9V8hYXrKvi9LtEVW3ATD0zbAXNwfUw==
X-Received: by 2002:adf:f7d0:0:b0:33b:2200:a076 with SMTP id a16-20020adff7d0000000b0033b2200a076mr5180536wrq.8.1707137132629;
        Mon, 05 Feb 2024 04:45:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhQbKNIMYyPNUUsGm6OpaKLjLncRljyTEjlpzOjoSmQIPeuwg/T4NPRLuMf6tpq1JIJbVpYxGfT1Q6bpi3ACI5BaL3xKWtECi+tnoRq9br8cJyaWXuFeha4+PIcXC7UqZGMM4j973PqaRzOVSfcW80PE0B+cg8VyBqLyvNcf38VkSZP40ORSRftYfyKPX+zOYiSjctdWrghn92yPmJBgdUcP7YIORCQs36bn0arczXNkLUMI8vtfp87jRkjjOVUDa9yNCU/BAV1p9om6oPPFrTJ1qmX/NDnf/1QTV01BP3vPaV0IqzUnJUs41U0VUWM5hzhkNflSAGocusT1q11OktudMn1GxYToMhFxIO7ZmKTOPvpbn+nFndcFhKUYJ4ecRRvTHdRZzOGjO8Ae3dEjFCJajPhsCJNY4g3muPmaTA54+OEZ8xLEbKN1xqlCG5ZmCm1RKQZ+cTeBewO6tff9YuYGQPhThYaNcfS2g6rbEUhK6TJog2V0Awhqdrag==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:32 -0800 (PST)
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
Subject: [PATCH v4 16/16] spi: s3c64xx: drop a superfluous bitwise NOT operation
Date: Mon,  5 Feb 2024 12:45:13 +0000
Message-ID: <20240205124513.447875-17-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

val &= ~mask;
val |= mask;

is equivalent to:
val |= mask;

Drop the superfluous bitwise NOT operation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ed0b5cf8fb4d..72c35dbe53b2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1089,7 +1089,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
-	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-- 
2.43.0.594.gd9cf4e227d-goog


