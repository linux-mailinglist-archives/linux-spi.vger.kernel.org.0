Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30214C1B9E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiBWTOs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 14:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiBWTOr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 14:14:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159E40E5A
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 11:14:05 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E3C5E3FCAE
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643643;
        bh=HpbyTrdXrFaP+pceEvy/NrkKlPBl1rW1ivTy++yPdQg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EW9lBoTZZ5sSNWQ32JNKdReI2lRd8LV1VsFxKh1iYhRInxhykTRFd7AgtrY4BzMZ8
         Xteq/VcH+x3nRj81dTl6ljtIhHAkf4PYiAH3mgfffqQ0sIm7/g1LJkmjypeZnPXEtK
         Nq/hVCA6HtRvgpwXytw9bAe+FgtS1HZUbT1FA0cQXvyv1bDoh9zzCIr24XMSu8GEHo
         UsZzXTw5C02hrEhdwRrzKbsJxy88Jwwin2Jfd53zL0DwkP+7Kt+n1Os9G8WPJmFqtv
         +oMxszCDcfIb39x+kk1G11jDchTTjFwRLJB51gsnAkf7xI10N9B71Zw4SLvUQIoLFK
         0CK/up3KE9t2A==
Received: by mail-ej1-f72.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo7439334ejc.3
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 11:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpbyTrdXrFaP+pceEvy/NrkKlPBl1rW1ivTy++yPdQg=;
        b=GAEA5pKgr+XvmkJVCT3qMYDekH1NwE0Y0YTT6NZ4mnTjgEqrvEL8Prb/3CAEgfvKEP
         9CW4rcAKWLomj4hEIb9WsMw1wzjfiAJNZUJW5XTiz2SPFvITEYrX4t/++96T0whBTWX+
         lGb9W84b1+2P6dvkEkRnWIZZDPcEm4UDP2UJam0pvLqoeoYogPulioFnSgueCH0dDydG
         EuE1/HO5ipBJMYZ6m7UJON3Zn+TjgAm3aA/5kq7fuzfKIYfb5dNAuuPhVCHyf+k/CqL0
         JtQ6DeRLILghpFpyTRnTtSm6EVz6sHDDcLvI8kTYgyQNgeG5mpuvr+OfCIEdnwr9TVmZ
         0fjQ==
X-Gm-Message-State: AOAM530lfeR93CKNHvAlCyKv0+j5etC8L581xS3XpkbM36ZA/BpR94Z7
        wB4xDiWvj4EkwYOlkCe4J1/RquQPGLBwy2GJ9X16x53FNVOMqTqJNDpm1594eyysOeCUqXFusl0
        lK2069K+u28Hyi8BAHD8/PXAcDHqjJwjrpjZ5Jw==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr848346edb.169.1645643633255;
        Wed, 23 Feb 2022 11:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYG5EE1VK62qsOOiEHtkeJRCih/epa6U/E9Szqr9uJDRTwmiXA+urJE3qxE0O0qjjabVNPNQ==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr848325edb.169.1645643633058;
        Wed, 23 Feb 2022 11:13:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:51 -0800 (PST)
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
Subject: [PATCH v2 02/11] amba: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:01 +0100
Message-Id: <20220223191310.347669-3-krzysztof.kozlowski@canonical.com>
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

Use a helper for seting driver_override to reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/amba/bus.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1a5eca3ae3c..12410c05ec70 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -94,31 +94,15 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old, *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(_dev);
-	old = dev->driver_override;
-	if (strlen(driver_override)) {
-		dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		dev->driver_override = NULL;
-	}
-	device_unlock(_dev);
-
-	kfree(old);
+	ret = driver_set_override(_dev, &dev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

