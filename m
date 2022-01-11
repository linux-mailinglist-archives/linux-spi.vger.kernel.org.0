Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0248AB29
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiAKKNu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 05:13:50 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41894
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348778AbiAKKNs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jan 2022 05:13:48 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 055A640048
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896027;
        bh=vkZ3shAsrts82aZQTD9Odzm7oGr7rqF0WKQDjTKTwd8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AsSy6TnxbEX9P9XkYo75tUEdzUi/QNUnxZtzQQaEXG6LEu4gKkiGy4eVjmoLUcapY
         6WhAAT6NaSssf2deKGqTP5U5jZYXk7hhw+U/cJS+iv0P+ORut60tC8iyd9b5uapSPx
         kVWatiiAuxpf2eDOocJu1vVSgr6/QMbI4b9BkHbdOTPdWLB9QdvQR4T2ljnq+hHq9T
         y5UOgs9lYQmmXx/3HWNlKNS6WOSjr84AFsVabhwUoHQS1AkBkX1MDXWF83j6I+e+fW
         ocYfMXcQcrWTUjQb/Dn1WtERIg3u2lBlYQTU/ZmKWTLIy90/yagUddaoF1XJH3iLbE
         Lt5i00s/sOUXQ==
Received: by mail-ed1-f72.google.com with SMTP id p8-20020aa7d308000000b003fe9b0c4760so2704184edq.17
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 02:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkZ3shAsrts82aZQTD9Odzm7oGr7rqF0WKQDjTKTwd8=;
        b=6LxgOgWI8D6IFZlDwRxUL2u0QE2p1F61kSKNYyijdQjixOCztSoT2tfEdMUjjflILJ
         ++OsCfSQbwnu4QJ5M6uwHQlOj6IcwQlWTdBhzJVqNQXxB/t1jmN/34xoxMmaTj+8pp2e
         KwvzimK0m5OYuOFgsEjwlmxbjppdn9/1EiWOFNDJy0QZ2gTMRc7cYvmkJ2leALQRr1Gu
         Us3ZrC2nCN6VCMyfqrqVel7EfNwiPlDpPaq6cJJpziNPCJ9smJ0+WvC/Da4gwqZAZNYM
         HyscroBATYlBG2QfXAHsb2viJTdzkttMkp/AdDrWQKgyu5uHwAb4xU42iEYu+lGL5BvR
         ULMw==
X-Gm-Message-State: AOAM532560DqEW52ArLhbshlSsPlcyv87DnFFIrUaURIdJIgFlq2NMlg
        4Z2od53zCDiNqqKfXQYzalpmUf/FFtlscCJV6ODQrZk1coBdcTV2yOGHs/UoIYG/MHFM6x2SR+S
        ZVaY6faLCQ7dt6jLMX/BqlzcPxWrVczp4GwQGMA==
X-Received: by 2002:a50:da48:: with SMTP id a8mr3517605edk.155.1641896026737;
        Tue, 11 Jan 2022 02:13:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrMWwC4F5CYCPwNtrsTc93H/KSEUuKQ3dZ2KWyqGsikQRFJIiGNhQmyHnezI5HUpc6kJMojw==
X-Received: by 2002:a50:da48:: with SMTP id a8mr3517597edk.155.1641896026571;
        Tue, 11 Jan 2022 02:13:46 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Tue, 11 Jan 2022 11:13:38 +0100
Message-Id: <20220111101338.58630-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Samsung SoC SPI driver requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..769d958a2f86 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -796,16 +796,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-EINVAL);
 	}
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
-	if (!data_np) {
-		dev_err(&spi->dev, "child node 'controller-data' not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs) {
-		of_node_put(data_np);
+	if (!cs)
 		return ERR_PTR(-ENOMEM);
+
+	data_np = of_get_child_by_name(slave_np, "controller-data");
+	if (!data_np) {
+		dev_info(&spi->dev, "child node 'controller-data' not found, using defaults\n");
+		return cs;
 	}
 
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-- 
2.32.0

