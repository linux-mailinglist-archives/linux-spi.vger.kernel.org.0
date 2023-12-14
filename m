Return-Path: <linux-spi+bounces-271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0088125C9
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 04:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F781C208BE
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147B393;
	Thu, 14 Dec 2023 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EqtANRqH"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB29B0
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 19:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYkDxOlf2M+af2awjo9U/jUYuQkQHYwCfa8gBCuhul5j1mPfBOQbW9TJAma1yTBPr6zcmVWs7DgdKerQ4TQOO7WHg5dUsJI6uIghXJZ4tmMQh5g2/2MouCE6ImxrpzML7G3EfvTSBI1+IQxk22i1GPj+sSW1gbTvajgsgajocuXOzD2bg/d3/uaC8Pql3uX7AvIKzmuiKPIdkApg+yb8Oj9Hu/7c0h4479FkYcEf96VCn8ldIFH9B9glNzPt6esJKfBfEpl4QregFtsS/ez2fAbMEyU/yE/o57Jw+qL+SEZdL78I6xRny63nQKnEIzusImQhjmONWx61kxN0HVXfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF/5FY2KGpt2Df4zFRDCp1+dd/IZPoSWPqsd/AWLXN8=;
 b=U0CYe3Qq4+toWN/qUAcHxZchYIT0YmFKgcAIGTrX5VmUxKRszbD+xELzCIWJDtYwQb4KsF5VTgyCVO4NKJEosCBWIIhKw/NxArfwDXgEXASu046gmacp9FYm1R3nafBbBxVcKe4X8PDxh/F7xy5U9NXZcaUdPc7/5iHr3394vQb9GxdSHoWYWVw6Vcfn/Ioe0U5DFWf5IimSO9G8+dWh+84lovira++8xx7NDDQ/L76jBW1lIOxef/3YIPKsWeJU39fR6xpu5wwoF7UYYyYbWJcDZnPBnw6AODkT2FSiiOTMclglxpxfHKazwWLlTQChvqvsTcQhwvncBqsiPJEAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF/5FY2KGpt2Df4zFRDCp1+dd/IZPoSWPqsd/AWLXN8=;
 b=EqtANRqHL+ztKQdPiaKS9MLPTLpiulgl1nvljc5/gaqFYX3tj2yyAJqqSz7gm70u11tpvva/b+9ZcXO7SKT/LQSxyDFWKJSAMy2wLrjwHLOSSp4cGqJ/eoFhlwBJ+9wNMnwF40iz1Qf1JPQr1N/5ND6+bMGVok9F49f0TNTW/Vo=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB6862.eurprd04.prod.outlook.com (2603:10a6:803:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 03:09:43 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:09:42 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Michael Walle <mwalle@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>
Subject: RE: [PATCH 3/5] spi: spi-nxp-fspi: add DTR mode support
Thread-Topic: [PATCH 3/5] spi: spi-nxp-fspi: add DTR mode support
Thread-Index: AQHaLaP3NtHy5qaQzEugEeXaNpKryLCnbmaAgACb3dA=
Date: Thu, 14 Dec 2023 03:09:42 +0000
Message-ID:
 <DB7PR04MB4010647E3087EBF90E8BA7B1908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231213091346.956789-3-haibo.chen@nxp.com>
 <20231213165305.2773796-1-mwalle@kernel.org>
In-Reply-To: <20231213165305.2773796-1-mwalle@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|VI1PR04MB6862:EE_
x-ms-office365-filtering-correlation-id: 57339b6a-da3c-4ebc-e9a3-08dbfc521e3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BrQFiPd6FKPpKkg/4/HuhVmwGWjf69hjgxLE2ZAImcnb6ij2EKaMSOev1dqxGk8Xx707500BJ5vkqfzGK9aagIw3XkdA306FJC3VZ3NttrBf4T/ymLOGqnrvP/Dg1e3D3l9iG10kBnhg9a933fL525AwCpEYX2fPvycylh6BXnLb9YDIC9G+x4C6CTDKyCpYygptHNWQUYQomEdwapdTrCziwr0HGH1hffjPbExOwYBS78Kx1D3E6Gy0Uui0Aois8jH9R2jw7B2u/os2XiRHfUhrABmgE5GokNx/Zqad5Tcz7VPY8R01vkctSKMrOqGW1hnSPNioSLUpPV1fAitfMfLDmGmd3bpTYjC8hueoetUe6N0hT/oF9vGdr2leLdSmRgcQbvIeyE7IyjCQG51lLFogATgaqajCPyTb4M+nLkEzaBwlxejkLcnj693yT6XUDK4SjeTEmyZ8ek6ZtRQrvqBXld8/Gzd4FVH0Nu2KZa7s+x5DaSEG5uvPiH5Tja1xV49FrFzVbVT05EottaikBtkv/oYl6Qlrwl7msuYL7zYU/aVRPkgpv6oCQL3x6l+WxcHS45ZJWopjNkftiIi5qHSGT9su8uO6c5Ft18v5GP8WOC8hNlZXB53wvqtl0OJT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38070700009)(55016003)(66556008)(76116006)(66946007)(66476007)(38100700002)(122000001)(66446008)(33656002)(86362001)(26005)(83380400001)(9686003)(6506007)(7696005)(53546011)(2906002)(6916009)(316002)(64756008)(54906003)(71200400001)(478600001)(4326008)(5660300002)(8936002)(8676002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?amZrYitNRjZ1S2xiTkJTcCs1eTRCbmVycW5EQW9WbTFFVGo5L2VGUGNCZFJt?=
 =?gb2312?B?TWo0eWN6Y0t4dUZ1S0FJSkJTczRWN05PV1VwT21mZXpyczRwS1MyLzNpZ29a?=
 =?gb2312?B?MTZ1RWFjSHF1M3NPTnBTR1dXN3RQcCtSVGlWVmhBVWJCSVpPcTBHWVNyQjFh?=
 =?gb2312?B?N2k2YmdqZWNYRnVnL004SWRoN1BOVzM5NmZRR1FTeEhjMXdwai9GbU8xZFRL?=
 =?gb2312?B?K2hJUEhWZWh5M0RaSkMrdWxKRE9RdllkVTNtSUNpelV2Sjkzbmo4WEM3a0RU?=
 =?gb2312?B?WFVVOVNnV3lZRXpSTkNYdlJxZW9paVpmLzRPS2dIWG1vKytIdzZHcFZ2VXI5?=
 =?gb2312?B?QkFsalRqNE1tbXRlaVVLaUFoOXlWVTM2Uk91b2xZeCthWVJReGovcm5MOUpW?=
 =?gb2312?B?SFpOeC9SUXJIQjQwMjlVT1JkZ3BWa0FqeS9DM3hvNTVlaEk4cm1kTi9ld1NZ?=
 =?gb2312?B?S2FIQ0pVWC9mZDBHMnljVHFTRHhyS1FmZzMwYXd0NjE3ZFlRTXMxaGRwMUhL?=
 =?gb2312?B?cHlUZlNOSlJhUzFWV1ZqVFR3OVZpR1VudDhpTXROVDR2Uk80czEzeHh0aXU1?=
 =?gb2312?B?N2hQbTdqdEphQkhlMDFyZ0lncFczYmFLZFZLTURaQXhnd0YvZ1FXUm51ZHc4?=
 =?gb2312?B?RUVBbk5CcVRoQnR5UUdXUmRDNmk1ODkzaFVuWW9ocHRIMUZvQ3ZhVDhmblBM?=
 =?gb2312?B?MU0vZlZRZnZWOXJRZDN0YlZMRVZaM1U5a3pLY1BWSWNCdEcvQkwzVktoLzZS?=
 =?gb2312?B?TUNmZ0w2aWlHSTNHWlVicm5tUFUrTTVtdjN3NEVxQlpuVmxpNXM0RThPc05w?=
 =?gb2312?B?SUlqWEZKSzA0dElpTnZjRU1aZytNVnlWM21VZFF2cWhFdUVNOEFjR3EwQ05o?=
 =?gb2312?B?K1p1ajExdWZGVjF2aVNmQ3hEUVF2V3huVkRidjM5c3FPL0VSV1FZcVdYMEtK?=
 =?gb2312?B?UkFob09neTdjTG9tNmJtTXZJVDN2TmhWeE5UMTlrWXQ1ZjFSY0w0TzFDTTNy?=
 =?gb2312?B?bm9WdUYyMXRvZG9NZDF1VWRNWVdQTSt1eVNMeERMM2ZMbDh3WkdUNmNIWUtY?=
 =?gb2312?B?YWNXaFhVZHRzak1iTEZjNWJWV0sxN2xKN2dMTFRmTnJMQ3B6NytvOVdpOXMw?=
 =?gb2312?B?VVJ0T3RHdTJLNWloU25PUGl6clV3Zis4OGJkTkRYdWZ0czR6MUtNRmVYdGxk?=
 =?gb2312?B?S0haSU5CditYakQxVHR1WWY4RWF0TXpHRnFoV3BYcU5aemMwbW9odFB6YWRO?=
 =?gb2312?B?MERVc2JRdmlEa3JQTVJqaW95WTBFQy9qeU50K0dudzFWRG9nSWRMY0U0WVp4?=
 =?gb2312?B?RGh1V0U3U2dnQlQwUnJYWGsvQmdrc1BWWnR3alhpQVpjUjlvT1JkNHhDYkww?=
 =?gb2312?B?dHlxWmJ5dFc4R2Z0eGVFQW1FSGUyQTAxZkZDcW0wczlrTVNuRlprbFhGb3Rp?=
 =?gb2312?B?UEpsMXRiOFZycmdhdDJVOGgvdHJQU00rTTNXekQ1cHRaQ3Q0VkRmRlU4UFJG?=
 =?gb2312?B?RkFBQjlGWEo4bEk5eWdCbXliUERNZXRaYXM4ZGtBbDhDbnBMNGwzM3RjbnRk?=
 =?gb2312?B?MEpYbTMwaGdKQUF2U0FhS05haGg1Ukp0YU1OaExSc000Ry9WdUtFeWhhamdj?=
 =?gb2312?B?L0ZaM0tsSDdYYm5rM2tqdTVLcHlPbjNZSU1RdmNOK0hka2xXZThzWEdCdThv?=
 =?gb2312?B?bXVTZ3V3Z1pmbVplZDBRUFNrcHIwZkFLVnVsenpTRXFsREY3RmRWLysxcHVt?=
 =?gb2312?B?blZVTFNrTUljeWNUcGlKbFVNeURPYU8yWHRjUXpjNGkvZTdXQ3RiSlQ3SGhq?=
 =?gb2312?B?Vlp5NUozR1RWWGhFU01lVkJnd0lNc1d6c3J1STlvUVB5My8zTWpIcCtubVdS?=
 =?gb2312?B?bkkwNjBHNkdzekZPaHEreWNvdk1Mb0VPYXN4ZFZZaUdpRWtyU1NmQkl0cEtX?=
 =?gb2312?B?UXpib1BBUFF6bkFKOW5LYStsWGdEVlFRVUFlOXVybnpKeDB4V3FvdnFrdC9i?=
 =?gb2312?B?YXErd0oxaEZRa0ErUG1tZDNISEVjaGdqOURTV0xXTm5VVS9qMHVSQiswNkJk?=
 =?gb2312?B?ZTdkOVFSUlRsTVltcWdVeElyb25MTWlCN3I4SGRweDhMclc4NGpJLzdGWnZp?=
 =?gb2312?Q?D6AZe0I0VmoaKdknS41etfTv2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57339b6a-da3c-4ebc-e9a3-08dbfc521e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 03:09:42.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmXcFWsP9x4HWLOVWD4+/sPR5UXPeet3jbtM99Ut5h4icsxTU+mD+pO2bzpiZUY7UyseZGEUIcLEc1ictGo7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6862

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFdhbGxlIDxtd2Fs
bGVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqMTLUwjE0yNUgMDo1Mw0KPiBUbzogQm91Z2gg
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBIYW4g
WHUgPGhhbi54dUBueHAuY29tPjsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IHlvZ2VzaGdhdXIuODNAZ21haWwuY29tOw0KPiBN
aWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAz
LzVdIHNwaTogc3BpLW54cC1mc3BpOiBhZGQgRFRSIG1vZGUgc3VwcG9ydA0KPiANCj4gPiBGcm9t
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBGb3IgTFVULCBhZGQg
RFRSIGNvbW1hbmQgc3VwcG9ydC4NCj4gDQo+IFBsZWFzZSBlbGFib3JhdGUgYSBiaXQgbW9yZS4N
Cg0KT2theS4NCg0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyB8
IDI3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+ID4g
aW5kZXggOWQ2YjRkMjIyNjNjLi4yNTYyZDUyNDE0OWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zcGkvc3BpLW54cC1mc3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGku
Yw0KPiA+IEBAIC01NTIsMTIgKzU1MiwyMiBAQCBzdGF0aWMgdm9pZCBueHBfZnNwaV9wcmVwYXJl
X2x1dChzdHJ1Y3QgbnhwX2ZzcGkgKmYsDQo+ID4gIAlpbnQgbHV0aWR4ID0gMSwgaTsNCj4gPg0K
PiA+ICAJLyogY21kICovDQo+ID4gLQlsdXR2YWxbMF0gfD0gTFVUX0RFRigwLCBMVVRfQ01ELCBM
VVRfUEFEKG9wLT5jbWQuYnVzd2lkdGgpLA0KPiA+IC0JCQkgICAgIG9wLT5jbWQub3Bjb2RlKTsN
Cj4gPiArCWlmIChvcC0+Y21kLmR0cikgew0KPiA+ICsJCWx1dHZhbFswXSB8PSBMVVRfREVGKDAs
IExVVF9DTURfRERSLA0KPiBMVVRfUEFEKG9wLT5jbWQuYnVzd2lkdGgpLA0KPiA+ICsJCQkJICAg
ICBvcC0+Y21kLm9wY29kZSA+PiA4KTsNCj4gDQo+IFNob3VsZG4ndCB3ZSBjaGVjayBjbWQubmJ5
dGVzIGhlcmU/IFlvdSBzZWVtIHRvIG1peCBkdHIgd2l0aCBjbWQubmJ5dGVzID09DQo+IDIgaGVy
ZS4NCg0KQ3VycmVudGx5LCBmb3IgRFRSIG1vZGUsIGFsbCBjbWQubmJ5dGVzID09IDIuIFJlZmVy
IHRvIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIDogc3BpX25vcl9zcGltZW1fc2V0dXBfb3Ao
KQ0KQnV0IGJldHRlciB0byBjaGVjayB0aGUgY21kLm5ieXRlcyBoZXJlIHRvIG1ha2UgdGhlIGNv
ZGUgbW9yZSBzdHJvbmcuDQoNCj4gDQo+ID4gKwkJbHV0dmFsW2x1dGlkeCAvIDJdIHw9IExVVF9E
RUYobHV0aWR4LCBMVVRfQ01EX0REUiwNCj4gPiArCQkJCQkgICAgICBMVVRfUEFEKG9wLT5jbWQu
YnVzd2lkdGgpLA0KPiA+ICsJCQkJCSAgICAgIG9wLT5jbWQub3Bjb2RlICYgMHgwMGZmKTsNCj4g
DQo+IEFuZCB5b3Ugc2VlbSB0byBhc3N1bWUgZHRyIGlzIGFsd2F5cyBvY3RhbCBtb2RlPw0KDQpD
dXJyZW50bHksIEkgb25seSB0ZXN0IHRoZSBvY3RhIGR0ciBtb2RlKDhELThELThEKS4gYnV0IGhl
cmUsIHdlIGNvbmZpZyB0aGUgb3AtPmNtZC5idXN3aWR0aCwgb3AtPmFkZHIuYnVzd2lkdGgsIG9w
LT5kdW1teS5idXN3aWR0aCwgb3AtPmRhdGEuYnVzd2lkdGguDQpTbyBJIHRoaW5rIGN1cnJlbnQg
TFVUIGNvbmZpZyBjYW4gY292ZXIgb3RoZXIgZHRzIG1vZGUsIGxpa2UgMUQtOEQtOEQsIDFELTRE
LTRELCAxRC0yRC0yRCwgMUQtMUQtMUQNCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0K
PiAtbWljaGFlbA0KPiANCj4gPiArCQlsdXRpZHgrKzsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJ
bHV0dmFsWzBdIHw9IExVVF9ERUYoMCwgTFVUX0NNRCwgTFVUX1BBRChvcC0+Y21kLmJ1c3dpZHRo
KSwNCj4gPiArCQkJCSAgICAgb3AtPmNtZC5vcGNvZGUpOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAkv
KiBhZGRyIGJ5dGVzICovDQo+ID4gIAlpZiAob3AtPmFkZHIubmJ5dGVzKSB7DQo+ID4gLQkJbHV0
dmFsW2x1dGlkeCAvIDJdIHw9IExVVF9ERUYobHV0aWR4LCBMVVRfQUREUiwNCj4gPiArCQlsdXR2
YWxbbHV0aWR4IC8gMl0gfD0gTFVUX0RFRihsdXRpZHgsIG9wLT5hZGRyLmR0ciA/DQo+ID4gKwkJ
CQkJICAgICAgTFVUX0FERFJfRERSIDogTFVUX0FERFIsDQo+ID4gIAkJCQkJICAgICAgTFVUX1BB
RChvcC0+YWRkci5idXN3aWR0aCksDQo+ID4gIAkJCQkJICAgICAgb3AtPmFkZHIubmJ5dGVzICog
OCk7DQo+ID4gIAkJbHV0aWR4Kys7DQo+ID4gQEAgLTU2NSw3ICs1NzUsOCBAQCBzdGF0aWMgdm9p
ZCBueHBfZnNwaV9wcmVwYXJlX2x1dChzdHJ1Y3QgbnhwX2ZzcGkNCj4gPiAqZiwNCj4gPg0KPiA+
ICAJLyogZHVtbXkgYnl0ZXMsIGlmIG5lZWRlZCAqLw0KPiA+ICAJaWYgKG9wLT5kdW1teS5uYnl0
ZXMpIHsNCj4gPiAtCQlsdXR2YWxbbHV0aWR4IC8gMl0gfD0gTFVUX0RFRihsdXRpZHgsIExVVF9E
VU1NWSwNCj4gPiArCQlsdXR2YWxbbHV0aWR4IC8gMl0gfD0gTFVUX0RFRihsdXRpZHgsIG9wLT5k
dW1teS5kdHIgPw0KPiA+ICsJCQkJCSAgICAgIExVVF9EVU1NWV9ERFIgOiBMVVRfRFVNTVksDQo+
ID4gIAkJLyoNCj4gPiAgCQkgKiBEdWUgdG8gRmxleFNQSSBjb250cm9sbGVyIGxpbWl0YXRpb24g
bnVtYmVyIG9mIFBBRCBmb3IgZHVtbXkNCj4gPiAgCQkgKiBidXN3aWR0aCBuZWVkcyB0byBiZSBw
cm9ncmFtbWVkIGFzIGVxdWFsIHRvIGRhdGEgYnVzd2lkdGguDQo+ID4gQEAgLTU4MCw3ICs1OTEs
OCBAQCBzdGF0aWMgdm9pZCBueHBfZnNwaV9wcmVwYXJlX2x1dChzdHJ1Y3QgbnhwX2ZzcGkgKmYs
DQo+ID4gIAlpZiAob3AtPmRhdGEubmJ5dGVzKSB7DQo+ID4gIAkJbHV0dmFsW2x1dGlkeCAvIDJd
IHw9IExVVF9ERUYobHV0aWR4LA0KPiA+ICAJCQkJCSAgICAgIG9wLT5kYXRhLmRpciA9PSBTUElf
TUVNX0RBVEFfSU4gPw0KPiA+IC0JCQkJCSAgICAgIExVVF9OWFBfUkVBRCA6IExVVF9OWFBfV1JJ
VEUsDQo+ID4gKwkJCQkJICAgICAgKG9wLT5kYXRhLmR0ciA/IExVVF9SRUFEX0REUiA6DQo+IExV
VF9OWFBfUkVBRCkgOg0KPiA+ICsJCQkJCSAgICAgIChvcC0+ZGF0YS5kdHIgPyBMVVRfV1JJVEVf
RERSIDoNCj4gTFVUX05YUF9XUklURSksDQo+ID4gIAkJCQkJICAgICAgTFVUX1BBRChvcC0+ZGF0
YS5idXN3aWR0aCksDQo+ID4gIAkJCQkJICAgICAgMCk7DQo+ID4gIAkJbHV0aWR4Kys7DQo+ID4g
QEAgLTExNTIsNiArMTE2NCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9jb250cm9sbGVy
X21lbV9vcHMNCj4gbnhwX2ZzcGlfbWVtX29wcyA9IHsNCj4gPiAgCS5nZXRfbmFtZSA9IG54cF9m
c3BpX2dldF9uYW1lLA0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc3BpX2NvbnRy
b2xsZXJfbWVtX2NhcHMgbnhwX2ZzcGlfbWVtX2NhcHMgPSB7DQo+ID4gKwkuZHRyID0gdHJ1ZSwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgbnhwX2ZzcGlfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBzcGlfY29udHJvbGxlciAqY3Rs
cjsNCj4gPiBAQCAtMTI1NCw2ICsxMjcwLDcgQEAgc3RhdGljIGludCBueHBfZnNwaV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJY3Rsci0+YnVzX251bSA9IC0x
Ow0KPiA+ICAJY3Rsci0+bnVtX2NoaXBzZWxlY3QgPSBOWFBfRlNQSV9NQVhfQ0hJUFNFTEVDVDsN
Cj4gPiAgCWN0bHItPm1lbV9vcHMgPSAmbnhwX2ZzcGlfbWVtX29wczsNCj4gPiArCWN0bHItPm1l
bV9jYXBzID0gJm54cF9mc3BpX21lbV9jYXBzOw0KPiA+DQo+ID4gIAlueHBfZnNwaV9kZWZhdWx0
X3NldHVwKGYpOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCg==

