Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF03F273FE
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 03:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfEWB3L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 21:29:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2361 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB3L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 21:29:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce5f7660000>; Wed, 22 May 2019 18:29:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 18:29:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 18:29:10 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 01:29:09 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 01:29:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 May 2019 01:29:09 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.170.210]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce5f7640000>; Wed, 22 May 2019 18:29:09 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <natechancellor@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] spi: tegra114: set master cleanup and also invoke it on probe error
Date:   Wed, 22 May 2019 18:29:04 -0700
Message-ID: <1558574945-19275-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558574950; bh=SAHDDiy+8cJTvUTqoCRwjDBSwZmy4x7d81HaiiKYpNs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=jYM//wB8NmUazpt22CMuPDn4kYvBJspP5cJzDflqciF9UGwDjY4CrdqBDKAFUQh5B
         jfB/mVjYVDbcaLgUJgf1WlglyFgVRGRxaCHfyzq52bt8oTbCLM9h+72uXpWYJZmhEH
         HqZwypcZwgS5X4L3YspTZQr3jORGgRW+shsrDyDnvnvdM8pc4wEpPFcvYcGtoaXpQy
         OU1r++T3yHRYRFGrHWiapbWF0e1zf2MtKgYXKsP1ggnZWpp/kXRLD8xvgc4Br5EmjW
         I7G0TwHZ7ZraTHUbxiB4GqAWK+5m99bpqVreYH4ko8aMod75eiX5GI1E8IsX3pHyw5
         Y+D+uXyBIJ2qA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch sets master cleanup and also invokes tegra spi clean on
tegra spi probe failure to release tegra spi client data.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 253a7f182fc9..15f9368fc0f8 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -966,6 +966,8 @@ static int tegra_spi_setup(struct spi_device *spi)
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
+		if (cdata)
+			tegra_spi_cleanup(spi);
 		return ret;
 	}
 
@@ -1331,6 +1333,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
+	master->cleanup = tegra_spi_cleanup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->set_cs_timing = tegra_spi_set_hw_cs_timing;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.7.4

