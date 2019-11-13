Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA6FAD34
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMJmR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:42:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48458 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJmR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:42:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9fj21122267;
        Wed, 13 Nov 2019 03:41:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638105;
        bh=wWJNZTFuNZCcK7Gn/PoNwIYOeJyEw7kXPqGfgVe5Kjc=;
        h=From:To:CC:Subject:Date;
        b=qzhwgSI41DHaPdsyG2pybK58nnrYlcNzOwFvAEJ8zErgmDrcjk1MfdN+sJjRHHzmw
         TZ55lqmjSWXuIVOxk6d4EruLhRJTbRGG67gVQsMgQ3oFAmnm5kC4sSmDrv3I4Shnsw
         aDqVx4jgrSYEmfOnxHZ1iTygLNmBbocseB2cbO/0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9fjAM080798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:41:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:41:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:41:27 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM0072663;
        Wed, 13 Nov 2019 03:41:41 -0600
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
Subject: [PATCH 0/9] spi: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:47 +0200
Message-ID: <20191113094256.1108-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I'm going through the tree to remove dma_request_slave_channel_reason() as it
is just:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Regards,
Peter
---
Peter Ujfalusi (9):
  spi: at91-usart: Use dma_request_chan() directly for channel request
  spi: atmel: Use dma_request_chan() directly for channel request
  spi: fsl-lpspi: Use dma_request_chan() directly for channel request
  spi: imx: Use dma_request_chan() directly for channel request
  spi: pl022: Use dma_request_chan() directly for channel request
  spi: qup: Use dma_request_chan() directly for channel request
  spi: s3c64xx: Use dma_request_chan() directly for channel request
  spi: tegra114: Use dma_request_chan() directly for channel request
  spi: tegra20-slink: Use dma_request_chan() directly for channel
    request

 drivers/spi/spi-at91-usart.c    | 4 ++--
 drivers/spi/spi-atmel.c         | 2 +-
 drivers/spi/spi-fsl-lpspi.c     | 4 ++--
 drivers/spi/spi-imx.c           | 4 ++--
 drivers/spi/spi-pl022.c         | 4 ++--
 drivers/spi/spi-qup.c           | 4 ++--
 drivers/spi/spi-s3c64xx.c       | 6 ++----
 drivers/spi/spi-tegra114.c      | 3 +--
 drivers/spi/spi-tegra20-slink.c | 3 +--
 9 files changed, 15 insertions(+), 19 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

