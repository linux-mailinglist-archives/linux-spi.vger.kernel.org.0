Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA73A73DC
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 04:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFOC1U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 22:27:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56785 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229743AbhFOC1T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Jun 2021 22:27:19 -0400
X-UUID: cabb52ea3d0144a48df2188204cad7cb-20210615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=Ms2V43Y+zG4rJT5W7kdWWCyQOlck/Ej4cx++NxLHMfo=;
        b=dlAxpBdPIXIZ/CbpzDFw0jAJb7Mslfmgr3AJ1kIK/cOKZ5mIZ83jlGqbhe0fUCdUNhv1wAuiaoXE7rqeWNWOGmvfVruIFq9pcppYWvXrkrmXS3BE1nEDo49gS/QnKMx8sldYzs5WN8qIaJU39hmSrwdgwSsFTPF8JLp0aRKJFN8=;
X-UUID: cabb52ea3d0144a48df2188204cad7cb-20210615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1632482878; Tue, 15 Jun 2021 10:04:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 10:04:22 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 10:04:21 +0800
Message-ID: <1623721803.24597.9.camel@mbjsdccf07>
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
Date:   Tue, 15 Jun 2021 09:50:03 +0800
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
dGZvcm1zDQogDQogLSAjYWRkcmVzcy1jZWxsczogc2hvdWxkIGJlIDEuDQo=

