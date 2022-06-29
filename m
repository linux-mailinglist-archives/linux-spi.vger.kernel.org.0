Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F6255FF37
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiF2MHH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiF2MHH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 08:07:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA837021
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656504425; x=1688040425;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWkQdAH3/vAEzwnHDG0O6heHzVv0U+QMPWPQG2cHuuU=;
  b=GeqHIC763lYGm7qFp+VGfdmALoHXFdJJ1am1C1gNm5SzfMMkqhqTf1wj
   6nx0CMXCert5KT6vbJvwHOwBYoj9U809kDJlWphn8xOULkOvhEb9SGS6R
   I8LESg/oLNODVHkojAPPNjXHf/+IQLl7uI3E33ZSSEzH9iLfR6Idwz8zu
   WfziCeBqd4h1kISmFttRiXBq7ZATcIE9Xrwx7JXxdygg1uXyO+p+kvJHL
   ShtyFdhnJQpH6LNNkg0ySzf3n4VTVTN/mrLq+4ERm30GKxMJli8RAvtWb
   8DjdMmsM7sYsLxiWrrqGOKCFC9Ac7xf3AQ+/CU9fCNvWj4iTK4YXgirMK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280776025"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="280776025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 05:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="588287112"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.55])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 05:07:03 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ap Kamal <kamal.ap@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Meteor Lake PCH-P
Date:   Wed, 29 Jun 2022 15:07:00 +0300
Message-Id: <20220629120700.620108-1-jarkko.nikula@linux.intel.com>
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

Add support for LPSS SPI on Intel Meteor Lake PCH-P. It has three
controllers each having two chip selects.

This squashes a fix from Ap, Kamal <kamal.ap@intel.com> fixing incorrect
PCI ID of 3rd controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
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

