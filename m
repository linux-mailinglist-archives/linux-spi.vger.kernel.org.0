Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6313954C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2019 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfFGTKL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jun 2019 15:10:11 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.163]:48340 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbfFGTKK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jun 2019 15:10:10 -0400
X-Greylist: delayed 1281 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 15:10:10 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 30118400CAC73
        for <linux-spi@vger.kernel.org>; Fri,  7 Jun 2019 13:48:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZJuzhapBp90onZJuzhc926; Fri, 07 Jun 2019 13:48:49 -0500
X-Authority-Reason: nr=8
Received: from [189.250.134.24] (port=47344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hZJux-002VU0-Ra; Fri, 07 Jun 2019 13:48:47 -0500
Date:   Fri, 7 Jun 2019 13:48:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: Use struct_size() helper
Message-ID: <20190607184845.GA13401@embeddedor>
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
X-Source-IP: 189.250.134.24
X-Source-L: No
X-Exim-ID: 1hZJux-002VU0-Ra
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.134.24]:47344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct spi_replaced_transfers {
	...
        struct spi_transfer inserted_transfers[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

insert * sizeof(struct spi_transfer) + sizeof(struct spi_replaced_transfers)

with:

struct_size(rxfer, inserted_transfers, insert)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e0cd8ccfe92d..69e492ed414a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2769,8 +2769,7 @@ struct spi_replaced_transfers *spi_replace_transfers(
 
 	/* allocate the structure using spi_res */
 	rxfer = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
-			      insert * sizeof(struct spi_transfer)
-			      + sizeof(struct spi_replaced_transfers)
+			      struct_size(rxfer, inserted_transfers, insert)
 			      + extradatasize,
 			      gfp);
 	if (!rxfer)
-- 
2.21.0

