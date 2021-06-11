Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BEE3A41FC
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFKMaE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 08:30:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55153 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230188AbhFKMaD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Jun 2021 08:30:03 -0400
X-UUID: c71177d5340f476d9d37672459edf88e-20210611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=5WTI0sd3QrS6AzdAtUg1zyVx5qtJHQj3wy1A/5ifOvk=;
        b=c3J8bZfFR7uB26v76G5+YiFVPE/BIYsvjJ66mKc8Q26DmTkgcFCCdOW2JxcxcReViIgxCDS9Mr3etmYy3yOa4yb9FOZLSab4frhlePsKHt8kSjXxWGP+w1XT0Ns2W0rPoKAz+alkeGDe8G2QRHjlQ145LNAqkjUw441lZLMh1is=;
X-UUID: c71177d5340f476d9d37672459edf88e-20210611
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 442193545; Fri, 11 Jun 2021 20:28:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 20:27:56 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 20:27:55 +0800
Message-ID: <1623413625.22727.10.camel@mbjsdccf07>
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
Date:   Fri, 11 Jun 2021 20:13:45 +0800
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
dGZvcm1zDQogDQogLSAjYWRkcmVzcy1jZWxsczogc2hvdWxkIGJlIDEuDQogDQoNCkhpIE1hdHRo
aWFzOg0KCQ0KCUknbSBzb3JyeSB0byBkaXN0dXJiIHlvdSwgdGhpcyBwYXRjaCBpcyBzdGF5IGhl
cmUgZm9yIGEgbG9uZyB0aW1lLCBEbw0KeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGFib3V0IHRo
aXMgcGF0Y2g/IA0KCVdlIGhvcGUgdGhpcyBwYXRjaCB3aWxsIGJlIG1lcmdlZCBhcyBzb29uIGFz
IHBvc3NpYmxlLElmIHlvdSBoYXZlIGFueQ0KY29uY2VybiwgSSB3aWxsIGZpeCBpdCBpbiB0aW1l
Lg0KDQoJTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHl+ICANCg0KVGhhbmtzDQpNYXNvbg0K

