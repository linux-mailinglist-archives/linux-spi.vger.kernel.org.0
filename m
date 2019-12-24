Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B2C129D21
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 04:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLXDoz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfLXDoz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41005E0AA862DB34E432;
        Tue, 24 Dec 2019 11:44:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:44:45 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/3] spi: use true,false for bool variable
Date:   Tue, 24 Dec 2019 11:52:03 +0800
Message-ID: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

zhengbin (3):
  spi: fsl-lpspi: use true,false for bool variable
  spi: imx: use true,false for bool variable
  spi: tegra114: use true,false for bool variable

 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 drivers/spi/spi-imx.c       | 4 ++--
 drivers/spi/spi-tegra114.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--
2.7.4

