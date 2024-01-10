Return-Path: <linux-spi+bounces-386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E718C82956B
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jan 2024 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E6C1F255BA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jan 2024 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B73CA4A;
	Wed, 10 Jan 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hRdZ7AG5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51173A8C6
	for <linux-spi@vger.kernel.org>; Wed, 10 Jan 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704876849; x=1736412849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vRqfUgQM2sdsBN1AvA0sRgBKLLZlTpAYMa60phHuMfk=;
  b=hRdZ7AG5ewc2r3lDFmTUJ/3eBi8uJYnn2KYXY4BGXpGXvF3uMV02v7I4
   p8t7L/CYHGjiW5MkLW4lWG8+UTRjYyalpbWd7xO/A4l3MTPLIX9RFqDbv
   AQ7j+CnjtWzayiSO+idYCwRgvKzNOI7a0Qxp775UQLuc3XCexGZgYfrb+
   OG7Q6EGvXaEtjDhMy03Y10d0sxmB7dpN1ThQdb48vzzvAnvRktkewaABi
   JckwRIy99AEubaxZjWUkMXcuBCgrxorgN15UE67MepfRkcXM/7pBBQfhd
   LZh8FqoStSlpduc/bA93xkZvYE7U51tszjZftQKv/q5YMbZjtdwNsSUxw
   A==;
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="34822720"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jan 2024 09:54:06 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1345A280075;
	Wed, 10 Jan 2024 09:54:06 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
Date: Wed, 10 Jan 2024 09:54:03 +0100
Message-Id: <20240110085403.457089-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dma_request_chan() fails, no error is shown nor any information is
shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
Use dev_err_probe to fix both problems.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Sorry, I lost sight of the replies from v1 series. I'll address Fabio's
concern here instead.

It's true that running spi-imx with SDMA is valid. But if provided DMA
channels are not available, aka -EPROBE_DEFER, there is no information
why so. This can simply be seen by disabling the sdma1 node on imx8mp:
$ cat /sys/kernel/debug/devices_deferred 
30820000.spi
30830000.spi
30840000.spi

There is no indication what is wrong/missing here. There is also no fallback
to pio mode.
This patch addresses this by setting the defer probe reason.

Changes in v2:
* Rebase to next-20240110

[1] https://lore.kernel.org/all/CAOMZO5CcD5iDkaempdxnQHx1fAgnXAmMq_0MdEq5wNgOLHcMuw@mail.gmail.com/

 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 272bc871a848b..546cdce525fc5 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1344,7 +1344,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	controller->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
 		ret = PTR_ERR(controller->dma_tx);
-		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		dev_err_probe(dev, ret, "can't get the TX DMA channel!\n");
 		controller->dma_tx = NULL;
 		goto err;
 	}
@@ -1353,7 +1353,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	controller->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(controller->dma_rx)) {
 		ret = PTR_ERR(controller->dma_rx);
-		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		dev_err_probe(dev, ret, "can't get the RX DMA channel!\n");
 		controller->dma_rx = NULL;
 		goto err;
 	}
-- 
2.34.1


