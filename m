Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A748C44
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 20:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfFQSky (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 14:40:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQSkq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 14:40:46 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1My2pz-1iYB2z0yrP-00zXBY; Mon, 17 Jun 2019 20:40:42 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/3] drivers: gpio: pcf857x: use subsys_spi_driver()
Date:   Mon, 17 Jun 2019 20:40:39 +0200
Message-Id: <1560796840-18207-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560796840-18207-1-git-send-email-info@metux.net>
References: <1560796840-18207-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:M/nsSJBHaWVfUfkok+yQ95wDcx5oNEK92hp+dTuZ1CnCnhjvWgZ
 XJx7TSgLZqCQ/hSdGwQ676mK5NtYlYWFgAjUxq++KusMtwFY0WAh1AjLDYyhzR1T1OxtamD
 lwkPRgYbL7l08CFT+CguKpWK+R0btJUsvDoYJZVWIaInPG1jaYjsVF8kvwCSpP9hE6SW5aR
 08JK0+RpwmkjcZ76MyKoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2MjLVd3qQAQ=:2kFG66DdoTwfVODnECYuCx
 Grqm+co+8Erozqx8ViFcKDj64slkV8HKSpOpFG9V7o69FOxKaiGQs1B8b5YRvdesslV2BxAIs
 yT6J80XSBtRYnjJ07xGte4jAUQpaMSKcOR2L18C1tPW7oeAI2ePhmI+nrUjDNEJS+a6k5dL3y
 oxPlC7XP9M5fY0OukcY1fZFnW1Hy/FFXgeRIjdSB1gSNh5lT2Zr1bbhusvjfMESLwVGhAly4v
 8nfMfU+A0ScGMXvJGMLpbEJKe+DLKpYw3KdywwnksaQsnoZa2OLzMJWJ9wttYa8vn8R1pC3fu
 ML41GX0/7RDg3MJpgPHcwE0eQzEYV8ZfCmCMGdym3kWN8TzGbvw0kFUzZkwxbefa5aioYEvWr
 afY040pMQxBMhDZx6zC01ORm9QAaydT49i5yUtzIBv6lhJRDaYOnv546wBjqns/Vn8iQnJqsX
 9VPmBWAR03XlLngqRGX3xX7fzUwN9mHnMosPDMC/n4G2Z+uQCNBPhprDYwkuUTe1xqbP3yy/h
 IrGpdGax9VHZ/qWxVguzuLuW/w/gk+HNd9oviyHY90KBmRznmrjyLqjWagIdnVpxMRPjdPrLN
 lptCJdNwFRZgSTYcNuArbFVstMNh5cDSXbxNqTkDVoChL/ipsgjjYj+HVqwtoyaJzWpSirbgj
 1AKbb1DIEuG8pPy0/BMFHO+3bc5Fk3ZMn7Xw4Bn6rwy6oJYmLqNfk7ght03P+70T8WnF9jV3d
 3Wu3O3i0QZpo1aQNt0LW+2pwv6IOmBhwWZ5ePK4QEkeuf9EkJHzvjE23cRn1pRWpOb3OkcqBw
 84c4h4bWQH2aUTSkFGM0X2QuOOLLmK8jdBxiEMIXpY17pSQ9+msT8EgxHT6X0zHGuA6x3nlsH
 Od0mxzvF41bjcVNnVKUqeWBKbDkqRJAombAvPH4eUeMvpBQIQH2SAAaz01Y4F1XIV+EbWuEJ6
 l4ALBexy+TA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_spi_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-max7301.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 647dfbb..30815cf 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -86,21 +86,10 @@ static int max7301_remove(struct spi_device *spi)
 	.remove = max7301_remove,
 	.id_table = max7301_id,
 };
-
-static int __init max7301_init(void)
-{
-	return spi_register_driver(&max7301_driver);
-}
 /* register after spi postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(max7301_init);
-
-static void __exit max7301_exit(void)
-{
-	spi_unregister_driver(&max7301_driver);
-}
-module_exit(max7301_exit);
+subsys_spi_driver(max7301_driver);
 
 MODULE_AUTHOR("Juergen Beisert, Wolfram Sang");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

