Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21ED35FCB5
	for <lists+linux-spi@lfdr.de>; Wed, 14 Apr 2021 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbhDNUe0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Apr 2021 16:34:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbhDNUeY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Apr 2021 16:34:24 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWmD3-0007Qg-Sf
        for linux-spi@vger.kernel.org; Wed, 14 Apr 2021 20:34:01 +0000
Received: by mail-ej1-f70.google.com with SMTP id re9-20020a170906d8c9b029037ca22d6744so217042ejb.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2hO5DXMeLJZo3Sq4pJYNG0FO8H5GrNmCBQcI+p7buM=;
        b=cCOv+F/TCrliYJrJ14mesLnwRWbRNNxsLQrpJc0K8H4bVMIsVQ/8gQvVSwwcgVVKwb
         bF2vZnMtlVq1umj1H2s9NqKiHXOSJCuh2IcgOqPvZf1xZECgRmGlmd8S9nxGSM98DjrM
         GbI1FX5cQsjeRdB1UUJqbTxzuqmAeoUb4DHlg71JJ//SaV762Lu9JTlEfox/crbMkjjR
         8dJd5ANIFmO0vnjb7FomeGdTjrXf/aMofWUYn/vOz9W6sF17tvV+O1g/BP9XMMf3qSim
         1cgifcig8+xSkgei3m2zKB+lnCryZtk7f0oQ0KX5NIOuZ+VEnfueCNqoYQ9jp1sfo1J/
         SwLA==
X-Gm-Message-State: AOAM531U74Revh59zZDlY92YO3OE6A095IVfz1UbbIQk1MyrjMZ7nKXu
        AOCHZj9xviL0VJWthrgc2XqActFxd1onwqWkbR0nvPr9oyPkluc8DelGhLbRYzXrOaUFn8AGjB5
        9ce7sQ4eSVm6UBG8G2K/FmxSYfmMq2jF5UNH4tw==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr72099edd.168.1618432441436;
        Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Z5ptlAYigxFNCd5S/xT8AwrP3ue/ADlxR9AJcWKfkq3TLq+hwkPI3X1JJfIFB9MPghvAVg==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr72086edd.168.1618432441295;
        Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id q6sm372209ejt.51.2021.04.14.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:34:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 1/3] spi: s3c64xx: simplify getting of_device_id match data
Date:   Wed, 14 Apr 2021 22:33:41 +0200
Message-Id: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller and to
remove the of_device_id table forward declaration.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dfa7c91e13aa..c6d7641ea342 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
 #include <linux/platform_data/spi-s3c64xx.h>
@@ -1048,17 +1049,12 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 }
 #endif
 
-static const struct of_device_id s3c64xx_spi_dt_match[];
-
 static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 						struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(s3c64xx_spi_dt_match, pdev->dev.of_node);
-		return (struct s3c64xx_spi_port_config *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return (struct s3c64xx_spi_port_config *)of_device_get_match_data(&pdev->dev);
 #endif
 	return (struct s3c64xx_spi_port_config *)
 			 platform_get_device_id(pdev)->driver_data;
-- 
2.25.1

