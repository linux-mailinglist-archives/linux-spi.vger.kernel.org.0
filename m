Return-Path: <linux-spi+bounces-9394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A0BB25265
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B82A16B6B3
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653F28D850;
	Wed, 13 Aug 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YbS57CMR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566A29B8D8
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107280; cv=none; b=E1KsQ2dMB5eO/TUACkLlwvzbFf9Dm/ZwOniPRdh9jt+cv1zMfPfISifyE+Qh2P7462xDWo6AQKxBPs+G2EXUIgGGIgYYqjIfdZDu0ymXAKBD3PPFi37foKRq7VrvMOPOmxHuNTHW1aV7s49LbBBU3DHlrtZQVLLcQoaztPyFN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107280; c=relaxed/simple;
	bh=QybKy29Ct2YiEDYuui7hJlz/0jLfGcDQxytYrS02m+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/A0sW+7AaWj5441yT/fwg/YBBw6y7+JZtxOZxejfmMbOwGqxH81qkdr/aim7A86zMIMCqEVE8evToO0MXH5jddSvcpiweStxXtTBTKCa/yOxryvxiFOItOfIEHbHHESYMCCQHXlbKHyYLPWkBEUe6Xsa6Jrs8RAbE5w3J0R1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YbS57CMR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8706ac44eso8378785a.3
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107276; x=1755712076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=YbS57CMR18b+LaQ/349rUeuLORIqWyYCBiNaUxmyPAe2kJmv74oEyzD7eUQ8gcpGlU
         nkKDAxdLMCURsZ2G10y4R2bSRHGUv1u+7j2x3bmKx13scTNjmEk9aH2KP8EL/UVOsPrF
         OMhUqGSpbctUVkMvHULzpLvLNnZZxw5KlSQTFga1y7V8d47iI+ZwjR2YoLqds5HBpv7/
         KH+9ggyq8YKwZn0yz8cH4yfSYw5KCLpQCiNdHkfnYVvxswBoXGKXkFDC3vb7/R1h6wct
         7nQJAi0Ll6O4pcBmcYv4oJbb7hn65hq2THBB0JUABzbX2XZ6bq0SsxoGGYsKJ2x6pTxe
         PKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107276; x=1755712076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=Ci64YmALgRCJHJ7I7ttWmfib+//9RX4gee5QGeBRFOgVRNWGkGB3vcDAD8j0q7nuSg
         VdteqF40mAyphmqhLSrqO1s0zhnTiNvmFYtgid+UEX0HOFEq8YqjBY26rMAxegDYh6vs
         /41CJgMzofyHiw7wVp56bE7zOCT458gFQxOItK+D5XFojn+0ygjN0XNsp1IbFixGFe3N
         8/2fwc9V7pCPdFKCXvPKx4i5joFmyqfyaQSTTX0o4P8LBraYHcLjVaSTjOK5py68q7PU
         8H4dbLMDdEgZav8Bey8AKg22uCXg8JvixlXZRAGQIib+yRs1pDrCWHuTWz1+s+hhixoO
         xUsw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4pqDaFL2X5UXs2HWyS2wluAqHsMyxoZ0r0/JkFsXommQt/Tn1ddjetOSt2F/0atxO7fFKD0d4rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywz8iDX4cwZX2Xfk1H5fCabsSkGymjYCEMqU4/hYJcURHQqyXf
	o+8v6SLOzmOslzTvbuwwPKhCaOLY8+jVRxV8s2vvhJWbcNCt/jMk0tRR8TkYWduel7I=
X-Gm-Gg: ASbGncsfws7QlqApVaAjmR6L5hrwOkL5FFtdvkX0QzFO0sliqcAz4b6kKswxt9hnU0X
	1QOR+kxzkYNrDtrlqjcum2iY0P5eibb8+QNfAHWuxzZTajBNKPrngIP1KDcRAlAeRXRNx5vu7PD
	NyvQiceu5kW80Npt9suD5O6I1u5T3wpDtNyqx/YkEJfcRG/21BlvesMbltmI0s9qg1NhiVG1Cr/
	X66McDsur1FH1iccQdqukweIn/R/3SxPONvtJXbn7LAhNWNoy9hcWHBvgQDxj2xp7fLTSu5Qz/s
	DCARxYr5tKAGqet3SvS+VcnZUH+Y1rosY140GcBhEmmLXLD4iHSATrb+rakJvSAuoe5JayyMZC+
	bx6tB1IIoUnHFttBziPC2xMD+w2MWNZP2T1zOC6jxUaZA66rmBnAl
X-Google-Smtp-Source: AGHT+IEg3SSFyFBuMzj7VtB0BXbM4b6FpFJkYNn6QJWw/Ig9p6dazfZbmEC4UpkoJX3lIwDtCnuVhw==
X-Received: by 2002:a05:620a:201d:b0:7e8:6a84:e82e with SMTP id af79cd13be357-7e8705753c2mr21068085a.32.1755107276240;
        Wed, 13 Aug 2025 10:47:56 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:55 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 6/9] spi: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:42 +0200
Message-ID: <20250813174720.540015-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel SPI, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..320b23e92cbd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -154,7 +154,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.50.1


