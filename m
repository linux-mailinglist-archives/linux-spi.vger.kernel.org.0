Return-Path: <linux-spi+bounces-3620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F54919875
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 21:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2124D1C211D6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3E1922D6;
	Wed, 26 Jun 2024 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J6AEFK33"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0E149E05
	for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431124; cv=none; b=WFd4PZn6BkQwIxhoWJSnqObng0q2PVrWGhgGlIRxBwdaqVM3O4upK8DuEbGnoOCoZkDF3lWk3CaMsxIOfwhPtQBwO7Pm00daOlc5/KoA2lsD8jTxo2O9kqvjLuNQ36BO0MzaUK7gzGGZNpLHUY8Xvt4gt1/rXYATMDmQDex42go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431124; c=relaxed/simple;
	bh=Hj2QWYGExHbz2eIVjGAcVAcoQqrqcYG5sIGyrw5LnkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bCbIdNxuOhiLApg0iZjbaRXplntvdDq2ckuO/Qarqtff6l8IeHoBQmwjoP/Yk+LqJ3Eu8v5g/dUkpVFzmR5/PYWO8zIkCRquYjgnP1u6o7caY8YsDK3xTN7QkA5cgipzNi+lK9ZEZTQs8PjRwx89lMJ540Cow8BPj6nANe9Inpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J6AEFK33; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f855b2499cso3827831a34.1
        for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719431122; x=1720035922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gADk6rDKIWbFLVEuG73ynnBZ3KXbCJ0Mu03G97si6N8=;
        b=J6AEFK33pbKHXkptzcq0ZA+3Gw6Nj+3p7VHND32sBKQkT5/f4sDJZHoKMGuZJNVcZb
         dpXGF34G+xHVKu+y0Nu5ZW3+30lV0uLKa87JIt/LOAhgwx+9Rwtbt1lex793RJ5juucU
         zt9dLKMMjXxRkiALIKztqvFMkPMU9V7KLjwwvw5/+ZztYaliIYkVFyXj+D97O3rscUKk
         edkzrCZbiRL4Z3+K98GAMNhNW4IK/gv0rvMGMDRWd+Ql9Y6YcANeV2vFdgsV1bBWabVV
         hmds8ye4b66u5LSTZ4myPRg9xBp065Ai3gm5ruK3v5dBC+orbJbzFTmdY0v2NasVvGa2
         NCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431122; x=1720035922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gADk6rDKIWbFLVEuG73ynnBZ3KXbCJ0Mu03G97si6N8=;
        b=P6fZ4q9xyFIt7RT7kPoN/+4VAYg6NZeXDKPvkfiCUITWHSsAb/CWVeDuoNslG4Ut/F
         twhpNA7G+U+d/5mH32fP57oLUNFm9qdsxTYbzV+tWXFXBCVf2l1sOxNcVkyUL8Jz9e8v
         F+jLsngr++acrfWjrqJ/+uNS3e68en17pRjR3Z2xstGPUgtuCc+xLuk83yOgJnijhS69
         5cnlad8kYTFowHTgzVlI9sMVbE1l9LNFwvFBW+aYwAp3c8WOXJ8sKQ/X52lx1tNwVlGp
         VjYVXYAxY5CmIGCop3X8k7oMXt2VOHUmIkEwyAMdXWEE7n5+dTL/zzM41U26uj9JXUCs
         FDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiSc66GTBd/iNAag2bRn9DH9Urwt0eCn0KNzsod3KnsOIJoPCGrOcjpbbBFSWH/nJvw5XjFH+TN4PnXJIocLrS5YsTk7puAqJW
X-Gm-Message-State: AOJu0YxaDJuDPtKSJQUnl8yebUwTaxcYoLz1+Rw59nhTmfGC5IRcIzxs
	ZCVgjwkjjzuqM69geWOpN9zLFwHQKMB/p/4SzqFzibAJ0BYcIJMcJ6ZUtk1dZL8=
X-Google-Smtp-Source: AGHT+IG2ddYJtEHIdb4D6/2WU/XZrENIz9ZWFcePTFUFMlVMxlP2HxzPACNC4QZa/OPlJtiOuuhoBA==
X-Received: by 2002:a05:6830:113:b0:6f9:6246:a14f with SMTP id 46e09a7af769-700b1293fe7mr13282187a34.30.1719431122030;
        Wed, 26 Jun 2024 12:45:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7016c03820asm64154a34.80.2024.06.26.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:45:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: remove platform_set_drvdata()
Date: Wed, 26 Jun 2024 14:45:17 -0500
Message-ID: <20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

platform_get_drvdata() is never called in the AXI SPI Engine driver, so
platform_set_drvdata() is not needed. Remove it. This also lets us
avoid the final error check in the probe function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 103a68bd4f19..447e5a962dee 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -700,13 +700,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, host);
-
-	return 0;
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 static const struct of_device_id spi_engine_match_table[] = {

---
base-commit: f66ed82666bc582434d57359d2d83d6f40c925e4
change-id: 20240626-spi-axi-spi-engine-remove-drvdata-cf390daaa2ab


