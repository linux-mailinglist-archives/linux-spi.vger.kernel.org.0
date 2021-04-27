Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36BE36C7D9
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhD0Ojg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhD0Ojg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 10:39:36 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1583C061574
        for <linux-spi@vger.kernel.org>; Tue, 27 Apr 2021 07:38:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91bb:828d:42f8:4e5f])
        by michel.telenet-ops.be with bizsmtp
        id xqek2400M2ZBlDX06qekl9; Tue, 27 Apr 2021 16:38:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lbOrM-000t7I-A9; Tue, 27 Apr 2021 16:38:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lbOrL-00GAse-Kz; Tue, 27 Apr 2021 16:38:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: altera: Make SPI_ALTERA_CORE invisible
Date:   Tue, 27 Apr 2021 16:38:42 +0200
Message-Id: <f0cb8e66baba4506db6f42fca74dc51b76883507.1619534253.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI_ALTERA_CORE config symbol controls compilation of the Altera SPI
Controller core code.  It is already selected by all of its users, so
there is no reason to make it visible, unless compile-testing.

Fixes: b0c3d9354de1f87e ("spi: altera: separate core code from platform code")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7f03d1e50361ea94..17a55214e66ad928 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -65,7 +65,7 @@ config SPI_ALTERA
 	  This is the driver for the Altera SPI Controller.
 
 config SPI_ALTERA_CORE
-	tristate "Altera SPI Controller core code"
+	tristate "Altera SPI Controller core code" if COMPILE_TEST
 	select REGMAP
 	help
 	  "The core code for the Altera SPI Controller"
-- 
2.25.1

