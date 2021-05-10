Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A75377CA7
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEJG7j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 02:59:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2609 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhEJG7j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 02:59:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdsKK5pjzzmVTQ;
        Mon, 10 May 2021 14:56:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 14:58:23 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>
Subject: [PATCH 0/4] spi: Set of cleanups
Date:   Mon, 10 May 2021 14:58:19 +0800
Message-ID: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some cleanups of SPI drivers. No functional change.


Thanks,
Jay

Jay Fang (4):
  spi: ppc4xx: include <linux/io.h> instead of <asm/io.h>
  spi: omap-100k: Clean the value of 'status' is not used
  spi: delete repeated words in comments
  spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'

 drivers/spi/spi-bcm2835aux.c    | 2 +-
 drivers/spi/spi-dw-mmio.c       | 2 +-
 drivers/spi/spi-geni-qcom.c     | 4 ++--
 drivers/spi/spi-loopback-test.c | 2 +-
 drivers/spi/spi-omap-100k.c     | 2 --
 drivers/spi/spi-pl022.c         | 4 ++--
 drivers/spi/spi-ppc4xx.c        | 4 ++--
 7 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.7.4

