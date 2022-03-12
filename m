Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566034D6EEE
	for <lists+linux-spi@lfdr.de>; Sat, 12 Mar 2022 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiCLNag (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Mar 2022 08:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiCLNae (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Mar 2022 08:30:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538F3B3F9
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 05:29:29 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 36C07405C7
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091768;
        bh=omHdnhYiVzDdXVNfQeQ6+CS2gK0y2vQxkHVBCoxIVic=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SfW7jzpjh3u4wDl9UR98L1jZK+4hyDxsNciLqWcAqqUPIAxWSnKahgOQESOvMlOaN
         FjpEAnyL2tlPUSqCcP2CUOE6B1h323FCQNJPo1exI6KdMHYPq/yINbxEvK3TtGxShD
         /vExnXcQntqo0t20NoE8g/LsWzqUIrmobyrdFGsa4pzfmy5oYcPbbH7KA1F1nL5wGD
         y6ALx0BUaxqZ9hOdk4sh0g/sI/kNozfFasoa+q78hvgVNZYIx6Uop04jCcXDsA4DN6
         aRMwtwqvbSlbKePHi95TWNfA48XUrjs8lY29WDUBw+XhPfWgL9r0m8BprG5lLIPqFB
         lo32n3262br4Q==
Received: by mail-wm1-f72.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so6904458wmz.2
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 05:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omHdnhYiVzDdXVNfQeQ6+CS2gK0y2vQxkHVBCoxIVic=;
        b=GKpN3jUxNFLzC0QLmbK4VIr7eSRYsFEDHtrrnk4QTD4OnY16/tXenvvl4L1h5ajbT5
         0vuQCxTs/cB89+qKaeEHLBWBw0y+ttOd1gQxOZ+h48f9oZwhKvi6wKejpERBglp8CoW4
         lCNRvNcV64z2Sb7sDraoqPBl7J6xV9pes7uNqtooo8nzDFYQIaFUDzEQrIx2dOTSLxWE
         I0BoxNVTFp2NRn6X79N7ezmR4zQk9PKhV6ATxuUmLBMXhsg0WtGedRIJEvgrv5lK62aq
         B43TtN1PsX++TuqloqHQM82q5ppU74Wcc0hErXaCeJgPYvARsxG+vSAZKZ+OwhV6ZACz
         5drA==
X-Gm-Message-State: AOAM533zDAo4Car4FR6k5uztUAe6PVduQNBwOYfVXTO82241wISt2xqU
        HF7sgPvJ54jVcAijfU2hYClC2iA+JFCezKfS3BnK7i1Ma5GcgyB5VoEDmJXxRtn/0/L7eRUFU+Q
        DdNNIH+2JvsfU1/6IOlMci63mKCLjS3HVwm4fMA==
X-Received: by 2002:adf:f44d:0:b0:1f0:49bb:fead with SMTP id f13-20020adff44d000000b001f049bbfeadmr10583049wrp.586.1647091756883;
        Sat, 12 Mar 2022 05:29:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/VzmVA5JNvsX6TR5L7X8QpqfI/POyM5THNfZEIE7XxPWAZ/IgTk7OADHiVtKc+QUuykZL9Q==
X-Received: by 2002:adf:f44d:0:b0:1f0:49bb:fead with SMTP id f13-20020adff44d000000b001f049bbfeadmr10583014wrp.586.1647091756718;
        Sat, 12 Mar 2022 05:29:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 02/11] amba: Use driver_set_override() instead of open-coding
Date:   Sat, 12 Mar 2022 14:28:47 +0100
Message-Id: <20220312132856.65163-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use a helper to set driver_override to reduce amount of duplicated code.
Make the driver_override field const char, because it is not modified by
the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/amba/bus.c       | 28 ++++------------------------
 include/linux/amba/bus.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d3bd14aaabf6..f3d26d698b77 100644
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
index 6562f543c3e0..93799a72ff82 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -70,7 +70,11 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	char			*driver_override;
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.32.0

