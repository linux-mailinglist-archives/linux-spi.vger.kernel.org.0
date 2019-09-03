Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03C5A6091
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 07:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfICFbG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:49352 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfICFbG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Sep 2019 14:31:05 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 535F6605FA;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 3 Sep 2019 14:31:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1ADCC1A0E9F;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E5B391204B3;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 2/3] spi: uniphier: remove unnecessary code
Date:   Tue,  3 Sep 2019 14:31:00 +0900
Message-Id: <1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This commit removed if() because priv->is_save_param is always true.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index e6ebbb1..d40ad93 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -227,8 +227,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 		priv->speed_hz = t->speed_hz;
 	}
 
-	if (!priv->is_save_param)
-		priv->is_save_param = true;
+	priv->is_save_param = true;
 
 	/* reset FIFOs */
 	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
-- 
2.7.4

