Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682EB5E8C14
	for <lists+linux-spi@lfdr.de>; Sat, 24 Sep 2022 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiIXMJs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 24 Sep 2022 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiIXMJp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 24 Sep 2022 08:09:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2F15800
        for <linux-spi@vger.kernel.org>; Sat, 24 Sep 2022 05:09:41 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZSQK0Rpwz1P6mQ;
        Sat, 24 Sep 2022 20:05:29 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 20:09:39 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 20:09:39 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH -next 1/3] spi: cadence-quadspi: Fix PM disable depth imbalance in cqspi_probe
Date:   Sat, 24 Sep 2022 20:13:07 +0800
Message-ID: <20220924121310.78331-2-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20220924121310.78331-1-zhangqilong3@huawei.com>
References: <20220924121310.78331-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context.

Fixes:73d5fe0462702 ("spi: cadence-quadspi: Remove spi_master_put() in probe failure path")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e12ab5b43f34..447230547945 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1645,7 +1645,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
-		return ret;
+		goto probe_pm_failed;
 
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
@@ -1740,6 +1740,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
 	pm_runtime_put_sync(dev);
+probe_pm_failed:
 	pm_runtime_disable(dev);
 	return ret;
 }
-- 
2.25.1

