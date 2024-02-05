Return-Path: <linux-spi+bounces-1035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2987F849AC0
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8F1C20ADA
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848A1BC37;
	Mon,  5 Feb 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+gR0kAe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044228688
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137128; cv=none; b=f4A9kre7DcFj/kPYDih0uL0WtvlaFoa5hnQSDxKkc5traz3oQVTm/obBqIC+22d3wGf9ehnXo5X1JqsQNz0BSxa7GqZ3V2aUocoqts51/mJZuo7hjhI9zzF0sGI4OTkkeebE+ywts+neCerz1GyEsulMGfD1e0PMfY2A4GuIvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137128; c=relaxed/simple;
	bh=fsH83Gl3RkkVFWG0rTvkjArWvOWiPFJ8T6oyUGVHsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cxd0oZ9FPfer+Iyq6e2uposxnjzNFs+c6azJfbg61eWeOatDgvhOss2BQtHF1xlRFyK6cjksNgx8sdcthd2xNXkkFEF6lyxJD1CP+cAhVREq8qWnXBSJ4+VM5xDBhFbeicEJ19/yPS8psnF/SD5HxcP+ezxvC/t2qJXzJyPFF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+gR0kAe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2415082f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137125; x=1707741925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl6pdkbEEgoE8D882wXKu1rMaFEwskiVorsz3uU2gaI=;
        b=p+gR0kAeErxWwhrUYOmh2bnwXrC+ip6xOjV5lPQghgCy8QgfIxbODhou7fNgqbYzu5
         7dd9+8rmeiJKRO5DzLAHkO+z/2/oKKYIRxSIuC2SCJ2jTsKfIfmQ6jdTeMude2m4WmsI
         Ak29rglFeQtGxumTvhMA91s+25tTALzxMWREzHlT8xvxZvJwCWmwL3F18QNB/v7fqeFR
         0ju4nwRyOWtV5qwWYAMLf5ukyEz7q+arR369UjLLecHZdh+y5P6q+KiylmsduFhVpnmM
         FYjz5KJDmeG6FNSbkyWRXQJaOBA1orvZFYO/BGooExTl3niF76Nk594Ec2ie7tPN1bgY
         o4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137125; x=1707741925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl6pdkbEEgoE8D882wXKu1rMaFEwskiVorsz3uU2gaI=;
        b=PTSfncHhErnhVGu5TJuLOjJH23MKGYxp91oFva84o9alRwFNEk2VgnIZqZ9JiSUbG0
         Jo76Uq77a3FHLUTJJBFzHdhtFXDCr7vQdG778VRCynnUJdxTKPVx14MWtvCt1gKpbD33
         lt+25ZACeZLSRt56F9grORgWTJ8oNP4J9IaPnNGzAGBlePMLfwhGwNi0jFsAR+Bkbfkz
         vHOPu1r7qJkRZNTbgBHK5s0tqS3PXXAtuV6EnlCD659pYBHSr+P7Wo3LX+sB8hP0bc9+
         plcVi0Djmsp1sR/PLelT3EmdHPyXwuT+ZRKr33NMVktYc88R2dzyxGzBb4wwmw6BDkYb
         gvnA==
X-Gm-Message-State: AOJu0Yx9yNydyfg1HTfTCSNEMiOo186ktlVsKQeTeDTAn0E2KfghSpbl
	Nudo3Ve8d/oZCRRuFmP3MYSynsmQ4uRPRkYUgLD26SuLTglzUHfCywrPRN0KqeE=
X-Google-Smtp-Source: AGHT+IEDe7EYwBHsgvEhHYw624nCPgXWvF+fc6geJZnawHKlv5pvLV7pnjnL7oVE2MzVyCIouzoc7A==
X-Received: by 2002:adf:ee8c:0:b0:33b:376d:6263 with SMTP id b12-20020adfee8c000000b0033b376d6263mr2789597wro.60.1707137125019;
        Mon, 05 Feb 2024 04:45:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVw4l7u+dPerpX2iIeIYeJpmDSZSVp/7atJ5rF2+W2qzeYzQ5703ZVXHX6x29RJ1tujigETMOU2yc6xB9Ao+8shHtUAdq0s5rzjd/tzE30Yb9S+frHisBdUz6J4HALhnWuytIGcGMaBb67tahDz/PicKwT47gy77pRuZdTEiNuaaUh5KBKMkZg6XI6XPftRYGE+Dvq9NCuIe+EVqKDF67OqHcGj1u4R70DsCpl1BYgbGaztewDF/cS49zmboaojgEHV0ULVsNyH63Bqr0FuFKIm3pVNFx/zkoaXqPRzEhGIE5hr51KE5BPnMbiO/yl7I/8iQ0y8Fvq+z5gMree7F2h4DSk6ZzMwscytFapnDl/E7Q1tG+d/k8YjshGcKs8xVlQN2i6z8q9RsIfyLpNLqlUCgXKTk7KD+GmpqvLYS2Xn7ZUZqjs+BOfnbyR6ryCAE/FYwoEr9+bokYIz5jAsqbpz9nqhiL/n22QPd50RgSvdv+LbvnYht5g7n2vgIw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:23 -0800 (PST)
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
Subject: [PATCH v4 08/16] spi: s3c64xx: move common code outside if else
Date: Mon,  5 Feb 2024 12:45:05 +0000
Message-ID: <20240205124513.447875-9-tudor.ambarus@linaro.org>
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

Move common code outside if else to avoid code duplication.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3139a703f942..fcc1f16d3ad1 100644
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
2.43.0.594.gd9cf4e227d-goog


