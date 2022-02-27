Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C24C5B8E
	for <lists+linux-spi@lfdr.de>; Sun, 27 Feb 2022 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiB0Nxj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Feb 2022 08:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiB0Nx3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Feb 2022 08:53:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE313EBE
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:52:52 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB7F940814
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645969954;
        bh=m4/zffFNkZQ1c8QkZX27EHIqdt+D+lrYYYcC+6RBnKM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=oxTHKuizKnfVrMj+ob15reDKgFyQGVThIe6lFkgledhCWWerBcS4wlg2oLYhIG1Le
         zh2NWcWeQPeEHdTe3A6dJW8Z4i/KAFzVHokYwn8TEfP3u0mPo3Ut9Wsys9GfpyJQrr
         btrqe0tHJcsACxOZ7tke6amglpbi1721YVRq1AIyCODdEXONE0pwMt9b3BU4sTZSQ7
         8fZnwQJl2Xg7hEIAk/XcYJqu2Gis3Ry9YbH57FHnW1M7XrV0rS0FGc1zzyVBJzEJdn
         NszgSCTalQiNKV0ga0bq2lbV7AKgT8HCaxk3s0TPEGYEPHcxcPzjOltcld2zk8pLHq
         aXKqvrZIgh/9g==
Received: by mail-ej1-f70.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo4333568ejc.3
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4/zffFNkZQ1c8QkZX27EHIqdt+D+lrYYYcC+6RBnKM=;
        b=fA/6vvFjMjGqVAn8lFQspOmEnNBtnJBB7s5/17aXGNILgIGb3h/5+0e9X1oKyrYsjM
         oRjSpstAltSCV0CFSTABdNNeRRpX9Pu7mtBDjqW6dBLXpv5MY/GmzkuW9aMO6wVBOEYD
         wuLCCN3buQaHZZbp3ew1nSTiDYibOHdbWreiXIC6MLHZrLhKz9ukMjDnPTjg+heLKeS4
         M3B3Db+pQCCWltylBXdVDPSWms8pANTuRD7A0TTgmtgxFIzgnj18pf0csGHLts2lft+b
         anow7biZ2YpyMnV7Q5XTFcwhkSSVxw6eMorFEpXbOwESdgaMupw4nSp97GQEuVvMQWg2
         Vpvw==
X-Gm-Message-State: AOAM531JrGeThTzfDqhdO7QvJL4qvwRig6+cJghFdgLfz+oQ2YXU0V1F
        Bn7kOObLVKhZttYEKFmeycLveJVkoZhWY/iRD/Do+bi2mpBmZD9rqRyUdyv17HSKHdIWHdlsHkB
        yjSs0pYB4mG2RSFmuGCXXDtUP2HUX2AZJLhViag==
X-Received: by 2002:a17:906:4a09:b0:6d0:7f19:d738 with SMTP id w9-20020a1709064a0900b006d07f19d738mr12036147eju.76.1645969954374;
        Sun, 27 Feb 2022 05:52:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDrA1IPUhAcFT/Pi1MZ832Wj6CLhe3h27Schy7iuQVqfDwWSjNQI4J+6UflVGRe+cHgFDDSw==
X-Received: by 2002:a17:906:4a09:b0:6d0:7f19:d738 with SMTP id w9-20020a1709064a0900b006d07f19d738mr12036129eju.76.1645969954167;
        Sun, 27 Feb 2022 05:52:34 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm3393333ejd.133.2022.02.27.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:52:33 -0800 (PST)
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
Subject: [PATCH v3 02/11] amba: Use driver_set_override() instead of open-coding
Date:   Sun, 27 Feb 2022 14:52:05 +0100
Message-Id: <20220227135214.145599-3-krzysztof.kozlowski@canonical.com>
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
 drivers/amba/bus.c       | 28 ++++------------------------
 include/linux/amba/bus.h |  7 ++++++-
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1a5eca3ae3c..9dffa17f50c0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -94,31 +94,11 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old, *cp;
-
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
-	device_lock(_dev);
-	old = dev->driver_override;
-	if (strlen(driver_override)) {
-		dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		dev->driver_override = NULL;
-	}
-	device_unlock(_dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(_dev, &dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6c7f47846971..7c703cb7a3cf 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -70,7 +70,12 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	char			*driver_override;
+	/*
+	 * Driver name to force a match.
+	 * Do not set directly, because core frees it.
+	 * Use driver_set_override() to set or clear it.
+	 */
+	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.32.0

