Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA46595C74
	for <lists+linux-spi@lfdr.de>; Tue, 16 Aug 2022 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiHPM40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Aug 2022 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiHPMzo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Aug 2022 08:55:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0C71BD5
        for <linux-spi@vger.kernel.org>; Tue, 16 Aug 2022 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660654526; x=1692190526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9wljqiEf/G6mcsJtyNXfBB5uhZ0Of/MGJ+jP4FOpPYQ=;
  b=Q7HefnbvTTkuoduKbnHzZ+Uf4cAYuzHKNyiMCR6FudhNDwAmUtw6KSHO
   WvxyTg3F2qX5xFbIy0pvx9dnHW9GrGrBpB6REDnP3Idd+eeQHssz9GmcR
   nyul57LG0x2mvni/p65Q9gDOGYHMkx/DU8wUlOOQfA4m0jV/ps0Tkl9Gg
   Y8xQ4DKl89otYZtEe1kfqUYEQE9mVRpfLr16rpOtyglwnjtnSqa+3r9sF
   /jfA9sY4PGxP1VnauYjlk6ekvilJA3xNTvzYDSqD6Rt6R2MSZfMjMUBV8
   x98dpwh5cpzuikVf09qQ3pv101lB9ko0FANiJ2YNEOsvnJlTrTsANgCiF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="318203200"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="318203200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="667098528"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 05:55:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2AC0E363; Tue, 16 Aug 2022 15:55:37 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: 64k erase is supported from Canon Lake and beyond
Date:   Tue, 16 Aug 2022 15:55:37 +0300
Message-Id: <20220816125537.89389-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The hardware sequencer in Intel Canon Lake and beyond supports also 64k
erase command. The SPI-NOR core uses SFDP (Serial Flash Discovery
Parameter) to figure out what the chip actually supports and only issues
64k erase if it is supported.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 66063687ae27..c020b276e238 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1073,6 +1073,7 @@ static int intel_spi_init(struct intel_spi *ispi)
 		ispi->pregs = ispi->base + CNL_PR;
 		ispi->nregions = CNL_FREG_NUM;
 		ispi->pr_num = CNL_PR_NUM;
+		erase_64k = true;
 		break;
 
 	default:
-- 
2.35.1

