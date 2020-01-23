Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B721466EA
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWLiy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 06:38:54 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:62631
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbgAWLiy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Jan 2020 06:38:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsFbhJQFe58ZupP/Cxrxni8iHQx0QyLFJebOqKiuGcfzSx0b+c7TlHokstHzC7qLRCQo/Ud6E7b+Pd7YPVEd79Wozu/j5w3KIC4r4pjOcSQ0l+Eev2Q7PxTFybOLbIXEGUv0H0QkpMwXbpXITpoLmusCbYddOxEbx9UBsHZOOiFzft12aAxpTFYYTsZPao0x4X7T15nuWmKAI1m8OM6uhXdTSz8RMGT0pTb2EWwIPawx5pUwXRS/gJCXN7dUU3xnTcRWPa7QdQZHo7l/SuYjzePQgdW1jDrLr0eXCECTN8wPWLeY+uWUhACPBftH+TMUdhWANO09vahjkObr/YbYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL/V63a2Npsh1uHMe8Qzg9sS/+K2MUjAZTCt7ixvVPE=;
 b=iRmTbwRDHrDJez3GKSkOFV/7/kY1tXYUtWRHMTmVfRx2Gb1pj2yIUYib7Q8rYXksq2Xb1l02hXADGOep2ZMebOBiJr9pogo2jrhWtEZ2OTh1Dj2gD5tqv4+Va3HCKWwsrUqTss1nrV01ZWF+Ag1+N2OiwJ1htkBHpLDybAvtmHoWlsxKUeLij7ByCId/zLliaDlpk8yILVAbZ6HwxyR9seSqlvO9O+pvQrdJ2TnxtJ2rHzLqMH5sccVc8SRo9rQnvc1TkAQeIGqMfnnxAwRhj0iwkcJZ9/RpvQH5Wr1Gl38K+JvVkFhYSvPZU6JqZVaF+FD+8TWl+puBYhPai02CTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL/V63a2Npsh1uHMe8Qzg9sS/+K2MUjAZTCt7ixvVPE=;
 b=AcaCJ3I5G8Ct4FXBY72u3JQWiJUHa5T6VZ9b5Wx+nbDk7h4kU373GatnC5Nml/gqengDG/MtyJvUoVwFTqH0TFHPd6PErUw6kmJiXFTRLET8RthPJE1S6kuU8M2I5KO1rpt9zDAZKVQG7hor2UbhczigBZnTqeNeNSVotcdnlV8=
Received: from AM6PR0402MB3557.eurprd04.prod.outlook.com (52.133.17.17) by
 AM6PR0402MB3478.eurprd04.prod.outlook.com (52.133.24.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 23 Jan 2020 11:37:09 +0000
Received: from AM6PR0402MB3557.eurprd04.prod.outlook.com
 ([fe80::9183:347b:76b0:49e]) by AM6PR0402MB3557.eurprd04.prod.outlook.com
 ([fe80::9183:347b:76b0:49e%6]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 11:37:09 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: RE: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for
 the Cadence QSPI controller
Thread-Topic: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for
 the Cadence QSPI controller
Thread-Index: AQHVy2r4wV90xU+/jkuGAisRlGad3Kf34utAgAAI2ACAABl2oA==
Date:   Thu, 23 Jan 2020 11:37:09 +0000
Message-ID: <AM6PR0402MB35573B2313C7FB81D747ABA6E00F0@AM6PR0402MB3557.eurprd04.prod.outlook.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
 <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
In-Reply-To: <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4f95a0e-402e-4bc3-3ebf-08d79ff894be
x-ms-traffictypediagnostic: AM6PR0402MB3478:
x-microsoft-antispam-prvs: <AM6PR0402MB3478DD6C0A72F37726045855E00F0@AM6PR0402MB3478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(2906002)(55016002)(9686003)(186003)(76116006)(26005)(5660300002)(44832011)(52536014)(66556008)(53546011)(6506007)(66946007)(66476007)(66446008)(478600001)(316002)(45080400002)(81156014)(81166006)(8936002)(7696005)(8676002)(54906003)(110136005)(966005)(64756008)(86362001)(4326008)(71200400001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3478;H:AM6PR0402MB3557.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8PFfrKlCVOcMENtbSuN+mV0Q3ovcOUizD5CtBs6ly0hnn0y60ZhxUqCHFnuRBryQP7e8e6usWxZZHnMonpmaDzxiWhcFktj1awjUW6gqkltz7+G9L8tD8JgvDlLItFj7AkF5euf78Mhrb817UGu9xxjjIz/ZIKW6hoHp95BKXDkplfgtp0HuyKZ8UioWjcQQ0FvulBdLVdkrPJOWx7+pn2GexnGlumHk/518Yd2U5g+ixfxsHBpnp0XLRi5FJItf7f5PA1AIb69qTZRLxWCxoVQAmb49knkcmupU16R/VzfxM5D53v3jqZvpzYVR9M44QQBWeRgkX3QarjHu/WUw3M8Xg9qqylAWkFuc6KruSrgkHU+uS7OVYDDJb248Ec78Ig9vsBU5BXSY4lsom1mhDS5tsAxcxmIooZl1ybQ1hbJFgB9O/TGMMAJ4XfGruwXEakdT6GZvkRZGLez/KNKDDhDPok29QLKmlMFqJKKnxUVRMFl/qnO4Jg8RHbLGaQk2AEbKClyKH2xRri4tGq0APYfgzrM7/Cq8rl65UIFD79pS4/KDRlULPJApTJNfEhrgf4wr90FLzX+wBUsQtn5+A==
x-ms-exchange-antispam-messagedata: C6m7CNU284RqMdhWhbDNAJubY7EgjN2ZHThMpaRY8ZtBqNVbql0A5vIrUk4tTRXTWKfTUs1pqck4hGAJXKdq4wxSNZI8gpmtHpn06WHzQLaprvRHF0r/OiJvL8/3Jzv0FGI49ABbuYVO6kku2Ihowg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f95a0e-402e-4bc3-3ebf-08d79ff894be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 11:37:09.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5F4Q7zjItEkwZYSBMqU9R3G7B4EHzEEp2jq94ov+j8pjsqaMObbKATNtWjA7fWdaT47BEYfphU9cWFflHDzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3478
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWdu
ZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51
YXJ5IDIzLCAyMDIwIDE6MTcgUE0NCj4gVG86IEt1bGRlZXAgU2luZ2ggPGt1bGRlZXAuc2luZ2hA
bnhwLmNvbT47IFJhbXV0aGV2YXIsVmFkaXZlbCBNdXJ1Z2FuWA0KPiA8dmFkaXZlbC5tdXJ1Z2Fu
eC5yYW11dGhldmFyQGxpbnV4LmludGVsLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgbGludXgt
DQo+IHNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tOw0KPiBjaGVv
bC55b25nLmtpbUBpbnRlbC5jb207IHFpLW1pbmcud3VAaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbRVhUXSBSZTogW1BBVENIIHY2IDAvMl0gc3BpOiBjYWRlbmNlLXF1YWRwc2k6IEFkZCBzdXBw
b3J0IGZvcg0KPiB0aGUgQ2FkZW5jZSBRU1BJIGNvbnRyb2xsZXINCj4gDQo+IENhdXRpb246IEVY
VCBFbWFpbA0KPiANCj4gT24gMjMvMDEvMjAgMTI6NTQgcG0sIEt1bGRlZXAgU2luZ2ggd3JvdGU6
DQo+ID4gSGkgVmlnbmVzaCwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJu
ZWwtDQo+ID4+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFZpZ25lc2ggUmFn
aGF2ZW5kcmENCj4gPj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE1LCAyMDIwIDExOjQzIEFN
DQo+ID4+IFRvOiBSYW11dGhldmFyLFZhZGl2ZWwgTXVydWdhblgNCj4gPj4gPHZhZGl2ZWwubXVy
dWdhbngucmFtdXRoZXZhckBsaW51eC5pbnRlbC5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7DQo+
ID4+IGxpbnV4LSBzcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bTsNCj4gPj4gY2hlb2wueW9uZy5raW1AaW50ZWwuY29tOyBxaS1taW5nLnd1QGludGVsLmNvbQ0K
PiA+PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY2IDAvMl0gc3BpOiBjYWRlbmNlLXF1YWRw
c2k6IEFkZCBzdXBwb3J0DQo+ID4+IGZvciB0aGUgQ2FkZW5jZSBRU1BJIGNvbnRyb2xsZXINCj4g
Pj4NCj4gPj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBP
biAxMi8zMC8yMDE5IDE6MTEgUE0sIFJhbXV0aGV2YXIsVmFkaXZlbCBNdXJ1Z2FuWCB3cm90ZToN
Cj4gPj4+IEFkZCBzdXBwb3J0IGZvciB0aGUgQ2FkZW5jZSBRU1BJIGNvbnRyb2xsZXIuIFRoaXMg
Y29udHJvbGxlciBpcw0KPiA+Pj4gcHJlc2VudCBpbiB0aGUgSW50ZWwgTGlnaHRuaW5nIE1vdW50
YWluKExHTSkgU29DcywgQWx0ZXJhIGFuZCBUSSBTb0NzLg0KPiA+Pj4gVGhpcyBkcml2ZXIgaGFz
IGJlZW4gdGVzdGVkIG9uIHRoZSBJbnRlbCBMR00gU29Dcy4NCj4gPj4+DQo+ID4+PiBUaGlzIGRy
aXZlciBkb2VzIG5vdCBzdXBwb3J0IGdlbmVyaWMgU1BJIGFuZCBhbHNvIHRoZSBpbXBsZW1lbnRh
dGlvbg0KPiA+Pj4gb25seSBzdXBwb3J0cyBzcGktbWVtIGludGVyZmFjZSB0byByZXBsYWNlIHRo
ZSBleGlzdGluZyBkcml2ZXIgaW4NCj4gPj4+IG10ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
LCB0aGUgZXhpc3RpbmcgZHJpdmVyIG9ubHkgc3VwcG9ydA0KPiA+Pj4gU1BJLU5PUiBmbGFzaCBt
ZW1vcnkuDQo+ID4+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBJIGFtIGZpbmFsbHkgYWJsZSB0
byBnZXQgc3BpLW1lbSBiYXNlZCBjYWRlbmNlLXF1YXNwaSBkcml2ZXIgd29ya2luZw0KPiA+PiBv
biBUSSBwbGF0Zm9ybXMgd2l0aCBETUEgYW5kIERBQyBtb2RlLiBJIGhhdmUgYWxzbyBpbmNvcnBv
cmF0ZWQNCj4gPj4gY2hhbmdlcyB0byBkaXNhYmxlIERBQyBhbmQgYXV0b3BvbGxpbmcgZm9yIHlv
dXIgaW50ZWwgU29DOg0KPiA+Pg0KPiA+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQNCj4gPj4gaHViLmNvDQo+ID4+
IG0lMkZyLQ0KPiA+Pg0KPiB2aWduZXNoJTJGbGludXglMkZjb21taXRzJTJGcXNwaSZhbXA7ZGF0
YT0wMiU3QzAxJTdDa3VsZGVlcC5zaW5naCUNCj4gPj4NCj4gNDBueHAuY29tJTdDY2JkMTRhYzUy
N2FlNDI5OGEyODgwOGQ3OTk4MjE5ZTYlN0M2ODZlYTFkM2JjMmI0YzZmYQ0KPiA+Pg0KPiA5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE0NjY1NjM2NTg3MjYzOCZhbXA7c2RhdGE9akFSN2xt
cnkNCj4gPj4gUjlmZHFGM2U0QTJkUXpGMFEwZll4TXZNN3NOaHg4bHZveTAlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPj4NCj4gPj4gKFRvcCB0d28gcGF0Y2hlcyBhcmUgb2YgaW50ZXJlc3QpDQo+ID4+
DQo+ID4+IEkgaGF2ZSB0ZXN0ZWQgYm90aCBEQUMgYW5kIElOREFDIG1vZGUgd2l0aCBzMjVmbCBm
bGFzaCBhbmQgZXZlcnl0aGluZw0KPiA+PiBzZWVtcyB0byBiZSBmaW5lLiBDb3VsZCB5b3UgcmUg
dGVzdCB0aGUgZHJpdmVyIG9uIHlvdXIgU29DPyBGZWVsIGZyZWUNCj4gPj4gdG8gZm9sZCBpdCBp
bnRvIHlvdXIgc2VyaWVzIGlmIGV2ZXJ5dGhpbmcgd29ya3MuDQo+ID4NCj4gPiBJcyBKRkZTMi9V
QklGUyBhIHZhbGlkIHVzZSBjYXNlIGhlcmU/IEFuZCB3ZXJlIHlvdSBhYmxlIHRvIHRlc3QgdGhl
IHNhbWU/DQo+ID4gSSBzZWUgZmV3IGlzc3VlcyB3aXRoIFNwYW5zaW9uIGZsYXNoZXMgKHMyNWZz
KSBpbiBmcmFtZXdvcmsgYW5kIGNvdWxkbuKAmXQNCj4gbWFrZSBGUyB1dGlsaXRpZXMgcnVuLg0K
PiA+IE9uIHRoZSBvdGhlciBoYW5kLCBmaWxlIHN5c3RlbXMgb24gb3RoZXIgZmxhc2hlcyAoZXg6
IG1pY3JvbiwgbXQyNXF1KSBhcmUNCj4gc2hvd2luZyBwb3NpdGl2ZSByZXN1bHRzLg0KPiA+DQo+
IA0KPiBJIGRpZCB0ZXN0IHdpdGggczI1Zmw1MTJzIHdpdGggVUJJRlMgYW5kIGRpZCBub3Qgc2Vl
IGFueSBpc3N1ZS4gDQoNClRoYW5rcyBWaWduZXNoIGZvciB0aGlzIGNvbmZpcm1hdGlvbi4NCg0K
PkNvdWxkIHlvdSB0cnkgd2l0aCBsYXRlc3QgbGludXggbWFzdGVyIG9yIGxpbnV4IG5leHQ/IFRo
ZXJlIHdlcmUgY291cGxlIG9mIGZpeGVzIGluIHRoZSBsYXN0IC1yYw0KPiByZWxhdGVkIHRvIHNw
YW5zaW9uIGZsYXNoZXM/DQoNClllcywgSSBoYXZlIGFscmVhZHkgYXBwbGllZCB0aG9zZSBwYXRj
aGVzIGFuZCBzdGlsbCBmYWNpbmcgdGhpcyBpc3N1ZS4NCkkgYW0gdGVzdGluZyB3aXRoIHMyNWZz
NTEycyBhbmQgb25seSBhYmxlIHRvIG1ha2UgaXQgd29yayBvbiAxYml0IG1vZGUgYW5kIHRoYXQg
dG9vIGJ5IHNraXBwaW5nIFNGRFAuDQpCYXNpYyByZWFkL3dyaXRlIHdvcmtzIG9uIG90aGVyIG1v
ZGVzIGJ1dCBub3QgRlMgdXRpbGl0aWVzLg0KQ291bGQgeW91IHBsZWFzZSBzaGFyZSBhbnkgcG9p
bnRlciB0byBsb29rIGludG8gd2hpY2ggZGlyZWN0aW9uLiBUaGFua3MgaW4gYWR2YW5jZS4NCg0K
VGhhbmtzDQpLdWxkZWVwDQoNCj4gDQo+IFsxXQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQua2VybmUNCj4gbC5v
cmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRm10ZCUyRmxpbnV4LmdpdCUy
RmNvbW1pdA0KPiAlMkYlM0ZoJTNEbXRkJTJGZml4ZXMlMjZpZCUzRDQ0MGI2ZDUwMjU0YmRiZDg0
YzJhNjY1YzdmNTNlYzY5ZGQNCj4gNzQxYTRmJmFtcDtkYXRhPTAyJTdDMDElN0NrdWxkZWVwLnNp
bmdoJTQwbnhwLmNvbSU3Q2VlMzQ1YmRmOWY2NTQNCj4gNGFjOWY0NTA4ZDc5ZmQ4NjNkOSU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlNw0KPiBDNjM3MTUzNjI0MDQx
MzMwNzc0JmFtcDtzZGF0YT1PeUtHbDJqbjVKRHE1S0NhVnJ4QW5VaDRxU3lubUFoUyUNCj4gMkZl
RmlPeEpTS3RVJTNEJmFtcDtyZXNlcnZlZD0wDQo+IFsyXWh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXINCj4gbmVs
Lm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJGbXRkJTJGbGludXguZ2l0
JTJGY29tbQ0KPiBpdCUyRiUzRmglM0RtdGQlMkZmaXhlcyUyNmlkJTNEZGEyZWY4MTI0ZjIwYjRj
ZTE4ZDFkM2QyNGZjN2I4OGU2OA0KPiA3ZTEwYmImYW1wO2RhdGE9MDIlN0MwMSU3Q2t1bGRlZXAu
c2luZ2glNDBueHAuY29tJTdDZWUzNDViZGY5ZjY1DQo+IDQ0YWM5ZjQ1MDhkNzlmZDg2M2Q5JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCUNCj4gN0M2MzcxNTM2MjQw
NDEzMzA3NzQmYW1wO3NkYXRhPUJUUnpXV1kyejZuWm5jeWt0RERJZEpGd1lUcDQxUyUyDQo+IEJ1
aDk5UWFKNjBlMU0lM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+ID4gVGhhbmtzDQo+ID4gS3VsZGVl
cA0KPiA+DQo+ID4+DQo+ID4+IFJlZ2FyZHMNCj4gPj4gVmlnbmVzaA0KPiA+Pg0KPiA+Pg0KPiA+
DQo+IA0KPiAtLQ0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCg==
