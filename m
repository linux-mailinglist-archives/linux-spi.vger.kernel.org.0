Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24341579538
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGSI3V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGSI3U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 04:29:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334930F57;
        Tue, 19 Jul 2022 01:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLhxguku2QK8jwO0E+xo2TuKeL5oxTA/U+1PAcN34B+VXwf1bBjA6sR72tS5jEWghRXy4rCzNd33PYqlgIQ47xBVo5b8jDK/IBDHvyxOeI0Pf4WT8LnlRp/D8VZR5+x6FP+WM0i6LXbbP9OO6+/ZN/d+2pIHmJfPprj5C0bseh3H7A9CyEJBHmkGu88x7EkWeZYlnixDL0feQSudHE53ID0dUMVkrKBATiTXPteLSEvj0zQcfdCDUToHbYposnBlBmVCZO4JR8MK86c6DJjRDy8HpbK7ibTIzXN/XIfqSoWGVSaSqG3yC1fTCaOh9Dqnh4bjBTrhWe4swHTosXxC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VG8SFQXKkwi4ELYCI2n+QcOh8XmlH2+6lts7xQybFc=;
 b=aWK/EDC0c/6zfiZzO9gUsqOahnAp9D9aux5m94amL4YGi9JI4E8tBdeCDFogecdN8K+w7Q6mMh8mUXeVf1JT0i/wgp/DIAsa/lGjkUEnCSSXkX6r8gXxHwLhjtsRHXM+BRqPz96IbWvRvGbFy++tOXiQbbJV0qmirEfZw7C3qJEuWE6q7Jgp51Md2y+0uZjnDdiU+3OAoe7/tXXpHCis9qQTxhSSjhuzlClCjti0+SkOQqjpS10150oDk5BmaSaTNQQNxsErxJ/PrFM6R80N+saTG3fpeLHwXaefphqCHsYPl7ar9QOulUGYms7moDgrFwZ0SKCmJB/x+y/Ok+swjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VG8SFQXKkwi4ELYCI2n+QcOh8XmlH2+6lts7xQybFc=;
 b=Gm/bSPkMXie7R1RknZZ26WZhq52CCKseDUwUsTIFVZUHKTqdAeyMMBc1gXa1N8KwYL7VJhp9dx6BaooW7x5McUuGBPlUdQyXdslQsXSLsLQpyJMtpdREE5xrY3IWqjQh9mNNVGHLs91D3JX1X0Y096BDuFjB1HWA+RjiNUfJBUQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8733.jpnprd01.prod.outlook.com (2603:1096:604:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 08:29:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 08:29:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Topic: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Index: AQHYmSpFDIO6jbtkAU6yW6fT0KKX0K2FW9cAgAAB/jA=
Date:   Tue, 19 Jul 2022 08:29:15 +0000
Message-ID: <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
In-Reply-To: <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 668474ef-63a8-435b-c329-08da6960c44f
x-ms-traffictypediagnostic: OSZPR01MB8733:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsS0NdA8wQqXSH0MNA1rq/BKQnz6nSW32fZF8NX2RO2bTjK99cZSoXet7Y+ia7ZZ0FrNK2y7AJ+y6tFsk6zPpHDqfWFe3GwsZhwbEhZkozIBcUueX1NCkFNzjpqpfnpDxLkDQkWq5LdSwoghgCNQtuTp3YNYrkiDGv+z0zyyshnPRIlbnnp9hyRKx/95Te0Dvk3vFnj+DCX1h7UsjhGkUiwiebOiTBSQX4vNY5WZkLcmaEnr8sg+HPe66WZxmPwUEOFsKL+f8XzRS+zKcCgESRbD2z0mV6KOXNI6lmvPdG0KFMlmemRWVQulSaUwQJewFagJ5ho7QJX5cM/x1NQHmkBDqE/wBsP5EnVglQaBr4owGVIR2/tVBg5e6AIgQqXPARSzBmrhmAmCpc07vwAir9iJhxtuEuY6hFkT5NKlVtXTJ3O6mQTmPX5LbY2FlB8nCq7gu5P1/cqHnzOgPVu8S33hsB4N3K8NTSZWokZg4IXH2Mh8VHXKiY2/92sUt4npxVvjqa0QhRonKFxFsHXmfdB7a8vo7oRt+Q4GINIefX4fSnb06nr+HGErfAnEDd6NxaDYDh0547aSzxGFVeyLNeIGcxScrizN/u6MWd3sQPUelqHsxaPW/hmK/vxghsdYzTKwWeVi3Ou/kTTRav5z6n/KgpHJ/T2yIfx7pclzuk1ZOReV1PJvKWs7c9Y5yqPZvB5+SJ0c/AAk0gS80HQ02Oc0psVBzGichYusR0aVBaKnVGGUmNkq/iaYQzJ6yoYZ3BSBqSLKRXzYKOFRnAXiVcPfBLPcLMp3Oyp0FkZbuHwhaR0ZgefZ6oyhbvjShE8RVVO508wy8utV6w5dCNc/9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(54906003)(53546011)(6506007)(7696005)(41300700001)(2906002)(186003)(122000001)(38100700002)(26005)(38070700005)(107886003)(966005)(4326008)(64756008)(66476007)(76116006)(66446008)(71200400001)(33656002)(55016003)(8676002)(8936002)(9686003)(5660300002)(52536014)(478600001)(6916009)(316002)(66556008)(86362001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFYZlM4OElsYjRMcVUrMjlTWVZ2cVdpdlduYnRZM0tNZzV0ZDU5UVl5Y3k2?=
 =?utf-8?B?Wnd5VlF5c29nZ1lFNDlHQ0NYbFFsWS9USCtOMWxDWWVnU0FFTEhmMXVLeEc1?=
 =?utf-8?B?a0VGOHVka0JUY0M2b1k1dmJCSDU3cURSL04yZHN3WmxsQ3htVUtvTHNnbGlt?=
 =?utf-8?B?NVgvdEVSajQ0VUp2cExjN2V6S0RVVDUzQk9aeTZCdEVVWnM2b240aG4zYmF3?=
 =?utf-8?B?NEJhb1poQXhrb2kxMWVvRGsydThFZ0Y1ZGhXc2VNZWh4d3hZMjhydy9Kak90?=
 =?utf-8?B?ZlhsMjFkNkxhSGdLL2had25KSk85T2cvd3k5QmNVQU9oRzdJZW5RR1N5OTEr?=
 =?utf-8?B?ZnhBeTZMM24wTDhOOGxGNXRwV2w2VDhUSmNaeEoxQUhLcWJuSjVpMFVkTG14?=
 =?utf-8?B?NXNlZHRqSDdYWWRwS0NIenlVYkw3ZEZuZFlOcWtESzNINW51eUxUaEJnRWpP?=
 =?utf-8?B?Y0RNUzZ3MEdNcm5ZeVI3amlIVS9zMi9WYzNpZXBNSzYrVlRsTVpEVTBvcFVv?=
 =?utf-8?B?UUFVd2dRQ0hZdmU5Tithd1RPNHVqQnloSGhSRGkyQkhTVmF5VHUxM0VNRXBM?=
 =?utf-8?B?blpORUVkSWEyS3lSOWpORFI3cWlhVGsyc21RVmhpa1JScm9vNlBXWitkMmZW?=
 =?utf-8?B?TVltd0s2c2VVcWZPR0pUV1VUbGE0QnViS043cFI5WWF3eGsyNGVNQ084VmtE?=
 =?utf-8?B?UlllMlVZZTZpWk9pWS9NUkxmRkF3aUN6Y3VFdFlxOHdNRDMwdE16TDVRQ3Jj?=
 =?utf-8?B?QjlIOEY2SEF0d0UvWmgzcmd6RDBFdnRTdlJRb3pWSjFMbWdyU3VjOUZETmZa?=
 =?utf-8?B?TlFKMFBWdDcxd1RXVDBOWGRRUVpSdEZ4RHZPOUFsdlpaeVhnOXdaUVZucUUv?=
 =?utf-8?B?SEJoaWZReVBVU2dlUnhCUU9Sck51ekkyWWxqWWlybHlUM2c0V1lKT1hWL0JO?=
 =?utf-8?B?N0drR29FanB5Q055VFFLQWh6SEFkM0kyaXBnSW1iSWplOE5hRE1pNTVDRDg5?=
 =?utf-8?B?cDBONUZkdm51d0FHYkxWYkxVaVhXTFNrcm1MVlBWQklWQzV3c1JsQW5HZlhB?=
 =?utf-8?B?Mzc4dW5QYWtMQ0k1YkZtTFh5aTE0K3Vyb3ZhVnVQYmk4b2J2U2VDdGFOWkdz?=
 =?utf-8?B?REM0d2IzVStrdEZnK1hXY2x4YWtSUlk2UGtHZGpjeDZXTkZwK1BKTWxsMXVP?=
 =?utf-8?B?WDR5TFJCbUlyK2c0OGdkS3I2U1liVGNWNndUZEpQdDkvL0tFSjdUVzF4UDNN?=
 =?utf-8?B?QU9uQXRadEV6YkN3V3pPMzhqemwwQjMwcWhad2RZTHhabVRQTi9pZHJTTHhJ?=
 =?utf-8?B?NGk0MUVFYjJOTTh1TU5HTEhVdjNnV1ozNWZHMUxhbGhIS3IwcVd1TnpmTXkw?=
 =?utf-8?B?Q2MxMXZLSVl3OVU2RDBMc2tuNmtKVlR3aXZNL00vSnlqTTlRZDNiWVNRZjFK?=
 =?utf-8?B?d0o2K0tsbmJmSTU1ZzVPZUZ5ejNJeERNMmJteFkzelo4Y05Gc25BbXRTN2x1?=
 =?utf-8?B?Z0NxRDB1RXlHR1k5QlJ4UmFEdHBXRE1ueDdMK1N3d1psTGdaazdYZk84ck1u?=
 =?utf-8?B?c1FjeW1yOVpUNGhwSFllQythUUFUN0tUdVNLejBnTlVxY1JxMnlsNStHYU9n?=
 =?utf-8?B?ck43T0w2OUtQbmdSN0Z1dmJJWmw3MlVZdGlRaEU5Y3JjZEE3dWRxSzUxbWVR?=
 =?utf-8?B?d2JKWFRzWmZPWW56ejNneFI5b0RlMndwQXRCTSt4amJZL1RjbFhpQXc5ZkJQ?=
 =?utf-8?B?akNaaGRoYVN4R0tKeXlsQ0ZjU2U1czRSN2IzQUZ0NHc1QjFGdjVMNXQvdzVC?=
 =?utf-8?B?eXNFRkp1UVlEZUVqdXQvdmdvUUVOR21qbUZ4YXhqaktuQTFNWUpPTFBOd1li?=
 =?utf-8?B?MWh0TzNxVzVrczFTQWdlMkhoNmNQY1g2L0x1VGxSbGQ2ZnEzNkpRUitZWldr?=
 =?utf-8?B?a1gzLzkvWjI4WkFoUStGQjFMZGZyWFFnWEhRdDE2QVlHL05Xb29vN1pVQnc3?=
 =?utf-8?B?WGNtNE9Cekg3ak0yeisveCtadTdHb3dvcHlkL05MaEkzOEVydDYwZ1FwcE1n?=
 =?utf-8?B?TXdxMGNxdjMvOFBraDRWTkRZRDhEOUpXWSs3Qnp0Y0xsdGxkbDlheWVEYlBt?=
 =?utf-8?B?K05vbFI0c3NlREJaQUN5c2VJT3JzWkVLWmovK1JwdENna0FLZFR2bFBVVGpL?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668474ef-63a8-435b-c329-08da6960c44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 08:29:15.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tzkx2rtXNdn3CKG2jg3mX6VSMtjfDb8/PTfDBG+fH9DgPhUyN0YLVj6R2lBTQzuljHJ+esi60Zo9KTRGtZJhRtvECbfP3S7GzkMDG6ZZkUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8733
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCisgQ2hyaXMsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3BpOiBzcGkt
cnNwaTogQWRkIGZvcmNlX2RtYSB2YXJpYWJsZSB0byBzcGlfb3BzDQo+IA0KPiBIaSBCaWp1LA0K
PiANCj4gT24gU2F0LCBKdWwgMTYsIDIwMjIgYXQgNTozOSBQTSBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IE9uIFJaL0cyTCBTb0NzIHN3aXRjaGluZyBm
cm9tIERNQSB0byBpbnRlcnJ1cHQgbW9kZSwgY2F1c2VzIHRpbWVvdXQNCj4gPiBpc3N1ZSBhcyB3
ZSBhcmUgbm90IGdldHRpbmcgUnggaW50ZXJydXB0IGV2ZW4gdGhvdWdoIFNQUkYgYml0IGlzIHNl
dA0KPiA+IGluIHRoZSBzdGF0dXMgcmVnaXN0ZXIuDQo+ID4NCj4gPiBCdXQgdGhlcmUgaXMgbm8g
aXNzdWUgaWYgd2UgZG9uJ3Qgc3dpdGNoIGJldHdlZW4gaW50ZXJydXB0IHRvIERNQSBtb2RlDQo+
ID4gb3IgdmljZSB2ZXJzYS4NCj4gPg0KPiA+IFBlcmZvcm1hbmNlIGNvbXBhcmlzb24gYmV0d2Vl
biBpbnRlcnJ1cHQgYW5kIERNQSBtb2RlIG9uIFJaL0ZpdmUgU01BUkMNCj4gPiBwbGF0Zm9ybSBj
b25uZWN0ZWQgdG8gYSBkaXNwbGF5IG1vZHVsZSBzaG93cyB0aGF0IHBlcmZvcm1hbmNlIGFuZCBD
UFUNCj4gPiB1dGlsaXphdGlvbiBpcyBtdWNoIGJldHRlciB3aXRoIERNQSBtb2RlIGNvbXBhcmVk
IHRvIGludGVycnVwdCBtb2RlDQo+ID4gKDEtPjY1IGZwcykgYW5kICg5OC0+OCUpLg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgdmFyaWFibGUgZm9yY2VfZG1hIHRvIGF2b2lkIHN3
aXRjaGluZyBiZXR3ZWVuDQo+ID4gRE1BIHRvIGludGVycnVwdCBtb2RlIGZvciBSWiBwbGF0Zm9y
bXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IEBAIC0xMTk2
LDYgKzExOTcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9vcHMgcnNwaV9yel9vcHMgPSB7
DQo+ID4gICAgICAgICAuZmxhZ3MgPSAgICAgICAgICAgICAgICBTUElfQ09OVFJPTExFUl9NVVNU
X1JYIHwNCj4gU1BJX0NPTlRST0xMRVJfTVVTVF9UWCwNCj4gPiAgICAgICAgIC5maWZvX3NpemUg
PSAgICAgICAgICAgIDgsICAgICAgLyogOCBmb3IgVFgsIDMyIGZvciBSWCAqLw0KPiA+ICAgICAg
ICAgLm51bV9od19zcyA9ICAgICAgICAgICAgMSwNCj4gPiArICAgICAgIC5mb3JjZV9kbWEgPSAg
ICAgICAgICAgIHRydWUsDQo+ID4gIH07DQo+IA0KPiBEbyB5b3Uga25vdyBpZiB0aGlzIGlzIG5l
ZWRlZCBvbiBSWi9BIHNlcmllcywgdG9vPw0KDQpJIGd1ZXNzIGl0IGlzIG5lZWRlZD8/IEkgbWF5
IGJlIHdyb25nLiBJIGdvdCBhIGxpbmsgZnJvbSBDaHJpcyBbMV0uIEFzIHBlciB0aGlzIHN0aWxs
DQpXZSBoYXZlbid0IGZvdW5kIGEgc29sdXRpb24uIE1heSBiZSB0aGUgcHJpb3JpdHkgaXMgY2hh
bmdlZCBmb3IgdGhpcyBhY3Rpdml0eSBhbmQNCm5vIG9uZSBsb29rZWQgYWZ0ZXIgdGhpcy4NCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbmVzYXMtc29jLz9xPXNwaS1yc3Bp
K21peGVzK0RNQSthbmQrUElPK3RyYW5zZmVycytjYXVzaW5nK1BJTyt0cmFuc2Zlcit0bytmYWls
DQoNCj4gSSBrbm93dXBzdHJlYW0gZG9lcyBub3QgaGF2ZSBETUEgc3VwcG9ydCBmb3IgUlovQSB5
ZXQsIGJ1dCB0aGUgQlNQIGhhcz8NCg0KUlovRzJMIERNQSBkcml2ZXIgaXMgZGVyaXZlZCBmcm9t
IFJaL0EsIHdpdGggc21hbGwgY2hhbmdlcyBpdCBjYW4gc3VwcG9ydCBSWi9BLg0KSSBhbSBub3Qg
c3VyZSBpcyB0aGVyZSBhbnkgcGxhbiB0byB1cHN0cmVhbSBETUEgc3VwcG9ydCBmb3IgUlovQT8N
CkkgZG8gbm90IGhhdmUgUlovQSBib2FyZC4NCg0KQ2hlZXJzLA0KQmlqdQ0K
