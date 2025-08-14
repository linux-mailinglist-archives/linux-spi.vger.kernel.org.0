Return-Path: <linux-spi+bounces-9420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A35B26C14
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AFAA03590
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6EA280037;
	Thu, 14 Aug 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qpw4hO0d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9982561C9
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187628; cv=none; b=WmReVGG5Eul8W4Oz15JDw7MbB/N84/xRbYEUdZ2uyNhKjTs2qNcirp3ClttkRkA9EBJR1n3Km72dLeGD3MPtxNoqVwf4I3EAJW8CCqruDN3tAmfWXw4bG8tw287t8ZFX4shSSz+Vs0i8uHt5JlPF+xj5I5Mt1oLIvRDp+YJ5y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187628; c=relaxed/simple;
	bh=tGr7ZdC9lWhIzCCUsw+rFlJmgOHa5c1oy9NRasjlofM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hg4PL+GXRKATMtbe+78lxE7iUMHmTfSP9UA76QjWWdRtZ5OKb6aUTZoI+9T288oWeTkoD2mO4IBmWK2dTPI9it89AYsoofmJ6dnZMl5FPhrm7SZRBoYSD/9GxUh3PWN0rLhAR5NV6GgJzEt3UiGap3TxCzMbHVn+Wd9bVLqzsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qpw4hO0d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso5784935e9.0
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187625; x=1755792425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIP40WisTeT4zrEy6wQwK47oVAaa0UgJRrDSFCcyNWg=;
        b=Qpw4hO0dtRi+GaLCNUcinFGipsBEL+i/BFhL4ouvTZeBy/fZfOYCvQ2LXd3+6CXxa1
         X4BXls5DLFYyej9wdnEspJL5svTXa/N+SvA8rDaTrkKbNxozcnwgqzpQm+0huOu7wdYc
         Xt0N5GQ9XhwMm9fk7fHmsFsCE+QiY54o9y9So6k6ATPg4QcESDo5C9p37CbwOwHgowA3
         WshOA4B8nMzBqLQXB3csqDJ0WmchHB0lRAp1VT1T9eKUXvN355UyF0iBYEMrzdd/IeS9
         CaVC0ZqpeTZv1yWUGhUDpRG510PE4aMR4sTZ96h1f8lFGIJGtMC0WaeP8IkjfooyVTLb
         oeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187625; x=1755792425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIP40WisTeT4zrEy6wQwK47oVAaa0UgJRrDSFCcyNWg=;
        b=Vf/bpNvNgNUmjeyaATHIkrufcYBTWcWxQGOeh0X9cVmpEMcTEwZymNroahBXIL4Eiu
         VkyFwgZAiWaMIx6VDXJGVfPVVkwDCg4JFyKM3Z2ruCIRKHz2k7PwK4b2jtX0B58U+PbY
         TS4eju+5cXId/H7YtBD4U03b/jqR584JiIs04TSJp7NAaOHTasI5VB8oHTGzs4EHJimM
         FOG42aDs2gaH0VTDw7FRu1iXMwRO3v3g8dVp2ljUjjfaMYAP+pDHcvukcCvHbW1+JzjN
         Y1wYTqUS2NUcQZollXccZWVksONT9lHdO+DJok1eih1JAc4UHZ5UFB497/agxhOg2uCg
         /QOA==
X-Forwarded-Encrypted: i=1; AJvYcCUjcwPrPbqiJ/PHX5hqsw2Ecnt5KWPK5Y4ZkE3ADUdJs0aPT1SeF5SZMVP1iwDQuJexaqW0tKCJbY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKThEqMblHBy6jLck2oGL0GLOwPwy+/IAoTi8MtpNyX9ERNsk
	qqdZG0Oy82TswGs9aC0KQercPiRZJ/2U0RRRAh+J7sWZm5GJfqXy+/zjhjyArcuhaDk=
X-Gm-Gg: ASbGncsCit55MOGFdmZQvPE0cQ1gtfOXqYkqMUykF2w601IREQ098N0k5owgbm0xDfB
	kkEnCL/AH9ktSYfn/GFNDAv9Vm6PcT3+KPbP5sSoErDm2d58eDbVQD5iYP28gk2FH6pX9FCOZH2
	+lEnh+u5Ve6Xj9VHike+HpVhYdjFfV3ipIRI54n2Ks7MIKi0UHPEpRM1FVm/rI8p5fuSKBeiscP
	C94JoqbD22X+vok7t++nS6hUUaaldDpsPPgcttEsOsQ1i1eaZIxxHkWEUNkQTvFAa1hJGDvgDm0
	ibrDc6Evu+GPvR+FMkHOD7CFjkQSdmVSrAJlihisLgKuxYueADtoiHEH/P6RG3L7YXUtQNd2bvf
	NXh+hWYWY7HKY0TWQMKISxvwQA5HSoQY=
X-Google-Smtp-Source: AGHT+IFHK7GjTXRXCwZAe8/WmOBTSJ+eME2lZCidVPBvgVxCWAF3s0hzjYhWMNTNHWm2p91GYyv0Yw==
X-Received: by 2002:a05:600c:4715:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-45a1b657876mr28054405e9.25.1755187624778;
        Thu, 14 Aug 2025 09:07:04 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:04 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:43 +0100
Subject: [PATCH 03/13] spi: spi-fsl-lpspi: Reset FIFO and disable module on
 transfer abort
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-3-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

In DMA mode fsl_lpspi_reset() is always called at the end, even when the
transfer is aborted. When not using DMA, aborts skip the reset leaving
the FIFO filled and the module enabled.

Fix it by always calling fsl_lpspi_reset().

Fixes: a15dc3d657fa ("spi: lpspi: Fix CLK pin becomes low before one transfer")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c65eb6d31ee7..aab92ee7eb94 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -734,12 +734,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,

-- 
2.34.1


