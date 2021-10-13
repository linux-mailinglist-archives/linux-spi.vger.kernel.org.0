Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57542C3CF
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJMOrr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhJMOrq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 10:47:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390D261166;
        Wed, 13 Oct 2021 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136343;
        bh=pJnfWgGsGqI+zfTzCodTG7zYPd1pU/Q0UOVa898IOI8=;
        h=From:To:Cc:Subject:Date:From;
        b=b8cGpsbY89OZhao46D3bT6WBHQVOgjq8KvdCA6d8xb8W+IBczoP5xCk5S3XwDSmk1
         MkLU+72FS8U/phw1N5p8I0JpN5h0bSr2KccFi3nBmdSfOBd/tYxqvxpHJoFsjdd+7r
         t0Nkt1COEjsVop13m7V/E2NzmPRnd/2UWMgXeH5/sCEZLCTvryYsUSGJVVdIiWKL1C
         0NDyoHNyWnnLM+8IvFLnZowh4jiO9QYZpQ40lxN4UKVGtnnSX1WRQGPBmR9BLTJ6bF
         xSE56vBnP02yWgjfGSL3AR4A53C6Y5Sz+8FbZ6eB7x+znZK16Sv6oAnWB4HXaR0FeY
         QmFRireLpQd9w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Osipenko <digetx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
Date:   Wed, 13 Oct 2021 16:45:23 +0200
Message-Id: <20211013144538.2346533-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is another one of these warnings:

drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
 1197 | static int tegra_slink_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~

Give it the same treatment as the other functions in this file.

Fixes: efafec27c565 ("spi: Fix tegra20 build with CONFIG_PM=n")
Fixes: 2bab94090b01 ("spi: tegra20-slink: Declare runtime suspend and resume functions conditionally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-tegra20-slink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 713292b0c71e..33302f6b42d7 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1194,7 +1194,7 @@ static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_slink_runtime_resume(struct device *dev)
+static __maybe_unused int tegra_slink_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
-- 
2.29.2

