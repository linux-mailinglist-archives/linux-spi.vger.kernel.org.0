Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A6386F64
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 03:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbhERBk7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 21:40:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3721 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhERBk7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 21:40:59 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkds36BB7z16Ppl;
        Tue, 18 May 2021 09:36:55 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:40 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhiqi Song <songzhiqi1@huawei.com>
Subject: [PATCH 4/7] spi: mpc52xx-psc: add parenthesis for sizeof
Date:   Tue, 18 May 2021 09:38:19 +0800
Message-ID: <1621301902-64158-5-git-send-email-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
References: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix missing parenthesis of sizeof reported by checkpatch.pl:
 WARNING: sizeof *pp should be sizeof(*pp).

The kernel coding style suggests thinking of sizeof as a function
and add parenthesis.

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/spi/spi-mpc52xx-psc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 17935e7..21ef5d4 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -265,7 +265,7 @@ static int mpc52xx_psc_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	if (!cs) {
-		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		spi->controller_state = cs;
@@ -365,7 +365,7 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof *mps);
+	master = spi_alloc_master(dev, sizeof(*mps));
 	if (master == NULL)
 		return -ENOMEM;
 
-- 
2.7.4

