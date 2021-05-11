Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054A37A8E0
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhEKOSr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:18:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:26618 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhEKOSk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:18:40 -0400
IronPort-SDR: SbP5atqwA4LBQcTG4p1mK+/qKETFcMmS7Cv3q+dgnQWnmzCCXAdVw2HjrG75XmRADEL0aAeqNm
 dkSspI9r/zkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="284942941"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284942941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:17:10 -0700
IronPort-SDR: kEyNBkIFqeMJtec6hWX8jf1qFI1k0McLtuBKIm6ufMJrwmXAZZoBeZtrSRtJYyznwMutc6EVwg
 L0Ix+Bme+KXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="455031948"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2021 07:17:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5071514B; Tue, 11 May 2021 17:17:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 0/8] spi: pxa2xx: Set of cleanups
Date:   Tue, 11 May 2021 17:17:17 +0300
Message-Id: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set of cleanups here and there related to the SPI PXA2xx driver.
On top of them, adding the special type for Intel Merrifield.

In v4:
- dropped applied patches

In v3:
- rebased on top of v5.13-rc1 and/or spi/for-5,14

In v2:
- cover letter (Mark)
- drop moving the header in patch 5 (Mark)


Andy Shevchenko (8):
  spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
  spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
  spi: pxa2xx: Extract pxa2xx_spi_update() helper
  spi: pxa2xx: Extract clear_SSCR1_bits() helper
  spi: pxa2xx: Extract read_SSSR_bits() helper
  spi: pxa2xx: Constify struct driver_data parameter
  spi: pxa2xx: Introduce special type for Merrifield SPIs
  spi: Convert to use predefined time multipliers

 drivers/spi/spi-pxa2xx-dma.c |  17 ++--
 drivers/spi/spi-pxa2xx-pci.c |   2 +-
 drivers/spi/spi-pxa2xx.c     | 147 ++++++++++++++++++-----------------
 drivers/spi/spi-pxa2xx.h     |  16 +++-
 drivers/spi/spi.c            |  41 ++++++----
 include/linux/pxa2xx_ssp.h   |  32 ++++++++
 sound/soc/pxa/pxa-ssp.c      |  16 ----
 7 files changed, 156 insertions(+), 115 deletions(-)

-- 
2.30.2

