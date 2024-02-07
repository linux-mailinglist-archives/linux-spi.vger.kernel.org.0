Return-Path: <linux-spi+bounces-1160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9EE84CA56
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D1B20EF3
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE65D733;
	Wed,  7 Feb 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMSNrQGA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCD5BAD4
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307497; cv=none; b=nmHh5MCQuE4qzSh+YINUWArHsjZKgLuWz4D4MOuPHvmobag9fR8S0mqUHwlFe6b6Dxx9oNKo37ncUjf6GJZqY4066CAuWNxeRokErw8Ddwji/1lrdh9Kes07hDsrZ/HVB5cljc/1laGVEgau5bdJAs+lP76Y84PSiLXq++T6mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307497; c=relaxed/simple;
	bh=7G2GlqK62V886iyFZZshyXOs/6SvUTM52aE4t6xMb4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL9nS0L+fbqWnN/iHpmr2aZT4S7FSKS7/F1w/m6NvA5yDTITzYHu4w4Jf9WAatIFvRPgzE+lmqHUmWSNQncXlCpLFeHnZx4vDTR42nlF/5i3UKhWOjn4T64McDBrq7Dh81Pg70Ezd1G8B9s3KYgGROS9GbEZx4YMusa2UNAcd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMSNrQGA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b4db36eb1so411471f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 04:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307494; x=1707912294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ufnZbtzqByKMCHA6c4FVXpl44oTWg4jCcYWjZ5sNSY=;
        b=HMSNrQGAWGZKONwbf5NCDZjNrBZyc3EjyMb71QoOprug4CwbzO8NMVdZ/sP+K1AWGy
         4FRYJhPYgg4LvxlPGnisi6GwuScfAROD3ESZGYMIFcaRLteLqpRg/eTuMnqnBJfW7w0N
         yhpoW793BWEoh2bjjdBnA3PRI7HOvwZb0fk9HlQLL1flwH6k+/6S3sRxAZXAarR1R6n6
         Iss7Dyw6kyqCRkcutm1h6k6TN2vmRx2hgUA7Tt08UoTyFUF2k1sYWMAYB+xBu4Q8YWWm
         V5inO2Qo+0tQl5vNXhWyNnCoUoCUNUKyomAF8/mgpvPwXcOpVSQ7JTrI2NrTdKQc90v9
         lVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307494; x=1707912294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ufnZbtzqByKMCHA6c4FVXpl44oTWg4jCcYWjZ5sNSY=;
        b=K/jv1gVm+G2pH2+fWucGFbMmjleeuV3qLZe0bB7LV4DWwK/4z5J3FuFWYCAz+RQECK
         K+1WfmrJ5foxlAUTc5ODwzd4NgE695/OgsEh/WZVSoK7odlE/DcpjdIkFBk3ciX5V0Mg
         TDTR0FXZhSKKZ31qnDQvS3wa6ENsmtgRpTkHz0LtvWnZCNGcZ6BV7uDBgGOIdQ80kmf0
         ekcsp23KCyD/k82SSlDc3AH8kL+L/QXDlWVaUChR4i7csP5wPZ1oiIsqpZQDqDde/3Co
         qJRwyJSObLHNLbKtiI7tKvpt17uexUsYZGSOsZ6prWewqXqXXRRycrcOyY/6jfXnAEzn
         f3rg==
X-Gm-Message-State: AOJu0Yy0GKC3Mn5g7OJ26fABuidiqw6BtM5MvZ7OCuRCAYwBeUn36/4d
	+xww4ZwPhNY1i2VZ0jti6Ynhuu4uoCic+xiVig6JQFdx7XFOZqxf+AnU3kJX4NA=
X-Google-Smtp-Source: AGHT+IFZT5HUj9Ch4rJSbpsip/HdNmr4oB4W9qCQPJGoBiXBqnNcx3ls5M2NAsHLNwHzFc9V7e/f8g==
X-Received: by 2002:a5d:678a:0:b0:33b:28ee:645d with SMTP id v10-20020a5d678a000000b0033b28ee645dmr3154982wru.68.1707307494003;
        Wed, 07 Feb 2024 04:04:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNBdOIH9bdH2mdNGvnteDdhtUtg423gHhRiIU8EipuSYxB4Jnvvy22Q4JUM6af/vtArLs6sopAQyYgAGNfcDYmd53wkvBPISfzd0y2hz3Ek8HK82t5uw1PU2fLLv/hJBZQA8Qo5Qky9n2NsHsAM/yazfDafaDpQvIr1jQvtkxKDVthlEomBOD9wlt3mKqkNm7g/75X3+drUsCUY9qwQi9RwlE7kLFWk42CTQcAYtcv/18q11HfXqHNSzv4nIRR2QlRQXd421oB+UQl6aAhoQ0hVxnf0C4EhAROGBBr93NOlVU0PFQ0DF+cpJwm2ZKcGvzeZQxaJjAE9f6sVbg/OF17uJWCXSpTAK/PgprTd9oYC3hF70hM2Jc5SEgZESMTUQPv/657od8oQU7q0I2xQsbNP9V83hjk2ENO0fTTf+ZMuQKgJzvPG8P3BA71+veRH+i+KtJ0dPd1y+vLf+0/iHPVa2GL8hiJ+zr68QTWM+n69yK9iQiuHnnW9cir4Q==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:53 -0800 (PST)
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
Subject: [PATCH v5 16/17] spi: s3c64xx: remove duplicated definition
Date: Wed,  7 Feb 2024 12:04:30 +0000
Message-ID: <20240207120431.2766269-17-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S3C64XX_SPI_TRAILCNT brings no benefit in terms of name over
S3C64XX_SPI_MAX_TRAILCNT. Remove the duplicated definition.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8ad28ec3e6c1..b618efba0509 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -116,8 +116,6 @@
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
 #define S3C64XX_SPI_TRAILCNT_OFF	19
 
-#define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
-
 #define S3C64XX_SPI_POLLING_SIZE	32
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
@@ -1132,7 +1130,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
 	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
-	val |= (S3C64XX_SPI_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
+	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	s3c64xx_flush_fifo(sdd);
-- 
2.43.0.687.g38aa6559b0-goog


