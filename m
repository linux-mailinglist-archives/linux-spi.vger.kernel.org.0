Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF812AEC78
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKKIzO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 03:55:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44939 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgKKIzN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 03:55:13 -0500
X-UUID: 8000e3fc85d74acd9d2fcda742db92b5-20201111
X-UUID: 8000e3fc85d74acd9d2fcda742db92b5-20201111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1381921055; Wed, 11 Nov 2020 16:55:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 16:55:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 16:55:06 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v1] add axi clock control for MT8192 spi-nor 
Date:   Wed, 11 Nov 2020 16:55:01 +0800
Message-ID: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bayi cheng (1):
  spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor

 drivers/spi/spi-mtk-nor.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--
1.9.1
