Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFA3DE4B3
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 05:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhHCDba (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 23:31:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233197AbhHCDba (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 23:31:30 -0400
X-UUID: 66120b80f6974681ac30056544c75e59-20210803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aU3UvCi1IbFyB5KtaIThVBbat1eD0yrQK0PdCy+027E=;
        b=PU73T0HuGn4C+6b9Vu3jwWvIIbgTnHaz8yuS9VpiO/X7iZSOcACPBMpfygcR/XMAHLcgjGzRBTLb/pT74vCIP7ZRsCj/7NJv50T6YzFaa4mnFb/FiZQ8AQkfAUXUap840Cld6d5GOslcvuc8pkMWRcsgVUiWEj8ip7P1+zIeOaE=;
X-UUID: 66120b80f6974681ac30056544c75e59-20210803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 73031877; Tue, 03 Aug 2021 11:31:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 11:31:15 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 11:31:14 +0800
Message-ID: <1627960488.7721.2.camel@mbjsdccf07>
Subject: Re: [PATCH 2/3] spi: modify set_cs_timing parameter
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 3 Aug 2021 11:14:48 +0800
In-Reply-To: <20210802201614.GA39900@sirena.org.uk>
References: <20210719091642.24633-1-mason.zhang@mediatek.com>
         <20210802201614.GA39900@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTAyIGF0IDIxOjE2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIEp1bCAxOSwgMjAyMSBhdCAwNToxNjo0M1BNICswODAwLCBNYXNvbiBaaGFuZyB3cm90
ZToNCj4gPiBGcm9tOiBNYXNvbiBaaGFuZyA8TWFzb24uWmhhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IE5vIG5lZWQgcGFzcyBpbiBzcGlfZGVsYXkgdG8gc2V0X2NzX3RpbWluZyBjYWxsYmFj
ay4NCj4gDQo+IFRoaXMgYnJlYWtzIHRoZSBidWlsZDoNCj4gDQo+IC9tbnQva2VybmVsL2RyaXZl
cnMvc3BpL3NwaS10ZWdyYTExNC5jOiBJbiBmdW5jdGlvbiAndGVncmFfc3BpX3Byb2JlJzoNCj4g
L21udC9rZXJuZWwvZHJpdmVycy9zcGkvc3BpLXRlZ3JhMTE0LmM6MTMyODoyNDogZXJyb3I6IGFz
c2lnbm1lbnQgdG8gJ2ludCAoKikoc3RydWN0IHNwaV9kZXZpY2UgKiknIGZyb20gaW5jb21wYXRp
YmxlIHBvaW50ZXIgdHlwZSAnaW50ICgqKShzdHJ1Y3Qgc3BpX2RldmljZSAqLCBzdHJ1Y3Qgc3Bp
X2RlbGF5ICosIHN0cnVjdCBzcGlfZGVsYXkgKiwgc3RydWN0IHNwaV9kZWxheSAqKScgWy1XZXJy
b3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdDQo+ICAgbWFzdGVyLT5zZXRfY3NfdGltaW5n
ID0gdGVncmFfc3BpX3NldF9od19jc190aW1pbmc7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCg0KRGVhciBNYXJrOg0KDQoJSSBoYXZlIGZpeGVkIHRoaXMgYnVpbGQgZXJyIGluIHRoaXMg
cGF0Y2g6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNwaS8yMDIxMDgwMzAyMTMy
OC4yODI5MS0xLU1hc29uLlpoYW5nQG1lZGlhdGVrLmNvbS9ULyN1DQoNCg0KVGhhbmtzDQpNYXNv
bg0K

