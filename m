Return-Path: <linux-spi+bounces-858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED0283DFBE
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340111C22B15
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A95224E7;
	Fri, 26 Jan 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HqctojUd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54410224DE
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289365; cv=none; b=kax++Xq1NLxYqffLdqKuHP9SM41WfjVAFDZW4Voa80wqQHBsxfl9HOU5kDcV34Cfbe83tJoNRGIcaLwoFCyOk0/IbU3Kl1Odayy8ZPV12OHcuuekC0NDxGlSB9pcpye//GUJHdiXMy5TyESrL2OOgyNGAon4OP4k4jX/5N42tsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289365; c=relaxed/simple;
	bh=ZOMLiG8OpKK2k5js5KEUh5k6xN64DPRZwellQfidiYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dz/iVaK/AvNuZcjLlVzLicBGESnnFe7XAY2RAuqj8NoxscQt5DQ/m5OpuHuZqK6Ax38zpOsEIGbnqs/n+NXGpOMoUa2g9dvdtIzaAfpfXLdZvKQA3AI3CHC8QsUVF00EoJWNfb2tFKw34wWbdNdYOsuRvJ7Jxa+Rrf6AtgNxhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HqctojUd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eccf4a91dso9317955e9.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289362; x=1706894162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaPg9S8ljvJnMWoVxzFt5cFSPcbWvq/ipc1ZxlzFBkk=;
        b=HqctojUdMdRyzLzKBiCc/NGuPgWigiz29JWXrj9WgiPdKiSblsUF8DjlBEkSQECi20
         hn27Yq2Qlxg2+jWRCSPfKvRuWluTYzMOjXhaRGb+v0UnOA/2C+w2ukTGzM0GfPy+9ktR
         Yyyy7iEKz383zLTccJ34RbRlDugNu7F5allGe5ToGP5pjMewvNxTqrxTK0ztzDZJXJO9
         Oj6529qcjZl3w3lJ3MOf9+aWrENMdPfHWqvedSV76nmS2YAG2cnH86/iyDk6fwnV3+bC
         AOVJAuhnsxOQ+hHr8giZHvLUTvqAF5irNP5u8DyA5aVY8A2WGOcAek0r8rWlqVpOv47V
         Ug0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289362; x=1706894162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaPg9S8ljvJnMWoVxzFt5cFSPcbWvq/ipc1ZxlzFBkk=;
        b=IIKSvWpiqBIvxnJP7iZCg4xKZEUHFJ7nGwffVsg+nWAR+pYJry2FZ5xd6pp8UEZVhp
         4JQHgSpu6qGERAIXYp1xtfn86qiMuGhUR/b9Y7PLe20GvfV9dLuW5jTZyvSVRhhDVr+P
         TUU9N/iouf9dQWx+24gYmygDepjdsC26ZqFXZmmKymPnD7xUwbLuNU0SCRfo1XOBTtpO
         L4mEfrJACpwxGkjDR7cXeyRld16CBvsibjqO+2sYF6DLVRstPUXYEz2PByE4+6AxGuux
         2nNDX1sU8wtqRWlLFUG+gDoo7yxkzaOSc7ezCYIU69T6LJp67YpWfeIs6g8T7iOonQPZ
         uD/w==
X-Gm-Message-State: AOJu0YyT8HgHNAAllgCOsjgTTTheKxtwSuegcjUnDtF3MhacNkBoXAxS
	g930vOguLuScK8b8b7dt5UrbKId7zZbHmoJ/pDCZ18LGSkCUBTCJ03/2NcrICy0=
X-Google-Smtp-Source: AGHT+IE88z6ZKihZy73X/hJ1tvJ33+pu9VU9RoQmgEehZIq7TTfq3+V7yphWkv94NZdwTEK7BUmRnw==
X-Received: by 2002:a1c:4b10:0:b0:40e:d2fa:fbdd with SMTP id y16-20020a1c4b10000000b0040ed2fafbddmr75392wma.172.1706289362605;
        Fri, 26 Jan 2024 09:16:02 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:01 -0800 (PST)
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
Subject: [PATCH v3 11/17] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
Date: Fri, 26 Jan 2024 17:15:39 +0000
Message-ID: <20240126171546.1233172-12-tudor.ambarus@linaro.org>
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

Don't monopolize the name. Prepend the driver prefix to the function
name.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 64daf944b245..76fa378ab5ab 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -278,8 +278,8 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
-			struct sg_table *sgt)
+static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
+			       struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
@@ -444,7 +444,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -476,7 +476,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


