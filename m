Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD87F146284
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 08:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgAWHYc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 02:24:32 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:12854
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgAWHYb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Jan 2020 02:24:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgNPEMIuG2Qt7MOqE9x4iJQ2y7q9hHgZx4TV5JFLpxjud9XAbJDpI0jXcbTsTQz35c+dtABeCWWVjWL8kWopzEWTH4EwjPhRYVdOGzUS33kAYHKqUpchLhe0xjXttvfgFORbDUFZr+t2JrgJd0+X9PY19BunREHeyFwe5+TQzws1yR5dZEMj7eE9HxtKBnWHs652w0+6j4z9Abb/VyuA/Uw628Q3H8zmVNnfktmHC+3DG0n5+Jfpi5rn9WrCWbmXodq9JMDlKqt7nd7cScSRj2HvoliUrdEu4fbP6apdzvcUScvt8ztz5E3+DsAmvOYSL9EJTEtiKREAknnRfYquZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njweKTqbOSiekgKMUJJk5vXa33vEUI/ExDionDCmcDk=;
 b=Z2R1GuLoyI4pKTnfGhc020A4ESZfdk1vERl1GCc/B5Dpp4ZAWU3RWMWWtMvICS6g5GB3yqkw49kxkTQWkeNsfLV0tcyHMrxJ+wnOa8+6rRs8tI8eQNyJ0fuU/MdZMhcIpNJ+dLrqAN01kpem0bQNBKJqQ86ZlUV0iH8EgQSj49wJBrbc1ww4KpErDDWPnRLeDn0WVKig46o3pHa1hG+/O5pp82AowUiXK9B2PfTTKzAbJBf5Pouy7YamJh5K7P1TZlWF1LitJfE1TgRTrt7f2v3X9LxNfZmBZOAtUx133TtET2id39UU5zNBhZkXrywHtVclKn8921BWbQHskf9xTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njweKTqbOSiekgKMUJJk5vXa33vEUI/ExDionDCmcDk=;
 b=kmBIul7zw50wDdyYPpK+jYZHgP/mn18w9oiCQBwLPvweksIFpMiIoJtG5WzIs+qRKMowaq8wu1Iq2J7PafKGAQOygiXywX6jaIJ5QpJGbr6vgFOozIUiIJZNEUaOY9dfpUZbALm2h5kMufg0IjNfoyKV4ymNeJY2m9D6tqmQCh8=
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com (52.133.43.147) by
 AM0PR0402MB3410.eurprd04.prod.outlook.com (52.133.44.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 07:24:26 +0000
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3]) by AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 07:24:26 +0000
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
Thread-Index: AQHVy2r4wV90xU+/jkuGAisRlGad3Kf34utA
Date:   Thu, 23 Jan 2020 07:24:26 +0000
Message-ID: <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
In-Reply-To: <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3d36520-766e-4dde-60ec-08d79fd54743
x-ms-traffictypediagnostic: AM0PR0402MB3410:
x-microsoft-antispam-prvs: <AM0PR0402MB3410010D53FDE0020B409365E00F0@AM0PR0402MB3410.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(81166006)(86362001)(81156014)(45080400002)(8676002)(6506007)(53546011)(186003)(66946007)(76116006)(4326008)(66476007)(8936002)(66446008)(64756008)(66556008)(7696005)(26005)(5660300002)(316002)(54906003)(52536014)(2906002)(71200400001)(44832011)(9686003)(110136005)(966005)(55016002)(478600001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3410;H:AM0PR0402MB3556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jf90BqD/ab2BnASzU1RGV1mWrZ3rdSdDFX2sPjWYda3l2pHrMof/g1SzFNTW2K81t9MkhlvLWBLpcL+MfhuIMugiaaad1V/+eRsWAO2dh7tc98e889w1BQoytp6SQWEjgeap3XFoADDeo73XJUlVukGbWpxDcys4wPmq6lDQkzjc+Zhcs+2uneKowhKFFLStVRTxYGqlj1NRe7hxOvXXAazR4VJ+iKAuuUKwMeZHE880kWIvCBphRs2qcfUm0L1Xs+q8/2vCQN26fyFh/f/DWae+cX86J9NdQyYwnUxF1GP0XTiE9PIzGOryJrbejsjrajG417Mm7o3APZhPH5WkUcW5W83yANu9/tHOBOm8JE3AlCGePZZLEt9zPwhmgKph807jkEXBeC3e6vffPlaRsNDjPw8KwG4fRc6V5b3z/V6E7ZImwCkJSQLFsbQvR3YXfPDmMr5WGlNUDEk6ihJgEn7U79rELYgBXZUwp/z/4s4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d36520-766e-4dde-60ec-08d79fd54743
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 07:24:26.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXnzy8y/JzImdveujs64QXPqjp7EHT9P2od8C2ma+lWNwMZq/xTfTyXoZKKprekFYA01nwF4sAsLJ5zOankXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3410
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZn
ZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gU2VudDog
V2VkbmVzZGF5LCBKYW51YXJ5IDE1LCAyMDIwIDExOjQzIEFNDQo+IFRvOiBSYW11dGhldmFyLFZh
ZGl2ZWwgTXVydWdhblgNCj4gPHZhZGl2ZWwubXVydWdhbngucmFtdXRoZXZhckBsaW51eC5pbnRl
bC5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBzcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7
IGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbTsNCj4gY2hlb2wueW9uZy5raW1AaW50ZWwuY29tOyBx
aS1taW5nLnd1QGludGVsLmNvbQ0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY2IDAvMl0g
c3BpOiBjYWRlbmNlLXF1YWRwc2k6IEFkZCBzdXBwb3J0IGZvciB0aGUNCj4gQ2FkZW5jZSBRU1BJ
IGNvbnRyb2xsZXINCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGksDQo+IA0KPiBP
biAxMi8zMC8yMDE5IDE6MTEgUE0sIFJhbXV0aGV2YXIsVmFkaXZlbCBNdXJ1Z2FuWCB3cm90ZToN
Cj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIENhZGVuY2UgUVNQSSBjb250cm9sbGVyLiBUaGlzIGNv
bnRyb2xsZXIgaXMNCj4gPiBwcmVzZW50IGluIHRoZSBJbnRlbCBMaWdodG5pbmcgTW91bnRhaW4o
TEdNKSBTb0NzLCBBbHRlcmEgYW5kIFRJIFNvQ3MuDQo+ID4gVGhpcyBkcml2ZXIgaGFzIGJlZW4g
dGVzdGVkIG9uIHRoZSBJbnRlbCBMR00gU29Dcy4NCj4gPg0KPiA+IFRoaXMgZHJpdmVyIGRvZXMg
bm90IHN1cHBvcnQgZ2VuZXJpYyBTUEkgYW5kIGFsc28gdGhlIGltcGxlbWVudGF0aW9uDQo+ID4g
b25seSBzdXBwb3J0cyBzcGktbWVtIGludGVyZmFjZSB0byByZXBsYWNlIHRoZSBleGlzdGluZyBk
cml2ZXIgaW4NCj4gPiBtdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYywgdGhlIGV4aXN0aW5n
IGRyaXZlciBvbmx5IHN1cHBvcnQNCj4gPiBTUEktTk9SIGZsYXNoIG1lbW9yeS4NCj4gPg0KPiAN
Cj4gDQo+IA0KPiBJIGFtIGZpbmFsbHkgYWJsZSB0byBnZXQgc3BpLW1lbSBiYXNlZCBjYWRlbmNl
LXF1YXNwaSBkcml2ZXIgd29ya2luZyBvbiBUSQ0KPiBwbGF0Zm9ybXMgd2l0aCBETUEgYW5kIERB
QyBtb2RlLiBJIGhhdmUgYWxzbyBpbmNvcnBvcmF0ZWQgY2hhbmdlcyB0bw0KPiBkaXNhYmxlIERB
QyBhbmQgYXV0b3BvbGxpbmcgZm9yIHlvdXIgaW50ZWwgU29DOg0KPiANCj4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0
aHViLmNvDQo+IG0lMkZyLQ0KPiB2aWduZXNoJTJGbGludXglMkZjb21taXRzJTJGcXNwaSZhbXA7
ZGF0YT0wMiU3QzAxJTdDa3VsZGVlcC5zaW5naCUNCj4gNDBueHAuY29tJTdDY2JkMTRhYzUyN2Fl
NDI5OGEyODgwOGQ3OTk4MjE5ZTYlN0M2ODZlYTFkM2JjMmI0YzZmYQ0KPiA5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMCU3QzYzNzE0NjY1NjM2NTg3MjYzOCZhbXA7c2RhdGE9akFSN2xtcnkNCj4gUjlm
ZHFGM2U0QTJkUXpGMFEwZll4TXZNN3NOaHg4bHZveTAlM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+
IChUb3AgdHdvIHBhdGNoZXMgYXJlIG9mIGludGVyZXN0KQ0KPiANCj4gSSBoYXZlIHRlc3RlZCBi
b3RoIERBQyBhbmQgSU5EQUMgbW9kZSB3aXRoIHMyNWZsIGZsYXNoIGFuZCBldmVyeXRoaW5nIHNl
ZW1zDQo+IHRvIGJlIGZpbmUuIENvdWxkIHlvdSByZSB0ZXN0IHRoZSBkcml2ZXIgb24geW91ciBT
b0M/IEZlZWwgZnJlZSB0byBmb2xkIGl0IGludG8NCj4geW91ciBzZXJpZXMgaWYgZXZlcnl0aGlu
ZyB3b3Jrcy4NCg0KSXMgSkZGUzIvVUJJRlMgYSB2YWxpZCB1c2UgY2FzZSBoZXJlPyBBbmQgd2Vy
ZSB5b3UgYWJsZSB0byB0ZXN0IHRoZSBzYW1lPw0KSSBzZWUgZmV3IGlzc3VlcyB3aXRoIFNwYW5z
aW9uIGZsYXNoZXMgKHMyNWZzKSBpbiBmcmFtZXdvcmsgYW5kIGNvdWxkbuKAmXQgbWFrZSBGUyB1
dGlsaXRpZXMgcnVuLg0KT24gdGhlIG90aGVyIGhhbmQsIGZpbGUgc3lzdGVtcyBvbiBvdGhlciBm
bGFzaGVzIChleDogbWljcm9uLCBtdDI1cXUpIGFyZSBzaG93aW5nIHBvc2l0aXZlIHJlc3VsdHMu
DQoNClRoYW5rcw0KS3VsZGVlcA0KDQo+IA0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCj4gDQo+IA0K
DQo=
