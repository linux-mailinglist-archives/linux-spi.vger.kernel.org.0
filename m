Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F22227FE0
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgGUMXk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 08:23:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59813 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728557AbgGUMXk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 08:23:40 -0400
X-UUID: 40f2cfce92c94a44a2a1fcc5608db344-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fjg7nMNQVLp7jHAziQfjeWpWwhYiATooWUXF/1IXayU=;
        b=oOkEf3hAxACP+8aU9ajnmJQ3VHqbsBO0NGaLnQXHUcXsipANTE7t6Zl92VIp4XVBFsWPOtxlwGX5YBrbiIzo5InMM5k5MLVQTIX2a2aFosDIlmAHMcXWl67glxeoOo0uL62kqy+FFqw7V5z7om5RdZamuS8xFg6gxweBzsFtQxU=;
X-UUID: 40f2cfce92c94a44a2a1fcc5608db344-20200721
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 768022660; Tue, 21 Jul 2020 20:23:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 20:23:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 20:23:26 +0800
Message-ID: <1595334144.31408.0.camel@mhfsdcap03>
Subject: Re: [PATCH] dt-bindings: spi: update bindings for MT8192 SoC
From:   lei liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Tue, 21 Jul 2020 20:22:24 +0800
In-Reply-To: <20200721094859.GB4845@sirena.org.uk>
References: <20200721024819.7150-1-leilk.liu@mediatek.com>
         <20200721094859.GB4845@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 68EB313837D36780FC0EDA997D82074C7AB48D5FE3646CEC1E13DEF30727FA492000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDEwOjQ4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEp1bCAyMSwgMjAyMCBhdCAxMDo0ODoxOUFNICswODAwLCBMZWlsayBMaXUgd3JvdGU6
DQo+ID4gRnJvbTogImxlaWxrLmxpdSIgPGxlaWxrLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gQWRkIGEgRFQgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciB0aGUgTVQ4MTkyIHNvYy4NCj4g
DQo+IEknZCBleHBlY3QgdG8gc2VlIGEgbWF0Y2hpbmcgZHJpdmVyIHBhdGNoLg0KDQpPSyxJJ2xs
IHNlbmQgcGF0Y2ggdjIuIFRoYW5rcy4NCg==

