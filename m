Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA43581FB
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhDHLei (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 07:34:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15190 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHLeh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 07:34:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGJxk4sPszpWbs;
        Thu,  8 Apr 2021 19:31:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:34:19 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 0/2] Minor updates for hisi-sfc-v3xx
Date:   Thu, 8 Apr 2021 19:31:43 +0800
Message-ID: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series fix a potential interrupt race condition and
cleanup the ACPI protection for the driver.

Yicong Yang (2):
  spi: hisi-sfc-v3xx: fix potential irq race condition
  spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and related ifendif
    protection

 drivers/spi/spi-hisi-sfc-v3xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.8.1

