Return-Path: <linux-spi+bounces-778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB6E83C5B4
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CEC299427
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1D12A174;
	Thu, 25 Jan 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xafGNeb9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08B1272CC
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194235; cv=none; b=Tz6vYA5Omj1YlTcW7lSRpTU2fsCytGirlSyN6ehJq/CPA9R7e46reqWxF2c0IDok2ZVGS2Vr2JlJ5QhTMxQWFb24deRYmWij4JeY07ZjqkZNvewHorp1a0nvBdTnLZXlfrrtaNCbkn1xGakKi6DjO4FfXakT+gd62YW0vJOAg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194235; c=relaxed/simple;
	bh=7oC6aE7yrHI7Bg4DPsg4ndJWuSNI1iWWkA69lQkaI/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJdTODSj/A+77fVCXQ6XR7zLpIIidbLRim+JgXA2JoxWJuvluuQBAd+NnDeCi/BCXbzbVgjpE7O99jkdPNXxzUAJCFpmjv8PnOVhRhX1zm6UKn412gEGggtbbn0Y1XsDvbAAiS8lVqF2M2NsoIghqGAZDRpxnTI0om89PhhLMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xafGNeb9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so3723646e87.0
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194229; x=1706799029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/zPTXzuzucodd7Jc2j/c0UTTlvdcrp8MZ/snSSgH8c=;
        b=xafGNeb9g1N9BbZ+KZut6Dopm/J25MczWZHvv05s2HjviOwn26Y8VjEN/sxJ0OSVw8
         Bvg6gtBTlOxyeaa8e0t9w2nOcL8KAQtPZ+hTlurSC7iuIivbbdCzxQiTo4As6KDY3h4L
         8ywDD9DHeCiONQQa7Bn5ZIvP1gcgkoT8kc8vprFl7Y61juItgWMxLTJpqLNb3ZoeRY2V
         MHZKbGJlhNssO/k4JGdA78Tj4NB/CrbU9kDpHwQ2fsDJwxPOSL+E0XsObo/Ztl61CO28
         Xm+3KIuTH9Za6DtmVt0suOsfZVkHTQEjPAC2cu01/nNLoi36TnbiOVcOh5Pp7zwYg2jJ
         csVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194229; x=1706799029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/zPTXzuzucodd7Jc2j/c0UTTlvdcrp8MZ/snSSgH8c=;
        b=t9imtE+nBt3mX5vD2g8HqnKzkJJhgtKdoMdtTDSAWXRDuqEtuFTTutPe7rg7CSS2+w
         hnxHvPv78mQRmwqpRyVx4lSJZa0oY8AQ30kXGQGO6hKralo0ltayT2Ot86W3+u3n+Pcr
         G6n5L4KygBhrdqjanJMeczkHI+r+suTaJzNllAJIcMC7LfI0UNivncCa8z8ZVHXdNB6Q
         hl2C3uEkS+a8pBGm4oC9cpN8DoQ4b2FQcZQeYZgMnk3i5dPELWRa37nSFJ0+7qSNpKyC
         PMW5VkHVjJSFcGrix/hfMr+5HYKDZqEAwWbUvakvCOdJUuuiJpRN6W3uP7PqOESYIeZS
         2WxQ==
X-Gm-Message-State: AOJu0YzEWHYWulRcdLmyNAylumOmKBFn+vWpXNcBUyVSJwc7lHSWacwr
	VI1gEUR/pdTetVEt6YWuQ7GhuGQs0JY3RQXof0iEtxR0xOAgOBpiF6SrYAF1OWw=
X-Google-Smtp-Source: AGHT+IEEJRoUMypCd5WxAINWuuyyAtoDoV7u9sVIAu6LKI6SWWX9FrZs5lQFbxcY+zk8kyfwTvqYyg==
X-Received: by 2002:a19:ad4c:0:b0:510:7e4:f2be with SMTP id s12-20020a19ad4c000000b0051007e4f2bemr790436lfd.48.1706194229248;
        Thu, 25 Jan 2024 06:50:29 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:28 -0800 (PST)
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
Subject: [PATCH v2 21/28] spi: s3c64xx: infer fifosize from the compatible
Date: Thu, 25 Jan 2024 14:49:59 +0000
Message-ID: <20240125145007.748295-22-tudor.ambarus@linaro.org>
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

Infer the FIFO size from the compatible, where all the instances of the
SPI IP have the same FIFO size. This way we no longer depend on the SPI
alias from the device tree to select the FIFO size, thus we remove the
dependency of the driver on the SPI alias.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a93ed4125b0..b86eb0a77b60 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1381,7 +1381,7 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 };
 
 static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
-	.fifo_lvl_mask	= { 0x7f },
+	.fifosize	= 64,
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
@@ -1389,7 +1389,7 @@ static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
-	.fifo_lvl_mask	= { 0x7f, 0x7F },
+	.fifosize	= 64,
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
@@ -1435,7 +1435,7 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
+	.fifosize	= 64,
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
@@ -1459,7 +1459,7 @@ static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	.fifosize	= 64,
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
-- 
2.43.0.429.g432eaa2c6b-goog


