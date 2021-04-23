Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC7369965
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhDWSZP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:21993 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243674AbhDWSZN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:13 -0400
IronPort-SDR: X6I7aK88DYXmDe7fnGbYYgZGs5o+0Q54FOw2TTMVxIxosF78daDe8juSeBSM1aTHWvy0xb+AA4
 WwjuV6w0QAPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="176235448"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="176235448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:35 -0700
IronPort-SDR: K+Ohwyal4vLPysBF+JXiSnKwxawXm7ER12OO+6qABeyBGkjaK9LOxUS033d8ElzxRHLwyVMWqS
 Av6cUYJSDcMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="402266299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2021 11:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7EAA4C0A; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
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
Subject: [PATCH v2 13/14] spi: pxa2xx: Constify struct driver_data parameter
Date:   Fri, 23 Apr 2021 21:24:40 +0300
Message-Id: <20210423182441.50272-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In a couple of functions the contents of struct driver_data are not altered,
hence we may constify the respective function parameter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index d2cb40f97c4b..5c6a5e0f249e 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -93,7 +93,7 @@ static inline void pxa2xx_spi_write(const struct driver_data *drv_data, u32 reg,
 
 #define DMA_ALIGNMENT		8
 
-static inline int pxa25x_ssp_comp(struct driver_data *drv_data)
+static inline int pxa25x_ssp_comp(const struct driver_data *drv_data)
 {
 	switch (drv_data->ssp_type) {
 	case PXA25x_SSP:
@@ -115,7 +115,7 @@ static inline u32 read_SSSR_bits(const struct driver_data *drv_data, u32 bits)
 	return pxa2xx_spi_read(drv_data, SSSR) & bits;
 }
 
-static inline void write_SSSR_CS(struct driver_data *drv_data, u32 val)
+static inline void write_SSSR_CS(const struct driver_data *drv_data, u32 val)
 {
 	if (drv_data->ssp_type == CE4100_SSP ||
 	    drv_data->ssp_type == QUARK_X1000_SSP)
-- 
2.30.2

