Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F129FB04
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 03:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgJ3CEK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 22:04:10 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:35496
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgJ3CEJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 22:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWp9p4lpfkgXuKOVkD3SY7izUrVrC5eh4P5T8FNIPZHhq5AlePTjs8HKGbBpvPqbZXn/OgPn2V3JEfBvBCBKPRZj+S+ORCwfOU67Uu2Fzal33O80PqEM0xmd5L75jTGfiVS+4KNJydTa4QnfVznuhwHSxDT5BeGIrOe8wxypzwu0IRqiL5uC0WXORy8UJiOIhykJJNmgWPEFgyHyKE7xpeEt1yvdlGGeAc1h8GOLffYiks58i8xjlsPXZ6abUFFeFLUufgM47uZcT2Php9G+MaKUhvGTg7kJqezoGS8juK/EOtTDIJwWFNPx9fmJ2WPwSkMPDuEasxvah//nZ1m3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3I+7cmNOTjr+KTPV2MUIBMhs0pzFfz4tONOToVB8C0=;
 b=OOd395f4AYq2MzLED4iwUci4koI5WjlIp+3QetcB5iVVouv8j9L+HaIqQGn3AcvgOxgspv1aJ3VPHA7eb0ujm+XcBglXshTpLJ982nM633L5J6m+O24Ni0XWwVPUgTch1+fbsQoUQ6soN7NB2vG7fCHLkn3v3osS9A3c1JJPDozb+o55FCLwkKuWWd3LGCn54kR5nOZNST27GSZhHmec5l3aEko7T9VTkQAjuqbV/OK7tAFiDNUFYUw1Hhtgfr+Xz1La+ukta/wsqivIFIf/V6WbMtjobx2wLvDQZo5DnACYqUt6OY5Gi3maMLv0WmaU3djRsTfcwWfz5nwk0TI5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3I+7cmNOTjr+KTPV2MUIBMhs0pzFfz4tONOToVB8C0=;
 b=s8JbmrYcP2Y9M8AOLBj6xiH+GQNqUvNjLIr+FwDrFTDDq823CltQQ4/m/extgdUbyAEBeVqA0RsTqUciv+AmkTu6pWYxv0eNi7nlwWrf/JVua2uDHkek77gjsRFwoiih3aWExV66ANq54i/qpflhtr1YgdL1tnmJ+RdnTdiP598=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR0402MB2894.eurprd04.prod.outlook.com (2603:10a6:800:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 02:04:06 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35%6]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 02:04:06 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Topic: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Index: AQHWrdB51nJYwHeGTEukPNQ8v2xIXamuapaAgAD5hoA=
Date:   Fri, 30 Oct 2020 02:04:06 +0000
Message-ID: <VE1PR04MB676878E41EB6E44B325A9C3A91150@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
 <20201029110319.iyvfmrlq6uz2pl2e@skbuf>
In-Reply-To: <20201029110319.iyvfmrlq6uz2pl2e@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b58d947-b995-4f03-113d-08d87c781511
x-ms-traffictypediagnostic: VI1PR0402MB2894:
x-microsoft-antispam-prvs: <VI1PR0402MB28945450382279CAEAADC90C91150@VI1PR0402MB2894.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdTKlOvUUJOXw3gibMVIOMPcXO3QxsGoswJxEXHF48BmbpZLgfVNln3gEGT7SQe/rL/OIcTq7q2oQUhyUL2oKOTz4JV0QQ1cwNbIT+HZcdfZ70IiH53+7M6uG+y+zdbJqSd/84d/PWKty+rK3Gn5qsbtmfZgS98OrBdq+t1+HXX+wfWkWMfaG+SGvfPxIZY0YdEsejgbPRHxAK9qWtCa4GpIKW6h5vsseGMO499u2kQYwUkib9W0wG0Sl7kHqj51mvTj5Z4LCqTcItaVi0PSsyzB+zZBQr/phpPmPb/NJ1om81hbfvp8eVw1JgiMmFVw/in4m/9HlDLgGVoYlUBUFxy4AFI8twfn5T1YZ4d6/uiLfCYM3AfEGHu1CgtkSDGmS4c8I692u/5/aTrqVL4xfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(53546011)(83380400001)(6506007)(8936002)(44832011)(7696005)(4326008)(66446008)(186003)(52536014)(9686003)(2906002)(8676002)(86362001)(26005)(316002)(54906003)(55016002)(66556008)(66476007)(66946007)(64756008)(76116006)(71200400001)(45080400002)(478600001)(966005)(33656002)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hpfxLxZ7ALEkIbZwVcUH5qvr5ZlmpYbWdd2DV/xqbxl0ZEf8gD39C4xNZRpgY59rZouFEixL0o4ona/npiOZRbSN6K4JVm8ROvN7Y2+UTpvxgCbAIxT9U3Q33bt50WW5vRBMd9gKRe+lsz1D27xUuk1G1cZqKYmrl2BW0cw7KIAjfkJApUYa6xBo+UJdUodtN/y7SPrBQFjAFNJEzlPZ00m7jFQU03j5YqlLIvMfZ1wWvYJc1+xfC2H3k2hc8D5PC0Cbb87oyo2fexXkhtzqGNfIWzdLAmN+xJ2g7DS30DGl0zPIXDJ8L0iwQbuoKTrByDidx+cypZ7RTMRaSxw0Umwl3nMYDebn7Sp6fUiSl+IB8zosGvTCxht9ZXmW4U9n28eJM2kwFlR/u2GxKjdc1BLBr7fQkPWnbFNuiAbwBoz+1Sg5b3Tjnu4oyp+QbqJhTbsFvuRXHkx6q7E4EOrufdnCOy3Rc2Wg5gNXuzge5RG+X6lvo6sxrdT6Qq7IubaPV0QE8Rzct3D2VbQZm7ZTNrwPTskOW2u28DqodK6oEvu3TjukPykNl+kuPWzH090kDznbEOM+FkKpGUHdnAU+qSoqWCr2TV6xMQHVghNhtZbtMd5L20yUMiyvXu7vUabwdcRqaU2FHpWBJtUnj/LorA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b58d947-b995-4f03-113d-08d87c781511
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 02:04:06.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4z/MqkQHZ5gU49kFqBiiRrt4XlvvZ5/ur4kToPoEkLDM+eiMkKce/9vwDzi3tHWSCeP1m8okuj3+r8MTJeP/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2894
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBPY3QgMjksIDIwMjAgYXQgMTk6MDNQTSwgVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52
QGdtYWlsLmNvbT4gd3JvdGU6DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBWbGFkaW1pciBPbHRlYW4gPG9sdGVhbnZAZ21haWwuY29tPg0KPiBTZW50OiAyMDIwxOox
MNTCMjnI1SAxOTowMw0KPiBUbzogUWlhbmcgWmhhbyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiBD
YzogYnJvb25pZUBrZXJuZWwub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNwaTogZnNs
LWRzcGk6IGZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gDQo+IE9uIFRodSwgT2N0IDI5
LCAyMDIwIGF0IDA0OjQwOjM1UE0gKzA4MDAsIFFpYW5nIFpoYW8gd3JvdGU6DQo+ID4gRnJvbTog
WmhhbyBRaWFuZyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+DQo+ID4gU2luY2UgY29tbWl0IDUz
MGI1YWZmYzY3NSAoInNwaTogZnNsLWRzcGk6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbg0KPiA+IHJl
bW92ZSBwYXRoIiksIHRoaXMgZHJpdmVyIGNhdXNlcyBhIGtlcm5lbCBvb3BzOg0KPiA+DQo+ID4g
WyAgIDY0LjU4NzQzMV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGF0DQo+ID4gdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMjANCj4gPiBbLi5d
DQo+ID4gWyAgIDY0Ljc1NjA4MF0gQ2FsbCB0cmFjZToNCj4gPiBbICAgNjQuNzU4NTI2XSAgZHNw
aV9zdXNwZW5kKzB4MzAvMHg3OA0KPiA+IFsgICA2NC43NjIwMTJdICBwbGF0Zm9ybV9wbV9zdXNw
ZW5kKzB4MjgvMHg3MA0KPiA+IFsgICA2NC43NjYxMDddICBkcG1fcnVuX2NhbGxiYWNrLmlzcmEu
MTkrMHgyNC8weDcwDQo+ID4gWyAgIDY0Ljc3MDYzNV0gIF9fZGV2aWNlX3N1c3BlbmQrMHhmNC8w
eDJmMA0KPiA+IFsgICA2NC43NzQ1NTNdICBkcG1fc3VzcGVuZCsweGVjLzB4MWUwDQo+ID4gWyAg
IDY0Ljc3ODAzNl0gIGRwbV9zdXNwZW5kX3N0YXJ0KzB4ODAvMHhhMA0KPiA+IFsgICA2NC43ODE5
NTddICBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyKzB4MTE4LzB4NGYwDQo+ID4gWyAgIDY0Ljc4
Njc0M10gIHBtX3N1c3BlbmQrMHgxZTAvMHgyNjANCj4gPiBbICAgNjQuNzkwMjI3XSAgc3RhdGVf
c3RvcmUrMHg4Yy8weDExOA0KPiA+IFsgICA2NC43OTM3MTJdICBrb2JqX2F0dHJfc3RvcmUrMHgx
OC8weDMwDQo+ID4gWyAgIDY0Ljc5NzQ1OV0gIHN5c2ZzX2tmX3dyaXRlKzB4NDAvMHg1OA0KPiA+
IFsgICA2NC44MDExMThdICBrZXJuZnNfZm9wX3dyaXRlKzB4MTQ4LzB4MjQwDQo+ID4gWyAgIDY0
LjgwNTEyNl0gIHZmc193cml0ZSsweGMwLzB4MjMwDQo+ID4gWyAgIDY0LjgwODQzNl0gIGtzeXNf
d3JpdGUrMHg2Yy8weDEwMA0KPiA+IFsgICA2NC44MTE4MzNdICBfX2FybTY0X3N5c193cml0ZSsw
eDFjLzB4MjgNCj4gPiBbICAgNjQuODE1NzUzXSAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjMr
MHg2OC8weDE3MA0KPiA+IFsgICA2NC44MjA1NDFdICBkb19lbDBfc3ZjKzB4MjQvMHg5MA0KPiA+
IFsgICA2NC44MjM4NTNdICBlbDBfc3luY19oYW5kbGVyKzB4MTE4LzB4MTY4DQo+ID4gWyAgIDY0
LjgyNzg1OF0gIGVsMF9zeW5jKzB4MTU4LzB4MTgwDQo+ID4NCj4gPiBUaGlzIGlzIGJlY2F1c2Ug
c2luY2UgdGhpcyBjb21taXQsIHRoZSBkcml2ZXJzIHByaXZhdGUgZGF0YSBwb2ludCB0bw0KPiA+
ICJkc3BpIiBpbnN0ZWFkIG9mICJjdGxyIiwgdGhlIGNvZGVzIGluIHN1c3BlbmQgYW5kIHJlc3Vt
ZSBmdW5jIHdlcmUNCj4gPiBub3QgbW9kaWZpZWQgY29ycmVzcG9uZGx5Lg0KPiA+DQo+ID4gRml4
ZXM6IDUzMGI1YWZmYzY3NSAoInNwaTogZnNsLWRzcGk6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBy
ZW1vdmUNCj4gPiBwYXRoIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFvIFFpYW5nIDxxaWFuZy56
aGFvQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBQbGVhc2UgdXBkYXRlIHlvdXIgdHJlZS4NCj4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGZ2l0aHViLmMNCj4gb20lMkZ0b3J2YWxkcyUyRmxpbnV4JTJGY29tbWl0JTJGNmUz
ODM3NjY4ZTAwZmI5MTRhYzJiNDMxNThlZjUxYjANCj4gMjdlYzM4NWMmYW1wO2RhdGE9MDQlN0Mw
MSU3Q3FpYW5nLnpoYW8lNDBueHAuY29tJTdDNTAxNzFiZjY1YTVlDQo+IDRmMjRlMGMyMDhkODdi
ZmEzZmU5JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2
MzczOTU2NjIwMjM4MzUwNDglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpB
DQo+IHdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzEwMDAmYW1wO3NkYQ0KPiB0YT1ObG1PajFTZnZLdTJWN25yU1lGM2xEamkyNXhiUDVQZURsMVBj
d2xLeXI0JTNEJmFtcDtyZXNlcnZlZD0wDQoNCkkgc2F3IHRoZSBwYXRjaCwgaXQganVzdCBmaXgg
dGhlIGlzc3VlIHdoZW4gdGhlIGtlcm5lbCBhcmUgYm9vdGVkIHVwLg0KQnV0IHRoZXJlIHN0aWxs
IGhhdmUgdGhlIGlzc3VlIHdoZW4gdGhlIGRyaXZlciBzdXNwZW5kIGFuZCByZXN1bWUuIA0KDQpC
ZXN0IFJlZ2FyZHMNClFpYW5nIFpoYW8NCg==
