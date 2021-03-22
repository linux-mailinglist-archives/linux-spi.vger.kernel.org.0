Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46C34365C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 02:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVBnu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Mar 2021 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVBng (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 21 Mar 2021 21:43:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E4C061574;
        Sun, 21 Mar 2021 18:43:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so10309717pjb.0;
        Sun, 21 Mar 2021 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Bj/WAqoiOctusFCA0iCAGRFTMD+Mlc8VyLQZzAghakA=;
        b=lrSPXVR6Oq5qkb0d9Z+8qGFKjhypxkrlFh6pahnCOc49QExjtNGKmcxryRAacwIRwk
         8HUrjQZ78dgrfTr91+DVyYi2A0P5oWuGiZjRp1UbAHTMAlhzBSo41oJDgxb+rNfcjdgR
         WE6fk1wYapl4xhKYYhVQ8f0Bdbmci+dK9Hgcl4PI9qyqlMXG7DQJez8kMpDAnYxPUl1a
         RmTvHGkjbzSZfny6GzJEEohSOPCFXPnrdWEDYirORf6Of5tJgOQ6pXG7i18v+mbQX2zi
         Y0AF9CHQWVWlK+4ue5lXByBoTxQEJANKM6aYMXMmBqYnlGzRHIikfUXNegTvBBhj4W2F
         D87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Bj/WAqoiOctusFCA0iCAGRFTMD+Mlc8VyLQZzAghakA=;
        b=pL8bGUqZX8kepuQ40Ps5nu6vQiHREETrcPI0xyMB78BxLQNJ9HrMWwVFLllkRhbH4z
         Q8sVj5fzwjcas1eTNFv9VyoBBmXr8uqmrKyJU2Lc6ehS6hzqn3pfQjXdCde/I33QZOdD
         1gbu4stfhyBfFETId5V77VnvmQVVkSodoetw6tKZ4AiBBzXuFBWrLEq1tTut65Pw+zLm
         Uqcy5G8jnhnYZtbTsAysHh0XfQ8IfcJmrq+pF3+PEYimEv4K4f0rjBx+yih8OdeK67JZ
         FGY36AdN0vb1Y8BI1R0rrXyjFkce2kkZjjdwvQAEOZNZn8YngtUSxZudYus3hjLyk443
         QV1A==
X-Gm-Message-State: AOAM533VDKwHNpi8mzGSwvPXeflYauv6EGLK0Q6Hlueq+KNCNZ23QL27
        E0KmTgRjrkvwemFLYYAHUcvRnS/v0MY=
X-Google-Smtp-Source: ABdhPJymEFdAaDFpR7wNzFNtp+AOb4BFaLW9noZCFFHVQDuLxGmc9xUMoMl35hesx8V+E2cbtATvPw==
X-Received: by 2002:a17:90a:fc5:: with SMTP id 63mr10715852pjz.233.1616377415646;
        Sun, 21 Mar 2021 18:43:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:85c2:9df1:533a:87e9])
        by smtp.gmail.com with ESMTPSA id j3sm12325195pjf.36.2021.03.21.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 18:43:34 -0700 (PDT)
Date:   Sun, 21 Mar 2021 18:43:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <YFf2RD931nq3RudJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

More and more drivers rely on devres to manage their resources, however
if bus' probe() and release() methods are not trivial and control some
of resources as well (for example enable or disable clocks, or attach
device to a power domain), we need to make sure that driver-allocated
resources are released immediately after driver's remove() method
returns, and not postponed until driver core gets around to releasing
resources. To fix that we open a new devres group before calling
driver's probe() and explicitly release it when we return from driver's
remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Note that this is not SPI-specific issue. I already send a similar
patch for I2C and will be sending more.

 drivers/spi/spi.c       | 25 +++++++++++++++++++++++--
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c19a09201358..7c369cebebbd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -421,29 +421,50 @@ static int spi_probe(struct device *dev)
 	if (ret)
 		return ret;
 
+	spi->devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!spi->devres_group_id) {
+		ret = -ENOMEM;
+		goto err_detach_pm_domain;
+	}
+
 	if (sdrv->probe) {
 		ret = sdrv->probe(spi);
 		if (ret)
-			dev_pm_domain_detach(dev, true);
+			goto err_release_driver_resources;
 	}
 
+	/*
+	 * Note that we are not closing the devres group opened above so
+	 * even resources that were attached to the device after probe has
+	 * run are released when spi_remove() is executed. This is needed as
+	 * some drivers might allocate additional resources.
+	 */
+
+	return 0;
+
+err_release_driver_resources:
+	devres_release_group(dev, spi->devres_group_id);
+err_detach_pm_domain:
+	dev_pm_domain_detach(dev, true);
 	return ret;
 }
 
 static int spi_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*spi = to_spi_device(dev);
 
 	if (sdrv->remove) {
 		int ret;
 
-		ret = sdrv->remove(to_spi_device(dev));
+		ret = sdrv->remove(spi);
 		if (ret)
 			dev_warn(dev,
 				 "Failed to unbind driver (%pe), ignoring\n",
 				 ERR_PTR(ret));
 	}
 
+	devres_release_group(dev, spi->devres_group_id);
 	dev_pm_domain_detach(dev, true);
 
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..969dd8ccc657 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -144,6 +144,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
+ * @devres_group_id: id of the devres group that will be created for resources
+ *	acquired when probing this device.
  *
  * @statistics: statistics for the spi_device
  *
@@ -195,6 +197,8 @@ struct spi_device {
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
 	struct spi_delay	word_delay; /* inter-word delay */
 
+	void			*devres_group_id;
+
 	/* the statistics */
 	struct spi_statistics	statistics;
 
-- 
2.31.0.rc2.261.g7f71774620-goog


-- 
Dmitry
