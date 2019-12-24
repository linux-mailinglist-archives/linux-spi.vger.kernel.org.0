Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E8129D23
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 04:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLXDoz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbfLXDoz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4454555B535104BCC010;
        Tue, 24 Dec 2019 11:44:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:44:46 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 3/3] spi: tegra114: use true,false for bool variable
Date:   Tue, 24 Dec 2019 11:52:06 +0800
Message-ID: <1577159526-33689-4-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
References: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes coccicheck warning:

drivers/spi/spi-tegra114.c:272:2-17: WARNING: Assignment of 0/1 to bool variable
drivers/spi/spi-tegra114.c:275:2-17: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-tegra114.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index fc40ab1..83edabd 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -269,10 +269,10 @@ static unsigned tegra_spi_calculate_curr_xfer_param(

 	if ((bits_per_word == 8 || bits_per_word == 16 ||
 	     bits_per_word == 32) && t->len > 3) {
-		tspi->is_packed = 1;
+		tspi->is_packed = true;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-		tspi->is_packed = 0;
+		tspi->is_packed = false;
 		tspi->words_per_32bit = 1;
 	}

--
2.7.4

