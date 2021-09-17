Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD340F35E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhIQHit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 03:38:49 -0400
Received: from mail.bytesnap.co.uk ([94.198.185.106]:44380 "EHLO
        mail.bytesnap.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbhIQHis (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 03:38:48 -0400
Received: from exch2016.ByteSnap.local (10.0.28.253) by
 exch2016.ByteSnap.local (10.0.28.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 08:37:24 +0100
Received: from exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0]) by
 exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0%8]) with mapi id
 15.01.2308.014; Fri, 17 Sep 2021 08:37:24 +0100
From:   Ville Baillie <VilleB@bytesnap.co.uk>
To:     "Dan.Sneddon@microchip.com" <Dan.Sneddon@microchip.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Index: AderDWrzqf5xpvNgRsOaMaLInBknhQADbUMAAB7deyA=
Date:   Fri, 17 Sep 2021 07:37:24 +0000
Message-ID: <1129421de3174d00a5b03af00fbdd9cb@bytesnap.co.uk>
References: <3804cb61226e433fb1f7cde911a2785a@bytesnap.co.uk>
 <748547ec-43bc-a6a1-f5fa-d717e7637ce1@microchip.com>
In-Reply-To: <748547ec-43bc-a6a1-f5fa-d717e7637ce1@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.27.202]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pkxvb2tzIGxpa2UgdGhlIHNhbWUgY2hhbmdlIHNob3VsZCBiZSBtYWRlIGF0IHRoZSBlbmQgb2Yg
dGhhdCBzYW1lIGZ1bmN0aW9uIHdoZXJlIHRoZSBjYWxsIHRvIGF0bWVsX3NwaV9kbWFfdW5tYXBf
eGZlciBpcyBtYWRlLg0KDQpUaGFua3MgRGFuLCBJIHRoaW5rIHlvdSBhcmUgY29ycmVjdC4gSSB3
aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggYW5kIHNlbmQgaXQgb3V0IGFzIFYyLg0KDQpDaGVlcnMNClZp
bGxlDQo=
