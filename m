Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3B151AB6
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 13:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBDMrv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 07:47:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46096 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMrv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 07:47:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 014ClnAv107979;
        Tue, 4 Feb 2020 06:47:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580820469;
        bh=P9x1aKSTPkxt8ox7A7M8oBeeGqzeXPx6rRSYJ/eVTck=;
        h=From:To:CC:Subject:Date;
        b=ixgagomzmJY8lXOnho4tIUH7II0iBQR+kQyarz/4Iv5Ut0XVO8pxvisVRVhW+3nXC
         q/WfokUm34iL7fc76G2kKrt/kc2lW/PiCNGrDdkH+9E8zaT4AOjl6fLBVsFO14ddK6
         TxMJfDD6Nt83nXn6uruNN6AxUhG1RFyI9GQZYu2A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014ClnF5014117;
        Tue, 4 Feb 2020 06:47:49 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 06:47:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 06:47:48 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014ClgcY095019;
        Tue, 4 Feb 2020 06:47:45 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] spi: spi-omap2-mcspi: Add DMA support for AM65x
Date:   Tue, 4 Feb 2020 18:18:14 +0530
Message-ID: <20200204124816.16735-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series adds DMA support for McSPI on AM65x.
First patch addresses a limitationn on AM65x where transfers have to be
<4K per DMA request and second patch handles possible EPROBE_DEFER when
requesting DMA channels

Vignesh Raghavendra (2):
  spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x
  spi: spi-omap2-mcspi: Support probe deferral for DMA channels

 drivers/spi/spi-omap2-mcspi.c                 | 103 +++++++++++-------
 include/linux/platform_data/spi-omap2-mcspi.h |   1 +
 2 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.25.0

