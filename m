Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB01A3709
	for <lists+linux-spi@lfdr.de>; Thu,  9 Apr 2020 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDIP0s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Apr 2020 11:26:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45296 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgDIP0s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Apr 2020 11:26:48 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 039F7gHW006314;
        Thu, 9 Apr 2020 11:26:45 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091pqpese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Apr 2020 11:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxfQWAXWFEpRe4kEzoSIbsMR9/gyB5fhyJNVdEV2rHdpkpbUG8NcbaDUvqejiAgajmVdJgQqLUNteEGPGyAxickjaOJun8M+HlUauUKgwwLVuijIdt+5FYGrrDFyiEO4XtNu9wY01FgkCM5igH9OMQFkCNTGmMIKM+3BOzlkq71pVFlhii0NBTDISdBR0MuKX/S8SxVhg+VsDPPaMkO2qk0q6hB46tipRTwa9Eorl3YMcXNHosJ4hxJuIWxOmDWm2p2aelP7WfFKsEUffFUlYdAm4hntTWADFF54z0jU5hR3HnnrT6b1gowmRqSszw60WosdAyBNQ+TW2Kr+u+LhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjM8coS1BNQGVpMsk78fl7PKRIn5J4FNzEG8Ice/qro=;
 b=kMkgyn/1pMCgPg5OV3dd6/c7jsPmxatVTGqXcoFBbnG/tP+0HiQOUlABx6Q1RmUQncDm46gtyh129yzvNMs1MOEYiwcYKpreAjPQjSVwI9ykSpsKBjZ3x7XYjXIPBHB1jkcCWxNW3P5UNHIn0iGfi3UwClRO6iXBvHHsmFQnW7WK+XKBJrnbFIqzyUOUip/KM/B0H3/oEPfV0qj4AohpaW86rhwM00pL21xkrOBnL3bUdWOVV1BEbCOeO50hKoVI6XnadwMFNADj3Z7Mfz/kCErdiz6UJv0ewMJq/9L1I9NjoqYj3IzdSVBE164snG1w0ekMSjZD1Xesg/tpRuKG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjM8coS1BNQGVpMsk78fl7PKRIn5J4FNzEG8Ice/qro=;
 b=gJkRL8TV1M7pco9oVwv5XipyBsbRwtgzaGphcJhsA4EfQtVYWqle4THQjIdKK8Z2TuxrF2esBBKWYX5mloRnJt0+Ff4Vdg/ehGnXkuOfmdldIsrcPCaUjBWeOubSdbV03m15p0J+987wKa3vTbeR7yk6JOQUq7ghl3gClugl+Z4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3769.namprd03.prod.outlook.com (2603:10b6:5:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 15:26:43 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 15:26:43 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafal.hibner@secom.com.pl" <rafal.hibner@secom.com.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-axi-spi-engine: Access register after clock
 initialization
Thread-Topic: [PATCH] spi: spi-axi-spi-engine: Access register after clock
 initialization
Thread-Index: AQHWDoLhRGyYb2rg902V7wi/SoP4Q6hw6pGA
Date:   Thu, 9 Apr 2020 15:26:41 +0000
Message-ID: <a21ea696ceccf55696f0561d7b3931a104b72b3d.camel@analog.com>
References: <67f644c1-a0cf-4897-a66a-e2ad4b11140d@secom.com.pl>
In-Reply-To: <67f644c1-a0cf-4897-a66a-e2ad4b11140d@secom.com.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2eaeef5-60e5-4101-a5a2-08d7dc9a6865
x-ms-traffictypediagnostic: DM6PR03MB3769:
x-microsoft-antispam-prvs: <DM6PR03MB3769E5CDDEAA71F580730570F9C10@DM6PR03MB3769.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(478600001)(86362001)(8936002)(71200400001)(81156014)(6512007)(8676002)(66556008)(91956017)(76116006)(81166007)(5660300002)(6486002)(2906002)(316002)(36756003)(26005)(2616005)(6506007)(186003)(66946007)(66476007)(66446008)(110136005)(64756008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOrnYEL2bHUurqaW1Bttxfdk5ZzwuYE3wSHM7HRFY1jjapq+iVRBRWFNLkMNxRFgqa/grLcvq5/QkqQ4pU51rXiUFAIzKHOZANxKJPcuyu0bQAp4vl4NJhNhTlNOQxjGYmT+/e6MTqquOragIm2mv9wdQuJgejL+v09mTerKOBzOpH9CsnqP+6rxdXOMZxKLXMQ7mDlIWO7XUaD4ZqUUzBUlMOpZ937TGuEIF1oJA2LhsfSmwCGjEPoPuZ3+DKqho2K0W4GwijDcj8fInY+lodAJx201NiXdWolsUkjboKEx8D1o7HW8nsZZVZ0gLYn9IMSTiDwSfM6bybaeXorxMh5BbZGehsDtQvYMyUz7FNVX9a+NUFa92iy+pxRSsLdkxF8o4PvkNtPOGoeSMVdhtIbjHuUQnlgOFaGW02c6WPdmGtYV91rUK14d/2PNbac1
x-ms-exchange-antispam-messagedata: 6hn2+RetHpy70nFMQmGdEgBHxhcRaO1MANv8a+qJZWLLWSVrtMy5auFqoKM8m8pcPHyJnfpZMOjDgWeGTrrPp1+09ch7wr8CR+wZetTHIrGsunmDJ3hQ9QryHLmRVo8SDVCMSWTCYkL9h8dooFg6FA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9DD54C739F17409167B992DDE687D3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eaeef5-60e5-4101-a5a2-08d7dc9a6865
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 15:26:42.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZa9aVjHCrzT/DIXZ2gNl+gf5y9fGIkXnS13DOl/vc6mCPiPXvBCtdmMhdHlrLMXP+jdWhg3AvcRC68oIAraAIpgXsI3BJABLQRty9To/lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3769
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_04:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090117
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQpPbiBUaHUsIDIwMjAtMDQtMDkgYXQgMTc6MjMgKzAyMDAsIFJhZmHFgiBIaWJuZXIgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE1vdmUgcmVnaXN0ZXIgYWNjZXNzIGFmdGVyIGNsb2NrIGlu
aXRpYWxpemF0aW9uLg0KPiANCj4gQ2xvY2sgInNfYXhpX2FjbGsiIGlzIG5lZWRlZCBmb3IgcmVn
aXN0ZXIgYWNjZXNzLiBXaXRob3V0IHRoZSBjbG9jayBydW5uaW5nDQo+IA0KPiBBWEkgYnVzIGhh
bmdzIGFuZCBjYXVzZXMga2VybmVsIGZyZWV6ZS4NCj4gDQoNClRoaXMgZW1haWwgbG9va3MgbGlr
ZSBpdCBoYXMgSFRNTCBmb3JtYXR0aW5nLg0KDQpDYW4geW91IHN3aXRjaCB0byBbYW5kIHVzZSBv
bmx5XSBwbGFpbi10ZXh0Pw0KDQoNCk91dCBvZiBjdXJpb3NpdHk6IGRpZCB5b3UgdXNlIHRoZSAn
Z2l0IHNlbmQtZW1haWwnIGNvbW1hbmQgZm9yIHRoaXMgcGF0Y2g/DQoNCg0KPiBDYzogQWxleGFu
ZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFJhZmHFgiBIaWJuZXIgPHJhZmFsLmhpYm5lckBzZWNvbS5jb20ucGw+DQo+IA0K
PiAtLS0NCj4gDQo+ICBkcml2ZXJzL3NwaS9zcGktYXhpLXNwaS1lbmdpbmUuYyB8IDMyICsrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3NwaS1heGktc3BpLWVuZ2luZS5jIGIvZHJpdmVycy9zcGkvc3BpLWF4aS1zcGktDQo+IGVu
Z2luZS5jDQo+IA0KPiBpbmRleCBlYjliNzhhOTBkLi5hZjg2ZTZkNmUxIDEwMDY0NA0KPiANCj4g
LS0tIGEvZHJpdmVycy9zcGkvc3BpLWF4aS1zcGktZW5naW5lLmMNCj4gDQo+ICsrKyBiL2RyaXZl
cnMvc3BpL3NwaS1heGktc3BpLWVuZ2luZS5jDQo+IA0KPiBAQCAtNDg5LDIyICs0ODksNiBAQCBz
dGF0aWMgaW50IHNwaV9lbmdpbmVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gDQo+ICANCj4gDQo+ICAgc3Bpbl9sb2NrX2luaXQoJnNwaV9lbmdpbmUtPmxvY2spOw0KPiAN
Cj4gIA0KPiANCj4gLSBzcGlfZW5naW5lLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiANCj4gLSBpZiAoSVNfRVJSKHNwaV9lbmdpbmUtPmJhc2UpKSB7
DQo+IA0KPiAtIHJldCA9IFBUUl9FUlIoc3BpX2VuZ2luZS0+YmFzZSk7DQo+IA0KPiAtIGdvdG8g
ZXJyX3B1dF9tYXN0ZXI7DQo+IA0KPiAtIH0NCj4gDQo+IC0NCj4gDQo+IC0gdmVyc2lvbiA9IHJl
YWRsKHNwaV9lbmdpbmUtPmJhc2UgKyBTUElfRU5HSU5FX1JFR19WRVJTSU9OKTsNCj4gDQo+IC0g
aWYgKFNQSV9FTkdJTkVfVkVSU0lPTl9NQUpPUih2ZXJzaW9uKSAhPSAxKSB7DQo+IA0KPiAtIGRl
dl9lcnIoJnBkZXYtPmRldiwgIlVuc3VwcG9ydGVkIHBlcmlwaGVyYWwgdmVyc2lvbiAldS4ldS4l
Y1xuIiwNCj4gDQo+IC0gU1BJX0VOR0lORV9WRVJTSU9OX01BSk9SKHZlcnNpb24pLA0KPiANCj4g
LSBTUElfRU5HSU5FX1ZFUlNJT05fTUlOT1IodmVyc2lvbiksDQo+IA0KPiAtIFNQSV9FTkdJTkVf
VkVSU0lPTl9QQVRDSCh2ZXJzaW9uKSk7DQo+IA0KPiAtIHJldCA9IC1FTk9ERVY7DQo+IA0KPiAt
IGdvdG8gZXJyX3B1dF9tYXN0ZXI7DQo+IA0KPiAtIH0NCj4gDQo+IC0NCj4gDQo+ICAgc3BpX2Vu
Z2luZS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzX2F4aV9hY2xrIik7DQo+IA0K
PiAgIGlmIChJU19FUlIoc3BpX2VuZ2luZS0+Y2xrKSkgew0KPiANCj4gICByZXQgPSBQVFJfRVJS
KHNwaV9lbmdpbmUtPmNsayk7DQo+IA0KPiBAQCAtNTI1LDYgKzUwOSwyMiBAQCBzdGF0aWMgaW50
IHNwaV9lbmdpbmVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAg
aWYgKHJldCkNCj4gDQo+ICAgZ290byBlcnJfY2xrX2Rpc2FibGU7DQo+IA0KPiAgDQo+IA0KPiAr
IHNwaV9lbmdpbmUtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MCk7DQo+IA0KPiArIGlmIChJU19FUlIoc3BpX2VuZ2luZS0+YmFzZSkpIHsNCj4gDQo+ICsgcmV0
ID0gUFRSX0VSUihzcGlfZW5naW5lLT5iYXNlKTsNCj4gDQo+ICsgZ290byBlcnJfcmVmX2Nsa19k
aXNhYmxlOw0KPiANCj4gKyB9DQo+IA0KPiArDQo+IA0KPiArIHZlcnNpb24gPSByZWFkbChzcGlf
ZW5naW5lLT5iYXNlICsgU1BJX0VOR0lORV9SRUdfVkVSU0lPTik7DQo+IA0KPiArIGlmIChTUElf
RU5HSU5FX1ZFUlNJT05fTUFKT1IodmVyc2lvbikgIT0gMSkgew0KPiANCj4gKyBkZXZfZXJyKCZw
ZGV2LT5kZXYsICJVbnN1cHBvcnRlZCBwZXJpcGhlcmFsIHZlcnNpb24gJXUuJXUuJWNcbiIsDQo+
IA0KPiArIFNQSV9FTkdJTkVfVkVSU0lPTl9NQUpPUih2ZXJzaW9uKSwNCj4gDQo+ICsgU1BJX0VO
R0lORV9WRVJTSU9OX01JTk9SKHZlcnNpb24pLA0KPiANCj4gKyBTUElfRU5HSU5FX1ZFUlNJT05f
UEFUQ0godmVyc2lvbikpOw0KPiANCj4gKyByZXQgPSAtRU5PREVWOw0KPiANCj4gKyBnb3RvIGVy
cl9yZWZfY2xrX2Rpc2FibGU7DQo+IA0KPiArIH0NCj4gDQo+ICsNCj4gDQo+ICAgd3JpdGVsX3Jl
bGF4ZWQoMHgwMCwgc3BpX2VuZ2luZS0+YmFzZSArIFNQSV9FTkdJTkVfUkVHX1JFU0VUKTsNCj4g
DQo+ICAgd3JpdGVsX3JlbGF4ZWQoMHhmZiwgc3BpX2VuZ2luZS0+YmFzZSArIFNQSV9FTkdJTkVf
UkVHX0lOVF9QRU5ESU5HKTsNCj4gDQo+ICAgd3JpdGVsX3JlbGF4ZWQoMHgwMCwgc3BpX2VuZ2lu
ZS0+YmFzZSArIFNQSV9FTkdJTkVfUkVHX0lOVF9FTkFCTEUpOw0KPiANCj4gLS0NCj4gDQo+IDIu
MjQuMQ0KPiANCg==
