Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95712378ED5
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhEJNcE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:32:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:40943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239859AbhEJMme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:42:34 -0400
IronPort-SDR: /Knf42rxs6dedtsD9DOzJWwKo59rlcQMrBCiECHTRMh4fGBD0gZB/+NUCeaCzt1s32RyJ2VwGU
 SLpdTLUG65pw==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="196090078"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="196090078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:41:23 -0700
IronPort-SDR: Phfeuo6XYiUizxOp3MkKZ0WCHLSS+7svpwaRHf+CR8L8RfBK8thLQd21dGZqfq3wZXtSODCEsf
 R6Sl/SGsTuYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="609085438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2021 05:41:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 947FE501; Mon, 10 May 2021 15:41:37 +0300 (EEST)
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
Subject: [PATCH v3 06/14] spi: pxa2xx: Group Intel Quark specific definitions
Date:   Mon, 10 May 2021 15:41:26 +0300
Message-Id: <20210510124134.24638-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DDS_RATE is Intel Quark specific definition. Move it to the rest
Intel Quark related.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 14b049840faf..1b6c1a0922bd 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
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

