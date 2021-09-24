Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57684175C9
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbhIXNdZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 09:33:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37712
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346649AbhIXNdW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Sep 2021 09:33:22 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF10140198
        for <linux-spi@vger.kernel.org>; Fri, 24 Sep 2021 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490308;
        bh=RftmjF1qZSv6klWcASBW873Ilh1kdlTIzs3Yp04z5B0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XnDGiqk6VfJ5ibYcRtcRF2eFoPjnR+VQ7/0lqs3JNw7TI2yGFUasu6Hmg0x36oCKV
         5XqLZ+Ig0YLKvKO62ZWfMaesZ3K+Ej+NtjiKYqLWvjsRbOVDxcaXRJFS9Ao2NfLQd4
         in+23fJ3LO4tw7mUH7B08hluvz/NdIUPDGKMYuwFCTqFu2D0uIhi4trGMsxyqbaxQF
         eXQRxpByivBzUohLvgaVuNGq4eGa2BU4nSLtwFgKgeLtejnokYsr3dOAnd6dJIxoIz
         S4VB4vhi1xNaDacO/ZnVpVf92XLjzTOXo7Tdej66YuxKP6u0QfcA1lx+w4yxEj6S02
         jwxdligdxN/0A==
Received: by mail-wr1-f72.google.com with SMTP id s14-20020adff80e000000b001601b124f50so8094199wrp.5
        for <linux-spi@vger.kernel.org>; Fri, 24 Sep 2021 06:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RftmjF1qZSv6klWcASBW873Ilh1kdlTIzs3Yp04z5B0=;
        b=NxLUduWFcdH0bA8AilVTQqJ6VIllEuZBgKWHABP9oStzu9Du/8anZ6z988n1TwEG9E
         MXuh5rahZ2sQqMvrgXV6V4eI09PqwH7GfSv/zvTOyv3Cpm8KD8MP5WtUVtPooKBEz6fS
         5q9hfQrkcbkDcBQrCd0eW8WwdGjbDfkGscAuGcaTwBcMgHE+AvYrpp6ZiIQtrsTZSwwM
         L3Fb+mJgV4aKoZTZoBkfb8d0S3LwB1fwtSI8hRjrZ2gYxBwrA4GEZoMta3v8R0nyF+lp
         n1gPvqItN6LJ7EXXNDHwxsiFibTo9D16gK3YN//pKsejTJ/8D1gbJlguMRxoeWME8y4Z
         ecXA==
X-Gm-Message-State: AOAM532lYbNSJwF967MoY8atw/r1XESZlE+y1biYCoc5RiaOsilUdpfW
        gWWzH9swy8z+BBz+yQd7HeBJqQBBMR+tkIhgRXRKHOnjXa/yg4m5knlbzr5jbZ8R1GZjC8+fH4c
        NzbbQSWGN1CmbySKo1Q2RBgaHLgDQTHUyTBvTFA==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr2206195wml.28.1632490308539;
        Fri, 24 Sep 2021 06:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydXBlQtFfnaiO3/Jj1ihFUm30hEdDJWLlsLaaeE+RNi9Ds1tVr6UL5QwkjiPuJ4jdaXffJHg==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr2206188wml.28.1632490308410;
        Fri, 24 Sep 2021 06:31:48 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u13sm8240290wrt.41.2021.09.24.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:31:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: s3c64xx: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:31:14 +0200
Message-Id: <20210924133114.111777-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea824b0012c6..c1c8e15c01a2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -747,10 +747,11 @@ config SPI_S3C24XX_FIQ
 	  TX and RX data paths.
 
 config SPI_S3C64XX
-	tristate "Samsung S3C64XX series type SPI"
+	tristate "Samsung S3C64XX/Exynos SoC series type SPI"
 	depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
 	help
-	  SPI driver for Samsung S3C64XX and newer SoCs.
+	  SPI driver for Samsung S3C64XX, S5Pv210 and Exynos SoCs.
+	  Choose Y/M here only if you build for such Samsung SoC.
 
 config SPI_SC18IS602
 	tristate "NXP SC18IS602/602B/603 I2C to SPI bridge"
-- 
2.30.2

