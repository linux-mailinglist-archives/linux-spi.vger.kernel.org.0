Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5A4C1BCA
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiBWTQW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 14:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbiBWTQM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 14:16:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4241FAF
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 11:15:41 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0575540806
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643740;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pVjMCgYzqof1V+7Sr6zskvN4auZKMkmvxFetwxMlLgm43iRoOU0cHfKf/FjW2Izgm
         NwZmNVC3Fqp+/2iCyYLp4m49XZ5yiUT2zkX+d3dX0mszf+fB7uCNB53PfToZc9DtY5
         Z0ZKXQB8d4E9d8q2zJpPJuaDvFkbZmTHooQfxSLKUf0+SCDWd/Ib5uIagnVezKm7u1
         zY2EBhQbWkUJ/bM4XmXynvohpoowflKNaVIzYK9dHlIiIraOftWYxrEC5qC+L25yqF
         TZGWn0Ln1e8BFgnx8SWXmwlO4BnbHL2NgbjUCOlW9VQhZPSnySc2R4oKIB0P1Gq+hN
         u7x+5/9yZ38ww==
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso14059192edh.6
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 11:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        b=TDjKg2gVHekTCnt0I70KdeMsQpf9P0hpymtPKITSHUrXIA8EqmdKU0kTnW0gfERVfr
         yRVNgiIQVyAtRek7T81t8dv+j5j2kwaPmqmoTg77ZyPEB2ZpOZBy0dh+F5Zd///98eQy
         dnkzsS4ui3sxQUkB8f5HW5AWuQuZ7Wrz8wez6xQNqcmThBMcLn+sP/UcyNGd4U6i09h3
         IFBNZ4ddqajRs8EhirLluXOiKZdFJSkM4cOGTDItVQ8GEsS38+WRcSEyPBP2dmV8r3vW
         RyoDES+HoW+HDCRLht39o0hhbDusMR2joUEZlXWEFTKzG4TBJGZcJ+1xWsa2D8yDIt4M
         r8+w==
X-Gm-Message-State: AOAM530R6ixnnqUXpgmUvNQq2Kg7oEw+3lVT+IGJX0/6gwurs1XFbV53
        orUVJZFJbx2QwZhercTU1m+JlWZ51Ckx3P7m15ZhSro+72LOv+N1XtqSjyYhfxDmnFUIPo9AD6u
        3Ln/BGAzz7E0KQkl1YvPLnr5Ha3NtOWxq8yVd6Q==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891865edx.0.1645643727235;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8vcySNYfbv43Pk2WXynTAOxXboVgUUSRQKZSxFWxW+kHULs5hedJTU2eFScz4UFZao2eyYQ==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891811edx.0.1645643727044;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 09/11] clk: imx: scu: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:39 +0100
Message-Id: <20220223191441.348109-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..15e1d670e51f 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk");
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

