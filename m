Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B04953BF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiATR6H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 12:58:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40728
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233314AbiATR6D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 12:58:03 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B68394002A
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642701481;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vhcDZZRFEmkY22c6I7rDHDL1V+VoQMk+AkUsg7tRkTtgS7i5bTgxltllAirbqj0aB
         onvYTPf7zzdO1IUmOX778SJ/I5c4fEoefhVdkt6DtjwMFin5NM/W75vACwUJT60JVF
         dfAZ+xddDrgcuKNn5MVP4rNGW58wrH14yi6SbRq5Lj6gFpI623GBdipUp1w+lLRzV9
         LIu+oiFDhdo7ievbKBKwayvSDvEl4+1Gf2qkm0+yNs7JLkTFQa3mrO0IYLT0DyugJ5
         P/B9eMHnZQtjnDH+XH4iklSCvP82IFUAVt7CGSj6N34KmiqKDoG4bOVhNqb7KDxIdh
         Kf2MBL/ycgarA==
Received: by mail-wm1-f69.google.com with SMTP id c188-20020a1c35c5000000b00346a2160ea8so3248676wma.9
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 09:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        b=dZcw+9prmBBWADcnEeaVrT/CMqD/mjYLt1c9UpjR9Ueba1+M3kfmNOGaBf6EnAus4s
         kFMbwTNEal46fbqwrt6m3FOTc3v1T2+UgcVp2aWOWpVLi3T4Tj8NapYateBYpWw8gIny
         aenSTDu/oDH/bOO3yisUxgCbH2ealVqZo5SP+eyOf7kIts9PDThyh5Y6PknEYHaDU9RD
         RNCpSVVNff6GRJPfWIyzcwP8ZS7TE12RCUon5Mm97HbCh85SNIOhMUtz7Vf/y5kDbfkO
         Syu2KtE44uLMsU6bC9WEqaAybAXBOyqWN2uuPpoF3dwP/4Sfyozc0vJ80Bn2zsv5uef8
         ARhQ==
X-Gm-Message-State: AOAM533UzIPCR2FsDolwzxEMNlHZVSHG3nv3gQFY+aej24A7yTt5q8ti
        kCAe3gfpQyJSQGozfDXVfoswH73T5Y/pCaioAmHm+xgRNZKAHyzTOT1AvHA4VjpXG6R93+uEKf4
        2rb+E9jo6CTBl5H/zIpD13o8OoapwuXdl8LG3TA==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9989439wmb.73.1642701479319;
        Thu, 20 Jan 2022 09:57:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqTIBDSwhzIJAAvThOjafSh4STpzbcmwUKvBnw8h3aAFohpEEpbyymlmGUkzLSw2lwFS1cZQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9989419wmb.73.1642701479169;
        Thu, 20 Jan 2022 09:57:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a15sm3345248wrp.41.2022.01.20.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:57:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Thu, 20 Jan 2022 18:57:47 +0100
Message-Id: <20220120175747.43403-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..386550fca81c 100644
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
+		dev_info(&spi->dev, "feedback delay set to default (0)\n");
+		return cs;
 	}
 
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-- 
2.32.0

