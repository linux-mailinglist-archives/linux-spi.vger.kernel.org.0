Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC64C5BA8
	for <lists+linux-spi@lfdr.de>; Sun, 27 Feb 2022 14:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiB0Ny3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Feb 2022 08:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiB0Ny2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Feb 2022 08:54:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19D1705E
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:53:51 -0800 (PST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9911540303
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970028;
        bh=qpFiz05rVbRuRAHN9hg8SmLpkD4Xh7SLbxYijfSgBwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=flEff7KWZPLjmOVmGn5oBIBD6rZ5ZrIxaTAxYP1KJ1xd4FuctIy0y+92Mkx429A/3
         g+GHMpHXTyTXUZdpx91f+kf31YJizNFFhzNO/TDnkxpp0bRub5lsjnxWpyBEk9bfNI
         9lSaQs/fyWv9inVsu8z4yHO4LVM7jV76r2+M9esRefCrbhTAY2lkpuqEZ8qpXojwJV
         BJj+3HLiMt8xd3DxvcmPLfg4oUTqmX3hnRy/QySCTPgIMpG+0eldo736BBpi03q6rv
         O2t9J+sijeV9j+P0vJhEvDPaZhtwf2pT7EyyF+aofg2Gwtc3sR3Eo7bTHR14G/bBAf
         kBhkfE7TBNdfg==
Received: by mail-lj1-f199.google.com with SMTP id h21-20020a05651c125500b002464536cf4eso4454851ljh.23
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpFiz05rVbRuRAHN9hg8SmLpkD4Xh7SLbxYijfSgBwA=;
        b=4iWwpisQn1vnfYC63N0YbuQIXeAYjs1gdEXmTJC0UoL5Unf+lKrFpyfOoE2Nnhg0pY
         tYoeMO0/fQ1ZpYBSGtNInKpu890F+oV+r7/Xm9GTACmqUBMoL4ryA4M+ifvm9FuodXiZ
         XMfV/IgJCF9h538gXjkuscW9ioCXBH16mKMsfioSu30/ZDGBBOaDGDKE9XXhfB1SRjoy
         7apj6+TlL8kEYW5se+//EGHWPAx+iWnFi4tX0GSKP6Nzpa1GACBZ5xPtHKBmnR5oZbIb
         n33b3akEtx22kYvSlQOhDTq1ApYX+ppogydLQANCpRvYQAirEL8jFNEhwXE5UvmDA8A+
         w/2w==
X-Gm-Message-State: AOAM530X/JFhSBuqMU4rKLMRcKHhyQegrmohj0yox94evnz0sdN218B6
        TUfaNiNqNWcEE5RZom2Xa0temyzHjBrJHSHYBs/6hCBQviwoxght4MGbgjj0SY97TFAV8yYEuj3
        7Gyi5iZzaTnfIzAtqxxyqu4a40G9iPfuGeV8kZg==
X-Received: by 2002:aa7:d98a:0:b0:410:b844:7889 with SMTP id u10-20020aa7d98a000000b00410b8447889mr15100903eds.109.1645970015740;
        Sun, 27 Feb 2022 05:53:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhO9Sv0dF420J0f9IZ/pCEaONwOixtXPt4DqHWIJWIfdwGeQCrhRg50N3SHeq1oP4tMC2tSg==
X-Received: by 2002:aa7:d98a:0:b0:410:b844:7889 with SMTP id u10-20020aa7d98a000000b00410b8447889mr15100871eds.109.1645970015533;
        Sun, 27 Feb 2022 05:53:35 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:34 -0800 (PST)
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
Subject: [PATCH v3 07/11] spi: Use helper for safer setting of driver_override
Date:   Sun, 27 Feb 2022 14:53:25 +0100
Message-Id: <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
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
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi.c       | 26 ++++----------------------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..9d0b11017741 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -72,29 +72,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	const char *end = memchr(buf, '\n', count);
-	const size_t len = end ? end - buf : count;
-	const char *driver_override, *old;
-
-	/* We need to keep extra room for a newline when displaying value */
-	if (len >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, len, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
+	int ret;
 
-	device_lock(dev);
-	old = spi->driver_override;
-	if (len) {
-		spi->driver_override = driver_override;
-	} else {
-		/* Empty string, disable driver override */
-		spi->driver_override = NULL;
-		kfree(driver_override);
-	}
-	device_unlock(dev);
-	kfree(old);
+	ret = driver_set_override(dev, &spi->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..f99bbb20dd4b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -136,6 +136,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	for driver coldplugging, and in uevents used for hotplugging
  * @driver_override: If the name of a driver is written to this attribute, then
  *	the device will bind to the named driver and only the named driver.
+ *	Do not set directly, because core frees it; use driver_set_override() to
+ *	set or clear it.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
-- 
2.32.0

