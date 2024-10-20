Return-Path: <linux-spi+bounces-5262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B361E9A55BE
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CDB282DC3
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2F197A88;
	Sun, 20 Oct 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3gMOSIt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF619644B;
	Sun, 20 Oct 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448519; cv=none; b=XC9x7NtDITaDP+zRmcC4uD5EhyQL7rq10gsIVeVleatWkHNiDnBESJZCaiYRn9Pxz3NJP56oVSTJaAC21lmq07fNbJ4OmFqMCqccISJssjEeYzW0OaL++nHl7iN6Uus54I5jBIKkFlTBd/w64mreBk+cLvVjtGzJ8zwIDlfHF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448519; c=relaxed/simple;
	bh=+SKnYOBkQ9uRpdUnkVZEGCogf+pRwPjMWuroZ0c6eOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px7Bo/hEjcoIUurLgm1obOnF9zLVZnygENput0mvZrpxjOUvB8flo2xHA1TzxKgS2ZuT3TLy+lZWGtdiAd5wQfOqUdpXbo8Br0BFv60qgvhH3BR930H/Lu+gpGdEP55GpT1asyHpicxhO1TRJT5FZJN1rsTwU23FINGVCF6WNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3gMOSIt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso30896675e9.0;
        Sun, 20 Oct 2024 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448516; x=1730053316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOGuZBzdjkFcdt2iKU9LrAuNdSVHouuBuYJiJneV5u0=;
        b=Y3gMOSIthGBb6y7O2fNAGnkk1HWl/pOdX8/CUtRDm6kgavu7xUxF5o6KUyHLsms0a+
         M2oUuefu+Yfn3m0buE4AoJzyLFnu4pKjOyQDWzAiPP5tfvqqc0SO1TxRgJN4hI6KQl+D
         /uqjLstolsQcnwl7UTZRbR8t9GQfOJMDn81AcMGO+tdS677wWbtlk9mViN88McccAZ55
         ttmByJ2waRnvhhh8WbbHkeNsh/58QNpZhTsPkhRyVAhqqQYRNMj5ZqfN1gL5WuxYVQml
         bHcMXqslhzsxieOrrZmZhdS3tYfiIk42+dKyCAa2FP4ZSXJwW9oW5MVpeoiTrXeKZH3h
         mA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448516; x=1730053316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOGuZBzdjkFcdt2iKU9LrAuNdSVHouuBuYJiJneV5u0=;
        b=iWYutMfubCpPRERHwwTm/rDdMT0/GWXzN/ZTDzEAAsMVJAUeTf3Fg2vU7B9ekESFBl
         93ap+vOEvdqQE/Vs5qsWPW6viXP0XkZVykgNFrlPLAWYCiGbz7D9eT0Br1s4aa94ogtm
         rbReU7YpmEbloHfy81dqHgqqnh1DKG4QKyq9m63jeENpBO2TJQtAshJRlLH3E9JH/T+w
         uUPPnLf1xer4jZ5RbmwhqwphAs7srUV5d18T9tP25YCxbwnG0Ia5cAjMhcyafEEwMw0q
         CLddQKN0Vc3pC0299TyXQuhn4/swj53bhSjCS56Podt0f4FDlRVdstCqqy6EBuBuGi20
         ujRA==
X-Forwarded-Encrypted: i=1; AJvYcCV1V8Sovo/FGIQIoGQDBlKeIrJaG69Y9Dtah2ITWNA0iV4d021JlZg9MkR+uHqvHzPkn47eJYgAFFphzKUS@vger.kernel.org, AJvYcCVgBV7RcIwwTd4f9LgTgcrg0UzbrK0aOeR+uq9hTJQqnLxf4Nz1nlFmohBN6HWVOiStx8yan+I1xWp0@vger.kernel.org, AJvYcCWhauoq5qgxn4q52uwQTPF0uIDpvQqG1R3ItmhrDBxLHXfh4hSXmJ7zdYDoqVokqGw0votEZfLpHdfWUKM+dtg3l0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HSDjMs8yCngV01KI6Rxgw+2KDT7M9vmbo7wF4TWc+uEB8p8X
	Pr/QpE4okN/GfKuZUGoFmy6LrS5F31RO4HMWXXBsZOyUmMuXaV40/QHRbjhx
X-Google-Smtp-Source: AGHT+IERV5gK0lNy0vobuAkOc9gFbu9smR5sqdfQrx4tjIF3P+r9hp2ckFPSqHYP7ZHOB662YVTfoQ==
X-Received: by 2002:a05:600c:3511:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-43161691204mr93465895e9.33.1729448515987;
        Sun, 20 Oct 2024 11:21:55 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:55 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] spi: dt-bindings: samsung: Add a compatible for samsung,exynos8895-spi
Date: Sun, 20 Oct 2024 21:21:17 +0300
Message-ID: <20241020182121.377969-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the vendor kernel, the Exynos8895 SoC has an SPI
configuration that matches with the Exynos850 one.

SPI FIFO depth is 64 bytes for all SPI blocks. All blocks have DIV_4
as the default internal clock divider, and an internal loopback mode
to run a loopback test.

Reuse the samsung,exynos850-spi compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index f681372da..3c206a64d 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -26,6 +26,10 @@ properties:
           - samsung,exynos850-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
+      - items:
+          - enum:
+              - samsung,exynos8895-spi
+          - const: samsung,exynos850-spi
       - const: samsung,exynos7-spi
         deprecated: true
 
-- 
2.43.0


