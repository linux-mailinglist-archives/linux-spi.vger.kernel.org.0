Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4443A29D808
	for <lists+linux-spi@lfdr.de>; Wed, 28 Oct 2020 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgJ1W3B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Oct 2020 18:29:01 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:48543 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbgJ1W3A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 18:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603924141; x=1635460141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PG3BuBb6fhnAMRuIGMjnnLTCQ1TwiOigd1jmvLmaAq4=;
  b=AGmxvrL4B8HiF8lHDA5a4/EIg3XboPRO/qE49WBxaIkuy1HGCDuQxzPS
   05hZAQA2+5qHW0ZYaJCVj+OdEaKHgDvToX++z6I1Yg4AJ6+z1DfYoTQH+
   uh0IRYVO/RXczWyx3o9MdeI8a5e3/JqntSz65n+UMvrsA91fRpVDGOg2l
   /G1hBnjceTug6O4ueiufZ61bzYosSOoX89ea62pFIczV4/UrN7cMmxED0
   lIgeg/N7W5rmgeewBqgps1PMs/dYVntbgeYLvahKyjgoif9+mJlL7V/RJ
   StzlcUo9aKpCgbq2GziWH/L6QRTd6xWenY8DW9KxcH8F4SWxmXZKAxKEd
   Q==;
IronPort-SDR: h0JZJjUgFzhNcyzZfbHpEKilCIVApPLErjsd3PRdixbtMMvDkGOstLzyYiKGqq4KoY9DlvxtgN
 DZyc1VSLYZ+P5NghzzbRgbLYsQvFYT1ixK/nX1wqpFkFiFcRXMAbeSxGl2cyNeuR/SDiSR9jRJ
 jw5bqLY5lguDTRvEFi69JBb6loyEq7xuTVJ6UOU/1gje772TxAQ5qFhRvfQADWmqbtFXmE8c2V
 XRtfrepPS4Vw64G5UZ4YXM6qriWqgm3iU4h70c0eW7FehVgdR4wgI/0w3U5tlCWMnVTDwga7WS
 q4U=
X-IronPort-AV: E=Sophos;i="5.77,426,1596524400"; 
   d="scan'208";a="96276571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2020 03:25:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 03:25:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 28 Oct 2020 03:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0USuTs95DbKRXPAu8SuwBqe0gW4NF20CpD/GPyRnV8bci6tcp/VOHg2oPEYwEhdTm2e49K9c2ptcCEswQByOPlwp5v9+SclfA7f9SgXP0FYpC4Rh8D0iGcpGzOUlHaf9sPreJcI/qRYO2GyKNIY9Q2rGbdSS+BBjsU3CQl9Dl0c0+7Bb/0elfw6CD5d8T4FBlfOs+iVmdzlCaaC/ktcfKuFQ1DsObrK+2z8D0DVpowIA1JZpIx7pyoN+Y/AqPpgREr5nWNJXaZiIYreV+tsPujPgegPlWu0/qifMbBWUiT+pBDOwucxZDvCChIVOo2RSSUK1LLZ/UiADICE/chZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG3BuBb6fhnAMRuIGMjnnLTCQ1TwiOigd1jmvLmaAq4=;
 b=FJO+MZOkS4kYnVjKg2Ic5yVUUJPs/+BHxfSJ+CEKxrpOPLu0EkQ5NmeZYs98hvCJRdccOsBhJhrx4reNb0z8VfPtRr8r0gpxTJxxhYzYFntY49z+TVhmfK3DgPjZjkJBAj7hPmWS5sbJNMDxpczD03GEkyA/EhkK4MjukSBRxjy4/lqaprDkO5baB7aNPas3j/Y/O+/2SfilJe25q/IVJ+F1eOfmYrQ1fQyi7AQVCsSbLpNDjpbql7SZC19J0waikNuD5nrDDQh5EMnnLn2p5kayW9b+L8uc4syWrW2lhh6+e33EapZmprXAKQ1R8UHiUhVCjZa+Qat0HZA/NjZKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG3BuBb6fhnAMRuIGMjnnLTCQ1TwiOigd1jmvLmaAq4=;
 b=hk/gorIg+NNkHOqLlbEjlydvtRH/Excq5N1OIGY+MCEOPFc2zQ5w/Ytpce4PrPj1km0KzesVoZHJOjdAKuK7PaSZWAIDNWOkMMrY6RLOhESWSKqmgqwvjNLgaofawh7+FKN9tMDdVzBDHgEcb0+5NRuQhjLH+PR43XZ2tlb+rYQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4700.namprd11.prod.outlook.com (2603:10b6:303:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 10:25:25 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::413f:1b5f:5cec:3bb4]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::413f:1b5f:5cec:3bb4%7]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 10:25:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <masonccyang@mxic.com.tw>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <matthias.bgg@gmail.com>,
        <ycllin@mxic.com.tw>
CC:     <juliensu@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <p.yadav@ti.com>
Subject: Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D
 supports for Macronix mx25uw51245g
Thread-Topic: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D
 supports for Macronix mx25uw51245g
Thread-Index: AQHWrRSmDndyYSszbECSYL7OWHzFOw==
Date:   Wed, 28 Oct 2020 10:25:25 +0000
Message-ID: <e3bbdf22-9cb1-fd39-9bda-86147fc1f0f8@microchip.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 653bd488-56c6-4dba-834a-08d87b2bc8e9
x-ms-traffictypediagnostic: MW3PR11MB4700:
x-microsoft-antispam-prvs: <MW3PR11MB470055BDFE1DFA51EC064939F0170@MW3PR11MB4700.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0yr+/AAqtU784gxRUFrWF9y9acb3afj8U9gQ+9jPlDq3qJvGZs/lSmkR2AhZCfS/tkAxw8LoaaERX00eQnTsR/d6jFU8LhKnCs7KsA5cvJ9Gu/0fImtXAeJO7sPsZRvpPeBhdtRGBYmXPZjWAQY/F8TB3uFVkuETkuCdGqbqO6nt+H8JvbHKevTf6bUAKq0W5jeLINe70zJK8kpGrwZp9HClDUy1eJ6nP4tu9BDxWcj6moExPo0h5DpjlLPvtMhwzUC4rSL91RusMv+tMjH5/hg929V7NUejEFeFTwqLafAeGvuMJAmG1FGidIW0zLCYFRqwM1kSM4DM57gDZtGxp8WA+AuVnL6bvjLj/7zMpCO4I53dmBkv4kCc7CfeVixi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(91956017)(76116006)(6486002)(110136005)(54906003)(186003)(7416002)(71200400001)(478600001)(31696002)(26005)(53546011)(2616005)(8676002)(31686004)(6506007)(316002)(86362001)(8936002)(2906002)(36756003)(66476007)(4326008)(5660300002)(6512007)(66446008)(66946007)(66556008)(64756008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G98Lw1C1dE1dNv3pvWv23ahxMB9CQPicUvn3dNVPYSsJ4Z07kUx74mBa5nHNRs71qNr2TPxGKzZMXyEFsraXjKuEtylCJU4UMzBHMOQhxVs1gQjGyK1SKh+x4rC+0YEEqJ5tKDuqYLnnZcOqSRpFnEDcOfqniviiP1EI12RuvxcsQOVkTax0fwGE3J7x2Ndz5wYC1KvoD8kbuW5tU9BjRLV5obuYiYKRGAFw0oGNwCQ3PFwASinb2pDPYjT6WqvYP4tSQYt3WEoplrv2R0vOlkWrXLJweFEtT8pockzjOqciHKxDnPH7IGuj00LgWvvAHPcmNGjj0U94ycs07Om+ikw9nR+D94mo0vX4ijIV99xZ+5bhP1LrKv3nbHmpwAfbT/ISO/D6Pt5B1K8+uQ1W7HkaBrf7jcwkv/qX5FXNAYNFmbdEDSmtnuP9SMYka2KFRztixji0yK3gGs+cbYYWTD5uHsdWmmi/JfQFdr3DyRZKuEGnEnCOChnHRVwQDojgXmRZ6saY2MO7P5EzDIYQn6kSTz5qPu6+uOosG1YJB3Zq1TrgbHGw5gIOHIAzk8c/SKx2fq137sAjvNtKSMx53io3KlOB5bvetwdiR6+WKCN827iovCoozL6mMyF9WE7iFBCY1Odc8kKdnDnuD7IPFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1219999BFA9FA149AB04EFCE8239AF20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653bd488-56c6-4dba-834a-08d87b2bc8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 10:25:25.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjiRjs7SVCefuM1+LVRBoGxTc36Zifk2SaHpKeWwSw812m3sZfeP89ee68p9aEntJJMPJt8vu/KVapiqSh8wND8Uw+r+NUiBbEqgyihslt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4700
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hc29uLCBZQyBMaW4sDQoNCk9uIDUvMjkvMjAgMTA6MzYgQU0sIE1hc29uIFlhbmcgd3Jv
dGU6DQo+IE1hY3Jvbml4IG14MjV1dzUxMjQ1ZyBpcyBhIFNQSSBOT1IgdGhhdCBzdXBwb3J0cyAx
LTEtMS84LTgtOCBtb2RlLg0KPiANCj4gQ29ycmVjdCB0aGUgZHVtbXkgY3ljbGVzIHRvIGRldmlj
ZSBmb3IgdmFyaW91cyBmcmVxdWVuY2llcw0KPiBhZnRlciB4U1BJIHByb2ZpbGUgMS4wIHRhYmxl
IHBhcnNlZC4NCj4gDQo+IEVuYWJsZSBteDI1dXc1MTI0NWcgdG8gT2N0YWwgRFRSIG1vZGUgYnkg
ZXhlY3V0aW5nIHRoZSBjb21tYW5kIHNlcXVlbmNlcw0KPiB0byBjaGFuZ2UgdG8gb2N0YWwgRFRS
IG1vZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXNvbiBZYW5nIDxtYXNvbmNjeWFuZ0BteGlj
LmNvbS50dz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMgfCA1NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9tYWNyb25peC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+IGluZGV4
IDk2NzM1ZDguLjZjOWEyNGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWFj
cm9uaXguYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMNCj4gQEAgLTgs
NiArOCw1NyBAQA0KPiAgDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgDQo+ICsjZGVmaW5lIE1Y
SUNfQ1IyX0RVTU1ZX1NFVF9BRERSIDB4MzAwDQo+ICsNCj4gKy8qIEZpeHVwIHRoZSBkdW1teSBj
eWNsZXMgdG8gZGV2aWNlIGFuZCBzZXR1cCBvY3RhX2R0cl9lbmFibGUoKSAqLw0KPiArc3RhdGlj
IHZvaWQgbXgyNXV3NTEyNDVnX3Bvc3Rfc2ZkcF9maXh1cHMoc3RydWN0IHNwaV9ub3IgKm5vcikN
Cj4gK3sNCj4gKwlzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9IG5vci0+
cGFyYW1zOw0KPiArCWludCByZXQ7DQo+ICsJdTggcmRjLCB3ZGM7DQo+ICsNCj4gKwlyZXQgPSBz
cGlfbm9yX3JlYWRfY3IyKG5vciwgTVhJQ19DUjJfRFVNTVlfU0VUX0FERFIsICZyZGMpOw0KDQpu
b3ItPmJvdW5jZWJ1ZiBpcyBETUEtYWJsZSwgdXNlIGl0IGluc3RlYWQgb2YgcmRjDQoNCj4gKwlp
ZiAocmV0KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKiBSZWZlciB0byBkdW1teSBjeWNsZSBh
bmQgZnJlcXVlbmN5IHRhYmxlKE1IeikgKi8NCj4gKwlzd2l0Y2ggKHBhcmFtcy0+ZHVtbXlfY3lj
bGVzKSB7DQo+ICsJY2FzZSAxMDoJLyogMTAgZHVtbXkgY3ljbGVzIGZvciAxMDQgTUh6ICovDQo+
ICsJCXdkYyA9IDU7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMTI6CS8qIDEyIGR1bW15IGN5Y2xl
cyBmb3IgMTMzIE1IeiAqLw0KPiArCQl3ZGMgPSA0Ow0KPiArCQlicmVhazsNCj4gKwljYXNlIDE2
OgkvKiAxNiBkdW1teSBjeWNsZXMgZm9yIDE2NiBNSHogKi8NCj4gKwkJd2RjID0gMjsNCj4gKwkJ
YnJlYWs7DQo+ICsJY2FzZSAxODoJLyogMTggZHVtbXkgY3ljbGVzIGZvciAxNzMgTUh6ICovDQo+
ICsJCXdkYyA9IDE7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMjA6CS8qIDIwIGR1bW15IGN5Y2xl
cyBmb3IgMjAwIE1IeiAqLw0KPiArCWRlZmF1bHQ6DQo+ICsJCXdkYyA9IDA7DQo+ICsJfQ0KPiAr
DQo+ICsJaWYgKHJkYyAhPSB3ZGMpDQo+ICsJCXNwaV9ub3Jfd3JpdGVfY3IyKG5vciwgTVhJQ19D
UjJfRFVNTVlfU0VUX0FERFIsICZ3ZGMpOw0KPiArDQo+ICsJaWYgKHBhcmFtcy0+Y21kX3NlcVsw
XS5sZW4pIHsNCj4gKwkJcGFyYW1zLT5vY3RhbF9kdHJfZW5hYmxlID0gc3BpX25vcl9jbWRfc2Vx
X29jdGFsX2R0cjsNCj4gKwkJcGFyYW1zLT5od2NhcHMubWFzayB8PSBTTk9SX0hXQ0FQU19SRUFE
XzhfOF84X0RUUjsNCj4gKwkJcGFyYW1zLT5od2NhcHMubWFzayB8PSBTTk9SX0hXQ0FQU19QUF84
XzhfOF9EVFI7DQo+ICsNCj4gKwl9IGVsc2Ugew0KPiArCQlwYXJhbXMtPm9jdGFsX2R0cl9lbmFi
bGUgPSBOVUxMOw0KPiArCQlwYXJhbXMtPmh3Y2Fwcy5tYXNrICY9IH5TTk9SX0hXQ0FQU19SRUFE
XzhfOF84X0RUUjsNCj4gKwkJcGFyYW1zLT5od2NhcHMubWFzayAmPSB+U05PUl9IV0NBUFNfUFBf
OF84XzhfRFRSOw0KPiArCX0NCj4gK30NCj4gKw0KPiArc3RhdGljIHN0cnVjdCBzcGlfbm9yX2Zp
eHVwcyBteDI1dXc1MTI0NWdfZml4dXBzID0gew0KPiArCS5wb3N0X3NmZHAgPSBteDI1dXc1MTI0
NWdfcG9zdF9zZmRwX2ZpeHVwcywNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBpbnQNCj4gIG14MjVs
MjU2MzVfcG9zdF9iZnB0X2ZpeHVwcyhzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgCQkJICAgIGNv
bnN0IHN0cnVjdCBzZmRwX3BhcmFtZXRlcl9oZWFkZXIgKmJmcHRfaGVhZGVyLA0KPiBAQCAtODQs
NiArMTM1LDEwIEBADQo+ICAJCQkgICAgICBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gIAl7ICJt
eDY2bDFnNTVnIiwgIElORk8oMHhjMjI2MWIsIDAsIDY0ICogMTAyNCwgMjA0OCwNCj4gIAkJCSAg
ICAgIFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiArCXsgIm14MjV1dzUxMjQ1ZyIsIElORk8oMHhj
MjgxM2EsIDAsIDY0ICogMTAyNCwgMTAyNCwNCj4gKwkJCSAgICAgIFNFQ1RfNEsgfCBTUElfTk9S
XzRCX09QQ09ERVMgfA0KPiArCQkJICAgICAgU1BJX05PUl9PQ1RBTF9EVFJfUkVBRCkNCg0Kb2N0
YWwgZHRyIHBhZ2UgcHJvZ3JhbSBpcyBzdXBwb3J0ZWQ/DQoNCj4gKwkJCSAgICAgIC5maXh1cHMg
PSAmbXgyNXV3NTEyNDVnX2ZpeHVwcyB9LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIHZvaWQgbWFj
cm9uaXhfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+IA0KDQpDaGVlcnMsDQp0
YQ0K
