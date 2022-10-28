Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5CE610844
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiJ1CjR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Oct 2022 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiJ1CjA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Oct 2022 22:39:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C76BF50
        for <linux-spi@vger.kernel.org>; Thu, 27 Oct 2022 19:38:36 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz66q1LN5zmVVc;
        Fri, 28 Oct 2022 10:33:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:38:34 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <john.garry@huawei.com>,
        <huangdaode@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH] MAINTAINERS: Update HiSilicon SFC Driver maintainer
Date:   Fri, 28 Oct 2022 10:37:39 +0800
Message-ID: <20221028023739.4113998-1-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Jay Fang as the maintainer of the HiSilicon SFC Driver, replacing
John Garry.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98b5ed6a3da6..781423be8400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9269,7 +9269,7 @@ S:	Maintained
 F:	drivers/crypto/hisilicon/trng/trng.c
 
 HISILICON V3XX SPI NOR FLASH Controller Driver
-M:	John Garry <john.garry@huawei.com>
+M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
-- 
2.30.0

