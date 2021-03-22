Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23773438D4
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 06:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCVFxu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 01:53:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50022 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229870AbhCVFxP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 01:53:15 -0400
X-UUID: 6aed3cc16ab34655b546913d7f3bde1e-20210322
X-UUID: 6aed3cc16ab34655b546913d7f3bde1e-20210322
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 771264958; Mon, 22 Mar 2021 13:53:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 13:53:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 13:53:03 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>
Subject: [PATCH 0/4] Add Mediatek MT8195 SPI driver support
Date:   Mon, 22 Mar 2021 13:52:40 +0800
Message-ID: <20210322055244.30179-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DFA52094B9505363474F86AB7C703C61050DCB637600FD4349E41A44D408118C2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series are based on spi/for-next, and provide 4 patches to add MT8195 spi support.

Leilk Liu (4):
  spi: update spi master bindings for MT8195 SoC
  spi: update spi slave bindings for MT8195 SoC
  spi: mediatek: add mtk_spi_compatible support
  spi: mediatek: add mt8195 spi slave support

 .../devicetree/bindings/spi/spi-mt65xx.txt    |  1 +
 .../bindings/spi/spi-slave-mt27xx.txt         |  1 +
 drivers/spi/spi-slave-mt27xx.c                | 36 ++++++++++++++++---
 3 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.25.1


