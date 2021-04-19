Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7A364072
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhDSLZm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:58397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238468AbhDSLZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:37 -0400
IronPort-SDR: WbWUKjv9tKT27BaUp66kGoVid5pvZGd08zVQRQhk2jlEp/8dluMmtGKMy+fbsgxXqMUxofTWR1
 wf8J3czQeNuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="215887025"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="215887025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:25:05 -0700
IronPort-SDR: 3SGx1v6CSuYIqnQ9Q/IBN1+ZLngsQIeyBqEi4sJv8Vu5Y6y0SKIACd+H/ZvzDlslq5Qk2eGkjo
 bmteP/tNAesw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="616565518"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2021 04:25:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB04F1A1; Mon, 19 Apr 2021 14:25:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/6] mmc: mmc_spi: Drop unused NO_IRQ definition
Date:   Mon, 19 Apr 2021 14:24:57 +0300
Message-Id: <20210419112459.25241-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After the commit 073350f7b562 ("mmc: mmc_spi: Fix return value evaluation of
irq_of_parse_and_map()") the NO_IRQ is not used anymore, drop it for good.

Fixes: 073350f7b562 ("mmc: mmc_spi: Fix return value evaluation of irq_of_parse_and_map()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/of_mmc_spi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 843ec3db891b..0b038f5c392a 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -19,11 +19,6 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
-/* For archs that don't support NO_IRQ (such as mips), provide a dummy value */
-#ifndef NO_IRQ
-#define NO_IRQ 0
-#endif
-
 MODULE_LICENSE("GPL");
 
 struct of_mmc_spi {
-- 
2.30.2

