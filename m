Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA98648E92
	for <lists+linux-spi@lfdr.de>; Sat, 10 Dec 2022 13:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLJMAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 10 Dec 2022 07:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJMAa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 10 Dec 2022 07:00:30 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Dec 2022 04:00:29 PST
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 895433A4
        for <linux-spi@vger.kernel.org>; Sat, 10 Dec 2022 04:00:29 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 3yPYpAeHxFUJ33yPYptfah; Sat, 10 Dec 2022 12:52:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 12:52:58 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org
Subject: [PATCH v1] spi: xtensa-xtfpga: Fix a double put() in xtfpga_spi_remove()
Date:   Sat, 10 Dec 2022 12:52:53 +0100
Message-Id: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'master' is allocated with devm_spi_alloc_master(), there is no need to
put it explicitly in the remove function.

Fixes: 478cc2fc3dd7 ("spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-xtensa-xtfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 2fa7608f94cd..271ae98f441c 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -123,7 +123,6 @@ static int xtfpga_spi_remove(struct platform_device *pdev)
 	struct xtfpga_spi *xspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&xspi->bitbang);
-	spi_master_put(master);
 
 	return 0;
 }
-- 
2.34.1

