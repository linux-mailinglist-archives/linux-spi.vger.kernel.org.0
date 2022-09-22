Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AD5E5D60
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIVIYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIVIY2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE221F9E5
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:12 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY7VR6nGRzMpSj;
        Thu, 22 Sep 2022 16:19:27 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 0/6] spi: Switch to use __devm_spi_alloc_controller() in some drivers
Date:   Thu, 22 Sep 2022 16:30:57 +0800
Message-ID: <20220922083103.666157-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
__devm_spi_alloc_controller() in some spi drivers. With this
helper, spi_master_put() is called in devres_release_all()
whenever the device is unbound, so the spi_master_put() in
error path can be removed.

v2:
  Using controller named struct and functions:
    Using struct spi_controller instead of struct spi_master
    Using __devm_spi_alloc_controller() instead of devm_spi_alloc_master()
    Using spi_controller_get_devdata() instead of spi_master_get_devdata()
    Using devm_spi_register_master() instead of devm_spi_register_controller()


Yang Yingliang (6):
  spi: oc-tiny: Switch to use __devm_spi_alloc_controller()
  spi: ath79: Switch to use __devm_spi_alloc_controller()
  spi: omap-uwire: Switch to use __devm_spi_alloc_controller()
  spi: ppc4xx: Switch to use __devm_spi_alloc_controller()
  spi: sh-sci: Switch to use __devm_spi_alloc_controller()
  spi: altera: Switch to use __devm_spi_alloc_controller()

 drivers/spi/spi-altera-platform.c | 55 ++++++++++++++-----------------
 drivers/spi/spi-ath79.c           | 40 ++++++++++------------
 drivers/spi/spi-oc-tiny.c         | 34 ++++++++-----------
 drivers/spi/spi-omap-uwire.c      | 28 ++++++++--------
 drivers/spi/spi-ppc4xx.c          | 29 +++++++---------
 drivers/spi/spi-sh-sci.c          | 44 ++++++++++---------------
 6 files changed, 98 insertions(+), 132 deletions(-)

-- 
2.25.1

