Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA4235988
	for <lists+linux-spi@lfdr.de>; Sun,  2 Aug 2020 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHBRuR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Aug 2020 13:50:17 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:16795 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHBRuR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Aug 2020 13:50:17 -0400
Received: from localhost.localdomain ([93.22.148.198])
        by mwinf5d37 with ME
        id AhqE2300J4H42jh03hqFTg; Sun, 02 Aug 2020 19:50:15 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Aug 2020 19:50:15 +0200
X-ME-IP: 93.22.148.198
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: a3700: Remove a useless memset
Date:   Sun,  2 Aug 2020 19:50:07 +0200
Message-Id: <20200802175007.703995-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Memory allocated by 'spi_alloc_master()' is already zeroed.
Remove a redundant memset.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-armada-3700.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index fcde419e480c..46feafe4e201 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -848,7 +848,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	spi = spi_master_get_devdata(master);
-	memset(spi, 0, sizeof(struct a3700_spi));
 
 	spi->master = master;
 
-- 
2.25.1

