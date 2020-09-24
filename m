Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C292770E9
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgIXMZz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbgIXMZz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3AED619671D9BAFB79F9;
        Thu, 24 Sep 2020 20:25:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 20:25:45 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <john.garry@huawei.com>, <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yangyicong@hisilicon.com>
Subject: [PATCH 0/4] Add IRQ mode support for hisi-sfc-v3xx driver and some cleanups
Date:   Thu, 24 Sep 2020 20:24:26 +0800
Message-ID: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series mainly add the IRQ mode support for hisi-sfc-v3xx driver, and some
cleanups for the preparation of the IRQ mode.
After this patch, the device can work in IRQ mode, or if firmware doesn't
declare irq support it will fall back to Poll mode.

Patch 1-2 refactor the .exec_op() path to make it simpler and clearer.
Patch 3 factor the definition of the interrupt bits.
Patch 4 add the IRQ support of the driver.


Yicong Yang (4):
  spi: hisi-sfc-v3xx: factor out IO modes configuration
  spi: hisi-sfc-v3xx: factor out bus config and transfer functions
  spi: hisi-sfc-v3xx: factor out the bit definition of interrupt
    register
  spi: hisi-sfc-v3xx: add support for IRQ mode

 drivers/spi/spi-hisi-sfc-v3xx.c | 261 +++++++++++++++++++++++++++++-----------
 1 file changed, 190 insertions(+), 71 deletions(-)

-- 
2.8.1

