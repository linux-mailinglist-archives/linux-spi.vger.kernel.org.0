Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6979B1F90EC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgFOIDZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgFOIDQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:03:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ABCC061A0E;
        Mon, 15 Jun 2020 01:03:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so13609903wmd.5;
        Mon, 15 Jun 2020 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdBft9EbSQxaFcZTBWSVvkfUii6hPWZmZod51XcwM3g=;
        b=g0xVjqvB6k9fvH6NGm+kO1T5wfZO8l3HKdzO0wSQSvO2LpekjvxflpTQDNAIQwNFao
         CkC2YMDv0ekrfG7O72j4wUaOThC9p2xN7Tme5DBv+m+tVSh7ZrzvlkDbEBOZ7ifa9usK
         JiwaiM2Dr8wZX+5MtOVp+PPFMUJf+zc5KIexFxEwW31/CM2AWYgZCg46reKbT1t3Gfgh
         4Gq8r9CvsBhuWMUMYuGX62d25dJ8CzujSjfQjRUapV+wxzqtu+AYvmTD7jpQJWmoeA8I
         qgqBqONep8a3VQZFmNc5KlCL+2UFCM1nojOHZrNSX8rYNo2XpEZG02QzWTp7NngeiSmy
         r9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdBft9EbSQxaFcZTBWSVvkfUii6hPWZmZod51XcwM3g=;
        b=QDzkuBGfFPxGkxyzaYEYuneq5sqs9NqLfkSeFvLQQIyp5MpFUYFtIKJYkH5xe2oKl2
         08dBQrfhpxdqNmdxbLQmVcQsgDn/tDJeY2Y73DIw3ue1y57PBbwf9gGFnloIS+yrubfH
         UZvAeootRzbNhOdVQH1a7Ze+HJtsvFDnXKkyx5Ku4p0ybAxZS/9QyQ84uKl3++LtWKo2
         izFH+WPHSFKBpe0KBYKWEJEhnOja3nBjp0op2Q1veyYpT+RoRIpPGF1lnTZKCv6ozCzB
         zjfy+pWsdTQwx0R8AS84VfZNJBBNO7oiEDoWsZ05NZG0upb5woSaY3ZvKsvk1iWGcRBQ
         9Btw==
X-Gm-Message-State: AOAM533nIZp0XB9b2LHfAahacqHwXa/q32pWjPbkET1n0PJntDp1msIY
        ANBdER6FN58VAfVHYwn3P/I=
X-Google-Smtp-Source: ABdhPJwYOlEd8lleqkaydTaZ9E0KnDTQorRKqyyOV9fUtb2vgr76+4VExaNKd9kXu5f/DzFqlcXUeA==
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr11782506wmg.70.1592208194668;
        Mon, 15 Jun 2020 01:03:14 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id d9sm23107054wre.28.2020.06.15.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:03:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 4/4] spi: bcm63xx-hsspi: allow building for BMIPS
Date:   Mon, 15 Jun 2020 10:03:09 +0200
Message-Id: <20200615080309.2897694-5-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615080309.2897694-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm63xx-hsspi controller is present on several BMIPS SoCs (BCM6318, BCM6328,
BCM6362 and BCM63268).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a9896e388355..500774fe1351 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -155,7 +155,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.27.0

