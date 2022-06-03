Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650AD53CB77
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jun 2022 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiFCOXu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jun 2022 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFCOXt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Jun 2022 10:23:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DA5044D
        for <linux-spi@vger.kernel.org>; Fri,  3 Jun 2022 07:23:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o10so10373875edi.1
        for <linux-spi@vger.kernel.org>; Fri, 03 Jun 2022 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjth9sumjNSb3AO9iyWCT7fwgeSWmJ+LjXs/gu7PTR8=;
        b=Sd0/9ztQMWmcIvF8Jo6Vha2Ov5iaokZz3RFZnieC5EKvdnaKSaaW9O0QtjRVv7QgUF
         /Ty8AZUaT8mMMcXHqi7N3eDIGcMCxmEkOWjGAViOTP1/4wXmYdFDMGb8DDprS2x4JH9t
         4uDvtsY0H/bzwM+a7Lp2Iw306Hy+B6pfGGX4+kcNujacpX5W44o5IIMxQ4+0GSfZKG5e
         YSq48nxFVbm1GrKBzAxcTu3tcoLhjt/N1V/s2aXr36x419eyswmn+IAJhyt/NLr7naxW
         TvBrOB2YGLQ1+WbAqZFAnYgQ0MOOHFV70iqYkXqWi4AWMU4oO4PPWqEgUT6aY+Oic4ex
         5k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjth9sumjNSb3AO9iyWCT7fwgeSWmJ+LjXs/gu7PTR8=;
        b=Y9WVoQJ2xvA+9tOU53ofsMcQKUnPZS3xxlGf3/oK0zq9Z8+TffBSHdMtzU3DabrTv2
         lLvBqruUCjKW8gj/s8VXWOmgKZ62Rc7y13Ii+pvBIxTkOmOLde/u7EKUeAbb7i/Zfz0r
         ZViXlYkHDvTssVldUo/VB41+UTGsOwAX9Sw23zDP5HZbriJUwwj+f7B2JHfQB32gPofy
         mWTJZ+SLgLVxBlk3tDKfAk/xEukKehL0riOHKJ9T+lru912lBUhZYAh9Epik9Xoexk/c
         M2EzCpeC0kQF9AD4k+/tifKFfHMV7GCkFDFet5HQwBAt/a3cXLS57TMcdSBb6a6udhWE
         SXhg==
X-Gm-Message-State: AOAM530fUwXqMg+upQytumgHE84alsC+4VeLnpcYZrH/xpvVSTtAfLLM
        mRWiYiuOzJd20WTZKsp7pnEKH5Q3IAcUNMBQ
X-Google-Smtp-Source: ABdhPJz5YtZ6/3ZAtJglYwJjyClJRFoKEBHDGITpS3vnA6RvsLlZ5RRKKOaSaKJuXmkAhtShD2LzGw==
X-Received: by 2002:a05:6402:26c5:b0:42e:1708:c09a with SMTP id x5-20020a05640226c500b0042e1708c09amr8038247edd.133.1654266223628;
        Fri, 03 Jun 2022 07:23:43 -0700 (PDT)
Received: from localhost.localdomain (customer-212-237-96-113.ip4.gigabit.dk. [212.237.96.113])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b006fea2705d18sm2810948ejt.210.2022.06.03.07.23.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2022 07:23:43 -0700 (PDT)
From:   Jens Lindahl <jensctl@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Jens Lindahl <jensctl@gmail.com>, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH] check if dma is active before attempting to terminate
Date:   Fri,  3 Jun 2022 16:23:40 +0200
Message-Id: <20220603142340.42271-1-jensctl@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

---
 drivers/spi/spi-bcm2835.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 775c0bf2f..84e72b8dd 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1138,10 +1138,14 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* if an error occurred and we have an active dma, then terminate */
-	dmaengine_terminate_sync(ctlr->dma_tx);
-	bs->tx_dma_active = false;
-	dmaengine_terminate_sync(ctlr->dma_rx);
-	bs->rx_dma_active = false;
+	if (bs->tx_dma_active) {
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		bs->tx_dma_active = false;
+	}
+	if (bs->rx_dma_active) {
+		dmaengine_terminate_sync(ctlr->dma_rx);
+		bs->rx_dma_active = false;
+	}
 	bcm2835_spi_undo_prologue(bs);
 
 	/* and reset */
-- 
2.20.1 (Apple Git-117)

