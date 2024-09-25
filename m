Return-Path: <linux-spi+bounces-4957-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EA985809
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 13:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8378A284EA9
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B414C59A;
	Wed, 25 Sep 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZJr3Gz+p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE3137775
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264124; cv=none; b=FQSah0CU/nsa2sT4OXFsphgRC3abFAdgIfdof12iBIvHNTusD246RPDAG+RmK4zPSSpdQTs318SimMUmZeHj0+BxwCHB0R0HJg21mY+XCaESEh1uwAdF0oNGZdjfO2MpikZr0BMmn+xIsDsqIuglIRSGww4VtaCWsfxxPZ4/2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264124; c=relaxed/simple;
	bh=8Ae9VNGqCEokqXB605TOug0qMqrhIaDielouo2nanrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pv1PoqS6TIKZRa+zQ4O0e4LpkY0J/SoWFoV6oLsD6K7MLqSaagJHq5wRHtu8p+pq5w4f3fuxXUWw5uZ7cPYtzy856JEjJ8c4y95uKvjuCsMHcsCirE7huFTxYqFM4cGMs3dQhok1jdHFFNlssuQ/+mCm3TqOwkd8+6b+VKMA28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZJr3Gz+p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so57948605e9.3
        for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727264118; x=1727868918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4Iwt4pI3X7O/Nd9Mr8ukS3MlUlfFqWio3hMMEB7pbY=;
        b=ZJr3Gz+paRT9N7SfMghffFCe2jsMCRtaoL+P+baFNeAAhJMqLHQIqdMNWsMOGxRsAH
         gQDXKE4bv+9Qz3vKXqDeY69vc4WKOKNmReXRsV/OVW072m5DFdeBV+o4RyPJBk2sBNkJ
         LGaE8mFoFM8EpSX7I6g6U8gHNFszsTcS3ugmHeIFwnEPkr7G3PQ5nFFlp4isKfcMTvVH
         gdvssv7xfyDDrYB9hWQK+DeQKwuowNpjDh3ClOlLBt+KvITHH8eh3iqxj3OpsVISfG/8
         mbubdLZS4T0YHnQHdQRwvRGhSqsW76W9XZyLAft0Fxwh0hbbgWWyRyAFXkfZslMJUQXZ
         SGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264118; x=1727868918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4Iwt4pI3X7O/Nd9Mr8ukS3MlUlfFqWio3hMMEB7pbY=;
        b=w+/0Lvow6By0g26B2qWpwN2/fhfD3twM52rkjqTyKXK2rgMk90U03Pmbtoh83aJyak
         Kei/fF2yU58edOakWw2E4ZYWzkGgJ6TGDwOZukfTJA3D8pB9s/VQLzfuco37RTBllxMd
         ujiQjx13O12B19Lk68XfiX6tdKv0ok8Of5ejo3zw2MkVPrJimkOWEBwMQc4JrjvuH6gC
         Tz62pk8KlzaEdI7PrU/N7SIHOSI0MLD4apV7mn+s3D2+ewsZYJYKAUQ2o3NOG8G7Jfkf
         EDTu7PupZWlLys4mldGTvOXB9bkGUe1ysxQWXAgWCxoBtxZ8tKb0tf8I6FFU6m6vQkfI
         66nQ==
X-Gm-Message-State: AOJu0YxDTn3w/Qyfslt7GNe/NZ4mFTHJgLLc+S6grHoNvsgrx1Q/P7vI
	ccMZDu45h48cs01ECYidXNlRz07LMui0K9h+3M/MpLT4EhKebXdYKXvoNr6nPpk=
X-Google-Smtp-Source: AGHT+IFz4nDptIBe7hekArcQiNucKsDPQPKkLIdSaC1fCppBLE0s4z1KeLC3UnbgLJnDiUwfQJ7h8g==
X-Received: by 2002:a7b:cb0f:0:b0:42c:bf70:a303 with SMTP id 5b1f17b1804b1-42f04f6adbemr9648885e9.29.1727264117599;
        Wed, 25 Sep 2024 04:35:17 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a0d8eesm15821235e9.30.2024.09.25.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:35:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Subject: [PATCH] usb: Switch back to struct platform_driver::remove()
Date: Wed, 25 Sep 2024 13:35:00 +0200
Message-ID: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=47560; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=8Ae9VNGqCEokqXB605TOug0qMqrhIaDielouo2nanrY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm8/VlnM9ttfUmoz08dHMr1XUjEi4XAlvJ+iJ1G qcjfWxDTp2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZvP1ZQAKCRCPgPtYfRL+ ThzOB/4hAEaqjyWSAXv3HI5pYio/4bMMjsjHf8xB/554t9xqTafeErVPuVBm420kyPd3Xwne2sX p+tuJux6LC3Sjo1IFa8dL/Y4KwF9JRoWHzpT6ifPXR6URqqkQ6AQOLPGZJsPUWHeOJxwEgRoW5Y eUutzXo5uo0SY7KLCCkfomQGHXBAenk7XVksWMHBswndjRrJcgdjrQUttwAW/EnpaTTtEu+QlaO FaZw2iBg/Kraf1wOFHQbV/tXruxBwUsQj6Cuv9U+7SfcSO5jlXzjCIcbt7YhMzfLOuzu7A4QSvU YHGgRfMS8NQEf7uquuJxid2oIclCldwGbKPJQhvutkQPvUHH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/spi to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

The change for the spi-npcm-fiu stands out in the diffstat because the
inconsistent formatting style of the platform_driver initializer is
fixed to match the other struct initializer in the file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/spi. While I usually prefer to
do one logical change per patch, this seems to be overengineering here
as the individual changes are really trivial and shouldn't be much in
the way for stable backports. But I'll happily split the patch if you
prefer it split.

Note I didn't Cc: the maintainers of each driver as this would hit
sending limits.

This is based on today's next, if conflicts arise when you apply it at
some later time and don't want to resolve them, feel free to just drop
the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend.

Best regards
Uwe

 drivers/spi/atmel-quadspi.c           | 2 +-
 drivers/spi/spi-ar934x.c              | 2 +-
 drivers/spi/spi-aspeed-smc.c          | 2 +-
 drivers/spi/spi-at91-usart.c          | 2 +-
 drivers/spi/spi-ath79.c               | 2 +-
 drivers/spi/spi-atmel.c               | 2 +-
 drivers/spi/spi-au1550.c              | 2 +-
 drivers/spi/spi-bcm2835.c             | 2 +-
 drivers/spi/spi-bcm2835aux.c          | 2 +-
 drivers/spi/spi-bcm63xx-hsspi.c       | 2 +-
 drivers/spi/spi-bcm63xx.c             | 2 +-
 drivers/spi/spi-bcmbca-hsspi.c        | 2 +-
 drivers/spi/spi-brcmstb-qspi.c        | 2 +-
 drivers/spi/spi-cadence-quadspi.c     | 2 +-
 drivers/spi/spi-cadence.c             | 2 +-
 drivers/spi/spi-cavium-octeon.c       | 2 +-
 drivers/spi/spi-coldfire-qspi.c       | 2 +-
 drivers/spi/spi-davinci.c             | 2 +-
 drivers/spi/spi-dln2.c                | 2 +-
 drivers/spi/spi-dw-bt1.c              | 2 +-
 drivers/spi/spi-dw-mmio.c             | 2 +-
 drivers/spi/spi-ep93xx.c              | 2 +-
 drivers/spi/spi-fsl-dspi.c            | 2 +-
 drivers/spi/spi-fsl-espi.c            | 2 +-
 drivers/spi/spi-fsl-lpspi.c           | 2 +-
 drivers/spi/spi-fsl-qspi.c            | 2 +-
 drivers/spi/spi-fsl-spi.c             | 4 ++--
 drivers/spi/spi-hisi-kunpeng.c        | 2 +-
 drivers/spi/spi-img-spfi.c            | 2 +-
 drivers/spi/spi-imx.c                 | 2 +-
 drivers/spi/spi-iproc-qspi.c          | 2 +-
 drivers/spi/spi-lantiq-ssc.c          | 2 +-
 drivers/spi/spi-meson-spicc.c         | 2 +-
 drivers/spi/spi-meson-spifc.c         | 2 +-
 drivers/spi/spi-microchip-core-qspi.c | 2 +-
 drivers/spi/spi-microchip-core.c      | 2 +-
 drivers/spi/spi-mpc52xx.c             | 2 +-
 drivers/spi/spi-mt65xx.c              | 2 +-
 drivers/spi/spi-mtk-nor.c             | 2 +-
 drivers/spi/spi-mtk-snfi.c            | 2 +-
 drivers/spi/spi-mxic.c                | 2 +-
 drivers/spi/spi-mxs.c                 | 2 +-
 drivers/spi/spi-npcm-fiu.c            | 8 ++++----
 drivers/spi/spi-npcm-pspi.c           | 2 +-
 drivers/spi/spi-nxp-fspi.c            | 2 +-
 drivers/spi/spi-oc-tiny.c             | 2 +-
 drivers/spi/spi-omap-uwire.c          | 2 +-
 drivers/spi/spi-omap2-mcspi.c         | 2 +-
 drivers/spi/spi-orion.c               | 2 +-
 drivers/spi/spi-pic32-sqi.c           | 2 +-
 drivers/spi/spi-pic32.c               | 2 +-
 drivers/spi/spi-ppc4xx.c              | 2 +-
 drivers/spi/spi-pxa2xx-platform.c     | 2 +-
 drivers/spi/spi-qcom-qspi.c           | 2 +-
 drivers/spi/spi-qup.c                 | 2 +-
 drivers/spi/spi-rb4xx.c               | 2 +-
 drivers/spi/spi-rockchip-sfc.c        | 2 +-
 drivers/spi/spi-rockchip.c            | 2 +-
 drivers/spi/spi-rpc-if.c              | 2 +-
 drivers/spi/spi-rspi.c                | 2 +-
 drivers/spi/spi-rzv2m-csi.c           | 2 +-
 drivers/spi/spi-s3c64xx.c             | 2 +-
 drivers/spi/spi-sh-hspi.c             | 2 +-
 drivers/spi/spi-sh-msiof.c            | 2 +-
 drivers/spi/spi-sh-sci.c              | 2 +-
 drivers/spi/spi-sh.c                  | 2 +-
 drivers/spi/spi-sifive.c              | 2 +-
 drivers/spi/spi-slave-mt27xx.c        | 2 +-
 drivers/spi/spi-sn-f-ospi.c           | 2 +-
 drivers/spi/spi-sprd.c                | 2 +-
 drivers/spi/spi-st-ssc4.c             | 2 +-
 drivers/spi/spi-stm32-qspi.c          | 2 +-
 drivers/spi/spi-stm32.c               | 2 +-
 drivers/spi/spi-sun4i.c               | 2 +-
 drivers/spi/spi-sun6i.c               | 2 +-
 drivers/spi/spi-sunplus-sp7021.c      | 2 +-
 drivers/spi/spi-synquacer.c           | 2 +-
 drivers/spi/spi-tegra114.c            | 2 +-
 drivers/spi/spi-tegra20-sflash.c      | 2 +-
 drivers/spi/spi-tegra20-slink.c       | 2 +-
 drivers/spi/spi-tegra210-quad.c       | 2 +-
 drivers/spi/spi-ti-qspi.c             | 2 +-
 drivers/spi/spi-topcliff-pch.c        | 2 +-
 drivers/spi/spi-uniphier.c            | 2 +-
 drivers/spi/spi-xilinx.c              | 2 +-
 drivers/spi/spi-xtensa-xtfpga.c       | 2 +-
 drivers/spi/spi-zynq-qspi.c           | 2 +-
 drivers/spi/spi-zynqmp-gqspi.c        | 2 +-
 88 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4f288f07e38f..20ee227dead2 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -840,7 +840,7 @@ static struct platform_driver atmel_qspi_driver = {
 		.pm	= pm_ptr(&atmel_qspi_pm_ops),
 	},
 	.probe		= atmel_qspi_probe,
-	.remove_new	= atmel_qspi_remove,
+	.remove		= atmel_qspi_remove,
 };
 module_platform_driver(atmel_qspi_driver);
 
diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index 5ba988720851..86c54fff9d6e 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -223,7 +223,7 @@ static struct platform_driver ar934x_spi_driver = {
 		.of_match_table = ar934x_spi_match,
 	},
 	.probe = ar934x_spi_probe,
-	.remove_new = ar934x_spi_remove,
+	.remove = ar934x_spi_remove,
 };
 
 module_platform_driver(ar934x_spi_driver);
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index bbd417c55e7f..8eb843ddb25f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1189,7 +1189,7 @@ MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
 
 static struct platform_driver aspeed_spi_driver = {
 	.probe			= aspeed_spi_probe,
-	.remove_new		= aspeed_spi_remove,
+	.remove			= aspeed_spi_remove,
 	.driver	= {
 		.name		= DEVICE_NAME,
 		.of_match_table = aspeed_spi_matches,
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 1cea8e159344..bbe97ce89a2f 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -650,7 +650,7 @@ static struct platform_driver at91_usart_spi_driver = {
 		.pm = &at91_usart_spi_pm_ops,
 	},
 	.probe = at91_usart_spi_probe,
-	.remove_new = at91_usart_spi_remove,
+	.remove = at91_usart_spi_remove,
 };
 
 module_platform_driver(at91_usart_spi_driver);
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index d78762d4db98..9a705a9fddd2 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -253,7 +253,7 @@ MODULE_DEVICE_TABLE(of, ath79_spi_of_match);
 
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
-	.remove_new	= ath79_spi_remove,
+	.remove		= ath79_spi_remove,
 	.shutdown	= ath79_spi_shutdown,
 	.driver		= {
 		.name	= DRV_NAME,
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b62f57390d8f..89a6b46cd319 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1781,7 +1781,7 @@ static struct platform_driver atmel_spi_driver = {
 		.of_match_table	= atmel_spi_dt_ids,
 	},
 	.probe		= atmel_spi_probe,
-	.remove_new	= atmel_spi_remove,
+	.remove		= atmel_spi_remove,
 };
 module_platform_driver(atmel_spi_driver);
 
diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 16f200bb3d17..b65798ccc679 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -940,7 +940,7 @@ MODULE_ALIAS("platform:au1550-spi");
 
 static struct platform_driver au1550_spi_drv = {
 	.probe = au1550_spi_probe,
-	.remove_new = au1550_spi_remove,
+	.remove = au1550_spi_remove,
 	.driver = {
 		.name = "au1550-spi",
 	},
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..0d1aa6592484 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1435,7 +1435,7 @@ static struct platform_driver bcm2835_spi_driver = {
 		.of_match_table	= bcm2835_spi_match,
 	},
 	.probe		= bcm2835_spi_probe,
-	.remove_new	= bcm2835_spi_remove,
+	.remove		= bcm2835_spi_remove,
 	.shutdown	= bcm2835_spi_remove,
 };
 module_platform_driver(bcm2835_spi_driver);
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 06fe155a70c9..90698d7d809d 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -577,7 +577,7 @@ static struct platform_driver bcm2835aux_spi_driver = {
 		.of_match_table	= bcm2835aux_spi_match,
 	},
 	.probe		= bcm2835aux_spi_probe,
-	.remove_new	= bcm2835aux_spi_remove,
+	.remove		= bcm2835aux_spi_remove,
 };
 module_platform_driver(bcm2835aux_spi_driver);
 
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1ca857c2a4aa..644b44d2aef2 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -944,7 +944,7 @@ static struct platform_driver bcm63xx_hsspi_driver = {
 		.of_match_table = bcm63xx_hsspi_of_match,
 	},
 	.probe		= bcm63xx_hsspi_probe,
-	.remove_new	= bcm63xx_hsspi_remove,
+	.remove		= bcm63xx_hsspi_remove,
 };
 
 module_platform_driver(bcm63xx_hsspi_driver);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index ef3a7226db12..c8f64ec69344 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -656,7 +656,7 @@ static struct platform_driver bcm63xx_spi_driver = {
 	},
 	.id_table	= bcm63xx_spi_dev_match,
 	.probe		= bcm63xx_spi_probe,
-	.remove_new	= bcm63xx_spi_remove,
+	.remove		= bcm63xx_spi_remove,
 };
 
 module_platform_driver(bcm63xx_spi_driver);
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index d936104a41ec..f16298b75236 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -633,7 +633,7 @@ static struct platform_driver bcmbca_hsspi_driver = {
 		   .of_match_table = bcmbca_hsspi_of_match,
 		   },
 	.probe = bcmbca_hsspi_probe,
-	.remove_new = bcmbca_hsspi_remove,
+	.remove = bcmbca_hsspi_remove,
 };
 
 module_platform_driver(bcmbca_hsspi_driver);
diff --git a/drivers/spi/spi-brcmstb-qspi.c b/drivers/spi/spi-brcmstb-qspi.c
index e1b137419f5c..7a33b479c1f7 100644
--- a/drivers/spi/spi-brcmstb-qspi.c
+++ b/drivers/spi/spi-brcmstb-qspi.c
@@ -28,7 +28,7 @@ static void brcmstb_qspi_remove(struct platform_device *pdev)
 
 static struct platform_driver brcmstb_qspi_driver = {
 	.probe			= brcmstb_qspi_probe,
-	.remove_new		= brcmstb_qspi_remove,
+	.remove			= brcmstb_qspi_remove,
 	.driver = {
 		.name		= "brcmstb_qspi",
 		.pm		= &bcm_qspi_pm_ops,
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1755ca026f08..0b45b7b2b3ab 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2112,7 +2112,7 @@ MODULE_DEVICE_TABLE(of, cqspi_dt_ids);
 
 static struct platform_driver cqspi_platform_driver = {
 	.probe = cqspi_probe,
-	.remove_new = cqspi_remove,
+	.remove = cqspi_remove,
 	.driver = {
 		.name = CQSPI_NAME,
 		.pm = pm_ptr(&cqspi_dev_pm_ops),
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e07e081de5ea..223939a7a657 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -804,7 +804,7 @@ MODULE_DEVICE_TABLE(of, cdns_spi_of_match);
 /* cdns_spi_driver - This structure defines the SPI subsystem platform driver */
 static struct platform_driver cdns_spi_driver = {
 	.probe	= cdns_spi_probe,
-	.remove_new = cdns_spi_remove,
+	.remove = cdns_spi_remove,
 	.driver = {
 		.name = CDNS_SPI_NAME,
 		.of_match_table = cdns_spi_of_match,
diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 4511c3b31223..a5ad90d66ec0 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -90,7 +90,7 @@ static struct platform_driver octeon_spi_driver = {
 		.of_match_table = octeon_spi_match,
 	},
 	.probe		= octeon_spi_probe,
-	.remove_new	= octeon_spi_remove,
+	.remove		= octeon_spi_remove,
 };
 
 module_platform_driver(octeon_spi_driver);
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index e83cd0510f20..fdf37636cb9f 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -502,7 +502,7 @@ static struct platform_driver mcfqspi_driver = {
 	.driver.name	= DRIVER_NAME,
 	.driver.pm	= &mcfqspi_pm,
 	.probe		= mcfqspi_probe,
-	.remove_new	= mcfqspi_remove,
+	.remove		= mcfqspi_remove,
 };
 module_platform_driver(mcfqspi_driver);
 
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index ad26c8409733..a29934422356 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -1039,7 +1039,7 @@ static struct platform_driver davinci_spi_driver = {
 		.of_match_table = of_match_ptr(davinci_spi_of_match),
 	},
 	.probe = davinci_spi_probe,
-	.remove_new = davinci_spi_remove,
+	.remove = davinci_spi_remove,
 };
 module_platform_driver(davinci_spi_driver);
 
diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index d319dc357fef..3e925d106dc9 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -871,7 +871,7 @@ static struct platform_driver spi_dln2_driver = {
 		.pm	= &dln2_spi_pm,
 	},
 	.probe		= dln2_spi_probe,
-	.remove_new	= dln2_spi_remove,
+	.remove		= dln2_spi_remove,
 };
 module_platform_driver(spi_dln2_driver);
 
diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 4577e8096cd9..abe6410f0e99 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -317,7 +317,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_bt1_of_match);
 
 static struct platform_driver dw_spi_bt1_driver = {
 	.probe	= dw_spi_bt1_probe,
-	.remove_new = dw_spi_bt1_remove,
+	.remove = dw_spi_bt1_remove,
 	.driver	= {
 		.name		= "bt1-sys-ssi",
 		.of_match_table	= dw_spi_bt1_of_match,
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 819907e332c4..863040cf5db7 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -433,7 +433,7 @@ MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
 
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
-	.remove_new	= dw_spi_mmio_remove,
+	.remove		= dw_spi_mmio_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = dw_spi_mmio_of_match,
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index dc6bdc74643d..e1d097091925 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -729,7 +729,7 @@ static struct platform_driver ep93xx_spi_driver = {
 		.of_match_table = ep93xx_spi_of_ids,
 	},
 	.probe		= ep93xx_spi_probe,
-	.remove_new	= ep93xx_spi_remove,
+	.remove		= ep93xx_spi_remove,
 };
 module_platform_driver(ep93xx_spi_driver);
 
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 191de1917f83..72044d76d736 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1469,7 +1469,7 @@ static struct platform_driver fsl_dspi_driver = {
 	.driver.of_match_table	= fsl_dspi_dt_ids,
 	.driver.pm		= &dspi_pm,
 	.probe			= dspi_probe,
-	.remove_new		= dspi_remove,
+	.remove			= dspi_remove,
 	.shutdown		= dspi_shutdown,
 };
 module_platform_driver(fsl_dspi_driver);
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index ea647ee94da8..6a73eaa34cf7 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -835,7 +835,7 @@ static struct platform_driver fsl_espi_driver = {
 		.pm = &espi_pm,
 	},
 	.probe		= of_fsl_espi_probe,
-	.remove_new	= of_fsl_espi_remove,
+	.remove		= of_fsl_espi_remove,
 };
 module_platform_driver(fsl_espi_driver);
 
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 977e8b55c82b..da312905feed 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -1024,7 +1024,7 @@ static struct platform_driver fsl_lpspi_driver = {
 		.pm = pm_ptr(&fsl_lpspi_pm_ops),
 	},
 	.probe = fsl_lpspi_probe,
-	.remove_new = fsl_lpspi_remove,
+	.remove = fsl_lpspi_remove,
 };
 module_platform_driver(fsl_lpspi_driver);
 
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af..9ec53bf0dda8 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -997,7 +997,7 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove_new	= fsl_qspi_remove,
+	.remove		= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 997e07c0a24a..856a4a9def66 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -714,7 +714,7 @@ static struct platform_driver of_fsl_spi_driver = {
 		.of_match_table = of_fsl_spi_match,
 	},
 	.probe		= of_fsl_spi_probe,
-	.remove_new	= of_fsl_spi_remove,
+	.remove		= of_fsl_spi_remove,
 };
 
 #ifdef CONFIG_MPC832x_RDB
@@ -757,7 +757,7 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 MODULE_ALIAS("platform:mpc8xxx_spi");
 static struct platform_driver mpc8xxx_spi_driver = {
 	.probe = plat_mpc8xxx_spi_probe,
-	.remove_new = plat_mpc8xxx_spi_remove,
+	.remove = plat_mpc8xxx_spi_remove,
 	.driver = {
 		.name = "mpc8xxx_spi",
 	},
diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 16054695bdb0..dadf558dd9c0 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -542,7 +542,7 @@ MODULE_DEVICE_TABLE(acpi, hisi_spi_acpi_match);
 
 static struct platform_driver hisi_spi_driver = {
 	.probe		= hisi_spi_probe,
-	.remove_new	= hisi_spi_remove,
+	.remove		= hisi_spi_remove,
 	.driver		= {
 		.name	= "hisi-kunpeng-spi",
 		.acpi_match_table = hisi_spi_acpi_match,
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index d8360f94d3b7..168ccf51f6d4 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -756,7 +756,7 @@ static struct platform_driver img_spfi_driver = {
 		.of_match_table = of_match_ptr(img_spfi_of_match),
 	},
 	.probe = img_spfi_probe,
-	.remove_new = img_spfi_remove,
+	.remove = img_spfi_remove,
 };
 module_platform_driver(img_spfi_driver);
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 85bd1a82a34e..bd83e4dc63bc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1956,7 +1956,7 @@ static struct platform_driver spi_imx_driver = {
 		   .pm = pm_ptr(&imx_spi_pm),
 	},
 	.probe = spi_imx_probe,
-	.remove_new = spi_imx_remove,
+	.remove = spi_imx_remove,
 };
 module_platform_driver(spi_imx_driver);
 
diff --git a/drivers/spi/spi-iproc-qspi.c b/drivers/spi/spi-iproc-qspi.c
index 39ee2b43a516..392acc4026ab 100644
--- a/drivers/spi/spi-iproc-qspi.c
+++ b/drivers/spi/spi-iproc-qspi.c
@@ -138,7 +138,7 @@ MODULE_DEVICE_TABLE(of, bcm_iproc_of_match);
 
 static struct platform_driver bcm_iproc_driver = {
 	.probe			= bcm_iproc_probe,
-	.remove_new		= bcm_iproc_remove,
+	.remove			= bcm_iproc_remove,
 	.driver = {
 		.name		= "bcm_iproc",
 		.pm		= &bcm_qspi_pm_ops,
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 18a46569ba46..315c5e3d34ee 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -1029,7 +1029,7 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 
 static struct platform_driver lantiq_ssc_driver = {
 	.probe = lantiq_ssc_probe,
-	.remove_new = lantiq_ssc_remove,
+	.remove = lantiq_ssc_remove,
 	.driver = {
 		.name = "spi-lantiq-ssc",
 		.of_match_table = lantiq_ssc_match,
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 1d05590a7434..df74ad5060f8 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -949,7 +949,7 @@ MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
 
 static struct platform_driver meson_spicc_driver = {
 	.probe   = meson_spicc_probe,
-	.remove_new = meson_spicc_remove,
+	.remove = meson_spicc_remove,
 	.driver  = {
 		.name = "meson-spicc",
 		.of_match_table = of_match_ptr(meson_spicc_of_match),
diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index fd8b26dd4a79..ef7efeaeee97 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -429,7 +429,7 @@ MODULE_DEVICE_TABLE(of, meson_spifc_dt_match);
 
 static struct platform_driver meson_spifc_driver = {
 	.probe	= meson_spifc_probe,
-	.remove_new = meson_spifc_remove,
+	.remove = meson_spifc_remove,
 	.driver	= {
 		.name		= "meson-spifc",
 		.of_match_table	= of_match_ptr(meson_spifc_dt_match),
diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 09f16471c537..ad2b5ffa6153 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -575,7 +575,7 @@ static struct platform_driver mchp_coreqspi_driver = {
 		.name = "microchip,coreqspi",
 		.of_match_table = mchp_coreqspi_of_match,
 	},
-	.remove_new = mchp_coreqspi_remove,
+	.remove = mchp_coreqspi_remove,
 };
 module_platform_driver(mchp_coreqspi_driver);
 
diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 7c1a9a985373..5b6af55855ef 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -622,7 +622,7 @@ static struct platform_driver mchp_corespi_driver = {
 		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
 	},
-	.remove_new = mchp_corespi_remove,
+	.remove = mchp_corespi_remove,
 };
 module_platform_driver(mchp_corespi_driver);
 MODULE_DESCRIPTION("Microchip coreSPI SPI controller driver");
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index d5ac60c135c2..036bfb7bf189 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -544,6 +544,6 @@ static struct platform_driver mpc52xx_spi_of_driver = {
 		.of_match_table = mpc52xx_spi_match,
 	},
 	.probe = mpc52xx_spi_probe,
-	.remove_new = mpc52xx_spi_remove,
+	.remove = mpc52xx_spi_remove,
 };
 module_platform_driver(mpc52xx_spi_of_driver);
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index dfee244fc317..85f3bafc975d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1432,7 +1432,7 @@ static struct platform_driver mtk_spi_driver = {
 		.of_match_table = mtk_spi_of_match,
 	},
 	.probe = mtk_spi_probe,
-	.remove_new = mtk_spi_remove,
+	.remove = mtk_spi_remove,
 };
 
 module_platform_driver(mtk_spi_driver);
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 62b1c8995fa4..85ab5ce96c4d 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -998,7 +998,7 @@ static struct platform_driver mtk_nor_driver = {
 		.pm = &mtk_nor_pm_ops,
 	},
 	.probe = mtk_nor_probe,
-	.remove_new = mtk_nor_remove,
+	.remove = mtk_nor_remove,
 };
 
 module_platform_driver(mtk_nor_driver);
diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index ddd98ddb7913..debe0e3c1c8b 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1477,7 +1477,7 @@ static void mtk_snand_remove(struct platform_device *pdev)
 
 static struct platform_driver mtk_snand_driver = {
 	.probe = mtk_snand_probe,
-	.remove_new = mtk_snand_remove,
+	.remove = mtk_snand_remove,
 	.driver = {
 		.name = "mtk-snand",
 		.of_match_table = mtk_snand_ids,
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 6156d691630a..71edeb8dfc5f 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -836,7 +836,7 @@ MODULE_DEVICE_TABLE(of, mxic_spi_of_ids);
 
 static struct platform_driver mxic_spi_driver = {
 	.probe = mxic_spi_probe,
-	.remove_new = mxic_spi_remove,
+	.remove = mxic_spi_remove,
 	.driver = {
 		.name = "mxic-spi",
 		.of_match_table = mxic_spi_of_ids,
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 3e341d1ff3b6..e6d955d964f4 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -657,7 +657,7 @@ static void mxs_spi_remove(struct platform_device *pdev)
 
 static struct platform_driver mxs_spi_driver = {
 	.probe	= mxs_spi_probe,
-	.remove_new = mxs_spi_remove,
+	.remove = mxs_spi_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table = mxs_spi_dt_ids,
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index f3bb8bbc192f..958bab27a081 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -766,12 +766,12 @@ MODULE_DEVICE_TABLE(of, npcm_fiu_dt_ids);
 
 static struct platform_driver npcm_fiu_driver = {
 	.driver = {
-		.name	= "NPCM-FIU",
-		.bus	= &platform_bus_type,
+		.name = "NPCM-FIU",
+		.bus = &platform_bus_type,
 		.of_match_table = npcm_fiu_dt_ids,
 	},
-	.probe      = npcm_fiu_probe,
-	.remove_new	    = npcm_fiu_remove,
+	.probe = npcm_fiu_probe,
+	.remove = npcm_fiu_remove,
 };
 module_platform_driver(npcm_fiu_driver);
 
diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index a7feb20b06ee..e4c291e653c8 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -452,7 +452,7 @@ static struct platform_driver npcm_pspi_driver = {
 		.of_match_table	= npcm_pspi_match,
 	},
 	.probe		= npcm_pspi_probe,
-	.remove_new	= npcm_pspi_remove,
+	.remove		= npcm_pspi_remove,
 };
 module_platform_driver(npcm_pspi_driver);
 
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 5a1e55a01c52..1161b9e5a4dc 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1331,7 +1331,7 @@ static struct platform_driver nxp_fspi_driver = {
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-	.remove_new	= nxp_fspi_remove,
+	.remove		= nxp_fspi_remove,
 };
 module_platform_driver(nxp_fspi_driver);
 
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 7d8c5cd680d1..cba229920357 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -288,7 +288,7 @@ MODULE_DEVICE_TABLE(of, tiny_spi_match);
 
 static struct platform_driver tiny_spi_driver = {
 	.probe = tiny_spi_probe,
-	.remove_new = tiny_spi_remove,
+	.remove = tiny_spi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.pm = NULL,
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 03b820e85651..b9a91dbfeaef 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -523,7 +523,7 @@ static struct platform_driver uwire_driver = {
 		.name		= "omap_uwire",
 	},
 	.probe = uwire_probe,
-	.remove_new = uwire_remove,
+	.remove = uwire_remove,
 	// suspend ... unuse ck
 	// resume ... use ck
 };
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2c043817c66a..e2400a067a95 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1654,7 +1654,7 @@ static struct platform_driver omap2_mcspi_driver = {
 		.of_match_table = omap_mcspi_of_match,
 	},
 	.probe =	omap2_mcspi_probe,
-	.remove_new =	omap2_mcspi_remove,
+	.remove =	omap2_mcspi_remove,
 };
 
 module_platform_driver(omap2_mcspi_driver);
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index eee9ff4bfa5b..6ff42475f851 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -846,7 +846,7 @@ static struct platform_driver orion_spi_driver = {
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.probe		= orion_spi_probe,
-	.remove_new	= orion_spi_remove,
+	.remove		= orion_spi_remove,
 };
 
 module_platform_driver(orion_spi_driver);
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 0031063a7e25..fb3835b4263e 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -682,7 +682,7 @@ static struct platform_driver pic32_sqi_driver = {
 		.of_match_table = of_match_ptr(pic32_sqi_of_ids),
 	},
 	.probe = pic32_sqi_probe,
-	.remove_new = pic32_sqi_remove,
+	.remove = pic32_sqi_remove,
 };
 
 module_platform_driver(pic32_sqi_driver);
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index b8bcc220e96d..369850d14313 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -859,7 +859,7 @@ static struct platform_driver pic32_spi_driver = {
 		.of_match_table = of_match_ptr(pic32_spi_of_match),
 	},
 	.probe = pic32_spi_probe,
-	.remove_new = pic32_spi_remove,
+	.remove = pic32_spi_remove,
 };
 
 module_platform_driver(pic32_spi_driver);
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 4a64ea0f596f..688cabcfbc52 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -484,7 +484,7 @@ MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
 
 static struct platform_driver spi_ppc4xx_of_driver = {
 	.probe = spi_ppc4xx_of_probe,
-	.remove_new = spi_ppc4xx_of_remove,
+	.remove = spi_ppc4xx_of_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = spi_ppc4xx_of_match,
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index 595af9fa4e0f..b88b7de7a005 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -207,7 +207,7 @@ static struct platform_driver driver = {
 		.of_match_table = pxa2xx_spi_of_match,
 	},
 	.probe = pxa2xx_spi_platform_probe,
-	.remove_new = pxa2xx_spi_platform_remove,
+	.remove = pxa2xx_spi_platform_remove,
 };
 
 static int __init pxa2xx_spi_init(void)
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 49b775134485..056f02677376 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -908,7 +908,7 @@ static struct platform_driver qcom_qspi_driver = {
 		.of_match_table = qcom_qspi_dt_match,
 	},
 	.probe = qcom_qspi_probe,
-	.remove_new = qcom_qspi_remove,
+	.remove = qcom_qspi_remove,
 };
 module_platform_driver(qcom_qspi_driver);
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1a2f9cd92b3c..7d647edf6bc3 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1364,7 +1364,7 @@ static struct platform_driver spi_qup_driver = {
 		.of_match_table = spi_qup_dt_match,
 	},
 	.probe = spi_qup_probe,
-	.remove_new = spi_qup_remove,
+	.remove = spi_qup_remove,
 };
 module_platform_driver(spi_qup_driver);
 
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 225f75550780..e71d3805b150 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -196,7 +196,7 @@ MODULE_DEVICE_TABLE(of, rb4xx_spi_dt_match);
 
 static struct platform_driver rb4xx_spi_drv = {
 	.probe = rb4xx_spi_probe,
-	.remove_new = rb4xx_spi_remove,
+	.remove = rb4xx_spi_remove,
 	.driver = {
 		.name = "rb4xx-spi",
 		.of_match_table = of_match_ptr(rb4xx_spi_dt_match),
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 0d7fadcd4ed3..c44904191198 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -677,7 +677,7 @@ static struct platform_driver rockchip_sfc_driver = {
 		.of_match_table = rockchip_sfc_dt_ids,
 	},
 	.probe	= rockchip_sfc_probe,
-	.remove_new = rockchip_sfc_remove,
+	.remove = rockchip_sfc_remove,
 };
 module_platform_driver(rockchip_sfc_driver);
 
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0bb33c43b1b4..d33ed34b8684 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -1036,7 +1036,7 @@ static struct platform_driver rockchip_spi_driver = {
 		.of_match_table = of_match_ptr(rockchip_spi_dt_match),
 	},
 	.probe = rockchip_spi_probe,
-	.remove_new = rockchip_spi_remove,
+	.remove = rockchip_spi_remove,
 };
 
 module_platform_driver(rockchip_spi_driver);
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index b468a95972bf..118ec54cc64f 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -206,7 +206,7 @@ MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
 
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
-	.remove_new = rpcif_spi_remove,
+	.remove = rpcif_spi_remove,
 	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7f95d22fb1ac..92faaf614f8e 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1427,7 +1427,7 @@ static SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
 
 static struct platform_driver rspi_driver = {
 	.probe =	rspi_probe,
-	.remove_new =	rspi_remove,
+	.remove =	rspi_remove,
 	.id_table =	spi_driver_ids,
 	.driver		= {
 		.name = "renesas_spi",
diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 741e0f44c49c..7c0442883ac0 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -683,7 +683,7 @@ MODULE_DEVICE_TABLE(of, rzv2m_csi_match);
 
 static struct platform_driver rzv2m_csi_drv = {
 	.probe = rzv2m_csi_probe,
-	.remove_new = rzv2m_csi_remove,
+	.remove = rzv2m_csi_remove,
 	.driver = {
 		.name = "rzv2m_csi",
 		.of_match_table = rzv2m_csi_match,
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 51a002b3f518..dbdd85c191dc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1681,7 +1681,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
 	},
 	.probe = s3c64xx_spi_probe,
-	.remove_new = s3c64xx_spi_remove,
+	.remove = s3c64xx_spi_remove,
 	.id_table = s3c64xx_spi_driver_ids,
 };
 MODULE_ALIAS("platform:s3c64xx-spi");
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 5d63aa1d28e2..93017faeb7b5 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -293,7 +293,7 @@ MODULE_DEVICE_TABLE(of, hspi_of_match);
 
 static struct platform_driver hspi_driver = {
 	.probe = hspi_probe,
-	.remove_new = hspi_remove,
+	.remove = hspi_remove,
 	.driver = {
 		.name = "sh-hspi",
 		.of_match_table = hspi_of_match,
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6f12e4fb2e2e..4ed6613b8188 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1429,7 +1429,7 @@ static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
 
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
-	.remove_new	= sh_msiof_spi_remove,
+	.remove		= sh_msiof_spi_remove,
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 3d560b154ad3..f66efaabcaca 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -183,7 +183,7 @@ static void sh_sci_spi_remove(struct platform_device *dev)
 
 static struct platform_driver sh_sci_spi_drv = {
 	.probe		= sh_sci_spi_probe,
-	.remove_new	= sh_sci_spi_remove,
+	.remove		= sh_sci_spi_remove,
 	.driver		= {
 		.name	= "spi_sh_sci",
 	},
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 4b873d9a7602..130d7fc452fa 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -459,7 +459,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 
 static struct platform_driver spi_sh_driver = {
 	.probe = spi_sh_probe,
-	.remove_new = spi_sh_remove,
+	.remove = spi_sh_remove,
 	.driver = {
 		.name = "sh_spi",
 	},
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index cfd17bbb2202..87bde2a207a3 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -471,7 +471,7 @@ MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
 
 static struct platform_driver sifive_spi_driver = {
 	.probe = sifive_spi_probe,
-	.remove_new = sifive_spi_remove,
+	.remove = sifive_spi_remove,
 	.driver = {
 		.name = SIFIVE_SPI_DRIVER_NAME,
 		.pm = &sifive_spi_pm_ops,
diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 4a91b7bae3c6..db690cc5eb61 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -558,7 +558,7 @@ static struct platform_driver mtk_spi_slave_driver = {
 		.of_match_table = mtk_spi_slave_of_match,
 	},
 	.probe = mtk_spi_slave_probe,
-	.remove_new = mtk_spi_slave_remove,
+	.remove = mtk_spi_slave_remove,
 };
 
 module_platform_driver(mtk_spi_slave_driver);
diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index a7c3b3923b4a..adac645732fe 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -680,7 +680,7 @@ static struct platform_driver f_ospi_driver = {
 		.of_match_table = f_ospi_dt_ids,
 	},
 	.probe = f_ospi_probe,
-	.remove_new = f_ospi_remove,
+	.remove = f_ospi_remove,
 };
 module_platform_driver(f_ospi_driver);
 
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 831ebae10fe0..eaaac04ab736 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1072,7 +1072,7 @@ static struct platform_driver sprd_spi_driver = {
 		.pm = &sprd_spi_pm_ops,
 	},
 	.probe = sprd_spi_probe,
-	.remove_new = sprd_spi_remove,
+	.remove = sprd_spi_remove,
 };
 
 module_platform_driver(sprd_spi_driver);
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e064025e2fd6..4cff976ab16f 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -449,7 +449,7 @@ static struct platform_driver spi_st_driver = {
 		.of_match_table = of_match_ptr(stm_spi_match),
 	},
 	.probe = spi_st_probe,
-	.remove_new = spi_st_remove,
+	.remove = spi_st_remove,
 };
 module_platform_driver(spi_st_driver);
 
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 955c920c4b63..540b6948b24d 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -963,7 +963,7 @@ MODULE_DEVICE_TABLE(of, stm32_qspi_match);
 
 static struct platform_driver stm32_qspi_driver = {
 	.probe	= stm32_qspi_probe,
-	.remove_new = stm32_qspi_remove,
+	.remove = stm32_qspi_remove,
 	.driver	= {
 		.name = "stm32-qspi",
 		.of_match_table = stm32_qspi_match,
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c4ff074e3f6..f2dd8ab12df8 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2355,7 +2355,7 @@ static const struct dev_pm_ops stm32_spi_pm_ops = {
 
 static struct platform_driver stm32_spi_driver = {
 	.probe = stm32_spi_probe,
-	.remove_new = stm32_spi_remove,
+	.remove = stm32_spi_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &stm32_spi_pm_ops,
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 2ee6755b43f5..fcbe864c9b7d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -535,7 +535,7 @@ static const struct dev_pm_ops sun4i_spi_pm_ops = {
 
 static struct platform_driver sun4i_spi_driver = {
 	.probe	= sun4i_spi_probe,
-	.remove_new = sun4i_spi_remove,
+	.remove = sun4i_spi_remove,
 	.driver	= {
 		.name		= "sun4i-spi",
 		.of_match_table	= sun4i_spi_match,
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 5c26bf056293..871dfd3e77be 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -810,7 +810,7 @@ static const struct dev_pm_ops sun6i_spi_pm_ops = {
 
 static struct platform_driver sun6i_spi_driver = {
 	.probe	= sun6i_spi_probe,
-	.remove_new = sun6i_spi_remove,
+	.remove = sun6i_spi_remove,
 	.driver	= {
 		.name		= "sun6i-spi",
 		.of_match_table	= sun6i_spi_match,
diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 4e481380c259..7fd4cc6f74c2 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -563,7 +563,7 @@ MODULE_DEVICE_TABLE(of, sp7021_spi_controller_ids);
 
 static struct platform_driver sp7021_spi_controller_driver = {
 	.probe = sp7021_spi_controller_probe,
-	.remove_new = sp7021_spi_controller_remove,
+	.remove = sp7021_spi_controller_remove,
 	.driver = {
 		.name = "sunplus,sp7021-spi-controller",
 		.of_match_table = sp7021_spi_controller_ids,
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 7cb4301a6fb2..eaf560487591 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -818,7 +818,7 @@ static struct platform_driver synquacer_spi_driver = {
 		.acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
 	},
 	.probe = synquacer_spi_probe,
-	.remove_new = synquacer_spi_remove,
+	.remove = synquacer_spi_remove,
 };
 module_platform_driver(synquacer_spi_driver);
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index bc7cc4088eea..3822d7c8d8ed 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1518,7 +1518,7 @@ static struct platform_driver tegra_spi_driver = {
 		.of_match_table	= tegra_spi_of_match,
 	},
 	.probe =	tegra_spi_probe,
-	.remove_new =	tegra_spi_remove,
+	.remove =	tegra_spi_remove,
 };
 module_platform_driver(tegra_spi_driver);
 
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 9f6b9f89be5b..d5c8ee20b8e5 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -600,7 +600,7 @@ static struct platform_driver tegra_sflash_driver = {
 		.of_match_table	= tegra_sflash_of_match,
 	},
 	.probe =	tegra_sflash_probe,
-	.remove_new =	tegra_sflash_remove,
+	.remove =	tegra_sflash_remove,
 };
 module_platform_driver(tegra_sflash_driver);
 
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1393d159ae..6b85fb6cf73c 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1214,7 +1214,7 @@ static struct platform_driver tegra_slink_driver = {
 		.of_match_table	= tegra_slink_of_match,
 	},
 	.probe =	tegra_slink_probe,
-	.remove_new =	tegra_slink_remove,
+	.remove =	tegra_slink_remove,
 };
 module_platform_driver(tegra_slink_driver);
 
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index afbd64a217eb..40f2afad1899 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1724,7 +1724,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
-	.remove_new =	tegra_qspi_remove,
+	.remove =	tegra_qspi_remove,
 };
 module_platform_driver(tegra_qspi_driver);
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0fe6899e78dd..0b8f496c6bf4 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -931,7 +931,7 @@ static const struct dev_pm_ops ti_qspi_pm_ops = {
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove_new = ti_qspi_remove,
+	.remove = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 271f3e7f834b..60fce5c73031 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1514,7 +1514,7 @@ static struct platform_driver pch_spi_pd_driver = {
 		.name = "pch-spi",
 	},
 	.probe = pch_spi_pd_probe,
-	.remove_new = pch_spi_pd_remove,
+	.remove = pch_spi_pd_remove,
 	.suspend = pch_spi_pd_suspend,
 	.resume = pch_spi_pd_resume
 };
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 4a18cf896194..15f76855bea4 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -796,7 +796,7 @@ MODULE_DEVICE_TABLE(of, uniphier_spi_match);
 
 static struct platform_driver uniphier_spi_driver = {
 	.probe = uniphier_spi_probe,
-	.remove_new = uniphier_spi_remove,
+	.remove = uniphier_spi_remove,
 	.driver = {
 		.name = "uniphier-spi",
 		.of_match_table = uniphier_spi_match,
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7795328427a6..ded709b2b459 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -524,7 +524,7 @@ MODULE_ALIAS("platform:" XILINX_SPI_NAME);
 
 static struct platform_driver xilinx_spi_driver = {
 	.probe = xilinx_spi_probe,
-	.remove_new = xilinx_spi_remove,
+	.remove = xilinx_spi_remove,
 	.driver = {
 		.name = XILINX_SPI_NAME,
 		.of_match_table = xilinx_spi_of_match,
diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 3c2cda315397..1b54d8f9f5ec 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -138,7 +138,7 @@ MODULE_DEVICE_TABLE(of, xtfpga_spi_of_match);
 
 static struct platform_driver xtfpga_spi_driver = {
 	.probe = xtfpga_spi_probe,
-	.remove_new = xtfpga_spi_remove,
+	.remove = xtfpga_spi_remove,
 	.driver = {
 		.name = XTFPGA_SPI_NAME,
 		.of_match_table = of_match_ptr(xtfpga_spi_of_match),
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index b67455bda972..dee9c339a35e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -763,7 +763,7 @@ MODULE_DEVICE_TABLE(of, zynq_qspi_of_match);
  */
 static struct platform_driver zynq_qspi_driver = {
 	.probe = zynq_qspi_probe,
-	.remove_new = zynq_qspi_remove,
+	.remove = zynq_qspi_remove,
 	.driver = {
 		.name = "zynq-qspi",
 		.of_match_table = zynq_qspi_of_match,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fcd0ca996684..84cce78e4f2e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1389,7 +1389,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
-	.remove_new = zynqmp_qspi_remove,
+	.remove = zynqmp_qspi_remove,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,

base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
-- 
2.45.2

