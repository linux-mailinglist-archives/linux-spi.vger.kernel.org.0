Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECC382E30
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhEQOE5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:04:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:59397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237714AbhEQOEw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:52 -0400
IronPort-SDR: u2VuDNGrp1M6MmVivvqbpy/vNL/GegOwr3dtSZiILR5j/lWKVBhmPsBswGaJwKpGys8KcbE33O
 HEqW1U6vUJ4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197388007"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="197388007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:35 -0700
IronPort-SDR: RJt6zWbABF28U6UFftum2C31sA7JYRrBO+H2vG79UILgLL8RBFB2TBZyawXxV+SHzCAtLlE1NE
 NOLfqYvFDMkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="629996774"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2021 07:03:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 013A0348; Mon, 17 May 2021 17:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 0/9] spi: pxa2xx: Convert to use SPI core GPIO handling
Date:   Mon, 17 May 2021 17:03:42 +0300
Message-Id: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the PXA2xx SPI host controller driver to use SPI core GPIO handling.
On top of that a few additional cleanups.

Has been tested on Intel Merrifield with SPI ADC and TFT display connected.

Andy Shevchenko (9):
  spi: pxa2xx: Propagate firmware node to the child SPI controller
    device
  spi: pxa2xx: Switch to use SPI core GPIO (descriptor) CS handling
  spi: pxa2xx: Switch to use SPI core GPIO (legacy) CS handling
  spi: pxa2xx: Drop duplicate chip_select in struct chip_data
  spi: pxa2xx: Drop unneeded '!= 0' comparisons
  spi: pxa2xx: Fix printf() specifiers
  spi: pxa2xx: Fix style of and typos in the comments and messages
  spi: pxa2xx: Update documentation to point out that it's outdated
  spi: pxa2xx: Use predefined mask when programming FIFO thresholds

 Documentation/spi/pxa2xx.rst   |  58 +++++-----
 drivers/spi/spi-pxa2xx-dma.c   |   4 +-
 drivers/spi/spi-pxa2xx-pci.c   |   5 +-
 drivers/spi/spi-pxa2xx.c       | 203 +++++++++++++--------------------
 drivers/spi/spi-pxa2xx.h       |  16 +--
 include/linux/pxa2xx_ssp.h     |   9 +-
 include/linux/spi/pxa2xx_spi.h |  12 +-
 7 files changed, 135 insertions(+), 172 deletions(-)

-- 
2.30.2

