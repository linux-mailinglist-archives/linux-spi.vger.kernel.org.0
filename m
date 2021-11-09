Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63CA44AB8C
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbhKIKes (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 05:34:48 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:14894 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245377AbhKIKe2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Nov 2021 05:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636453903; x=1667989903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUnXj6bVC9JZgNr9vV26hKfJy1oHGzw91NDS5HFk2sI=;
  b=C5Ro+ajJUx1gqNVwsjZAmKRlwRoQgITAv9P5VUAUKzknRnw25QEyRBGE
   QLEFb1plE3JrMOrRemOskembfOwJOiW4v7IVKrsrfT5Sni2ly+jcaCoBX
   PEKbTlGMehwTnitpkkZOyjgsct08IRe5CkkoQrK+qk9tTUUOu0U1XgqZY
   /yt81YNj3m4qtNnTscKHc2v+p/uM4LhfNU3WSE2sJQVL1+tHmgo5l5HJx
   pcj2VVZDOA4bDsMFb6H1SNhlIqcQEoC1j9lpscUJ5vAQr+7s9utD5rdHJ
   1D7MVYZFlDQ4+nUlkIR4Pm2t/c9y4xkd/aBrO7XE57v51Kp5ci3L6rR9S
   g==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631570400"; 
   d="scan'208";a="20391749"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Nov 2021 11:31:39 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 09 Nov 2021 11:31:40 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 09 Nov 2021 11:31:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636453899; x=1667989899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUnXj6bVC9JZgNr9vV26hKfJy1oHGzw91NDS5HFk2sI=;
  b=JvzC8JykXP+jRgakwJ9emhOG8O/jFT+en4ykpvyckAZQ73Fkk8Za2O+G
   uVEK9YhUgB3JpL9o+N6c50xO+Zlqv1PqBA3XXUJRWMFt041NQZohBeNXz
   y+8WnmPqOAjr2zTXO/AYxbsjcR+tZnP5xt52Xi3qwKFfoXFOIoz3kajlQ
   6y1SlCiTKGVNrmCZcibwxTwTyJathK3wKKxJ2jwT3udD8rD0AVa9h0imS
   Q/lRowol8/wU6ELOZgCukJ0A//Nbo0hN06JTSHtiAzpbcmPXRDmd4mh9v
   pud/F6RPI44nIHLOC3zVekXyy9wQU+P0oe+k9+RUHKFggr91isHSQg3Lw
   w==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631570400"; 
   d="scan'208";a="20391748"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Nov 2021 11:31:39 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A2C10280065;
        Tue,  9 Nov 2021 11:31:39 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: lpspi: release requested DMA channels
Date:   Tue,  9 Nov 2021 11:31:34 +0100
Message-Id: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The requested DMA channels are never released. Do this in .remove as well
as in .probe. spi_register_controller() can return -EPROBE_DEFER if
cs-gpios are not probed yet.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/spi/spi-fsl-lpspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c72e501c270f..4c601294f8fa 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -913,7 +913,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "spi_register_controller error: %i\n", ret);
-		goto out_pm_get;
+		goto free_dma;
 	}
 
 	pm_runtime_mark_last_busy(fsl_lpspi->dev);
@@ -921,6 +921,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	return 0;
 
+free_dma:
+	fsl_lpspi_dma_exit(controller);
 out_pm_get:
 	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
 	pm_runtime_put_sync(fsl_lpspi->dev);
@@ -937,6 +939,8 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(controller);
 
+	fsl_lpspi_dma_exit(controller);
+
 	pm_runtime_disable(fsl_lpspi->dev);
 	return 0;
 }
-- 
2.25.1

