Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2EC36970D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbhDWQfX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:35:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:26414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243036AbhDWQfX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:35:23 -0400
IronPort-SDR: a6j9msOtpeGls9m3KF6n7+RjXYn57FvLROIFkWFXgf2YgGhE7FUiXXTW91/hTrUdIN2qp9LG1+
 4KrkwVydxw8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183227057"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183227057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:34:46 -0700
IronPort-SDR: 0rIITxXvFXROaqSP6RWWo/LjE3xn3fp/eFwpEp/aBW9WfHbz64VIJD79JZEA5jfotOvOHXV+fK
 Qt3TJgDkZf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="453620727"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2021 09:34:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AE0B1FC; Fri, 23 Apr 2021 19:34:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 06/14] spi: pxa2xx: Group Intel Quark specific definitions
Date:   Fri, 23 Apr 2021 19:34:29 +0300
Message-Id: <20210423163437.89306-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DDS_RATE is Intel Quark specific definition. Move it to the rest
Intel Quark related.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/pxa2xx_ssp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/pxa2xx_ssp.h b/include/linux/spi/pxa2xx_ssp.h
index 14b049840faf..1b6c1a0922bd 100644
--- a/include/linux/spi/pxa2xx_ssp.h
+++ b/include/linux/spi/pxa2xx_ssp.h
@@ -38,7 +38,6 @@ struct device_node;
 #define SSDR		(0x10)  /* SSP Data Write/Data Read Register */
 
 #define SSTO		(0x28)  /* SSP Time Out Register */
-#define DDS_RATE	(0x28)  /* SSP DDS Clock Rate Register (Intel Quark) */
 #define SSPSP		(0x2C)  /* SSP Programmable Serial Protocol */
 #define SSTSA		(0x30)  /* SSP Tx Timeslot Active */
 #define SSRSA		(0x34)  /* SSP Rx Timeslot Active */
@@ -105,6 +104,9 @@ struct device_node;
 #define CE4100_SSCR1_RFT	GENMASK(11, 10)	/* Receive FIFO Threshold (mask) */
 #define CE4100_SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..4] */
 
+/* Intel Quark X1000 */
+#define DDS_RATE		0x28		 /* SSP DDS Clock Rate Register */
+
 /* QUARK_X1000 SSCR0 bit definition */
 #define QUARK_X1000_SSCR0_DSS		GENMASK(4, 0)	/* Data Size Select (mask) */
 #define QUARK_X1000_SSCR0_DataSize(x)	((x) - 1)	/* Data Size Select [4..32] */
-- 
2.30.2

