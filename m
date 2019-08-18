Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102759189B
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRSBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRSBc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so6346196wra.6
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m8n6owAUPuiX9pysL2biDiSAS1D0ZAq6z0kB1f1ELAU=;
        b=HsUOp3OdzpMsJwP109qSJn/D6EGF51fvnv7ukpDcRZfTIUdsYCr1jxrskqDxQayx2l
         Ms8zMkPQow+IzfpSw8tKW3ZvybhF9/n+rlGfT18w0ResiaAnZbFlnDDISZ6LfELPMjrv
         9iz4QsjG7/3JB4l8Li5PugOGmV+5P7eyFM7Ao+2o6hbALoXER9EJxhiXgsa3aLhY11A9
         COtnkqlQ6R2O0KFjTMcH75brh9e8bpLMRXDaIilOsVSibkG6fNcF4VchdhwxtOb/9iYx
         vaGZjp2tkIHHzlIlFQJ4R9PmwqjHJlxvaRIaN/jsFx7a0Fu/Qu4kozcNrDqw/TsFU1dY
         dqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8n6owAUPuiX9pysL2biDiSAS1D0ZAq6z0kB1f1ELAU=;
        b=TbgnG40rtt5nmdJV3EqV4wEsuIypGWfu80VyZJy45e3lTjKAGWRpbyUBkGrtXXfZ4l
         pSqP+QKI6cd+fGQ184YgOOBkTfgem7WfLMVSSGiUnEwKLwOQmpPqrlpIebm6JIsaU1qK
         kacXGuIc652TBuzQDm73wFKVcQN1nudbULbIZ28BYb7LSJO/HbZE1q9+CpA5Bw0HTI0H
         7pbE5EaKNHHORD2pvVkwYnHJrC7FoglmY7fNK/ynVJE1fy/sXcUjDi9E2EDh5uFi29ZR
         gBlMkJsgYhUVN4HrPSsz7PHXZRqcr+Aqv+GltdIAPw7+TbgR7YDcQBzKEDARC13C2H2k
         qvog==
X-Gm-Message-State: APjAAAUp1kvrz3w8hzxOtsD5WpZoVEPej6UXG1xzIGVMJFgjSsY6S6dB
        DVxIbxdzNR7thqHPGhxVqE4=
X-Google-Smtp-Source: APXvYqy0EMs4SmvIjC8RdooiNQrbYDdtr5ZMDNohsOytokoYc7yXDAi7iNLVbsnCYCxJfxjljUFEPA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr22844006wrv.95.1566151290293;
        Sun, 18 Aug 2019 11:01:30 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:29 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 11/14] spi: spi-fsl-dspi: Fix typos
Date:   Sun, 18 Aug 2019 21:01:12 +0300
Message-Id: <20190818180115.31114-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mask of -> mask off
at and -> and

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e2e71bd73b5c..6128c695d06f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -232,7 +232,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask of undefined bits */
+	/* Mask off undefined bits */
 	rxdata &= (1 << dspi->bits_per_word) - 1;
 
 	if (dspi->bytes_per_word == 1)
@@ -642,7 +642,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 {
 	int fifo_size = DSPI_FIFO_SIZE;
 
-	/* Read one FIFO entry at and push to rx buffer */
+	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
-- 
2.17.1

