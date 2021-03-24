Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E55347178
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhCXGQ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:16:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14444 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhCXGQX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd03RcFzkf6G;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:15 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 07/11] spi: spi-bitbang: Fix open brace following function definitions go on the next line
Date:   Wed, 24 Mar 2021 14:16:38 +0800
Message-ID: <1616566602-13894-8-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix checkpatch errors:

  ERROR: open brace '{' following function definitions go on the next line
  #54: FILE: spi-bitbang.c:54:
  ERROR: open brace '{' following function definitions go on the next line
  #82: FILE: spi-bitbang.c:82:
  ERROR: open brace '{' following function definitions go on the next line
  #110: FILE: spi-bitbang.c:110:

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-bitbang.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 1a7352a..6a6af85 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -60,7 +60,8 @@ static unsigned bitbang_txrx_8(
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
-) {
+)
+{
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
 	const u8		*tx = t->tx_buf;
@@ -88,7 +89,8 @@ static unsigned bitbang_txrx_16(
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
-) {
+)
+{
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
 	const u16		*tx = t->tx_buf;
@@ -116,7 +118,8 @@ static unsigned bitbang_txrx_32(
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
-) {
+)
+{
 	unsigned		bits = t->bits_per_word;
 	unsigned		count = t->len;
 	const u32		*tx = t->tx_buf;
-- 
2.7.4

