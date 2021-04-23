Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC611369958
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbhDWSZJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:3219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243471AbhDWSZI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:08 -0400
IronPort-SDR: NIlvK3agrtx+kb+IKQxuFHFiSmZ1nMmcv8Fd4CkzDGM7aDL5IJRhjQ3hKKC8yIC06XbuEkkdQy
 /pTq+/c39xLg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196224389"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="196224389"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:29 -0700
IronPort-SDR: /2YeD8bvSJ83Lc78E/vTHcFFeQjHt0sSD6U1jTeXnsZytf2DTGs3SfNHLhkP0Jdcl85iv1NlpY
 Nx1gsNPC69ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="614792175"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2021 11:24:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D222411E; Fri, 23 Apr 2021 21:24:44 +0300 (EEST)
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
Subject: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Date:   Fri, 23 Apr 2021 21:24:27 +0300
Message-Id: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set of cleanups here and there related to the SPI PXA2xx driver.
On top of them, adding the special type for Intel Merrifield.

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

