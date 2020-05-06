Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E41C74DB
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgEFPa3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:14457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgEFPa3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:29 -0400
IronPort-SDR: 75KZZq6Dg/+KjhqBXPXz4B18k7GN/XuRNX0DuOeCxraw6jL0DfkHTtknndWM7GJA52kzwbmxY0
 OonE73njfAgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:28 -0700
IronPort-SDR: fx1A9VyNczBd2EMsxbTH5U7WaRAPtWlFmRidPzSwmC94DS4z4yj2iP8vh+pYcntpbd4NFRarFk
 7PTUCWwW+NvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="284658192"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2020 08:30:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51591D7; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/8] spi: dw: Remove unused variable in CR0 configuring hooks
Date:   Wed,  6 May 2020 18:30:19 +0300
Message-Id: <20200506153025.21441-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After enabling new IP support in the driver couple of variables
were left unused compiler is not happy about:

.../spi-dw.c: In function ‘dw_spi_update_cr0’:
.../spi-dw.c:264:17: warning: unused variable ‘dws’ [-Wunused-variable]
  264 |  struct dw_spi *dws = spi_controller_get_devdata(master);
      |                 ^~~
.../spi-dw.c: In function ‘dw_spi_update_cr0_v1_01a’:
.../spi-dw.c:285:17: warning: unused variable ‘dws’ [-Wunused-variable]
  285 |  struct dw_spi *dws = spi_controller_get_devdata(master);
      |                 ^~~

Drop them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 240a61b66a066..6e56a64ccc557 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -261,7 +261,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 u32 dw_spi_update_cr0(struct spi_controller *master, struct spi_device *spi,
 		      struct spi_transfer *transfer)
 {
-	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0;
 
@@ -282,7 +281,6 @@ u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 			     struct spi_device *spi,
 			     struct spi_transfer *transfer)
 {
-	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0;
 
-- 
2.26.2

