Return-Path: <linux-spi+bounces-10017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E22B56FE5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639723A29DC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E419DF4F;
	Mon, 15 Sep 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjuPvkPx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306092741C6
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915407; cv=none; b=tt8gXQg//iqULwbgpY/0A3IjdApNdKpQfJOfeaZFc+RuvdYugbkgSTRdPbCylIo1v4tYU1fdkz0gup0kiOOiSeB195LmfNp+OqpVfiJqm6wQIp5yc9fHwC4DyCu7pP0r/uSQlRFyTA1qLEM2JGMGdIO5BtoAnWXHqzVUoZYOgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915407; c=relaxed/simple;
	bh=fiwgx8MAD2XVYzvxjkvb3XQ/m9LZS2p8t8MWQAfOLm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AymSdrdZIW1e5mh+JJs9T+xlPZSluixR0gZ7rpeDG2An4PmD4KpQ5MQm/fb0BDZzSHhWy4+qNSO1bOqr5acSAKjuQvyHtIyLiQKFTnaeL0jzEvP95qPZ9jpzfAtAe/VNV4opSBR4LhBuwF/ouZ3J6w9A5hILgTWMR5LfuK7oUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rjuPvkPx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso1102545e9.0
        for <linux-spi@vger.kernel.org>; Sun, 14 Sep 2025 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757915403; x=1758520203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/wBl0xLLFWVBpKxMI9aJF68zcNMG/DejRgIpzGZk0I=;
        b=rjuPvkPxUiqWiJaP8vf/aMiepBOJEAd0AvORKY2TuO0BPT9Lkxd73FMpD6F6QYfJu0
         AdQTW7ozH9XSBhaPmcIyo1jnnVMSzk7ZV7+Wxw3AWy1OEeo5dxElTtDAosnGpZVde6Xv
         v2uCnraqcmGtZtB/heNWDONqlxK3+HvJuzKxVxNVm8q5lRkTk2jcsnqCpZSEQnV7VKmE
         WU+gYkPkim2pSV7vqL/OSZTLuU/Wpy1zQK0KD/GGSAVbWevEz1hC89ajfeT1YxD16/2Y
         M9IONNcBVeAH6bBKQpsVTmrDkJUZPUCOFAv/sL7abOJ8Hl9uTDrH1832TYyqM6u+NvRb
         63kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915403; x=1758520203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/wBl0xLLFWVBpKxMI9aJF68zcNMG/DejRgIpzGZk0I=;
        b=t/x55jAvw9qXqZsCw9030CVCh+nBLjZJMGYZB2e4dhtj7AyVBD3wkJoN3vZFbT2l24
         MqH+3jhQ822sbSV/38gezrfAMyo0SJyEdtE9Ac+HFTVojpTEFHvim73phKmkHuRgzQlm
         W3MZ8PZNK5ZnKi/tOx+YKjktpygBMXPwG17SkBy7C/b8Y5AQJG3PRz87m1pl82E7Q9ui
         r0JKP0zChunVLwTfFYnKcKEsNLeM96fSBbqN7UbNknpiSAUlGYyd7Wn8Z9Ep/JMkcfn3
         CBo9qr39q8b2d5yf4BmKRqymhSBMl12kX5K17S8kaq12GdI0uxBeJimVeqvjtYozA+BG
         g73Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2SclrCu1rGZW+kt5Tr7JMK3s7glvoNPA0vTgxz2unrr6VI9jH9v34wT34/3Ae1vGobi2CwZKGAMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TRBAZbmQTkR7ZlA5oHuv6Mf3Bwrv18k/0XMadyij38eQayhb
	FeU344TK2/egqfI7eSBsY+R3px/NUFof8tMqjQ19kadwtkY9h1s5KSMCAN+zLSRR3+Q=
X-Gm-Gg: ASbGncuewYlMAbQtLyCAaAq2T9ikbFHzoY5hFouQxsi5sMPbmuLSRJdlBodDuIMox3D
	aTu8UMtqDghf5bSCxPXeYKwTHh4EPua9HngSE0GXiTgLBMM1ArrYeu4xLd/ffuHCqZtCMBxlxSR
	WIAnk5Y7TYqBiYhHo4IDaz0SOwIe0HxJFPAM7SKr6E8UhVZZRudV28ac92n57W23l4dYELZTk2u
	wnyXpcTS5z7nMaAoSXrJhh4kJ9bwv2VIPr6p3InoVlCNjSBZf0kJCpBTKkTybUePGNPlZTfnFH1
	Y7Ox7kmB/5ZztVJDp+EsoBVP5k3kgMklc8rxg89OPQkcyD1C8haYyk60IZvcdkkm3Is7H3C8i5a
	awexRw0F6d4J113IvzUU2TLMKm38e9ZQr37i33rUx1aJQmzgj
X-Google-Smtp-Source: AGHT+IFRoam51kLCQlognqaLnDSeb4W/WyS/huGGcdNg8zu0xDnWYvxEcLms+5oh6bPzNGICjmp+CQ==
X-Received: by 2002:a05:600c:58c8:b0:45d:d88b:cca with SMTP id 5b1f17b1804b1-45f211cb94dmr78596335e9.1.1757915403521;
        Sun, 14 Sep 2025 22:50:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e9996f384bsm5624675f8f.56.2025.09.14.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 22:50:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:49:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Feng Chen <feng.chen@amlogic.com>
Cc: Liang Yang <liang.yang@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: amlogic: Fix some error checking in
 aml_sfc_dma_buffer_setup()
Message-ID: <aMepB7E95kwYvx0o@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There was supposed to be a "ret = " assignment here but it was
accidentally left off so the error checking doesn't work.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


