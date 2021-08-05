Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD63E0DD2
	for <lists+linux-spi@lfdr.de>; Thu,  5 Aug 2021 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhHEFkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 01:40:11 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35018 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230405AbhHEFkL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Aug 2021 01:40:11 -0400
X-UUID: ae6d84afd5b1433a97fad107c3f1d3ee-20210805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iysGRkBA3I1DDFi54oZ4OInQV+8ljw933mvUY9ZHSjA=;
        b=rEuPM1rXzgqeYNRkc9KC5gHv+tEjH1uLvB5IUVR4YUxNvSJFzCWuTsxe/2sU/FqsNv9pyjBgWtBvkmXAQKKNdwo95pp/uDn4JRKNok0eTjKz/oq71JRoEUeBcgYONvUluX89C6zJLbx6Cfms6nXBgO5LipUG4pF/9GPKv3zK2eE=;
X-UUID: ae6d84afd5b1433a97fad107c3f1d3ee-20210805
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 823788249; Thu, 05 Aug 2021 13:39:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Aug 2021 13:39:52 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Aug 2021 13:39:51 +0800
Message-ID: <1628140993.20108.4.camel@mbjsdccf07>
Subject: Re: [PATCH v2 4/4] spi: tegra114: Fix set_cs_timing param
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <mason.zhang@mediatek.com>
Date:   Thu, 5 Aug 2021 13:23:13 +0800
In-Reply-To: <20210803141045.GN4668@sirena.org.uk>
References: <20210803102517.20944-1-Mason.Zhang@mediatek.com>
         <20210803141045.GN4668@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDE1OjEwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAwMywgMjAyMSBhdCAwNjoyNToxOFBNICswODAwLCBNYXNvbiBaaGFuZyB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoIGZpeGVkIHNldF9jc190aW1pbmcgcGFyYW0sIGJlY2F1c2UgY3Mg
dGltaW5nIGRlbGF5IGhhcw0KPiA+IGJlZW4gbW92ZWQgdG8gc3BpX2RldmljZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYXNvbiBaaGFuZyA8TWFzb24uWmhhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktdGVncmExMTQuYyB8IDggKysrKy0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IEVhY2ggaW5kaXZpZHVhbCBwYXRjaCBpbiB0aGUgc2VyaWVzIG5lZWRzIHRvIGJlIGJ1aWxkYWJs
ZSBieSBpdHNlbGYsIGlmDQo+IGFuIGVhcmxpZXIgY29tbWl0IGluIHRoZSBzZXJpZXMgY2F1c2Vz
IHRoaW5ncyB0byBmYWlsIHRvIGJ1aWxkIHRoZW4gdGhhdA0KPiBjb21taXQgbmVlZHMgdG8gYmUg
aW1wcm92ZWQgc28gdGhhdCB0aGlzIGRvZXNuJ3QgaGFwcGVuLiAgVGhpcyBzdXBwb3J0cw0KPiB0
aGluZ3MgbGlrZSBiaXNlY3Rpb24uDQo+IA0KPiBQbGVhc2UgYWxzbyBsb29rIGludG8gaG93IHlv
dSdyZSBzZW5kaW5nIHNlcmllc2VzLCB0aGVzZSBwYXRjaGVzIGFyZW4ndA0KPiB0aHJlYWRlZCB0
b2dldGhlciBhcyBub3JtYWwgYW5kIHRoZXJlJ3MgYSB3ZWlyZCAiKioqIiBpbiB0aGUgc3ViamVj
dCBvZg0KPiB0aGUgZmlyc3QgcGF0Y2guDQoNCg0KRGVhciBNYXJrOg0KDQoJVGhhbmtzIGZvciB5
b3VyIHN1Z2dlc3Rpb25zLCBJIGhhdmUgbWVyZ2VkIHBhdGNoIDIvMy80IGluIG9uZSBwYXRjaCB0
bw0KZW5zdXJlIGl0IGNhbiBiZSBidWlsdCBieSBpdHNlbGYuDQoJQW5kIEkgaGF2ZSB1cGRhdGVk
IHRoZSBwYXRjaCB2MywgYW5kIHJlbW92ZWQgdGhlICoqKiBpbnQgdGhlIGZpcnN0DQpwYXRjaC4N
Cg0KDQpUaGFua3MNCk1hc29uDQo=

