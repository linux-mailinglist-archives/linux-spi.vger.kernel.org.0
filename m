Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2506378F25
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhEJNdx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:34989 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352120AbhEJNN6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:58 -0400
IronPort-SDR: HtnkK7LbJBGzf63nhO/iCFDRdoCAO/BXDBKECdWXdByop90yIthV3kf3xRciFFOgIoMIcVLs/H
 oK8ah2VbcQqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260455820"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="260455820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:12:32 -0700
IronPort-SDR: hRB4ZCKBdaL3C9TD93BXQ9WFVkZiNyvKATq+mH5eXyyeB6ULOaC/NOHhBr8/sm214wWgrYJc7k
 sFDzJ6oFDM/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="470793157"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 06:12:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B813D7; Mon, 10 May 2021 16:12:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Switch to signed types for *_native_cs SPI controller fields
Date:   Mon, 10 May 2021 16:12:42 +0300
Message-Id: <20210510131242.49455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

While fixing undefined behaviour the commit f60d7270c8a3 ("spi: Avoid
undefined behaviour when counting unused native CSs") missed the case
when all CSs are GPIOs and thus unused_native_cs will be evaluated to
-1 in unsigned representation. This will falsely trigger a condition
in the spi_get_gpio_descs().

Switch to signed types for *_native_cs SPI controller fields to fix above.

Fixes: f60d7270c8a3 ("spi: Avoid undefined behaviour when counting unused native CSs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 360a3bc767ca..74239d65c7fd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -644,8 +644,8 @@ struct spi_controller {
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
-	u8			unused_native_cs;
-	u8			max_native_cs;
+	s8			unused_native_cs;
+	s8			max_native_cs;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
2.30.2

