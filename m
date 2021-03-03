Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5F32C6DB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446527AbhCDAaM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29392 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241045AbhCCKTC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 05:19:02 -0500
X-UUID: 6835a1d1b8324615addd4471616ca7a2-20210303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=grLmHzM1WTxLyFnetwt7OHqUMHVimT2ZQg79yw21waE=;
        b=GzRFRsptfSotdqbg/abyCO99qWyWAd+R1PY+sbqL0+RxWvswbgg1NUl/PvC5/GdMFzVy/P00CC6tDINz7ERx8w3cLt2YP4kDLD8htyFDUFgbXDp3IOAFXUMpJ8MRJdCvZPsqwYPBaVIjEeafFnF0rWBmXx4issfcbU529XCJpwE=;
X-UUID: 6835a1d1b8324615addd4471616ca7a2-20210303
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 428997883; Wed, 03 Mar 2021 17:02:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 17:02:40 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 17:02:39 +0800
Message-ID: <1614762159.5898.9.camel@mhfsdcap03>
Subject: Re: [PATCH] spi: mediatek: Re-license MTK SPI driver as Dual MIT/GPL
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "luhua . xu" <luhua.xu@mediatek.com>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Daniel Kurtz" <djkurtz@chromium.org>,
        Axel Lin <axel.lin@ingics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>
Date:   Wed, 3 Mar 2021 17:02:39 +0800
In-Reply-To: <YD84OKr4vNwA7vnz@kroah.com>
References: <20210303025636.795-1-leilk.liu@mediatek.com>
         <YD84OKr4vNwA7vnz@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A50E5966DFB3374904F9625230C65C0882547409960E6A6FB5287E07708BE842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTAzIGF0IDA4OjE4ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTWFyIDAzLCAyMDIxIGF0IDEwOjU2OjM2QU0gKzA4MDAsIExlaWxrIExp
dSB3cm90ZToNCj4gPiBGcm9tOiAibGVpbGsubGl1IiA8bGVpbGsubGl1QG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBJdCBpcyB3YW50ZWQgdG8gdXNlIE1USyBzcGkgYnVzIGRyaXZlciB3aXRoIEdQ
TC0yLjAgb3IgTUlUIGxpY2Vuc2UuDQo+ID4gQnV0IG5vdyBpdCBpcyBvbmx5IGxpY2Vuc2VkIGFz
IEdQTC0yLjAsIHNvIHJlLWxpY2Vuc2UgaXQgYXMgZHVhbA0KPiA+IE1JVC9HUEwuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogbGVpbGsubGl1IDxsZWlsay5saXVAbWVkaWF0ZWsuY29tPg0KPiAN
Cj4gUGxlYXNlIHVzZSB5b3VyIG5hbWUgaGVyZSwgbm90IGFuIGVtYWlsIGFsaWFzIGZvciB3aGVy
ZSB5b3VyIG5hbWUgZ29lcy4NCj4gDQpPSywgSSdsbCBmaXggaXQsIHRoYW5rcyENCj4gDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvc3BpL3NwaS1tdDY1eHguYyAgICAgICAgICAgICAgICAgfCA0ICsr
LS0NCj4gPiAgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3NwaS1tdDY1eHguaCB8IDIgKy0N
Cj4gDQo+IEdpdmVuIHRoYXQgdGhlc2UgZmlsZXMgaGF2ZSBiZWVuIGxpY2Vuc2VkIHVuZGVyIHRo
ZSBHUEwgb25seSBzaW5jZSAyMDE1LA0KPiBhbGwgY2hhbmdlcyBjb250cmlidXRlZCB0byBpdCBo
YXZlIG9ubHkgYmVlbiBsaWNlbnNlZCB1bmRlciB0aGUgR1BMIGFzDQo+IHdlbGwsIHNvIGhhdmUg
eW91IGdvdHRlbiBhcHByb3ZhbCBmb3IgYWxsIG9mIHRoZSBjb250cmlidXRvcnMgZm9yIHRoaXMN
Cj4gY2hhbmdlPw0KPiANClRoaXMgaXMgdGhlIHJlYXNvbiB0aGF0IEkgc2VudCB0aGlzIHBhdGNo
IHRvIGFzayBmb3IgQUNLcyBmcm9tIGFsbA0KY29udHJpYnV0b3JzICh3aG8gYXJlIGFsbCBpbiB0
aGUgVG8gbWFpbC1saXN0KSBmb3IgdGhlc2UgZmlsZXMuDQoNCj4gQ2FuIHlvdSBwbGVhc2UgZ2V0
IHlvdXIgbGF3eWVyIHRvIGFsc28gc2lnbiBvZmYgb24gdGhpcyBsaWNlbnNlIGNoYW5nZQ0KPiBw
YXRjaCwgc28gdGhhdCB3ZSBrbm93IHRoYXQgeW91IGhhdmUgdGhlaXIgYXBwcm92YWwgZm9yIHRo
aXMgaW5jYXNlDQo+IHRoZXJlIGFyZSBxdWVzdGlvbnMgYWJvdXQgaXQgaW4gdGhlIGZ1dHVyZT8N
Cj4gDQpJIG5lZWQgdG8gdXNlIHRoZSBjb2RlIGluIG90aGVyIHByb2plY3RzIHRoYXQgaXMgbm90
IHdpdGggR1BMLTIuMC4NCkFsc28sIHRoZSBsaWNlbnNlIGNoYW5nZSBpcyBhcHByb3ZlZCBieSBN
ZWRpYXRlayBzdXBlcnZpc29yLg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

