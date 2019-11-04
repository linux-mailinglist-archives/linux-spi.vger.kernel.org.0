Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBEED6A7
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 01:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfKDAf1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Nov 2019 19:35:27 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43460 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbfKDAf0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Nov 2019 19:35:26 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EC198365A;
        Mon,  4 Nov 2019 13:35:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572827725;
        bh=yocSiiBQ9FgtpVwNhm3bz8iYAE4rW+HfdIVcEnTMEY0=;
        h=From:To:CC:Subject:Date;
        b=QyxtAkCgFk+jFQK5b5y8sqCOwU1N5i9azNzey+7bZRCodDMjjuEI42bhOIyyOLk1g
         OItKO+MGLwevhkUzbWzn2tthSU6PllDkW3rq2UgV9DxEfq7X16XivIkwB4XldehSGt
         Hwnk2vPPCKimtiAtyNqDZyAA81DN15IMz5RKjyXVpNgYnn8IN5o12cbql7ZwJB/uaI
         49dnGoHBR5vHAk26VyAOLAmpgcLFmlfv//4bSsUFk53b5Eyb35e+92PHiJr9rOeXzk
         d8FpsQ1cHzTU1sGB1QFFbCED9uID1lOGzcKZqNjsgpZpvE+iyjMr6qYljlHWFII+6p
         nyLn8CsltFoaw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dbf724c0000>; Mon, 04 Nov 2019 13:35:24 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 4 Nov 2019 13:35:25 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 4 Nov 2019 13:35:25 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: spi-mem and gpio chipselects
Thread-Topic: spi-mem and gpio chipselects
Thread-Index: AQHVkqe/99KPV78Qa0mRy221SIO+EA==
Date:   Mon, 4 Nov 2019 00:35:24 +0000
Message-ID: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:c5c6:9a61:cb8f:b19f]
Content-Type: text/plain; charset="utf-8"
Content-ID: <514C190899003245AAB7FC3F5C117648@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksDQoNCkknbSB3b3JraW5nIG9uIGEgcGxhdGZvcm0gdGhhdCBoYXMgYSBzbGlnaHRseSBjb21w
bGljYXRlZCBzY2hlbWUgZm9yDQpTUEkgY2hpcC1zZWxlY3RzIHVzaW5nIGdwaW9zWzFdLiBUaGUg
c3BpIGNvbnRyb2xsZXIgZHJpdmVyIGluIHRoaXMgY2FzZQ0Kc3VwcG9ydHMgdGhlIHNwaS1tZW0g
b3BlcmF0aW9ucyB3aGljaCBhcHBlYXIgdG8gYnlwYXNzIHRoZSBnZW5lcmljDQpzcGlfc2V0X2Nz
KCkuDQoNCldvdWxkIHRoZXJlIGJlIGFueSBoYXJtIGluIGFkZGluZyBjYWxscyB0byBzcGlfc2V0
X2NzKCkgdG8gc3BpLW1lbS5jPw0KTmFpdmVseSBzcGlfbWVtX2FjY2Vzc19zdGFydCgpIGFuZCBz
cGlfbWVtX2FjY2Vzc19lbmQoKSBzZWVtIGxpa2UNCmNvbnZlbmllbnQgcGxhY2VzIHRvIHN0YXJ0
Lg0KDQotLQ0KWzFdIC0gc2ltaWxhciBkZXNpZ24gdG8gDQpodHRwczovL21hcmMuaW5mby8/bD1s
aW51eC1zcGkmbT0xNTU1MDQ1Mzc2Mjg2MzUmdz0yIGJ1dCBhIGRpZmZlcmVudA0KcGxhdGZvcm0u
DQo=
