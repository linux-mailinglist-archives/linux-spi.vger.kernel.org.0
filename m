Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61F48C3E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFQSkq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 14:40:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfFQSkq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 14:40:46 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsI4Q-1iVAln3msE-00tltd; Mon, 17 Jun 2019 20:40:42 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/3] include: linux: spi: more helpers for declaring spi drivers
Date:   Mon, 17 Jun 2019 20:40:38 +0200
Message-Id: <1560796840-18207-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:05rIirEOuVh/P2GdhGgoALTibWMKzcYIYDli8Uu//ZC/3VBGI2w
 +JIY4qGMr/KjTh0Ppz2vrXxXy41cx263AHETMbkXWAcydFrR/jKTiozF+AkwFY4RA6qyQ1K
 LI3uMpGHuBiSXZ0GeZqOZ/65Qg9BNa1sGxKroYGElKDyvZvERJiKF/NWASU/ArGsW5bqcaJ
 4uNZhph5J1wMf9p1vjweg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DbZzcJp0H/g=:W4xpeF7mD2ihzuY4mz4zvV
 Mz9o6ivmAQFHsM/1tyfdeMxNAZDi7t+3LNqty4ZeuajIz+U2oSfAPH2P0ZS4XyCV2Xayhl31P
 egaXRNkJpZlROWmx+b2taN/QMksYOmTDkjBNp/Yw1Tbm5el1UPFkWE0L4U/aqC3OQ6R3g4osR
 kX+uYV849Jxe41HHoyaxJxHZtxO92vr8or61zWPuKf/cYYDuZk/ZzuzVF5jkluL5j3y5X/awS
 iJBRfTKIUlzevJGA4pvD9ICWW1wQ5dKX/t5pepqsDqn2uVBRVpTsroc/nanzrXrxWtzZM189d
 6TR8r0F0HvzALAn16IENWRDnjQdQDNKgO2/QNnbP4Eg3yBQxUFlByLdO/EO25OjWY0BmTskRQ
 ndtfnOEJChtozu9D1u3U+ONHCDXHaLNVVFkKOz/bDjQSHfjFFBnouZAQkcI7gyDzxsV0ffeif
 i82sCtCrJsDekSwAMumFmgjOlAiDQM/6simcBGLXqQEQeS4hmRiCMasPv3GiFcTOQWq66GMJA
 V1DYoOg9Q/mRlqcfHbDU66g34t9YR/aIp19WF+LZQeW0soIzZr6RAfmehGTDlcmmlaQuwdNeY
 ZWSmfhPPJWLvlzbFXmWETCP3qPn9DrnfQm7dUtH4cDIi9/5/aeHqbu4RTrCw32T83dvNFXmmc
 W78gciRdLng6agaEH4nGGwrzAwZTAczz+hhHzWOl9L918q8I6AAhgEMq5GbKlNCRZPDB5zrE6
 Lyk9Ofw7cVoGsQ7HgYVW7ElpIwzCBAMkzA3pew==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Add more helper macros for trivial driver init cases, similar to the
already existing module_spi_driver()+friends - now for those which
are initialized at other stages (eg. by subsys_initcall()).

This helps to further reduce driver init boilerplate.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 include/linux/spi/spi.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd2..f55ba34 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -296,6 +296,23 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 	module_driver(__spi_driver, spi_register_driver, \
 			spi_unregister_driver)
 
+/* subsys_spi_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces subsys_initcall() and module_exit()
+ */
+#define subsys_spi_driver(__spi_driver) \
+static int __init __spi_driver##_init(void) \
+{ \
+	return spi_register_driver(&(__spi_driver)); \
+} \
+subsys_initcall(__spi_driver##_init); \
+static void __exit __spi_driver##_exit(void) \
+{ \
+	spi_unregister_driver(&(__spi_driver)); \
+} \
+module_exit(__spi_driver##_exit);
+
 /**
  * struct spi_controller - interface to SPI master or slave controller
  * @dev: device interface to this driver
-- 
1.9.1

