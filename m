Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07F1FFFDF
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 03:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgFSBsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 21:48:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:64031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730721AbgFSBsK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 21:48:10 -0400
IronPort-SDR: +vDIEhDAY+/5FQ0zpCSS3R6wydWp6mKp4DkBZoOxawngmkRxMfO4WAZHLOW579rXklZo9jQwZW
 tyzLIMcLxe/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204278285"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="204278285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:48:08 -0700
IronPort-SDR: NSGholFvFMBmxixUb0YMHh6vRYAvcj7n7nvTlfvsWuaIUWJQ0N7eEVbDP9oO0rcrR0fLWkqv80
 5MrEQcqqDRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="263746077"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 18:48:04 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [RESEND PATCH v2 3/3] spi: altera: fix size mismatch on 64 bit processors
Date:   Fri, 19 Jun 2020 09:43:41 +0800
Message-Id: <1592531021-11412-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
References: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

The spi-altera driver was originally written with a 32
bit processor, where sizeof(unsigned long) is 4.  On a
64 bit processor sizeof(unsigned long) is 8.  Change the structure
member to u32 to match the actual size of the control
register.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by : Tom Rix <trix@redhat.com>
---
 drivers/spi/spi-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 4f7717f..d91c093 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -53,7 +53,7 @@ struct altera_spi {
 	int len;
 	int count;
 	int bytes_per_word;
-	unsigned long imr;
+	u32 imr;
 
 	/* data buffers */
 	const unsigned char *tx;
-- 
2.7.4

