Return-Path: <linux-spi+bounces-1288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971E851708
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81606B28AFD
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B44D9FF;
	Mon, 12 Feb 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8vYvTgz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427894CE17
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746649; cv=none; b=QGrNpZL4zoDQz9YPhBZhWZlQoSPEpZ7qtSpk6CQsdtvnRhs8fcfIX+3JbNTyPGrymOzLK1ZDaV74U8gwpV8UX9jn2nQWsmAVAA8c8E2WkWedxqpBRCZkPGeQ2potAm/g8DhxnrfDBKJZYORBsrPtWDEuLGg4457Fiu28CsnykAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746649; c=relaxed/simple;
	bh=QDMQ1KkcYtiV6MjOl7LHm4vYVsmfWSXZLbn40VwBYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeuapBaYl0VWgGjdJ0yHQcPhnZjyT/oij6xKhMK68KOwlfKDCd40JPZmnRBtwwHyE1OX8qmEhuFMUd9yNtiS0nxLMHxf1lHqmwedv0ziqNAtZGgldjE2bQweyoSqbdiQWGlaX4YGIv446dpyXrV4QckZ5+GqMyYKo5TigU+Std4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8vYvTgz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so1756200f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746645; x=1708351445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzqxKaIV5lycuIt7a1okhuIIh6nU9oeZCJpLQ+HKFAg=;
        b=A8vYvTgzQnYDCOacYkD8QoBCFrIExkw5mJYZKKo5Y61ZCuX9yD2upsqKDyqYEEUTMO
         fyIkhNAH3tclSs/A/Lctckf2dRnyyR8gtkz7zOoYr7qVUjWRKdX86/bhJNvbt7sq++AM
         aEcBOVsYiVKUhP6tctB864/ak1wvIc4LkgwJcNaUZnA8Qrc/M8Xhzr2ZzHT9Ww/+YC1O
         k4nrYg9KnrNsOg3KLEuBilrAZ+6AVPCO1AC4/hemsUzhDhUCVvRvNN5LWZKRol99wZqK
         juyIpnfq4J9kq2Fa4ay/7IHKw95lSzS5U+EE1RSNW0UQnIMwNxXQixjfD1jONJc4sHvf
         jFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746645; x=1708351445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzqxKaIV5lycuIt7a1okhuIIh6nU9oeZCJpLQ+HKFAg=;
        b=Ln4AaRi7uJQXNZLH2gfLqF8XHML+TEwHmP9qRwTbEblAhL4flqXKxkrbBS3Tf7/Qvs
         eKaTMCjyYRko+AJwwnDiR1iyF9BJHfz67YvbQ1UQTx9YkNOYjq14drsqViEc6C112XB9
         fkfIWM7ovJc3RCyK6G1dtJEWN1CdaZ1zoo+d6IRm4nXK0PSGarlECKdlhqm6ni6m4sz0
         Fp+47jEICRtitVkrM66U+VPIZBX5wglIWLD5leOH93FA+HpmaqxRdTegwnH0HHpBW5Py
         /aT7b63jbCr2pY5xOTwbH2v+7239LkqzpbPFUZOYlR6xTnDVP0Je2QwVI2RKrxO29104
         qe6g==
X-Forwarded-Encrypted: i=1; AJvYcCW91hA8S3yu7/LvH+lZBbLWOwCmQBWjytHUEhDx1nRAslXvmGTJ51Zx7km+355xnH7rsvYqF80+7E+UlhxklpGoQJb42SJupLym
X-Gm-Message-State: AOJu0YyAyRuWl1+iXM4Xa9zbvWZRfrQXSFKD6fSxdu4LOoWH0UgUA8mi
	YPKnxWqPaF41pUl/Pbge3k1HD0iytP0Zyz1e68IsmnXW6UOubjtl2a7f7Imc+xY=
X-Google-Smtp-Source: AGHT+IFy6aDhjr2oJ130HcAfkLOXkvU+O+ob16/LkBpNY5N4HcWxyaK6sZ3E8EGV969nAunN59KVVg==
X-Received: by 2002:adf:eac9:0:b0:33b:7947:d22 with SMTP id o9-20020adfeac9000000b0033b79470d22mr2896136wrn.57.1707746645615;
        Mon, 12 Feb 2024 06:04:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoAQdPDjEx05yUQKNJ5YW19Z+nEZfGE5BKVBETz8rQvifVDgKkiVcO2vhxCGv7I3abloAAQMUTrSt3HZUu1hnKRQmjgYWEdx3Fx417AKeLfYRrdURrCKf4u8fvJAe9X7N3swQHP6jLMIjBj+8WOHIMkkdBzWRKTvKoZbcKRxdNLc0ZI2Rw5uIUmtM+GGw8bid4nqe5Fh37dNlKfvZ/nlCDHIS8xr/6X1Z01RvFMZShuEoyxy0MGsUTpCHdLqJIFywsuWJTRiRWWhdFfATqmkIxEdofDlg5oqd9yJXDCAWhTEXahk9yFIK9T45xAWj1hcYX/WhdX4IMO2Gxl4F+VTObdCr+2qnUSjaxjCZxAZAj4ZxpNrteSsVEX/ErAfECV2CzTZWl2fzgQuIF245xuPavSmSrbyjpYlgFquvUeFtcRHqloQftpPqSxgbNGv20faz67RIPgKmiUoL+tT++3P/zr7X1KxetLFSF3QG7H2oPKBtk66Da+ISCcfq1f1171mbUEcMyJqwWdSAx2seFVEBe8+SV2QmKn5X1Zxs3VGwTkol4yU0hzrw7XppoOsX2GyE/kKwEIcEswoxvkqdETEZzv7Djj3EyuUGEaZLE9B/7v2ILTvA=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:04:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 12/12] spi: s3c64xx: switch exynos850 to new port config data
Date: Mon, 12 Feb 2024 14:03:31 +0000
Message-ID: <20240212140331.915498-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos850 has the same version of USI SPI (v2.1) as GS101.
Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
config data.

Backward compatibility with DT is not broken because when alises are
set:
- the SPI core will set the bus number according to the alias ID
- the FIFO depth is always the same size for exynos850 (64 bytes) no
  matter the alias ID number.

Advantages of the change:
- drop dependency on the OF alias ID.
- FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
  IPs, all with 64 bytes FIFO depths.
- use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
  masks is misleading and can hide problems of the driver logic.

Just compiled tested.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 784786407d2e..9fcbe040cb2f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1576,10 +1576,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
-	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
-	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
-	.rx_lvl_offset	= 15,
+	.fifo_depth	= 64,
+	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
 	.high_speed	= true,
-- 
2.43.0.687.g38aa6559b0-goog


