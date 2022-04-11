Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868B04FBAF5
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiDKLeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbiDKLeQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 07:34:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B745783
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676722; x=1681212722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+tDJ2OKrRtfXTUVjXpUksDaCFN9DSpKkw2XjLuA95J0=;
  b=b+ixX79x6MQE31TbAyoZ8nM9KUanlncZ8DJAZu/7Hs2G8kanFqxItapA
   7xwuTHgnM1ZxAAljMJdtNu6try+w+Lj5pl71rUMLbNaNDbyvhY1PDRUDB
   vBIrt7ebzmKJ+1pbklVQ17mMl+8kUTuMx2YczP+PCN8e7vB91eY2GnpbJ
   Ef5sAOhfHMD5VHL731VZOBDIJlFFubWcZl4lg+ZyOoUlNPRZ60ICAhpua
   s3hPekzr61delsKwVsffM7aAj77NT+4oHS1Owd04kA/6CoFe80kC3paVt
   t02wxSLgnIchML2MMoeneDFOSrHq6lTDpZk/fTM7nRylF3vA2qUtCSSVf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="259689227"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="259689227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="507073731"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 04:31:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7891618E; Mon, 11 Apr 2022 14:31:58 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Hongli Li <hongli.li@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] spi: intel: Fix typo in kernel-doc of intel_spi_probe()
Date:   Mon, 11 Apr 2022 14:31:57 +0300
Message-Id: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Should be 'specific' not 'spefific'. Fix this.

Reported-by: Hongli Li <hongli.li@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index e937cfe85559..1bdb227e0ca2 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1205,7 +1205,7 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
  * intel_spi_probe() - Probe the Intel SPI flash controller
  * @dev: Pointer to the parent device
  * @mem: MMIO resource
- * @info: Platform spefific information
+ * @info: Platform specific information
  *
  * Probes Intel SPI flash controller and creates the flash chip device.
  * Returns %0 on success and negative errno in case of failure.
-- 
2.35.1

