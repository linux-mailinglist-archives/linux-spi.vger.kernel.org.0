Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5B378EE3
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhEJNcO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:32:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:31643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239843AbhEJMme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:42:34 -0400
IronPort-SDR: thlt/mWZjXb5OWzMfe0YwQaxdxQn+7G8fAp0AM16gY14rPkDNsrhfPGafbCrBgYJTebI6FiUiE
 ZzaznKxT9dZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263114672"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263114672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:41:20 -0700
IronPort-SDR: 5nN/+7mM/gojnHt//gtw2ISyE1hf0GSBEA0Igq5eujV0QPHMd1F9Pmq4FrvuZI5TRp33lU1ioh
 udxzIQuO6WXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="536401736"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2021 05:41:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1917FD7; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 00/14] spi: pxa2xx: Set of cleanups
Date:   Mon, 10 May 2021 15:41:20 +0300
Message-Id: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set of cleanups here and there related to the SPI PXA2xx driver.
On top of them, adding the special type for Intel Merrifield.

In v3:
- rebased on top of v5.13-rc1 and/or spi/for-5,14

In v2:
- cover letter (Mark)
- drop moving the header in patch 5 (Mark)

Andy Shevchenko (14):
  spi: pxa2xx: Use one point of return when ->probe() fails
  spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
  spi: pxa2xx: Utilize struct device from struct ssp_device
  spi: pxa2xx: Replace header inclusions by forward declarations
  spi: pxa2xx: Unify ifdeffery used in the headers
  spi: pxa2xx: Group Intel Quark specific definitions
  spi: pxa2xx: Introduce int_stop_and_reset() helper
  spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
  spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
  spi: pxa2xx: Extract pxa2xx_spi_update() helper
  spi: pxa2xx: Extract clear_SSCR1_bits() helper
  spi: pxa2xx: Extract read_SSSR_bits() helper
  spi: pxa2xx: Constify struct driver_data parameter
  spi: pxa2xx: Introduce special type for Merrifield SPIs

 drivers/spi/spi-pxa2xx-dma.c   |  37 +++----
 drivers/spi/spi-pxa2xx-pci.c   |   4 +-
 drivers/spi/spi-pxa2xx.c       | 190 +++++++++++++++++----------------
 drivers/spi/spi-pxa2xx.h       |  52 ++++-----
 include/linux/pxa2xx_ssp.h     |  42 +++++++-
 include/linux/spi/pxa2xx_spi.h |   9 +-
 sound/soc/pxa/pxa-ssp.c        |  16 ---
 7 files changed, 185 insertions(+), 165 deletions(-)

-- 
2.30.2

