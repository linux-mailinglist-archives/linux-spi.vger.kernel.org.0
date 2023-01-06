Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF765FE84
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jan 2023 11:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAFKH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Jan 2023 05:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjAFKH0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 05:07:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC41C40D
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 02:07:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so813283wrb.11
        for <linux-spi@vger.kernel.org>; Fri, 06 Jan 2023 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3R1Lbe2HL6UDHx8NRIcdd2REVBcn4pDKMIH3jzsR7A=;
        b=t2Grv2RjFdeGtq9774/UemXRj4+qjHeiqrmMNUZMRC0IGIQkFZjDsN7sy0cZn/Vi/E
         SdBqKqOt6WZKOcDhIvpOAHsGnU6tkY1iD67by2dplh8Yn9Vxd7QgZsLSvl749N29FXPL
         YDC0hoc5PEXbuCSVFcy5GgkOMbDaGQ+rle4eyd82OoGiPxyilXlpT5Es+hzOLEWhn85l
         HHBHgD4A29ke5YDnaJymUjI5OMtZX8jg6AscvIYM+ro540c8M7LqaJSwA99P+q4Awmj9
         0RHELIKRGbNtHRddj9EanUODcqPosluBqM1aiOREsLpgGzBcx6R/OPuZbVkYQEhpTO6A
         XgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3R1Lbe2HL6UDHx8NRIcdd2REVBcn4pDKMIH3jzsR7A=;
        b=j0IjudXCv8s5PNeIy5zYPxAvW7iblwmGPUQs0D7YrC40Al+Y9eq5B0HRDtH4Yx9qEm
         +LLT9QfQ1ULifRQmPPWuayo7KRQ29ybOp7BPDx10taQbVhdDM1bdfX4uxaw/t2veZoiS
         7F8P4MzgMwaxI/n4VXR4nYsNBvT4SKJXxkunS+uio0bQXulE0uKe+oooYlCQ7djq4ZRi
         497Rv98AfkHsTIVEVP+9oNC4C8VlIAvD1AA7yUs909QXO1ibIM0Ume8nxxMmGx3P+CZD
         mS7qejjIpLqFSxu3/crtHfB6yCMYzoN5KuHLAaAE/5Qfy1qt0Lorq/EPHys+laq0rjkS
         L2NA==
X-Gm-Message-State: AFqh2kqkZQAiJfr21snnvtgOcA1YZWcBPFb4/RqBLNfm3Wl6qIovlyDl
        2UWR5cx3Q1hjdfXqUaHGOntcsA==
X-Google-Smtp-Source: AMrXdXvdlCN8Ptrnx2KBQVhXVCJVA+LPep8Hepq+EbCEmxdhKXmp5K4y7s6w4Zj1GS5y3ah2kMPb5g==
X-Received: by 2002:a5d:4f06:0:b0:274:a10d:f1ac with SMTP id c6-20020a5d4f06000000b00274a10df1acmr29764024wru.27.1672999641788;
        Fri, 06 Jan 2023 02:07:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:86fd:399:3851:d474])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm780594wrj.2.2023.01.06.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:07:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing spidev->spi
Date:   Fri,  6 Jan 2023 11:07:18 +0100
Message-Id: <20230106100719.196243-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's a spinlock in place that is taken in file_operations callbacks
whenever we check if spidev->spi is still alive (not null). It's also
taken when spidev->spi is set to NULL in remove().

This however doesn't protect the code against driver unbind event while
one of the syscalls is still in progress. To that end we need a lock taken
continuously as long as we may still access spidev->spi. As both the file
ops and the remove callback are never called from interrupt context, we
can replace the spinlock with a mutex.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use a mutex instead of an RW semaphore (but for the record: I believe that
  the semaphore is the better solution here)

 drivers/spi/spidev.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..42aaaca67265 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -68,7 +68,7 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 
 struct spidev_data {
 	dev_t			devt;
-	spinlock_t		spi_lock;
+	struct mutex		spi_lock;
 	struct spi_device	*spi;
 	struct list_head	device_entry;
 
@@ -95,9 +95,8 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	int status;
 	struct spi_device *spi;
 
-	spin_lock_irq(&spidev->spi_lock);
+	mutex_lock(&spidev->spi_lock);
 	spi = spidev->spi;
-	spin_unlock_irq(&spidev->spi_lock);
 
 	if (spi == NULL)
 		status = -ESHUTDOWN;
@@ -107,6 +106,7 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	if (status == 0)
 		status = message->actual_length;
 
+	mutex_unlock(&spidev->spi_lock);
 	return status;
 }
 
@@ -359,12 +359,12 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	 * we issue this ioctl.
 	 */
 	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
+	mutex_lock(&spidev->spi_lock);
 	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (spi == NULL) {
+		mutex_unlock(&spidev->spi_lock);
 		return -ESHUTDOWN;
+	}
 
 	/* use the buffer lock here for triple duty:
 	 *  - prevent I/O (from us) so calling spi_setup() is safe;
@@ -508,6 +508,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
+	mutex_unlock(&spidev->spi_lock);
 	return retval;
 }
 
@@ -529,12 +530,12 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	 * we issue this ioctl.
 	 */
 	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
+	mutex_lock(&spidev->spi_lock);
 	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (spi == NULL) {
+		mutex_unlock(&spidev->spi_lock);
 		return -ESHUTDOWN;
+	}
 
 	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
 	mutex_lock(&spidev->buf_lock);
@@ -561,6 +562,7 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 done:
 	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
+	mutex_unlock(&spidev->spi_lock);
 	return retval;
 }
 
@@ -640,10 +642,10 @@ static int spidev_release(struct inode *inode, struct file *filp)
 	spidev = filp->private_data;
 	filp->private_data = NULL;
 
-	spin_lock_irq(&spidev->spi_lock);
+	mutex_lock(&spidev->spi_lock);
 	/* ... after we unbound from the underlying device? */
 	dofree = (spidev->spi == NULL);
-	spin_unlock_irq(&spidev->spi_lock);
+	mutex_unlock(&spidev->spi_lock);
 
 	/* last close? */
 	spidev->users--;
@@ -776,7 +778,7 @@ static int spidev_probe(struct spi_device *spi)
 
 	/* Initialize the driver data */
 	spidev->spi = spi;
-	spin_lock_init(&spidev->spi_lock);
+	mutex_init(&spidev->spi_lock);
 	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
@@ -821,9 +823,9 @@ static void spidev_remove(struct spi_device *spi)
 	/* prevent new opens */
 	mutex_lock(&device_list_lock);
 	/* make sure ops on existing fds can abort cleanly */
-	spin_lock_irq(&spidev->spi_lock);
+	mutex_lock(&spidev->spi_lock);
 	spidev->spi = NULL;
-	spin_unlock_irq(&spidev->spi_lock);
+	mutex_unlock(&spidev->spi_lock);
 
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
-- 
2.37.2

