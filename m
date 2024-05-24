Return-Path: <linux-spi+bounces-3084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A98CE9C6
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488A1B22314
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF71481A6;
	Fri, 24 May 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="H8SvFKa9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857B55C0A
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575287; cv=none; b=VRc5x5ri0T6VQQoNNvlp9eEq762UzSVTLVSOoHmtBDI5QZrlZC630Z7fDOhp/MaOYAnz3V50IMDYtFQW4P1clQOPq6ln6nhKPSK3l0DE/EMOvywII6Vo4IUlz4CEC5Z8AWEt7VzLiap3pTgeIsM/jt91uKWKIXV9LiZqk0D47TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575287; c=relaxed/simple;
	bh=N3Kfi5rjJxhjSAGsgu3nLGQYoSBKamIirsVfmPZi9nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RB+wVlx98Xkz9dSjNMZe4oOfEp6FQo/Gy51WU4rop8+QnUhsg9HriVthKSbqES/w+dT7w1NIRll+QAeOGlIHzTQ4vALVavtYBNxPrL03iH6DO/GQt2VXivM+W7sFHc6mw/2Eu7Gq09nl1HVCZLaeAxBC5HBNeFizpe4jXsR7oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=H8SvFKa9; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so6627745e9.0
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575280; x=1717180080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGCf1ir0ewKxnfYL+8Y6zr0drR+R4O1jhqT1oluTBL8=;
        b=H8SvFKa9kcI0I/S+GtybgKj6wteHMsd/mvWsk40hg9y3B5a7budMlqyQzjhI2tTyuc
         KS1R7UFxf0NRtU3gcoSd1Xk7xdRHs4khoOx4koY4eZU9PutbV04+vkjrh8hStrVcaHlg
         t7Y7FGGkUC6+hy4TOVMMMSVriHxTRMzyUfZJWiuWS95xvP6CCA5KvqTmZHtwc1K83yZ4
         IVObWlnssFfrwYMea+b1gDqGMw9dmc7pXVMGzhz14ec3Jkwo4QG1OMl2sPf24xh9+KGG
         xWRJRUSfo8lhlUDrMtl6++T6y9gppJYBvtcN9D3913uLH4Ho+c2t1cRjYmcJfoFmrmcS
         EhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575280; x=1717180080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGCf1ir0ewKxnfYL+8Y6zr0drR+R4O1jhqT1oluTBL8=;
        b=AzpwLLZne92gZJbjyhMjPY12Whlz7sS0AFvrN2iNFKamg5BPNIfYxEylnvhmMl3lFf
         k5HYyRyI8LRjSAxAlbiKxyS6qOFKAClqsIZvdzvIKXoAvtiJy6iKa4SCwI5Ek/vtW+lH
         GIobMW6plrKLsYIAF8qkmnZpAPMENYFEBpCyVzR1VcYmKEAjXzMme2icyNGh2udJqArM
         Rg8N+pWkyugbsu4StEmlS9Sv0a1HGqFVCQMBmm9F2pKZon9wIrwZ9sDrWzbHcOWLv043
         MvA9MdXvFpbTTCxIRfX7kJRu/tEexN01CzzN8pFzYNH6ivFFJ70UaO2b3YskUP9GWM/m
         32Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVrUC/+Ephco9pvqIzQtSPp9489HqXNbrwD6sxjGV10KI6ddQuwVWWSd4cB3wmWWEBQoZ7GB277CElgTvYMNxg4A81kulJZWiUI
X-Gm-Message-State: AOJu0YxYRbXGP//QNHCBXJ7thtqLut9EsA7rCKSJr/yWy95HaNiqOE+j
	CPHxqXK9gUhFR1VlhEPUo1sKuKuBVMdpvTchViwzdh6Smu0G9dARwA5BnIL0Fc7Sl77YD4CGyVy
	BOpf+gTkSbmY4ydmypg8WfQQcEw49QlQY
X-Google-Smtp-Source: AGHT+IHAQFzXjWnTl+TwMEnEF3wypw9s7LeiM71e7MxN0zWKYR44rUnrOPV4U43jDFBiNTbbJuux8HJQ65dC
X-Received: by 2002:a05:600c:1381:b0:41f:b0e7:f299 with SMTP id 5b1f17b1804b1-42108a59292mr20514315e9.9.1716575280074;
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fa9eb7sm5393305e9.34.2024.05.24.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
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
Subject: [PATCH 15/18] spi: bcm2835: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:26:59 +0100
Message-Id: <20240524182702.1317935-16-dave.stevenson@raspberrypi.com>
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
 drivers/spi/spi-bcm2835.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..e8242e0c4246 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -119,6 +119,7 @@ MODULE_PARM_DESC(polling_limit_us,
  */
 struct bcm2835_spi {
 	void __iomem *regs;
+	phys_addr_t phys_addr;
 	struct clk *clk;
 	struct gpio_desc *cs_gpio;
 	unsigned long clk_hz;
@@ -891,19 +892,8 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 			    struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
-	const __be32 *addr;
-	dma_addr_t dma_reg_base;
 	int ret;
 
-	/* base address in dma-space */
-	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
-	if (!addr) {
-		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
-		/* Fall back to interrupt mode */
-		return 0;
-	}
-	dma_reg_base = be32_to_cpup(addr);
-
 	/* get tx/rx dma */
 	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
@@ -925,7 +915,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * or, in case of an RX-only transfer, cyclically copies from the zero
 	 * page to the FIFO using a preallocated, reusable descriptor.
 	 */
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.dst_addr = bs->phys_addr + BCM2835_SPI_FIFO;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_tx, &slave_config);
@@ -964,9 +954,9 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * RX FIFO or, in case of a TX-only transfer, cyclically writes a
 	 * precalculated value to the CS register to clear the RX FIFO.
 	 */
-	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.src_addr = bs->phys_addr + BCM2835_SPI_FIFO;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_CS);
+	slave_config.dst_addr = bs->phys_addr + BCM2835_SPI_CS;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_rx, &slave_config);
@@ -1336,6 +1326,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
+	struct resource *iomem;
 	int err;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
@@ -1359,10 +1350,12 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs = spi_controller_get_devdata(ctlr);
 	bs->ctlr = ctlr;
 
-	bs->regs = devm_platform_ioremap_resource(pdev, 0);
+	bs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
+	bs->phys_addr = iomem->start;
+
 	bs->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
-- 
2.34.1


