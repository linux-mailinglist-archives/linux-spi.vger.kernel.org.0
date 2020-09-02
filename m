Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF95A25AC0E
	for <lists+linux-spi@lfdr.de>; Wed,  2 Sep 2020 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBN3T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Sep 2020 09:29:19 -0400
Received: from smtp1.axis.com ([195.60.68.17]:2982 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbgIBN2z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Sep 2020 09:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2096; q=dns/txt; s=axis-central1;
  t=1599053334; x=1630589334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AgdT9RyvsL1kMu2Pv2jpSFW1ZTFPH2ZXclfIA30Z60Y=;
  b=d2PTxg1V9lYEarg8MYSKJMcJOU+Cok4SdbdwDBMMEZjkO8oMi5dXZUCJ
   Ye7gZccacyTxzFwGI676L1xvSbYsGawEXzwGyb8CyfzMiPPPPY3Nn9tCA
   Bp9T1ad5J4ZVUiduHbxX8Pc3QmmbKgW+4RTW1lPmqrfJ8LieVVgzrjXAL
   JdEh2uCLg4aO+ACJ8maKqOyVBc1TAQouTV9aL6y9OG23pzuOsIeb17TGW
   bS+vHgPrr6J4CijiFMjTdHgxMAQE60kq3afF6w9Sld2w/ZEgF2+0TaMZV
   K+2ZbnuyXgZWPVk7f985KJ6p/w76esbkaGN3fIU3eo0B59ztOHty22I35
   Q==;
IronPort-SDR: xVA0Ecv2co77wx8zDWdXanLVFBUWn4ULzvpAmbOa/TC3EDsVdd1pzAXB3RXHSzZ98c+judpJZK
 Xfa0lziKAwkmK8/OvcKLhDzMAYhf/2FPLIb8d7CGtGM6Xu31T57VNvRwsVU+N66hBucbI0Ooc1
 nDlhoG3CdRFWu+oy/cg+/BCj8pyP/dEg5GqtjX7CGEJoDUZ3XyIIAyT5qELys/eO2WZRruuvsb
 PKA6i7UF5s11ELEgfy9EtRpQKW4ZodwAmvhiPLNZxbHP+AwZH5TtgpTVKVWErzj6cPTe9cVk3+
 jQg=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12478310"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, <linux-spi@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] spi: spi-loopback-test: Fix out-of-bounds read
Date:   Wed, 2 Sep 2020 15:23:41 +0200
Message-ID: <20200902132341.7079-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 9522d1b5786d..df981e55c24c 100644
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
2.28.0

