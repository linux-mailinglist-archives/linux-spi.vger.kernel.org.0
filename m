Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2B1AFD64
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDST0O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4822C061A0C;
        Sun, 19 Apr 2020 12:26:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so3945351pgc.10;
        Sun, 19 Apr 2020 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MryED8uai1n3gclYsGl5qk+GTHUCazZ5O/sEZ7i7aTw=;
        b=KHrhNz9eW2SEE10dN9YUDkj+Ug7Reo0bS49H4hagifMITN32wf7w38RTWZh8FgBLzp
         Ze8EXPb7NdEYMbBLJlMO+wc+CfhSvGJ0NM3kdOa7K1ttzItHClDETecWsi/eQ2UGGA4P
         eQpxI+w+bRUKdGBkKMTOGPU/r6sVcZJZ3mZ11jpIQZzXmFBQim0yemDodqOGOz3+n49J
         u1oDBQYQHRunfftqt/321rwt4f2d9RabY8OdJe+KpqEanDUlv2WBq64eIRiIRHYgixgd
         abjoJwce/1rVuIxVG0w0Jo3WwM5AwgMNPKsqdwCFfMlDIqMbvY2gYx6etyhTvfdgo5C5
         lvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MryED8uai1n3gclYsGl5qk+GTHUCazZ5O/sEZ7i7aTw=;
        b=RpEFTTdj9108n/uvKfEOnzXKRPH4qdkvWwJ6B2YDYWZ4lBJzSSIF+JqrBYDJQUOjCR
         tirZ22SPszYEK3CCDufTZZesZ/Ye7M3euFT6krby9mC4bVLbqRJvq4nMU65Pk0bogTRi
         hs1pCNCdd3eht1rWiws1B6B84IXMHggsafYkOmLL0zg4BiyDxIfTswTFwoRdpgnmw91L
         1IElPgFShe/GQcOxDK7Sbzlg9TDub2VFr9JRqH2wthTzUmAfoINmJA1WqCjgu1TcCGKs
         YfHXat38d06M38RD3R5S2N0ZW9IOSazRHVbZyKkMAe/JuYb01pEcyfQcNi8sRVPIy9NF
         5BBQ==
X-Gm-Message-State: AGi0PuYdjhAbStRIdYC0BpFqS1nPIfVphc2lBCPJ7lunYaxWvHFLZ8WD
        frcIYYD1WAgYQibEOyqKXE4=
X-Google-Smtp-Source: APiQypJq57LDtDw5YkhAyu3co9ZJlm0e2Zx8UQb5qRrl36rguXOG17PZM06e+tqpYWCqGOa438Wv0A==
X-Received: by 2002:a62:5b02:: with SMTP id p2mr14019001pfb.14.1587324373535;
        Sun, 19 Apr 2020 12:26:13 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:13 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2 1/9] spi: bcm-qspi: Handle clock probe deferral
Date:   Sun, 19 Apr 2020 15:23:30 -0400
Message-Id: <20200419192339.32023-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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

