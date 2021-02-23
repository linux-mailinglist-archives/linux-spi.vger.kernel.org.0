Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80A322D52
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhBWPTm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhBWPTi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Feb 2021 10:19:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E2C06178B;
        Tue, 23 Feb 2021 07:18:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so11314963wro.9;
        Tue, 23 Feb 2021 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfZ/5xe9NBSnHkO39Gxsq3EH9tS2Heq5rSvmJq9KbeU=;
        b=UGL2Rf0qxeubaDNyvNg0c2oDmQUoK5yYzaNczecD/rcq9iWECM5jDtFGZQpi6In1O3
         jmcwAN+SInZoH09/mhZIv2F9F3pytR9bgD57Feg3iUOGk5tqEfcX2NAPwNfam09yg+Dx
         L2+Zs8ictn/0Bh1diu4JIU5IwT8WH+vOSnEdRKG4sSNXNTTPaIQFXIhAMzlwnkDckLSG
         QTQGJzha7dF9XrEdV6sXVjW/zFSe0p4X69TFi/fIKDZucM9jHfC4A4nZpTYInpZ/xNDy
         BfQt79OzQIZU5EyGujo9n1/ueNLYjQTRsRek5nm3Hf1bcWgWlf36rh4669CoDhl5aXbg
         bEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfZ/5xe9NBSnHkO39Gxsq3EH9tS2Heq5rSvmJq9KbeU=;
        b=WZGCjop+hTIvtdOyEc0BUKowwAmIhv3AwW38B1Zv7Q56S3CvrcERuVZh2q9gCIFZsS
         WhSXybMTcJScPTNe1ajvs4AfbQUp9avFXFzr4M7pbrbdKx4zlwTKKn09fVGKaYgbIFE2
         E0y8Bw2Qp8nbeeBlGL3e6kL3+MixL1E9nqQHHql1rKkCoW2GaIi8IX6uS7UrmbO6BPvg
         Uw7+Rk0OL+Pbq3yKWoa5fZCbd0uHW39KsacUGhiI39gpuxC5bMclDuiXIAPr9VzKheow
         vvF/6P9RVXa10k1opg5lCGleH1Bw6DnI+Y1s0zkXLbm1eq2kDn8eBZ/YtRXP5PAbu+pj
         RsOA==
X-Gm-Message-State: AOAM530vnL6dr7alcCNcO+nPPbQV0fjug5pLDEamR1zkIrEpoX0RGNio
        v521iWyQfE76pFPXrcFtR/0=
X-Google-Smtp-Source: ABdhPJxY+e838XSKAzRF/xlUuk7lvyEq5pa7fOjHOft5xgDgm9MD4ImwkIFchjmDyFZWd4juTFg4uA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr26182950wrv.319.1614093534689;
        Tue, 23 Feb 2021 07:18:54 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id y6sm3018071wma.10.2021.02.23.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:18:54 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] spi: bcm63xx-spi: fix pm_runtime
Date:   Tue, 23 Feb 2021 16:18:50 +0100
Message-Id: <20210223151851.4110-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223151851.4110-1-noltari@gmail.com>
References: <20210223151851.4110-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver sets auto_runtime_pm to true, but it doesn't call
pm_runtime_enable(), which results in "Failed to power device" when PM support
is enabled.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 96d075e633f4..d08bb7600150 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -593,11 +593,13 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
+	pm_runtime_enable(&pdev->dev);
+
 	/* register and we are done */
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
-		goto out_clk_disable;
+		goto out_pm_disable;
 	}
 
 	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
@@ -605,6 +607,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
-- 
2.20.1

