Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D142AC43B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKIS5E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 13:57:04 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:35976 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIS5E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 13:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604948223; x=1636484223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1K8EIIZxjtQG+6NQN9tx7whshU3QDBjDRcGnHcOvaQs=;
  b=be6sGxGH3r6rOacDsraOQtrbNwcMiTgiyoSDjXxiQj9CiH/8mtb4jsG8
   fq9WRXGQukduBdgcPTojFZy/d+oCWJdi90g1jHsgJ7VxBCJ8uKBX/KZFi
   H1N7uLBiMznvQWmN+8e0IKU/m6IlDEciD36feDLqOPNZaan0lv3lsQrMY
   yZkbSa2GK77aU9yuVveRFcAieP+6/lxf7IWmdBqFrnNDoRRRVo41D8t4y
   p7lcHnP3nCw80/gGf7aHwL3InWbTcrOFZcV4Sto/388+rwdOW0E2CnFQ7
   1fodHF0nsSzwhLsAAy6/kRHs8GDSny9SdeUoEKkU8YAa03ZhwJPpEKmTS
   w==;
IronPort-SDR: MvC3MzA9lZ8g9NAeWTD+h8+YiEEw9yYF4883OwnPqOR4KU2qNTk6sgOhWrOqRYvR6nXhttH+AQ
 JURjdHJ6mEmdDTxVP6ou3wSonOVpZwsq6JzgVbpNmnTqM4tzLrMrwlS9TenZrnvXDV/UlVRrGp
 aLtneIzSCeCwtM1Uu5wXywBwrobGULdecjetUbAC7TeuUF7cQ99TXcm+nYhRSomyBOkKohVTNg
 km/R5J78Om0a18Dqfy3uv7a+6H3OAMJVTPmcnkNQ9xum6oa/ywXJOm7391M2sF3SIhm0T3p/iq
 WPk=
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="93019620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Nov 2020 11:57:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 11:57:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 9 Nov 2020 11:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X96fVHGcBLvldj++gnxORQ/GlgBhKzB+WOlrMXOY3CG9ApMoh50pPKk5CbItvWGlpbW4ydUYfcUjd7ovTgopU/hGKF34pX6NVsCDylMTBNlbTX215C52gHoiEzh/m/dwXYbL65bDgud5XwUN0hKNbbh7g2HxKcI8vG1ZXkP03FrBtUuaWn3epN76/b00MLg5Ty9nNy73ds2Ajq+Y5qAtL4IiWuAvGjhzedhwNvuDMbTg4ECs4wchCKoX8KNITKjO2Fq2sadvXWcH5lSbDT3mMENGvH4aTl++sKk9iT7LFujiW1z4CEpKYZ07CxqHuKEqesAukXeEVlBewwhHLqxfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K8EIIZxjtQG+6NQN9tx7whshU3QDBjDRcGnHcOvaQs=;
 b=RK3aoenHH7YxLyBms/4uKDIQiU9rUms+UZvkhluiIgj6OYB5PyH+rktevUUtXKo7hKPah4L8nV0hFMiqrhRHZsE8AhNsLYGJszuiIKC2HjcbFaAWNn7Zfj1xW6FFDd4jXrzcZDySwHVUaFhB2gz/7m1tSWqvxJmjPj5Q0RIcQvfqmyguwT+TrVMcb+a17MIJEmMwHnNEfFtHgKk/ft7dzsgLHOm9TbSWfzyVtWRsVbVZV5VHiCDnnCsbZT5I6eqwRzvLEEM/EKKsL8Pk05QD9f7Sk2iWgqq68OP+yOxsr/877vIMB4PZx1TEN/RIp84QEjFyZ+B5OFrFcYQos1HPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K8EIIZxjtQG+6NQN9tx7whshU3QDBjDRcGnHcOvaQs=;
 b=fq5THxBy5wXBk5mkmA9xKswhJHbazR/B7zbaAmbSef8nU0c7Y5pEdshsNaceQ+X8ix8GC8+hKQq8v/+nas46C+Y06ikzv1+9wllJDKcwUblvEpZxHmG5Gi6/mCfOGjlntPXpw/F3BQZk9DyRMIxnG0huKnrCcJfbbHeTKSQNgjs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2784.namprd11.prod.outlook.com (2603:10b6:805:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 18:57:00 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 18:56:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <lukas@wunner.de>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Disable clock in probe error path
Thread-Topic: [PATCH] spi: atmel-quadspi: Disable clock in probe error path
Thread-Index: AQHWtiCRWKRuvsXbcUuF/8DkmPHxCKnAJ/KA
Date:   Mon, 9 Nov 2020 18:56:59 +0000
Message-ID: <98bb6714-2c99-6373-0f33-b707e970c078@microchip.com>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
 <8f8dc2815aa97b2378528f08f923bf81e19611f0.1604874488.git.lukas@wunner.de>
In-Reply-To: <8f8dc2815aa97b2378528f08f923bf81e19611f0.1604874488.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94c6fd00-ef8b-4fe1-6352-08d884e13cfe
x-ms-traffictypediagnostic: SN6PR11MB2784:
x-microsoft-antispam-prvs: <SN6PR11MB2784FD274B36A87AA5C4F732F0EA0@SN6PR11MB2784.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cq+9xgPqXsU7BU3mFcphLUNFicuZ8HQ/rFrUCWfYDJPfNz/wuP0NcTMML7Ky4oVvZ7knee3QiMbeA+LXlHNMPoz0ZOOTBaKLZxC9wGJYtEW0TnnBVWFiubRmDMnVo62b5NJ31GyUli8Gg2dGF+UrKGzcAGx9D8xdclfjTpJcv+GomCOcrQeRfx4zIgqK5oCxDCtIMEOMQFlVOFThyyvQ/IHBosQ9O9VAZKxt0CyzGZW2ovNE4fSB/IjgiaHU0CPIhyr9TgQHt8INeg5lrxQk8zXVWgjELXwwf/gbKM8/Gffhe0zqDS+TqWdpT6KtY0CJSJr3VMCuW84zWyx6oZPaVBKrC4cd5flxO+WvMvRfKIhdUUFRcI96z0MNHTQatrNj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(2906002)(66476007)(8936002)(71200400001)(4326008)(83380400001)(478600001)(54906003)(86362001)(6486002)(76116006)(186003)(36756003)(8676002)(26005)(66446008)(31686004)(64756008)(66556008)(31696002)(110136005)(66946007)(53546011)(6512007)(2616005)(5660300002)(6506007)(316002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /+3I3q1Fo2HefeBHje0KikxQDCEJeD833fAx5iG5EijCiKQEtlMo4V6Zmx9YyL+HCzKssNalaQKCP4nTg/+WUQsbAOLQpvcuoVPGQS6194ul9b48xLmlXmKgGgjuTRCPIulqekHMBjjdmdraepg+SySPYGErxHJ+pZFBcXnK/L+w0VYeN129dXklBtE2unJOlqlxL62kvGSlT3lp1XLkapNOQ7keLksPj6JanQATaKCHXkNY4pJlgiGXazLxENEv/ddWXq21sC7fPzQqidSSvAvUnBxm+QPoDiWNZEdoNR68NbCh5rq3kVykEAyfLcuQJOMmmheciDaVtok/7yP6sV1pFnREHQQncUD4eFPOOWuuYq9iz8F4m/MfMYbTdZvk8/xhkIhymTMJjgwCrPW046HYvtB1Vs/9X3PAHhiCcO9ejfOB3qK6+uYOzAdMo/M8r4Ga1Cwj6TfhANS6ABp6WsfPbR6+VojWbGv24KMdToE3MCePPusUHuiYioOQ+bBrDC4bVnqRyKBUXrDeugRc/dVVa0wS29/Zfj2cGeMTyMsNnw14bvMAj9A1IFz6BcAozBpCP/mtzsMe9hQW9oY5TTj1t31XTjjBn9VLJonLJoUREwcOFJAbCuFnqYkgHQ3Lfwc+INjqlmhbBf6pqewxng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <197A407D1C8A0245A3D4ACFBF3E1E034@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c6fd00-ef8b-4fe1-6352-08d884e13cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 18:56:59.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLWX8eq2gTK8a4BfJw4/Lv6+Cz8Wqn9ASLmMHyyeyRF0BgNjOJCC9UB64/dnr+WLd4zf21d9bniMTC80MgGq2+CUQ+qnjz11cDWnHQjJs0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2784
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTEvOS8yMCAxMjo0MSBBTSwgTHVrYXMgV3VubmVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IElmIHRoZSBjYWxsIHRvIG9mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YSgpIGZhaWxzIG9uIHByb2JlIG9mIHRoZSBBdG1lbA0KPiBRdWFkU1BJIGRyaXZl
ciwgdGhlIGNsb2NrICJhcS0+cGNsayIgaXMgZXJyb25lb3VzbHkgbm90IHVucHJlcGFyZWQgYW5k
DQo+IGRpc2FibGVkLiAgRml4IGl0Lg0KPiANCj4gRml4ZXM6IDJlNWM4ODg4NzM1OCAoInNwaTog
YXRtZWwtcXVhZHNwaTogYWRkIHN1cHBvcnQgZm9yIHNhbTl4NjAgcXNwaSBjb250cm9sbGVyIikN
Cj4gU2lnbmVkLW9mZi1ieTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+DQo+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NS4xKw0KPiBDYzogVHVkb3IgQW1iYXJ1cyA8dHVk
b3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiBDYzogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5i
cmV6aWxsb25AY29sbGFib3JhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1
ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzIQ0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9zcGkvYXRtZWwtcXVhZHNwaS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRt
ZWwtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IGluZGV4IDhjMDA5
YzE3NWYyYy4uYjQ0NTIxZDRhMjQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1x
dWFkc3BpLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IEBAIC01OTQs
NyArNTk0LDcgQEAgc3RhdGljIGludCBhdG1lbF9xc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgaWYgKCFhcS0+Y2Fwcykgew0KPiAgICAgICAgICAgICAg
ICAgZGV2X2VycigmcGRldi0+ZGV2LCAiQ291bGQgbm90IHJldHJpZXZlIFFTUEkgY2Fwc1xuIik7
DQo+ICAgICAgICAgICAgICAgICBlcnIgPSAtRUlOVkFMOw0KPiAtICAgICAgICAgICAgICAgZ290
byBleGl0Ow0KPiArICAgICAgICAgICAgICAgZ290byBkaXNhYmxlX3BjbGs7DQo+ICAgICAgICAg
fQ0KPiANCj4gICAgICAgICBpZiAoYXEtPmNhcHMtPmhhc19xc3BpY2spIHsNCj4gLS0NCj4gMi4y
OC4wDQo+IA0KDQo=
