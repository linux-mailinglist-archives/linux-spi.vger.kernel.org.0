Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465A317E2E6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCIO4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:56:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgCIO4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id g134so10288050wme.3;
        Mon, 09 Mar 2020 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL7TUO9B/e8wYQKuwe9Iv+RdI+L5yqc8HfjdMUkN5OQ=;
        b=n/QlIdvVs7r9NIFZ7lrfaRlji0EHzZQ9mBNoEouMenoaKpHqMd+1/ngBKflwqOKG66
         3npDsAq2cG171y6OI1tPUbrK/33H6u4MVHN14rEAFtl9LN4QhJKfbXUMueNvb7wXfyLt
         L8n6lMt0DJQEXw6C+yclVzzvrM5bV7QkGE7rSj8Ue3K8my5D+mkg4qUdgpxayRUMDfjs
         sRxSy239lBgEohGUyyp/kdvlDEc1XGYvDpxUU3mTvVMF65UE1DJQbi8EaLqBgGpYENUS
         NMJAkIT9K+SDo7YDxXb+XgyinHa7VhiXOB10POHP/FWlIj2sRnsUFjmvfrZufadvCiMB
         +85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL7TUO9B/e8wYQKuwe9Iv+RdI+L5yqc8HfjdMUkN5OQ=;
        b=gtoDYohvMGg+lNt7/DespzEP9YtdY80f49amzsINLtBFzt/skJEFp58jSRnhYkftJQ
         SLfKtWra6gfXDKy2AZLa1VCO+Qy/QjDX+TmBFNEs8Gb9Pmeor96HzibYXFtgCQt6twHs
         EsfthtXeGYygubrqZYKTWcdRxykDbCcWq4+HLY8Mcnq3Z9h7JP/peS85Ha+vt66vLfhm
         niriyYShjYxFAEPnqSjgJ77qsKlZuvnHYYmDKGxO5fw5cIDsVZ+SR3490hu7OIy0zokJ
         JBj5Dto2YebDQ2Krw/A3BwEE43NjziKW1K0wYZMKKco0bqaW4RjB/bhh8xRxxVMP2FHo
         J7tw==
X-Gm-Message-State: ANhLgQ3MqDPluzRBEHWQ6Fw7orGCHwqN07UB6391HRLVEGEWwk+CeEZT
        3bm+eRMwcZtzskHUjyfhnCg=
X-Google-Smtp-Source: ADFU+vsp81mIhxzaa3uhtuNOQnYBjU4hdT2fuT3yXd6s38W0d/2aLJaHjmCT0UuDCg2268viGfAb1g==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr20976578wmm.145.1583765802463;
        Mon, 09 Mar 2020 07:56:42 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:41 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 3/6] spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
Date:   Mon,  9 Mar 2020 16:56:21 +0200
Message-Id: <20200309145624.10026-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In DMA mode, dspi_setup_accel does not get called, which results in the
dspi->oper_word_size variable (which is used by dspi_dma_xfer) to not be
initialized properly.

Because oper_word_size is zero, a few calculations end up being
incorrect, and the DMA transfer eventually times out instead of sending
anything on the wire.

Set up native transfers (or 8-on-16 acceleration) using dspi_setup_accel
for DMA mode too.

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8e56abe20ac..5624b9ee77db 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -372,6 +372,8 @@ static void dspi_rx_dma_callback(void *arg)
 	complete(&dma->cmd_rx_complete);
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
 	struct device *dev = &dspi->pdev->dev;
@@ -459,9 +461,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	int bytes_per_buffer;
 	int ret = 0;
 
+	dspi_setup_accel(dspi);
+
 	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
+	bytes_per_buffer = dspi->devtype_data->dma_bufsize;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
 		dma->curr_xfer_len = curr_remaining_bytes /
-- 
2.17.1

