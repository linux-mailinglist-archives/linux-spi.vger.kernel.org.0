Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5917FAD3C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKMJm3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:42:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57312 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKMJm2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:42:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9g8uA063797;
        Wed, 13 Nov 2019 03:42:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638128;
        bh=KKS9sP1jn/T+EJqEWvgAhiMaS7E2CEh8yFxDixsH8fU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DcSD3IXdnr343GsXzvo3GAzXEWpMauuUZnel9H5c8HPtILXwBgTfPYH4V//s7OKzC
         9/pYhNOtNXAAN+4dZWBuMxN4CL4g6MyHTvD5H6riLENUFe0VdoQGE6D4hk2/9afYIG
         eiUNf1w/livsfOFdpi8kom4gTuZ+30Cw64Bk0TzQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9g8L8081243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:42:08 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:41:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:41:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM5072663;
        Wed, 13 Nov 2019 03:42:03 -0600
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
Subject: [PATCH 5/9] spi: pl022: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:52 +0200
Message-ID: <20191113094256.1108-6-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-pl022.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3024c30e7f2e..66028ebbc336 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1158,7 +1158,7 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 	int err;
 
 	/* automatically configure DMA channels from platform, normally using DT */
-	chan = dma_request_slave_channel_reason(dev, "rx");
+	chan = dma_request_chan(dev, "rx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_no_rxchan;
@@ -1166,7 +1166,7 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 
 	pl022->dma_rx_channel = chan;
 
-	chan = dma_request_slave_channel_reason(dev, "tx");
+	chan = dma_request_chan(dev, "tx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_no_txchan;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

