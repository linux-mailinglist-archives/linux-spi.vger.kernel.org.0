Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0B32C6FD
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377260AbhCDAan (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:43 -0500
Received: from mars.blocktrron.ovh ([51.254.112.43]:56730 "EHLO
        mail.blocktrron.ovh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbhCCQRk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 11:17:40 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 11:17:40 EST
Received: from localhost.localdomain (p200300e53f0682002d543747df09623c.dip0.t-ipconnect.de [IPv6:2003:e5:3f06:8200:2d54:3747:df09:623c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id 8EA9C23380;
        Wed,  3 Mar 2021 17:08:50 +0100 (CET)
From:   David Bauer <mail@david-bauer.net>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: ath79: always call chipselect function
Date:   Wed,  3 Mar 2021 17:08:36 +0100
Message-Id: <20210303160837.165771-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi-bitbang has to call the chipselect function on the ath79 SPI driver
in order to communicate with the SPI slave device, as the ath79 SPI
driver has three dedicated chipselect lines but can also be used with
GPIOs for the CS lines.

Fixes commit 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/spi/spi-ath79.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index eb9a243e9526..436327fb58de 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -158,6 +158,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->setup = spi_bitbang_setup;
 	master->cleanup = spi_bitbang_cleanup;
+	master->flags = SPI_MASTER_GPIO_SS;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
-- 
2.30.1

