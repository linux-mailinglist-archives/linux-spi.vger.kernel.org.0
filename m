Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6781F607C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKD3J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:29:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgFKD3I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:29:08 -0400
IronPort-SDR: ZWDpdSknHbxqDI7aLn+4+zzEgJ+vZcTvxnGyjhWnVWjpDAWROW7SZ9hhs4H/hhc7YlgWummARJ
 RgF84sOHtqrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:29:07 -0700
IronPort-SDR: 0xIDsRmuAh38Yby2221681XR9lDiTqZds7eKuxn82WkXUSBsqmlnfU2185dpjck2t1Hn+lZAXx
 d2T0wY+eX3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587405"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:29:05 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 6/6] spi: altera: fix size mismatch on 64 bit processors
Date:   Thu, 11 Jun 2020 11:25:11 +0800
Message-Id: <1591845911-10197-7-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
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
---
 drivers/spi/spi-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 2c12c7a..468fbd5 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -46,7 +46,7 @@ struct altera_spi {
 	int len;
 	int count;
 	int bytes_per_word;
-	unsigned long imr;
+	u32 imr;
 
 	/* data buffers */
 	const unsigned char *tx;
-- 
2.7.4

