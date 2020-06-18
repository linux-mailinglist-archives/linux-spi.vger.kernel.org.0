Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB51FE964
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 05:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFRDVm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFRDVl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 23:21:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F2C06174E;
        Wed, 17 Jun 2020 20:21:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so1862026ple.0;
        Wed, 17 Jun 2020 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1NWJxm63+RTlg+oAVdOZ6I0S8r49HaqZO3Z/lAuEzyE=;
        b=U2FAda4uia6U0/pg7JxAtwL6PaSJUUG/L3Q1UzDYX3vjMUobrVd7mDP5IWqtB1Q+Tg
         hsDI+RlvfwAsk+JrsHL1FwTyo3qAsrqJU0twc98caE7Z3PStE5K+mU7dCaPdYTGv0Lyh
         ed1Ay7V+Pj/MGrzZpZ1t5f+tzg8M2aATThsp80V9tVanmS/33Y44h1tA0EqyXNBB2900
         VO2nk+4uBO680GCp/pgUfPbt1gam2lagCpOiGaLUBifpL7ckviLld2cIv4x57QY8AxHH
         RXh8JsH/Vz3XcLrt4mgVoIOX1KXwLAal/Z+5rVNdnIXHwTqqXJzZsjcQ1vtBWBOvkp2V
         BWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1NWJxm63+RTlg+oAVdOZ6I0S8r49HaqZO3Z/lAuEzyE=;
        b=cCzbvP/eIjBA2Imr5mDn6K8u+7LlZtOgdt1kmNyChnBMJJBj1dcuTSSsQwTB/wfYBK
         vN1Qgaho6gkGl9Ndh5eDKbklVGp0zXThdUSC+5D5qGq0MqKAsjEjyH6YHdEDpf73hGPt
         VuNLA6R1Z9QKNSfxiN7kdO+RGek60TmbzBEnWnb3WNnUzolWLXiY/pGsH3ar3y3gQWq3
         NbDdFbexPjJ4ynr3oa/ovn69kjGtY0Afd2/pzyGYJNfwZxAeUOUjzbBZGdi/kO0oQDSl
         xHtxLDCifSQ0cUUgRUR3itn/RjdbXrE1hixrHZ4azSBbI0YDt77MJbD8rnmCQX8x6Rhr
         U2uw==
X-Gm-Message-State: AOAM533esw6CYBJTCMvEe/jahEJ2aepFeYglsKmBf09zyQBXQXmJHdJ4
        uHvnv+Klu5Biyb7QyyobEWKoT65E
X-Google-Smtp-Source: ABdhPJxB+4DuGI2wrs+jT8j1SDJ/xeQh3U1/uVcycNEvHG3j8JyZfp8dsjJRWnKYtFGCTEk/YMs/vg==
X-Received: by 2002:a17:90a:2708:: with SMTP id o8mr2096530pje.161.1592450500624;
        Wed, 17 Jun 2020 20:21:40 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.43.85.232])
        by smtp.gmail.com with ESMTPSA id g21sm1124838pfh.134.2020.06.17.20.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 20:21:39 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH 1/2] spi: spidev: fix a race between spidev_release and spidev_remove
Date:   Thu, 18 Jun 2020 11:21:24 +0800
Message-Id: <20200618032125.4650-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Imagine below scene, spidev is referenced after it's freed.

spidev_release()                spidev_remove()
...
                                spin_lock_irq(&spidev->spi_lock);
                                    spidev->spi = NULL;
                                spin_unlock_irq(&spidev->spi_lock);
mutex_lock(&device_list_lock);
dofree = (spidev->spi == NULL);
if (dofree)
    kfree(spidev);
mutex_unlock(&device_list_lock);
                                mutex_lock(&device_list_lock);
                                list_del(&spidev->device_entry);
                                device_destroy(spidev_class, spidev->devt);
                                clear_bit(MINOR(spidev->devt), minors);
                                if (spidev->users == 0)
                                    kfree(spidev);
                                mutex_unlock(&device_list_lock);

Fix it by resetting spidev->spi in device_list_lock's protection.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/spi/spidev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d753df7..f74ea26 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -787,13 +787,13 @@ static int spidev_remove(struct spi_device *spi)
 {
 	struct spidev_data	*spidev = spi_get_drvdata(spi);
 
+	/* prevent new opens */
+	mutex_lock(&device_list_lock);
 	/* make sure ops on existing fds can abort cleanly */
 	spin_lock_irq(&spidev->spi_lock);
 	spidev->spi = NULL;
 	spin_unlock_irq(&spidev->spi_lock);
 
-	/* prevent new opens */
-	mutex_lock(&device_list_lock);
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
 	clear_bit(MINOR(spidev->devt), minors);
-- 
1.8.3.1

