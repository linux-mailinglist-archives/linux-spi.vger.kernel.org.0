Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDADCF4F9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2019 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJHIYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 04:24:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHIYm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 04:24:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC0FCE1A61DB5DE6BFD4;
        Tue,  8 Oct 2019 16:24:34 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 16:24:26 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/2] spi: Remove two set but not used variables
Date:   Tue, 8 Oct 2019 16:31:35 +0800
Message-ID: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

zhengbin (2):
  spi: omap-100k: Remove set but not used variable 'dataH'
  spi: npcm: Remove set but not used variable 'val'

 drivers/spi/spi-npcm-pspi.c | 2 --
 drivers/spi/spi-omap-100k.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

--
2.7.4

