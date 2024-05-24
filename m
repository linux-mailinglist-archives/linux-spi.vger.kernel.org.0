Return-Path: <linux-spi+bounces-3086-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912648CE9CB
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88CFB225B5
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861286CDD2;
	Fri, 24 May 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pbw6huoW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027F41C6D
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575289; cv=none; b=puh66YM6Rs38ekeVIepcZ/IlhbceetpQNTzM+zAQ1TJD47MWpi9mscy84vVh6yMecEu1BXOi7wNtNZkq1j2t7SY8M44MEidtqX8sE6w3TMnLlwsTCT0RLpEoCMd/I+h+12Q3NfVrFShcJt+xkyjbYYVJCDN2qvlcCQ3Wgr5pO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575289; c=relaxed/simple;
	bh=HegCCdIEY4pR36AZ8QiWEFIcmksLTJsNsXIyFUq7yl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNNaJVlkKWvauuRn8MHrKzpghYTGyyjOgrqLf4NKZfEqjjw3Q1kQpp7xJMEAwih2GUoz0GpwaNWGqoAsNWEkIBokihUdS0L2YYDzkc1Uu14JO75/QbJZblxAIb04lTuGHo+84Rihrl2eCfDIP9TSQ7EPr244unS+hG9oNtw6s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pbw6huoW; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-2e964acff1aso888591fa.0
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575279; x=1717180079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=pbw6huoWpJHSkW6rnnTfQHXZo+T89snmADZc68eQy+0rB5V25z3dVo7uOfjJ0fDEEd
         zFOtb8HeB4NlGE20heQin92G9n1stH9HhEBMXEvJ++dDmD/nS4f1XuSN5zuaDgxKHLcH
         whvf3vUUxc2AL520bsjKTzHKcZFtnB95vKCUg6lpQzyO47SiNk82Rj9b0zZE9EcklSkO
         1HK/YSTdz1Kwnxnn7wACrWjXXfVXdoUMyE7OlbAe9Vwe9vcTyNFnqlQ2+yVeytmpe6ku
         xIqExOH/FcBwmEOlQDaQzIBuDKrw4Gd6iuvvPp1lLfNK5yxju917WcONYsLkk3Chit2u
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575279; x=1717180079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=rQNuwtu8+nTw/Ifw67+29NwuM1inDcQ/HTLBC9yJDoCm+Xxt+hG7OmweosNwQn4kgn
         PzCOmQtntDVzbBDDApvR5PRN9f7C/z+ZTaOtTxfdrVjOCELvqcNuTU8NZOQZt4MOJHu3
         G2FKhuINFPPcgSg7ozBlX3i0esgw3AumGyAYKOfL4Yqv3DGTMwIJFWPdkliplD9nmAlu
         lT6wWu+7Jkl+u1WBHTua/n58esEFbFx5MTs4+xUeIyfAFR9rgUsIowkMGIDLbDxOSr5E
         IeG2zVZidz8uTS1wn1zmL0F4p+HFiptEt/lDeWAIJGpm4ILlkeBQ2/jztS/ARRAIjyx+
         1ZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBRo26lagSNBlQ+/RUdnCg2p7HOzQfLAVkEknjXHOz3jr2DKaMkXFXgWVWy0UXb+m+LQ//k2rTNzWnrnZIuhwMG1YO9G1QEaZU
X-Gm-Message-State: AOJu0YzU1qIXPaK0qUb91miN9huQGkYazGHs+shob9rxay/Dw7AuW/Fc
	uH5lJyDTnclUW2gSF1wjSCqNZGfc7VLiIavX2ia9yScZaaF5l++d4x083tEm2DqIYNSlVNPazp+
	boSQRNsIKi5jCSXITXRbgzj5CFdY6qVWA
X-Google-Smtp-Source: AGHT+IEUZDsi7SCR4IVByAOz4hmEEdc/AaRCJ/JoMT6C0FVxhy9anVd20JxEW5NHN8g2XEYbzyFyk0QQFB+O
X-Received: by 2002:a2e:9c8f:0:b0:2e6:f59e:226f with SMTP id 38308e7fff4ca-2e95b0bce90mr19539971fa.5.1716575279453;
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2e95be01800sm348091fa.53.2024.05.24.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 14/18] mmc: bcm2835: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:26:58 +0100
Message-Id: <20240524182702.1317935-15-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Elwell <phil@raspberrypi.com>

Contrary to what struct snd_dmaengine_dai_dma_data suggests, the
configuration of addresses of DMA slave interfaces should be done in
CPU physical addresses.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/mmc/host/bcm2835.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..746a60fac0f0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -1347,8 +1346,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	struct bcm2835_host *host;
+	struct resource *iomem;
 	struct mmc_host *mmc;
-	const __be32 *regaddr_p;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -1361,23 +1360,13 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
 
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	host->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (IS_ERR(host->ioaddr)) {
 		ret = PTR_ERR(host->ioaddr);
 		goto err;
 	}
 
-	/* Parse OF address directly to get the physical address for
-	 * DMA to our registers.
-	 */
-	regaddr_p = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
-	if (!regaddr_p) {
-		dev_err(dev, "Can't get phys address\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	host->phys_addr = be32_to_cpup(regaddr_p);
+	host->phys_addr = iomem->start;
 
 	host->dma_chan = NULL;
 	host->dma_desc = NULL;
-- 
2.34.1


