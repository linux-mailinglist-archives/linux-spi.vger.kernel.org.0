Return-Path: <linux-spi+bounces-854-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D383DFB3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C131C22BD1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB421A02;
	Fri, 26 Jan 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPl1UOu/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8321358
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289361; cv=none; b=ob8SzqA28ZT7Oet8zrs5Fywi9ofBXwRwEW+QVSVggKkBU/TlptGtMoArnuIDZ1zNeMsl5hrCbomcdJHCPZ1GBODqtzP7DGqcgsNTotsnxjn/FuLC0LGEb9qBu2dX2xnMigPaefHqvKbKzREV0Rg6XNTjfHjbjvFcRyM+EJcI2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289361; c=relaxed/simple;
	bh=sdxE7dtZ2UGuWO+rcbDjJI+aHitLSmW5QV5kKZjEQO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF1pGxxZbhRFkK0VW/MCtYlhXZ0+E4iUHkuUiHmpIdpVP0+puNTue4Tbcj/9ETlLVrYYIwdIif6Xmibd2WYC4t7goT6h6BT3DzjXreBqN44zulI2Erk08xwmLMiS9/PffJKihxFrk7U6M/dZyP7qtaKlNkm/lmbXsJufGWSIPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPl1UOu/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ee6ff0c7dso9656055e9.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289357; x=1706894157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4xVKWwugYgGoHizGIdwlg/22zyZrS4EMqmySuw93Sc=;
        b=yPl1UOu/YtSB3RNckXuB/Bx+nE0HSlnqe4KTwgt8LWgo4R2UUyqQGPjJi781srZ9S8
         mHz+rERjEi07sBDhmfhslGYoj7BsFYoWWVx0q2LJD4+YQhPjUKGLF9vyqWc0kkL031fp
         nrN2ZfQdWywvjg1UzfuUEBa59JrNFFHu8t5hJ07M4+j3sC41WOBg0L7FC5dSUa51YPgA
         oBwW0x3V9zcVna3YHrtn5BOIMx9DGVOa+i3aGhWqbLqzDHFgdf/XPsT9XPI4N5e3F1CB
         NKcwjUfFtIXBsqqRBqY5ofIaYC5W8hRFbP1HTNS8K4vzjR0p1odGU5KQ5GBSbz3fHnmA
         WSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289357; x=1706894157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4xVKWwugYgGoHizGIdwlg/22zyZrS4EMqmySuw93Sc=;
        b=FxRQUHXhyyTMUbLQNM9v7WXvUB1SAaeiU7P95lQZ2I+ErVqO9eS6/CviGPUusufDF8
         FE/9Q7i0N2Zb1AwHxOBMCGuA1ODZkogYj8TTdRLBilzV+KaDUDDjh1Bh0EDRye3BlA7E
         rnQrKM6+SfWAAJNeVs5OmQAI99E5imyjAB8jXRYZqIsj0WuCB/hP2OIuZHUYXKBROKTw
         1Hb6q4PuwA8lue3ksh07Qyeh1RLhHWZwmJMxojYrJshVy5EHCzdrXki5FS6taPpDCzc0
         1SVEDeiPRjXTFJ4Kz8OQynGnQlLYIXD0ozI/bEjx02VJ3H5QBqf5CEyDfMNWfeH8mtjR
         59CA==
X-Gm-Message-State: AOJu0YyJy+mjGzk3Kpo+nYEvZT6piF8rt93ujUyqYoFFUIgsI0GaH74p
	n42WwgORGCQvaPaSaEPk7YnmImaTL4g4Z5bqeXo3FGNu7/FQfYfkHLzT2Eh20ffAukJRTFqsxa5
	kxDE=
X-Google-Smtp-Source: AGHT+IEXhDE4nufHz0/LUuTfSrWjuCL+iH1BoKlo3v9opQn+OxuMuntV4aZh2UJOeFdGIflbLzWWYQ==
X-Received: by 2002:a05:600c:3144:b0:40c:2417:3b51 with SMTP id h4-20020a05600c314400b0040c24173b51mr73223wmo.74.1706289357772;
        Fri, 26 Jan 2024 09:15:57 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:57 -0800 (PST)
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
Subject: [PATCH v3 08/17] spi: s3c64xx: move common code outside if else
Date: Fri, 26 Jan 2024 17:15:36 +0000
Message-ID: <20240126171546.1233172-9-tudor.ambarus@linaro.org>
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

Move common code outside if else to avoid code duplication.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bd2ac875af59..bbbc4795bcbf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -291,20 +291,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-		config.direction = dma->direction;
 		config.src_addr = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 		config.src_addr_width = sdd->cur_bpw / 8;
 		config.src_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
-		config.direction = dma->direction;
 		config.dst_addr = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
 		config.dst_addr_width = sdd->cur_bpw / 8;
 		config.dst_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	}
+	config.direction = dma->direction;
+	dmaengine_slave_config(dma->ch, &config);
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


