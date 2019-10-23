Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D31E1AF2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbfJWMmB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 08:42:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46827 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389887AbfJWMmB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 08:42:01 -0400
X-UUID: a4dc8739ecee419582113529d95f9dce-20191023
X-UUID: a4dc8739ecee419582113529d95f9dce-20191023
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1206687605; Wed, 23 Oct 2019 20:41:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 23 Oct 2019 20:41:51 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Oct 2019 20:41:51 +0800
From:   Luhua Xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <luhua.xu@mediatek.com>
Subject: [PATCH 0/1] Add spi power control when set cs
Date:   Wed, 23 Oct 2019 08:38:41 -0400
Message-ID: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch add power control when set spi cs to fix register
access violation.


luhua.xu (1):
  spi: mediatek: add power control when set_cs

 drivers/spi/spi-mt65xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

