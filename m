Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4918DC65
	for <lists+linux-spi@lfdr.de>; Sat, 21 Mar 2020 01:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCUAM4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 20:12:56 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.71]:32317 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgCUAM4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 20:12:56 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 20:12:55 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 331724849
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2020 18:25:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FR0vjhM5uSl8qFR0vjFlCf; Fri, 20 Mar 2020 18:25:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tp+We5q+QfjK/lqlPn+mWwyn+mIaqLI3anJr08yNMA0=; b=UIXKck/TEIYQC4tKigmWFuF3gj
        8UjwPJlbXjYmCBWPR2iFwvbyigdrAAAeK4eqdWsmOBN/+/S51z8AFg7v0vgQHmy/CZUJlCmmVN0yg
        DeqqlJanPSpIN0RJrZp3s//jMxJk8dgaqD52kQma73EpsCr6fu7iqq6MhA3U1UxmaHi/pwbPB3+6x
        b/ldkgHliw2QdF4g2stz07QCXoRj6T6CeAvEiUDcaXFKvShi6ZNPbZLRZEP7x6mh8DrNdPcMrC84z
        oGAM/wdMhveg12QAbI9zOzXwIfifZEAmwBImCfqFP7Ljj84jI9DMW2C8e6sgXnLN/35zIhH0jwy2g
        8woQYVlw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53616 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jFR0t-001M8o-Nq; Fri, 20 Mar 2020 18:25:15 -0500
Date:   Fri, 20 Mar 2020 18:25:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] spi: spi-fsl-lpspi: Replace zero-length array with
 flexible-array member
Message-ID: <20200320232515.GA24800@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jFR0t-001M8o-Nq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53616
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 298329b781d2..8b41b70f6f5c 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -123,7 +123,7 @@ struct fsl_lpspi_data {
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
 
-	int chipselect[0];
+	int chipselect[];
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
-- 
2.23.0

