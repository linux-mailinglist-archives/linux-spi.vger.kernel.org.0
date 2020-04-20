Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF61B1564
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDTTJW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF68C061A0C;
        Mon, 20 Apr 2020 12:09:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so795177wmj.1;
        Mon, 20 Apr 2020 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MryED8uai1n3gclYsGl5qk+GTHUCazZ5O/sEZ7i7aTw=;
        b=AjFvPXB3NEFW2PxnuZMSlnLdaQZRCuRYUfLf63TlgpoiN4aCakwkGh216tynJP/KPY
         hCxzvDllrz2vAAo8p8AHIdRZ3HJ3c7T4Qcy/cCcqvMDOiASUmI5IpvPVj1+roqra4CjB
         4skiMm+SGw4PvK1V3rvjGeBvvQfjfY1CsPb9Z5nk1qC4iRJl+4m59BHeJ8pEBNoRFjBr
         SRO40pP73+/JTdzi0ob40DkALMrrLNs5mcR6qtxTQ/zxiPRSY4aYc3HEaqLg1KsVefyC
         FBhWNKxxzWDP/k60HkT2uzcrI+pLnrJc5eSsvCblxqhpyRZ6cvyongxXXYylXPkV7m5T
         wCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MryED8uai1n3gclYsGl5qk+GTHUCazZ5O/sEZ7i7aTw=;
        b=rAkw4LbkSMhA4VQw6VAom5AK506K9N+bF7qpCYky7xre/lL9M0HcKRvoijqcsWSAFh
         OiczP83tSN7dGOnamHe0QL68+qvbD9oOBJxyYVZQVVPiXRwy8xgYm0+4/1ykEWn+XpZE
         WgO/hprowi6kI2UTa8UE4EES3zM7eKPBmSbAYs45y81y+9z1d3UfRdUaMw0QfqszcrR1
         0H5JmoHCRHjseimiXejUpuuJ+mxnB+N0TXnM00iFH2NSMaU5aN26NucQxpEvJjkyddwU
         zhAoSwNEX3yYDsMbXSlf0vziN2m4UPscoF23uRJuNKyYbzv2FZEjnQgJMM9QJXzqwKR8
         ZQhg==
X-Gm-Message-State: AGi0PuYxnxEcuxxzCXnwcRlBfzFxIom0BwJ/EyAKw3MhMv/UJ0qsk7AZ
        B2sv2/crA2oT1LqMKeI9R8E=
X-Google-Smtp-Source: APiQypLsyKNAgvuWGyKHGw0G7eoRaKGEavFsr5XFrPv90rLPDoF8meIeiXS8YTK3tz3/3UW6G4vYbg==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr931818wmb.4.1587409760724;
        Mon, 20 Apr 2020 12:09:20 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:20 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Date:   Mon, 20 Apr 2020 15:08:45 -0400
Message-Id: <20200420190853.45614-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
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

