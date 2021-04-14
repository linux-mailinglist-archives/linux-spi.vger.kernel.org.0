Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C835FCB8
	for <lists+linux-spi@lfdr.de>; Wed, 14 Apr 2021 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhDNUe3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Apr 2021 16:34:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50471 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbhDNUe0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Apr 2021 16:34:26 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWmD6-0007Rp-1K
        for linux-spi@vger.kernel.org; Wed, 14 Apr 2021 20:34:04 +0000
Received: by mail-ej1-f72.google.com with SMTP id bx15-20020a170906a1cfb029037415131f28so219395ejb.18
        for <linux-spi@vger.kernel.org>; Wed, 14 Apr 2021 13:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnsBrJR/4Jhy/GeQbcflnHQbmvQg6xzGpkQctWEUZLc=;
        b=bsx0em2pMgKFxWJIRIGOAuVeduwT5BeKH3lwQbqN4Ng0pNj1EpSHgMIkRRaHw34dFy
         HuBFgLHEfoQbxroD0XAMq56yeNYugqrsIXxvojVtBt2wdMuBXlZtQMWrAz1obPaTeg0N
         y1oi2Sy61iQuwTsRXO+47lKCNdc3qpUUw+7IAWYd5E2NwKG0ESLbPvTQYoYvH/KG1lGg
         I3HGtqLQhBWC3TtGxUJllorEyWXV1nPZu3mx4BeoLVGfaw6GBc0sODOYp6mADvnWsuXP
         YPvyx9yEdNzKP8eYzWPWGlC0YBWIJTn/vw6TuU7iywz6eEXXB6tSp/+ZtP5TTXTikQ4J
         qThQ==
X-Gm-Message-State: AOAM531kLovjwY+S2SrEc5KjS0uaPr8qtoQOgEIYkundrU7jjbukG1/x
        yoUkPpDDgrCOh2by7fDXBOZbG60LijQCad+4g19Bll5WYYSCcoVVg+Gua19AUpG9cv16/gg15Kl
        9dr4diiq0FTsz1XUZfHr6FPS7SI+jqyTD/a7zhw==
X-Received: by 2002:a05:6402:3092:: with SMTP id de18mr77349edb.96.1618432443691;
        Wed, 14 Apr 2021 13:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4ge9Wh6Dy2ti9MnagPxtY+Lp7PT4OXoKWYxYA7ocEK2jErwNRrZdhQ86yjzHKPsL2D62BKQ==
X-Received: by 2002:a05:6402:3092:: with SMTP id de18mr77329edb.96.1618432443522;
        Wed, 14 Apr 2021 13:34:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id q6sm372209ejt.51.2021.04.14.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:34:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 3/3] spi: s3c64xx: constify driver/match data
Date:   Wed, 14 Apr 2021 22:33:43 +0200
Message-Id: <20210414203343.203119-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The match data (struct s3c64xx_spi_port_config) stored in of_device_id
and platform_device_id tables is not modified by the driver and can be
handled entirely in a const-way to increase the code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index eac3c300f806..8755cd85e83c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -190,7 +190,7 @@ struct s3c64xx_spi_driver_data {
 	unsigned                        cur_speed;
 	struct s3c64xx_spi_dma_data	rx_dma;
 	struct s3c64xx_spi_dma_data	tx_dma;
-	struct s3c64xx_spi_port_config	*port_conf;
+	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
 };
 
@@ -1049,15 +1049,14 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 }
 #endif
 
-static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
+static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 						struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
 	if (pdev->dev.of_node)
-		return (struct s3c64xx_spi_port_config *)of_device_get_match_data(&pdev->dev);
+		return of_device_get_match_data(&pdev->dev);
 #endif
-	return (struct s3c64xx_spi_port_config *)
-			 platform_get_device_id(pdev)->driver_data;
+	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
 static int s3c64xx_spi_probe(struct platform_device *pdev)
@@ -1395,27 +1394,27 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 			   s3c64xx_spi_runtime_resume, NULL)
 };
 
-static struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
+static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.high_speed	= true,
 };
 
-static struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
+static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 };
 
-static struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.high_speed	= true,
 };
 
-static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1424,7 +1423,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
-static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
+static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1433,7 +1432,7 @@ static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
-static struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
+static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
-- 
2.25.1

