Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7A3DEB91
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhHCLJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 07:09:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50960 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234156AbhHCLJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 07:09:32 -0400
X-UUID: 3c6a25b1029e4b4aa70ff42139fa2d9d-20210803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Od2MpSzeMLHI3T1P4xyf0dSDDK91tD2ThNe34CdzcnA=;
        b=jyA4hJK21e5yEMZ0ze3OF6owXdCH0LuOLSAY7NPZPhWxc+IYPlif/MYOi0bxrXLrJqbj1a5st6TF9BwVln6iQwPGu3vYTd3Xs/wLph68Yh3qwBthHMep5Y92mL44QOXl/zDLLs2cASOV4Ja36fWTEsHjupUrS0IZ/CmZzE0NExI=;
X-UUID: 3c6a25b1029e4b4aa70ff42139fa2d9d-20210803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 985537256; Tue, 03 Aug 2021 19:09:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 19:09:18 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 19:09:17 +0800
Message-ID: <1627987970.27248.4.camel@mbjsdccf07>
Subject: Re: [PATCH 2/3] spi: modify set_cs_timing parameter
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 3 Aug 2021 18:52:50 +0800
In-Reply-To: <1627960488.7721.2.camel@mbjsdccf07>
References: <20210719091642.24633-1-mason.zhang@mediatek.com>
         <20210802201614.GA39900@sirena.org.uk> <1627960488.7721.2.camel@mbjsdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDExOjE0ICswODAwLCBNYXNvbiBaaGFuZyB3cm90ZToNCj4g
RGVhciBNYXJrOg0KPiANCj4gCUkgaGF2ZSBmaXhlZCB0aGlzIGJ1aWxkIGVyciBpbiB0aGlzIHBh
dGNoOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc3BpLzIwMjEwODAzMDIx
MzI4LjI4MjkxLTEtTWFzb24uWmhhbmdAbWVkaWF0ZWsuY29tL1QvI3UNCj4gDQo+IA0KPiBUaGFu
a3MNCj4gTWFzb24NCg0KRGVhciBNYXJrOg0KDQoJSSBoYXZlIHN1Ym1pdCB0aGlzIGNoYW5nZSBz
ZXBhcmF0ZWx5LCBidXQgc3RpbGwgaGF2ZSBidWlsZCBlcnIsIHNvIEkNCmhhdmUgdXBkYXRlZCB0
aGUgcGF0Y2ggdjIgYXMgYmVsb3c6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNw
aS8yMDIxMDgwMzEwMjIyOC4yNTM1LTEtTWFzb24uWmhhbmdAbWVkaWF0ZWsuY29tL1QvI3UNCg0K
VGhhbmtzDQpNYXNvbg0K

