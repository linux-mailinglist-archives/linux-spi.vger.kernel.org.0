Return-Path: <linux-spi+bounces-9675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C514B37FA7
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AC9680BDC
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3034AAF0;
	Wed, 27 Aug 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NpFgNjXE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BB1487D1
	for <linux-spi@vger.kernel.org>; Wed, 27 Aug 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289780; cv=none; b=qwIKT29A1qtaf9QxAADnmbodFtVHM9HNplLlSSoTDBdcGAhefqB1OpOrd2o6GR6EUYNpqj197n36cTA8O3W7mvYY0ypqQRZlQR9qXBzqV37A++xxKwXPA2qjZ8PByTq/Qm5tpVm9Vz+gObkywAttSb97svAlixgzvWdQMoHFT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289780; c=relaxed/simple;
	bh=rpyw9b+34OBAP5yd/g0+qQSLnf1nAfix4iyWf9uhBq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQwnXVquZHITqL5BXHTN7oAjaVYXbCuRK1dWbNE99t0+5Rp7IFwWrXxaLtMofQW7rs04uEN0b64N7YrJXyZBzWuv2dqIY6CDpYuH3ROWwjlEWmsBKAc4zFQy63pEDF2JEWZB8eaW8Vq3U32adbo47RsYtA7wG5lFhk91CvuACCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NpFgNjXE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c84925055aso2698801f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 27 Aug 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289777; x=1756894577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0pXmP8YLVTTuZVB19qTDKpWwsJ6nLU7EBvOCqYMS5Y=;
        b=NpFgNjXEZSDEP1oxYMptqmp/UWVuqWKgxKtZ5/TVnQMvruhh5Jx4qhCElHnImeBCiT
         7rPV+/yD1j5C4bJUtityC8SC2hWOJVSE6yG/iIv5Su5eC9eT/uxuJJaNpQcYrl4R70OB
         KXd7ibiL2ipCguyazBbMCDjHNPoUFCSohNDczHE59O54Vm7RYpwFRkAT5xtpV1+W9XBK
         7DWkE6c3y/wrSoURfA9j8IU6emnC+sN3iRT8SEnZ5PZZcxfphRfZ1E9pGNehkVtA+Sy9
         eMUuO3RmLn24MI5U5VfKTTZ7nUHqxI0uhy8d954SwwPTQKN0GBgE6zNGdSeNHJt+t42N
         JuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289777; x=1756894577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0pXmP8YLVTTuZVB19qTDKpWwsJ6nLU7EBvOCqYMS5Y=;
        b=jZ1I9jAAahd+fOEG/vLS4r1Na7slLoivCN3W5/0cHKXW3xJnu027QbP7w7ujT8VRh8
         TTfvUUp+cSw1eJipGIwoqHtxVMrem1cN46FUzveaS7JWaHqxbl3rAOni8qEZ6INi14LH
         wtnbozi46L4klr6jZUagkVnjxK0xpB0WO7iMav4XpEuLOyE9pccICORXberKVPIHbseX
         x5dOTaxzXB3wPzEEGx8YAB8+yAsQy4z2Vz2x2yeFU+01JY4j/zcy99vBObsEnbDHxkEK
         1/BGMMyz7C1vKZfva02++3BVZ3g17Knl/8oAtiLnZVSEhPhaCZejtmkH7KQX60de3NuO
         IhEA==
X-Forwarded-Encrypted: i=1; AJvYcCVkKlZ2+ni4RcD9jz+FZzgA+WzVZPFkx1lSlVopfb3nONQXJ5nuMrSD/kyi/ArWONiTOL9p4tPaf24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqLtKzXJre7F5Rw4B2Vl6xIZnq+GCiVL2lGVHbybQvt92Wp9k
	VNZ5pTioNTf9xWVYzrx8QQBdMb5zMSll+2M2g8mVCKAnaxmKNqchlklTw21lMuzU76g=
X-Gm-Gg: ASbGncuhY2NPoEBwKPErWxFm9VPE7Yr9EH7GDW0JVEmmV+a0Phr2jcg9U2XUaeO5OJz
	RCeLzA5awYRqmeqfIJfP40knNqjnaGaA9bbg8vjsfMqLM8/c+b37h+QlVfepZc+8RfjzhmqrbsG
	4rFO1DB0EQ294R38PSIRekV4FTHxyMfjW+YeK26mGMwsA7vtvEAEr/juDCTcPB5ogcFN27tVWZU
	CG+qIqS8f4P3Ehq10Ygdsx9YCMqivtkWAsIi/Ty4ck88jgsfK5pzoFMqSYL9TBl8u8s8Z2QhiWi
	kapYn+a9jmpvgRrjim+2Jr/8ryGH2pAZrpnLSl8hiueeb9YAe5J+XlelZcZHWlCTgsyAj3Zs86p
	sBnhChXq52VObzvg/n6/DkHSSRj/6XDznvbAKEW/MtnSWyvYQP0QrQ/X1WiSHSOAzWvsN/urxwb
	aCzU6+1w==
X-Google-Smtp-Source: AGHT+IGRiuzfeTyfR1IcpE8UX0OV0iAdfKjM8ryKEaQV5VkJf38zB7WTj3zM74hTpVp7/4Fjf0guDA==
X-Received: by 2002:a5d:584d:0:b0:3ca:734a:a337 with SMTP id ffacd0b85a97d-3ca734aa8famr6040248f8f.32.1756289776881;
        Wed, 27 Aug 2025 03:16:16 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70b634943sm19801199f8f.0.2025.08.27.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:16:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: broonie@kernel.org,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] spi: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:16:12 +0300
Message-ID: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/spi/spi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a388f372b27a..f95c4304df8e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -427,15 +427,13 @@ static int spi_probe(struct device *dev)
 	if (spi->irq < 0)
 		spi->irq = 0;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
-	if (sdrv->probe) {
+	if (sdrv->probe)
 		ret = sdrv->probe(spi);
-		if (ret)
-			dev_pm_domain_detach(dev, true);
-	}
 
 	return ret;
 }
@@ -446,8 +444,6 @@ static void spi_remove(struct device *dev)
 
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
-
-	dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


