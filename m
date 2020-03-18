Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C981892B5
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCRARU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44249 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCRART (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id y2so12610245wrn.11;
        Tue, 17 Mar 2020 17:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=00i66m1wtM2+P1s/tRhqDIGUbMRLcSr0KSarPdUP5w0=;
        b=KwyMwcTvlZwqq7M8RopS1rcsR9Pl4g3h8aAWTRuCDWS/Y+PAsOCDZV89UouR8StFl8
         /sMiQT1OWTZN3nSViZGALrlWN80fh+L1WbdBv/e0lMGWY4U2edaugJnZEuZ6oP7wgHbA
         3w8LEef+quCgr8bHoce/njjXXsPenhxo95XM1YqdDJlQ1BZQRQ9rG1pR684o663i+/M7
         jfSgPCBfcuwU114PeueZtBc2XnUZblJQT2lHXTfLfVZyceuzLiEeIfV9uOhMtuvcOeUc
         kf6H9C5IPaJR++D15CbHz+F6GTkRXNNTbpNQcojxqX8DYMx5ltIj0z7urfTU8NMHAO7k
         CnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=00i66m1wtM2+P1s/tRhqDIGUbMRLcSr0KSarPdUP5w0=;
        b=nRHA9c3N9OLxFjMGpj4URTDAaKTnrBlf/7vyUq0Bu0B9DHuVadXYHDPu88imPq6DbA
         Rd4Do7FzI3k8SHORFj1IJJ9eRbLMu6FBlRik/ePDc37dmAvE/U2NGSMovXy1hC6TLYIj
         ZftgIZ1tU6zA0cbbQ2B6wojcglK5RlupAd7tZ9nkaM7kPC6bwG31pjQJxkr+0dfDQ1pY
         A6/k4k7BKOciR8Rfk6VJ2F3yTJ+t/Vby33WN5zeVsniH6wH+IeFGHNMZcSAI1au+Mq4N
         n61+BIgEOLoN6ccqW+UNHtWRlEY2VVupxqQmBsyTtn21W2R+eZmxOPbzJTVjXMovvNzB
         +8Sg==
X-Gm-Message-State: ANhLgQ33oTR2aBwgsRJSQ2cohdEOY4ezD8nU37dZHK8QarLzxqNp/c12
        mhLhNFd5JW4ZMBvrvxhlPVU=
X-Google-Smtp-Source: ADFU+vvtlrjqyj2EntsV/CBRdNvwL6+zfzVjVL1dzehHxplW/HnQN2fzjCzAS9/vuC8hEo2yuTH7Hg==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr1631350wrt.352.1584490637777;
        Tue, 17 Mar 2020 17:17:17 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:17 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
Date:   Wed, 18 Mar 2020 02:15:59 +0200
Message-Id: <20200318001603.9650-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Interrupts are not necessary for DMA functionality, since the completion
event is provided by the DMA driver.

But if the driver fails to request the IRQ defined in the device tree,
it will call dspi_poll which would make the driver hang waiting for data
to become available in the RX FIFO.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 81e22b6eadc7..fcc6f20b6631 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -965,13 +965,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
-			wait_for_completion(&dspi->xfer_done);
-			reinit_completion(&dspi->xfer_done);
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (dspi->irq) {
+				wait_for_completion(&dspi->xfer_done);
+				reinit_completion(&dspi->xfer_done);
+			} else {
+				do {
+					status = dspi_poll(dspi);
+				} while (status == -EINPROGRESS);
+			}
 		}
 
 		spi_transfer_delay_exec(transfer);
-- 
2.17.1

