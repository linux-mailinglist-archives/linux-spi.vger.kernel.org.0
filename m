Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DED364067
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhDSLZ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:61250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238087AbhDSLZ0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:26 -0400
IronPort-SDR: 06qUESQ5jX9w0DgNM2KRPnHDJBDvy8/ObOqLnOmAcGJYovDbSR2GHIDINsCjEELexFWacqojoT
 NLDqRGPKxerw==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="195337211"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="195337211"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:24:56 -0700
IronPort-SDR: 5OZIRQYIR9a6lghPfoytwhZsFRUVQY9MPv0LfTDo4TxoIEz4VD2QxJxV1Fu6f6vaXmR+9qp0Uk
 QUjXUkElZeCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="602113557"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2021 04:24:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 699FF13C; Mon, 19 Apr 2021 14:25:10 +0300 (EEST)
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
Subject: [PATCH v1 1/6] mmc: core: Correct descriptions in mmc_of_parse()
Date:   Mon, 19 Apr 2021 14:24:54 +0300
Message-Id: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since it has been converted to use device property API, the function
and field descriptions become outdated. Correct them.

Fixes: 73a47a9bb3e2 ("mmc: core: Use device_property_read instead of of_property_read")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9b89a91b6b47..ce030c5aa53c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -209,8 +209,8 @@ mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
 EXPORT_SYMBOL(mmc_of_parse_clk_phase);
 
 /**
- *	mmc_of_parse() - parse host's device-tree node
- *	@host: host whose node should be parsed.
+ * mmc_of_parse() - parse host's device properties
+ * @host: host whose properties should be parsed.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
  * used to to instantiate and configure this host instance or not, we
-- 
2.30.2

