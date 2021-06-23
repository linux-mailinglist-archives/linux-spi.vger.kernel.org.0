Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF73B1766
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhFWKBD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 06:01:03 -0400
Received: from www.zeus03.de ([194.117.254.33]:50522 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFWKBD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=E11OwyfOqdc0Pf
        4bCuqrSIXsLfAF/1gZ/HldFNuzncU=; b=E1enCBCvPW9B12QyL0C9Kd/LH5jW+L
        xxo1Tcpu9NbBDfGOCNVVcY83BielMruXQnB94l/7Il9Sbgdf5krvfA+v3yphFllu
        3D10OWU9pGp6vI5hQtYPyfiXociXqCxjhO2jco/+PuCtYp23s0OH9xCt6FYg17bs
        cCAhA1lXXIK6E=
Received: (qmail 2551478 invoked from network); 23 Jun 2021 11:58:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 11:58:44 +0200
X-UD-Smtp-Session: l3s3148p1@eBK082vFCqogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: spi-rspi: : use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 11:58:42 +0200
Message-Id: <20210623095843.3228-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
References: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dmaengine_terminate_all() is deprecated in favor of explicitly saying if
it should be sync or async. Here, we want dmaengine_terminate_sync()
because there is no other synchronization code in the driver to handle
an async case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-rspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e39fd38f5180..d16ed88802d3 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -618,9 +618,9 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 			ret = -ETIMEDOUT;
 		}
 		if (tx)
-			dmaengine_terminate_all(rspi->ctlr->dma_tx);
+			dmaengine_terminate_sync(rspi->ctlr->dma_tx);
 		if (rx)
-			dmaengine_terminate_all(rspi->ctlr->dma_rx);
+			dmaengine_terminate_sync(rspi->ctlr->dma_rx);
 	}
 
 	rspi_disable_irq(rspi, irq_mask);
@@ -634,7 +634,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 no_dma_tx:
 	if (rx)
-		dmaengine_terminate_all(rspi->ctlr->dma_rx);
+		dmaengine_terminate_sync(rspi->ctlr->dma_rx);
 no_dma_rx:
 	if (ret == -EAGAIN) {
 		dev_warn_once(&rspi->ctlr->dev,
-- 
2.30.2

