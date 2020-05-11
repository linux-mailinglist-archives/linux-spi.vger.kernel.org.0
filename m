Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604EB1CD3CB
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgEKIZl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 04:25:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:36091 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgEKIZk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 04:25:40 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 May 2020 17:25:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 09B4A1800CF;
        Mon, 11 May 2020 17:25:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 11 May 2020 17:25:38 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 8392C1A0E67;
        Mon, 11 May 2020 17:25:38 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] spi: uniphier: Depend on HAS_IOMEM
Date:   Mon, 11 May 2020 17:25:29 +0900
Message-Id: <1589185530-28170-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver uses devm_ioremap_resource() which is only available when
CONFIG_HAS_IOMEM is set, so the driver depends on this option.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 17e7e4a..099d6a7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -844,6 +844,7 @@ config SPI_TXX9
 config SPI_UNIPHIER
 	tristate "Socionext UniPhier SPI Controller"
 	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
+	depends on HAS_IOMEM
 	help
 	  This enables a driver for the Socionext UniPhier SoC SCSSI SPI controller.
 
-- 
2.7.4

