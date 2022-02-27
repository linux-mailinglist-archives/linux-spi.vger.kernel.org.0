Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34E4C5B8C
	for <lists+linux-spi@lfdr.de>; Sun, 27 Feb 2022 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiB0Nxh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Feb 2022 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiB0Nx3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Feb 2022 08:53:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9E13F11
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:52:52 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4D2F4092D
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645969956;
        bh=lHEHPtP6JAM6zCrRNeDTlRy/WZxSvWGZvNHgREr2xAI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YYmIWvVBd8hAFKEneAPLXYvqJ9NoKRtnpMxIJ4oseziHn09PwdtEiJRJyI+P9Yknh
         W2UrUeff0ISfpOfG29569jJj9VDkChvoelDDft8fYyiE/Qxi66iLAixpG9N04i6OUS
         cpydPFLqqM3pxbCqHvpbxA+8AVrTTNLEU/mijOBNLynWTL7OxZwkm6O2O810isJSBf
         Wn/dXwCQXE6MwQVqRhoi/+VVDSaV5FEUYStscR+XXN9UWqwIKLRrJSf8fKWOTiJIap
         1jKdwB8teRK+RzFlg46MP7VeK/htTvC+N3j/1gQ4CU79Qf/khV8EeJ3sKbWaTI5kqk
         p2IYti553vjvw==
Received: by mail-ed1-f71.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso2415912edb.10
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHEHPtP6JAM6zCrRNeDTlRy/WZxSvWGZvNHgREr2xAI=;
        b=6SQYmdlPfB7OL70yjEDCppCusU2x0HCU+d5rQbLv6GWWvskk99Uo1JuqQYfkpCq5AN
         45jQFuOYEVtAqE4rehySScpnlpeBamTtJEiQSlmdYiY+sRIBcaHaJomZmKcn9fEgINUS
         GDPMDmHFOOgS8xyS0TelQuXnIokGko24+G3ai/B4muTskyqRDhrXYTNky3VbIy1uQnYM
         GBVphrFqfVOQMB69HeEXxZoJv9EgLEjAHv0O5SUAJtg+7ZeP8YggQaPacSLRrVrXpgyk
         cSe2COItsOP+HPbljd8egbwV3lqoj9LbmWxxuD6LDLHtPGeMiy7uWUkKEanirRzjlzTo
         eiuA==
X-Gm-Message-State: AOAM531JTT9ScWyT45H9CW2HLHuwa6et8NK2XKJfxO4PVnPkSMsuhs7+
        AX723wRQM4y7x0kvI7jqgwoUhnNHg3Ut2IsIoNI3heHm7uGQyMjCga4Ctp8tIEypJu7ufl7FWbW
        EepQzKWjxMAoiQOFRp5g4Ww2zqwcSjhQuZOegZw==
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id b12-20020a170906d10c00b006cd4aa2cd62mr12751204ejz.229.1645969956003;
        Sun, 27 Feb 2022 05:52:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXq+ZARVgwx9GQqR/xqmr4FidvI0jbXs/SPWVteyhvLCXz3Udlc0TuaU2TzyIf2JoyZYkY6w==
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id b12-20020a170906d10c00b006cd4aa2cd62mr12751178ejz.229.1645969955744;
        Sun, 27 Feb 2022 05:52:35 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm3393333ejd.133.2022.02.27.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:52:35 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 03/11] fsl-mc: Use driver_set_override() instead of open-coding
Date:   Sun, 27 Feb 2022 14:52:06 +0100
Message-Id: <20220227135214.145599-4-krzysztof.kozlowski@canonical.com>
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

Use a helper for seting driver_override to reduce amount of duplicated
code. Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 ++++---------------------
 include/linux/fsl/mc.h          |  6 ++++--
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..ba01c7f4de92 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -166,31 +166,14 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	char *driver_override, *old = mc_dev->driver_override;
-	char *cp;
+	int ret;
 
 	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
 		return -EINVAL;
 
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	if (strlen(driver_override)) {
-		mc_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		mc_dev->driver_override = NULL;
-	}
-
-	kfree(old);
+	ret = driver_set_override(dev, &mc_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 7b6c42bfb660..7a87ab9eba99 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -170,7 +170,9 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
@@ -204,7 +206,7 @@ struct fsl_mc_device {
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
 	struct device_link *consumer_link;
-	char   *driver_override;
+	const char *driver_override;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
2.32.0

