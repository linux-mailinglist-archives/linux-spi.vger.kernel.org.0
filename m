Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE953A73F0
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 04:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhFOC35 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 22:29:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44245 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230017AbhFOC34 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Jun 2021 22:29:56 -0400
X-UUID: 1a1dd5c6154e4b4d9f47f18dae7ae266-20210615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=HgQEMPAQwFVw316F5Bb8QONY/lmsE8nLMBDtacQX7JI=;
        b=t3LvgieWBiOCwyg6dSv+mDsiKdf3OzAtFRQhDIgA06QHvTwrwjODC8+0XU4Caf1YqPyQkJgI4BvzQf8zOiEVVe6CJsmU1ipIuD+CefYkbNfLqGJzsBzTqwDlMxjko9L2ivHs3VYUBvs4o9PvgavCYhdcswbuWScXKY8gwAe3nHE=;
X-UUID: 1a1dd5c6154e4b4d9f47f18dae7ae266-20210615
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 405860223; Tue, 15 Jun 2021 09:51:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 09:51:12 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 09:51:11 +0800
Message-ID: <1623721012.24597.3.camel@mbjsdccf07>
Subject: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <hanks.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 15 Jun 2021 09:36:52 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQp0aGlzIHBhdGNoIHVwZGF0ZSBzcGkgZG9jdW1lbnQgZm9yIE1UNjc3OSBTT0MuDQoNClNpZ25l
ZC1vZmYtYnk6IE1hc29uIFpoYW5nIDxNYXNvbi5aaGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdDY1eHgudHh0IHwgMSAr
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdDY1eHgudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbXQ2NXh4LnR4dA0KaW5kZXggOWU0Mzcy
MWZhN2Q2Li43YmFlN2VlZjI2YzcgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL3NwaS1tdDY1eHgudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdDY1eHgudHh0DQpAQCAtMTMsNiArMTMsNyBAQCBSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KICAgICAtIG1lZGlhdGVrLG10ODE4My1zcGk6IGZvciBtdDgxODMg
cGxhdGZvcm1zDQogICAgIC0gIm1lZGlhdGVrLG10ODE5Mi1zcGkiLCAibWVkaWF0ZWssbXQ2NzY1
LXNwaSI6IGZvciBtdDgxOTIgcGxhdGZvcm1zDQogICAgIC0gIm1lZGlhdGVrLG10ODUxNi1zcGki
LCAibWVkaWF0ZWssbXQyNzEyLXNwaSI6IGZvciBtdDg1MTYgcGxhdGZvcm1zDQorICAgIC0gIm1l
ZGlhdGVrLG10Njc3OS1zcGkiLCAibWVkaWF0ZWssbXQ2NzY1LXNwaSI6IGZvciBtdDY3NzkgcGxh
dGZvcm1zDQogDQogLSAjYWRkcmVzcy1jZWxsczogc2hvdWxkIGJlIDEuDQogDQoNCg0KSGkgTWFy
ayAmJiBNYXR0aGlhczoNCg0KCUkgaGF2ZSBmaXhlZCBjb21taXQgbWVzc2FnZSwgdGhhbmtzfg0K
DQpUaGFua3MNCk1hc29uDQo=

