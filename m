Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BB218C7D
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgGHQDy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 12:03:54 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19261 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgGHQDx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 12:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594224233; x=1625760233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AnErN4u1RKf/uAJ2hPXwE332+8yg//KZ+Posz3vV5Ew=;
  b=M3lslppQHz2gM80YET6ztKp1MZBjUi6KJdN6APx4MtEs0AGkTKywJKHi
   hcoxmTgssIu18hhVxgo7ZegtRg8nnJ0ozqv9bNtBE9s/y/Bs8kinfKUYa
   TsgAFrUNWh7FyzGjI9OCOFpGVZ+mBk8M8CHBoPqHIRAr0rClEn7JWUn6/
   TfEo0YtPP9PPg4jZye12cUSPuuDNj4tFnaNB5u6gfQiiQOIBL2MtGbz1r
   U8nLnhrqNOm8BnqPdj8NRc3m91KpSH39FlqkHRwFU3zvG2wIFl2O58g2O
   mWjMIEw/cY2aBOz8hwqRm24oQS+1DGBnQu/NwcAQ/N8P/LrBr/1XyasS9
   Q==;
IronPort-SDR: olXbXUk8CbIM2J11neeomo8fEqaQ6y5SedBrWoH3grAA6CYNqSmyHhQYndwZSzGLGFm5W9x7zh
 uk8ZdtICFbdalhObI+rSvfkeArQmRt3IXDlETwsUO10R38BthE2y/YffTJ+S+FkSFkIlCszhbT
 lCpd9ODw+mTGYw6JlDqLx/nvZS0Ae/2/DEn0kcSTF+MpnOIErHV3bPe472QmJU9D0Vb/I5D9P2
 mkHUWB3wSNYUZcGY4t0RGKyHEaE7ef0Vlv0lP+yqXCBJ4RtdjPI9LhjwrnyHvJXDeTXOHF5Ixz
 3YU=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="79169684"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 09:03:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 09:03:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 8 Jul 2020 09:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR/fnwTPgmSKb+b13eGHpieaZMQoYhYJKpRSBSU2d92w0JDkteYVKY7MCE4K7AjftAJCTm5HNZ1c1268l5BAIFlgY9DtrPqZynHEAv1cpVhuS1N7Gf6UKrHwxTe3NjDDo0elAYQCAPx6SCoyW+Uir+isvSQczg8Ck79M9H7Sus9b/osnj9QkrHXgD8MlI23It2LZVnqbDjfmK7/Zqht3MMhjNX+4nDe09u2SKwKABs5UZobKGVr9aPgvY3wHUULgY0Dks4a+5MNcQeGJg97vIH3oUTp97LctF+6D4Q1aTJowVWzx2dQfaHRPIq3fTUJUCQTPBgZXgPFJNilqqZV6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnErN4u1RKf/uAJ2hPXwE332+8yg//KZ+Posz3vV5Ew=;
 b=PEhlF4L/PSQ0Kb/1t9B7aJGdFdbKqCUPSA3RATGo0Mp5Waxr/YcU13GhyfeRUAmjcy+Bn1Uy4rwTIwxFoUOm/38HW8kXVhpx/LuBvCarC65tU05fG2hmkDU8IqCEmuYe+PQi3JbeHT9fJOxlzCnQ8nLkVJDnKmcQiWbHAeZiGJkC4vdSv+n5h0Ck5QhGS53+mH/5LSmrH44HeBE5FNLJpwjaMBZpcp26r5E7XjYVM9eLS78cHN0FG9DSdvyLopQkS/7/CoxyUMZud8P2S3gL4LxJRmL5ycwK8eFfd6net0hbsK5zwriR0InP5DbuuXGLr8+ajmANBNpcPtAqBKk9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnErN4u1RKf/uAJ2hPXwE332+8yg//KZ+Posz3vV5Ew=;
 b=IuwNzazA/lKysCRZhhjNjbJJAMUim63+f41L5ByrWo2FGhgmUBa6ZhWzw6P6seX+JxYXiFKbI5m5FSC1A0qi2asyjoy+Z8XF5bmg6sWdpbWkHSUKHskseZ7Jg3ph/W9x5K1sXaqPkNQ2APAupgVTXovwObmxtl7sTUJ/jNoeONQ=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 16:03:47 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 16:03:47 +0000
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
Subject: Re: [PATCH v10 08/17] mtd: spi-nor: core: use dummy cycle and address
 width info from SFDP
Thread-Topic: [PATCH v10 08/17] mtd: spi-nor: core: use dummy cycle and
 address width info from SFDP
Thread-Index: AQHWVUFcjtrXlk7Bh0yQOzcibPIurg==
Date:   Wed, 8 Jul 2020 16:03:47 +0000
Message-ID: <d4b5178e-debb-1397-caae-f20086f5c3fc@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-9-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-9-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 488e016b-bd31-4fe4-ad22-08d823587f83
x-ms-traffictypediagnostic: BY5PR11MB3958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39582C230037EB49E77EC04CF0670@BY5PR11MB3958.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niKiimRN7BdP7CxVJmd2YDcfqW3VEwxH8epZujYhRC1J0EvwkknB0mh9TQshPG5zC1BjMgc5+uzg9hPyJHBqGCbpAziS3k6nivOKnLID6looKjbkB7BRqUdSoUjgZXeotAgBud5dswRTL+WiYR4NMKZcamp2e/hD8ZHvj4TJZV9pL5Dgrd+r6BH6F/3HBWhKRDL8I5M/mkgF/8uEmCwzKaqcv958BIIGFivMQRLftanr26gTfRQ2cFcAqX4Fs8AGcYMqx6v7liutdLO+XfI8FAYWwLs4k6+x6RO/q9wfENwptzJ4Qb092F10NbAnEuxIrHb2HlFixiswc2YdaHs1ZyGavPAS4iL0IVa7uHEaoBJxzVTXU3YhZNlpaQLhSL1wa2AT7RJaDpHle8JGvUTWGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(110136005)(316002)(6486002)(8676002)(2616005)(71200400001)(8936002)(478600001)(91956017)(66556008)(66476007)(5660300002)(64756008)(66446008)(66946007)(76116006)(31696002)(2906002)(186003)(4326008)(26005)(7416002)(6512007)(31686004)(83380400001)(86362001)(54906003)(36756003)(53546011)(6506007)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fDa+Ctj2hKV1gmG1otu9xIUaLhr2ivl/o3VTVcsddrpercky8eXHlvkzmfpYSG7AGnS+zuYbo5SqSXBZ8clEt0/8jXuemYbLBHm59KULw7jN9WSiWd70+KruZlzzgxcUekRXcPDlSzmihC5kcQjB84fYlJ7X002DghTW8bbZnh7BVSs/OS8oyiicS+7xdD4c2T3DXR3eCgF1HjF/7DgcSMypO92JwS+JZir+frvwkxcjej+rQUSQRlIOFTXapXIaZW+FTTnKMg739lz8hjv1HEaouRH0Z+UPC7HqXhu0D4lUrdT+M86KRZlZt3vYgq7Gu9rP9XlkUoAwSUuY2LmQF6aotuvFBS56RNONkQ9/c1QjN4lT+KsYdo6GlhNWD1/0oUtHDnXxZ7SBQWcP8c6FN5EEdoM4Cz4TIp7V70PjU2OGB49sRTt5+HxAXnHV/pwTdbnwYZzxs3WoeIGCtSo1SuzTE7P8DJEMDc7EyIkeynU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52858E4A70C6AF4F9B260B65206915F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488e016b-bd31-4fe4-ad22-08d823587f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 16:03:47.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6frkT+Y0NL6XnX+0s5WCFLWOB/ettI8UOqv0bDfxt9HtJ9PaVge/j5dQFbRL3IbgdL1fJOz9C99NAyiESrLlAOzDHdzI+KRDFl/fazqjJUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3958
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgeFNQSSBQcm9maWxlIDEuMCB0YWJsZSBz
cGVjaWZpZXMgaG93IG1hbnkgZHVtbXkgY3ljbGVzIGFuZCBhZGRyZXNzDQo+IGJ5dGVzIGFyZSBu
ZWVkZWQgZm9yIHRoZSBSZWFkIFN0YXR1cyBSZWdpc3RlciBjb21tYW5kIGluIG9jdGFsIERUUiBt
b2RlLg0KPiBVc2UgdGhhdCBpbmZvcm1hdGlvbiB0byBzZW5kIHRoZSBjb3JyZWN0IFJlYWQgU1Ig
Y29tbWFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRp
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXggN2QyNGU2M2ZjY2E4Li5m
Mjc0OGYxZDk5NTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBAIC0zNTcsNiArMzU3LDggQEAg
aW50IHNwaV9ub3Jfd3JpdGVfZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgc3RhdGlj
IGludCBzcGlfbm9yX3JlYWRfc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKnNyKQ0KPiAgew0K
PiAgICAgICAgIGludCByZXQ7DQo+ICsgICAgICAgdTggYWRkcl9ieXRlcyA9IG5vci0+cGFyYW1z
LT5yZHNyX2FkZHJfbmJ5dGVzOw0KPiArICAgICAgIHU4IGR1bW15ID0gbm9yLT5wYXJhbXMtPnJk
c3JfZHVtbXk7DQoNCm5vIG5lZWQgdG8gaW50cm9kdWNlIGxvY2FsIHZhcmlhYmxlcyBmb3IgYSBz
aW5nbGUgZGVyZWZlcmVuY2UNCg0KPiANCj4gICAgICAgICBpZiAobm9yLT5zcGltZW0pIHsNCj4g
ICAgICAgICAgICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wID0NCj4gQEAgLTM2NSwxMCArMzY3
LDIxIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4
ICpzcikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05P
X0RVTU1ZLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1Bf
REFUQV9JTigxLCBzciwgMSkpOw0KPiANCj4gKyAgICAgICAgICAgICAgIGlmIChzcGlfbm9yX3By
b3RvY29sX2lzX2R0cihub3ItPnJlZ19wcm90bykpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgb3AuYWRkci5uYnl0ZXMgPSBhZGRyX2J5dGVzOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBvcC5hZGRyLnZhbCA9IDA7DQoNCmlzbid0IGFkZHIgYWxyZWFkeSBpbml0aWFsaXplZCB0byAw
Pw0KDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wLmR1bW15Lm5ieXRlcyA9IGR1bW15Ow0K
PiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICBzcGlfbm9yX3NwaW1l
bV9zZXR1cF9vcChub3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KPiArDQo+ICAgICAgICAgICAg
ICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+ICAgICAgICAg
fSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAgIHJldCA9IG5vci0+Y29udHJvbGxlcl9vcHMtPnJl
YWRfcmVnKG5vciwgU1BJTk9SX09QX1JEU1IsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzciwgMSk7DQo+ICsgICAgICAgICAgICAgICBpZiAo
c3BpX25vcl9wcm90b2NvbF9pc19kdHIobm9yLT5yZWdfcHJvdG8pKQ0KPiArICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSAtRU5PVFNVUFA7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldCA9IG5vci0+Y29udHJvbGxlcl9vcHMtPnJlYWRfcmVn
KG5vciwgU1BJTk9SX09QX1JEU1IsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNyLCAxKTsNCj4gICAgICAgICB9DQoNCmRvZXNu
J3QgdGhpcyBiZWxvbmcgdG8gYSBwcmV2aW91cyBwYXRjaD8NCg0KPiANCj4gICAgICAgICBpZiAo
cmV0KQ0KPiBAQCAtMzg4LDYgKzQwMSw4IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX3NyKHN0
cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcikNCj4gIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX2Zz
cihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCAqZnNyKQ0KPiAgew0KPiAgICAgICAgIGludCByZXQ7
DQo+ICsgICAgICAgdTggYWRkcl9ieXRlcyA9IG5vci0+cGFyYW1zLT5yZHNyX2FkZHJfbmJ5dGVz
Ow0KPiArICAgICAgIHU4IGR1bW15ID0gbm9yLT5wYXJhbXMtPnJkc3JfZHVtbXk7DQo+IA0KPiAg
ICAgICAgIGlmIChub3ItPnNwaW1lbSkgew0KPiAgICAgICAgICAgICAgICAgc3RydWN0IHNwaV9t
ZW1fb3Agb3AgPQ0KPiBAQCAtMzk2LDYgKzQxMSwxMiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcmVh
ZF9mc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKmZzcikNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0RVTU1ZLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfREFUQV9JTigxLCBmc3IsIDEpKTsNCj4gDQo+
ICsgICAgICAgICAgICAgICBpZiAoc3BpX25vcl9wcm90b2NvbF9pc19kdHIobm9yLT5yZWdfcHJv
dG8pKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wLmFkZHIubmJ5dGVzID0gYWRkcl9i
eXRlczsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3AuYWRkci52YWwgPSAwOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBvcC5kdW1teS5uYnl0ZXMgPSBkdW1teTsNCj4gKyAgICAgICAg
ICAgICAgIH0NCj4gKw0KPiAgICAgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Ao
bm9yLCAmb3AsIG5vci0+cmVnX3Byb3RvKTsNCj4gDQo+ICAgICAgICAgICAgICAgICByZXQgPSBz
cGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+IC0tDQo+IDIuMjcuMA0KPiANCg0K
