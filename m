Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116C6D16CE
	for <lists+linux-spi@lfdr.de>; Fri, 31 Mar 2023 07:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCaFbD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Mar 2023 01:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCaFbC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Mar 2023 01:31:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A712CD9
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680240655; x=1711776655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vs2j2b+1Lyd4lcO/SMjCCRC5Hzw3rFlGTHa2dfVZhPI=;
  b=hVYCf4F7d+W5KLKmknmHKn5q6+Hbm7ki+s4hCtXLtdk/WUlzmLoPLHOL
   qsoPBqJVv2TARXlgWzSMzYjlrYE1W9pUhpLj6sqQb55XMSNB1Doaap70m
   ZWJZBAUutb2BPH4xdr6szrDiOT9Q95mt6bc1+oNvmpup6NLtJsCeTmOIR
   mtS5aYnVSaE5uUgZvsGYNGwjTqlpBIT/+/10Gnz3tPilZx1j4PhrknQkB
   fi8IV4+5Dn40QDs2mUuFoPJ20x5VSi7moR9iHDWYh3IRg2W3vam1B8sQU
   nKNXmCkwF0QO+L8rg/82vF+OKp7IHJzXD8PU7CgXbIkZt38M1NXLegUS9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="341375963"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="341375963"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 22:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="749491380"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="749491380"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 22:30:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 32B1E101; Fri, 31 Mar 2023 08:28:12 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel-pci: Add support for Meteor Lake-S SPI serial flash
Date:   Fri, 31 Mar 2023 08:28:12 +0300
Message-Id: <20230331052812.39983-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Meteor Lake-S has the same SPI serial flash controller as Meteor
Lake-P. Add Meteor Lake-S PCI ID to the driver list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 00b140903e4e..87de0e3eb451 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -83,6 +83,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xae23), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.39.2

