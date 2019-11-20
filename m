Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99321036A0
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2019 10:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfKTJbh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Nov 2019 04:31:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfKTJbh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Nov 2019 04:31:37 -0500
X-UUID: 6c8c298000f246188359f9276152f61f-20191120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T3sDLo2K05Z/3ZcFow82bTWpYhK40YdPKIaIHVHrszc=;
        b=DTMHBhxRDbrLOgWKBS2brxxvhpGLB8+MrbqaGlwukjtDX4hLuuAU+4MnD9g+S+1gss7BmckkkM05Xkvj40a/9EaPRVvSseYF+44Mx0FBD9J0LcQpkwfXNGJKPgR1Og3Cv52WltXw6j2PCsRFHGKz1JwT3jaRr51BBZYQtPRZpcs=;
X-UUID: 6c8c298000f246188359f9276152f61f-20191120
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971422696; Wed, 20 Nov 2019 17:31:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Nov 2019 17:31:26 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Nov 2019 17:31:13 +0800
Message-ID: <1574242283.27063.5.camel@mbjsdccf07>
Subject: Re: [PATCH 2/2] spi: mediatek: add cs timing configuration support
From:   luhua xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 20 Nov 2019 17:31:23 +0800
In-Reply-To: <20191119181930.GF3634@sirena.org.uk>
References: <1574053037-26721-1-git-send-email-luhua.xu@mediatek.com>
         <1574053037-26721-3-git-send-email-luhua.xu@mediatek.com>
         <20191119181930.GF3634@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTE5IGF0IDE4OjE5ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIE5vdiAxOCwgMjAxOSBhdCAxMjo1NzoxN1BNICswODAwLCBMdWh1YSBYdSB3cm90ZToN
Cj4gPiBBZGQgY29uZmlndXJlIFNQSSBDUyBzZXR1cC9ob2xkL2lkbGUgZGVsYXlzIGluIHRlcm1z
DQo+ID4gb2YgY2xrIGNvdW50IHN1cHBvcnQsIGFuZCB1c2Ugb25lIHBlcmlvZCBvZiBjdXJyZW50
DQo+ID4gc3BpIHNwZWVkIGFzIGRlZmF1bHQgaWYgc2V0dXAvaG9sZC9pZGxlIG5vdCBpbmRpY2F0
ZWQuDQo+IA0KPiBXZSBoYXZlIGFkZGVkIGEgZ2VuZXJpYyB3YXkgdG8gc3BlY2lmeSBkZWxheXMg
bGlrZSB0aGlzIHZpYSB0aGUNCj4gc2V0X2NzX3RpbWluZygpIG9wZXJhdGlvbiBhbmQgcmVsYXRl
ZCBmaWVsZHMgaW4gdGhlIHNwaV9kZXZpY2Ugc3RydWN0DQo+IHdoaWNoIG9wZXJhdGUgaW4gdGVy
bXMgb2Ygc3BpX2RlbGF5IC0gQWxleGFuZHJ1IEFyZGVsZWFuIGFkZGVkIHRoZW0NCj4gcmVjZW50
bHkuICBUaGlzIHN1cHBvcnRzIGJvdGggdGltZXMgYW5kIGNsb2NrIGN5Y2xlcyBhcyB1bml0cyBz
byBzaG91bGQNCj4gZml0IHdpdGggd2hhdCB5b3VyIGhhcmR3YXJlIGNhbiBkbywgdGhlIGludGVy
ZmFjZSBpcyBuZXcgdGhvdWdoIHNvIHRoZXJlDQo+IG1heSBiZSBzb2VtIHJvdWdoIGVkZ2VzIHRv
IHdvcnJ5IGFib3V0Lg0KDQpJIGZpbmQgdGhlIHBhdGNoIHRvZGF5LiBJdCdzIHJlYWxseSBhIGJl
dHRlciBpZGVhci4NCg==

