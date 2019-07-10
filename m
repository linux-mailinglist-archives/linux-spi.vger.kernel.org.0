Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF24463F69
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 04:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGJClX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jul 2019 22:41:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32880 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGJClW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jul 2019 22:41:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3351200F3A;
        Wed, 10 Jul 2019 04:41:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52BD3200F3E;
        Wed, 10 Jul 2019 04:41:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B0CB6402DB;
        Wed, 10 Jul 2019 10:41:12 +0800 (SGT)
From:   han.xu@nxp.com
To:     han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/3] spi: spi-fsl-qspi: change i.MX7D RX FIFO size
Date:   Wed, 10 Jul 2019 10:31:27 +0800
Message-Id: <20190710023128.13115-3-han.xu@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190710023128.13115-1-han.xu@nxp.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

The RX FIFO should be 128 byte rather than 512 byte. It's a typo on
reference manual.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..1d08c60e5ae2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -206,7 +206,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 };
 
 static const struct fsl_qspi_devtype_data imx7d_data = {
-	.rxfifo = SZ_512,
+	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
-- 
2.17.1

