Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1713B1770
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFWKBG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 06:01:06 -0400
Received: from www.zeus03.de ([194.117.254.33]:50546 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFWKBD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=lAbSFZ8eh4pWJf
        sVSlspybh6bhZ7rcs5PPFi2TFi8DE=; b=TweBTkQpZ7yWHm9u+UTDhFm42998MX
        yt35erUF7v11QUUPMz6AdIX+MLP3/3ipcNMEcm9peJriqsTS42YvZj7/Yly1zOCh
        Bj3mjadnyvRFJiMs6gstxPRc4ZRLdfXdMRPAltTBuMjA+26QtI7VI7eU+jBj/Ynx
        l2X026Wd7QZSE=
Received: (qmail 2551517 invoked from network); 23 Jun 2021 11:58:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 11:58:45 +0200
X-UD-Smtp-Session: l3s3148p1@hEm+82vFDKogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-sh-msiof: : use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 11:58:43 +0200
Message-Id: <20210623095843.3228-3-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 41ed9ff8fad0..f88d9acd20d9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -853,10 +853,10 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	sh_msiof_spi_stop(p, rx);
 stop_dma:
 	if (tx)
-		dmaengine_terminate_all(p->ctlr->dma_tx);
+		dmaengine_terminate_sync(p->ctlr->dma_tx);
 no_dma_tx:
 	if (rx)
-		dmaengine_terminate_all(p->ctlr->dma_rx);
+		dmaengine_terminate_sync(p->ctlr->dma_rx);
 	sh_msiof_write(p, SIIER, 0);
 	return ret;
 }
-- 
2.30.2

