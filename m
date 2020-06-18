Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A131FF6C1
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgFRP3U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:29:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:21448 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbgFRP3T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:29:19 -0400
IronPort-SDR: CuzmyOyS3Y5rgZeHmw7frbvneJr6+utML8JXsId+BcUBN4vMifGtS4SIfhDVPgPp0S9QuqRVbz
 eAjRIURW5tcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="140137430"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="140137430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:29:19 -0700
IronPort-SDR: MB/EgPENA8SUxNDBoEdU5Zjd6gHeD8s7KkZGR5+SRpdqnz37cQGJVLZ07mnZiXfRL6IbjJTkws
 2+JFxk3utd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="450675797"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 08:29:16 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH v2 6/6] spi: altera: fix size mismatch on 64 bit processors
Date:   Thu, 18 Jun 2020 23:25:10 +0800
Message-Id: <1592493910-30473-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
References: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
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

