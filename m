Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31F561350
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiF3Hdh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiF3Hdc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 03:33:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457C1A3B8
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656574409; x=1688110409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qxKAxCe9Rmdwb4xlBGcVT0Ckla5HX0aM31Gk5bkMexQ=;
  b=lBP08ExJIvMxxWJ6qMVSQwohXV5GhhRMsZ/0wEjN6VXpVgQykrN2yfgT
   qZYjVlVZ2O7m3a2d3GqhH17ZUXiL2II/Pd/OoKRlYbmWAQ5pDZc6ziSDB
   5ebxhA/zOEUaelb2XbaQyijzmxIDPOoNUJbtFoqJ8wlI4q6vwx73A7KL3
   ntuogbld1M0kIsVWzi0b1EQ0bX/8upUn8g8HS90d92SLEMO8ARZgscvH3
   521bboC0QrYRkWPqlls2c4JRSCV0vchgOx7Lk3aFTCOUlySACSMN4I4Ul
   pPTEKieRP1bSq95uq6A3DEak+c7uSrJfbrMo2ufooNTveW7s6cT8wRc+L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262676651"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="262676651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="658892212"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.55])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2022 00:33:26 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ap Kamal <kamal.ap@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] spi: pxa2xx: Add support for Intel Meteor Lake-P
Date:   Thu, 30 Jun 2022 10:33:05 +0300
Message-Id: <20220630073305.632850-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for LPSS SPI on Intel Meteor Lake-P. It has three
controllers each having two chip selects.

This squashes a fix from Ap, Kamal <kamal.ap@intel.com> fixing incorrect
PCI ID of 3rd controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: Removed PCH from the subject and commit log since Meteor Lake -P doesn't
have a PCH die. Thanks to Andy Shevchenko for noticing. His Reviewed-by
added.
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index edb42d08857d..838d12e65144 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1404,6 +1404,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x7aab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x7af9), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x7afb), LPSS_CNL_SSP },
+	/* MTL-P */
+	{ PCI_VDEVICE(INTEL, 0x7e27), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7e30), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7e46), LPSS_CNL_SSP },
 	/* CNL-LP */
 	{ PCI_VDEVICE(INTEL, 0x9daa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x9dab), LPSS_CNL_SSP },
-- 
2.35.1

