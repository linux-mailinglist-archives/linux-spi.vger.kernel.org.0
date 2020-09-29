Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32D27D5D1
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgI2Se6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 14:34:58 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:8655 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgI2Se5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 14:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601404498; x=1632940498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UGkMVf664zrLR9iFUz4G3kQ2Emh/TkSyP14QzOeZeL0=;
  b=cokpnFWMrUIUlL1uSDoiKCZkaBuYCe/iTJJI+mkXH2YMuclWIw2U8yvt
   kJrPw1d55S52cXU/GoLEyPIrFjYxvR4cqpfX62FpEd2A5Rjh6K+etee/D
   Wmj9Z95+prZtKNRTzthNccHqQutArmVXnF0RaJTN6WbUMFRls2u+xKG4I
   Aog58v3NsTv3aYNu71aNvqKPt2m0sEfKoAYQ+wkEy7UCzegImQ+GSBP8u
   0Yce0mUKyLelueGuCYtSO7jPxHwpJtr9/Fn/RwqC7qGVVabH9Xh5Dwvvv
   R31wrSooaX50X9IKVVjDgeoSfJAT4skncaRI1XueFEd/gj7Ce+WUqGgl7
   g==;
IronPort-SDR: gAIVvBWUnEqy+fmO8tPBxgvKz6axVOhAI4KeFRCty+2dTXKBQJ4BjORaSb3Z2hgZQIfJZesdD2
 rZ2LYnqLX8h0Yj58HrPn6daM7/Z35KZX5Rn9VdubnFMrLFY8dUX6G4uRbid0ILUXmySWMlrg51
 kr7nkEJslbcxDpYlvlKTqqb+asqE34+Gi8yhT54lYBnGUe+RIdOcqJlD2fSwSUJ9wfDxWEU3EC
 IwTNv6ndMuFpL0B8MGySOelWPrGC1CgWNsFnhAd8VmrDD+dcSJoWaeYos05PXSP99npuvPL6yy
 ks8=
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="92836405"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 11:34:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 11:34:56 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 11:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULRXLvj2QjB7nEs4EGYcmv8p+wJTDgXXx8u9ev4O5f3w31+L30RlJPpDuKMhT7KXS5mJhHNBcISRYIuS7HNGejvyJZT56SG7PXrYOnFHdUfFj37zya+zhQggkQlmkENqVXpr29AfC0x0znKAGI+YnBHy1Evj4lbyHKN4mRkAW1GiwYe4XFJ1vjMvgNZvgT8AygabK2t/hJDx8LUYmlMB/cq7BNLZsf9W9bP02JWMCwaYgJW9B2iyr73dzpKjCz46SBprb6ocddmMrT3EY1fvI7MtIG1ipbIsVl4TxTT2T8UrYe9iVHg1eO1GKPNxO2s9o6CaoGG0QnqNacV3JmQCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGkMVf664zrLR9iFUz4G3kQ2Emh/TkSyP14QzOeZeL0=;
 b=ih0bqCOgpgg7Q73SsARznACDC2iPIBLgN9OnKVYkKpNAKfXkmodEt1r6+lRIbg/W5eYG7T7uqepsmaH81sAAfi5nwloZm4uU/SxV5dQ8YYIMcNptLSvWPGKZumbjpnq/sG22Ax4B8awbxqgjRHxi5mbtsaoK6dfXgb1PT1SAstBJp2I53oEpMy+3kMRP1eSk0LduMqlDNNp0wTyVco7jR7/DOSzKZfLH4FHYSQFlNlWE8scje22MSwZtfbAlm21B+NhVkrP60qu+IjkD0vC0WINrzMRlO1DWMfA6gmY/m8FoPYqCzzrTaBk94BJsdyWtHHF0LMSY2TZdpC29EleZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGkMVf664zrLR9iFUz4G3kQ2Emh/TkSyP14QzOeZeL0=;
 b=ZFEOrjINsm6yIQfBS7bCP83w/+ueMJH3shKhoVFHjfh5n7Y8GyjDyVpguROl2/FCFAve+wsJwlygAh5hDTYC1A+//6ciVIen2gNUJJKHg/u7jIRS2/6BA0+qLNow9Y2bdO4Va9vaxrXerbTUPNZKdiVryh5x9YzMeLGYEm+hHoI=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 18:34:52 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 18:34:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <me@yadavpratyush.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <nsekhar@ti.com>
Subject: Re: [PATCH v10 05/17] mtd: spi-nor: add support for DTR protocol
Thread-Topic: [PATCH v10 05/17] mtd: spi-nor: add support for DTR protocol
Thread-Index: AQHWVIVGo10ftuQ9H0mpaQ4YA8PU1w==
Date:   Tue, 29 Sep 2020 18:34:52 +0000
Message-ID: <184f757b-dadc-0fd9-67f2-4c5903ec9c5c@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-6-p.yadav@ti.com>
 <fbb3d7e7-75ed-dbf6-a975-2ae871bc9fbf@microchip.com>
 <20200721112951.rngfk7njubcsahzp@yadavpratyush.com>
 <f9a22bc5-35f6-9507-b0e7-dcbad51caea7@microchip.com>
 <20200929162943.qbnzmzgxb75wdpyo@ti.com>
In-Reply-To: <20200929162943.qbnzmzgxb75wdpyo@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1ce27db-24b7-49c7-1817-08d864a65af1
x-ms-traffictypediagnostic: DM5PR11MB1914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB191487AA9494804759AAEEFBF0320@DM5PR11MB1914.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XpZV9oFdt+qxQee67T9xxEHDWU5F+QPdWweMI7xo8a0dtCAzvCCLqzBrXfn45unqukOwjpFAJnBp0jd5vsl558z+EKN3252A5yCIz/lakvvanwX5oK7GaKGVTXNsVGakIH5bBGG0Ak5dq7p8RKi+d3iEH28CuiTRiBjDBTkW4IAAShwDKJ8Jm5H1i3DhJ9rpiEW5YB+D5Ouc//k1VvDuj2RpFLUCBSEUH1QT5wuW5Iu1SBYbP67EAm48GoXAYEqIG1viSM+SnlrO0R7+aUERefYD9CdxJobVfnOiTQILMEbeAxk5mZ8Lp4vlkTFt9lomSzmZJsrpKvalXiJm4BKlJjvi2rRM0/BInGvIrQUWyre7kKd+nyUv3hhq6Tw9NkHoxzeUTej8tWBBU1VrNm20aNFPLBlnAFgrY1iCKrVsWk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(31686004)(86362001)(478600001)(26005)(6916009)(186003)(31696002)(7416002)(66946007)(316002)(54906003)(4326008)(83380400001)(66446008)(66476007)(66556008)(64756008)(8676002)(2616005)(8936002)(6486002)(36756003)(91956017)(76116006)(5660300002)(2906002)(6512007)(6506007)(53546011)(71200400001)(43740500002)(352734003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IXfOl62T3cw+HPKB0rUTI+hoTrAWmFmc7IpBsGU5+vZwFLUc9cQqYqcGA6wB9Gny9zGkO+w0ukB8qSEXBEcTA3jf/Rb82caNnpo7mnCO2Io8Tqlbda74okBe+HpkP7Ju1JCcITYW2X4eOEb2urRJAGWtDZIlcj/zcQj3ksPzKZDKsLgAlnHbXKkFaBQ4Po8OpB6FLJtsHMuCrNqxyVEWCDr99QtWaqUzo0gfKYwy6SL/AQzurO0Jwr7YlCV8vFwiUkkFIxN9zjBvCJUe8jaEoB1OJNWxH8Uyo5wJyR6PSgIBP0v6Wo0WzIV1fVrg9B1XeBGZKduSLnz6oQobl3H+ViprWsYdeM8sc8WEo4wdAb6GEAxEJQaQ1B/tXL9L2sWEbO4kNoChkLWYVjbunIbtpVYgvjzA/3TzlFkTDhQUumMVZOdYl1fIkXIADcnLY7/1vHwMkiHxd1TSS5GDhqZeXjgi05jv7+HqPxfbBqNcU3/Eb2O8tr13G3tUYB32WRLMIUye2Q2tarnvFgnxb5d47az6emx6fHJEvV3Gm+iE7H2mMtbSJcTeHaiaRUFs3eimwSaiTBvI859ZrgS6RlGzSBEFDXSO6OvubkKolS2fySSU2qLcYgzCkjHSGaAtJYV4Q2hfJAFClMHJbQ2zWt/zNQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DA2A9213EBB004492088D5506B3737A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ce27db-24b7-49c7-1817-08d864a65af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 18:34:52.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6ayO7/Vk+p9Si3TeRSka2L5z++hHupR8pCWDU7nno2hfgcW3nI2ebg27gdIwX294EJrEXdMIv9kFSFnpmhIj2RFUXfMMf+sn2w77lAF1uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1914
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gOS8yOS8yMCA3OjI5IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyOS8wOS8yMCAwMzo0MlBNLCBUdWRvci5B
bWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSwgUHJhdHl1c2gsDQo+Pg0KPj4gSSdt
IHJlcGx5aW5nIHRvIHYxMCBzbyB0aGF0IHdlIGNvbnRpbnVlIHRoZSBkaXNjdXNzaW9uLCBidXQg
dGhpcyBhcHBsaWVzIHRvIHYxMyBhcyB3ZWxsLg0KPj4NCj4+IE9uIDcvMjEvMjAgMjoyOSBQTSwg
UHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+Pg0KPj4+Pj4gQEAgLTIzNjgsMTIgKzI1MTcsMTYgQEAg
c3BpX25vcl9zcGltZW1fYWRqdXN0X2h3Y2FwcyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1MzIgKmh3
Y2FwcykNCj4+Pj4+ICAgICAgICAgc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyICpwYXJh
bXMgPSBub3ItPnBhcmFtczsNCj4+Pj4+ICAgICAgICAgdW5zaWduZWQgaW50IGNhcDsNCj4+Pj4+
DQo+Pj4+PiAtICAgICAgIC8qIERUUiBtb2RlcyBhcmUgbm90IHN1cHBvcnRlZCB5ZXQsIG1hc2sg
dGhlbSBhbGwuICovDQo+Pj4+PiAtICAgICAgICpod2NhcHMgJj0gflNOT1JfSFdDQVBTX0RUUjsN
Cj4+Pj4+IC0NCj4+Pj4+ICAgICAgICAgLyogWC1YLVggbW9kZXMgYXJlIG5vdCBzdXBwb3J0ZWQg
eWV0LCBtYXNrIHRoZW0gYWxsLiAqLw0KPj4+Pj4gICAgICAgICAqaHdjYXBzICY9IH5TTk9SX0hX
Q0FQU19YX1hfWDsNCj4+Pj4+DQo+Pj4+PiArICAgICAgIC8qDQo+Pj4+PiArICAgICAgICAqIElm
IHRoZSByZXNldCBsaW5lIGlzIGJyb2tlbiwgd2UgZG8gbm90IHdhbnQgdG8gZW50ZXIgYSBzdGF0
ZWZ1bA0KPj4+Pj4gKyAgICAgICAgKiBtb2RlLg0KPj4+Pj4gKyAgICAgICAgKi8NCj4+Pj4+ICsg
ICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJPS0VOX1JFU0VUKQ0KPj4+Pj4gKyAgICAg
ICAgICAgICAgICpod2NhcHMgJj0gfihTTk9SX0hXQ0FQU19YX1hfWCB8IFNOT1JfSFdDQVBTX1hf
WF9YX0RUUik7DQo+Pj4+DQo+Pj4+IEEgZGVkaWNhdGVkIHJlc2V0IGxpbmUgaXMgbm90IGVub3Vn
aCBmb3IgZmxhc2hlcyB0aGF0IGtlZXAgdGhlaXIgc3RhdGUNCj4+Pj4gaW4gbm9uLXZvbGF0aWxl
IGJpdHMuIFNpbmNlIHdlIGNhbid0IHByb3RlY3QgZnJvbSB1bmV4cGVjdGVkIGNyYXNoZXMgaW4N
Cj4+Pj4gdGhlIG5vbiB2b2xhdGlsZSBzdGF0ZSBjYXNlLCB3ZSBzaG91bGQgZW50ZXIgdGhlc2Ug
bW9kZXMgb25seSB3aXRoIGFuDQo+Pj4+IGV4cGxpY2l0IHJlcXVlc3QsIGkuZS4gYW4gb3B0aW9u
YWwgRFQgcHJvcGVydHk6ICJ1cGRhdGUtbm9udm9sYXRpbGUtc3RhdGUiLA0KPj4+PiBvciBzb21l
dGhpbmcgc2ltaWxhci4NCj4+Pg0KPj4+IEkgd3JvdGUgdGhpcyBwYXRjaCB3aXRoIHRoZSBhc3N1
bXB0aW9uIHRoYXQgd2Ugd29uJ3QgYmUgc3VwcG9ydGluZz4gbm9uLXZvbGF0aWxlIGNvbmZpZ3Vy
YXRpb24gYXMgb2Ygbm93LiBJbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbnMgd2UNCj4+DQo+PiBJ
IHRoaW5rIHdlIGhhdmUgdG8gdGFrZSBjYXJlIG9mIHRoZSBzdGF0ZWZ1bCBmbGFzaGVzIG5vdywg
b3RoZXJ3aXNlIHdlJ2xsIHJpc2sNCj4+IHRvIGVuZCB1cCB3aXRoIHVzZXJzIHRoYXQgbGV0IHRo
ZWlyIGZsYXNoZXMgaW4gYSBtb2RlIGZyb20gd2hpY2ggdGhleSBjYW4ndCByZWNvdmVyLg0KPj4g
SSBtYWRlIHNvbWUgc21hbGwgUkZDIHBhdGNoZXMgaW4gcmVwbHkgdG8geW91ciB2MTMsIGxldCBt
ZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KPiANCj4gSSBoYXZlbid0IGdvbmUgdGhyb3VnaCB0aGVt
IHlldC4gV2lsbCBjaGVjayB0b21vcnJvdy4NCj4gDQo+Pj4gY2FtZSB0byB0aGUgY29uY2x1c2lv
biB0aGF0IGl0IGlzIG5vdCBlYXN5IHRvIGRldGVjdCB0aGUgZmxhc2ggaWYgaXQNCj4+PiBib290
cyBpbiBhbnkgbW9kZSBvdGhlciB0aGFuIDFTLTFTLTFTIFswXS4gU28gaWYgd2UgdXBkYXRlIG5v
bi12b2xhdGlsZQ0KPj4+IHN0YXRlLCB0aGUgZmxhc2ggd291bGQgYmUgdXNlbGVzcyBhZnRlciBh
IHJlYm9vdCBiZWNhdXNlIHdlIHdvbid0IGJlDQo+Pj4gYWJsZSB0byBkZXRlY3QgaXQgaW4gOEQg
bW9kZS4gSXQgZG9lc24ndCBtYXR0ZXIgaWYgdGhlIHJlc2V0IGxpbmUgaXMNCj4+PiBjb25uZWN0
ZWQgb3Igbm90IGJlY2F1c2UgaXQgd2lsbCByZXNldCB0aGUgZmxhc2ggdG8gdGhlIG5vbi12b2xh
dGlsZQ0KPj4+IHN0YXRlLCBhbmQgd2UgY2FuJ3QgZGV0ZWN0IGl0IGZyb20gdGhlIG5vbi12b2xh
dGlsZSBzdGF0ZS4NCj4+DQo+PiBjb3JyZWN0LCBzbyBhIHJlc2V0IGxpbmUgZm9yIHN0YXRlZnVs
IG1vZGVzIGRvZXNuJ3QgaGVscCBhbmQgdGhlIGNvbW1lbnQgZnJvbSB0aGUNCj4+IGNvZGUgc2hv
dWxkIGJlIHVwZGF0ZWQuIHMvc3RhdGVmdWwvc3RhdGVsZXNzDQo+IA0KPiBXZSBhcmUgdGFsa2lu
ZyBhYm91dCB0d28gZGlmZmVyZW50IGtpbmRzIG9mICJzdGF0ZSIgaGVyZS4gVGhlIHN0YXRlIHlv
dQ0KDQpSaWdodCwgSSB1c2VkICdzdGF0ZWZ1bCcgZm9yIGZsYXNoZXMgdGhhdCBlbnRlciBpbiBh
IFgtWC1YIG1vZGUgYnkgc2V0dGluZyBhDQpub24tdm9sYXRpbGUgYml0IGFuZCAnc3RhdGVsZXNz
JyBmb3IgdGhvc2UgdGhhdCBlbnRlciBpbiBhIFgtWC1YIG1vZGUNCnZpYSB2b2xhdGlsZSBiaXRz
Lg0KDQo+IGFyZSB0YWxraW5nIGFib3V0IGlzIHRoZSBwZXJzaXN0ZW50IHN0YXRlIG9mIHRoZSBm
bGFzaCBjb25maWd1cmVkIHZpYQ0KPiBub24tdm9sYXRpbGUgcmVnaXN0ZXJzLiBZZXMsIGEgcmVz
ZXQgbGluZSBkb2Vzbid0IGhlbHAgaW4gdGhhdCBjYXNlIGF0DQo+IGFsbC4NCj4gPiBUaGUgb3Ro
ZXIgc3RhdGUgaXMgdGhlIG5vbi1wZXJzaXN0ZW50IHN0YXRlIHdlIHNldCBvbiB0aGUgZmxhc2gu
IFVzaW5nDQo+IDFTLTFTLThEIG1vZGUgaXMgc3RhdGVsZXNzIGluIHRoZSBzZW5zZSB0aGF0IHdl
IGRpZG4ndCBjaGFuZ2UgYW55IHN0YXRlDQo+IG9uIHRoZSBmbGFzaCB0byBiZSBhYmxlIHRvIHVz
ZSB0aGlzIG1vZGUsIGFuZCBvbmx5IGhhZCB0byB1c2UgdGhlDQo+IGNvcnJlY3Qgb3Bjb2RlLiBJ
ZiB3ZSBleGVjdXRlIGEgMVMtMVMtMVMgY29tbWFuZCBuZXh0IGl0IHdpbGwgYWxzbyB3b3JrDQo+
IGJlY2F1c2UgdGhlIGZsYXNoIGlzIHN0aWxsIGludGVycHJldGluZyBvcGNvZGVzIGluIDFTIG1v
ZGUuIFVzaW5nDQo+IDhELThELThEIG9yIDRTLTRTLTRTIG1vZGUgaXMgc3RhdGVmdWwgYmVjYXVz
ZSB3ZSBkaWQgaGF2ZSB0byBjb25maWd1cmUNCj4gc29tZSBzdGF0ZSBvbiB0aGUgZmxhc2ggKHdo
aWNoIGNhbiB2ZXJ5IHdlbGwgYmUgdm9sYXRpbGUpLiBPbmNlIDhELThELThEDQo+IG9yIDRTLTRT
LTRTIG1vZGUgaXMgZW50ZXJlZCwgd2UgY2Fubm90IGV4ZWN1dGUgMVMtMVMtMVMgY29tbWFuZHMg
dW50aWwNCj4gd2UgcmVzZXQgdGhlIGZsYXNoIGJlY2F1c2Ugbm93IHRoZSBmbGFzaCBpcyBpbnRl
cnByZXRpbmcgY29tbWFuZHMgaW4gNFMNCj4gb3IgOEQgbW9kZS4gVGhpcyBtZWFucyB3ZSBpbnRy
b2R1Y2VkIHNvbWUgc3RhdGUgb24gdGhlIGZsYXNoLg0KPiANCj4gSGF2aW5nIGEgcmVzZXQgbGlu
ZSB3aWxsIG5vdCBoZWxwIGFnYWluc3QgdGhlIGZvcm1lciBidXQgd2lsbCBoZWxwDQo+IGFnYWlu
c3QgdGhlIGxhdHRlci4gSWYgdGhlIGZsYXNoIGlzIGluIGEgc3RhdGVmdWwgbW9kZSBsaWtlIDhE
LThELThEDQo+IHdpdGhvdXQgYSByZXNldCBsaW5lLCBhbiB1bmV4cGVjdGVkIHJlc2V0IGNvdWxk
IGxlYXZlIGJvb3Rsb2FkZXIgdW5hYmxlDQo+IHRvIGJvb3QgYmVjYXVzZSBpdCBpc3N1ZXMgdGhl
IGNvbW1hbmRzIGluIDFTLTFTLTFTIG1vZGUgdGhhdCB0aGUgZmxhc2gNCj4gY2Fubm90IGludGVy
cHJldC4gU28gZXZlbiBpZiB0aGUgc3RhdGUgd2Ugc2V0IGlzIHZvbGF0aWxlLCB3ZSBzdGlsbCB3
YW50DQo+IHRvIGF2b2lkIGRvaW5nIGl0IGlmIHRoZXJlIGlzIG5vIHJlc2V0IGxpbmUuDQo+IA0K
PiBTbyBJIHRoaW5rIHRoZSBjb2RlIGFuZCBjb21tZW50IHNob3VsZCBzdGF5IGFzIHRoZXkgYXJl
Lg0KDQpPay4gQ2hlZXJzLA0KdGENCg==
