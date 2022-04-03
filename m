Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185E74F0C0B
	for <lists+linux-spi@lfdr.de>; Sun,  3 Apr 2022 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376298AbiDCSlG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Apr 2022 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359855AbiDCSkn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Apr 2022 14:40:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D2E91
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 11:38:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so11374568wrr.9
        for <linux-spi@vger.kernel.org>; Sun, 03 Apr 2022 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7atrdHIPQWrKPdmTA65creUl3MO148uK4lDHmIisbDg=;
        b=hVNX9Cidu2X/sm6u9wyAYEGqM/0IBQR2YvOEDgs8X1o5lfX2h1WHmc/4g0P47OrafO
         F+LHnXVltwQtgcm4vDmUAJxCpS3dj/NvpeYdiV7BjSEw65jnEU9Y2hfnPDeRaCANOHM4
         mc8xkmvx0E50fhFCSilb4TNIPXVpKBzFK2JWisIgiHGHdMTr3WCheZOmvXNx1ZOPUZnm
         UyAOB70hUZLLUn089nOrWn/JVQqqGcLUe6BqjthrWDW5YJAZnN1eAsrTvK7/RT421Uvo
         I7cb77/HfmJZ+FUQFn3z02MoVja74qNVLv49IJwubMkGcSoRfDyhGrwGLUzitdsMPsWH
         LXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7atrdHIPQWrKPdmTA65creUl3MO148uK4lDHmIisbDg=;
        b=LLPwAyw7Aa9mmkB5zidlxPf9KDXhfMUtIlRC1/znZC13NEViSU07RUETx7t3fehrbs
         HTglQqMZ8o1GZwatZPu8AtpyaISowO6Kk54gqfM7pdFKnJDwTRE9Tjsqfnx9d3zj1R1W
         3IVs1IGhJBwtmfBZYoCOM/gLJdItNw3Pdp2d7WRZNJokKc8l9q6aaPZLY2prlLRnNXI8
         tGVGnpkkyOfxkgfRBg2Aiwua12HTAeMonwdEt2QPzAKfST45QS5fwabgHlxm4RDoi5Lk
         1eb6xFbu+5bIuAcMd1o3zxB64zbJ8/Ax3APIKHCk7H+rh2inp9LIaEoB8fI09amBHJnu
         +jpA==
X-Gm-Message-State: AOAM530J5Zvp29OnYDH282SBF8Knmp2t02B3j1PdPG0cFGR8HZwewHKP
        SkvRIu3w9exLhj108Etm8XJ6Yg==
X-Google-Smtp-Source: ABdhPJy4yd5YoqphkuK9k4HQTLrBtQPx3QnrGk9JujddMnXXbGWsTVahGCOz4/3Jom2tz+Nx6nWEBw==
X-Received: by 2002:a5d:4dcd:0:b0:206:6c0:b814 with SMTP id f13-20020a5d4dcd000000b0020606c0b814mr5500047wru.493.1649011107352;
        Sun, 03 Apr 2022 11:38:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:26 -0700 (PDT)
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
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 08/12] vdpa: Use helper for safer setting of driver_override
Date:   Sun,  3 Apr 2022 20:37:54 +0200
Message-Id: <20220403183758.192236-9-krzysztof.kozlowski@linaro.org>
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

Use a helper to set driver_override to the reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 2b75c00b1005..33d1ad60cba7 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
-	/* We need to keep extra room for a newline */
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
-	device_lock(dev);
-	old = vdev->driver_override;
-	if (strlen(driver_override)) {
-		vdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		vdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8943a209202e..c0a5083632ab 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @config: the configuration ops for this device.
  * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
-- 
2.32.0

