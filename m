Return-Path: <linux-spi+bounces-9672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA08B37461
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 23:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459B02076A3
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87E36C08C;
	Tue, 26 Aug 2025 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeCJURSi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDD2FDC49;
	Tue, 26 Aug 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243462; cv=none; b=nnUED05RNlTF/fWi+By/WfZIMOxOeAMClDyvxR4Sv1Q8sc13jEoho1th4qrNq9UpV+cU1/bfIyTcJpbgUUR6Sf9/B6lARCcu3E2TLpUhEUvDLVqnbp8537bJC6fhfagvIWLQY16WlPWohFJHPZZc6QJXrK9JgDmtARvPjr//DVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243462; c=relaxed/simple;
	bh=rGM5oFrpE7IZ/wiiDmdO6yKZ6jGKP7Ou4X1ZQdPS+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjUZ4u1/fGc+cCd/PWzutGYPs3cV4q3saK5hnyVlkhaI+w2WVvDhGi2Os/uG70v1ZPvVIUlpb2Jf+SfnIfMDOTzr/2YunY9PM+52FVsFUupJ1Pvzzd6HMUvGkN2/qC42FYlYm3DVegLUBtcZImuyNMOhKYJGeMHIE+H9kkShm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeCJURSi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b297962b24so61047481cf.2;
        Tue, 26 Aug 2025 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756243459; x=1756848259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pX6DnEQUDsZd/6WXGhQUCkCmFvOmnaGnVWybHzRyIY=;
        b=MeCJURSiePO96NLk43UmtzgRiTBFQrw0nmMLlzXM0YLS8jTkJOQc/PiqAAs7zkXaF/
         SlblxADRrGTEYKIby4ocrah7FXnV/GHo3WWPwrqGmbT/n0ZDpTsOprDmB45GAum7NMpj
         iMBlymHRi7YBZiisSILxEuma6KMaGSirmnjMufLGl8zQ4+zO7QQzFpW04qAtW1h5vIVc
         tvmWdGf/ycYN6eyoWIQab1XsTewKtSxvYXWXJDCK2joApwfNbo51DcBYREer8J2QuUve
         pJbR5WtolxqAPUU+f7ZyCwSiEdlcpEixOGjGYXXTJu10PyBgeO4eS6LyFxenxAFo9+Py
         VI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243459; x=1756848259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pX6DnEQUDsZd/6WXGhQUCkCmFvOmnaGnVWybHzRyIY=;
        b=SuGWOGCXimckkncsU4+QxTjS+0vjLuVaXCVgtKSnIXFiqmDARJagQ5bXtJDVfRKMVK
         1pE9+DmXsyGcqa8QNoBRHL9V9fwtjg0/yLxkIu2gvjoheg7kIxsgrwRsVCEo7dGqNQm5
         4bnddEMoXXdZmeL91yu6xt0Q/20xLjEJOmZcMMRTrmD+A/tMcyBiY6/8uOfCHlZSrOGN
         Ki+Wnlip8UPI0EuZSyoWZyKO0JIxgQfpEW0HeAbqg0HUNbTIKZIB5RhahHrnzTfqZJnI
         tjhUrNQz28Bdb1UQaNwGgUIydbUeYh1sBF2LR8i+Rds1YHc5ELogRdXyzughe0iHzcFO
         jPcA==
X-Forwarded-Encrypted: i=1; AJvYcCXjZZ3HdLJqJfLxaZedXBWhKxcypl6M0haWa3B6VAezO+v1wcmabNCg/TClxdOyQqX80MZ39CJOx5JlFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpI+hI1xiHFv5L/wKeQJmyeAIs0x6bqnPGa0+CO+fTxlai0FK
	nD3EvITQGgRSJPrnWl/z83wgLpjgIPx0UI5EVdyoxhOCwNczyRAvQMnTMG/JiA==
X-Gm-Gg: ASbGncuoUlS9THlBm8fucKKDzb5o5VCF/1HQvzKw10n71pdhBaDZ4x0ppyM7Lq9LYHn
	Qlh4TRLFrzGZAYHYN8OBb9C/RNFVyYo+JidDLxdSXGshvRdx2JZpEoGXEvZaRv4en1WwYcR6YGR
	XzOfaT2oxqfjUN9ePOyVrRiHoTX2vq8GCvrWA2swZckyX/hBmxPiNpw22+7NNx2A4I4KoreyXbE
	sLYZmUmJ8Jp42A8k76tXsZLnJX0A6/OsPK1l4y5PcccePFI/mPp2V1UcXot6bI9krHTF03Y0uOa
	SLVl+jgPqv4CEyGe+8BYnYoCFJhBPco1vTDzhYECZDLTKtJwOx7P+Gy1dLqmP9sbd+tFDFXGtPv
	Op7ljy5mcR1WU9aXmx/sYw/WNY2EiAAvQGe5BLzqrvMfYE6JzWsW8DYvOvrLY0vuJjA==
X-Google-Smtp-Source: AGHT+IEYSECETbIPCVwcTqb4Djf799ep/SzYEE0PgmZU1aQo/unByov+jzSqVUxUqcO4GcN5jI2LVQ==
X-Received: by 2002:a05:622a:cf:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4b2aaa28036mr286861281cf.13.1756243459343;
        Tue, 26 Aug 2025 14:24:19 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebe6069a17sm758731685a.0.2025.08.26.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:24:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	j4g8y7@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/3] spi: rb4xx: add COMPILE_TEST support
Date: Tue, 26 Aug 2025 14:24:12 -0700
Message-ID: <20250826212413.15065-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826212413.15065-1-rosenp@gmail.com>
References: <20250826212413.15065-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy macros from ath79 SPI driver to allow compilation on all platforms
and remove ath79 specific header.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/Kconfig     |  2 +-
 drivers/spi/spi-rb4xx.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cdeaa8e711fd..f7020d35b3a5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -916,7 +916,7 @@ config SPI_ROCKCHIP_SFC
 
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
-	depends on SPI_MASTER && ATH79
+	depends on SPI_MASTER && (ATH79 || COMPILE_TEST)
 	depends on OF
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index a795e263299e..bae802e94226 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -16,7 +16,16 @@
 #include <linux/spi/spi.h>
 #include <linux/of.h>
 
-#include <asm/mach-ath79/ar71xx_regs.h>
+#define AR71XX_SPI_REG_FS		0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL		0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC		0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS		0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO		BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_IOC_DO		BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK		BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)		BIT(16 + (n))
 
 struct rb4xx_spi {
 	void __iomem *base;
@@ -63,7 +72,7 @@ static inline void do_spi_clk_two(struct rb4xx_spi *rbspi, u32 spi_ioc,
 	if (value & BIT(1))
 		regval |= AR71XX_SPI_IOC_DO;
 	if (value & BIT(0))
-		regval |= AR71XX_SPI_IOC_CS2;
+		regval |= AR71XX_SPI_IOC_CS(2);
 
 	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
 	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
@@ -89,7 +98,7 @@ static void rb4xx_set_cs(struct spi_device *spi, bool enable)
 	 */
 	if (enable)
 		rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
-			    AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
+			    AR71XX_SPI_IOC_CS(0) | AR71XX_SPI_IOC_CS(1));
 }
 
 static int rb4xx_transfer_one(struct spi_controller *host,
@@ -109,10 +118,10 @@ static int rb4xx_transfer_one(struct spi_controller *host,
 	 */
 	if (spi_get_chipselect(spi, 0) == 2)
 		/* MMC */
-		spi_ioc = AR71XX_SPI_IOC_CS0;
+		spi_ioc = AR71XX_SPI_IOC_CS(0);
 	else
 		/* Boot flash and CPLD */
-		spi_ioc = AR71XX_SPI_IOC_CS1;
+		spi_ioc = AR71XX_SPI_IOC_CS(1);
 
 	tx_buf = t->tx_buf;
 	rx_buf = t->rx_buf;
-- 
2.50.1


