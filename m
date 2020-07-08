Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704CB218C94
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgGHQKc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 12:10:32 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:20050 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGHQKc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 12:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594224631; x=1625760631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ggM0Ec9o3VtxgaiChxbjiOmWxBjsX71Py8u9L3AQ2n0=;
  b=HJmi0g34C87kGu3DRq4QgnmVWfNvec11cSOjsCMWQElZnsH8xedjFUd+
   qKOoNDGE9eB5urIaSIQ6HEDSQpLgcFwUESAsP2JSlKy1PH3w2RJYksAk1
   psIvFGt4odmAVDG+KvOhSVCpXrP/bSQ0cerJM6wpp9AqGew+1hyBTGj19
   +niQxIYYJqy9C1Qbj93E7TMrpUvpYPw7YDr7fkthFF+rOVe4A7sfvaGqA
   QaFBfgNy9QjcLMzVvUat4734fkms38DWzbzNdyCCtuskIlvwFrDc2Hpay
   J+XDEkLzmRBos/FkWwm3jEZEGL0freqwRTq0TglT7snV2hfbvVMgk71MF
   Q==;
IronPort-SDR: xv2gLDkjfNArzyNHKPIT6R8llbm1IbIVX8tkZ+TCvLgNp+WFN8TvcFiujx/wZUM363g+MiPZMt
 b99f0PTI5JRFOGbGpTvKZLKHwVZC/o1jjlUKKYwVBlxnwVTyj79xrfHkaucgblAMisN3HIvT65
 Eq/ni6n+oAbI2BlkB9STu0Ukwqx+1E1XRjSrgirEXHRNRJfR6WnSqNfQJJCMIzBNJY9smQ9Cxj
 1CiczylSwrHHtqRjyt40g6BC8VJRIMRlxf7wOdqyuEexVtA+cfmNYGd0LifhYh0x9GFgBrtcXB
 ZuY=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="79171833"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 09:10:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 09:10:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 8 Jul 2020 09:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbAOFPsy+BKZ5fQ3YaDaTB+ow0CHDJPjnSPdLlkE07Aqf1kFdoZ8Vp835I/7F52EzosTiZsmlkFiOJMZkP6pDiHPNOe3FdcSH5SfUXPk4Ma1lmn3khCAJv/dOhX6ZPYhk911tca5jk/mvbHG//+lwAwoMISttVZ3NXyw6bNEVkU8nLxY5oppfXbgBpKD10cH6sVunN/YI6l45SFswjdw5vCon2Tl6PTnlZTQ/JUq2ZGGkUayJAB0fX7H1y/sopRCg0UC7ig0Izs+7cQcV6wFqbZ7Plqg6gVrtG6bu+U7f9fRkU4YEbvUqN/kGlDiAiCbJKYv5MOIMu/7y4XXUbFfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggM0Ec9o3VtxgaiChxbjiOmWxBjsX71Py8u9L3AQ2n0=;
 b=i4aShXorkbHJWqHOKj0iBrEMs/iMPPOo0USv3PR1i2xVeSfu4mE7obXKvZe8u68zSVWySEBs/KRij9yITcmeGABDO+vNFN0PCtScEE2m6vuLJnnVgr2QyxmebX2Lnnb2CV4Pe9bvnVathyPc3FE6Kye2gdzhx1yiYt0z3h/FntTZKR0Z+ghkeNDkJoO/KdtqINwDNGXiKy3kHR5DMZz6rEuO+WSJqzUmWDmXs730InGRxBjCi2j3++G0ADsv6QwoMcSV4oCkXtkY8m4SFKLtIQZzcotU/Gvu0AixanLs3nskgc201J4PMBbSSfBmRjTlYqtDR0feEqCmfkHKhIhorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggM0Ec9o3VtxgaiChxbjiOmWxBjsX71Py8u9L3AQ2n0=;
 b=hRxflZnZmSjcIzyhzAs6ThW77HGuDtkjd5u/StFYb0wdYfGL3uHlEtztxATcOvJ4AzcolZHB7LKSK4FTpRMRIa0OZnIVbfM3ThL1DqkQHLvUCGhXsjzVlY4hxWuE36PkMrESlvY6bYzA2FJNgmnB2vOFi/qS7DBVbdKGnQh23tw=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3702.namprd11.prod.outlook.com (2603:10b6:a03:f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 16:10:28 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 16:10:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v10 13/17] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Topic: [PATCH v10 13/17] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Index: AQHWVUJL1YuQPPY7GUeYXQqfS3m8rw==
Date:   Wed, 8 Jul 2020 16:10:28 +0000
Message-ID: <ccc128f1-2e7b-e64f-c958-ad5cc272085a@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-14-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-14-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39206fc7-e3ff-4902-abb0-08d823596e49
x-ms-traffictypediagnostic: BYAPR11MB3702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3702566BEFDE19ED7AB2D7EDF0670@BYAPR11MB3702.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00kezQSJs2ujYWeGXDcW0vEPQpIPbbLYy/k2v1uCFK4J72IAoZ5wTOILKMM3eR3zm6kHR6jzJM/5nQmZILMHeCaxTHdj7I/hbuYD6Rick/E1BjLZSEv9RJwKGTZn/ijr8okCTNU8Zm9o3nxJzQolv4bhNQD2YQp//jWlhLQ+Z94s8LEcTE0gmtMn9vuvqpmCwAMP5nS23mu8N6UgepuL0/dtUFuEgiYJHOqu/i81LfHVt85rmqyq5mAJyDmkoKr6QlrmiKq3fQje0aa9F//p8rb7LR+urfeix62OFqRFt6ZpdqJPzVL8PnZ3hgL66hwHY4M09HMERpoDcbhaJtu+8qpzMwgdqNRqbuLBwomcRfspBv6kPmko41WSflhGGr7NoJbdVHBlpKejRjIRuOCU3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(7416002)(66446008)(66476007)(64756008)(110136005)(8676002)(53546011)(86362001)(26005)(71200400001)(316002)(6486002)(8936002)(2616005)(2906002)(54906003)(4326008)(6506007)(6512007)(5660300002)(186003)(31686004)(36756003)(66556008)(66946007)(31696002)(91956017)(76116006)(478600001)(83380400001)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ul7g6+WRaeURLWhU8gG//FWYbStiCkUzAxtnz2XKfHfCcCD0ZtdGl51xzODwvhQ5Hn7jmwGljO9oPpSNVaZcGMQubQZJmmy3SC/HopfhzvhnZQJIGTVrH/t9LmwoScCXP7VxvOL/GtNU6IL+HzK3snnPDF8yisCWC6vPAYhic/zsqahyVecv54MX4a8qsr0RQ6q9WU12++7yorwSnAxY9ruIXSBG9Jo6g+O3gzc8wiViMTJmfrHzv2uzCeLN1VQ1RHnz7vetSp1FIWmBCRm5FBUp+73pFe62+5tTyLUd8Ad5aobZCyQ2z7/O9cnVg9on5YtAyZtxQExFCcgFqFmT58ygEaRmanCu1363SmoA3cy3lPph/s5/qT80YIjcFuKHZUKtMiBMM0u8Dsf3bBbnw9FWqIDcKquFL9NF2mZ4PGnihXnmVchkb0iVehl4JkLoIali+tBq3ysaXYEkOMj8IQmryKqinWSqXOPMKjoBaaI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9AC9FF3E2816148A5D1C98C5A389205@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39206fc7-e3ff-4902-abb0-08d823596e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 16:10:28.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iKJDSSEgmQZdPWSLn6qs6LBGopAzpwma6tNeTydDx5ko5i7B2Sq9TngDfstu4cS1vEdCOL0+eF+Rgt1MujRiAbXamIpIlkUoOlS/DfOem4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3702
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBQZXJmb3JtIGEgU29mdCBSZXNldCBvbiBzaHV0
ZG93biBvbiBmbGFzaGVzIHRoYXQgc3VwcG9ydCBpdCBzbyB0aGF0IHRoZQ0KPiBmbGFzaCBjYW4g
YmUgcmVzZXQgdG8gaXRzIGluaXRpYWwgc3RhdGUgYW5kIGFueSBjb25maWd1cmF0aW9ucyBtYWRl
IGJ5DQo+IHNwaS1ub3IgKGdpdmVuIHRoYXQgdGhleSdyZSBvbmx5IGRvbmUgaW4gdm9sYXRpbGUg
cmVnaXN0ZXJzKSB3aWxsIGJlDQo+IHJlc2V0LiBUaGlzIHdpbGwgaGFuZCBiYWNrIHRoZSBmbGFz
aCBpbiBwcmlzdGluZSBzdGF0ZSBmb3IgYW55IGZ1cnRoZXINCj4gb3BlcmF0aW9ucyBvbiBpdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgfCA0MiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggfCAg
MiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuYw0KPiBpbmRleCA0YTFmNmIzNDM1MzQuLjI3YWQ5YmFiMDZkYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gQEAgLTQwLDYgKzQwLDkgQEANCj4gDQo+ICAjZGVmaW5lIFNQSV9OT1JfTUFYX0FE
RFJfV0lEVEggNA0KPiANCj4gKyNkZWZpbmUgU1BJX05PUl9TUlNUX1NMRUVQX01JTiAyMDANCj4g
KyNkZWZpbmUgU1BJX05PUl9TUlNUX1NMRUVQX01BWCA0MDANCj4gKw0KPiAgLyoqDQo+ICAgKiBz
cGlfbm9yX2dldF9jbWRfZXh0KCkgLSBHZXQgdGhlIGNvbW1hbmQgb3Bjb2RlIGV4dGVuc2lvbiBi
YXNlZCBvbiB0aGUNCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgZXh0ZW5zaW9uIHR5cGUu
DQo+IEBAIC0zMjAxLDYgKzMyMDQsNDEgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXQoc3RydWN0
IHNwaV9ub3IgKm5vcikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMg
dm9pZCBzcGlfbm9yX3NvZnRfcmVzZXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3sNCj4gKyAg
ICAgICBzdHJ1Y3Qgc3BpX21lbV9vcCBvcDsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiArDQo+ICsg
ICAgICAgb3AgPSAoc3RydWN0IHNwaV9tZW1fb3ApU1BJX01FTV9PUChTUElfTUVNX09QX0NNRChT
UElOT1JfT1BfU1JTVEVOLCA4KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9P
UF9OT19EVU1NWSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19BRERS
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0RBVEEpOw0KPiArICAg
ICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgJm9wLCBTTk9SX1BST1RPXzhfOF84X0RU
Uik7DQo+ICsgICAgICAgcmV0ID0gc3BpX21lbV9leGVjX29wKG5vci0+c3BpbWVtLCAmb3ApOw0K
PiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl93YXJuKG5vci0+ZGV2
LCAiU29mdHdhcmUgcmVzZXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKyAgICAgICAgICAgICAg
IHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBvcCA9IChzdHJ1Y3Qgc3BpX21l
bV9vcClTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9TUlNULCA4KSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgU1BJX01FTV9PUF9OT19BRERSLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBTUElfTUVNX09QX05PX0RBVEEpOw0KPiArICAgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29w
KG5vciwgJm9wLCBTTk9SX1BST1RPXzhfOF84X0RUUik7DQo+ICsgICAgICAgcmV0ID0gc3BpX21l
bV9leGVjX29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAg
ICAgICAgICAgICAgIGRldl93YXJuKG5vci0+ZGV2LCAiU29mdHdhcmUgcmVzZXQgZmFpbGVkOiAl
ZFxuIiwgcmV0KTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsN
Cj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFNvZnR3YXJlIFJlc2V0IGlzIG5vdCBpbnN0YW50
LCBhbmQgdGhlIGRlbGF5IHZhcmllcyBmcm9tIGZsYXNoIHRvDQo+ICsgICAgICAgICogZmxhc2gu
IExvb2tpbmcgYXQgYSBmZXcgZmxhc2hlcywgbW9zdCByYW5nZSBzb21ld2hlcmUgYmVsb3cgMTAw
DQo+ICsgICAgICAgICogbWljcm9zZWNvbmRzLiBTbywgc2xlZXAgZm9yIGEgcmFuZ2Ugb2YgMjAw
LTQwMCB1cy4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICB1c2xlZXBfcmFuZ2UoU1BJX05PUl9T
UlNUX1NMRUVQX01JTiwgU1BJX05PUl9TUlNUX1NMRUVQX01BWCk7DQo+ICt9DQo+ICsNCj4gIC8q
IG10ZCByZXN1bWUgaGFuZGxlciAqLw0KPiAgc3RhdGljIHZvaWQgc3BpX25vcl9yZXN1bWUoc3Ry
dWN0IG10ZF9pbmZvICptdGQpDQo+ICB7DQo+IEBAIC0zMjIwLDYgKzMyNTgsMTAgQEAgdm9pZCBz
cGlfbm9yX3Jlc3RvcmUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gICAgICAgICBpZiAobm9yLT5h
ZGRyX3dpZHRoID09IDQgJiYgIShub3ItPmZsYWdzICYgU05PUl9GXzRCX09QQ09ERVMpICYmDQo+
ICAgICAgICAgICAgIG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJPS0VOX1JFU0VUKQ0KPiAgICAgICAg
ICAgICAgICAgbm9yLT5wYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUobm9yLCBmYWxzZSk7DQo+
ICsNCj4gKyAgICAgICBpZiAobm9yLT5pbmZvLT5mbGFncyAmIFNQSV9OT1JfT0NUQUxfRFRSX1JF
QUQgJiYNCg0KV2h5IHRoaXMgbGltaXRhdGlvbj8gQ2FuJ3Qgd2UgbWFrZSB0aGUgc29mdHdhcmUg
cmVzZXQgYXZhaWxhYmxlIGZvciBhbGwNCnRoZSBtb2Rlcz8NCg0KPiArICAgICAgICAgICBub3It
PmZsYWdzICYgU05PUl9GX1NPRlRfUkVTRVQpDQo+ICsgICAgICAgICAgICAgICBzcGlfbm9yX3Nv
ZnRfcmVzZXQobm9yKTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKHNwaV9ub3JfcmVzdG9y
ZSk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIGIvaW5j
bHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+IGluZGV4IGNkNTQ5MDQyYzUzZC4uMjk5Njg1ZDE1
ZGMyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+IEBAIC01MSw2ICs1MSw4IEBADQo+ICAjZGVm
aW5lIFNQSU5PUl9PUF9DTEZTUiAgICAgICAgICAgICAgICAweDUwICAgIC8qIENsZWFyIGZsYWcg
c3RhdHVzIHJlZ2lzdGVyICovDQo+ICAjZGVmaW5lIFNQSU5PUl9PUF9SREVBUiAgICAgICAgICAg
ICAgICAweGM4ICAgIC8qIFJlYWQgRXh0ZW5kZWQgQWRkcmVzcyBSZWdpc3RlciAqLw0KPiAgI2Rl
ZmluZSBTUElOT1JfT1BfV1JFQVIgICAgICAgICAgICAgICAgMHhjNSAgICAvKiBXcml0ZSBFeHRl
bmRlZCBBZGRyZXNzIFJlZ2lzdGVyICovDQo+ICsjZGVmaW5lIFNQSU5PUl9PUF9TUlNURU4gICAg
ICAgMHg2NiAgICAvKiBTb2Z0d2FyZSBSZXNldCBFbmFibGUgKi8NCj4gKyNkZWZpbmUgU1BJTk9S
X09QX1NSU1QgICAgICAgICAweDk5ICAgIC8qIFNvZnR3YXJlIFJlc2V0ICovDQo+IA0KPiAgLyog
NC1ieXRlIGFkZHJlc3Mgb3Bjb2RlcyAtIHVzZWQgb24gU3BhbnNpb24gYW5kIHNvbWUgTWFjcm9u
aXggZmxhc2hlcy4gKi8NCj4gICNkZWZpbmUgU1BJTk9SX09QX1JFQURfNEIgICAgICAweDEzICAg
IC8qIFJlYWQgZGF0YSBieXRlcyAobG93IGZyZXF1ZW5jeSkgKi8NCj4gLS0NCj4gMi4yNy4wDQo+
IA0KDQo=
