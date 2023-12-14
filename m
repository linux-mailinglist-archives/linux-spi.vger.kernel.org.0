Return-Path: <linux-spi+bounces-274-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B578129C4
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 08:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ACC1C208EA
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6491400D;
	Thu, 14 Dec 2023 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pG/h25N9"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2EEA7
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 23:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+gEm/+See3BuEoxeZGlDEPl1ZhRH1I/mzWIUW9KXZ0FJIQmXiJOBDiNpTPFEIIQzfGDSOg5hymD6/FbWnPgFJowtkRpFwNdsmsqN4GWnLWo6zMvYb2aL9FHefNFN51d/Dfd2lyx4RduXSo/cKIK2cRQbpmoza5pDi7nDHq+74Mw7Nujejjk0QA+U9gBq1bOV25oMlBoThVwDADxSab4cRj6iLD36YDhN1/mSsziTh/0AzPlMnbLg91x1yGAQ8LqCdZzWScSStVS1k8MshXBAefZj9Zon9FLA+IW1q2LcMLmWbKTJmhc7TGNAeJgaVR/O17FaexsAMzg/SrOGquy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWGC+zrDMyieK//tHfxdylaSZSTZW0kbdGDuUd9iA5s=;
 b=lSDLMBvAdlesm5ggV0RMKpYQP3nQQnaolqhzM7dm5W+bMPr6FPW9RFKESOYVLTbkdMyOeJBmsWjDvKAIP+W2SBxVwMQbas+Ncf8AQfVcRcvQnYDvnDh3NpUkciiAmwxrnHIdiYWPY87+IdIhjOKYh2PayyRmf5EdRR27MIarT8X5EhfoIy/VPtd1SP87iKP0l9UhBaKvBFMkHlOfYJyWfbC77PEyusfVmXQYi2nyXdIk3uaUQpd5qlAn0hp3taU0kF6kzHgEeSMZkckp3scl3uStBDVLapo8XwZlEDiat1vLVs1pIlCYOIUySoGkoSbAghMdXg0jl+DAKbZqDRD72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWGC+zrDMyieK//tHfxdylaSZSTZW0kbdGDuUd9iA5s=;
 b=pG/h25N9eFQl1oAUqQjS7MeGCd6HnXwD3xsaUmagk80W76krzaUYH1ZaNehPQiWtDCYuZ6C5O4I9Fsk88felAVPM9AD9Iw089bSBF+/Bv7m2SNgncO5cKFqjcC1o7FGysztZFTQkNRV3Qop6kh16pn6yVrUhVfs680pe2FlMPNg=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8728.eurprd04.prod.outlook.com (2603:10a6:10:2df::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 07:54:00 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:54:00 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Michael Walle <mwalle@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>
Subject: RE: [PATCH 4/5] spi: spi-nxp-fspi: add function to select sample
 clock source for flash reading
Thread-Topic: [PATCH 4/5] spi: spi-nxp-fspi: add function to select sample
 clock source for flash reading
Thread-Index: AQHaLaP5TjA9dDifrUKi5IJpXXW0D7CndkOAgADleFA=
Date: Thu, 14 Dec 2023 07:54:00 +0000
Message-ID:
 <DB7PR04MB4010E0C19722CBAA2FD668E5908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231213091346.956789-4-haibo.chen@nxp.com>
 <20231213172113.2774476-1-mwalle@kernel.org>
In-Reply-To: <20231213172113.2774476-1-mwalle@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8728:EE_
x-ms-office365-filtering-correlation-id: da70ce6e-b442-4829-8d88-08dbfc79d55c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rlk7u7k+ASDpeZtDdiUzdb43wDtUXTwOhEQxBFcsUW3dIwNSOjUdf+WXTR1ktFTOVVgARj4ywjc916vuMVMBB3msCsp0KTOfjgU/R1YOt6XDlotLf7iVjwr8Q3EpDlCvycQUVF89AkwOV7R7bCDWvLURHmAYDgujxqIEu7onKaiTjLwLP9wqC4N/ovWpcmOX8o1vSHsfMu21T+0CNaU/lf/HmIiL3tPzpZxazNfXC89OkF8YT0/Wdb7NqefAq9xPfUPlNCj/1ZAMyzp2EW/obMq+FHGa7GWypEyP3E4EkP1WPXDvMSoO+Cbb3uGFUPugadDHByizD84DSuHnhPelOD7aOrskco1G4kvDVbPheQc4jScon2Ptocy8UkwQlW45LjTXh2zV2rmxkhaf2TOvxH3DZIxWqSnBEOePXsCH5ivBA2c9yX3xrKtCH6UIVMtZeQjdSN8wjX9xGrsVBF3dzW1nN+0W0FBBwtSKDrrvXVPztqz+1xLoQgSj//MPi4dR2pA4zayLRfaK7nSfKa0hIBAr2Ua+Q1Yyffng1mhWWGkGmLsqWepE0wlj8GDbVmjKy97Agqvlc0YjX6jvYPwbNpFxtFq36DT0+T3lK4FOc6VNjNP1jIZKIvCJSlE3K0Nl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(71200400001)(478600001)(55016003)(122000001)(38100700002)(26005)(83380400001)(6506007)(7696005)(9686003)(53546011)(2906002)(8676002)(33656002)(41300700001)(8936002)(4326008)(38070700009)(5660300002)(86362001)(52536014)(64756008)(54906003)(6916009)(316002)(66446008)(66556008)(66946007)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZWYyNzNONWJQYmlxUjAySGZWSkdJWG45ZCtzaGZEV2QrT1dlTVBmZ1gxK1Ez?=
 =?gb2312?B?N2VDSU94UFZIcUlqNHpNaUdzUVBuTnpVSGx5d1lnS25iMjVLQUl0OEdGdWlz?=
 =?gb2312?B?NmxzNmlueC9IT21WRlpmaHBlMERJQ1RkcDUxbU90Kzc1SHVkckZwdVNadDZu?=
 =?gb2312?B?Q3pWMlpCUzM5U2NMOVJNOTQxSjdXL284SXF1ZkV2cW5SSFFpYjdwekRiRHQ1?=
 =?gb2312?B?dGNHQ2FDb0NVZjJOakd2KzZsSU43QlFxSmN1ZHFVSTR5TnJkd2htbk1tZCtj?=
 =?gb2312?B?YjdwWldZYXBsUTNNeEU4TnhWallRWjhEVGJJaUxUb2FaY2lPczk5SHhVaU9X?=
 =?gb2312?B?dEYvbXZaSzc5MzdtcUY1M051T1ViTDhIcWVHY3cybGx5ZFZMNzZjMDFnc1hr?=
 =?gb2312?B?U2ovWjQ0TE1qOHovK2NKeDZ6MUlyWmRrQm1ScWFIeFBBTmZlMXgwVGgwUDNF?=
 =?gb2312?B?ZXhoZDJqS2N6eVdHZFJWRi9sKysvTVpERXJEOFp2ZG0wS0g1bmZqM0FONWNk?=
 =?gb2312?B?bjN0TUxGR0swRUFudTJGbms5dXB2SnBvWHQ4ZTFVQ25aUStDb0pIZTdJaDhz?=
 =?gb2312?B?WTZ5UDR4ZlAvcnVlTTZDRy9Ld3UrZC9SVmpuVEZrSVFEbGRhVHlRQ2ViZXNv?=
 =?gb2312?B?MDVEa29oTXRWdU1mbm5LcjV3d2pKa0l6RkdMeDA4cTNJVGxId1NNVkxiL25z?=
 =?gb2312?B?MTlUdkEwQm9FM2JLMTh1a0lzOTNpWmM5RVhSd0FFOVhOYjkvczk3eWhNNkVs?=
 =?gb2312?B?L2RFd2FXMmdJeGFwOXk0RlovRERDemV5S08waFJyeUFkWjJWcngvUTFsSnh1?=
 =?gb2312?B?Ri84Q0VoQUc3SDRsVkNNM2xKSnVBdmw3cXRtSHZXNUVYK1htWEt1VEx3Vi84?=
 =?gb2312?B?YVhxclhpTWNQbUhnWHppR2YxUXV6NU5JTkh2eFdYMWd2eEg0czZyaWNiYUoy?=
 =?gb2312?B?aytDb0pQZnErZ2xvTHYrRExObXYrdGhQVlJiSkYxZ3g5NnR1dGdKUmRLUGJB?=
 =?gb2312?B?YWUzU1V1MHVpQW1nR3NxR0NjOWx3dm93SjI0Qjg0eVpMQXNzTDViaFRacGk5?=
 =?gb2312?B?c0hhY3RFTWdlUDN3OURKcSsyOEVtd0JFd2dRQUxxL1BqcDBpMWNjTUUvY2wy?=
 =?gb2312?B?b3Nsd3lrcWtDN3h6NWdodHQrYkhnNHp4RzZMZThhc09JY1RZSGIwN043Z0RF?=
 =?gb2312?B?L0tyVDh1RXFDR0dnUTdsUmw3N0xxTTl4OVhqZEtJc3VjWUR6UWx1L2pZYTgv?=
 =?gb2312?B?NlI2NlErUWMzSm5pOS9PQ216SGZuZDdVdGp1OG54NkZ5TjBmZ1dyZ2twWjVr?=
 =?gb2312?B?Szd5VEE3MzhzRkpqTEhGajRyL3RBajdXNjl0N0NKWGJWRCtsQktjNDNuVGl4?=
 =?gb2312?B?Z3JtMmpoNXlrYXFpSm8xSy9iNnhIeksvOWpaVVcxQkZCQ0lGUDVkbm5Yc1Er?=
 =?gb2312?B?SlJtS09qaS9oem56ZE5yV1hoaTdSZ1IxZ3BUd2pnbXBKb01DZVBZNFd2VkdH?=
 =?gb2312?B?Z0pJUTJiNnUvNi9wcHR2dnJTNHJwTThadDgya1B4eGRtcEdCQ084WEtXSUZT?=
 =?gb2312?B?WHJ3dDdIRE4yZk5qMGZMTDZubmRjRkI0Q2luc2ZBWWExNk9qMkFLckNMMXBm?=
 =?gb2312?B?c1FKKzFFYm1VMkNmV1lwRGJnS0dDZ0RIYkE1QWVmcUhGdi9WQi9aT2REaGxQ?=
 =?gb2312?B?bGZqL3ludzBnUUZqMWcvZ21qQkdHS2s2V2ZzMnFEQmdpdDdiek94aWtpcTho?=
 =?gb2312?B?Z2UxemFqNGRWVEJraSt2MktJU2VNRE42U1FxY2pxdFFjRUs5alN0R0lYZmkv?=
 =?gb2312?B?UlVudWladlJjTzhvSGliYVZsR2JaVDZWVWg1TDFObytqbFc4aXJJV21ZMTdl?=
 =?gb2312?B?bGhQQWtXR1VkNllwSjZVVkg2R1VWb09aYjNQQ0dSR1AyS3gxUGRFMkkxc3dV?=
 =?gb2312?B?K0k3MEVvb1F3bWhIU25iR2pKQzJRcHhQb3dUNjBWWElZdk04anZCZ01wMHo1?=
 =?gb2312?B?MUgzZUl6U2laUkViTElZbFNRMGxOV01SUkc5NDNBcm1XZTJpWVFEd1pqWHN4?=
 =?gb2312?B?akZXNWxZaEhFWm90VEJLNkdGam9sS0NJRWNvN3NMVXV2VXdWcWVBM0doYloz?=
 =?gb2312?Q?bc5s=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da70ce6e-b442-4829-8d88-08dbfc79d55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 07:54:00.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pPu1NhEdXntxmsf3+IWjTPfebXJdndp28yJgXq47+zX9W28kdSifAY76rmrdSifTkbt1TsmnscLe89np1jZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFdhbGxlIDxtd2Fs
bGVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqMTLUwjE0yNUgMToyMQ0KPiBUbzogQm91Z2gg
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBIYW4g
WHUgPGhhbi54dUBueHAuY29tPjsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IHlvZ2VzaGdhdXIuODNAZ21haWwuY29tOw0KPiBN
aWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LzVdIHNwaTogc3BpLW54cC1mc3BpOiBhZGQgZnVuY3Rpb24gdG8gc2VsZWN0IHNhbXBsZSBjbG9j
aw0KPiBzb3VyY2UgZm9yIGZsYXNoIHJlYWRpbmcNCj4gDQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gZnNwaSBkZWZpbmUgZm91ciBtb2RlIGZvciBz
YW1wbGUgY2xvY2sgc291cmNlIHNlbGVjdGlvbi4NCj4gPg0KPiA+IEhlcmUgaXMgdGhlIGxpc3Qg
b2YgbW9kZXM6DQo+ID4gbW9kZSAwOiBEdW1teSBSZWFkIHN0cm9iZSBnZW5lcmF0ZWQgYnkgRmxl
eFNQSSBDb250cm9sbGVyIGFuZCBsb29wYmFjaw0KPiA+IGludGVybmFsbHkgbW9kZSAxOiBEdW1t
eSBSZWFkIHN0cm9iZSBnZW5lcmF0ZWQgYnkgRmxleFNQSSBDb250cm9sbGVyDQo+ID4gYW5kIGxv
b3BiYWNrIGZyb20gRFFTIHBhZCBtb2RlIDI6IFJlc2VydmVkIG1vZGUgMzogRmxhc2ggcHJvdmlk
ZWQgUmVhZA0KPiA+IHN0cm9iZSBhbmQgaW5wdXQgZnJvbSBEUVMgcGFkDQo+ID4NCj4gPiBJbiBk
ZWZhdWx0LCBmc3BpIHVzZSBtb2RlIDAgYWZ0ZXIgcmVzZXQuDQo+ID4gRm9yIDgtOC04LURUUiBt
b2RlLCBuZWVkIHRvIHVzZSBtb2RlIDMsIG90aGVyd2lzZSA4LTgtOC1EVFIgcmVhZA0KPiA+IGFs
d2F5cyBnZXQgaW5jb3JyZWN0IGRhdGEuDQo+IA0KPiBJJ2Qgc2F5IHRoaXMgaXMgYm9hcmQgZGVw
ZW5kYW50LCByaWdodD8gSWYgeW91IG5vdyBoYXJkY29kZSA4ZDhkOGQgdG8gYWx3YXlzIHVzZQ0K
PiBtb2RlIDMuIEknbSBub3Qgc3VyZSBob3cgYSBib2FyZCB3aGljaCBkb2Vzbid0IGhhdmUgdGhl
IERRUyBjb25uZWN0ZWQgdG8gdGhlDQo+IGZsYXNoIGNhbiBjaGFuZ2UgdGhpcyB0byBhbm90aGVy
IG1vZGUgYWdhaW4uIExvb2tzIGxpa2Ugd2UnZCBuZWVkIGEgKERUKQ0KPiBwcm9wZXJ0eSB3aGlj
aCB0ZWxscyB5b3UgaWYgdGhlcmUgaXMgYWN0dWFsbHkgYSBEUVMgbGluZSBjb25uZWN0ZWQgdG8g
dGhlIGZsYXNoLg0KDQpDdXJyZW50bHkgd2UgZGlzdGluZ3Vpc2ggdGhyb3VnaCBTb0MgY2hpcCwg
bm90IGJvYXJkLiBMaWtlIHBhdGNoNS4NCklmIFNvQyBjb250YWluIHRoZSBEUVMsIGJ1dCB0aGUg
Ym9hcmQgZG8gbm90IGNvbm5lY3QgaXQgdG8gZmxhc2ggZGV2aWNlLCB0aGVuIHRoaXMgaXMgYSBy
ZWFsIGlzc3VlLg0KQnV0IEkgdGhpbmsgaWYgdXNlciB1c2Ugb25lIG9jdGFsIGZsYXNoIGRldmlj
ZSB3aGljaCBzdXBwb3J0IGR0ciBtb2RlLCB0aGV5IHNob3VsZCBjb25uZWN0IHRoaXMgRFFTIHBh
ZCBpZiB3YW50IHRvIHdvcmsgaW4gRFRSIG1vZGUuDQpJZiBmb3JnZXQgdG8gY29ubmVjdCB0aGUg
RFFTIHBhZCwgdGhleSBjYW4gbGltaXQgdGhlIHR4L3J4IGJ1c3dpZHRoIHRvIDQgb3IgMSBpbiBk
dHMuDQoNCkFueXdheSwgYWRkIGEgRFQgcHJvcGVydHkgc2VlbXMgYmV0dGVyLiBEUVMgaXMgYSBt
dXN0IHJlcXVpcmVtZW50IGZvciBvY3RhbCBkdHIgbW9kZSwgaWYgZGV0ZWN0IG5vIERRUywgd2Ug
Y2FuIGFsc28gZGlzYWJsZSB0aGUgRFRSIG1vZGUgc3VwcG9ydC4NCldpbGwgYWRkIGluIG5leHQg
dmVyc2lvbi4NCg0KDQo+DQo+IEJ0dyB5b3UgZG9uJ3QgY2hlY2sgYnVzd2lkdGgsIHNvIHlvdSds
bCBlbmFibGUgdGhhdCBtb2RlIGZvciBhbnkgRFRSIG1vZGUuDQoNClNlZW1zIGN1cnJlbnQgc3Bp
LW5vciBjb2RlIG9ubHkgc3VwcG9ydCBvbmUgRFRSIG1vZGUsIHRoYXQgaXMgOGQtOGQtOGQuDQoN
CkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KDQo+IA0KPiAtbWljaGFlbA0K

