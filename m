Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631B325008
	for <lists+linux-spi@lfdr.de>; Thu, 25 Feb 2021 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhBYM4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Feb 2021 07:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhBYM43 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Feb 2021 07:56:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F205D64EC4;
        Thu, 25 Feb 2021 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614257749;
        bh=IM56HS2jcyC+tX7uO3Kx0IQACMvoulpcQ1kwIFss1Y8=;
        h=From:To:Cc:Subject:Date:From;
        b=VpA+Es3n8RVmv0k82sr68P/4h+o3X4PL1A+BU84Xdyo5ko5VC6ohN684iY0y6JJ2z
         nLYOHtZMY080H6NcG/HMefO6FutpQbYYxGYlL9O0AHNQDLZ9mBO+kyQhtGR5hdLHtM
         Z80JHWc5Lx9q4tJM+a1w/tmRnLszXABEgzAzsHxiXZSxpByZetnCAc/LonKrDpOlHY
         X+ykl7KoOHzyQ8iZEIHNfTXcxKzglPRZs7FRkssvsgJY5pnz1FMh/ettZeR/PWlp/h
         Q9g2VjL8p4CkDob8nQCZAij1kglqPYFRiLYZA2PqOTECIkfgXlZz93IivQyzARXmms
         4vtFHrDg6mL4w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] spi: rockchip: avoid objtool warning
Date:   Thu, 25 Feb 2021 13:55:34 +0100
Message-Id: <20210225125541.1808719-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building this file with clang leads to a an unreachable code path
causing a warning from objtool:

drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame

Use BUG() instead of unreachable() to avoid the undefined behavior
if it does happen.

Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 936ef54e0903..972beac1169a 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		 * ctlr->bits_per_word_mask, so this shouldn't
 		 * happen
 		 */
-		unreachable();
+		BUG();
 	}
 
 	if (use_dma) {
-- 
2.29.2

