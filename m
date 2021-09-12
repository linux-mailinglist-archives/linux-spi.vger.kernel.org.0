Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F04081F5
	for <lists+linux-spi@lfdr.de>; Sun, 12 Sep 2021 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhILV7M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Sep 2021 17:59:12 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:39914 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhILV7L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Sep 2021 17:59:11 -0400
X-Greylist: delayed 1816 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 17:59:10 EDT
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPWyY-00C2a9-07; Sun, 12 Sep 2021 23:25:23 +0200
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPWyX-0003D0-7N; Sun, 12 Sep 2021 23:25:21 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95-RC2)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mPWyW-00034n-IF;
        Sun, 12 Sep 2021 23:25:20 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun, 12 Sep 2021 23:25:19 +0200
Message-Id: <20210912212519.11797-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001 autolearn=no
        autolearn_force=no languages=ro en
Subject: [PATCH] spi: tegra20-slink: fix "defined but not used" if !CONFIG_PM
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Because of warnings, esp. with new default -Werror.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/spi/spi-tegra20-slink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ebd27f883033..c8b54c7c53d0 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -204,8 +204,10 @@ struct tegra_slink_data {
 	struct dma_async_tx_descriptor		*tx_dma_desc;
 };
 
+#ifdef CONFIG_PM
 static int tegra_slink_runtime_suspend(struct device *dev);
 static int tegra_slink_runtime_resume(struct device *dev);
+#endif
 
 static inline u32 tegra_slink_readl(struct tegra_slink_data *tspi,
 		unsigned long reg)
@@ -1185,6 +1187,7 @@ static int tegra_slink_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
 static int tegra_slink_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -1210,6 +1213,7 @@ static int tegra_slink_runtime_resume(struct device *dev)
 	}
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops slink_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_slink_runtime_suspend,
-- 
2.33.0

