Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8818D3275F1
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 02:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhCABxn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Feb 2021 20:53:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231522AbhCABxm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Feb 2021 20:53:42 -0500
X-UUID: 8e960fac560f456494d8b6cd1179dce6-20210301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lZn0loMDBlLQ+v3do751492I2dJdgs8xXjuL08g8siA=;
        b=gq6r6V10aCF68AJenigWvFpZWPqzWNI94P+VCm9IH8Tm9VUZuXMp7869ymZ0QgXORF8RwPD2N4knVhGCh+71xOVxvDIGNaHp/DH1rcEJQb0aEnXNQ1PyC50LAbp6kS+eqrWe7exq58BrmA54zsUlhVXHW3SgubqJfJtewslQP7c=;
X-UUID: 8e960fac560f456494d8b6cd1179dce6-20210301
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 75423923; Mon, 01 Mar 2021 09:52:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Mar 2021 09:52:56 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Mar 2021 09:52:55 +0800
Message-ID: <1614563278.1578.6.camel@mbjsdccf07>
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hanks.chen@mediatek.com>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 1 Mar 2021 09:47:58 +0800
In-Reply-To: <20210226170705.GB4518@sirena.org.uk>
References: <20210226110109.30500-1-Mason.Zhang@mediatek.com>
         <20210226170705.GB4518@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RGVhciBNYXJrOg0KDQoJUGF0Y2ggMS8yIGlzIGluIHRoaXMgbGluazoNCglsa21sLm9yZy9sa21s
LzIwMjEvMi8yNi8zMjUNCglJIHdpbGwgZW1haWwgeW91IGxhdGVyIGFib3V0IHBhdGNoIDEvMi4N
CgkNCglUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbiENCg0KVGhhbmtzDQpNYXNvbg0KLS0t
LS0tLS0tLS0tLS0tLS0NCk9uIEZyaSwgMjAyMS0wMi0yNiBhdCAxNzowNyArMDAwMCwgTWFyayBC
cm93biB3cm90ZToNCj4gT24gRnJpLCBGZWIgMjYsIDIwMjEgYXQgMDc6MDE6MTBQTSArMDgwMCwg
TWFzb24gWmhhbmcgd3JvdGU6DQo+ID4gdGhpcyBwYXRjaCB1cGRhdGUgc3BpIGRvY3VtZW50IGZv
ciBNVDY3NzkgU09DLg0KPiANCj4gSSdtIG1pc3NpbmcgcGF0Y2ggMS8yIGhlcmUsIHdoYXQncyB0
aGUgc3Rvcnkgd2l0aCBkZXBlbmRlbmNpZXM/DQo+IA0KPiBQbGVhc2Ugc3VibWl0IHBhdGNoZXMg
dXNpbmcgc3ViamVjdCBsaW5lcyByZWZsZWN0aW5nIHRoZSBzdHlsZSBmb3IgdGhlDQo+IHN1YnN5
c3RlbSwgdGhpcyBtYWtlcyBpdCBlYXNpZXIgZm9yIHBlb3BsZSB0byBpZGVudGlmeSByZWxldmFu
dCBwYXRjaGVzLg0KPiBMb29rIGF0IHdoYXQgZXhpc3RpbmcgY29tbWl0cyBpbiB0aGUgYXJlYSB5
b3UncmUgY2hhbmdpbmcgYXJlIGRvaW5nIGFuZA0KPiBtYWtlIHN1cmUgeW91ciBzdWJqZWN0IGxp
bmVzIHZpc3VhbGx5IHJlc2VtYmxlIHdoYXQgdGhleSdyZSBkb2luZy4NCj4gVGhlcmUncyBubyBu
ZWVkIHRvIHJlc3VibWl0IHRvIGZpeCB0aGlzIGFsb25lLg0KDQo=

