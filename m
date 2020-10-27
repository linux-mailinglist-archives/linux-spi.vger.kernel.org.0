Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36A29BEF1
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814678AbgJ0Q62 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 12:58:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:16121 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814576AbgJ0Q5n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Oct 2020 12:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603817862; x=1635353862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Oz6vPe+Tcxbk49QYHwTFCGCx69BqOPi7aAxn4P3J+Tc=;
  b=xVYk+34UvR3y+mileygwqWedvcn5tHn4FU4yAJoRhZfeo9C85hvvIpEx
   FL0uQmiW/vpqF6WDeX1ZRF3ByrGqTOzubFEcLOFVmle1Qb6cs/rqJemEU
   PVbbv3OCn6yJpQ8L7wFofkiXeC/cYkfZ5GtjRhwIhPQQNNbTA+Z1hrLR3
   mjGFvLVc4Eo7u7DStAR2jLTMSaV3+BcA1jyR8UNcS+RjOhVQ51WQDzakM
   cIYbmQzPCZ+5gMNPpGsjcp/9yL66p5ytBc2/i9KO7+tyrw9YPYibGIm6g
   sJ+46s6bFJ/wM0f+45K/1ymt2qKin5JJTXeVm0FR+Rvp+VUiQVaeKW1Os
   g==;
IronPort-SDR: kyoJrtkov2lwodQIKIr2XCFHZV445XP5m4zoPRVTQFwYntz7tcXQd2/dDzg/pj2dCV2yqK2c2X
 nVZ58/q2l/q+wH5E1moTWMT9uFi3udotY/GVt9T05HeUWClD7trzlLhHgOH5JMAyRYERfBbxxS
 1WxqErFyMY2D0F4Mw6R9TRDLeBqj/q1z7t52pZKxcUcZLZE44UEMdwA8G54heZ6fequ8oyvQhX
 25x2q6Z46eiMiJSK9/K5PanPcF7pNiZuztzFGiMDBfjw1ym2BJxuDGkzLp7m3U6Y3h6NN41KnR
 1a8=
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="101126710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Oct 2020 09:57:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 09:57:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 27 Oct 2020 09:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4ww42BW7CDTPQbKdHuPWE+YIzwj7xW5vjPhYLfNToxqcMn1hG4pfjyZYcuelL+EKu68w4GGU2H8RQaa6CUX5HBpW7MoyXHdS9FagPVNl8vJ89k7v2Xhf+VValrZiLFjCEwuZa/vsztgwqIfjIlK+sU3AzkIowEccAWNxnNUueP9ABZVkMOVM7hQuKP02h9WqlNXZDMHLaf/8/OjoUS+S6U1VP/33ChEduUU1HH5wLpnwVJbcGhsa6O+QJkGbg2VJhpMkdjb11q+Mrha98nHXo3a/KbMJCI6U6g4CL/mtj6AIMXMd30sou02uCy63+Q9EwGZRQvxGGCbSI+1ldVTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz6vPe+Tcxbk49QYHwTFCGCx69BqOPi7aAxn4P3J+Tc=;
 b=bWcri2RdJ460MTirnjvNV84E6rF2JatIF8u2GGT0N/XcY84mbvZInu3XOMulNYE0rOXYtPUHtzmc33mvjZZ5D9NQQ4GoaIV5EpBKtG+S61PIOw49GBf65TEA4ybkfSv4e7eDj1rjsYIrq4WOlwYqjdjDEkfTdWgvKqK0KONWOacgE0znlv96niZTmQGLrXozL0w0yevwtp2sqnxydSfds/JMNa4ClJbq8DT25UPmo+dTty+pvyKIKfoJfpSlgCiEhd/1uCx5b+pBT4Xx4djm/Vx9TVNpUWTAOL9tVgExhmHzvwVBLnSoL/gP/sZao0UKgDYUe6aX+OfVLJcEUm/rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz6vPe+Tcxbk49QYHwTFCGCx69BqOPi7aAxn4P3J+Tc=;
 b=jhNbB2EnHD7Ie1WKW40cWb+HwfkemB2Bgxf8COi5PMzq3mx19az8OnTLoXn2o7SzCLMXQDgHxVIEMK4epfwrDp/sFlgGuIYT2o5lrTCyD9IO5L2hmZKrOWCkt9IHX+VeLZ7uZ3HQBxT4wm/+P11suCZUngYuyQ4eGutRlS5oTRE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2736.namprd11.prod.outlook.com (2603:10b6:805:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 16:57:39 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 16:57:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <masonccyang@mxic.com.tw>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <matthias.bgg@gmail.com>
CC:     <juliensu@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <p.yadav@ti.com>, <ycllin@mxic.com.tw>
Subject: Re: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed
 from BFPT
Thread-Topic: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed
 from BFPT
Thread-Index: AQHWrIJF/cj+GvvkW023XwftDkioRg==
Date:   Tue, 27 Oct 2020 16:57:38 +0000
Message-ID: <5df6d950-d47e-daec-cd06-d6a1880457e7@microchip.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw>
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
x-ms-office365-filtering-correlation-id: 072ea670-c413-45fe-818b-08d87a99695a
x-ms-traffictypediagnostic: SN6PR11MB2736:
x-microsoft-antispam-prvs: <SN6PR11MB27361BAB36F54B037E7DACF2F0160@SN6PR11MB2736.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIYTYEKrp0NB6HcsOXepxPjylce1vpeZrn4jV7tlUqZvsCuMtWFztqjfbxJQs2/TgTiLMeYtMC1AMyslvm8E3wT9s1i3DBGGRwc+p4Yl2lZmwORqUg8FsYtrj8Cx//byR75NCguoFLQ+hOh2IOqCCz+xTlHdyU35pnFVp4g+S1cvGD2Ux0wL7r/G8ZhUV5g7zPF/HQXrTLV03FMC1gGEqxdrADH6JtyL33CegDMfPoCeYin5tf5QdJpQNLXrozSheUBQKC0nFdxnwqRFzRcO4r9ni1Qc4iqfoQ9eP7+pO3yEsKhslc9zAvamWezBdaHUdBAUnkc5fNcYr4t1571L1069FwbUiqhAWKFJSi7I5rPBS4vebTwB34BuFkLhpotR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(186003)(86362001)(31696002)(31686004)(6512007)(478600001)(2906002)(316002)(5660300002)(36756003)(110136005)(54906003)(2616005)(8936002)(76116006)(8676002)(6506007)(64756008)(53546011)(26005)(6486002)(66446008)(71200400001)(66476007)(4326008)(66556008)(7416002)(83380400001)(66946007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0avYsMubjX7Z2gRqdu/bC7xu/h9ZNQKJqqKwBD8zwlX0PEXDAAFGCjjeQqdcASoBAoh2/cIYLRY+t0yWomLR/AZdcvaCXVoZXRPSHcYxP3YCkE0qefdtRcGIwdInaJj8oo5EJKHoMzbyenaJi+G0H2hebjs2KrCdUT8o11auX8XC88UyB4j2FZtmL0hZNRVmosadwVSvdVmq1zTmtdNGO8KoSFYTpTYwkXkr0L6e383YviBdyUf5QSLoZlBYFCAs63AThzQVwYkQgp4Efp+nxwCOroLxy0JBrP4rc7EPaWCchn56pF1AmouND5tJ4XmHTCOhZH+8uvJtZ98zsZrjaT0CQGEu4CRc/cCxgpypR3TwGvA8aMIENu7YPobt4sYdt2o4mtEYaK17kGCqYe59mIxH/HQAFR/3utYqDZYU8yEFwUvEL8+uDb0XL5oH9Zg83HQGbRfxbkFl7UgT0jQ8idPFE1qufIvzRx+teY/AJyrlLrdJd84Hva3RztG1ihjdxPexOrNnHMgHxqJq+dLabuTuak+feJ7ZmyYhiB3lYowha3ihLaYC66Tpwl/ti4xu4cFEgCAUjj/KGRwB/we3pTTBKRYk8GzWP9q/p6biFp72MuPWmfVG+3uX6dOSObKSbc5NmpoAGRpZIF4g+so7xA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43FCA5A58C850543833509D8686986CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072ea670-c413-45fe-818b-08d87a99695a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 16:57:38.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nieTu174f8DiqLfzyI+Zru+/0YAQZMOQvFGpCao0inbj165GQsgJya+qgSqgTQMUaX5Smzko9GEK95xQRYlX7RgCkoQhV3hLT8qGRiqiCI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2736
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hc29uLCBZQyBMaW4sDQoNCk9uIDUvMjkvMjAgMTA6MzYgQU0sIE1hc29uIFlhbmcgd3Jv
dGU6DQo+IEdldCBtYXhpbXVtIG9wZXJhdGlvbiBzcGVlZCBvZiBkZXZpY2UgaW4gb2N0YWwgbW9k
ZSBmcm9tDQo+IEJGUFQgMjB0aCBEV09SRC4NCj4gDQoNCkkgd291bGQgbGlrZSB0byB1bmRlcnN0
YW5kIGhvdyB3b3VsZCB3ZSB1c2UgdGhlIG1heCBzcGVlZCB2YWx1ZQ0KYXQgdGhlIFNQSSBOT1Ig
bGV2ZWwuIFRoZSBtYXhpbXVtIG9wZXJhdGlvbiBzcGVlZCBpcyB0eXBpY2FsbHkgdXNlZA0KdG8g
ZGV0ZXJtaW5lIHRoZSBudW1iZXIgb2YgZHVtbXkgY3ljbGVzLCB3aGljaCBpcyBkZXNjcmliZWQg
aW4geFNQSQ0KU3BlYyBmb3Igc3BlZWRzIG9mIDIwMCBNSHogb3IgbGVzcy4gRXZlbiBpZiBCRlBU
W2R3b3JkMjBdIGRlc2NyaWJlcw0Kc3VwcG9ydGVkIHNwZWVkcyB1cCB0byA0MDAgTUh6LCBpdCBk
b2Vzbid0IGluZGljYXRlIHRoZSBudW1iZXIgb2YNCnJlcXVpcmVkIGR1bW15IGN5Y2xlcy4gV2hh
dCBudW1iZXIgb2YgZHVtbXkgY3ljbGVzIHdvdWxkIHdlIHVzZSBmb3INCnNwZWVkcyBoaWdoZXIg
dGhhbiAyMDAgTUh6Pw0KDQpXZSBtYXkgYmUgdGVtcHRlZCBob3dldmVyIHRvIHBhc3MgdGhlIG1h
eF9zcGVlZF9oeiB0byB0aGUgU1BJTUVNIGxheWVyLA0Kc28gdGhhdCB0aGUgY29udHJvbGxlciBj
YW4gc3luYyB3aXRoIHRoZSBtZW1vcnkgdG8gY2hvb3NlIHRoZSBiZXN0DQphdmFpbGFibGUgc3Bl
ZWQuDQoNCkNoZWVycywNCnRhDQoNCj4gU2lnbmVkLW9mZi1ieTogTWFzb24gWWFuZyA8bWFzb25j
Y3lhbmdAbXhpYy5jb20udHc+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgg
fCAgMiArKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgfCAzNiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5oIHwg
IDQgKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuaA0KPiBpbmRleCA2ZjJmNmIyLi43YTM2YjIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0K
PiBAQCAtMTkwLDYgKzE5MCw3IEBAIHN0cnVjdCBzcGlfbm9yX2xvY2tpbmdfb3BzIHsNCj4gICAq
DQo+ICAgKiBAc2l6ZToJCXRoZSBmbGFzaCBtZW1vcnkgZGVuc2l0eSBpbiBieXRlcy4NCj4gICAq
IEBwYWdlX3NpemU6CQl0aGUgcGFnZSBzaXplIG9mIHRoZSBTUEkgTk9SIGZsYXNoIG1lbW9yeS4N
Cj4gKyAqIEBvY3RhbF9tYXhfc3BlZWQ6CW1heGltdW0gb3BlcmF0aW9uIHNwZWVkIG9mIGRldmlj
ZSBpbiBvY3RhbCBtb2RlLg0KPiAgICogQGh3Y2FwczoJCWRlc2NyaWJlcyB0aGUgcmVhZCBhbmQg
cGFnZSBwcm9ncmFtIGhhcmR3YXJlDQo+ICAgKgkJCWNhcGFiaWxpdGllcy4NCj4gICAqIEByZWFk
czoJCXJlYWQgY2FwYWJpbGl0aWVzIG9yZGVyZWQgYnkgcHJpb3JpdHk6IHRoZSBoaWdoZXIgaW5k
ZXgNCj4gQEAgLTIxMiw2ICsyMTMsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9sb2NraW5nX29wcyB7DQo+
ICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgew0KPiAgCXU2NAkJCQlzaXplOw0KPiAg
CXUzMgkJCQlwYWdlX3NpemU7DQo+ICsJdTE2CQkJCW9jdGFsX21heF9zcGVlZDsNCj4gIA0KPiAg
CXN0cnVjdCBzcGlfbm9yX2h3Y2FwcwkJaHdjYXBzOw0KPiAgCXN0cnVjdCBzcGlfbm9yX3JlYWRf
Y29tbWFuZAlyZWFkc1tTTk9SX0NNRF9SRUFEX01BWF07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IGluZGV4
IGY2MDM4ZDMuLjRkMTNmNjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2Zk
cC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IEBAIC00LDYgKzQsNyBA
QA0KPiAgICogQ29weXJpZ2h0IChDKSAyMDE0LCBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciwgSW5j
Lg0KPiAgICovDQo+ICANCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb3J0Lmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvbXRkL3NwaS1ub3IuaD4NCj4gQEAgLTI2LDYgKzI3LDEyIEBADQo+ICAjZGVmaW5l
IFNGRFBfSkVTRDIxNkFfTUlOT1IJNQ0KPiAgI2RlZmluZSBTRkRQX0pFU0QyMTZCX01JTk9SCTYN
Cj4gIA0KPiArLyogQmFzaWMgRmxhc2ggUGFyYW1ldGVyIFRhYmxlIDIwdGggRFdPUkQsIE1heCBv
cGVyYXRpb24gc3BlZWQgb2YgZGV2aWNlICovDQo+ICtzdHJ1Y3Qgb2N0YWxfbWF4X3NwZWVkIHsN
Cj4gKwl1OCBpZHg7IC8qIEJpdHMgdmFsdWUgKi8NCj4gKwl1MTYgaHo7IC8qIE1IeiAqLw0KPiAr
fTsNCj4gKw0KPiAgc3RydWN0IHNmZHBfaGVhZGVyIHsNCj4gIAl1MzIJCXNpZ25hdHVyZTsgLyog
T3g1MDQ0NDY1M1UgPD0+ICJTRkRQIiAqLw0KPiAgCXU4CQltaW5vcjsNCj4gQEAgLTQ0MCw2ICs0
NDcsMjIgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5v
ciwNCj4gIAl1MzIgYWRkcjsNCj4gIAl1MTYgaGFsZjsNCj4gIAl1OCBlcmFzZV9tYXNrOw0KPiAr
CXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2N0YWxfbWF4X3NwZWVkIG1heF9oeltdID0gew0KPiArCQkv
KiBCaXRzIHZhbHVlLCBNSHogKi8NCj4gKwkJeyAweDBjLCA0MDAgfSwNCj4gKwkJeyAweDBiLCAz
MzMgfSwNCj4gKwkJeyAweDBhLCAyNjYgfSwNCj4gKwkJeyAweDA5LCAyNTAgfSwNCj4gKwkJeyAw
eDA4LCAyMDAgfSwNCj4gKwkJeyAweDA3LCAxNjYgfSwNCj4gKwkJeyAweDA2LCAxMzMgfSwNCj4g
KwkJeyAweDA1LCAxMDAgfSwNCj4gKwkJeyAweDA0LCAgODAgfSwNCj4gKwkJeyAweDAzLCAgNjYg
fSwNCj4gKwkJeyAweDAyLCAgNTAgfSwNCj4gKwkJeyAweDAxLCAgMzMgfSwNCj4gKwl9Ow0KPiAr
CXU4IGlkeDsNCj4gIA0KPiAgCS8qIEpFU0QyMTYgQmFzaWMgRmxhc2ggUGFyYW1ldGVyIFRhYmxl
IGxlbmd0aCBpcyBhdCBsZWFzdCA5IERXT1JEcy4gKi8NCj4gIAlpZiAoYmZwdF9oZWFkZXItPmxl
bmd0aCA8IEJGUFRfRFdPUkRfTUFYX0pFU0QyMTYpDQo+IEBAIC02MDQsNiArNjI3LDE5IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAJCXJl
dHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIA0KPiArCS8qIE9jdGFsIG1vZGUgbWF4IHNwZWVkICov
DQo+ICsJaWR4ID0gbWF4KEZJRUxEX0dFVChCRlBUX0RXT1JEMjBfT0NUQUxfRFRSX01BWF9TUEVF
RCwNCj4gKwkJCSAgICBiZnB0LmR3b3Jkc1tCRlBUX0RXT1JEKDIwKV0pLA0KPiArCQkgIEZJRUxE
X0dFVChCRlBUX0RXT1JEMjBfT0NUQUxfU1RSX01BWF9TUEVFRCwNCj4gKwkJCSAgICBiZnB0LmR3
b3Jkc1tCRlBUX0RXT1JEKDIwKV0pKTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKG1heF9oeik7IGkrKykgew0KPiArCQlpZiAobWF4X2h6W2ldLmlkeCA9PSBpZHgpIHsNCj4g
KwkJCXBhcmFtcy0+b2N0YWxfbWF4X3NwZWVkID0gbWF4X2h6W2ldLmh6Ow0KPiArCQkJYnJlYWs7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4gc3BpX25vcl9wb3N0X2JmcHRfZml4dXBz
KG5vciwgYmZwdF9oZWFkZXIsICZiZnB0LCBwYXJhbXMpOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2Zk
cC5oDQo+IGluZGV4IGUwYThkZWQuLjhhZTZkOWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5oDQo+IEBA
IC04Myw2ICs4MywxMCBAQCBzdHJ1Y3Qgc2ZkcF9iZnB0IHsNCj4gICNkZWZpbmUgQkZQVF9EV09S
RDE1X1FFUl9TUjJfQklUMV9OT19SRAkJKDB4NFVMIDw8IDIwKQ0KPiAgI2RlZmluZSBCRlBUX0RX
T1JEMTVfUUVSX1NSMl9CSVQxCQkoMHg1VUwgPDwgMjApIC8qIFNwYW5zaW9uICovDQo+ICANCj4g
KyNkZWZpbmUgQkZQVF9EV09SRDIwX09DVEFMX01BWF9TUEVFRF9NQVNLICAgICAgIEdFTk1BU0so
MzEsIDE2KQ0KPiArI2RlZmluZSBCRlBUX0RXT1JEMjBfT0NUQUxfRFRSX01BWF9TUEVFRCAgICAg
ICAgR0VOTUFTSygzMSwgMjgpDQo+ICsjZGVmaW5lIEJGUFRfRFdPUkQyMF9PQ1RBTF9TVFJfTUFY
X1NQRUVEICAgICAgICBHRU5NQVNLKDE5LCAxNikNCj4gKw0KPiAgc3RydWN0IHNmZHBfcGFyYW1l
dGVyX2hlYWRlciB7DQo+ICAJdTgJCWlkX2xzYjsNCj4gIAl1OAkJbWlub3I7DQo+IA0KDQo=
