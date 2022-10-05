Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FC5F50D3
	for <lists+linux-spi@lfdr.de>; Wed,  5 Oct 2022 10:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJEIc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Oct 2022 04:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJEIcY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Oct 2022 04:32:24 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940672B58
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 01:32:23 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2958Ag4F056777;
        Wed, 5 Oct 2022 16:10:42 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 Oct
 2022 16:32:20 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <clg@kaod.org>, <chin-ting_kuo@aspeedtech.com>,
        <broonie@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
Date:   Wed, 5 Oct 2022 16:32:09 +0800
Message-ID: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2958Ag4F056777
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Both quad SPI TX and RX modes can be supported on AST2600.
Correct typo in mode_bits field in both ast2600_fmc_data
and ast2600_spi_data structs.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index a334e89add86..33cefcf18392 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1163,7 +1163,7 @@ static const struct aspeed_spi_data ast2500_spi_data = {
 static const struct aspeed_spi_data ast2600_fmc_data = {
 	.max_cs	       = 3,
 	.hastype       = false,
-	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
@@ -1178,7 +1178,7 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
 static const struct aspeed_spi_data ast2600_spi_data = {
 	.max_cs	       = 2,
 	.hastype       = false,
-	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
-- 
2.25.1

