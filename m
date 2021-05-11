Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD337A8D7
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhEKOS2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:18:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:64437 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhEKOSX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:18:23 -0400
IronPort-SDR: cKgeaIoTcwWxi+9eJfknTPM0wfFU6UsT8sWSbWhs4QmD3o2cvtXWIr+y1yt+K4q/WlHFfnUyHK
 0N+JLdmMRi+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="263383157"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263383157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:17:13 -0700
IronPort-SDR: PnubEKBfAite/AY61Xjd81s74ay1vk8qVdTt6O69QGJiAFF6zcHk0Zq471QVSXYlxo+6LSfu2b
 +2H3peMnVqkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="468925143"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 May 2021 07:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 876D8436; Tue, 11 May 2021 17:17:27 +0300 (EEST)
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
Subject: [PATCH v3 6/8] spi: pxa2xx: Constify struct driver_data parameter
Date:   Tue, 11 May 2021 17:17:23 +0300
Message-Id: <20210511141725.32097-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
References: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
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

