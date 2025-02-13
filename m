Return-Path: <linux-spi+bounces-6812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C423CA34F96
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 21:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E1A3AC89A
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77F266B7A;
	Thu, 13 Feb 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6yEVYaQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3712661B7;
	Thu, 13 Feb 2025 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479272; cv=none; b=lREwaMA42+0N751GT6tVDjcVPpVBC8xZUr/eoHKBm54gzr+ZEqoqRnN0ZwN2pDL6OU3AmXu33HQuh4Hfjqj3MRXeUbdwDGCR63WpBtS4Mhd+yRmI6bzaCu3h+JhZjqCnNpAtNx7zBu8vRiiYBHPIl1XLT8Ibr/ZxvNOlw96taT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479272; c=relaxed/simple;
	bh=HQDZWS0MvWVnjZJ1jZNB/gjF3cSIjWMDfLacihPU3Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjmmVZwPvJTPs1Fa4sqt1IGOyS4EUJiWfIGUkGIqHovkHt29xaLP3dagUrO/BZUAqLp9kWGAWDAemb7Oees4KtH22O2lEWjvLxsMdqDAMDGHn2l0Emi8TYZoyk1rSGPLs7n/zjwt8fsg7Z/OgRFheNCn21omSY5+k0xRtP8+gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6yEVYaQ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso393862e0c.3;
        Thu, 13 Feb 2025 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739479269; x=1740084069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUETjozF1sAV1HRzCHDJTOKm9OqmezyE1AGTSwfrSB0=;
        b=D6yEVYaQ8sLNvqlh4HRKWA8c1UFcIZXZEjiSndS2hdBnejb5XL/lAT/kEi+C/GRY/s
         M6Mz/rFiFD7bvX/ZXZyAgFkWDL54DCLZNpfULBU8mOg81K1VU8f0SEZWwJSI5v3BU1p1
         quGR5nk0uQVg2Rjyg4fDjDSYSblX6fMke24q3NWDoeKsukSRUS8Z9xnoaxG/EsP4Itrm
         zbmXtqdSIGrSkz0lg6PQ+CTYc/OlxMBbUzoydx8zzggFzRsOWxJyajxs+bbSEVdy6c1J
         O4I9VJSHkSIfYMKajILxznTSoyyIKHahBKS9tInQPDI+OBg6w7A5spmi/jCgL79kZgeE
         0wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479269; x=1740084069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUETjozF1sAV1HRzCHDJTOKm9OqmezyE1AGTSwfrSB0=;
        b=RZzuGs8/Xljvf5KyR3EPUdRr4O88V7vuGenpV+iB1hG3e/iSISs4V3wsOp3WZ80h5K
         e3BPgbTeqURhGhQIgVhYx1s9358ptJYrbOssSm8BQaUSBUqAcnaUNKVFgqM006yA0s2B
         VBJJcOzKMHlbjjVWGLgZvxY2Op79pJRsZ7o7rYDrzB19onXSa0/6M3AqmDjUS7oPkRDo
         GgZz45RDyGG1vHghW5zxTOD47XHQg5NSLrLA598+9tcbBGGR0joxzobGkqAx8jhI+jca
         DVFipbTfjaDUb1OLo6eri7+b122b21Ju4LA1CvRQkiN2SAdEolPLKjOFXjmByIh5mR/i
         26eg==
X-Forwarded-Encrypted: i=1; AJvYcCUNEwwl1Q9XxAsGF0HXyRk6N4xquZzi2J0UIGXc8ge5CQUFoFYksLcX8KpVgExmLXwSHNrG8FsxfeKowr4SI18Qmbg=@vger.kernel.org, AJvYcCWE4GzWKQFYhziucM4tWmajlqZrgOjwhFisfiFsJrfifdxbpNeOCX461E1SpywUeSlEkiZhm1yBra+A@vger.kernel.org, AJvYcCWmmtJriqL4v4BtD2CUoTK4S18F7WCWNjZ3K/Z6+KiZXxASkRZu1BiDW7bQ41l9GLXPWkGOZACn4rGg@vger.kernel.org, AJvYcCWqJZGb4zX/DkdAYRWa6t2H6R2eUTq/CnIWZNjqL54iIWr9lAbn9gaMGTCr/pIjlKEEvuN32D1y9t08ngap@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5u03zQCnaMNF4hri/OgbaJz8oiTOM9GZe2KgpJPaNGX64ui/w
	48nSJe+FOzFBNX6cGDA+4DL+1ZsikTkfVMaFT8S1O+fqyqs7Jp+Cu1ZkMatK
X-Gm-Gg: ASbGnctmSVtp6/wi+rWUeLPnNFALQWdoapn8Xy6fS7IufID88UuvDs65Gr8W7loLcr0
	zhlldw0Zm18ZpepqrU1eQk6OXR7tu6x83JRFa99Ac2A1drACKk48UXA8U2ODpyIT7a1/x51EmV0
	gF9iw5W/7u7F/ZYYOU1WAibgWVNJFCTSJZWXL/CdEhQFWAV9m6nwHsGtXIvtYiw81UPRKRVBIWz
	99w0QLzNz1bnH3kX/8MdD2YV6bu1lJYd6vbrrdeQFPRIAd+oMxUbpernxS/uZ6KTDp8HqeSJuu2
	zIK8SwBK1fOlMjZvAVrFb3cGHwLrw1yje2PsqTsytpiWOp875MlKHC/U0/MVpQRd6vs6SGwQPUM
	Qlw==
X-Google-Smtp-Source: AGHT+IHXSWpNKt7Pd1wu4O/V5ZcIgriucI8y2fDXNJrEQw8A9Foh3kO6pxXQxDdlqsXOjqgU4No96Q==
X-Received: by 2002:a05:6122:32cb:b0:520:5f0a:b5a5 with SMTP id 71dfb90a1353d-52077ee259emr3992376e0c.6.1739479269272;
        Thu, 13 Feb 2025 12:41:09 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa40088sm285572e0c.10.2025.02.13.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:41:08 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v2 2/2] spi: s3c64xx: add support exynos990-spi to new port config data
Date: Thu, 13 Feb 2025 20:40:44 +0000
Message-Id: <20250213204044.660-3-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213204044.660-1-wachiturroxd150@gmail.com>
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
configuration port.

The difference from other new port configuration data is that fifo_depth
is only specified in fifo-depth in DT.

Exynos 990 data for SPI:
- The depth of the FIFO is not the same size on all nodes.
  A depth of 64 bytes is used on most nodes,
  while a depth of 256 bytes is used on 3 specific nodes (SPI 8/9/10).
- The Exynos 990 only allows access to 32-bit registers.
  If access is attempted with a different size, an error interrupt
  is generated. Therefore, it is necessary to perform write accesses to
  registers in 32-bit blocks.
- To prevent potential issues when fifo-depth is not explicitly set in
  DT, a default value of 64 is assigned to ensure stable operation.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 389275dbc..5f55763f9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1586,6 +1586,20 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config exynos990_spi_port_config = {
+	/* If not specified in DT, defaults to 64 */
+	.fifo_depth     = 64,
+	.rx_fifomask    = S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask    = S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
+	.tx_st_done     = 25,
+	.clk_div        = 4,
+	.high_speed     = true,
+	.clk_from_cmu   = true,
+	.has_loopback   = true,
+	.use_32bit_io   = true,
+	.quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
@@ -1664,6 +1678,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos850-spi",
 			.data = &exynos850_spi_port_config,
 	},
+	{ .compatible = "samsung,exynos990-spi",
+			.data = &exynos990_spi_port_config,
+	},
 	{ .compatible = "samsung,exynosautov9-spi",
 			.data = &exynosautov9_spi_port_config,
 	},
-- 
2.48.1


