Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758455BE758
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiITNlm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiITNlg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109443E64
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:32 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX2fR6zBWzmVYR;
        Tue, 20 Sep 2022 21:37:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in some drivers
Date:   Tue, 20 Sep 2022 21:48:13 +0800
Message-ID: <20220920134819.2981033-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset is trying to replace spi_alloc_master() with
devm_spi_alloc_master() in some spi drivers. With this helper,
spi_master_put() is called in devres_release_all() whenever
the device is unbound, so the spi_master_put() in error path
can be removed.

Yang Yingliang (6):
  spi: oc-tiny: Switch to use devm_spi_alloc_master()
  spi: ath79: Switch to use devm_spi_alloc_master()
  spi: omap-uwire: Switch to use devm_spi_alloc_master()
  spi: ppc4xx: Switch to use devm_spi_alloc_master()
  spi: sh-sci: Switch to use devm_spi_alloc_master()
  spi: altera: Switch to use devm_spi_alloc_master()

 drivers/spi/spi-altera-platform.c | 23 ++++++++-------------
 drivers/spi/spi-ath79.c           | 18 ++++++----------
 drivers/spi/spi-oc-tiny.c         | 18 ++++++----------
 drivers/spi/spi-omap-uwire.c      |  6 ++----
 drivers/spi/spi-ppc4xx.c          | 17 ++++++----------
 drivers/spi/spi-sh-sci.c          | 34 ++++++++++++-------------------
 6 files changed, 41 insertions(+), 75 deletions(-)

-- 
2.25.1

