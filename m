Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6F2F2C44
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbhALKHn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 05:07:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10957 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbhALKHm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jan 2021 05:07:42 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DFR6q1NPtzj5PB;
        Tue, 12 Jan 2021 18:06:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 12 Jan 2021 18:06:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 0/1] spi: cadence-quadspi: Fix a compilation warning for 64-bit platform
Date:   Tue, 12 Jan 2021 18:06:36 +0800
Message-ID: <20210112100637.747-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch is based on the latest linux-next. So the Fixes commit-id
maybe changed when it merged int v5.12-rc1. For details about the problem
analysis, see the patch description. The auxiliary information is listed here.

1) the type of size_t on 32-bit and 64-bit platforms
include/uapi/asm-generic/posix_types.h:
typedef unsigned long   __kernel_ulong_t;

#if __BITS_PER_LONG != 64
typedef unsigned int    __kernel_size_t;
#else
typedef __kernel_ulong_t __kernel_size_t;
#endif

include/linux/types.h:
typedef __kernel_size_t         size_t;

2) The compilation warning information on arm64:
In file included from ./include/linux/kernel.h:14,
                 from ./include/linux/clk.h:13,
                 from drivers/spi/spi-cadence-quadspi.c:9:
drivers/spi/spi-cadence-quadspi.c: In function ‘cqspi_direct_read_execute’:
./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
   18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                            ^~
./include/linux/minmax.h:32:4: note: in expansion of macro ‘__typecheck’
   32 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
./include/linux/minmax.h:42:24: note: in expansion of macro ‘__safe_cmp’
   42 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
./include/linux/minmax.h:58:19: note: in expansion of macro ‘__careful_cmp’
   58 | #define max(x, y) __careful_cmp(x, y, >)
      |                   ^~~~~~~~~~~~~
drivers/spi/spi-cadence-quadspi.c:1153:24: note: in expansion of macro ‘max’
 1153 |       msecs_to_jiffies(max(len, 500U)))) {
      |                        ^~~


Zhen Lei (1):
  spi: cadence-quadspi: Fix a compilation warning for 64-bit platform

 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3


