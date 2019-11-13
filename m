Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D48FAD5A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKMJnE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:43:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58636 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJnE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:43:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9gMsZ082912;
        Wed, 13 Nov 2019 03:42:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638142;
        bh=3x3rU9RLW9JRC3Q9uswDVAWWOQCpRFv6hqsq7AAr2eA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pxyY6RmoRry+v7ZDPTbg1OZkA6tj+IY/Bx/zIEw2DtfWFnLKbqw4KaE9yjaPYlEON
         Hezoe3HPRTz0lTXk9MrkdI22tQHMgr9wJfeF0BaQsi4hQ/9s5kcH/Dzkk253Ji93Ai
         g+WXaoBJHMkp5hzjJK5+xnSJ3FZM6X5RsEcK7qlY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9gM7n063299;
        Wed, 13 Nov 2019 03:42:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:42:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:42:04 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM8072663;
        Wed, 13 Nov 2019 03:42:17 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linus.walleij@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <andi@etezian.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 8/9] spi: tegra114: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:55 +0200
Message-ID: <20191113094256.1108-9-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-tegra114.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e6a450d9b4f0..fc40ab146c86 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -666,8 +666,7 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	dma_addr_t dma_phys;
 	int ret;
 
-	dma_chan = dma_request_slave_channel_reason(tspi->dev,
-					dma_to_memory ? "rx" : "tx");
+	dma_chan = dma_request_chan(tspi->dev, dma_to_memory ? "rx" : "tx");
 	if (IS_ERR(dma_chan)) {
 		ret = PTR_ERR(dma_chan);
 		if (ret != -EPROBE_DEFER)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

