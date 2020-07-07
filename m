Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18552175A9
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGRx6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 13:53:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41131 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRx5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 13:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594144436; x=1625680436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xw3S66fEfd0VyI9qKTQXhyZ7GPkfglwR1Iz3vv7GzgA=;
  b=cAEhRHrfy/P2eGhxS0QWjd8netzflmPd1U5G4nKGbU2yrGih/CvnpTEx
   SNZUQq+2pBlkblMWCI2IUz5qkG/inBV5M8piyDco/pa8hZT0nBUnSSHAS
   ko6Gzz5ua+lb9ovHQlpk+4uCV84dIwnpyfKhp30ed18l8j/e7f03CsofQ
   MXVfG4CeXXaLlOKHvoyvobLWxUjJV7CtSBQtFl7Yy6NTol8T4DDpQjy6e
   o4ISm6MBtM6AhtUVFDWcRtwX7uN9L5xeiUSLod4sIlvnP1c0rYknoGRHk
   eRXAFCbkpOStzQS3Zqui3IqDwFodzhfKX26P1iow1bRNhAMJ3h+DVt7c7
   g==;
IronPort-SDR: LlC/qQARs+D2uv4qzIglbdwKS9ccHrlKHiXS9fRVPe64hwtkD6NgZO5u/+FXwIQhHbNEPQ2YWj
 VLTbUdKoMnMjI9Ht6touEZEusBO5igjg9Tx776AMjHjT7XxbizBm0IhQrUhhDwekxlYoHV+eeT
 ruw7FDHNLtZwNzsY9A9gvUo4B1qCcslqDbMo4527QkJK6vY7Mivm169oY2gQKUgFSeCuuoFCbZ
 2m+Z1Z/IwsSgfQsaiEo1l48h4Xnzk0XBhftgDpXHFp5LCi2UT0rwdnXs4KYJaklsEavZlM6Q5W
 cis=
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="79051977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2020 10:53:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 7 Jul 2020 10:53:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 7 Jul 2020 10:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYWIJMySPYGVtpsZF+3X2S0cn28sPHE0OsuKcz6VfrPHmGTpeNmxt1a02ZRX0VdbRQVDLTmOK1NkPkLrCt49d3SBPJkzSQhyr/rztWu0FrYgHhFKWwem7CUruahVZ4caS6MjBBpcHdg86uuq6395Gnfg5kF7QUpQYSYV+RfJn5D55Aatp/fCscmg9Q+BS2t50jdzf8ao8GkrHhDozOl5IvSeU3BZb6OdTmi9jZFpflgv4bXtEkIUm69GrReed+0nDkdTMmF0KSwU3ibXt60GyzMhPaWa7KfOwoEp1ZpyZkWthfYNYUc+LAuJ8KASOryeXMoDXVmwhtUIQ0JRRut4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw3S66fEfd0VyI9qKTQXhyZ7GPkfglwR1Iz3vv7GzgA=;
 b=W7RahP2UFxw9bWgwYpxnTuEMel9xT7Hvf76uTN+fyIjh1AKRuftZqJdjairoFJ6QPJxODFIEVvFHi/+EWTbnVRzm2LVNT5U6ik9Hrlix/yRY1itXDdWG/3GiVr7WwsuVIUWgEuoVQu1b2itf5E7ibkISXP9FME0evtqBDawx5cYVemT5cahnlkIYX6bQCqKuZPXLIJozEBmWqN8QD/l5vMIz1JsuBXal5BZLUCQohJxbq0SCYBCqyzR+T6Iufr/LgY8bOOM6oFXl+l9dKx7rl9ZPmGG5B49j0w1quQGwONsPGomB/YFtqQXe2UYGt8Z5qxvCiWscRyjwyE9RPJ7P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw3S66fEfd0VyI9qKTQXhyZ7GPkfglwR1Iz3vv7GzgA=;
 b=PfoR7rJGKAl6oywFcY3r9h/1ekXyBpaPsL658PCKEoIDc2ETP4QQ2ZruWXaoD52PTxAOA4GUnPzEPgoZS7B7Hin34PgEjJsL8MlLHHmoqWoYIb9O8KC3YDXSCjZ8/beRnwKLAxy7ZqwDS44yeHsZYjqxoI1tk81zGT15dk6C1Zw=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 17:53:53 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 17:53:52 +0000
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
Subject: Re: [PATCH v10 06/17] mtd: spi-nor: sfdp: get command opcode
 extension type from BFPT
Thread-Topic: [PATCH v10 06/17] mtd: spi-nor: sfdp: get command opcode
 extension type from BFPT
Thread-Index: AQHWVIeTPEfqRDg7DkGG9JINhim1sA==
Date:   Tue, 7 Jul 2020 17:53:52 +0000
Message-ID: <a8513b6b-4780-e854-897b-6b6364606bce@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-7-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-7-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39db2f43-6be0-4f45-23fa-08d8229eb630
x-ms-traffictypediagnostic: BY5PR11MB4024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4024FA5ADEDDD2C564A4BB5AF0660@BY5PR11MB4024.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpAcuD5dBQXKtiEAbJ82+2M5SMUt6pItdln8M9giLdEKBIEl4H0zqEtgdR2BF+zXDVjkOHPOwLOGtLSupe4/sspit0RERg4oZPVGpV4xc0p6CVv0CfgDr84pb+tFnXnhVIttaQOTjXYgK12j8cGT0lYhwKV+iVNXf9ZWEltkcT4fuKuGe/MtNM0UkQ1c70OIef2uLfgqZ0S8GevEZMXYSSJoQDtnWL7aNNRmBRV7cO7x1l3RkF7GDFHZ/2gPmM6OxUOLkOvzqCW1BZAAFCeO1OOvqUxZ+KTxzd4JNn3EIlDHBvM5MZh7LEbjqbePios7y7Qg1z3xiuH8svqJTQ7J+/tRmuFo71aE9tmp/qzi1HgGgDzlsBTpjXDfhFnOzBu7S5UAJZYi80NvnzOLZKFNxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(376002)(39850400004)(396003)(36756003)(186003)(66446008)(66946007)(8936002)(6506007)(64756008)(66556008)(66476007)(4326008)(76116006)(2906002)(91956017)(53546011)(26005)(5660300002)(6512007)(86362001)(71200400001)(110136005)(31696002)(316002)(54906003)(31686004)(7416002)(478600001)(2616005)(8676002)(6486002)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S4OFd/rG725w5ezSO1IwErK2D6K3JRUct1gftNiyGJUL82X1fsPzCvXIMmI7fbpC29apS2bV6A4OGOo1M9fBl+hWC3r/AxijfCJtkJsPBuistgivekZXKQ2sYTpuz345dUG1LLXa17biCXqh05QP/zkAwiSz+9As2LRqcpyh30T/mHQ8ktcoI4KtY7eUgM1kNDtLswyDo7OY1tFp/JvVAOCWCmlst9Ld+FT7T/8ebQVFZxqM/LaVq2pkcGBLIHmQTc6fQYBFSGREAsaGxY54KGUHGGrfEzMma8HSakWbF5hURESflXjPAEr5bidw1aETUoaSSaBpARDj+l0qqRqZ63M29UqrxqvhHLIhSOTJTw/kLbRfcXS3XrCX+hfXtMBYqMoRefT0dtul3pdyAJulyRFQx01DiqnsyF4OlVwTe9qXUDQ7hq0jBElAJA5MhZrIiPj7s/0jR6T4i7cNBdUink8O40qpFxJo7Sn8/fsctO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D3E4A1880A514EA9E1287839D56C55@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39db2f43-6be0-4f45-23fa-08d8229eb630
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 17:53:52.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3hvH/esMQc5JWC4tVwUmbWlsZmaPR6MC4morxcY/xkizMq/Ud5MPwoK0hP+Mlv4/KAzWe7vcj8B2F/JTEdVn5U/jStHGpDHpQL5HueLBp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4024
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTb21lIGRldmljZXMgaW4gRFRSIG1vZGUgZXhw
ZWN0IGFuIGV4dHJhIGNvbW1hbmQgYnl0ZSBjYWxsZWQgdGhlDQo+IGV4dGVuc2lvbi4gVGhlIGV4
dGVuc2lvbiBjYW4gZWl0aGVyIGJlIHNhbWUgYXMgdGhlIG9wY29kZSwgYml0d2lzZQ0KPiBpbnZl
cnNlIG9mIHRoZSBvcGNvZGUsIG9yIGFub3RoZXIgYWRkaXRpb25hbCBieXRlIGZvcm1pbmcgYSAx
Ni1ieXRlDQo+IG9wY29kZS4gR2V0IHRoZSBleHRlbnNpb24gdHlwZSBmcm9tIHRoZSBCRlBULiBG
b3Igbm93LCBvbmx5IGZsYXNoZXMgd2l0aA0KPiAicmVwZWF0IiBhbmQgImludmVyc2UiIGV4dGVu
c2lvbnMgYXJlIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2
IDxwLnlhZGF2QHRpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyB8
IDE3ICsrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaCB8ICA2
ICsrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgYi9kcml2ZXJzL210ZC9zcGktbm9y
L3NmZHAuYw0KPiBpbmRleCBjYjZlOTNhMzU2MGEuLjNmNzA5ZGU1ZWE2NyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9zZmRwLmMNCj4gQEAgLTYwNSw2ICs2MDUsMjMgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNl
X2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICBpZiAoYmZwdF9oZWFkZXItPmxl
bmd0aCA9PSBCRlBUX0RXT1JEX01BWF9KRVNEMjE2QikNCj4gICAgICAgICAgICAgICAgIHJldHVy
biBzcGlfbm9yX3Bvc3RfYmZwdF9maXh1cHMobm9yLCBiZnB0X2hlYWRlciwgJmJmcHQsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtcyk7DQo+
ICsgICAgICAgLyogOEQtOEQtOEQgY29tbWFuZCBleHRlbnNpb24uICovDQo+ICsgICAgICAgc3dp
dGNoIChiZnB0LmR3b3Jkc1tCRlBUX0RXT1JEKDE4KV0gJiBCRlBUX0RXT1JEMThfQ01EX0VYVF9N
QVNLKSB7DQo+ICsgICAgICAgY2FzZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9SRVA6DQo+ICsgICAg
ICAgICAgICAgICBub3ItPmNtZF9leHRfdHlwZSA9IFNQSV9OT1JfRVhUX1JFUEVBVDsNCj4gKyAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgICAgY2FzZSBCRlBUX0RXT1JEMThfQ01E
X0VYVF9JTlY6DQo+ICsgICAgICAgICAgICAgICBub3ItPmNtZF9leHRfdHlwZSA9IFNQSV9OT1Jf
RVhUX0lOVkVSVDsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgICAgY2Fz
ZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9SRVM6DQoNCmRldl9kYmcNCg0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQoNCkRvIHdlIHJlYWxseSB3YW50IHRvIHN0b3AgdGhlIFNGRFAg
cGFyc2luZyBoZXJlIGFuZCBsb29zZSBldmVyeXRoaW5nIHRoYXQNCndlIGdhdGhlcmVkPw0KDQoN
Cj4gKw0KPiArICAgICAgIGNhc2UgQkZQVF9EV09SRDE4X0NNRF9FWFRfMTZCOg0KPiArICAgICAg
ICAgICAgICAgZGV2X2Vycihub3ItPmRldiwgIjE2LWJpdCBvcGNvZGVzIG5vdCBzdXBwb3J0ZWRc
biIpOw0KDQpkZXZfZGJnDQoNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+
ICsgICAgICAgfQ0KPiANCj4gICAgICAgICByZXR1cm4gc3BpX25vcl9wb3N0X2JmcHRfZml4dXBz
KG5vciwgYmZwdF9oZWFkZXIsICZiZnB0LCBwYXJhbXMpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmggYi9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaA0K
PiBpbmRleCA3Zjk4NDZiM2ExYWQuLjZkNzI0MzA2NzI1MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zZmRwLmgNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmgN
Cj4gQEAgLTkwLDYgKzkwLDEyIEBAIHN0cnVjdCBzZmRwX2JmcHQgew0KPiAgI2RlZmluZSBCRlBU
X0RXT1JEMTVfUUVSX1NSMl9CSVQxX05PX1JEICAgICAgICAgICAgICAgICgweDRVTCA8PCAyMCkN
Cj4gICNkZWZpbmUgQkZQVF9EV09SRDE1X1FFUl9TUjJfQklUMSAgICAgICAgICAgICAgKDB4NVVM
IDw8IDIwKSAvKiBTcGFuc2lvbiAqLw0KPiANCj4gKyNkZWZpbmUgQkZQVF9EV09SRDE4X0NNRF9F
WFRfTUFTSyAgICAgICAgICAgICAgR0VOTUFTSygzMCwgMjkpDQo+ICsjZGVmaW5lIEJGUFRfRFdP
UkQxOF9DTURfRVhUX1JFUCAgICAgICAgICAgICAgICgweDBVTCA8PCAyOSkgLyogUmVwZWF0ICov
DQo+ICsjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX0lOViAgICAgICAgICAgICAgICgweDFV
TCA8PCAyOSkgLyogSW52ZXJ0ICovDQo+ICsjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX1JF
UyAgICAgICAgICAgICAgICgweDJVTCA8PCAyOSkgLyogUmVzZXJ2ZWQgKi8NCj4gKyNkZWZpbmUg
QkZQVF9EV09SRDE4X0NNRF9FWFRfMTZCICAgICAgICAgICAgICAgKDB4M1VMIDw8IDI5KSAvKiAx
Ni1iaXQgb3Bjb2RlICovDQo+ICsNCj4gIHN0cnVjdCBzZmRwX3BhcmFtZXRlcl9oZWFkZXIgew0K
PiAgICAgICAgIHU4ICAgICAgICAgICAgICBpZF9sc2I7DQo+ICAgICAgICAgdTggICAgICAgICAg
ICAgIG1pbm9yOw0KPiAtLQ0KPiAyLjI3LjANCj4gDQoNCg==
