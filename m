Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2531A6903
	for <lists+linux-spi@lfdr.de>; Mon, 13 Apr 2020 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgDMPln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Apr 2020 11:41:43 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:19934 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgDMPln (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Apr 2020 11:41:43 -0400
Received: from localhost.localdomain ([93.22.151.169])
        by mwinf5d63 with ME
        id SFhg2200F3fYTYl03Fhgp5; Mon, 13 Apr 2020 17:41:41 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Apr 2020 17:41:41 +0200
X-ME-IP: 93.22.151.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: sc18is602: Fix a typo in MODULE_DESCRIPTION
Date:   Mon, 13 Apr 2020 17:40:43 +0200
Message-Id: <20200413154043.23064-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This should be 'SC18IS602', not 'SC18IC602'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 5497eeb3bf3e..ee0f3edf49cd 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -345,6 +345,6 @@ static struct i2c_driver sc18is602_driver = {
 
 module_i2c_driver(sc18is602_driver);
 
-MODULE_DESCRIPTION("SC18IC602/603 SPI Master Driver");
+MODULE_DESCRIPTION("SC18IS602/603 SPI Master Driver");
 MODULE_AUTHOR("Guenter Roeck");
 MODULE_LICENSE("GPL");
-- 
2.20.1

