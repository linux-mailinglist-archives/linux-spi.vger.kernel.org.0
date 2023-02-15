Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D126697A59
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOLAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 06:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBOLAD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 06:00:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE139728B
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 03:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676458802; x=1707994802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cf8b+iDfRofdtn0yJ2mtRL2M9+DLI6A9yuJaHJdBefU=;
  b=TAMqWRGgC7AUR1Ld+TFSU5V5YZQQKyX+wJpcu1o6mc9WeUoEQi6hxz62
   cDRH1Vvnt1L0ZBt/4imuNU1VoA0c/Z8PpdGYGR06NduHIC60gJad7LTyV
   ea+2pnwzMG4vIunk94klacN/MzKI87B+WPK3quSwLYc1QjLn1dV88yX1k
   UAm/GF6jrJRgY94UQUGBa/YRKwF9h5frWkZr2vBwlMq1PvbsQFEAEhQ1r
   +xHX92zicgHRky6BavY5RsG1UsnR/DIDdAZKQ2SOJGoIIQCTjzizy4YTx
   NRNkv3KS0QZsD3NN8KmtGfUfZzbTrlQU2RCzS2tIeip2ULk39Q5Q6V3WZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329117970"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="329117970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 03:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="699919159"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="699919159"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2023 03:00:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D50CD1A6; Wed, 15 Feb 2023 13:00:40 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marcin Witkowski <marcin.witkowski@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Check number of chip selects after reading the descriptor
Date:   Wed, 15 Feb 2023 13:00:40 +0200
Message-Id: <20230215110040.42186-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The flash decriptor contains the number of flash components that we use
to figure out how many flash chips there are connected. Therefore we
need to read it first before deciding how many chip selects the
controller has.

Reported-by: Marcin Witkowski <marcin.witkowski@intel.com>
Fixes: 3f03c618bebb ("spi: intel: Add support for second flash chip")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index f619212b0d5c..627287925fed 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1368,14 +1368,14 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	if (!spi_new_device(ispi->master, &chip))
 		return -ENODEV;
 
-	/* Add the second chip if present */
-	if (ispi->master->num_chipselect < 2)
-		return 0;
-
 	ret = intel_spi_read_desc(ispi);
 	if (ret)
 		return ret;
 
+	/* Add the second chip if present */
+	if (ispi->master->num_chipselect < 2)
+		return 0;
+
 	chip.platform_data = NULL;
 	chip.chip_select = 1;
 
-- 
2.39.1

