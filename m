Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E518255CFC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 02:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZAl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jun 2019 20:41:58 -0400
Received: from mx.socionext.com ([202.248.49.38]:7014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfFZAl6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Jun 2019 20:41:58 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jun 2019 09:41:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id F38CC60629;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 26 Jun 2019 09:41:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A99A21A14E3;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7F157120138;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 2/2] spi: uniphier: fix zero-length transfer
Date:   Wed, 26 Jun 2019 09:41:48 +0900
Message-Id: <1561509708-4175-3-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The zero-length transfer results in timeout error because
the transfer doesn't start.
This commit modified to return success in this case.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c3c35c0..b32c77d 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -331,6 +331,10 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 	struct device *dev = master->dev.parent;
 	unsigned long time_left;
 
+	/* Terminate and return success for 0 byte length transfer */
+	if (!t->len)
+		return 0;
+
 	uniphier_spi_setup_transfer(spi, t);
 
 	reinit_completion(&priv->xfer_done);
-- 
2.7.4

