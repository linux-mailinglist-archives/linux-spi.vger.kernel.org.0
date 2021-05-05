Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50BE3733DA
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 05:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEEDPV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 May 2021 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhEEDPU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 May 2021 23:15:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CABC061574
        for <linux-spi@vger.kernel.org>; Tue,  4 May 2021 20:14:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so260285qkd.2
        for <linux-spi@vger.kernel.org>; Tue, 04 May 2021 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6FMbAN7t12G/Juix+b9gMTv2kzO3C2P3Q5jEJeo40h4=;
        b=RHKxy0nzZMKiiaUNg6+cDehHN1wDU7unHEmn9ng1SCsYUPc5cgsHrvLITgnMZ1z4KW
         Xxg6wWzJHuuNnH8Z8YgFLdgnR9usVQNw94dFxzmTppUq2f2QRHago0bOsPsGuIPpU1Jh
         LDz/07RjTFR73vDyiU2iBzST+K6dUns+UGNRnOrEGy3Ho0Y07Z2FeFNC60eBbmo5hShK
         OxTnwzCMwmYS/i06DGdcQ943ZH/38mYOm1S3137p6HcT+KOpEjT+eEct4p1gcKjUtIV6
         /6o0VO0lhc7yP1W4RLwDNzYt6Wdotd4KnpEI7n8ZtnNAoWkcz8iyhjYM1733toOiVMLi
         f+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6FMbAN7t12G/Juix+b9gMTv2kzO3C2P3Q5jEJeo40h4=;
        b=PtinKLWwqIVERW5YaQwlzYp0tgekkOjIzYjpWHnpa8h7ohtuGC9ZA/e6WgqRvMpW2q
         O3o5Os6r09zSzk/XJlGTzphN24k15H6bNOMMcKK7Qq4xQsoX11ZFgFYtDME7/j1YMlvZ
         Zye+3w5RHrCUTjUDeZBSsogBMGzaLV7CvGPA/2dUBItEdlwidCMh1cf34G4L+OqNyr8G
         jl9sC48bgNSB+efUPbYoTcb3WwskVY8E/oDv8/SOaf16W6Ohq+V9Sk/prJvMzgzCPKXP
         VcR9aADvtqJJqnu3toKt4Ye45ZPh5yn8ADqfyF5eg5jedDF2cAuFT4ShWmBbi54mXe9B
         x76A==
X-Gm-Message-State: AOAM530OagkPX3WBsY80096kdCVFh47+zx7kvMUaVdAgX6JdmheMu38W
        Hja1uJcBnmCbBOqwUFCZKAMkwizDTkkb+ck=
X-Google-Smtp-Source: ABdhPJxG9O+6Dqmq1pl0275GQdNWC3CuGBrHDFQUp40IO934UlNUR9csN1vCxTHLw+4ZGeFupcfTnE2b5niSMR4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:423c:41e9:e02e:706e])
 (user=saravanak job=sendgmr) by 2002:a05:6214:583:: with SMTP id
 bx3mr19001972qvb.38.1620184462756; Tue, 04 May 2021 20:14:22 -0700 (PDT)
Date:   Tue,  4 May 2021 20:14:16 -0700
Message-Id: <20210505031416.30128-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v1] spi: Don't have controller clean up spi device before
 driver unbind
From:   Saravana Kannan <saravanak@google.com>
To:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, kernel-team@android.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When a spi device is unregistered and triggers a driver unbind, the
driver might need to access the spi device. So, don't have the
controller clean up the spi device before the driver is unbound. Clean
up the spi device after the driver is unbound.

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Lukas,

Can you test this out please?

Thanks,
Saravana

 drivers/spi/spi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2350d131871b..b856f4a1e3a4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -401,6 +401,12 @@ static int spi_probe(struct device *dev)
 	return ret;
 }
 
+static void spi_cleanup(struct spi_device *spi)
+{
+	if (spi->controller->cleanup)
+		spi->controller->cleanup(spi);
+}
+
 static int spi_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
@@ -415,6 +421,7 @@ static int spi_remove(struct device *dev)
 				 ERR_PTR(ret));
 	}
 
+	spi_cleanup(to_spi_device(dev));
 	dev_pm_domain_detach(dev, true);
 
 	return 0;
@@ -554,12 +561,6 @@ static int spi_dev_check(struct device *dev, void *data)
 	return 0;
 }
 
-static void spi_cleanup(struct spi_device *spi)
-{
-	if (spi->controller->cleanup)
-		spi->controller->cleanup(spi);
-}
-
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -714,8 +715,6 @@ void spi_unregister_device(struct spi_device *spi)
 	if (!spi)
 		return;
 
-	spi_cleanup(spi);
-
 	if (spi->dev.of_node) {
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
 		of_node_put(spi->dev.of_node);
-- 
2.31.1.527.g47e6f16901-goog

