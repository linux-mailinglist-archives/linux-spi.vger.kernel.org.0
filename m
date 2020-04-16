Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7E1ACEDD
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgDPRnV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgDPRnU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF95C061A0C;
        Thu, 16 Apr 2020 10:43:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so5821939wrv.10;
        Thu, 16 Apr 2020 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NrrUfW6vk8LgplT9nLEcV4V1JQYGDjA/MPqzeQmBnq8=;
        b=pns9fgLXDrLLhNt5os5ASORlyC0koVOzvPif+M5x6S/CCgOKjO3IyFkQNdQoP3Z4UK
         Tvm9T7/an5kT7IXWAtMWuoQN3Vy9ZfMa611ZA5SKsUb/YuNTorbImGAEkw5cq1ztrfoX
         4G1rdsg4LZdti7+0vAU0O6q2Lka5A65gTEUKQUTcKrtvcFzlSgNcvgqPmC6f/fg913Z2
         x/rYzoTUDjHhU/gVOMWsHnwbfOssQg9luk4Xte9TyK9j8IyIdlCvR5gqKHPKY7+t8M/M
         Jpy00ecl3IC3k0B5viNA7ImKIYwSGzF+tMUghlZZEVxpNmrPKQ2qs7/18StwPQWZUrWM
         vuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NrrUfW6vk8LgplT9nLEcV4V1JQYGDjA/MPqzeQmBnq8=;
        b=rAKn0liKVkckGwh1hkjlGoFk7puEo2tGIbovLgA96/TQj5g+D3fCYrLOY9cSSYDqAv
         2A66KjGWp4mJ8uCAi/R/8LNNuNwcWZqRwz0eg3ClK3b/4Ps9/pxOnrHfPF/tvvCv57v4
         iof1W2Yry8LxjjnPlkespcLSxHxnXdcGY5UNz/5/I7gsmh9Btweh8BZyyHArAkZAEyKK
         ezvSpwv7GfOw5DfNhML2tL1jC0Gjey32PPz1T8qxfsYlLQ/cdOUIFm5+G1K91C20JFfA
         er8TMkqEEe2QCiKWLBImVgGL20esfku319MKHTTFIl9V2PrjIq8X9osPfuG5UX9qQ+6j
         ztcg==
X-Gm-Message-State: AGi0PuZYbas58h1DlHXUnQBZ3aaqXCMsnewLShS64ghv+kEtelnJ7Frb
        y9NOf6N1mJM0ovYbZn2p0rybgnhoxwk=
X-Google-Smtp-Source: APiQypKFjOmDUmtTBtpZe21AkDnu+8Yk+AWo5X3eZCnDcLMBTElU/6Y2/S8IBVEwUYWgP8g00DuvTQ==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr34531615wrr.131.1587058999291;
        Thu, 16 Apr 2020 10:43:19 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:18 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch 1/9] spi: bcm-qspi: Handle clock probe deferral
Date:   Thu, 16 Apr 2020 13:43:01 -0400
Message-Id: <20200416174309.34044-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The clock provider may not be ready by the time spi-bcm-qspi gets
probed, handle probe deferral using devm_clk_get_optional().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 23d295f36c80..74f4579c3f6a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1222,6 +1222,11 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	}
 
 	qspi = spi_master_get_devdata(master);
+
+	qspi->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(qspi->clk))
+		return PTR_ERR(qspi->clk);
+
 	qspi->pdev = pdev;
 	qspi->trans_pos.trans = NULL;
 	qspi->trans_pos.byte = 0;
@@ -1335,13 +1340,6 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->soc_intc = NULL;
 	}
 
-	qspi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(qspi->clk)) {
-		dev_warn(dev, "unable to get clock\n");
-		ret = PTR_ERR(qspi->clk);
-		goto qspi_probe_err;
-	}
-
 	ret = clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
-- 
2.17.1

