Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC455CFE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 02:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFZAl5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jun 2019 20:41:57 -0400
Received: from mx.socionext.com ([202.248.49.38]:7014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfFZAl5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Jun 2019 20:41:57 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jun 2019 09:41:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 8F16F60629;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 26 Jun 2019 09:41:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 78EDF40377;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 4E6AD120138;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 1/2] spi: uniphier: fix timeout error
Date:   Wed, 26 Jun 2019 09:41:47 +0900
Message-Id: <1561509708-4175-2-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Timeout error was silently ignored.
This commit adds timeout error handling and modifies return type of
wait_for_completion_timeout().

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 5a6137f..c3c35c0 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -328,7 +328,8 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 				     struct spi_transfer *t)
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
-	int status;
+	struct device *dev = master->dev.parent;
+	unsigned long time_left;
 
 	uniphier_spi_setup_transfer(spi, t);
 
@@ -338,13 +339,15 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 
 	uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	status = wait_for_completion_timeout(&priv->xfer_done,
-					     msecs_to_jiffies(SSI_TIMEOUT_MS));
+	time_left = wait_for_completion_timeout(&priv->xfer_done,
+					msecs_to_jiffies(SSI_TIMEOUT_MS));
 
 	uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	if (status < 0)
-		return status;
+	if (!time_left) {
+		dev_err(dev, "transfer timeout.\n");
+		return -ETIMEDOUT;
+	}
 
 	return priv->error;
 }
-- 
2.7.4

