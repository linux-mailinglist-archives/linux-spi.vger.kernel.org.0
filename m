Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3126630573C
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhA0JpW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 04:45:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11451 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhA0Jnt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jan 2021 04:43:49 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQdt95PtHzjCvf;
        Wed, 27 Jan 2021 17:42:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 17:42:59 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH 0/2] Add check of 4-byte when parsing SFDP 4bait table
Date:   Wed, 27 Jan 2021 17:40:48 +0800
Message-ID: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add check of 4-byte address mode support when parsing SFDP 4bait. Some
flash will provide a 4bait table and the spi-nor core will convert the
address mode to 4-byte without checking whether it's actually supported
or not by the controller. For example, the 16M s25fs128s1 provides the
4bait and will be convert to 4-byte address mode, which makes it unusable
on hisi-sfc-v3xx on hip08 platform.

Add the check before convert the address mode when parsing the 4bait will
solve this issue.

Yicong Yang (2):
  mtd: spi-nor: check 4-byte address support when parsing 4bait
  spi: hisi-sfc-v3xx: add address mode check

 drivers/mtd/spi-nor/sfdp.c      | 48 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-hisi-sfc-v3xx.c | 25 ++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.8.1

