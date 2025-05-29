Return-Path: <linux-spi+bounces-8328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09899AC7E6C
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B834E7353
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450722652E;
	Thu, 29 May 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOVYB/sW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06672253F8;
	Thu, 29 May 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524165; cv=none; b=bGYcXuN4Q8gRpUEnZQ3+h7i/cXhjv3jQvFg9rOtnHU4ffe/gf+qiKJS59k43qqJkSS/R0148jObAucvPiziNwSEgYh5eQwiw64Lw2dFjeuWvRcogo1eWi1uC0BUJENqlrZp44qOxVR3+5OYnJWv/zxSDTxr0fC8yRPu6yzUU8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524165; c=relaxed/simple;
	bh=zgVpzLutN8WSGXgdIJAg8cL2u7VObotUdyJeEmZ6JUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUBV3P5aCK4APQzuAnCdIWbN/V7DgHviOY2p9d7DRTYbTiEXtGxNgmihe0R4+AFOSCKldKRQ2QAp1zNZTuchQwHvL0m/nfR7NlU3OikC4yrP46bK22OcqQQtQuJvIQhxn0ss9xx4dw5LVq0sCOtqy0CGE9jL4HU8wS/Wm0bbh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOVYB/sW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so573021f8f.2;
        Thu, 29 May 2025 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524162; x=1749128962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7d0iThNLbH9IM9I/9siwNZzQknnB0201qeXBKYmNvM=;
        b=VOVYB/sW9L1CASklI4rE0FktbPjujCMP868qKCmSKOAZF2Wbxvjk1gRasrSYxe44qa
         8C/MZ1O/E8JUvZakyMFAbTuWVfI6Tnl/9aZEGUr6vpULSiL1A4uKQC8u7Iste45TmHrV
         rMtsGWkuFI83Sug9I+WjF7hpbLEKLLV80FZmPVpJpRQuLVmCHzbbIy4KwagiC3WrrNRC
         AoNeR23stXv0G89jf6jfWNa+qcUQaCHuPlFlewSTXygF88YfBZS0NjaLiSBU2KrmEPzT
         5YG9itAvDvVocfx3wnEx+0v0dRLTTZLxuny4yyuV1qEpPfoVtLP3e9a+M/PivMoYXBMw
         wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524162; x=1749128962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7d0iThNLbH9IM9I/9siwNZzQknnB0201qeXBKYmNvM=;
        b=danU21gkxYtNqt6o+fAgrbSgxUG/v9OFeyBWxSGx2NC5bcX4pQIECISoATFww4adnM
         wVWITN+TtsPa09+f7V5Hl60vgYrzyrLstkfWio0AQqpuhOlzpM34RuRu7npyRvVlMH3+
         mvOytDwoNHidDhlFAHx6rKu8TSFp5e/wEFjOWDiPR/oWDv9dc5JRXm+xQmloL9WMkUIG
         yPjMI6hFBUZ58W+lkPRCzuyUVHFgam3dvhFuhKVIGMcE/x5a5g77FQ3dxhhgEJwzQisH
         Bp0b1v8qqPwYOVgfrJdimbkcOKmcxPZBT3JJ3ob9Y6Fx3qBjcGK/Q9nIPqZo+O+ytht+
         B9pA==
X-Forwarded-Encrypted: i=1; AJvYcCWVUoQxhAuJ0S6pkl6FmmfIwgRGTYjVW5YZka4w/oxS0LEFKqMTIG3VmeQSinw6+yEYQHn+gcBKdUA/0xw=@vger.kernel.org, AJvYcCXVte0DSAkzXQUG5xU7I2+SePuCWgU6/y+ggJaLd7gO1hUlWhaSaDFSydzMy2r9/vkxhtN2m22d9tVy@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7rdgsfvb7E6EByPqbWMTN+bD7OxBoCpEedSbkqP35HkuJu5d
	d7u/Ia6xiUTSnO8mvFWSrz2q01GA/k++nEfT6NxzqxrSfw/tHxiuI05D
X-Gm-Gg: ASbGncsdVtArZEnf7QRQZQiN3h7IlNlMUbeMxn/hw9Gl8Z/IH+sOri/zqP/auDBqGDx
	rYt/Sy7ZWVXrL2OKZXX76skTjsALtolSeidjm1ABlsbYrr2zNbYzRMFHr+N1mOLZmJqe8Xu5dCT
	JqYPyMZmQynTgObJlapIN/oBZGlBkCGZr55mTxpapvS6963q0z+A20Ub6I8PK9Pil7QxPK9gImL
	nX2GRr8D3T6ldt2YuHRTJ1CbYRIfzBgixWBc4l/U6sXDISI8A3008Y3V9mMO4BZo4e3tllJfjGc
	WsWBv8KxV4Keg2mt40JHX+7KZAHvF+XfYYwBJ59KM6VkUCKPo7z1ZSPlDAAcvmP6wpsPd2JaQH0
	/PcBze9xeK8BKv88GQ1e9PnVXFlnGM8uvKJ7R0trpn9YEfiTX1Buh
X-Google-Smtp-Source: AGHT+IELWXo0fhuMDjKuAwfU+R2e5HLSo3BcMCZFnwYf54yJKPKEYWHMkrgOjp/B0CJNI6JsZBT1gA==
X-Received: by 2002:a05:6000:2388:b0:3a4:f6cc:57ce with SMTP id ffacd0b85a97d-3a4f6cc5907mr434003f8f.57.1748524161743;
        Thu, 29 May 2025 06:09:21 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc67933sm19439755e9.32.2025.05.29.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:09:21 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: dgcbueu@gmail.com,
	florian.fainelli@broadcom.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] spi: bcm63xx-hsspi: fix shared reset
Date: Thu, 29 May 2025 15:09:15 +0200
Message-Id: <20250529130915.2519590-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250529130915.2519590-1-noltari@gmail.com>
References: <20250529130915.2519590-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
and HSSPI controllers, so reset shouldn't be exclusive.

Fixes: 0eeadddbf09a ("spi: bcm63xx-hsspi: add reset support")
Reported-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 644b44d2aef2..18261cbd413b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -745,7 +745,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-- 
2.39.5


