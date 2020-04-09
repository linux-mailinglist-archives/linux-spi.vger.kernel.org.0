Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692FD1A38D4
	for <lists+linux-spi@lfdr.de>; Thu,  9 Apr 2020 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDIRWx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Apr 2020 13:22:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42350 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbgDIRWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Apr 2020 13:22:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 039HEq8Z019614;
        Thu, 9 Apr 2020 13:22:49 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091naxnpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Apr 2020 13:22:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flDQ497QK9SoZteO+elYdNP+dqLgVZBr5kuQhniSSGYBe1wp9b49PCdJ+CuSqpxp5KmxuTG6vRpQEefFdJ0OONJTqQHJlQ5bHdgvpGdzBKvDhfoN95cwS9/ej+SGPwoNBAG2JpANNuJrKSclhah0/i2VSRWskZHG1vTCDSP1kuMONjKqBPDmJhmeFL2H0X+k2yz6jSc3Fl/A7pQZ0amXKI2Lb6XjqF6+LRK5WCGreaiecjkfdHca7JEuKzdW05EmML47lKfUK+ukzo9Odehn/tt1ViFXnHSd5h2+vGhi3Roxr0A3MS+ITgI4soonz3k4YcoWLB2gK/JT/MBBbqM3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHmKrCHP1eIJURVbabefRZsSio9wx92ZE4GNp2h+TGA=;
 b=cyblorlBhuD3PeeNDjx46Dw5KQ37oWb5/GveCHDxeJPsRyONap4NVytsVzZOur6GOmqES3Z1RH5CIPuguoTM7kqEZ+V00IBt+3Eaee93NuRHYnXCpxUkpqKrpZGkrg7YgUKOzE9yEpwpGxtFI5YmrDG40UQu0sQQ72DiaAXLMLFPRBnkJXEWvv7tuPrfevxdrK4KVCZsmkh6HJKmqcdGPp/guMnulSmy+zGfEF4/lSB7vnZjcxChisxtxrdkMzkuLsGRwwLKVAV4ti5893qSC+KA17bzQLF2wIp/W3fNgPnvjoqq8VT4MzjHzQyJetdMtWIQ9Gn/49JbaCKKaGODRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHmKrCHP1eIJURVbabefRZsSio9wx92ZE4GNp2h+TGA=;
 b=TzQ+3jKt+SO5xkTIA9TTO3viDGHtp31M2AxLwzUM+99oWWEZSJPnKRJgs2FS49a6CBbef7N54aGGiq0W7SG4B1azvOXbvEZE+ZA4kLDaSYY6C2ywgDnzkb0tD8lVeQDHZ7qj1YoYaG2ZyEQjSzL1Ua281PHZZ8hgm5okSDXphtk=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4652.namprd03.prod.outlook.com (2603:10b6:5:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Thu, 9 Apr
 2020 17:22:48 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 17:22:48 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rafal.hibner@secom.com.pl" <rafal.hibner@secom.com.pl>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-axi-spi-engine: Access register after clock
  initialization
Thread-Topic: [PATCH] spi: spi-axi-spi-engine: Access register after clock
  initialization
Thread-Index: AQHWDojh1NkmPOFHJUiZeD8RYi9xjahxCveA
Date:   Thu, 9 Apr 2020 17:22:48 +0000
Message-ID: <1135f49cdef0313edaf366ddaa60600472566199.camel@analog.com>
References: <20200409155621.12174-1-rafal.hibner@secom.com.pl>
In-Reply-To: <20200409155621.12174-1-rafal.hibner@secom.com.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a1a0fd0-6938-4279-e46a-08d7dcaa9ff6
x-ms-traffictypediagnostic: DM6PR03MB4652:
x-microsoft-antispam-prvs: <DM6PR03MB46524ABA2B7F3915B8BECEECF9C10@DM6PR03MB4652.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(26005)(6512007)(66946007)(76116006)(86362001)(66476007)(2906002)(66446008)(5660300002)(36756003)(91956017)(6916009)(81166007)(64756008)(6486002)(478600001)(8676002)(54906003)(66556008)(186003)(8936002)(4326008)(71200400001)(2616005)(316002)(6506007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gER9FjOSIF5PWAfakKFgCe3VZriQPbgt6458vKBpHKrebBEQQEDAA0BaDisCGQK+2SOAyxerg4REVhc9WwlJkk9zKXWneqKZcdJZ23Wy1/2Yohrkn1pMYThFpO/Z5SYl8kWfvgNBvbqTxSt3lYdGqGb+6+tdGqoNTy22nzacRr+TtlOENBmU931n/sYk1tkW9/kDQVOgtddtN5mKKYjuQIym27nGMV6k2YsvSI7yn8fKUaZDcY2zBKVS9TfV1CmhA94K8Ae88SyfglcYf5vnANY561Nn25JytF3/bVYekIOU5/sHActE8zvLpwXWuRmoVpZNIAdZBqAp8BoUrg+93m1B3az632nyzCQU/UH3loWVYUlt2htv81LnChe+BDA+0AG2YYCdDMdFPL7H5gsC+rVfbVY8CJJPmy8H/7QdeNW+/f8Wev/UmyzM2HChwxrr
x-ms-exchange-antispam-messagedata: syV6mRzzgO/7y0NQjOHdqblUuLqdnoYYwqZ9YGJ+U8pWgkWitYNlYmpNAllqmtUJXJAuFY4eUyLeIDJ5rK+wM/RasZqqy6VuxaEQtReke6f/u6Z38KWHLfKmqbJB70pxi/K4deMzptoSGQlsQQHAMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B8CBFE4AADD9E4090A99A5141D448F5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1a0fd0-6938-4279-e46a-08d7dcaa9ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 17:22:48.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qBf+GyvxcxRZua2s4zsQe7mkjzf2pFD4vrbyioM63bkYD6lBU2fpqEe80XIyiabffkx0vKnb0U4A4QsOKAMxR0aS8vDwJ5QL4lq4EyVJkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4652
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_06:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090123
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTA5IGF0IDE3OjU2ICswMjAwLCBSYWZhxYIgSGlibmVyIHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBNb3ZlIHJlZ2lzdGVyIGFjY2VzcyBhZnRlciBjbG9jayBpbml0
aWFsaXphdGlvbi4NCj4gQ2xvY2sgInNfYXhpX2FjbGsiIGlzIG5lZWRlZCBmb3IgcmVnaXN0ZXIg
YWNjZXNzLiBXaXRob3V0IHRoZSBjbG9jayBydW5uaW5nDQo+IEFYSSBidXMgaGFuZ3MgYW5kIGNh
dXNlcyBrZXJuZWwgZnJlZXplLg0KDQp0aGlzIHBhdGNoIHNob3VsZCBoYXZlIGJlZW4gbWFya2Vk
IGFzIFYyDQp0aGUgZWFzaWVzdCB3YXkgdG8gYXBwbHkgVjIgdGFncywgaXMgdG8gcnVuICAnZ2l0
IGZvcm1hdC1wYXRjaCAtdjInIA0KW29yIC12MyBmb3IgM3JkIHZlcnNpb25dDQoNCm5vIGlkZWEg
aWYgeW91IG5lZWQgdG8gcmUtc2VuZCB0aGlzOw0KaSBndWVzcyBpdCdzIHVwIHRvIHRoZSBtYWlu
dGFpbmVyOw0KbWF5YmUgdHJ5IHRvIHJlbWVtYmVyIHRoaXMgd2hlbiByZS1zZW5kaW5nIHBhdGNo
ZXMsIGVhY2ggcmUtc2VuZCBpcyBhbiBpbmNyZW1lbnQNCg0KYWxzbywgaXQncyBhIGdvb2QgaWRl
YSB0byBhZGQgYSBjaGFuZ2Vsb2cgcmlnaHQgYWZ0ZXIgdGhlIC0tLSBsaW5lDQp0aGF0IGxpbmUg
ZG9lc24ndCBnZXQgYXBwbGllZDsNCg0Kb3RoZXIgdGhhbiB0aGF0Og0KDQpSZXZpZXdlZC1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiAN
Cj4gQ2M6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFJhZmHFgiBIaWJuZXIgPHJhZmFsLmhpYm5lckBzZWNvbS5jb20u
cGw+DQo+IC0tLQ0KDQpzbyBoZXJlLCBzb21ldGhpbmcgbGlrZToNCkNoYW5nZWxvZyB2MSAtPiB2
MjoNCiogcmUtc2VuZCBpbiBwbGFpbi10ZXh0IGZvcm1hdA0KDQoNCj4gIGRyaXZlcnMvc3BpL3Nw
aS1heGktc3BpLWVuZ2luZS5jIHwgMzIgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktYXhpLXNwaS1lbmdpbmUuYyBiL2RyaXZl
cnMvc3BpL3NwaS1heGktc3BpLQ0KPiBlbmdpbmUuYw0KPiBpbmRleCBlYjliNzhhOTBkLi5hZjg2
ZTZkNmUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktYXhpLXNwaS1lbmdpbmUuYw0K
PiArKysgYi9kcml2ZXJzL3NwaS9zcGktYXhpLXNwaS1lbmdpbmUuYw0KPiBAQCAtNDg5LDIyICs0
ODksNiBAQCBzdGF0aWMgaW50IHNwaV9lbmdpbmVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIA0KPiAgCXNwaW5fbG9ja19pbml0KCZzcGlfZW5naW5lLT5sb2NrKTsNCj4g
IA0KPiAtCXNwaV9lbmdpbmUtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2Uo
cGRldiwgMCk7DQo+IC0JaWYgKElTX0VSUihzcGlfZW5naW5lLT5iYXNlKSkgew0KPiAtCQlyZXQg
PSBQVFJfRVJSKHNwaV9lbmdpbmUtPmJhc2UpOw0KPiAtCQlnb3RvIGVycl9wdXRfbWFzdGVyOw0K
PiAtCX0NCj4gLQ0KPiAtCXZlcnNpb24gPSByZWFkbChzcGlfZW5naW5lLT5iYXNlICsgU1BJX0VO
R0lORV9SRUdfVkVSU0lPTik7DQo+IC0JaWYgKFNQSV9FTkdJTkVfVkVSU0lPTl9NQUpPUih2ZXJz
aW9uKSAhPSAxKSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlVuc3VwcG9ydGVkIHBlcmlw
aGVyYWwgdmVyc2lvbiAldS4ldS4lY1xuIiwNCj4gLQkJCVNQSV9FTkdJTkVfVkVSU0lPTl9NQUpP
Uih2ZXJzaW9uKSwNCj4gLQkJCVNQSV9FTkdJTkVfVkVSU0lPTl9NSU5PUih2ZXJzaW9uKSwNCj4g
LQkJCVNQSV9FTkdJTkVfVkVSU0lPTl9QQVRDSCh2ZXJzaW9uKSk7DQo+IC0JCXJldCA9IC1FTk9E
RVY7DQo+IC0JCWdvdG8gZXJyX3B1dF9tYXN0ZXI7DQo+IC0JfQ0KPiAtDQo+ICAJc3BpX2VuZ2lu
ZS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzX2F4aV9hY2xrIik7DQo+ICAJaWYg
KElTX0VSUihzcGlfZW5naW5lLT5jbGspKSB7DQo+ICAJCXJldCA9IFBUUl9FUlIoc3BpX2VuZ2lu
ZS0+Y2xrKTsNCj4gQEAgLTUyNSw2ICs1MDksMjIgQEAgc3RhdGljIGludCBzcGlfZW5naW5lX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290
byBlcnJfY2xrX2Rpc2FibGU7DQo+ICANCj4gKwlzcGlfZW5naW5lLT5iYXNlID0gZGV2bV9wbGF0
Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiArCWlmIChJU19FUlIoc3BpX2VuZ2lu
ZS0+YmFzZSkpIHsNCj4gKwkJcmV0ID0gUFRSX0VSUihzcGlfZW5naW5lLT5iYXNlKTsNCj4gKwkJ
Z290byBlcnJfcmVmX2Nsa19kaXNhYmxlOw0KPiArCX0NCj4gKw0KPiArCXZlcnNpb24gPSByZWFk
bChzcGlfZW5naW5lLT5iYXNlICsgU1BJX0VOR0lORV9SRUdfVkVSU0lPTik7DQo+ICsJaWYgKFNQ
SV9FTkdJTkVfVkVSU0lPTl9NQUpPUih2ZXJzaW9uKSAhPSAxKSB7DQo+ICsJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIlVuc3VwcG9ydGVkIHBlcmlwaGVyYWwgdmVyc2lvbiAldS4ldS4lY1xuIiwNCj4g
KwkJCVNQSV9FTkdJTkVfVkVSU0lPTl9NQUpPUih2ZXJzaW9uKSwNCj4gKwkJCVNQSV9FTkdJTkVf
VkVSU0lPTl9NSU5PUih2ZXJzaW9uKSwNCj4gKwkJCVNQSV9FTkdJTkVfVkVSU0lPTl9QQVRDSCh2
ZXJzaW9uKSk7DQo+ICsJCXJldCA9IC1FTk9ERVY7DQo+ICsJCWdvdG8gZXJyX3JlZl9jbGtfZGlz
YWJsZTsNCj4gKwl9DQo+ICsNCj4gIAl3cml0ZWxfcmVsYXhlZCgweDAwLCBzcGlfZW5naW5lLT5i
YXNlICsgU1BJX0VOR0lORV9SRUdfUkVTRVQpOw0KPiAgCXdyaXRlbF9yZWxheGVkKDB4ZmYsIHNw
aV9lbmdpbmUtPmJhc2UgKyBTUElfRU5HSU5FX1JFR19JTlRfUEVORElORyk7DQo+ICAJd3JpdGVs
X3JlbGF4ZWQoMHgwMCwgc3BpX2VuZ2luZS0+YmFzZSArIFNQSV9FTkdJTkVfUkVHX0lOVF9FTkFC
TEUpOw0K
