Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809C4C4C03
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiBYRYk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiBYRYj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 12:24:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1E19E010;
        Fri, 25 Feb 2022 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809847; x=1677345847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4IkmrVZvoee7LpRtKfcAm9A5VhB3z+xAiMSzfCyhgg=;
  b=BpE/UQSmeqc8IhFJhvyDHDO1hDA6jl+LQCD6aZ4GGWC71kkou+Eqiry9
   z6sOxG+HCVWeGQ2e2p6f2NBXA51D5IJBA9VDSwuBM9Bvza4gib+UbjQBZ
   4pmddA5dJ4CWB9urT8wyocsqt6XEChsr1uF+gnLJOi/15BvNakrYHQVkW
   JNU1V17WgPSU6vUaI3u4/uZQ0694Vt2nhwabMTFuEWM8GYkBFUzHshPBW
   /ARd37un848tXiikUHDYetnoqIqhfWmTPuyBaGMotAOcVaH0pFj/Lu3J+
   j5KnCT/T6xTtm/lBmpYihaDjp9JhU7PM2M2c7jmLpjjClpFecwVXUALWo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315755869"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315755869"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="506757106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2022 09:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 55B163F9; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 04/11] spi: pxa2xx-pci: Move port_id assignment to ->setup()
Date:   Fri, 25 Feb 2022 19:23:43 +0200
Message-Id: <20220225172350.69797-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Instead of using conditional, move port_id to the corresponding
->setup() functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 90b95e49a164..87629da3e544 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -29,7 +29,7 @@ enum {
 
 struct pxa_spi_info {
 	enum pxa_ssp_type type;
-	int port_id;
+	unsigned int port_id;
 	unsigned int num_chipselect;
 	unsigned long max_clk_rate;
 
@@ -116,6 +116,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 
 static int ce4100_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	c->port_id = dev->devfn;
 	c->num_chipselect = dev->devfn;
 	c->max_clk_rate = 3686400;
 
@@ -169,6 +170,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 
 static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	c->port_id = dev->devfn;
 	c->num_chipselect = 1;
 	c->max_clk_rate = 50000000;
 
@@ -178,7 +180,6 @@ static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
-		.port_id =  -1,
 		.setup = ce4100_spi_setup,
 	},
 	[PORT_BYT] = {
@@ -216,7 +217,6 @@ static struct pxa_spi_info spi_info_configs[] = {
 	},
 	[PORT_QUARK_X1000] = {
 		.type = QUARK_X1000_SSP,
-		.port_id = -1,
 		.setup = qrk_spi_setup,
 	},
 	[PORT_LPT0] = {
@@ -271,8 +271,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
-	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;
+	ssp->port_id = c->port_id;
 
 	pci_set_master(dev);
 
-- 
2.34.1

