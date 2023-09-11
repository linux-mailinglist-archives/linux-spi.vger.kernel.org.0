Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743379A4EC
	for <lists+linux-spi@lfdr.de>; Mon, 11 Sep 2023 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjIKHsR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Sep 2023 03:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjIKHsN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Sep 2023 03:48:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968B1FED
        for <linux-spi@vger.kernel.org>; Mon, 11 Sep 2023 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694418461; x=1725954461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CK/JoiKSJRYoOTxgi3KExnk7KPAnFhOgvUreujLOLuA=;
  b=nt0pJn0cNpGRdvVlBqh4t8m3OW7stkk7bDLJDcj4PZzcK4oe9vEOZ2Xd
   WQdNh0ItX2iFJGWUMb+QH0E5fv2s/MAHmnGu6LN5mAPxJSRkq6m/ucQZo
   7INy0IDgWQQzjzZKhPcxWEe5zktia16vKQJgjWqVsbhmG9YjI2yRK66Sa
   N5ojVTt0+TEy9o7uU+5dLHGuhFPXcbbAhNbxDt/oAa0a7eKxfQlzp09oZ
   +pa1DR+rJJdj10sdGy60ERjI/BsyaoVWJpdG5f6Ltvy0gv29ysFwdPtdY
   TeGmjGnEHibWshGXojQxG5OWOz1vmALkL17JaBoXXz/7/oj372WKymzJ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358320355"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358320355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916937160"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916937160"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 00:46:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B3F47516; Mon, 11 Sep 2023 10:46:16 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel-pci: Add support for Granite Rapids SPI serial flash
Date:   Mon, 11 Sep 2023 10:46:16 +0300
Message-Id: <20230911074616.3473347-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

Intel Granite Rapids has a flash controller that is compatible with the
other Cannon Lake derivatives. Add Granite Rapids PCI ID to the driver
list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 87de0e3eb451..e50bea1076b8 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -72,6 +72,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-- 
2.40.1

