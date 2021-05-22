Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF838D455
	for <lists+linux-spi@lfdr.de>; Sat, 22 May 2021 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhEVHxM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 May 2021 03:53:12 -0400
Received: from perseus.uberspace.de ([95.143.172.134]:41994 "EHLO
        perseus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhEVHxL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 May 2021 03:53:11 -0400
Received: (qmail 28609 invoked from network); 22 May 2021 07:45:04 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by perseus.uberspace.de with SMTP; 22 May 2021 07:45:04 -0000
From:   David Bauer <mail@david-bauer.net>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: ath79: set number of chipselect lines
Date:   Sat, 22 May 2021 09:44:53 +0200
Message-Id: <20210522074453.39299-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522074453.39299-1-mail@david-bauer.net>
References: <20210522074453.39299-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All chipsets from AR7100 up to QCA9563 have three dedicated chipselect
lines for the integrated SPI controller. Set the number of chipselect
lines available on the controller to this value.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/spi/spi-ath79.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 497d5c028496..d1e287d2d9cd 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -153,6 +153,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->flags = SPI_MASTER_GPIO_SS;
+	master->num_chipselect = 3;
 
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
-- 
2.31.1

