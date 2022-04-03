Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63E4F0C33
	for <lists+linux-spi@lfdr.de>; Sun,  3 Apr 2022 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376279AbiDCSln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Apr 2022 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376273AbiDCSkn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Apr 2022 14:40:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E49E089
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 11:38:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q20so4660266wmq.1
        for <linux-spi@vger.kernel.org>; Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtEucOUUPP5N/mYQNy60J2tmYru2tvlYgmO9h18XcJE=;
        b=MzbOCsPtGwGO108/lSDaSaf1+XSDrXAe5yX1DdV0mfrCl06/DuHGGptcVp1iZ+OCZs
         Sr3xXPu+/LUQWaSua+Z9riHXtxnsjZYcgfudGMg0eGSJroXkQN+sAwRy7pi2DkWUc69u
         LRP1Jq0DgipVHVcL0TbLHQFLItz8svl7Y6g5raLhE3+qSjyR1t772d2IkpZCUfha5jsL
         eHrNfWm2+KC5ijYi8x8UCWcrLmspOUoun6wYfkN8lLtnfvh5BLRGN+hYx0WJnkU+ntJv
         MdIvqte1KodMeoX1CiPjM+5xKuzO5A1rzXr8OFxIaWEBogUpc8y4KWBCNDNf1jGVaH3J
         ayiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtEucOUUPP5N/mYQNy60J2tmYru2tvlYgmO9h18XcJE=;
        b=4gNPXl714kqpBVD/JDjUwJxkD85kT53uIKhXCexSOFPfgza1QR3Q76mSOscqklhxMZ
         sagPP8KI3EjFOzdK413D+wxRBU/cfT9MjCBIBfZmT8D/fYGRfqNK6wsYU60sE5R3FXtd
         dAcXuM3fHNxmHe9wlhEQ/79h8KrAOX8fM0lIMxGHIQ050hQVlghdLGk8t5H3/plGn+oW
         NydB1A1dO6Mh8fToCw0LxgvSz/g0VGxpM/yqv5NTRIL2aesB+ia6pZu7PQAinhlJgsY3
         dgJg517vCPhwrBlt51irlxlyhNujhslW+F5+6eVy0lXUc48uq9QO9o/xjCHrWzTy3HeK
         Pkhw==
X-Gm-Message-State: AOAM533+B6xwCZvZOqvrFwVgbRcjv9915rJccx5xTQNEi3dwb5JnLU2e
        QqNX9TBYu6b4XppYZjrz3cbzJA==
X-Google-Smtp-Source: ABdhPJyXl7rsWywHQpujLV7EDE78zSf60/dgWAa8SR6HS+xUHZ+OK90mFzRYvM677eBKG6B3suxzyQ==
X-Received: by 2002:a05:600c:3547:b0:38c:ac1c:53e9 with SMTP id i7-20020a05600c354700b0038cac1c53e9mr16601811wmq.159.1649011109253;
        Sun, 03 Apr 2022 11:38:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 09/12] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Sun,  3 Apr 2022 20:37:55 +0200
Message-Id: <20220403183758.192236-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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

