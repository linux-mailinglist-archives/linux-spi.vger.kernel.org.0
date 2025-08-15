Return-Path: <linux-spi+bounces-9492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA97B28548
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A869AE0388
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF372606;
	Fri, 15 Aug 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eY6gJro/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AD3176E1
	for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279631; cv=none; b=QUNXxsxXbXLdjUTvBAfl0g6kwT7K77a1W/aMWPj7i64NNrg/zxiC+s21POPvpsgsqAYVdHvqONRLnGUQmResDqHQR4Edg+xUv57QA7OTc9Yg2JUW52y/GSRWmspQZQVT7OwXOZnee7jkKlSjfaxeEQr3Mgq8m0MsJUux86jvGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279631; c=relaxed/simple;
	bh=qF17MIgwZ4um6xPpV2Lc/KTKWxgB+FMaNQ/GTgBmE8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOxTVaMjyMla8sa0TgDhYBHK5DaFkvggoksPgw1pvT72NXy8u9lsNREkPb10+vEWLGlfKQsXS1VTxccRGEd9EjrTCvXztBaWzGSX3FgCV7bGmwPsUU5hNONOk3GI/O8555q0eHb58wTWzbWUijLLbpH+c6LJYIZK7+sqLDxelQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eY6gJro/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce534a91so918412fac.0
        for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755279628; x=1755884428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrZOZjq4k19XoTtuKs4tt9bKWHaUTsfBdCOIXfyCOCc=;
        b=eY6gJro/28rcwwBMmYJMfi10PdAChUTd1zAMPy3h5ZreV2qiyciNG+oAtNtVTEf561
         7OuR8PJe66GsVdIIB7CO1Sm0N2qBcENIN8kprvw/RBDaa1/V04bzMTdqnHUdNjvtkpDe
         PPa27c1UBRaG58Y4DVf2stQxGTgQrngd899JKTnLMortNBI+6L8QmLoTEMITnDu6UIwK
         gat7o7zLkbxsXQaprg3uLpehTJU7SyFng9cYg0m1eyx+wsKdd17fecmxuFSCT8pqYzxl
         mqx0dGgKKp/Q3h2D0Q5QsLYD0b4t+zC7hfZa+DyJpxKtDevcn5aj6NYQTTBfmM4n/M9G
         Wz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279628; x=1755884428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrZOZjq4k19XoTtuKs4tt9bKWHaUTsfBdCOIXfyCOCc=;
        b=hWkNxZmKMQH0txVUf+FuCEsFcWguTZG2Y4Ob56KCPYLNwNcN6FLf2hMRHwGv2Wh8sa
         yG644VAZFbg+v5iZNgApxOvgBzp2R5tEcNYpIkMX74QGg8ck0jgzrwHeb9wDt/AtfYUf
         Xwf223+qTnrG5oRnRBIzg+Yt2yEI6IbdEMuGu4zI6xZS7hOalkuqgF5jkLG2KsSM2au/
         FG8uXcx81r5WcpMkBsVvdgrukv9D154Hign1wWV/UCT9IZFJ5hxXurtHr304G+ygCGvF
         XqL6U6yKW8zXR/YoozHgUosbVsw9GJ38FXl+03b28MnPZTUgOkJTZ8yimnofA8trbLp+
         P/ow==
X-Forwarded-Encrypted: i=1; AJvYcCU4eGNONy1nv+PobtFHFN8gfkFoFolhG5RaHqgCe9wabv4mTQUoM5PuZkyuvpVVXk6gySrsAuwQVFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6ZrLuGaT7nYe39y5ARWhASpCcqdxcUUrtUqg9lsBb+txjxIg
	QK9jynkaKl2D9vCASPp2iC00mBkFVsh7Jv4MMBPrZIw/H2b010EmIB3AJ4lngAFt9HkVeZzJ0uU
	63U45
X-Gm-Gg: ASbGncvRYsQveHjaRjjxdQrUvUE+EbjqiaB4QaW+6evpq2ygMT7Mm3W44bdp2+lSGjA
	NUfvA49PJgrh6dLVSdF73pKEMCQ/QA4he90DMIZm1DJQQ2HFU/P9skcnC9/aMqKxMFiCoxGEhai
	Hk74KKeXBxOAZH43LF8pzR5GFYTVfBy35JJI/UedotybuEuqr0ZCWo9Vti7ljUSUrduhMr+hmRX
	29SBqgM26Miy36SnXwViz1FRnRMimIANhFP2ONrWCBwVFkjpEOTtrieYvc7VC+mKy3HJloD4twh
	K0lDSZTjjp2goQknFCBiddPtMfXKwzKH4ISoF+9MBpp2htJqAUH4JbKh4sKeLJPAT6OvQDaDvE6
	wLw8XWkMFuGLe4wRLYqTcQadsask=
X-Google-Smtp-Source: AGHT+IHl+L2c6ZR5EKKpcpLYiQuhOfUmaY2rJnVDEfBWAl+cA9iUsP7QEIfUNwfJ+He0T8Rn7d3igg==
X-Received: by 2002:a05:6870:c0ca:b0:307:bfe5:481e with SMTP id 586e51a60fabf-310aaef94a6mr1697122fac.27.1755279628446;
        Fri, 15 Aug 2025 10:40:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74392073439sm405826a34.48.2025.08.15.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:40:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Aug 2025 12:40:03 -0500
Subject: [PATCH 2/2] spi: axi-spi-engine: use adi_axi_pcore_ver_gteq()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-2-13bde357d5b6@baylibre.com>
References: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
In-Reply-To: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qF17MIgwZ4um6xPpV2Lc/KTKWxgB+FMaNQ/GTgBmE8w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon3EBg0nVZ5yifanqRh0LUVGar6/Ua/+h5OBiM
 hV/k/2GfqeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9xAQAKCRDCzCAB/wGP
 wES1B/wOFfzS8yecVvgWSBk26bh8psoTA3dbqFFwwCH0OKsfz+oqil8xDxc7kg/+ochs247yzeL
 kT1wAMPnsBATQ6VA8D8KkhoYjfvAA0hyRt/hmGK/inu5c+ov8ACsEZIwoWQsgmsyUzkHkVCjIdH
 cqvH2btvoSgsmlom1H3Emu4hPYc7FbhOB0/Dy0x9ErTD2nR1Vjbl3BRpuljCjvBVyj/A/kMXNuM
 AT/hWyI+JkL7MSyuc5H2Wq7uPdMGAkNVLNc40LoxlIWJsSsc4nQrsy569Nzvr9FXTbe2kNg2DAR
 t74g6DGvEzMiDrtQQfg7e/iNJLKy7/JNegc5XHcPkQZHacJL
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Make use of the adi_axi_pcore_ver_gteq() helper to make version checks
more readable and robust against a major version bump.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 512d53a8ef4d1460a411685920f4f95802816483..e06f412190fd243161a0b3df992f26157531f6a1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -1050,7 +1050,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (ADI_AXI_PCORE_VER_MINOR(version) >= 1) {
+	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
 		unsigned int sizes = readl(spi_engine->base +
 				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
 
@@ -1064,7 +1064,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	}
 
 	/* IP v1.5 dropped the requirement for SYNC in offload messages. */
-	spi_engine->offload_requires_sync = ADI_AXI_PCORE_VER_MINOR(version) < 5;
+	spi_engine->offload_requires_sync = !adi_axi_pcore_ver_gteq(version, 1, 5);
 
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
@@ -1091,15 +1091,12 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->put_offload = spi_engine_put_offload;
 	host->num_chipselect = 8;
 
-	/* Some features depend of the IP core version. */
-	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1) {
-		if (ADI_AXI_PCORE_VER_MINOR(version) >= 2) {
-			host->mode_bits |= SPI_CS_HIGH;
-			host->setup = spi_engine_setup;
-		}
-		if (ADI_AXI_PCORE_VER_MINOR(version) >= 3)
-			host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
+	if (adi_axi_pcore_ver_gteq(version, 1, 2)) {
+		host->mode_bits |= SPI_CS_HIGH;
+		host->setup = spi_engine_setup;
 	}
+	if (adi_axi_pcore_ver_gteq(version, 1, 3))
+		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");

-- 
2.43.0


