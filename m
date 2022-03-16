Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6112B4DB43F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Mar 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357012AbiCPPKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Mar 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356993AbiCPPKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Mar 2022 11:10:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE3652D7
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 08:09:09 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 26EE73F1A1
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443348;
        bh=yjxT3cEgNPbxxzjxaxofFiViREMV9sxUDnIsV8OP+D8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ASPWY56z2SIG8YhPnK1HQ4g1UcPDdFDJdlDkD5cyrE9w5SX31bFizyp6RUmcz0+Zm
         xEQnk8u5U9EvfLguCm98Hj42FdUPRo7lVCA8kxrw96ccuuQ+LBJvGU0HzzBaZV+Mww
         xTtQPkMjMOqwty1GWP2xeE7ms++L23KPVXVUVnxTST94V+eHfjAOtm8770W7um7Yth
         D6wMWM6NYkinDoY7bog0Syk+Q0AIebvG4MCAtekPHTxzT4TgGSi0kSJCLdErRpgKDI
         2eO5JIcyK0yeh1P0NP+zbauxu6pxPSHSk0jMsDx2g6yWpU8I4mIP3/Bj25OCXIWK10
         6WxcgsIzw6CQw==
Received: by mail-wm1-f71.google.com with SMTP id o33-20020a05600c512100b0038a1d06e525so2898653wms.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 08:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjxT3cEgNPbxxzjxaxofFiViREMV9sxUDnIsV8OP+D8=;
        b=Um0EFnoFjV8dWqlcEyQKV160Hg6Xo4x5dkBRagFlvSj9eT8J3gvWfVmiG/eqU47sFO
         WtPnZ2Ob79KX0+VXpmC6p9uJM7Hf/dL6oC6QN8EdypTYAsu2BSLsbHKBWdbMEk/i7LiM
         JpIhvjsL3ThPwKkuoP6sixZAnjjDMpg+XGgEf+2A8NMKBYcOKrfS1ggOxNMVlW8U5m4e
         hKKN1TopuopE+8WVmpxAOq2wBgiEMtSZs/mGcvPEnJxxknDrvNZimqv1SsIQ2ZozaZfd
         5N6tg16zu4itIqYYFi61+6J9bgzKbI05PUVFIVuOddeKn9PrgU12svWDCmHUwyOeGWy0
         PDUw==
X-Gm-Message-State: AOAM530dDFW1pm0GlxbzpoUJI46wMPRDTJihandHoFo4hTKL+uVson3n
        b6AkM7/nxsYjbQPcbV0q6CbApP6cEHt+uiUJnnwNKo32PN9y5bjksX4bAcj5IXvmFYDWTyhNpkd
        IIgF1s1OXhZJb6LVQuNkhk8StL1jZRWKX1SHrOg==
X-Received: by 2002:a05:600c:3d8d:b0:38c:6f6e:e61a with SMTP id bi13-20020a05600c3d8d00b0038c6f6ee61amr2475301wmb.101.1647443337718;
        Wed, 16 Mar 2022 08:08:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxihfOFhqnyQOV2LqVMQfkoNfvlmhYMokdGWLXgOBRd3UZepsNC84lNIG8stGIAXm3FyJnJA==
X-Received: by 2002:a05:600c:3d8d:b0:38c:6f6e:e61a with SMTP id bi13-20020a05600c3d8d00b0038c6f6ee61amr2475269wmb.101.1647443337539;
        Wed, 16 Mar 2022 08:08:57 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:08:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 08/11] vdpa: Use helper for safer setting of driver_override
Date:   Wed, 16 Mar 2022 16:08:00 +0100
Message-Id: <20220316150803.421897-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use a helper to set driver_override to the reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1ea525433a5c..2dabed1df35c 100644
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
index 721089bb4c84..37117404660e 100644
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

