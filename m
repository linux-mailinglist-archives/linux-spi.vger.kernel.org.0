Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6C386F67
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbhERBlA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 21:41:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345928AbhERBk7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 21:40:59 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkdrC2vSbzQnsN;
        Tue, 18 May 2021 09:36:11 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:39:39 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhiqi Song <songzhiqi1@huawei.com>
Subject: [PATCH 0/7] drivers: spi - add parenthesis for sizeof
Date:   Tue, 18 May 2021 09:38:15 +0800
Message-ID: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset fixes missing parentheses of sizeof reported by checkpatch.pl
under drivers/spi/.

Zhiqi Song (7):
  spi: lm70llp: add parenthesis for sizeof
  spi: mpc512x-psc: add parenthesis for sizeof
  spi: mpc52xx: add parenthesis for sizeof
  spi: mpc52xx-psc: add parenthesis for sizeof
  spi: omap2-mcspi: add parenthesis for sizeof
  spi: omap-uwire: add parenthesis for sizeof
  spi: ppc4xx: add parenthesis for sizeof

 drivers/spi/spi-lm70llp.c     | 2 +-
 drivers/spi/spi-mpc512x-psc.c | 4 ++--
 drivers/spi/spi-mpc52xx-psc.c | 4 ++--
 drivers/spi/spi-mpc52xx.c     | 2 +-
 drivers/spi/spi-omap-uwire.c  | 2 +-
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 drivers/spi/spi-ppc4xx.c      | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

--
2.7.4

