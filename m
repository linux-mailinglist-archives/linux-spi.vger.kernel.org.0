Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857B0370C1A
	for <lists+linux-spi@lfdr.de>; Sun,  2 May 2021 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhEBOFU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 May 2021 10:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhEBOFJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 2 May 2021 10:05:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B440F613B0;
        Sun,  2 May 2021 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619964255;
        bh=pgd1252rTW4FmboBZqeKmdDft2iOwqQhjAW9jP4Q6SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcTMLHuI2LzjN8MpKeDu+5L1o9NQP/DuiQ83t9O7UKgMQYsMYp7PYv0J1ZAUNIUwe
         dntsXBqWADj/TmS6GRP/s+58ZFDyd5yOc4aTfWN90aRFoqkjXnOKtAK0gMlet9yLF7
         YyFJwpC4VYjwxtLh10QQRnDfWDHKrsM9/45YjaaZ6kF7FvR2tFYtapH0zPefvMB6pZ
         jIWb6hEQOl6hKf4EmTkxq+mm7mlAVDnOJTsvWONAvKh87MuQ2jrVPcheJ5eEaDMddx
         FPemn1VNBJw0JeILDBC4udBwEL6I70E1kvcbuQ4Z1KY9mEa0B7zfThFvPYBKCxDWb0
         HF4zhfl5e8oNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Bauer <mail@david-bauer.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/66] spi: ath79: always call chipselect function
Date:   Sun,  2 May 2021 10:03:08 -0400
Message-Id: <20210502140411.2719301-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210502140411.2719301-1-sashal@kernel.org>
References: <20210502140411.2719301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: David Bauer <mail@david-bauer.net>

[ Upstream commit 19e2132174583beb90c1bd3e9c842bc6d5c944d1 ]

spi-bitbang has to call the chipselect function on the ath79 SPI driver
in order to communicate with the SPI slave device, as the ath79 SPI
driver has three dedicated chipselect lines but can also be used with
GPIOs for the CS lines.

Fixes commit 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")

Signed-off-by: David Bauer <mail@david-bauer.net>
Link: https://lore.kernel.org/r/20210303160837.165771-1-mail@david-bauer.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.30.2

