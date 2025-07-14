Return-Path: <linux-spi+bounces-9094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A423DB034DD
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 05:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758771892050
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4551D7E5C;
	Mon, 14 Jul 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3O8ZF1S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463218C332;
	Mon, 14 Jul 2025 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462889; cv=none; b=EDYQMSb48tzd2W6gu4lfUHg3tLfW+kzzqFTGlyrmTOZR2Co/PKsYyvEAyU7/Sr7bjtRbRaSy/POr+xDJRGcWgepsWJy+LiyexloBHdoXRLOCBiMOUSCGEUVlyyllQJ1k2gyD+4SPdeHqG5n5paNucshwWVHacZHjsLHejJByvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462889; c=relaxed/simple;
	bh=S2V/5srBEaCioYTrBML/AY2nMFXPxXZ1WqhziUpKJsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqrhWvoxJdkKebMSg8iEBkaeM6yUG+C4xc8nDu527TFbauYQ6voHt1K5F+VHSEwQXjdhy8Cx+ojbIGfstUKe0qB5dWbP5Ax19o7gp5Zrd0Lz/5tjZse9KTGtfEyEiPFxQYRE5Z8Jfcj+5tsvltmuLqmq3OWxLA/JsVESvT9GT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3O8ZF1S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313a001d781so2957172a91.3;
        Sun, 13 Jul 2025 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752462887; x=1753067687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=At7y0wHwJf3VmJEJIkfhgYvbhzbFcHD84ETTP6m3T5I=;
        b=B3O8ZF1SajARP04nDG+oYR8KpiQ5AARbQLM8B7EpnzLIa8KMrP2ow/Zzs6/xOxSLkk
         j72/jW5NhnMVbdxSEdHnTVW52ERaibS1Gt6taAQY+XSpPFybzuSWdsbQkjelaJ8v2jqo
         ChLcETtaEelaai1SAAWQFOGLCt0ierImvh5s8EkjdTI4LuJn12CGjFoelQe+e/4bPS8r
         Z4TJ6Cnxk7Pkp6MdqWJXiumuAXMCEmVMjh6M0+6vMHHUmgrKjFLVvZvIQx2155kN99kt
         cl1QfzdjuNMg0xBFER6BmFfmfJbkLx6laaOFFf1qfyrtw39za7t2dCfE9Mkq/35qiA+G
         FkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752462887; x=1753067687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=At7y0wHwJf3VmJEJIkfhgYvbhzbFcHD84ETTP6m3T5I=;
        b=ZUDaBLOgVYWzn1qR0F+wSAAPI+OnsDT1pLVNf0JMtcZQcG83C6JkbAmdd2AQbWJh1I
         5Dh/aAVcNkWE25jJMl0ofBrzDg9MkCc6mH4yVpBY6HElfY5EOyikSdbEZaNTqxgrcH7D
         qcqz5AwJ2WKWsZ3Ds8MlmcvM4rrkqixnpNv4KWr/wL7acFIK42mRWSpZX9GeJTvWVnBq
         JNL/WBlTvALPMxnMx6mGvJR17pakSWaXuNc80fSbFAT8Ul+h1Lb6F7wn7vEICS1VD/iw
         Kp+eApgKluglG7eWipsbdWJ/O3QWlW+Rz3xHaaqJX07Zupi57p8BF1a4Jyo/Shz9c7s3
         bxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNxTPc0e9L01QJSPhUjlykmNKq+mdZrnh4T5RBvFk1u8++AuFka0bL+jwIf6rVwBzBBcg9gF2X+tsF@vger.kernel.org, AJvYcCW70xxY1Uy9mfFH5fcRmckQ+BflN0xjiuZwIOoSSVrJclkkYHribxIFGa9JYI/sVPmDGvYAA0VU@vger.kernel.org, AJvYcCWWE08nNGfCyMRkE3mXbJWbbZ+eTlM9NFQRjoswvB/K5HaQ2oa+GYu4wNen1D2YIXBU4bzUSAZAnS8R30c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu2Wca4k25AavSMKA1wg5DeNguY+lUTJ/eTdTdvHG8dwJ9rga
	aDRunS7yDTlz3lsKg8lcfcKs/c3oKmTf0Myq8M7oEhBUJRvbyK/1WyvkFlwn1A==
X-Gm-Gg: ASbGncuwBE8nT+gZRV598qG/AY+IiQm38PFe13H6UooFfumuRJzOSgtX3YDlRaZsdPD
	T7KaL74F3BKvXRqlDmHbvq2OlAkI3n14VKg1vWT4k5/4uUF0+6iIxRXIxCH5YpyzaiiPnSjaljg
	HmpYwIxLwJUu1LmLjI0d55rc6MpTlqKMBBEHyWUtdwZ29wu0plAbKNPJR2vSGupBosl/njLwiaA
	vPu4+9PaxWNXxTYVbh3do2pLwOkGwmcDlLcg1nUchNRlCMqXiGLn9n7SlEdO7v/CEp6S/xjaEQK
	DZsh3zN1WHlDj47bh5xzJZq8Z4FGNLoFUfI49LsY074SS2E/XMuKqLfGH1f3XTIXDB2R8TnmPij
	mJ09ZZuqiHoJ5GS6hHqacvqxsNebsU29AatwBMB+8uiut5KrrwG/1Nq7w
X-Google-Smtp-Source: AGHT+IENAoHED/eb4jvWy0p9769EY7DcJ+Xr5EH6sYUWDDIzUtA7BIEM3Dzr2J0p/7afgMUFX1+oqw==
X-Received: by 2002:a17:90b:1643:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-31c4ccdcce7mr17392740a91.19.1752462886669;
        Sun, 13 Jul 2025 20:14:46 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e973e8dsm9298151a91.17.2025.07.13.20.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:14:46 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id D8DF18043D;
	Mon, 14 Jul 2025 11:20:57 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: broonie@kernel.org
Cc: patrice.chotard@foss.st.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH] spi: Add check for 8-bit transfer with 8 IO mode support
Date: Mon, 14 Jul 2025 11:10:23 +0800
Message-Id: <20250714031023.504752-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

The current SPI framework does not verify if the SPI device supports
8 IO mode when doing an 8-bit transfer. This patch adds a check to
ensure that if the transfer tx_nbits or rx_nbits is 8, the SPI mode must
support 8 IO. If not, an error is returned, preventing undefined behavior.

Fixes: d6a711a898672 ("spi: Fix OCTAL mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/spi/spi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bc0fdbb1bd7..0ffa3f9f2870 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4138,10 +4138,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				xfer->tx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
-				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
+				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL)))
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
-				!(spi->mode & SPI_TX_QUAD))
+				!(spi->mode & (SPI_TX_QUAD | SPI_TX_OCTAL)))
+				return -EINVAL;
+			if ((xfer->tx_nbits == SPI_NBITS_OCTAL) &&
+				!(spi->mode & SPI_TX_OCTAL))
 				return -EINVAL;
 		}
 		/* Check transfer rx_nbits */
@@ -4154,10 +4157,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				xfer->rx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
-				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
+				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
-				!(spi->mode & SPI_RX_QUAD))
+				!(spi->mode & (SPI_RX_QUAD | SPI_RX_OCTAL)))
+				return -EINVAL;
+			if ((xfer->rx_nbits == SPI_NBITS_OCTAL) &&
+				!(spi->mode & SPI_RX_OCTAL))
 				return -EINVAL;
 		}
 
-- 
2.25.1


