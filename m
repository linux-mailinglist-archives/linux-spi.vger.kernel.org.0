Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8390B4C5BB9
	for <lists+linux-spi@lfdr.de>; Sun, 27 Feb 2022 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiB0NyW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Feb 2022 08:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiB0NyT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Feb 2022 08:54:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E413E0E
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:53:41 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D27133FCA8
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970019;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UeIoO3VIx05X5TBtXq8cu4tfVlY399szPon3BP0HBaq7x2fa51X47qHjBupiQp5Le
         3khp2bRthTGY5HJitXT4lt1/tjmpekzWTM0a1OFczwPxCO28he/uWzI3Pqjjm3Mch9
         tX2bPD7E+xV512oUGyigKsE06SiSRRl+B7VhsTgjE3SmNG8OVkO2ts6XwkulojDVfL
         M2YlOqIyHKLVf0/kdher8jHmtjVzefNqw9AGVZIie1Eta6p/16WWXzPyhtqOomNAxF
         G9hoAkDDLvsMpvcrTzAZ8V9z24RVLSL7d7fF3YcLh6TaxQaUot1EZAY+N2WxN8/GZT
         gCgfvDnbJ2fDQ==
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a0564021e8900b00412d0a6ef0dso4243545edf.11
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        b=FAoPh0hfHb48sRB6gmYXqb/4O3h02kBWQg5uda2ct6KdI6fpAGvQtkvpja4z6Aqa14
         DUCBdYKo3DnT6WNrCKeloOo0V5T92HiYdAc/YPcKNl+e9QqgfepQ1ZlUhLiU8aZSFz/Y
         pP7AdDPC3/KENP+c7aYg+M5SWbfEgiAamCP9FJ+u0l41T8/R3rW5m/pylx64us3TXCT3
         /DWDSqUw8ugvc8IXRCmbxS9ZZr75CM22jyKEM2S09717gB+Tu4w+i64VoG8ZJkbKHu6g
         PhxMZcTvm95gi2D3MEurFsjK6DIUclolPkFsdygHHepEpaKYpH6i6pOHt2zbyEcFJNvK
         Yi2w==
X-Gm-Message-State: AOAM533ezApwlZSHvIjbpwAqC0j70vYhqiWC/75wE1qcW7dfXMSAy+MM
        v/vThlqis5ykGfm0Us+qbhCgmqosPoMeqLXgvYAU20qOhDwbbHo69vQlaxT50bK+Hj92Ivb3ujG
        NcywBLBcy0qTplBLFLQeK9sfdI14/sourp1XP1Q==
X-Received: by 2002:a17:906:354f:b0:6b4:1449:2d03 with SMTP id s15-20020a170906354f00b006b414492d03mr13078914eja.197.1645970019290;
        Sun, 27 Feb 2022 05:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLkm/ya1hWTxNWHY0owECzZBrknUNuVIsi2Y1TI9mIZSzwklvOz9AjjK7v7g0U5lSZuOzjqQ==
X-Received: by 2002:a17:906:354f:b0:6b4:1449:2d03 with SMTP id s15-20020a170906354f00b006b414492d03mr13078900eja.197.1645970019102;
        Sun, 27 Feb 2022 05:53:39 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:38 -0800 (PST)
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
Subject: [PATCH v3 09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Sun, 27 Feb 2022 14:53:27 +0100
Message-Id: <20220227135329.145862-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 083da31dc3ea..4b2268b7d0d0 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk", strlen("imx-scu-clk"));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

