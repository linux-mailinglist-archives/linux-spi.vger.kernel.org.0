Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B0253340
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHZPO6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 11:14:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:10043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHZPO6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 11:14:58 -0400
IronPort-SDR: wUBHrVn6c+TMDO9boUFN9HrzMO3RdhpklISzTCPVpUmWJsjFBnmy9oOwg6/umCS9YowwVJo1lA
 a+VzK/Jn48VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153731071"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153731071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:14:57 -0700
IronPort-SDR: ui0D5J+YgS8yIrzNWUOxpilBasUvg0PrfL6rZbVptzj+T36P8M0bw+gBtXpS0U2wlCEX2UfFdJ
 4TZRo2OUo+NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="295401175"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2020 08:14:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A694C166; Wed, 26 Aug 2020 18:14:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] spi: pxa2xx: Update header block in pxa2xx_ssp.h
Date:   Wed, 26 Aug 2020 18:14:53 +0300
Message-Id: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have direct users of some headers that are missed and
have header included when forward declarations are enough.

Update header block in pxa2xx_ssp.h to align with actual usage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 6facf27865f9..f139e049e52e 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -16,10 +16,15 @@
 #ifndef __LINUX_SSP_H
 #define __LINUX_SSP_H
 
-#include <linux/list.h>
+#include <linux/compiler_types.h>
 #include <linux/io.h>
-#include <linux/of.h>
+#include <linux/kconfig.h>
+#include <linux/list.h>
+#include <linux/types.h>
 
+struct clk;
+struct device;
+struct device_node;
 
 /*
  * SSP Serial Port Registers
-- 
2.28.0

