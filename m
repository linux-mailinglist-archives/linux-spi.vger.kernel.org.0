Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C01ABE1E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505155AbgDPKkA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 06:40:00 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:6371
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505374AbgDPKjw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 06:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9mDZANpowApMQeBrPNVCR1YFSjk1XJnRodP+z27xxPhSG9cN4PlJOFyf+QGNvdVp1a3GT3ZAZyAQgY3zXOOxSyTMDdMbpgecsxQROCbOSTCw3EMrnMKxA61NafqODI2bJvImX0uP60zPWOtg0lYDzAaGdAK0iFWMIGyT3eE/haCFzfyapCq+ZzXd5UlRrAi1DpjYGjMoJ8VtSAwnv6z1l7jvWPruWLwuGXx1FUsYQrRGS4RaN5jVARLc6LCTKON2GYO7MD3FpiJV4rIz0pAO1jVGu4YLYf2OkWdhNlYcN8kGdJiUttZG9PqFIdjyHWziURh1wv2Z9F2mViUxeznnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAE/skY7m5jXDTs9/3s7yWQiktGscxoSXr0XvhC6nJ0=;
 b=ZPhGZLlXpqotfRsXCP+1RYLbNWfRt6K+VL+gsTfEPet/73agNU8W3GVZqk0YXuaaAr0iDLl+Pn6LJLLtaRQCh/C5KnKS941i1Jp0igg6IuRU1T3yPQ/B6OlIqSwgT7MxotN7O6v+2WWbVhdfcAr3CbM98ulM+ELAuYhwgCWzb0svtAqtbPXPYB5flhS7ClD4ZsxX0xumcLvkGfsqFCyzAHwdffVrEvWJKxcO2zVCIbSQ+tT3JMK/FOTlzyVzTHc7uhx+8HTJEoOrLfoblTav0r8tpRbibWGWgsGiO5QCN10wujRcVm1TEybVwnVAgpzzOhgg/9fU8kSs+Jf6gI2agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAE/skY7m5jXDTs9/3s7yWQiktGscxoSXr0XvhC6nJ0=;
 b=GJ64wkpUY8St+4YDINjFTUyrexfoy6V405QV/ewqjsxBJGHQ0jsyUdjdBVCXRal3ENT7R0bdFj7nnWRopyP0Q0XdItseHe28q6q44BKYPwBQeO7WFhOv9Wgi7bgWvh/AQJJjrG4QSBsk6wobMgZUaHJQps3uvXYrd34ed1UWh4g=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR04MB3115.eurprd04.prod.outlook.com (2603:10a6:7:1a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Thu, 16 Apr 2020 10:39:45 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::c84a:5e6a:b6e3:4a1f]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::c84a:5e6a:b6e3:4a1f%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 10:39:44 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] spi: spi-fsl-qspi: Reduce devm_ioremap size to
 4 times AHB buffer size
Thread-Topic: [EXT] Re: [PATCH] spi: spi-fsl-qspi: Reduce devm_ioremap size to
 4 times AHB buffer size
Thread-Index: AQHWE8mv4WznfRToqEiagyEvofDJa6h7fWQAgAARPsA=
Date:   Thu, 16 Apr 2020 10:39:44 +0000
Message-ID: <HE1PR04MB31967794B3CA11BD7C831CED95D80@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <1587025984-5696-1-git-send-email-Ashish.Kumar@nxp.com>
 <95c90219-0fd9-c0b4-5c1a-6abb321ef2e3@kontron.de>
In-Reply-To: <95c90219-0fd9-c0b4-5c1a-6abb321ef2e3@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [106.215.104.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99909817-d5b4-42cc-4d2e-08d7e1f27a76
x-ms-traffictypediagnostic: HE1PR04MB3115:|HE1PR04MB3115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB311521FF160E53AD3ADFF37295D80@HE1PR04MB3115.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(83080400001)(76116006)(33656002)(64756008)(966005)(55016002)(5660300002)(66946007)(8936002)(6506007)(66476007)(66556008)(44832011)(7696005)(53546011)(66446008)(54906003)(316002)(81156014)(71200400001)(8676002)(86362001)(52536014)(9686003)(45080400002)(110136005)(2906002)(186003)(26005)(4326008)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TokqH/R6wWivELPJknadLPFwv6xJsK2hO4kygTnUNBdllGJM0aIhjAe6pij/80SeOOMAx9HkAEYTdygO7OivPs0Aqn/FInz6wQYoUUHxNY6gucMZMHOFGOmxZ/oclCx42vf1J0SCg2hDr5ekc3x12w0Bzrz5tfO/wQj0gVGoD94XMxP4n/IdgQXtc3lNwFUX/W5jftOeU3yJqOwo/qpEwcBP0PLDv34lnPddHc53MbhVMuyyLr8yAdnxEpFt7vCU/O0nyRpdTBoqCZHSAUY1lidFSv0vX9K4eGxQ2+sdZHt27O0zKz0R+7czHBX2/qigfJGpNDjHhP8D/nAmapZM4oUuKsjMseeLVTt43TO0mAMLxewtqZfF9rqHe8C2fA14r6/poe3myXq9QXuJd92OhYPvYNLKd4UjHOPdfn21oITEANDDDnHXzZG4IgEhbmsD8Dnrqm6j45u5DdbiUsBBtqKYoT+iVKNK96hEnzVpmS4f2kOxuAHVrVRYPXxYjbtz
x-ms-exchange-antispam-messagedata: UmmVVBS4xFOHH+ch6i5I8kjzcdXTpiW4eaj18WIAv8wlcJKJEyLfq1kcY40wWLJkZiipxBVn5WvwwnaOaAiuk+A47QyTlbSr241udnMtGpJ0pwjLmq0pLRGvT6RtzU+9XdWOv7tpb6kKrztbkY/3sw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99909817-d5b4-42cc-4d2e-08d7e1f27a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 10:39:44.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCL1W43bRRKSpOUq7oVeWTXSZPOzJgrzYacvW9HG7C92TlpQacQMhAQ7nQz6e8UyHAC4HcW/thNqLryFGd4ceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3115
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgRnJpZWRlciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY2hy
ZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxNiwgMjAyMCAzOjA2IFBNDQo+IFRvOiBBc2hpc2ggS3VtYXIgPGFzaGlzaC5r
dW1hckBueHAuY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBib3Jpcy5icmV6aWxsb25AY29s
bGFib3JhLmNvbQ0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgS3VsZGVlcCBTaW5naA0KPiA8a3VsZGVlcC5zaW5naEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBzcGk6IHNwaS1mc2wtcXNwaTogUmVkdWNl
IGRldm1faW9yZW1hcCBzaXplIHRvIDQNCj4gdGltZXMgQUhCIGJ1ZmZlciBzaXplDQo+IA0KPiBD
YXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IEhpIEFzaGlzaCwNCj4gDQo+IE9uIDE2LjA0LjIwIDEw
OjMzLCBBc2hpc2ggS3VtYXIgd3JvdGU6DQo+ID4gUmVkdWNlIGRldm1faW9yZW1hcCBzaXplIHRv
ICg0ICogQUhCX0JVRkVSX1NJWkUpIHJhdGhlciB0aGFuIG1hcHBpbmcNCj4gPiBjb21wbGV0ZSBR
U1BJLU1lbW1vcnkgYXMgZHJpdmVyIGlzIG5vdyBpbmRlcGVuZGVudCBvZiBmbGFzaCBzaXplLg0K
PiA+IEZsYXNoIG9mIGFueSBzaXplIGNhbiBiZSBhY2Nlc3NlZC4NCj4gPg0KPiA+IElzc3VlIHdh
cyByZXBvcnRlZCBvbiBwbGF0Zm9ybSB3aGVyZSBkZXZtX2lvcmVtYXAgZmFpbHVyZSBpcyBvYnNl
cnZlZA0KPiA+IHdpdGggc2l6ZSA+IDI1Nk0uDQo+ID4gRXJyb3IgbG9nIG9uIExTMTAyMUFUV1Ig
Og0KPiA+ICAgZnNsLXF1YWRzcGkgMTU1MDAwMC5zcGk6IGlvcmVtYXAgZmFpbGVkIGZvciByZXNv
dXJjZSBbbWVtIDB4NDAwMDAwMDAtDQo+IDB4N2ZmZmZmZmZdDQo+ID4gICBmc2wtcXVhZHNwaSAx
NTUwMDAwLnNwaTogRnJlZXNjYWxlIFF1YWRTUEkgcHJvYmUgZmFpbGVkDQo+ID4gICBmc2wtcXVh
ZHNwaTogcHJvYmUgb2YgMTU1MDAwMC5zcGkgZmFpbGVkIHdpdGggZXJyb3IgLTEyDQo+ID4NCj4g
PiBUaGlzIGNoYW5nZSB3YXMgYWxzbyBzdWdnZXN0ZWQgcHJldmlvdXNseToNCj4gPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZwYXRjDQo+ID4NCj4gaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA1MDg3NTMlMkYlMjMy
MjE2NjM4NSZhbXA7ZGF0YT0wMiU3Qw0KPiAwMSU3Q2ENCj4gPg0KPiBzaGlzaC5rdW1hciU0MG54
cC5jb20lN0M3ZTRhNjkxMzAzMGY0ZjVhNGEwNDA4ZDdlMWU5YTM0MiU3QzY4NmVhDQo+IDFkM2Jj
Mg0KPiA+DQo+IGI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MjI2MjY1OTAzNTc1
OTMzJmFtcDtzZGF0YT1KRGINCj4gazByQTJMDQo+ID4gNUV3QWFoOFMzc3JkNXUyNmJPeGFEMU1W
UjN2b1VLRnh5SSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gU28gaWYgeW91IHdhbnQgeW91IGNv
dWxkIGFkZCBhICJTdWdnZXN0ZWQtYnkiIHRhZyByZWZlcnJpbmcgdG8gQm9yaXMuDQpTdXJlLCBJ
IHdpbGwgYWRkIGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEt1bGRlZXAgU2luZ2ggPGt1bGRlZXAuc2luZ2hAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBc2hpc2ggS3VtYXIgPEFzaGlzaC5rdW1hckBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9zcGkvc3BpLWZzbC1xc3BpLmMgfCAxMCArKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtcXNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3Bp
LmMNCj4gPiBpbmRleCA2M2M5ZjdlLi5hNDFjZTgxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
c3BpL3NwaS1mc2wtcXNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMN
Cj4gPiBAQCAtODU5LDE0ICs4NTksMTUgQEAgc3RhdGljIGludCBmc2xfcXNwaV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4NCj4gPiAgICAgICByZXMgPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlF1YWRTUEktbWVtb3J5Iik7DQo+ID4g
LSAgICAgcS0+YWhiX2FkZHIgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+
ICsgICAgIHEtPm1lbW1hcF9waHkgPSByZXMtPnN0YXJ0Ow0KPiA+ICsgICAgIC8qIFNpbmNlIHRo
ZXJlIGFyZSA0IENTIG1heCBNQVAgcmVxdWlyZWQgaXMgNCB0aW1lIGFoYl9idWZfc2l6ZQ0KPiA+
ICsgKi8NCj4gDQo+IC8qIFNpbmNlIHRoZXJlIGFyZSA0IGNzLCBtYXAgc2l6ZSByZXF1aXJlZCBp
cyA0IHRpbWVzIGFoYl9idWZfc2l6ZSAqLw0KPiANCj4gPiArICAgICBxLT5haGJfYWRkciA9IGRl
dm1faW9yZW1hcChkZXYsIHEtPm1lbW1hcF9waHksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplICogNCkpOw0KPiA+ICAg
ICAgIGlmIChJU19FUlIocS0+YWhiX2FkZHIpKSB7DQo+ID4gICAgICAgICAgICAgICByZXQgPSBQ
VFJfRVJSKHEtPmFoYl9hZGRyKTsNCj4gPiAgICAgICAgICAgICAgIGdvdG8gZXJyX3B1dF9jdHJs
Ow0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgIHEtPm1lbW1hcF9waHkgPSByZXMtPnN0YXJ0
Ow0KPiA+IC0NCj4gPiAgICAgICAvKiBmaW5kIHRoZSBjbG9ja3MgKi8NCj4gPiAgICAgICBxLT5j
bGtfZW4gPSBkZXZtX2Nsa19nZXQoZGV2LCAicXNwaV9lbiIpOw0KPiA+ICAgICAgIGlmIChJU19F
UlIocS0+Y2xrX2VuKSkgew0KPiA+IEBAIC05MzksNiArOTQwLDkgQEAgc3RhdGljIGludCBmc2xf
cXNwaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiA+ICpwZGV2KQ0KPiA+DQo+ID4g
ICAgICAgbXV0ZXhfZGVzdHJveSgmcS0+bG9jayk7DQo+ID4NCj4gPiArICAgICBpZiAocS0+YWhi
X2FkZHIpDQo+ID4gKyAgICAgICAgICAgICBkZXZtX2lvdW5tYXAocS0+ZGV2LCBxLT5haGJfYWRk
cik7DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0byB1bm1hcCBleHBsaWNpdGx5LiBVc2luZyBkZXZt
XyooKSwgbGlmZXRpbWUgb2YgdGhlIHJlc291cmNlDQo+IGlzIGFscmVhZHkgdGllZCB0byB0aGUg
ZGV2aWNlLg0KVGhhbmtzLiBJIHdpbGwgcmVtb3ZlIHRoaXMuDQoNClJlZ2FyZHMNCkFzaGlzaCAN
Cj4gDQo+IFRoYW5rcywNCj4gRnJpZWRlcg0KPiANCj4gPiArDQo+ID4gICAgICAgcmV0dXJuIDA7
DQo+ID4gICB9DQo+ID4NCj4gPg0K
