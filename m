Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED8658BD8
	for <lists+linux-spi@lfdr.de>; Thu, 29 Dec 2022 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiL2Km3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Dec 2022 05:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiL2KmN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Dec 2022 05:42:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B912745
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 02:42:12 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjQ0N4DyNz16LsT;
        Thu, 29 Dec 2022 18:40:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 29 Dec
 2022 18:41:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 0/3] spi: altera: switch to use modern name
Date:   Thu, 29 Dec 2022 18:38:34 +0800
Message-ID: <20221229103837.4192759-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
And also change other legacy name master/slave to modern name host/target
or controller. 

Yang Yingliang (3):
  spi: altera: switch to use modern name
  spi: spi-altera-dfl: switch to use modern name
  spi: spi-altera-platform: switch to use modern name

 drivers/spi/spi-altera-core.c     | 30 +++++++++++++-------------
 drivers/spi/spi-altera-dfl.c      | 36 +++++++++++++++----------------
 drivers/spi/spi-altera-platform.c | 36 +++++++++++++++----------------
 include/linux/spi/altera.h        |  4 ++--
 4 files changed, 53 insertions(+), 53 deletions(-)

-- 
2.25.1

