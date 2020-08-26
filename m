Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D8253344
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZPPU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 11:15:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:15853 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHZPPT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:19 -0400
IronPort-SDR: DyNcF8e7wF+xiRkVbOLZFCoSbmJsQ8ePLuIlXjh7xRQU9SKzDSb5+rOVfAioo97DyYFrl125UE
 rZGEbgWG4yMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="143972282"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="143972282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:15:17 -0700
IronPort-SDR: iwTwOug2FXRV4ROF8hFgNweUYHe/OpGZ/FEU+O2RV4uWfPzid3Fx/k0ANKI1pOc2ESDymBYLG+
 OSCzQ0VzCk1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="281820893"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2020 08:15:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6DE61B4; Wed, 26 Aug 2020 18:14:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] spi: pxa2xx: Drop useless comment in the pxa2xx_ssp.h
Date:   Wed, 26 Aug 2020 18:14:55 +0300
Message-Id: <20200826151455.55970-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
References: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

No need to have file name inside file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 223a4673f0c8..663e86653884 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  pxa2xx_ssp.h
- *
  *  Copyright (C) 2003 Russell King, All Rights Reserved.
  *
  * This driver supports the following PXA CPU/SSP ports:-
-- 
2.28.0

