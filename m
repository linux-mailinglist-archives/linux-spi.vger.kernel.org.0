Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2966482F86
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2019 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfHFKLv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Aug 2019 06:11:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35831 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbfHFKLu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Aug 2019 06:11:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so6071231pgv.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Aug 2019 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lUpr9FUhH57QcCVU+vO9HZiupwMzhMDSaNOkei0kz5o=;
        b=KQzE8lzJdxbMLa7xWIi9QlXR8wrWagY9a9wVsb+QGRhBWY5aqhsfHHE2AyrjJIcVD/
         7LYxPKcutsYSEKgNxm7cHvsqHgv4eTeS4Y7FuW3hmQqrDvKCQhJfyRqr4VisGAV4v9J5
         Yi6MXdOHOENOtg14J9z1y0qkaHfa34vKckpUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUpr9FUhH57QcCVU+vO9HZiupwMzhMDSaNOkei0kz5o=;
        b=gxSIulL+MuGOf+doQOvxuNwBcZeTOmZcFCuyh5UiTp0hqWduMpsn6E+CUUsCO0OCLH
         P2aw9x8Kn9ZQ9kVlYonRDP+GdqwoH5T8d0mPWvyAysoMvRAkry8l29rvVusaDvtOfoog
         8tIs1WYa/nwzcmQzjxDig1txG06bGOQyUqR5vhTSE669ClYIgyKmqvDCAsvyD9kvWJLY
         3pKVkyvuB8rnDuQcrNmdGCcnf5TZMfeQbeLQjPS1YYap488lMkkWlEHYtHiLOJEJrzS1
         mC5tS272e5VMywCTG3u23dcjoviJ9O3BgPkQ7rP7ymQN1TsLhGkFsI0fngd1qII00Rv/
         5xYw==
X-Gm-Message-State: APjAAAUGhUk2H21MGdq+Wr4HjZLjTi8y/ekZhOoEkq73FEbovr+r3pu0
        o8/3MZU/gCA0KDCUXZm2CoSx2A==
X-Google-Smtp-Source: APXvYqz3DsQSBvWF/KP/ixJyTHvQYj+8c8sIGjrKtx0GL00qLG7Y9M9fH8rbf2sPJXyIBjVqc6hKZQ==
X-Received: by 2002:a17:90a:9488:: with SMTP id s8mr2495733pjo.2.1565086310244;
        Tue, 06 Aug 2019 03:11:50 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id f20sm101713186pgg.56.2019.08.06.03.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 03:11:49 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mode
Date:   Tue,  6 Aug 2019 15:37:50 +0530
Message-Id: <1565086070-28451-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix data transfer width settings based on DT field 'spi-rx-bus-width'
to configure BSPI in single, dual or quad mode by using data width
and not the command width.

Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..0dbfd24 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -343,7 +343,7 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
 {
 	int bpc = 0, bpp = 0;
 	u8 command = op->cmd.opcode;
-	int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
+	int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
 	int addrlen = op->addr.nbytes;
 	int flex_mode = 1;
 
@@ -981,7 +981,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	if (mspi_read)
 		return bcm_qspi_mspi_exec_mem_op(spi, op);
 
-	ret = bcm_qspi_bspi_set_mode(qspi, op, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, op, 0);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_exec_mem_op(spi, op);
-- 
1.9.1

