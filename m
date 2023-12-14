Return-Path: <linux-spi+bounces-272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F64812636
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 05:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9154DB20B12
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713817F0;
	Thu, 14 Dec 2023 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2U6YGu8"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D9D5
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 20:00:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7P4agvYC1OP85E/VS6HWompB5xMv6ThcUjgFLgft/JepDLVmyMWImibJ6AB9cfF/FuO+g6OF6wUYBdzWrckEN0hveXsR6fWpF43kMxoipygfmXGn36BJm2py6/WIcN3O9/h8avTpuY0TBIRDuwo0qJMWeQf602osaVT4P1RylbDs6ziMlN1y/eM2oFz6AP9UnDitDWtKI5OAsPagmU64i9oskFFgmlxHjR2ZpMbkUpF8lyibpY7qhLz16N+7vpeXTYMFLqiX1GmaTckDkSXTj4kTUVxNupadQoyTn072d36DKI1YgdtySUCHd/SA5lXgg5jObCDXFJZ5X+GDSrCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzXGWuqizXy1kc6Agv+q1eLO9CWmBxeN9sSBG1kTZMw=;
 b=aw3FKQ1JEapNDDp0DIpyWFLZJKKbyDehCs1N2pFDmHeaH4N6e8DXB1ob+9DG7+efPiy7UOAP60C+c4vhWpN6A894D5WiWZ9IEUWcwDvc53ErEmXai+R7MbZYM8c9jGpS3LfPO2PhFjHEFrw5Y1u4QyHDQyrDGMDQo9xO/6EQ3d6Qz7tQ70i6wB67gh7/K2bT4Q2vnUmhaT1KdlijY4pCYfF+njeW/fJ2hh79qurm63y7A0jWPWe72OsK5WwCOnLSagC1yQ/Gux3gXuZxYlOEJ9m6be06yEGPdf1yeUdREyILAmHKKHeb6b/lZ8xwn47zBh2fVaimsJXoH+fLndsCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzXGWuqizXy1kc6Agv+q1eLO9CWmBxeN9sSBG1kTZMw=;
 b=C2U6YGu8Zff3RlVoO5u12Kj6kqR6DJX+T+rL32lViBSnvt4tKjXYaMawGuriMzUfo4s1AWnpUHpTu3xm9UhfSuEs05yV/KagChvQA2LPCgW6ZBmd4YIOaXgqa4/qj6Tj+zhgoBGqLSl03m1q358uC8+ZfzK8M79UNZhrqDOYp6Y=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8094.eurprd04.prod.outlook.com (2603:10a6:102:1c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 04:00:38 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:00:38 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Adam Ford <aford173@gmail.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Han Xu
	<han.xu@nxp.com>
Subject: RE: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Thread-Topic: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Thread-Index: AQHaLaP2wzhi5TR1c06pjVU5onkOhbCoGSAAgAAPmxA=
Date: Thu, 14 Dec 2023 04:00:38 +0000
Message-ID:
 <DB7PR04MB4010656713DDDB2A9D056CCC908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231213091346.956789-1-haibo.chen@nxp.com>
 <20231213091346.956789-2-haibo.chen@nxp.com>
 <CAHCN7xJc+2fSCsU_Ff=8eUh9qtZku_rxTdvQxgXu9oced=b8Tw@mail.gmail.com>
In-Reply-To:
 <CAHCN7xJc+2fSCsU_Ff=8eUh9qtZku_rxTdvQxgXu9oced=b8Tw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8094:EE_
x-ms-office365-filtering-correlation-id: 68bd45c5-e35c-4688-5ac1-08dbfc593bc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lbQ/FT84IM8XkmxhAUhR725fujMOkX4eWsUeQuYapVnOA8ne27EU0fFA3hbbYGgFEgfL1cupQ2haYSli9j+lNCrPAQjQR1H8EnUTdPRfOuGIu/uKikMf+s3J2gSJAJnDxG9mXxtlBWrqtxyZ13pqcSH2sC+RqEfWRM/PFljrmeWHrAqBjJZQERNTtM3msAeGMEIq6bqSHOjENWzomhIQsO85MVyK3qUpsvqFyNSnQhSVKuKrtk2IsbgAGDVMD7zTmAybWFkfaMqWJ/XVp7OwPY9fsTn5lQM3F8sHN5P/nJSPip2LhB8N8h/Rs6w5/IArSqyuDVjmDFBBbARVV8xL9UWTGOspGkWmol5IfEeDsMhx6wke/LU/Ib7r4Nz1qpHXfEV+FmhfmbBZoTk3+dn0o0UzvHEN/OOAvNdd96PWWE4K7wl/M/nGasU2/9z5s4dIEcXJyEg50j5zg12l2aoaEd/p1VVUssMS2Pm62Ob5D24McKzzVSsGgJhJOS26KSi2V/s4qApg4qf9dKstx8vLweXSGm2DxQ+LqXTPLEhapZ1JT1/Tak64KkIF9oSe35XaI8FkzqxGlQO21xyFOjGuJEC+vLvwA91d9PCXam9bItQ9oivYVB0C12lWXCU3ADjR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(9686003)(7696005)(6506007)(53546011)(83380400001)(26005)(52536014)(86362001)(41300700001)(4326008)(8676002)(8936002)(2906002)(33656002)(5660300002)(38070700009)(76116006)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(478600001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEVPbDJtWnFyQ2p0YTF5R3M0QmJTcFNxRXA0a0tMWUxaSDQ2OVRJaE12ZlVK?=
 =?utf-8?B?djA5dksrMWxmMzVXenZnQWVMRm42dEFoK3NRaEFpQW11OEhDVG5Uem5odytB?=
 =?utf-8?B?TDNQOHpJaVYrSEpmWWljNzNCbDl1OFd2ajZLK0pkTzJWQUdVSTdvdTRqNVRN?=
 =?utf-8?B?SU9uUW91c0l2cHV1eEFOTDgyWlpHWEVCbDZiV3lzWk5NS0REUjhJRDM2RFB5?=
 =?utf-8?B?ZnRLbFowNW5KenI4SXljTWZBd2NXb1BEa3JKSXhlWXp4dXR0aU9tNW9abTV6?=
 =?utf-8?B?cmI5c0JDdUpxNXRBbXhLNFlqd2IyMi9iRURESEZRQTlSNDZJaUxpTTYzV3Nt?=
 =?utf-8?B?L2hEeldpOGlNSGloQ0RTS2ZOTEhXK2ZUQ3lPc1EyRjZmZ0VrUWFNN0V0ZHY0?=
 =?utf-8?B?UG4zalBSQ1phYXJrTkl6aHV3QzlsM2NsVmZ5dkw2dHFxTmcraW9mTTNPeDBx?=
 =?utf-8?B?Tk5sMElwMHdqRlF0ODQxc2RDcS8rTEorTStaSVpWV3BIWlNkQ3oxaElVeEdQ?=
 =?utf-8?B?Q3I4ckJ5aHFEcXYxRlg2cS9ZN1lXN2dwcXBpcTRNTlR2R09IU1RiR3ozdjZF?=
 =?utf-8?B?VTVWNVRnWEVlQ0VkNUNkeEZienREa0RCMVN2TkZEYUtkYkJxenF4QTJxVjcy?=
 =?utf-8?B?S0Q2d3I4RWNObi85Z2lLclJnMEJ1b1VNV21LMkhVa01NUi9sZG1XRE5FVHh1?=
 =?utf-8?B?U1ZsbFhnczJNbDF3aEswRDg0bGtPcENzbHNjaHF6WjZqTGQyN1ZYNWU3Yk4z?=
 =?utf-8?B?SkFlaW9EUEgxL2JBZjltQXpMNTJBNGdKc1d1TWZ3RlEvdE1OK3cwVVRBVGEy?=
 =?utf-8?B?QURaRXBYZUhTNTU1VlN3akh0elk2UWxJZnc0dlF2dS84ek1Yby9UM1NSOFNo?=
 =?utf-8?B?Q1dmRnBVWDlkLyszQjVualZwbVB6K1BjWU9ibTdtMVE2MUh0VGNWYUFFVjVD?=
 =?utf-8?B?aHBHeFJYUnNJR0FiRVNEM010eXRmSFNaR1gzM3U3YlpMb295L01QcmpmWnhr?=
 =?utf-8?B?a1gzRTErUlcyVDdHdGh1NVRBNTJHK0pLL01VK09MamtZZlpPZGgrOE5aUHNu?=
 =?utf-8?B?QUNLbmFhRkhaS0lQRHp4NVR4aVUwVzNxczFaQUh2V0JPV1lEL0NPb0hrZTlo?=
 =?utf-8?B?VmRCRHBtM0xwV0xGZmpnNDl1SHVBczNuTE4zTHlGU2ZpS1BmNm1nSGs4NU9w?=
 =?utf-8?B?anZkVEgyemRSc21aSzNpd3MzYndhS1RTSVIrK09uQlBKYkNpdFkzeGVzM2I3?=
 =?utf-8?B?QWdhRmRpMkJjTUFocGFMaEV6VHlYU2ZZNzlxbCt1YnE2QmFETGVPQ1RNamxI?=
 =?utf-8?B?Z2cvbmZCM1Y2anl4Ui9vZWZxSTZtZVdyWndKNUV2V3Z2MzVFUTdkaDVGZTd5?=
 =?utf-8?B?dkREV0J5Z3k0bVhRSFZtTTVDSXE5Tlk2MjYxNnZXSFhMWjdsN2xNejJ0aDRl?=
 =?utf-8?B?VllBbXhtUFg2SkY2RExXNG5aNkkya1RabDRJd1FQSmdnMkRpNklIQkFVSnQ2?=
 =?utf-8?B?WDlON0psVE5TTklVWHJnVHd1VTM4dnBBeWNJTWFkYVVRSzJ5QnNod2dSNFZy?=
 =?utf-8?B?VUMzTnJKVGRqb28vZmQ2V1U0MDBvSjFhbVpCTW0rSTY2OEQ0UlE3WGwyQXFT?=
 =?utf-8?B?UG9ZcEZwbFJkZ1Q1THhMNWRIM3NXS2EyblhJemN0eHFITy85ZVo1dVIzejVT?=
 =?utf-8?B?V3NvNVplY044UXVKd1pJS0tYcnRsRUJTbyt4NWt2THNMZ1QxNE9YTHFqVEhM?=
 =?utf-8?B?RXVlSGxqdWpybjBlRnNMK2lUcEhiT09aUk5pbEpoMlNyWkk2V0ZITmV3MHJi?=
 =?utf-8?B?dkxpMXlXMmd1ZjczbnhjSTl5NCswUldsZnJqSWwwbU1tcFJxb2lKMlVhNXZm?=
 =?utf-8?B?TGV1bnorQ2hvZ1FDQzBCNTJRbTN4YVgrZnA4dGc5bC9yYlh1WHorZW9hd0JY?=
 =?utf-8?B?Q3JTc3dSU0FkZ1J2RVQ5OUdaY2hWczUyKzZ3Mk5GbVR1TzdDaXpkN1pFUXdp?=
 =?utf-8?B?aS9ORGhxNC9vRFNCWWwrdmlNZlBnY2VzTThMWDExN2wxck85UFFiRzRweTRK?=
 =?utf-8?B?Y2hBZm9FYUE4a0lFakdwejZLc1hXTHB6QkV3OEdnUnhBNkZqUS9RV2xLeGNI?=
 =?utf-8?Q?jcc/BMYQJ5OFcNynk8c2XPlmK?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bd45c5-e35c-4688-5ac1-08dbfc593bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 04:00:38.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhAXnbW7d38bQeoDwc1OYPd6u5Wnz6hEwUWVM9nj4aSsjEbP1TuF5WU7avEj2u/YnD7IsQDNCixytkAHLQw7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8094

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZGFtIEZvcmQgPGFmb3JkMTcz
QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyM+W5tDEy5pyIMTTml6UgMTE6MDQNCj4gVG86IEJvdWdo
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGJyb29uaWVAa2VybmVsLm9yZzsgeW9n
ZXNoZ2F1ci44M0BnbWFpbC5jb207IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBIYW4gWHUgPGhhbi54dUBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDIvNV0gc3BpOiBzcGktbnhwLWZzcGk6IGNoYW5nZSB0aGUgZGVm
YXVsdCBsdXQgaW5kZXgNCj4gDQo+IE9uIFdlZCwgRGVjIDEzLCAyMDIzIGF0IDM6MDjigK9BTSA8
aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhh
aWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBmc3BpIGR5bmFtaWMgbHV0IHVzZSB0aGUg
bGFzdCBsdXQgZm9yIGFsbCBJUFMgb3BlcmF0aW9ucywgdGhlDQo+ID4gaW14OHVscCBvbmx5IHN1
cHBvcnRzIDE1IGx1dHMsIHNvIGNoYW5nZSB0aGUgbGFzdCBsdXQgaW5kZXggZnJvbQ0KPiA+IDMx
IHRvIDE1Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFuIFh1IDxoYW4ueHVAbnhwLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIHwgNCArKy0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGktbnhw
LWZzcGkuYw0KPiA+IGluZGV4IDBmZWVjZjViYTAxMC4uOWQ2YjRkMjIyNjNjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkv
c3BpLW54cC1mc3BpLmMNCj4gPiBAQCAtNjQsOSArNjQsOSBAQA0KPiA+ICAvKg0KPiA+ICAgKiBU
aGUgZHJpdmVyIG9ubHkgdXNlcyBvbmUgc2luZ2xlIExVVCBlbnRyeSwgdGhhdCBpcyB1cGRhdGVk
IG9uDQo+ID4gICAqIGVhY2ggY2FsbCBvZiBleGVjX29wKCkuIEluZGV4IDAgaXMgcHJlc2V0IGF0
IGJvb3Qgd2l0aCBhIGJhc2ljDQo+ID4gLSAqIHJlYWQgb3BlcmF0aW9uLCBzbyBsZXQncyB1c2Ug
dGhlIGxhc3QgZW50cnkgKDMxKS4NCj4gPiArICogcmVhZCBvcGVyYXRpb24sIHNvIGxldCdzIHVz
ZSB0aGUgbGFzdCBlbnRyeSAoMTUpLg0KPiA+ICAgKi8NCj4gPiAtI2RlZmluZSAgICAgICAgU0VR
SURfTFVUICAgICAgICAgICAgICAgICAgICAgICAzMQ0KPiA+ICsjZGVmaW5lICAgICAgICBTRVFJ
RF9MVVQgICAgICAgICAgICAgICAgICAgICAgIDE1DQo+IA0KPiBXaGF0IGltcGFjdCBkb2VzIHRo
aXMgaGF2ZSBvbiBvdGhlciBTb0MncyB3aXRoIHRoZSBGbGV4U1BJIHdpdGggMzI/DQoNCk5vIGlt
cGFjdCwganVzdCB1c2UgYW5vdGhlciBMVVQgdG8gc2VuZCBjb21tYW5kIHF1ZXVlLg0KDQpCZXN0
IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IGFkYW0NCj4gPg0KPiA+ICAvKiBSZWdpc3RlcnMg
dXNlZCBieSB0aGUgZHJpdmVyICovDQo+ID4gICNkZWZpbmUgRlNQSV9NQ1IwICAgICAgICAgICAg
ICAgICAgICAgIDB4MDANCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCg==

