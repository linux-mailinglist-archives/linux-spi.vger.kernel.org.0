Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6A2190ED
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgGHToL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 15:44:11 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:57956 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgGHToK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 15:44:10 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0322FBC0EE;
        Wed,  8 Jul 2020 19:44:06 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] SPI SUBSYSTEM: Replace HTTP links with HTTPS ones
Date:   Wed,  8 Jul 2020 21:44:00 +0200
Message-Id: <20200708194400.22213-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 Documentation/devicetree/bindings/spi/spi-davinci.txt | 4 ++--
 Documentation/spi/spi-sc18is602.rst                   | 2 +-
 drivers/spi/spi-ep93xx.c                              | 2 +-
 drivers/spi/spi-oc-tiny.c                             | 2 +-
 drivers/spi/spi-ti-qspi.c                             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 9f5b4c7c0c08..e2198a389484 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -1,8 +1,8 @@
 Davinci SPI controller device bindings
 
 Links on DM:
-Keystone 2 - http://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
-dm644x - http://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
+Keystone 2 - https://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
+dm644x - https://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
 OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
 
 Required properties:
diff --git a/Documentation/spi/spi-sc18is602.rst b/Documentation/spi/spi-sc18is602.rst
index 2a31dc722321..4ab9ca346b44 100644
--- a/Documentation/spi/spi-sc18is602.rst
+++ b/Documentation/spi/spi-sc18is602.rst
@@ -6,7 +6,7 @@ Supported chips:
 
   * NXP SI18IS602/602B/603
 
-    Datasheet: http://www.nxp.com/documents/data_sheet/SC18IS602_602B_603.pdf
+    Datasheet: https://www.nxp.com/documents/data_sheet/SC18IS602_602B_603.pdf
 
 Author:
         Guenter Roeck <linux@roeck-us.net>
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 8c854b187b1d..ae7c79a06208 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -10,7 +10,7 @@
  *
  * For more information about the SPI controller see documentation on Cirrus
  * Logic web site:
- *     http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1.pdf
+ *     https://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1.pdf
  */
 
 #include <linux/io.h>
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 9df7c5979c29..f3843f0ff260 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -2,7 +2,7 @@
 /*
  * OpenCores tiny SPI master driver
  *
- * http://opencores.org/project,tiny_spi
+ * https://opencores.org/project,tiny_spi
  *
  * Copyright (C) 2011 Thomas Chou <thomas@wytron.com.tw>
  *
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 366a3e5cca6b..3c41649698a5 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -2,7 +2,7 @@
 /*
  * TI QSPI driver
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  * Author: Sourav Poddar <sourav.poddar@ti.com>
  */
 
-- 
2.27.0

