Return-Path: <linux-spi+bounces-8449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C9AD5689
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A493A2C65
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E57283CA3;
	Wed, 11 Jun 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3KnW3Uh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEE27145F
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647394; cv=none; b=labxLbrGlbRQ4gPODYRWeE4nch37p/Tymw+bgNSlJqS8bN/wOYEtBfkdf8Tt8o6FWJyceFQClqpnlpLotXv26YGoZFtEwkW+Hf7iH6qb2dPfAI0Uus0gMybJNKjZJ0oPv8uuE0TX0sz9mPvQiJfv7wx/aazHBE51LL3zZhv9E5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647394; c=relaxed/simple;
	bh=L2yruaMlTjnh6snqZlpt4phoeh5TVI4kMDcp31WpKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CpvSVKdbL/Vzlx1f4bdmtZUHV16zJ5LK/pi/o1kfweyQulcmcH4JuZ0edX/nUWeVGtdU00YR7JfMfyIK33w/zU4o8Y6iwO/g6ytIE9RdfqPbS6LPDTOVpAaV9M6tEuzg8x3pwJwc2zJEJC/o8bxECyxRsJXsTUmKZdUUYnGu+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3KnW3Uh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so55571185e9.3
        for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749647389; x=1750252189; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZtQA0IihRFr37LmrEZeXl1GzobVsfcdH49oAK/210w=;
        b=L3KnW3UhmSOCJ6NAkkrydI6OhuvBQlJ7G3QK54wpYUZzW1wCelUqiscAOSqkCACntn
         zvIv/vnKO5gynA35/c/IPrpNt65kXIMc+GdWoikR0Kn6ZNMpzYLNciqHJ49U/EhU/S59
         IouqO1dFu86kadaRqSI604ybwh+w534FqyohYGG9usoFIs30XHMX0LUSBIzwpxZGnY9f
         ArhnNMjfnO0aMmx1Z6Wh4xTaAqZRevqTMYtOCG1GwQq379dHg5RPzdZDWVPEUHgYXISq
         Myh1B1Dj6DOVoD69p9E07cOyMvMfAU1BK8ED4R6s9Le+/Ol0UvGykGwoAsLrUf/8XRbS
         h3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647389; x=1750252189;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZtQA0IihRFr37LmrEZeXl1GzobVsfcdH49oAK/210w=;
        b=fqneh/XwRIZcmcUU4fFgQYBvxL94W1LW8R3Q6rNE0iEwGgNPMjqS72EzDY2qxIct/k
         hQzHjIPKiziWKaLf0Mk93RlO1OjiE1dYKx+ZUhFiejYqIfFMNuoGQmrFpS82FSsXWPfC
         BGjybFmAMrdyR7z2U/BMaPWfDTY0bJWLYE4WpY//w0JDrbqkM1iVDnEO9qYuRO3X4yVK
         WfahkKBsfYEKTz3uYw1r5GFR9OKtZKUeGzQCmkoV2/Ybs3PyRm8Gl+v6gwjmviIvLhNt
         8SUs+nzrGicD54H6ciRV4hHuWyaowosaMSTfrnCSjbPMcEm/pivg7VNXPedkVLAs1jKl
         NztQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEe/exPQx3aEmpXUDGtpj7+qgKwwAHSJFsQ+874nA3V3pTjG7N3PaBmdlTnW1P5VxjP2ZPNcXuz1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjWN5iWLEX149twW/5tWEOBZ6BpHV89GRvZoZZaYEtLA+TDPM
	K9ub6CWIfFhVFMBQDCh0fxv+4hnKXVKgmWr6POl63SInjRsSlRXtzZelUsfYT4g2Tqo=
X-Gm-Gg: ASbGnctdqW2Qqcy717/cbWAQxmxaHou+tm7FPV8K0wOmMyq9D0kORX5d3Flk6a7vBD7
	S45JyimdxDi/NWunSnQ9W3vRICIqOBgtTd8dHqf4CraBHn84W33YlkAqikT3uKcmEdTIFv/oTpz
	0oI9EsS429y2Rnm0KE6y/wDLcCeJAmcKFvEDO55FT8+uOeepdJ7j38gD5QyFE/qHYVVOMAQcvcR
	sAFEQN+qR/w6YYi6uCggFz8jUp6gj9TzgV2Uv/wN6XP5Ivk5rSPpqP9OwsU6Cr1X//bqJLtuGee
	Ky0XEQ6cX4PShDP+QnCdd3yWqt8O04MASRA5gbl0OigoOp6EwWVykKDDItBEkbM8Ax0=
X-Google-Smtp-Source: AGHT+IEBRO+SagBJ4t0nPcz40k+JfMlWO7SvxBp7cy9P/imnH5Z03hsajw0WU0mj5IxyTgoNyCPJNA==
X-Received: by 2002:a05:6000:2204:b0:3a4:fc0a:33ca with SMTP id ffacd0b85a97d-3a558a926a5mr2258868f8f.4.1749647389545;
        Wed, 11 Jun 2025 06:09:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a53246b678sm15078061f8f.101.2025.06.11.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:09:49 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:09:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: stm32-ospi: clean up on error in probe()
Message-ID: <aEmAGTUzzKZlLe3K@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If reset_control_acquire() fails, then we can't return directly.
We need to do a little clean up first.

Fixes: cf2c3eceb757 ("spi: stm32-ospi: Make usage of reset_control_acquire/release() API")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32-ospi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index db6b1cfc970f..4ab7e86f4bd5 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -937,8 +937,10 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 		goto err_pm_enable;
 
 	ret = reset_control_acquire(ospi->rstc);
-	if (ret)
-		return dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
+	if (ret) {
+		dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
+		goto err_pm_resume;
+	}
 
 	reset_control_assert(ospi->rstc);
 	udelay(2);
-- 
2.47.2


