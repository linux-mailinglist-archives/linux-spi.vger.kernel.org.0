Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368037A92D
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhEKO2C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:28:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:45472 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231305AbhEKO2C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:28:02 -0400
IronPort-SDR: hlje2w2MOfuUlsrIaihSbJT9iRc5NAQsFB0vt/p0HhjhZN9pdBF+qlMwclwBk+G8lAZycdLTIT
 uF4bF05ZOQYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186894771"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186894771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:26:55 -0700
IronPort-SDR: XW+NcED4qTFOB/IBnZCqXZFhli+dJOuN8su+/RFqCtkejCR5hm1hClhEoUgdqAxlwDoc7zo1pL
 fYu4uDAa/8tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="392319995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2021 07:26:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D3A06249; Tue, 11 May 2021 17:27:12 +0300 (EEST)
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
Subject: [PATCH v4 0/8] spi: pxa2xx: Set of cleanups (part 1+)
Date:   Tue, 11 May 2021 17:27:03 +0300
Message-Id: <20210511142711.23244-1-andriy.shevchenko@linux.intel.com>
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
  spi: pxa2xx: Introduce int_stop_and_reset() helper
  spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
  spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
  spi: pxa2xx: Extract pxa2xx_spi_update() helper
  spi: pxa2xx: Extract clear_SSCR1_bits() helper
  spi: pxa2xx: Extract read_SSSR_bits() helper
  spi: pxa2xx: Constify struct driver_data parameter
  spi: pxa2xx: Introduce special type for Merrifield SPIs

 drivers/spi/spi-pxa2xx-dma.c |  17 +---
 drivers/spi/spi-pxa2xx-pci.c |   2 +-
 drivers/spi/spi-pxa2xx.c     | 171 ++++++++++++++++++-----------------
 drivers/spi/spi-pxa2xx.h     |  16 +++-
 include/linux/pxa2xx_ssp.h   |  32 +++++++
 sound/soc/pxa/pxa-ssp.c      |  16 ----
 6 files changed, 140 insertions(+), 114 deletions(-)

-- 
2.30.2

