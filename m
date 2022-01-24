Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B59497A3F
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiAXIYF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 03:24:05 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58634
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242150AbiAXIYA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 03:24:00 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F8FF3FFFC
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012638;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JSWnxyc6Ynxb4pzX0DEiloksdMGeHVH6a9RN36NM0CxF6rmsONQ+hL2l9dBHMFvjB
         z6JSuTDgV5/BKMd1xaTWFZK1rPg2NhY4OhzxdCqTYvI3Og0fVfnzpwcon8qI397GjX
         iK9t4+pMFlgIwuYpspxZ7nUKciXf11UZYK67XL5sEZLgiPP02j+BBixUbYnjA8aJUs
         z0j7L8lKXGFADXh6fAMbEZDzJWe6YxFdP+I5LFJKRCK7BywQfIGhKAXdicexuhs7tA
         sNekQUWlnhnJeA24NqgDOwaXGtYXHEGwasAA8yeT93d5s87JDZRCGt4QZfMWAE6uyy
         aVoeygH+Oaumg==
Received: by mail-wm1-f71.google.com with SMTP id b4-20020a7bc244000000b0034f4c46217cso2871469wmj.0
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 00:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bto/xpfUsOVGNmCnHot8/BAzxWmx4lezX3yYM6aPOPk=;
        b=EAiCwiC/8jN3a/EaC6QfYhks7FOJ4YySeJa+vGxVfZcePFjn2ncYG2L7Xo6Owfrbsm
         uKYjKR9lTL6ofCv1CKGfpsY5TaFt20gJEcBx6T8nmG6OM/VX7wsatKOptdAz3IGoGW4T
         NHZmLn8VpzZE9mpDSLEDrX4YR4MWwiERcVgpssV1QYX9UfdWG+QCZdCy3PdRmwf2m40N
         /6g8fmcjVgLHqsflCTvunDW9dd+TyxddKwrWedmkKOoUxatFOH+itppwSRhfYRcatwJc
         XmJXP+WNwr8+A5xz5CLXQp0JKa0WLLspbiyd+zV+5cu/OT3lXH73hW9XXIyf07h8pCOb
         g2YQ==
X-Gm-Message-State: AOAM530e4ZvoQWpfbrBBfRwF1dHPmgR2iFtA6QFfECqKdXkAeqMamOFy
        BqwzgcAxVGio6q8oUtXhw3afKlPsn9AzisKUW/4IhtVr4zkx4GsyEWKkE28ku19h/MLE+BQqjbp
        WYOIY94LdafEyd6G1+6M1+T8bN+8pDmngmHCAuw==
X-Received: by 2002:a5d:64c1:: with SMTP id f1mr13620192wri.214.1643012637902;
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbDEtlR+A8QosvqD2D6NDMpI/LZF+F4pIQPaln/inShBkt2VmjdWxKP27qiPZUiadTkD+7Dw==
X-Received: by 2002:a5d:64c1:: with SMTP id f1mr13620166wri.214.1643012637710;
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Mon, 24 Jan 2022 09:23:47 +0100
Message-Id: <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
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

