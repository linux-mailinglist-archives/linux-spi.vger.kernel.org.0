Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD518DC32
	for <lists+linux-spi@lfdr.de>; Sat, 21 Mar 2020 00:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCTXsa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 19:48:30 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.38]:18464 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgCTXsa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 19:48:30 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 19:48:29 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1CB2223CBD9
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2020 18:25:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FR1ajBT7yAGTXFR1ajbDWq; Fri, 20 Mar 2020 18:25:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oVBIDiOUACeEBMEExhB0XWqzRyL5CKRO/6X8VGFTGn4=; b=hALY/WzciDDDeEWFVpB2y/q2ON
        qP3PjjYxkSVl7XQNt2fAJqmA6l5gfpdGSVhs0M5OhSE+Y4xmHJIz3wJuv+Z2MFfk8rp7lllrnNF94
        H3va7Zo1uS7oDtuhFmuzWJW/78RTyLb+RlosCxZlD4cP6oFYKciX7l6i6Usi2bB5NFkLO0u4TtiSF
        nmYDtajvpDOxqPT1fXrrVqwyECAbY0DwK7+Px1o1M4tU83iddHbjKQzBKiaChjc6RtDD4jQBtt7El
        7DMjIv29IrGfrR0qUiv18SjB4PhppIRgecrEdXIfwJ+e00Dai2KbrXTx/h2obe5yzmDTO98ud2hAA
        RQPRjf7Q==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53620 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jFR1Y-001MNY-IF; Fri, 20 Mar 2020 18:25:56 -0500
Date:   Fri, 20 Mar 2020 18:25:56 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] spi: spi-s3c24xx: Replace zero-length array with
 flexible-array member
Message-ID: <20200320232556.GA24989@embeddedor.com>
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
X-Exim-ID: 1jFR1Y-001MNY-IF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53620
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
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
 drivers/spi/spi-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 2d6e37f25e2d..2cb3b611c294 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -227,7 +227,7 @@ static inline unsigned int hw_txbyte(struct s3c24xx_spi *hw, int count)
 struct spi_fiq_code {
 	u32	length;
 	u32	ack_offset;
-	u8	data[0];
+	u8	data[];
 };
 
 extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
-- 
2.23.0

