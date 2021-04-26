Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1C36BC62
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 01:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhDZX51 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 19:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDZX50 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 19:57:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E7C061574
        for <linux-spi@vger.kernel.org>; Mon, 26 Apr 2021 16:56:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n11-20020a25808b0000b02904d9818b80e8so35120741ybk.14
        for <linux-spi@vger.kernel.org>; Mon, 26 Apr 2021 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bLpFuVYdmPMnBYEaz/LwZMrDFGhW/UaBfFKC3wD97bw=;
        b=jtFpzcZtBpvmVY1OQxFz99OaCQ/fGYvIQYAsMbBQWsumpBgVpO8xEj/8Mdu8/VKkAE
         zv/RYjenlWm2FfayETY4b50Z3O3i0hYcGuoefZnBASscfpyqLwNzqaTwTkTIBZSxGjNe
         ZAacjTRxdZGCkWPvLfYtKwRHc44z/0sWRzovy820iYr8jKjXq1CMgC13KUneGdQ4lpWi
         CExeaHOA8ukZOnu1Ox3SV7z5J92DawYKeTbHgdJ+1l8JJQ8ck4o7S0tL2DrKMfBlLfIg
         GpU2kgeQYxrQfXI1DXOGj7vF76v+WsV5c+ZyEdkTm+LwCYxQzHlexbPeJqOL5J34K0yc
         pmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bLpFuVYdmPMnBYEaz/LwZMrDFGhW/UaBfFKC3wD97bw=;
        b=bJlMsmNLFLOwI/0L3DlVRaPFejetmTFaScXDSc5snXxb5+jOLtqiBLbV5phTv7Q84L
         R13F9X8ZAriaHx+VcuiRd1Vm1KrnHxajZnIaWQkvAQlHa5qSbqulFTe3Hb72npPFFZrM
         3AsJ2PeQ0aUGwIVDctJ00eTgEIAmN2gZNZU6Ebn8u0+7mBnmqFeN0MZFoTZVhG7QA2ls
         sYCW5Ykubdfrb/f/NbTbuq8EIUeNjvdeWrXox5hClzW52FEH1hb6EdxzVTDHDuVOdBC2
         cXnrdAJpQB1fo0FHbUyMSkbL99bxjvx9IsWFEerRMdXao1jL6QoMI4fMy21DZUk7mrMW
         Te1Q==
X-Gm-Message-State: AOAM530+Ab+IHHShZgldInPdJbow3w2I6ZrujVq+vc9v2Bt7TRvH1LsS
        6rtNTNS/4DOlcVbVn2+BEBuHbLHFEmj1ZW0=
X-Google-Smtp-Source: ABdhPJyssTCKXdLShQhExFAq2pBioU6ZEBWFFG5oiOoJL/kVfwi2w1LlaVZYGfaj8wii6xiRIYL8G7dgnUVa9Uc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d0ce:dc79:218:3f25])
 (user=saravanak job=sendgmr) by 2002:a25:d40d:: with SMTP id
 m13mr235353ybf.170.1619481402352; Mon, 26 Apr 2021 16:56:42 -0700 (PDT)
Date:   Mon, 26 Apr 2021 16:56:38 -0700
Message-Id: <20210426235638.1285530-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] spi: Fix spi device unregister flow
From:   Saravana Kannan <saravanak@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When an SPI device is unregistered, the spi->controller->cleanup() is
called in the device's release callback. That's wrong for a couple of
reasons:

1. spi_dev_put() can be called before spi_add_device() is called. And
   it's spi_add_device() that calls spi_setup(). This will cause clean()
   to get called without the spi device ever being setup.

2. There's no guarantee that the controller's driver would be present by
   the time the spi device's release function gets called.

3. It also causes "sleeping in atomic context" stack dump[1] when device
   link deletion code does a put_device() on the spi device.

Fix these issues by simply moving the cleanup from the device release
callback to the actual spi_unregister_device() function.

[1] - https://lore.kernel.org/lkml/CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/spi/spi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..7d0d89172a1d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -47,10 +47,6 @@ static void spidev_release(struct device *dev)
 {
 	struct spi_device	*spi = to_spi_device(dev);
 
-	/* spi controllers may cleanup for released devices */
-	if (spi->controller->cleanup)
-		spi->controller->cleanup(spi);
-
 	spi_controller_put(spi->controller);
 	kfree(spi->driver_override);
 	kfree(spi);
@@ -558,6 +554,12 @@ static int spi_dev_check(struct device *dev, void *data)
 	return 0;
 }
 
+static void spi_cleanup(struct spi_device *spi)
+{
+	if (spi->controller->cleanup)
+		spi->controller->cleanup(spi);
+}
+
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -622,11 +624,13 @@ int spi_add_device(struct spi_device *spi)
 
 	/* Device may be bound to an active driver when this returns */
 	status = device_add(&spi->dev);
-	if (status < 0)
+	if (status < 0) {
 		dev_err(dev, "can't add %s, status %d\n",
 				dev_name(&spi->dev), status);
-	else
+		spi_cleanup(spi);
+	} else {
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
+	}
 
 done:
 	mutex_unlock(&spi_add_lock);
@@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
 	if (!spi)
 		return;
 
+	spi_cleanup(spi);
+
 	if (spi->dev.of_node) {
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
 		of_node_put(spi->dev.of_node);
-- 
2.31.1.498.g6c1eba8ee3d-goog

