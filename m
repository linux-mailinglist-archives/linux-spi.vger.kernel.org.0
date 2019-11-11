Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D97F80A0
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2019 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKKTxh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Nov 2019 14:53:37 -0500
Received: from muru.com ([72.249.23.125]:41620 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfKKTxh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Nov 2019 14:53:37 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7659D8047;
        Mon, 11 Nov 2019 19:54:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-omap@vger.kernel.org,
        Luhua Xu <luhua.xu@mediatek.com>, wsd_upstream@mediatek.com
Subject: [PATCH] spi: Fix regression to return zero on success instead of positive value
Date:   Mon, 11 Nov 2019 11:53:34 -0800
Message-Id: <20191111195334.44833-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit d948e6ca1899 ("spi: add power control when set_cs") added generic
runtime PM handling, but also changed the return value to be 1 instead
of 0 that we had earlier as pm_runtime_get functions return a positve
value on success.

This causes SPI devices to return errors for cases where they do:

ret = spi_setup(spi);
if (ret)
	return ret;

As in many cases the SPI devices do not check for if (ret < 0).

Let's fix this by setting the status to 0 on succeess after the
runtime PM calls. Let's not return 0 at the end of the function
as this might break again later on if the function changes and
starts returning status again.

Fixes: d948e6ca1899 ("spi: add power control when set_cs")
Cc: Luhua Xu <luhua.xu@mediatek.com>
Cc: wsd_upstream@mediatek.com
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3270,6 +3270,15 @@ int spi_setup(struct spi_device *spi)
 				status);
 			return status;
 		}
+
+		/*
+		 * We do not want to return positive value from pm_runtime_get,
+		 * there are many instances of devices calling spi_setup() and
+		 * checking for a non-zero return value instead of a negative
+		 * return value.
+		 */
+		status = 0;
+
 		spi_set_cs(spi, false);
 		pm_runtime_mark_last_busy(spi->controller->dev.parent);
 		pm_runtime_put_autosuspend(spi->controller->dev.parent);
-- 
2.23.0
