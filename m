Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A93929CE
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhE0IrQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhE0IrQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 04:47:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A0C061574;
        Thu, 27 May 2021 01:45:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s22so6758403ejv.12;
        Thu, 27 May 2021 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cQwyco3zF02M7nTlGhSF9ivKxGvmlRN3UcsYlTk9ek=;
        b=fMYMAS3NLVBE7kNccGYVDzrj+orSZV945AABDdZdU+V2xrbX50R86WCxE4JduqlXtD
         WMqlBAHnu6q9YqAzbYvEXz5CCTCsZM+zY7npUgCuZRrHGQdy/PvXiTFwT9S6eioVtH2/
         speSEK2c4p0oq0x+wxwDDNG+J6dv1jflurLJnX1KpSJ+y08WWuFhD+MYY5XDjaAn7dOX
         8VwmYB055k1KCJivPu+lhv52NY5xqpQ5vbPk4z3B8IQVfm2eciG+Y7xCSeMU4pfno4oo
         Uotenboe1oZr/Yq4ueENY8l4l04tW7CdqnIIrcAwNrA/yVnPgMKsDgCP9lgYhjxfVo7D
         MB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cQwyco3zF02M7nTlGhSF9ivKxGvmlRN3UcsYlTk9ek=;
        b=NHHngSkNSJgmbZ+oVtetr2mfKNjgu2YY93GT1Op4B5EKO91xcdZOGWT9ucvzd0T8jn
         05W4PNVlknFmL0Aa0fiHfiP6PB+RYu2y78Kj7ZvATmRSUJ0Yb1KTGyoNtVJwHEM4JHjH
         95yGZXQYGIjTJCa7Vy1OOzVUUWaLUqHxtJR5KjbbellfxzgpuNOtteGrYQlFNB5M3A4d
         Y3BguBIHYplJlaZbRERbZpRJ1KSbCt4CCph6s/GMAaogXzVEFHSIYhCXM7JNHLlmT/0B
         QwhHl6SjXXmornq9Nr4WYbSWJD4I0zerWUBCfrxQEi9NPflWhqAaRJjcJZM7X5j/efPC
         LvAA==
X-Gm-Message-State: AOAM530WlliBKMbI+tUScBmKUG+d/eNojhorqv6jiyJUUd7+IOYmpybr
        DkmgicT8jHL/IHZuRAjzsRBCMiN7M58=
X-Google-Smtp-Source: ABdhPJwkKT3yCdVllDuFVEIsx0pKHPYmRjfnymTyyoKwBYTwr/381V/lD+9K/PWm0yvn6ddu13Jpcg==
X-Received: by 2002:a17:906:5d0c:: with SMTP id g12mr2613378ejt.447.1622105140804;
        Thu, 27 May 2021 01:45:40 -0700 (PDT)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id jy21sm654578ejc.13.2021.05.27.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:45:40 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spidev: add platform driver support
Date:   Thu, 27 May 2021 10:45:15 +0200
Message-Id: <20210527084531.18989-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This makes it possible to use spidev in combination with the
MFD subsystem. The MFD subsystem add platform_driver devices.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/spi/spidev.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f56e0e975a46..fb7b483ff70d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -25,6 +25,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
 
+#include <linux/platform_device.h>
+
 #include <linux/uaccess.h>
 
 
@@ -827,6 +829,40 @@ static struct spi_driver spidev_spi_driver = {
 	 */
 };
 
+static int spidev_platform_probe(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+	struct spi_device *spi;
+
+	if (strcmp(parent->bus->name, "spi"))
+		return -ENODEV;
+
+	spi = to_spi_device(parent);
+
+	/* This only works if no drvdata is stored */
+	if (spi_get_drvdata(spi)) {
+		dev_err(&pdev->dev, "drvdata is not NULL\n");
+		return -EOPNOTSUPP;
+	}
+
+	return spidev_probe(spi);
+}
+
+static int spidev_platform_remove(struct platform_device *pdev)
+{
+	struct spi_device *spi = to_spi_device(pdev->dev.parent);
+
+	return spidev_remove(spi);
+}
+
+static struct platform_driver spidev_platfoem_driver = {
+	.probe = spidev_platform_probe,
+	.remove = spidev_platform_remove,
+	.driver = {
+		.name = "spidev",
+	},
+};
+
 /*-------------------------------------------------------------------------*/
 
 static int __init spidev_init(void)
@@ -853,12 +889,21 @@ static int __init spidev_init(void)
 		class_destroy(spidev_class);
 		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 	}
+
+	status = platform_driver_register(&spidev_platfoem_driver);
+	if (status < 0) {
+		spi_unregister_driver(&spidev_spi_driver);
+		class_destroy(spidev_class);
+		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
+	}
+
 	return status;
 }
 module_init(spidev_init);
 
 static void __exit spidev_exit(void)
 {
+	platform_driver_unregister(&spidev_platfoem_driver);
 	spi_unregister_driver(&spidev_spi_driver);
 	class_destroy(spidev_class);
 	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-- 
2.31.1

