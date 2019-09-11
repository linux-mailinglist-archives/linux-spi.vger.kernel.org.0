Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C83AF9AB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfIKJ67 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 05:58:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51334 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727093AbfIKJ67 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 05:58:59 -0400
X-UUID: 11a683efec1448528c5135f870771c37-20190911
X-UUID: 11a683efec1448528c5135f870771c37-20190911
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1367689443; Wed, 11 Sep 2019 17:58:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Sep 2019 17:58:51 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Sep 2019 17:58:50 +0800
From:   Luhua Xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 0/3] MT6765 spi support 
Date:   Wed, 11 Sep 2019 05:55:28 -0400
Message-ID: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These patch series add Mediatek mt6765 spi support, and add spi DMA
large PA support on some platforms. 


luhua.xu (3):
  dt-bindings: spi: update bindings for MT6765 SoC
  spi: mediatek: add spi support for mt6765 IC
  spi: mediatek: support large PA

 .../devicetree/bindings/spi/spi-mt65xx.txt    |  1 +
 drivers/spi/spi-mt65xx.c                      | 53 +++++++++++++++++--
 2 files changed, 49 insertions(+), 5 deletions(-)

--
2.18.0
