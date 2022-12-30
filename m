Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736586596BC
	for <lists+linux-spi@lfdr.de>; Fri, 30 Dec 2022 10:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiL3JbS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Dec 2022 04:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JbR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Dec 2022 04:31:17 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E790510E5
        for <linux-spi@vger.kernel.org>; Fri, 30 Dec 2022 01:31:16 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nk0K41Rg7zJpVV;
        Fri, 30 Dec 2022 17:27:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 30 Dec
 2022 17:31:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 0/3] spi: switch to use modern name
Date:   Fri, 30 Dec 2022 17:28:03 +0800
Message-ID: <20221230092806.1687340-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
  spi: ath79: switch to use modern name
  spi: a3700: switch to use modern name
  spi: ar934x: switch to use modern name

 drivers/spi/spi-ar934x.c      | 10 ++--
 drivers/spi/spi-armada-3700.c | 98 +++++++++++++++++------------------
 drivers/spi/spi-ath79.c       | 40 +++++++-------
 3 files changed, 74 insertions(+), 74 deletions(-)

-- 
2.25.1

