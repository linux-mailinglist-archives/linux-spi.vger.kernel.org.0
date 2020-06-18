Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE71FE966
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 05:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFRDVp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFRDVo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 23:21:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53FC06174E;
        Wed, 17 Jun 2020 20:21:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so2127416pfd.6;
        Wed, 17 Jun 2020 20:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0KewjQZe5O+wSq1k01WRPDVSjOJ4PewFyPFvRaHyFc4=;
        b=V0JZzs9zGqcpP0DBpw8CFGFBkrFk2L91Gy9yO2yDB9KcZfRdYGIUaFNVB+24STVg3N
         6jIDQ6dTllOS5JzcZDr3N/r1WDuOmKR2s57KQI4JSHFj3ZeEE2ShsIjs66DAGXwjb6AZ
         jk49kygXsmV9TnX/sQWqXOQEbhzZeDjNDjHnCoRjMQZ1DaEloUHA8nc9K0vQLVevM9Ks
         k18zNmlmjXYe0958GVwMYrTvZD1aPwFnkk9Ec5wMxnm+KEX8g/M4aMXbjfGDp4IhBMMg
         12NOEkNvx8gsLZGuMt/G8PHuUXS1J/CVBTDMNgpKvaa/q2dLvrE7ZxMjnT8qeW1RRfX4
         UAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0KewjQZe5O+wSq1k01WRPDVSjOJ4PewFyPFvRaHyFc4=;
        b=dCZ50AK1EhcKs/rF3iAbx9ILlEJXQbYyYYY8hh6rqD67wXUksVxXaAgOPLP3J017ql
         xuy2VM9Y5YkgElUMFJCFSO28uI3paeQV57ecaG7w+IbW7Rj36cZM5kNmZcXX2zF9DEMa
         9IBZZZKO2Bz2ELrTtCq41PvzJiL1+pRWBvYTObUDnCvjN7SVUQeUlPpmK+Gipw5FZIC2
         +wkzKxLPluW9W8eXZ/2y/1+R8zh7Mu8iJUUgoaZB0oKVVFip0H73SO3MwusHg5Cbm3g5
         +LbEZVL1Wrr79EWwFRxFTe7EwPbgL1FdUm5zfQR4mppo6lHQ9yenH+I4zik4Z9AyPFcl
         PfPQ==
X-Gm-Message-State: AOAM530+TsbLSrHhNBn/tVznuBXd9tO9OuOnEWn3HsZULsmUjfKDvyqy
        EPcMMi473YlSlBeRDVCx9VwIGCII
X-Google-Smtp-Source: ABdhPJyFK+BBNWXSgziaecOd2v+M+Sus5vQ0yNXTu8hwBABi/EU30tVdB5tdvIGlfQTolMpN3RQgJQ==
X-Received: by 2002:aa7:96e9:: with SMTP id i9mr1812379pfq.232.1592450502846;
        Wed, 17 Jun 2020 20:21:42 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.43.85.232])
        by smtp.gmail.com with ESMTPSA id g21sm1124838pfh.134.2020.06.17.20.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 20:21:42 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH 2/2] spi: spidev: fix a potential use-after-free in spidev_release()
Date:   Thu, 18 Jun 2020 11:21:25 +0800
Message-Id: <20200618032125.4650-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618032125.4650-1-zhenzhong.duan@gmail.com>
References: <20200618032125.4650-1-zhenzhong.duan@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If an spi device is unbounded from the driver before the release
process, there will be an NULL pointer reference when it's
referenced in spi_slave_abort().

Fix it by checking it's already freed before reference.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/spi/spidev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f74ea26..59e0767 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -609,15 +609,20 @@ static int spidev_open(struct inode *inode, struct file *filp)
 static int spidev_release(struct inode *inode, struct file *filp)
 {
 	struct spidev_data	*spidev;
+	int			dofree;
 
 	mutex_lock(&device_list_lock);
 	spidev = filp->private_data;
 	filp->private_data = NULL;
 
+	spin_lock_irq(&spidev->spi_lock);
+	/* ... after we unbound from the underlying device? */
+	dofree = (spidev->spi == NULL);
+	spin_unlock_irq(&spidev->spi_lock);
+
 	/* last close? */
 	spidev->users--;
 	if (!spidev->users) {
-		int		dofree;
 
 		kfree(spidev->tx_buffer);
 		spidev->tx_buffer = NULL;
@@ -625,19 +630,14 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		kfree(spidev->rx_buffer);
 		spidev->rx_buffer = NULL;
 
-		spin_lock_irq(&spidev->spi_lock);
-		if (spidev->spi)
-			spidev->speed_hz = spidev->spi->max_speed_hz;
-
-		/* ... after we unbound from the underlying device? */
-		dofree = (spidev->spi == NULL);
-		spin_unlock_irq(&spidev->spi_lock);
-
 		if (dofree)
 			kfree(spidev);
+		else
+			spidev->speed_hz = spidev->spi->max_speed_hz;
 	}
 #ifdef CONFIG_SPI_SLAVE
-	spi_slave_abort(spidev->spi);
+	if (!dofree)
+		spi_slave_abort(spidev->spi);
 #endif
 	mutex_unlock(&device_list_lock);
 
-- 
1.8.3.1

