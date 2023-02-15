Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35D697C98
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 14:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBONBl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBONBi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 08:01:38 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55C36695
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 05:01:33 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SHPepPq8UqIOtSHPepCxKZ; Wed, 15 Feb 2023 14:01:31 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Feb 2023 14:01:31 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: synquacer: Fix timeout handling in synquacer_spi_transfer_one()
Date:   Wed, 15 Feb 2023 14:01:28 +0100
Message-Id: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

wait_for_completion_timeout() never returns a <0 value. It returns either
on timeout or a positive value (at least 1, or number of jiffies left
till timeout)

So, fix the error handling path and return -ETIMEDOUT should a timeout
occur.

Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/spi/spi-synquacer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 47cbe73137c2..dc188f9202c9 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -472,10 +472,9 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 		read_fifo(sspi);
 	}
 
-	if (status < 0) {
-		dev_err(sspi->dev, "failed to transfer. status: 0x%x\n",
-			status);
-		return status;
+	if (status == 0) {
+		dev_err(sspi->dev, "failed to transfer. Timeout.\n");
+		return -ETIMEDOUT;
 	}
 
 	return 0;
-- 
2.34.1

