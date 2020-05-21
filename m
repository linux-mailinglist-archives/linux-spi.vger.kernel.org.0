Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE931DCC08
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 13:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEULYP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 07:24:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbgEULYP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 07:24:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3758CC14ED682E7A9D3;
        Thu, 21 May 2020 19:24:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 19:24:06 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <john.garry@huawei.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: [RFC PATCH 0/3] Add prepare/unprepare method in spi_controller_mem_ops
Date:   Thu, 21 May 2020 19:23:48 +0800
Message-ID: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In this series:
- Add optional prepare/unprepare methods in spi_controller_mem_ops to allow
  the controller do specific works before/after a set of operations, like
  spi-nor flash's read/write/erase/lock/unlock. This is equivalent mechanism
  to spi_nor_controller_ops' prepare/unprepare methods.
- Implement prepare/unprepare methods for hisi-sfc-v3xx controller. This will
  solve a race condition between the kernel driver and firmware.

Yicong Yang (3):
  spi: spi-mem: add optional prepare/unprepare methods in
    spi_controller_mem_ops
  mtd: spi-nor: Add prepare/unprepare support for spimem device
  spi: hisi-sfc-v3xx: Add prepare/unprepare methods to avoid race
    condition

 drivers/mtd/spi-nor/core.c      |  8 ++++++--
 drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-mem.c           | 20 ++++++++++++++++++++
 include/linux/spi/spi-mem.h     | 11 +++++++++++
 4 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.8.1

