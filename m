Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615F4218C88
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgGHQI0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 12:08:26 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19817 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHQIZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 12:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594224504; x=1625760504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9g6qKzgfVawGBWosD/ySi8Ozh6beuBKKvZcECxXFuyg=;
  b=0/kangMa7urbzRoqix6i5gV24+rcLqW1P7iyUVCGr+aPXS+iO5DCLbqO
   +lEsTzEJbi9gRXAw5oWKy/2uaa9noXtqo6Jwh9AtlpPJ1CWHhuz5ke2N3
   4o/xdSBxMyguSyG+xGdttofLxM4RyYh447HizNWgDUOUzUFTkEiuUiW7G
   rrAs4Lpc+0IOWpYvo6XlQdDSGAiCpgkTJNesd4tSMVNLtavY0qxIV8aiF
   FmZ9UF0b+79yhwm2D1sQ0Ng46TPxaV1F7XKfy/8V+2pKY6rBkGyTemtpa
   Dbmq8s2Aj90qo/N4xuyYUxhLI6+JARPcMiLBz1HC9BPOQodoMhGmArI2P
   w==;
IronPort-SDR: X3sSi9VX7AP7gFe7qo3ZcT6iabW6RxvjUIT0hSnV33FeJMVuQ22Ti6ziLFLG80ZrnNEiBV3UOo
 oLEyUFfStL/wHc9eNDLvJazLmQoScX2xPgOwzThOjt7qTt2t7uDqO9QiBdDZGLBxkuf1TsY770
 SJZ2vNs/7HqsEl0UR5YOAa6o1Haha8lkKhN9S8DHGSsBlm53HGC46QELpLR17AOh0lX3epxsg5
 354i7e1OEBWiy1hOFmfVRBuDOM+hgu32H/swOKNsL999mMcNBc9Yy5446vNtM5kyp3CCy6Zc8Q
 vAw=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="79171303"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 09:08:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 09:08:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 8 Jul 2020 09:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lue59fTS2hwS+ASQcIM52y3aIb1fLDc108csFJemXv3EbOvZEhHuIj5k6H+y3+sAuueCcHUvMae9bB8D+JImMr7kvqSeZL8eIjsIB56/JUo8rhEg8wC33tD2MDamPJ0VVFmzgJhJWoOvj6ssdOPl9Vn8DKG2WCyK6RF+EgYbBdoHHWz+EKOi+opx5j5joVIxp07/LCkzcU9VGQhj4xabra0U9Br9iH+FO2sHwtmgLtZCaPR//ND1GO0VNBFqsQIV6099cTssvoTcpMuBlMm9JwIEBjoicCEt2JcA2IJsDmJ8p2k+QLyZSUpw60joAmKj2gKMssl7yLeL6eMqCGJgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g6qKzgfVawGBWosD/ySi8Ozh6beuBKKvZcECxXFuyg=;
 b=FdVvO5L2tr0+KV2dUda1Edf+SUUBosKPyLxuxWGcsqbxf+Uav4/uuWPPM2gA1wC1L6cRV1RQ/WGQD2y0u6hJFYI/jJROnRdoaHSrQgy4FNGEg1zBAbRpFYHewPCN17V5RfJYDj9KvNNqNk786WH6WureAAZdXBlrOPXfB2WGoXtz46cKpxxcbtOq3QV5zssa2NNrJVFKA8VT9sSWnljdTvp+ef3eutg735EG90kcEytwUYD6yDPnybz0U0nbJnhpyOaIG/TcBEMYbtAZJh6OSCGNkZmF3340vEtbNJVpI1apDuqhB7xRDxbI32X9lk/02itpNDCQVTRaLXx41ylUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g6qKzgfVawGBWosD/ySi8Ozh6beuBKKvZcECxXFuyg=;
 b=JlzPg8uqtY7uDqnpk/4N+QsV+4KGEo0n14e/kxjAjoaSUh6er6Yzvm7fiX0p+eCaakeFVMRoiXJLtZGhk+IFKQFYl6Zpqt0fJDCfaf1iCBiJdDYVhB6CTW/gtTfSSzjoUAQKcM+vv+P2FGbcFn/hiNruiWbenyktKLskgDWEljY=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3702.namprd11.prod.outlook.com (2603:10b6:a03:f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 16:08:22 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 16:08:22 +0000
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
Subject: Re: [PATCH v10 12/17] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Topic: [PATCH v10 12/17] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Index: AQHWVUIAsFiQ+I4mt0WYZhmL22dMxA==
Date:   Wed, 8 Jul 2020 16:08:21 +0000
Message-ID: <5f9a93d0-833c-8976-c6d3-2043e65b1b66@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-13-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-13-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: e9ddbc1c-e351-49c7-339b-08d82359231f
x-ms-traffictypediagnostic: BYAPR11MB3702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB370272994E23CFBC6EC97331F0670@BYAPR11MB3702.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLrl9aZOiu56F9fD3dfFBZ51YAwsPTirJzz8lLSwPB9+hrSvUwx/IsEpmNg8irknyMtnKNEfpFREmz5ySj68GLp26KDM9ZDtwa6yYuju18tPMZG4i+Hwk7EojgCNyx0j8gPzuwt5cZfskCyeFCoqjIXgKKZPFxbKcvu87ACxIzlImmb5HwawfsD1rUqB6pbddcVYWoPyz1E3hJSdW0DB5uKolQQ83q0W/oVPRQsm6EqVuN9Z4mjdxbHq5yOrduh993uFTPWGjeXxsi9h36D/P3v695psIc5uNzBWZptDZXw2o9WvDOIn7vktv9p1WQ0oBap2bPWg0QzXWyHqcztDjM9MCZUehecbG2Tk7nQqcJNnyaryVrQD44N6uqRwScK6OBawDje48ec7DBPnd++tVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(7416002)(66446008)(66476007)(64756008)(110136005)(8676002)(53546011)(86362001)(26005)(71200400001)(316002)(6486002)(8936002)(2616005)(2906002)(54906003)(4326008)(6506007)(6512007)(5660300002)(186003)(31686004)(36756003)(66556008)(66946007)(31696002)(91956017)(76116006)(478600001)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8pAh/+NyiayLJtrsK0Q0sZREdpixTeHkzi3lIASUfvtd/rImi2xUXgT8YKOKu3K4pAwkqiiiiBP6uf9YweIpwxSMk2RsfgIYNHrH55EGeCL9dV/9BjGoq1zAR+ECpxLHk/r7Gc5FXzgsMvY29RjZAgwTcFVxcotCbl9JxFFqcgxQG7SCibnTFoMJjjAKFuJkfrJdk+WNhrG9BxtT8bfjR+wdG/JKsKQGqtZ6CLUaTHxbgp1+r2YXfwcrtBiNNfBCYC+N2+LFoUWJ4BVoVNiBtpHT4d2RZqEWf1LyfwwiG97/UhZAaiLCAPmONIk76WpQfuOmXMCH07ctJhgl/dGzYZxc8fnJSqqT1a/LX+BacBMgOEG8xFMzV7HgVNQPrMZA6qqLyPN8cxH6F0ZjGWqxaeHkUUFhF88bOcUyO2+SvIgI8oG4YPC9c6ZroNnEPY1yGin0EcGeIy7PrRXFeQcAy9BZICDqKUpUSxYB8hJqHEk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93AAB675FF7A824BB3F01E52D5156678@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ddbc1c-e351-49c7-339b-08d82359231f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 16:08:22.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDKJVhF4coQ5mI4OOptitJf/NGXwBGKikTBsi4zKUcD4xsaPkjN8j3Uq3J9+JK6CoLLFXwDZhuNXuUtVdyxwwnn5vf2hmGEChSdI5VpUuPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3702
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBIFNvZnQgUmVzZXQgc2VxdWVuY2Ugd2lsbCBy
ZXR1cm4gdGhlIGZsYXNoIHRvIFBvd2VyLW9uLVJlc2V0IChQT1IpDQo+IHN0YXRlLiBJdCBjb25z
aXN0cyBvZiB0d28gY29tbWFuZHM6IFNvZnQgUmVzZXQgRW5hYmxlIGFuZCBTb2Z0IFJlc2V0Lg0K
PiBGaW5kIG91dCBpZiB0aGUgc2VxdWVuY2UgaXMgc3VwcG9ydGVkIGZyb20gQkZQVCBEV09SRCAx
Ni4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8IDEgKw0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9zZmRwLmMgfCA0ICsrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5o
IHwgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oDQo+IGluZGV4IDYzMzhkMzJhMGQ3Ny4uNzljZTk1MmMwNTM5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuaA0KPiBAQCAtMjYsNiArMjYsNyBAQCBlbnVtIHNwaV9ub3Jfb3B0aW9uX2ZsYWdzIHsN
Cj4gICAgICAgICBTTk9SX0ZfSEFTX1NSX1RCX0JJVDYgICA9IEJJVCgxMSksDQo+ICAgICAgICAg
U05PUl9GX0hBU180QklUX0JQICAgICAgPSBCSVQoMTIpLA0KPiAgICAgICAgIFNOT1JfRl9IQVNf
U1JfQlAzX0JJVDYgID0gQklUKDEzKSwNCj4gKyAgICAgICBTTk9SX0ZfU09GVF9SRVNFVCAgICAg
ICA9IEJJVCgxNCksDQo+ICB9Ow0KPiANCj4gIHN0cnVjdCBzcGlfbm9yX3JlYWRfY29tbWFuZCB7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5jDQo+IGluZGV4IDc5ODNmZjQzMTM0Ni4uOGUwNzQxZDhiZmQzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NmZHAuYw0KPiBAQCAtNjE2LDYgKzYxNiwxMCBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICAvKiBTb2Z0IFJlc2V0IHN1cHBvcnQuICov
DQo+ICsgICAgICAgaWYgKGJmcHQuZHdvcmRzW0JGUFRfRFdPUkQoMTYpXSAmIEJGUFRfRFdPUkQx
Nl9TT0ZUX1JTVCkNCg0KdGhpcyBjYW4gYmUgaW1wcm92ZWQuIFRoZXJlIGFyZSBtdWx0aXBsZSBy
ZXNldCBtZXRob2RzIGRlc2NyaWJlZCBhbmQgeW91J3JlDQphZGRyZXNzaW5nIGp1c3Qgb25lIG9m
IHRoZW0uDQoNCj4gKyAgICAgICAgICAgICAgIG5vci0+ZmxhZ3MgfD0gU05PUl9GX1NPRlRfUkVT
RVQ7DQo+ICsNCj4gICAgICAgICAvKiBTdG9wIGhlcmUgaWYgbm90IEpFU0QyMTYgcmV2IEMgb3Ig
bGF0ZXIuICovDQo+ICAgICAgICAgaWYgKGJmcHRfaGVhZGVyLT5sZW5ndGggPT0gQkZQVF9EV09S
RF9NQVhfSkVTRDIxNkIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gc3BpX25vcl9wb3N0X2Jm
cHRfZml4dXBzKG5vciwgYmZwdF9oZWFkZXIsICZiZnB0LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zZmRwLmggYi9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaA0KPiBpbmRl
eCA2ZDcyNDMwNjcyNTIuLjhhZTU1ZTk4MDg0ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9zZmRwLmgNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmgNCj4gQEAg
LTkwLDYgKzkwLDggQEAgc3RydWN0IHNmZHBfYmZwdCB7DQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQx
NV9RRVJfU1IyX0JJVDFfTk9fUkQgICAgICAgICAgICAgICAgKDB4NFVMIDw8IDIwKQ0KPiAgI2Rl
ZmluZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxICAgICAgICAgICAgICAoMHg1VUwgPDwgMjAp
IC8qIFNwYW5zaW9uICovDQo+IA0KPiArI2RlZmluZSBCRlBUX0RXT1JEMTZfU09GVF9SU1QgICAg
ICAgICAgICAgICAgICBCSVQoMTIpDQo+ICsNCj4gICNkZWZpbmUgQkZQVF9EV09SRDE4X0NNRF9F
WFRfTUFTSyAgICAgICAgICAgICAgR0VOTUFTSygzMCwgMjkpDQo+ICAjZGVmaW5lIEJGUFRfRFdP
UkQxOF9DTURfRVhUX1JFUCAgICAgICAgICAgICAgICgweDBVTCA8PCAyOSkgLyogUmVwZWF0ICov
DQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX0lOViAgICAgICAgICAgICAgICgweDFV
TCA8PCAyOSkgLyogSW52ZXJ0ICovDQo+IC0tDQo+IDIuMjcuMA0KPiANCg0K
