Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62560C3CC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJYG1n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJYG1m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:27:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC19109D6F
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666679261; x=1698215261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gP7BkeNBDN8b+WUOHQ/WDZLeGpVMxeBq8D/W43ikivU=;
  b=KZnzfMse4disIxp/r514hOyNd854Gwj1sgY5VF9L1XM1vQMlL4TQDWzE
   XmXs5rETsDB1REpuCtd9JhEWqb3xacU7M/j3RnKZrVvC5Dx2v9jWM7T5m
   Vsc8zsvwDhBGGB78k4b6XBNL+LsJDxCwHz2xD2397EAF/uyCOTc122XBx
   7DClY67t8dvtXDfSUIl7hS8FD9xUvF88rO7hnWUmDlgY0RYNc8KPRNIsT
   6FA2th3+/QqhyHZACBrRUUz1gwBkdUDJBWnymEbW0Od1Bb/ULP0KULduQ
   rgHHOE8PLglMYkk0MQF1ACjEWZdIgJH2YbQ9BmnxwZVl5YHXxAqgkOwNU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309286829"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="309286829"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="774082888"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="774082888"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2022 23:27:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4CACD107; Tue, 25 Oct 2022 09:28:00 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Use correct mask for flash and protected regions
Date:   Tue, 25 Oct 2022 09:28:00 +0300
Message-Id: <20221025062800.22357-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The flash and protected region mask is actually 0x7fff (30:16 and 14:0)
and not 0x3fff so fix this accordingly. While there use GENMASK() instead.

Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 55f4ee2db002..acd8ec4f86a7 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -52,17 +52,17 @@
 #define FRACC				0x50
 
 #define FREG(n)				(0x54 + ((n) * 4))
-#define FREG_BASE_MASK			0x3fff
+#define FREG_BASE_MASK			GENMASK(14, 0)
 #define FREG_LIMIT_SHIFT		16
-#define FREG_LIMIT_MASK			(0x03fff << FREG_LIMIT_SHIFT)
+#define FREG_LIMIT_MASK			GENMASK(30, 16)
 
 /* Offset is from @ispi->pregs */
 #define PR(n)				((n) * 4)
 #define PR_WPE				BIT(31)
 #define PR_LIMIT_SHIFT			16
-#define PR_LIMIT_MASK			(0x3fff << PR_LIMIT_SHIFT)
+#define PR_LIMIT_MASK			GENMASK(30, 16)
 #define PR_RPE				BIT(15)
-#define PR_BASE_MASK			0x3fff
+#define PR_BASE_MASK			GENMASK(14, 0)
 
 /* Offsets are from @ispi->sregs */
 #define SSFSTS_CTL			0x00
-- 
2.35.1

