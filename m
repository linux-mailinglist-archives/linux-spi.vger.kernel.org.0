Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB93B8014
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhF3JhR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 05:37:17 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:44275
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233653AbhF3JhR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 05:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8DGD/P4BokSyX5HhoPrsv6AKASNAc/iWkEHcUjFzOQ0uoGqxzjcB7CkXICrDHQEuItpZvFYyIdk2fuYtIwFJXsWnILeAnewTJwydmbLt9MAn4kDapWC1A3ObGQRRcZgwkvSNxdg3zi0EtUxDEQgz6MvawqAmNAPE+/Fcr+slq4ztI+2MgdU9bc/Iefl52JMQx3DvLjwYd5XFVMfKYHBdwosF7AqHeYrqbT/eLTJntVYt+rtditBcTnk2ph9ihFFBLooAkJq/UOOQyxk4VkGNAoJP4ufHzjMemWsOtCiEFhOpVCiHMeQ2OYMP1umC5gJV9MOSPvtT0BiFZn9zv3yXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wOnXmPMgM4bU5bkq5TK9SI1LZ9JBZQ7qBUmi/SqFcM=;
 b=XucisfKdikjU1ZrSyuqax5wtv5hroe2fb42pojbFf1M1joW/fGNqbSPJwGH0rSODZl5Nf/q7aRGHtKd9qIAvXHJvlRayBj92Re4ziQA58/Kxg/20ktSMDX+RmxYzL1SknOxB8opbYaxznsCTwcy9ypNx6EWgjh2/r5LqCe8x96xUCCXb7KJmkjbarOknp7ACv6klhkgQPoYy+ALhdH1q4JXzDNyBquzJW2zdP12cblr3X3JWOS+hrkPS1rascc1cfF+476WKsVjH9NQFhssfUY9a8huTtCzgWeb3Bf8kdSG0GxKI4I9gkXvK1WLoNWiS3dXLrIKaC7r5D0XR1t6QrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wOnXmPMgM4bU5bkq5TK9SI1LZ9JBZQ7qBUmi/SqFcM=;
 b=HN0qDKpEixUAInF0f/XIydSu44xMiP87F8g/vSog2zrGOb29okfuSR9eLf8QuMA6On1sxE6q9yCxY9I+UCenhJDgU9s2CRqabTytPyMhXHqbOKO1/bvsBtoPalIVSEwKAN7QGhxCprPuWa8k0kchqCLGYVjrZ+q7DSuKK9rANpo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4492.eurprd04.prod.outlook.com (2603:10a6:5:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 30 Jun
 2021 09:34:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:34:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
CC:     Charles Stevens <charles.stevens@logicpd.com>
Subject: RE: ECSPI Slave on i.M8M Mini with DMA
Thread-Topic: ECSPI Slave on i.M8M Mini with DMA
Thread-Index: AQHXZGM6AZXfHWecRUW8TYFhtaKN76ssXXGw
Date:   Wed, 30 Jun 2021 09:34:45 +0000
Message-ID: <DB6PR0402MB27601D0F4FB77F0007EDF0E888019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <CAHCN7xJ_Cidr5EiBXNi11St9vLFmm=s=K6jdHGJrvCzeQQpqyQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJ_Cidr5EiBXNi11St9vLFmm=s=K6jdHGJrvCzeQQpqyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd641c82-173c-4ffb-615c-08d93baa4c5c
x-ms-traffictypediagnostic: DB7PR04MB4492:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4492CF00FD5A10CFF7102BCF88019@DB7PR04MB4492.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+Cn42sAOWahP0zElhhl4EzXplKuV9/06jOe1NgHcwQop3od0FdBGGWHnZDLotJNr/eFlhL4ylJWXHRDWy8KIkyxnLQYSx52WLtYSthU3lg1731XvRhP3fpbne9nmsoosV0k/ZBzt53Gxm90aO+cTPVOkroOsVAeH8ILpYUd/18Jw6k97sbE96CNULQvDsfNhK5eSjBUIZkGMA5hISYqBHz+5BWZK3L26srsFTyt8YlwaDIXHvfOnHAs5Gvf6yhDbuY0uT2i+utOekeBieUHPdYulMVT9YIxnKpShDEauxRxQkuXsj+S67JoWakUUICxoZxJkR9CGkGWBuOaBwL8Bb3P2T8t2DGWCklICC78T2EPY3SaFarixZ7aFORjL7dYx5C2EJqfjdouuzIqnMfyFPXTBJCiuDSyiQSicFbgkP3nqsG35uEpVrYKvkoocNyexH2ZfMYGWaieCeTMq9KGNQGEvQjv9LiJ60ZxrBQUGAeTQHlRmPHbvUjD8oJupYc4slnNY/44PRIvjugLGGMZjTEx/Si/IbX9LC8eUhLUK1Nda/jbKbcLub2LcENpK4LpFutpjC+K4Xfy+OPll6nO29spuzOrQkyyL4CAIJfTTs3REsogl3oqIE6C16+wZ/nKl2NQOO48ZPy9l9Ef4/J3Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(55016002)(71200400001)(316002)(76116006)(66946007)(83380400001)(52536014)(5660300002)(2906002)(4326008)(66556008)(64756008)(66446008)(66476007)(33656002)(6636002)(9686003)(478600001)(110136005)(186003)(7696005)(44832011)(122000001)(8676002)(38100700002)(8936002)(6506007)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGp5ekcwS0RVZEJuRW9oWnhYQ2xnTk9KTVVzRGZaWXZmMitMa0lISEtjUnhX?=
 =?utf-8?B?NXFWZjhSS3g3Qkx4WU14amx0QTk5d2kvUkhnTndsODVBWmIyU1lOMGFVVkM3?=
 =?utf-8?B?a01meVZrNUxYb1lVY3E5QjRTTXBnZC83elkxdU9LcGR4SEJEb25SMEJYYVJt?=
 =?utf-8?B?Q0QyWERoV3ZPSkVGTThWdFZkQThPNzZwUUZmNmhPR3lQZ0pWSXhNejVsRGRj?=
 =?utf-8?B?ZmJVaGNpS0xFVTY2MjFlckIxTU1Vb0R0VXdkRDFOZTZoVEYzQ3EySUFPemxI?=
 =?utf-8?B?aEQzSzVEMTNnbTJnQXlhQVNYOVQ0bEh0RGlpbjFqckdONURYVjEyZzlHV0FN?=
 =?utf-8?B?MGQzdTBvVEVWSlczUWZ6alkzdjZaUkRIYjlnZ2FlTkdnYXl3LzRNNHFtZnpX?=
 =?utf-8?B?Zkkxa0I1bC9pTDBybDdaZzM4azdtSWJzM09HbGNDb1lEQVI5NVQxVS9ONE1r?=
 =?utf-8?B?TnR3YVQzTzRXSVpBVVM3OWdRN0kyV1ZXZWRKM3FuWCtXdlg5dkxhK3FpTEw1?=
 =?utf-8?B?U3hBQlNvYlJZTDZqUzZnOUlnYmFBOXBkQUxUeGhERGxuQjNTVWhBZ0VCZEU5?=
 =?utf-8?B?MkVIdk0waWhWUzNmY3hQNjdJZ1BVWC8yaUlMSFFCeEsxVi9sN21zMUVQeUov?=
 =?utf-8?B?MGFCVVFTV1dNbjh4T1FEZFVETzd4Y0hraE1BWjhyV1FScGVObjdlWW5sRDZU?=
 =?utf-8?B?akFBc0JQeEF1T1dHWU41NEs0R2czRDJKSjJtYmJGV0Zvd0tTR0hxVGZTQjk4?=
 =?utf-8?B?VW02bVpHRDI0YXEyQjBTUTE3ZTdDaWhLSVpEWUVoS2Fuc29yY0I5VE5zZy9V?=
 =?utf-8?B?ZGVFcnNlTDJBa2ZDaTBkKzYxUEJsZjJZcitsSS9zbnozVHpOY2VoS2dxcHBv?=
 =?utf-8?B?Q0s0clJIQ1orMXFlc3EzMUU4eXdwaGwzbGJjQUZkMHozdzhsVVNPM0NraEdi?=
 =?utf-8?B?SEJDeldvdDJ5Rjl5Y2c3VkZOWFI1RUFYZGxuVDgrYWk4YklCc3ZrVWZQSU10?=
 =?utf-8?B?NW8rWHZWRjVyYTEyL0xIbmtNWktZMUR0b2ZjNHhEUzQwSDNKczRzdElxWm16?=
 =?utf-8?B?a3VnN3FmSVFmQ2F5ZUtyN3BwR1ZSNytHSGpSTmM4bDRXUE1NSlN4MllCV1Bs?=
 =?utf-8?B?RnpmZVNEU1BFUlNuQnVlak5FQXZ6T3BlaWlZS24vdWRWdkdEU1lKOUpMamRF?=
 =?utf-8?B?TGRiV2ZUS0doaXJkNXc3N2YyZEY3RVBxdjJta1EvcW9ldnIrUTZ6SjFzMVdB?=
 =?utf-8?B?bVhXSG5nRWhoRWo4aElPVzcxeDlaNVM0ditjeTd2b2FYSEE5azN2ZlJoZ1Br?=
 =?utf-8?B?c0lxTWpsbTk5UVBKcy9LVDZZMC9nb09TZnlnVWoxRWxZemVmQ29IY24vLzh5?=
 =?utf-8?B?b0FUZEd3UVZwWUZ3MXVpMUJGWnJEZ1BDNkszOEFmSko1dWJJZjhSQ3lTT0sz?=
 =?utf-8?B?aGVDaGNxSlZ6RTM0WFg2c0NVTzE4alc5OU42dWx0K2xUWjVMVjNhMm1HVzNN?=
 =?utf-8?B?YmlJU3dwdjdiRTM2RzVRbkZXVDZycTVxMTBzZG9jS2tidGZMc21HZm1vY0tE?=
 =?utf-8?B?bXJON0NtRGZ0UlZUN2VOS1ZSTnhmbHJRYURxa253UGJqb3NManM3bmlLUEhh?=
 =?utf-8?B?bk5yTlQrd1RHcUdCTTBLbzFZRDA1TmZvMXdibWYwNmVmYUhlSGZMYmtvNjZp?=
 =?utf-8?B?cFJkTlhVblA0WFJkVlFLbWdmMEJFaFBRWjJRdnNkTFUrWE9ldHJIUWRvc0dM?=
 =?utf-8?Q?95qB+Lnvlq8I8plC/CQiSJH72NX365w8exKpKDH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd641c82-173c-4ffb-615c-08d93baa4c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 09:34:45.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QywDLjaGApfgKD1hJnsdXTTXvEmQI5s9vNpbhvAhdMctExq0izzymXvOa1WRulYSFSraVzhzXf/RbKxy7t6OOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4492
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBTdWJqZWN0OiBFQ1NQSSBTbGF2ZSBvbiBpLk04TSBNaW5pIHdpdGggRE1BDQoNCkNsYXJrIG1h
eSBoZWxwIG9uIHRoaXMuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBUbyB0aGUgTlhQIHRl
YW0sDQo+IA0KPiBJIG5vdGljZWQgdGhlIHNwaS1pbXggZHJpdmVyIGhhcyBhIGZ1bmN0aW9uIGNh
bGxlZCBzcGlfaW14X2Nhbl9kbWEoKSB3aGljaA0KPiByZXR1cm5zIGZhbHNlIGlmIHRoZSBTUEkg
aXMgY29uZmlndXJlZCBhcyBhIHNsYXZlLCBzbyB0aGUgZG1hIGNhbm5vdCBiZSB1c2VkIGluDQo+
IHNsYXZlIG1vZGUuDQo+IA0KPiBTZWN0aW9uIDEwLjEuMi43ICJETUEiIG9mIHRoZSBUaGUgOE1N
IFJlZiBtYW51YWwsIFJldiAzLCBzaG93cyB0aGVyZSBhcmUgYQ0KPiBmZXcgY29uZGl0aW9ucyB0
aGF0IGNhbiB0cmlnZ2VyIHRoZSBETUEuICBPZiB0aGVtLCB0d28gYXJlIFJYRklGTyBkYXRhDQo+
IHJlcXVlc3QgYW5kIFJYRklGTyBmdWxsLiAgVGhlIGJsb2NrIGRpYWdyYW0gaW4gdGhhdCBzZWN0
aW9uIHNob3dzIGl0IGNhbg0KPiByZXRyaWV2ZSBkYXRhIHdpdGggRE1BDQo+IA0KPiBIb3dldmVy
LCBpbiBzZWN0aW9uIDEwLjEuNCAiQXBwbGljYXRpb25zIiBvZiB0aGUgc2FtZSBkb2N1bWVudCwg
aXQgc2hvd3MgdGhlDQo+IG9wdGlvbmFsIERNQSBjb25maWd1cmF0aW9ucyBhcmUgb25seSBpbiB0
aGUgU1BJIG1hc3RlciBjb25maWd1cmF0aW9uIGFuZCBub3QNCj4gdGhlIFNQSSBzbGF2ZSBjb25m
aWd1cmF0aW9uLg0KPiANCj4gVGhlIEVDU1BJeF9ETUFSRUcgZG9jdW1lbnRhdGlvbiAoc2VjdGlv
biAxMC4xLjUuNikgc3RhdGVzICJUaGUgRUNTUEkNCj4gc2VuZHMgb3V0IERNQSByZXF1ZXN0cyB3
aGVuIHRoZSBhcHByb3ByaWF0ZSBGSUZPIGNvbmRpdGlvbnMgYXJlIG1hdGNoZWQuIg0KPiBVbmZv
cnR1bmF0ZWx5IGl0IGRvZXNuJ3QgZXhwbGljaXRseSBzdGF0ZSB3aGV0aGVyIHRoYXQncyBvbmx5
IGZvciBtYXN0ZXIgb3INCj4gYXZhaWxhYmxlIGluIGVpdGhlciBtYXN0ZXIgb3Igc2xhdmUgbW9k
ZS4NCj4gDQo+IENhbiBzb21lb25lIHRlbGwgbWUgaWYgRE1BIGlzIGF2YWlsYWJsZSB3aGVuIFNQ
SSBpcyBjb25maWd1cmVkIGFzIGEgc2xhdmU/DQo+IA0KPiB0aGFuayB5b3UsDQo+IA0KPiBhZGFt
DQo=
