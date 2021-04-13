Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7C35DEDB
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345811AbhDMM2Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbhDMM1x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Apr 2021 08:27:53 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1DC061345
        for <linux-spi@vger.kernel.org>; Tue, 13 Apr 2021 05:27:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ed15:b7e9:afd7:f062])
        by baptiste.telenet-ops.be with bizsmtp
        id sCTR2400B1dBBzp01CTRAp; Tue, 13 Apr 2021 14:27:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lWI8a-00FJNA-Oz; Tue, 13 Apr 2021 14:27:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lWI8a-002kYK-AJ; Tue, 13 Apr 2021 14:27:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jay Fang <f.fangjian@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: SPI_HISI_KUNPENG should depend on ARCH_HISI
Date:   Tue, 13 Apr 2021 14:27:23 +0200
Message-Id: <d93934dfdbb4d35e35371517de3b64c144aeb5ef.1618316782.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The HiSilicon Kunpeng SPI controller is only present on HiSilicon
Kunpeng SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking
the user about this driver when configuring a kernel without Hisilicon
platform support.

Fixes: c770d8631e1810d8 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1ffcad19c0562a39..7d438ad343598bb8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -334,7 +334,7 @@ config SPI_FSL_QUADSPI
 
 config SPI_HISI_KUNPENG
 	tristate "HiSilicon SPI Controller for Kunpeng SoCs"
-	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on (ARM64 && ARCH_HISI && ACPI) || COMPILE_TEST
 	help
 	  This enables support for HiSilicon SPI controller found on
 	  Kunpeng SoCs.
-- 
2.25.1

