Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662F366060
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhDTTqz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 15:46:55 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:54884 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTTqz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 15:46:55 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d34 with ME
        id v7mF2400D21Fzsu037mFED; Tue, 20 Apr 2021 21:46:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 21:46:16 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     eajames@linux.ibm.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: fsi: add a missing of_node_put
Date:   Tue, 20 Apr 2021 21:46:13 +0200
Message-Id: <504e431b900341249d331b868d90312cf41f415a.1618947919.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'for_each_available_child_of_node' performs an of_node_get on each
iteration, so a return from the middle of the loop requires an of_node_put.

Fixes: bbb6b2f9865b ("spi: Add FSI-attached SPI controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-fsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index de359718e816..87f8829c3995 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -566,8 +566,10 @@ static int fsi_spi_probe(struct device *dev)
 			continue;
 
 		ctlr = spi_alloc_master(dev, sizeof(*ctx));
-		if (!ctlr)
+		if (!ctlr) {
+			of_node_put(np);
 			break;
+		}
 
 		ctlr->dev.of_node = np;
 		ctlr->num_chipselect = of_get_available_child_count(np) ?: 1;
-- 
2.27.0

