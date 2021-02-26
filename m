Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C163263A0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBZOCd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 09:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZOCb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 09:02:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7876F64EC4;
        Fri, 26 Feb 2021 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614348110;
        bh=CdhaZ+gptekojCnIxLj0qCtsG+fp7Fb4kfokZslzO18=;
        h=From:To:Cc:Subject:Date:From;
        b=Y/RQ4yiSx6y29mXvp33Syj0RSBQSQKaKZLHBl1BqaEbrt/5kkBNk/5nA7Sz5LXBrY
         arQflDHpYOqTDzKYXaPebQzC/0lizbDvMu8EL85u1BGC7Wg+3G9/BcLSSPhecejCiK
         al67NyEoo3NfX6w9YsDi6zDO8zCsFIo+2bpuVfwM29Sx0vOjAZxuuQ3uybkTJ/lNMO
         Z+8U1VqG7S81of9bZRldYAxYSGrJfmhEHF4VaOAF9sOd2CqU8HgTGn9QQG1WH+Rdp8
         XeLcsKQn+7W1vLVqmr/eDI7ay9S2dzvM/2Wzn0qouKaqsjgu07ySjTc+rmVsvlZnyg
         mt17okwc0rdUA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jon Lin <jon.lin@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] spi: rockchip: avoid objtool warning
Date:   Fri, 26 Feb 2021 15:00:48 +0100
Message-Id: <20210226140109.3477093-1-arnd@kernel.org>
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

Change the unreachable() into an error return that can be
handled if it ever happens, rather than silently crashing
the kernel.

Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use 'return' instead of 'BUG()'
---
 drivers/spi/spi-rockchip.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 936ef54e0903..0d75080da648 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -476,7 +476,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	return 1;
 }
 
-static void rockchip_spi_config(struct rockchip_spi *rs,
+static int rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma, bool slave_mode)
 {
@@ -521,7 +521,9 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		 * ctlr->bits_per_word_mask, so this shouldn't
 		 * happen
 		 */
-		unreachable();
+		dev_err(rs->dev, "unknown bits per word: %d\n",
+			xfer->bits_per_word);
+		return -EINVAL;
 	}
 
 	if (use_dma) {
@@ -554,6 +556,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	 */
 	writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
 			rs->regs + ROCKCHIP_SPI_BAUDR);
+
+	return 0;
 }
 
 static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
@@ -577,6 +581,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
+	int ret;
 	bool use_dma;
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -596,7 +601,9 @@ static int rockchip_spi_transfer_one(
 
 	use_dma = ctlr->can_dma ? ctlr->can_dma(ctlr, spi, xfer) : false;
 
-	rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
+	ret = rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
+	if (ret)
+		return ret;
 
 	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, ctlr, xfer);
-- 
2.29.2

