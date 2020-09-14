Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839CD268E1A
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgINOoK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgINNF3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:05:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E572F2222E;
        Mon, 14 Sep 2020 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600088682;
        bh=Znj6Ys0c5jRV6GwNvsGEzPyhBwAFXhnTPfn0h1uiGBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIKc23R/S0pQYrJMpIIeeBY6EIEdExg/eE+C+YdjUM8gkwTBoNnMraMILu0jWa47/
         rAdlS24loho9VVgNfIyG9LRY182rLDc5AJTYPxGXKUbByYFCoaSO6Tgub4hKMYxXpe
         550VbmtQSrUpVXYyV9WL6d106+UTCFoR55iOVjJM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/22] spi: spi-loopback-test: Fix out-of-bounds read
Date:   Mon, 14 Sep 2020 09:04:18 -0400
Message-Id: <20200914130434.1804478-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130434.1804478-1-sashal@kernel.org>
References: <20200914130434.1804478-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit 837ba18dfcd4db21ad58107c65bfe89753aa56d7 ]

The "tx/rx-transfer - crossing PAGE_SIZE" test always fails when
len=131071 and rx_offset >= 5:

 spi-loopback-test spi0.0: Running test tx/rx-transfer - crossing PAGE_SIZE
 ...
   with iteration values: len = 131071, tx_off = 0, rx_off = 3
   with iteration values: len = 131071, tx_off = 0, rx_off = 4
   with iteration values: len = 131071, tx_off = 0, rx_off = 5
 loopback strangeness - rx changed outside of allowed range at: ...a4321000
   spi_msg@ffffffd5a4157690
     frame_length:  131071
     actual_length: 131071
     spi_transfer@ffffffd5a41576f8
       len:    131071
       tx_buf: ffffffd5a4340ffc

Note that rx_offset > 3 can only occur if the SPI controller driver sets
->dma_alignment to a higher value than 4, so most SPI controller drivers
are not affect.

The allocated Rx buffer is of size SPI_TEST_MAX_SIZE_PLUS, which is 132
KiB (assuming 4 KiB pages).  This test uses an initial offset into the
rx_buf of PAGE_SIZE - 4, and a len of 131071, so the range expected to
be written in this transfer ends at (4096 - 4) + 5 + 131071 == 132 KiB,
which is also the end of the allocated buffer.  But the code which
verifies the content of the buffer reads a byte beyond the allocated
buffer and spuriously fails because this out-of-bounds read doesn't
return the expected value.

Fix this by using ITERATE_LEN instead of ITERATE_MAX_LEN to avoid
testing sizes which cause out-of-bounds reads.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/r/20200902132341.7079-1-vincent.whitchurch@axis.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6f18d49527673..51633b2b64371 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -90,7 +90,7 @@ static struct spi_test spi_tests[] = {
 	{
 		.description	= "tx/rx-transfer - crossing PAGE_SIZE",
 		.fill_option	= FILL_COUNT_8,
-		.iterate_len    = { ITERATE_MAX_LEN },
+		.iterate_len    = { ITERATE_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_rx_align = ITERATE_ALIGN,
 		.transfer_count = 1,
-- 
2.25.1

