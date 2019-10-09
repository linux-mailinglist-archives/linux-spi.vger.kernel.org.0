Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB12D04C5
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2019 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfJIAaP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 20:30:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbfJIAaP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 20:30:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 789E5F4BA56C7CC98C80;
        Wed,  9 Oct 2019 08:30:13 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 08:30:06 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <geert@linux-m68k.org>,
        <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH v2 0/2] spi: Remove two set but not used variables
Date:   Wed, 9 Oct 2019 08:37:15 +0800
Message-ID: <1570581437-104549-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

v1->v2: just remove variable, still call read function

zhengbin (2):
  spi: omap-100k: Remove set but not used variable 'dataH'
  spi: npcm: Remove set but not used variable 'val'

 drivers/spi/spi-npcm-pspi.c | 3 +--
 drivers/spi/spi-omap-100k.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

--
2.7.4

