Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28334717A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhCXGQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:16:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14440 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhCXGQY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd03GDDzkf69;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:13 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 00/11] spi: Fix ERRORs reported by checkpatch
Date:   Wed, 24 Mar 2021 14:16:31 +0800
Message-ID: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

A total of 27 ERRORs are found when scanning all files in the drivers/spi
directory by checkpatch tool. This series fixes 21 ERRORs of them, and the
remaining 6 ERRORs I don't think need to be fixed.

No functional change.


Thanks,
Jay

Jay Fang (11):
  spi: spi-topcliff-pch: Fix checkpatch spacing error
  spi: sprd: Fix checkpatch spacing error
  spi: pxa2xx: Fix checkpatch spacing errors
  spi: omap-100k: Fix checkpatch spacing errors
  spi: spi-mtk-nor: Fix checkpatch spacing error
  spi: dln2: Fix open brace following function definitions go on the
    next line
  spi: spi-bitbang: Fix open brace following function definitions go on
    the next line
  spi: jcore: Fix trailing statements should be on next line
  spi: spi-mem: Fix code indent should use tabs where possible
  spi: rockchip: Fix code indent should use tabs where possible
  spi: pl022: Fix trailing whitespace

 drivers/spi/spi-bitbang.c      | 9 ++++++---
 drivers/spi/spi-dln2.c         | 3 ++-
 drivers/spi/spi-jcore.c        | 3 ++-
 drivers/spi/spi-mem.c          | 6 +++---
 drivers/spi/spi-mtk-nor.c      | 2 +-
 drivers/spi/spi-omap-100k.c    | 8 ++++----
 drivers/spi/spi-pl022.c        | 2 +-
 drivers/spi/spi-pxa2xx-pci.c   | 2 +-
 drivers/spi/spi-pxa2xx.c       | 2 +-
 drivers/spi/spi-rockchip.c     | 6 +++---
 drivers/spi/spi-sprd-adi.c     | 2 +-
 drivers/spi/spi-topcliff-pch.c | 3 ++-
 12 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.7.4

