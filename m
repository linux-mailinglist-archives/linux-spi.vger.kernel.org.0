Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D96331151
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCHOzi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCHOzb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC077C0613D7
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t1so15166472eds.7
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1kerxlBQXsnkBW66DYRSLvt3f+bVaEYRPTXorPAb2o=;
        b=rFtmC2lX9bx1OJQsukKFxbVFYmys8q4JZilYPWNowCRpc+e/TA9cZqZuTTmo16QaR3
         Zts0P3qeGkvIV/+kY5d/R0/Gw7urqV7JEVAcqMz4uNzUhyurQ0hxY1RtoW1q0pXyENR2
         w2LLt4h6lI238BNd0PG6+9Q0us3AzZyEyTMu6vptP6nzK+wfcPqaXSegsOW7yGGHWTs4
         vqBks9FDZgZ3wwSatAgxdylkY+t4TBwvAV4tOIZ6nmLIL5Gc8pNQrKR+rl0KStooCfyt
         28nw+vmJGXOmQBlF/aBAwnrusLCaNg8aOw8HMdOocFZq4TxTqx7MmHm2sHqz19j4+89R
         kvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1kerxlBQXsnkBW66DYRSLvt3f+bVaEYRPTXorPAb2o=;
        b=az19EKkhJOsJN6tpTC2iML6r6/xSQOVJnsyfcAC87HdQRH78pHCpwI2bwxbAgEZgPA
         9/bOEAZ8h1lxD0VUJkkt/bh1ZqrOS8mOLCbCUOixUn0FyN9rMM1igP+GXGggAugJSc90
         4ONa6S4rnZlE4Jyh0z8SSs6KnI9oyNle3NazXV1s+FihLAkUuNg2pZUhDpIWCG17THmY
         h+r4QNENZyZtNxM5y49/njdTKpKuoSJwLOtuC18oFaZnCo3NxTM5qGOgkNw5G+q0uqlO
         ggEzMTQjfehbK41kAe01i/fbI/0eb2ZySdQ8sLrsNSgbPFiFHwyoJlcnNiGBUYKrwneW
         citA==
X-Gm-Message-State: AOAM531GXsbueZ1fLpeAOl6lEu0/bQ26HW0jkv9rtNNjNtlZOQLFJxt2
        iFSyIJTsZAOnNAxiMG6tToU9MyI+YoPxaR9wpcY=
X-Google-Smtp-Source: ABdhPJxEzekHbaS2S5/KEJAyRUXUwCnOcpb8YwShTRdZxuCkPKC3qM7GvCvE1zMb6YSlbV7UXjYPrg==
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr23091988edl.32.1615215328449;
        Mon, 08 Mar 2021 06:55:28 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:28 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 02/10] spi: bcm63xx-spi: don't check 'delay_usecs' field
Date:   Mon,  8 Mar 2021 16:54:54 +0200
Message-Id: <20210308145502.1075689-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay_usecs' field was handled for backwards compatibility in case
there were some users that still configured SPI delay transfers with
this field.

They should all be removed by now.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index d08bb7600150..80fa0ef8909c 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -369,7 +369,7 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 		}
 
 		/* CS will be deasserted directly after transfer */
-		if (t->delay_usecs || t->delay.value) {
+		if (t->delay.value) {
 			dev_err(&spi->dev, "unable to keep CS asserted after transfer\n");
 			status = -EINVAL;
 			goto exit;
-- 
2.29.2

