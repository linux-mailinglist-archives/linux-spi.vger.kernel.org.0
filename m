Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBA4D062F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 19:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiCGSS2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 13:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiCGSS0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 13:18:26 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7BA17E2F;
        Mon,  7 Mar 2022 10:17:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO4pLPur4UGF+m7vcJzvdgjLkXY3WnbqKFWyFsF+6t2AJg+2wKFPNrycteVrhDKeGC7cwmcnAauNjZtVXli5B4hP/d16odDGyitzht7v1eEG6xadkwpI8E4Fc3tSZ5jyUqPXSs4BKd96E5KNc/y9MXIYErJbciCIxjz1pSRt56yoEati1yoeqWfvAGgaDaM5XTFMg4BAcaE+i0CUysyRylR5MzkZRta0aB7p1dmukr+V/AxEmwtMRQwp9L1K8LDSQXBlO/W6HsQkqlq98cO5hF9qU0jjWYduw3xuPLqVy+gVGe7hdnJQjl2asI47kqBMjo+80rzE7vVobtBTF/oU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVGZNxbyq/iquzkOVwQo7lDtXcFdiOfIWISAOZgqQxU=;
 b=JwihLuTe2uevm6ee/TOfDsHtyWamR9OH95miKEHZFpJ/lvtwvFrkfqLZ6HoLLJg6icUWOdmE1eNnwX5MHGiJoD4zmlhiV3odIwSHIjeKCFQ3dhf8vM80c8ABMdq08sD1xAfL3SzlBW3fzr2mMDOH1Q6P9blivW4amQbUUcGp0updi3z1r91cKHkzgS+67+j4X3qRA8wnep7muO6y2fx0Rpg2C8ZRdPB50bbT0Hgav7Nf6JgMsy0oEnj+8nYWG6Ej4zVFjJfhg2nYuxvNSym80QPPh6y4pOsBHbXCzx6na5Ni0uaMugpLl/XR8wSKQQ5yXijWNBQnl58B1oBb0u2fDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVGZNxbyq/iquzkOVwQo7lDtXcFdiOfIWISAOZgqQxU=;
 b=Hl0Od4NRhs3huqphRXo7RI0fbTYWszeqopunUc44l7J0v8dBY0S4TWzxDpMtyta5zkqZQxXjii9GEwozwNm99lPSMu1ymMIExshB3TtL8kByTlFZanlKqixBVmNvZyphho6wtCDHmO2Ndi+LzAx32tSVfAF5bCFQU/QdrODtHEg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (20.183.20.197) by
 TY2PR01MB5275.jpnprd01.prod.outlook.com (20.178.132.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.18; Mon, 7 Mar 2022 18:17:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%4]) with mapi id 15.20.5038.023; Mon, 7 Mar 2022
 18:17:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: Fix invalid sgs value
Thread-Topic: [PATCH] spi: Fix invalid sgs value
Thread-Index: AQHYMk1bt5E5wl7NDk+Lte/agSpjXqy0N7sAgAACUqA=
Date:   Mon, 7 Mar 2022 18:17:23 +0000
Message-ID: <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
In-Reply-To: <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e7156b-058a-440d-9109-08da0066ba01
x-ms-traffictypediagnostic: TY2PR01MB5275:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5275E227C6DDE04E8DF54B1B86089@TY2PR01MB5275.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxygocDUL7g8NXPXbMb3F03P79VcECkqS0NEDViyP+q6q1CfzUM1Fq6yllu9MNl9ti7UVe1KKu/skbgMNq8QeFkPVWeyJpRJ3ZbuLgU1K1ZhoI32yBW6+mm++iTnrl4yBqQiPCtslA2VOLnPl9f6/kRF1NJhGd1+rSriwW3ZvMcmOodxlfVOTBQ7RMCGIhND3P/O2MYtUFz7YJuyveeZl8Kl/wip6jZjvl4OcN02E41kRlW0i2t0Txn+ENowOWm11H7mJS4paQvIvDnmGJzDkYghkOev2JroFvjyqa6nSIhtIqe02QfGchioMaE+H2v0y+urx7dkbwufTSjV0rUvtSdTfWW+i9I2Si2AqJaOkp8oAMsuDwGyjVEhqObHYDcxOIELbNb0XESMZxlDACUUiKMpNZ6ASDzrOd8wGsceQCRV77UTvFAgiOeyNv6uUW/MXeiCukrrpeLR0qLdjTkDeovt5YgTuXIOBjlGid4lYRaj0+0qDjjcVck2FfgHJok3aNj4tzDbMh5e4txKJfl+FUCqHaJdijZMQqhqYZ03HBG1djAInF+Gh7Mek0d4t+/D8KzLrRHP+VKRptzvi2nAhoRM4GmzWJnJdV2ZJ19ELycTbQC8XI1ozY3A6xeCTlMezN696/QVDFqMILvOSwy7xm7w6ey2WYCCgvAUtTthWGmSUFp7UUh0TPcWWJbvB7n32CCYLtvq+3wC/3zrZw4cwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66556008)(66476007)(66446008)(8676002)(6916009)(8936002)(5660300002)(38100700002)(4326008)(66946007)(52536014)(76116006)(9686003)(6506007)(53546011)(2906002)(33656002)(186003)(7696005)(26005)(86362001)(54906003)(508600001)(316002)(55016003)(71200400001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3FjSCsybjF5VkJHeHo2VWlDVU9GcDhjWm1EWWdmQnp2RWpIbFdISS9DdWZT?=
 =?utf-8?B?R0V1OEQ0MCs4bVE3bHNoeFF6SlFTZlhBOU9vNDNVdnU2TmhYSjRCbVdkVTZk?=
 =?utf-8?B?RlJGanhDWkFDTHI4Qyt6SkJrUjBUMG04cjdpb0Y1SEQ0SGRnTk91UklWUDBm?=
 =?utf-8?B?bnlGYmpTUGtWTlBybTlTMkFzVnJKRDNZWW9LMHRiVy96NWFueHNMRy9CNDln?=
 =?utf-8?B?bjR0RUdqMS9NL1V2TzN0Wmd1V3JUOXFEd0d3blVXazVnbis1MUI2cVdKdDRD?=
 =?utf-8?B?dzFrRVVZOUZnOVJaNWJUSldmS2hkVllhcThtTktYSTJlUG85cndQR3VDRzY2?=
 =?utf-8?B?dHZ5TXZlcFhNWTR0N3NVOTVoOC9IdmpJeVhYZzZub2ZPMTZKcU9Jc0NBT21Y?=
 =?utf-8?B?V2IyU3Z2VElhSHF0MURnTU4ySmJmVDg4cUNDSTdOZ0EzcEVMdllKUkl5c0lO?=
 =?utf-8?B?Zkt1VWQyYUIwTWRBdkNIWWZzMnJkMFBTblFoSWdySloyeGRSQzhJU28zSGRZ?=
 =?utf-8?B?UUN0SHozYkV0Wk42R3hJMXBKSGlENlh0aXBoc1Yrd3VrRTZjTVNHVnlJRUU3?=
 =?utf-8?B?VDhuZGNBVGhQZzRXYVJMQ1ZzK1pKWUgvNUQwMkpJaXJ3bWUyRG9Fb1ZUNHAw?=
 =?utf-8?B?dEFWUGVyR29lRUI1R2RaMGhqZWZhT3cwOCthaHdrd0tmUkdDQlE0LzVta00z?=
 =?utf-8?B?c2xRRlhLTU1IRTE1NEpzZ29VZFdGOWJYZDcyR0lYZkhiY284eUYzYWVsMUVu?=
 =?utf-8?B?TGhYcTZ6cTR1RUt1RjlqYk50cVg3MDFHZU84SG16RDA4VnNxWk0raFJSYlVz?=
 =?utf-8?B?QWNndzhLVkRYeTFHN3UweVg1bzVkSC9PdXZMek04YnFycTU2c3RPMTJ3V1pD?=
 =?utf-8?B?NVZ5YklpRnB2M3ljUDI3U1VSTW9QZk1kYjZFN1JCN0owSys3THU3MVlUQ3VW?=
 =?utf-8?B?RXpqTmRSRVhmMGQyR2FzcHlWaEJrL0NhUjQ1Q01IdVhBcWhFYThWSHAwSGps?=
 =?utf-8?B?OEY2R211Z1N6VE9hbWMwdVJvY3loZVgwdzlRUkZnNXFCQkszOU51ZmVGOVg0?=
 =?utf-8?B?dWhCN3VnRDh3WTkvaVY1R0g2UWFkMDNuMGpiMDlNLzBRSXJWUS92aU50bVlY?=
 =?utf-8?B?T2YvdHpPNDJwL2ZXNFlhRHhEaGxnZjJmL0VxdWVTMncyWXBGL0w5TjAreUlH?=
 =?utf-8?B?d3N5Tzc3TDRDOG9OZDdsUStUbTJzMFNNTkVHb1ZEdkVGZHpMaUVxRzJFY0Vl?=
 =?utf-8?B?djVrbE1ZWXpJNUl3UXg1c0hSaFdYUWNvbXZyOU4wWFN1bmJtZXZYcCthMFRs?=
 =?utf-8?B?SkRyTmQvaWluR0h3ZmZnR2JvbmVwc1lCQlVTdkMxamk1ODVyZTVjZmlwUzU2?=
 =?utf-8?B?Wk1vQ1hzOExIOXRDQ1ZIVkhXMkJNNW85WnBoelZkci9NRGg5blJMa2FxeUl0?=
 =?utf-8?B?UUJtUElCZHA2eFNVTDRhRm5NL1BONG1HOVhBR0lSSUdRTWV1cWhjTWxjRTdG?=
 =?utf-8?B?ZmIrMXNCV2tRMFZ4L1plcGRveEJHMUxud2ZPdUZ3Ri9hcVZ6bDF1SzVBSlph?=
 =?utf-8?B?V3JyK2FJRHFMa3hYTUdpUmhIVlA5RjQzeWhXclFGUjRhbWFGc1kyT2VFMmtj?=
 =?utf-8?B?eTg3YlAvVmJRWHJwdDdxc0IwY3FZSzlER0VlNUp2cnArcnZsdVJ2SWEyenBl?=
 =?utf-8?B?NHVTRGx0d21ZVmJ2L1JYRXNYLzZuNURjd3FuOEFTU1VSS0ZRYUxvNUlLdWJy?=
 =?utf-8?B?UFFFbE9xTEFxcTlxcVNJQWVha245djltRm1BUGJtVHM3NUl6aVZiRnF6VjRh?=
 =?utf-8?B?eEV5TmxiVEJDcjR2N3N1QVpmejA5NHphNEthOFY3dmZDTzAvNTNOaHVvQmZV?=
 =?utf-8?B?NFNZclkzVjZ5UEkzZnlsVVA4a0FOUmU0M09hK1F2dVBKaWlvK0MrS0pmZWVQ?=
 =?utf-8?B?RjRlWXdUY0dFUW90VCthZFQ2dXAwV3A1ais4eldwWnhIMW5KaHBLYkVibndD?=
 =?utf-8?B?RDlEYk1zTUJBQ0xzaUluVHI5M1hWYkxUUXNkaU83dWZoZkdmaEdPYUpzLzBL?=
 =?utf-8?B?OWQwbjNRYkQ5c0swTlZua1k3TlpCaElDdFlMcFRHWlNackF6UlFwekh2T1U5?=
 =?utf-8?B?NThqeUJRdzBFNlV4UEI5M1VoTElDclNYTEFCUVVoaHowYXIzT3hqdGZDNjJQ?=
 =?utf-8?B?UXl1MXRmSUg4OVRuZXlDUnlCL1JHRUMrSmJ5QWFXTEZNWDh6RTZKbXpkc3Qy?=
 =?utf-8?B?SDRNd3V5V3JseWhlZm1Db3B2Wk13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e7156b-058a-440d-9109-08da0066ba01
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:17:23.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1gIW0amutb9EIybSSpvLVKnmxv+UehTVrpqGzTQdXZwLlhzrUoNnZUSdcbVBMEOoL8vWE4kmwrwrUY1l1Di2awYXh7s0LnK2Z1avtCa81s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5275
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHNwaTogRml4IGludmFsaWQgc2dzIHZhbHVlDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4g
T24gTW9uLCBNYXIgNywgMjAyMiBhdCA3OjAxIFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gbWF4X3NlZ19zaXplIGlzIHVuc2lnbmVkIGludCBh
bmQgaXQgY2FuIGhhdmUgYSB2YWx1ZSB1cCB0byAyXjMyIChmb3INCj4gPiBlZzotUlpfRE1BQyBk
cml2ZXIgc2V0cyBkbWFfc2V0X21heF9zZWdfc2l6ZSBhcyBVMzJfTUFYKSBXaGVuIHRoaXMNCj4g
PiB2YWx1ZSBpcyB1c2VkIGluIG1pbl90KCkgYXMgYW4gaW50ZWdlciB0eXBlLCBpdCBiZWNvbWVz
DQo+ID4gLTEgYW5kIHRoZSB2YWx1ZSBvZiBzZ3MgYmVjb21lcyAwLg0KPiA+DQo+ID4gRml4IHRo
aXMgaXNzdWUgYnkgcmVwbGFjaW5nIHRoZSAnaW50JyBkYXRhIHR5cGUgd2l0aCAndW5zaWduZWQg
aW50Jw0KPiA+IGluIG1pbl90KCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IExhZCBQcmFiaGFr
YXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3NwaS9zcGkuYw0KPiA+IEBAIC0xMDE5LDEwICsxMDE5LDEwIEBAIGludCBz
cGlfbWFwX2J1ZihzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsDQo+IHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPiAgICAgICAgIGludCBpLCByZXQ7DQo+ID4NCj4gPiAgICAgICAgIGlmICh2bWFs
bG9jZWRfYnVmIHx8IGttYXBfYnVmKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRlc2NfbGVuID0g
bWluX3QoaW50LCBtYXhfc2VnX3NpemUsIFBBR0VfU0laRSk7DQo+ID4gKyAgICAgICAgICAgICAg
IGRlc2NfbGVuID0gbWluX3QodW5zaWduZWQgaW50LCBtYXhfc2VnX3NpemUsDQo+ID4gKyBQQUdF
X1NJWkUpOw0KPiA+ICAgICAgICAgICAgICAgICBzZ3MgPSBESVZfUk9VTkRfVVAobGVuICsgb2Zm
c2V0X2luX3BhZ2UoYnVmKSwgZGVzY19sZW4pOw0KPiA+ICAgICAgICAgfSBlbHNlIGlmICh2aXJ0
X2FkZHJfdmFsaWQoYnVmKSkgew0KPiA+IC0gICAgICAgICAgICAgICBkZXNjX2xlbiA9IG1pbl90
KGludCwgbWF4X3NlZ19zaXplLCBjdGxyLT5tYXhfZG1hX2xlbik7DQo+ID4gKyAgICAgICAgICAg
ICAgIGRlc2NfbGVuID0gbWluX3QodW5zaWduZWQgaW50LCBtYXhfc2VnX3NpemUsICh1bnNpZ25l
ZA0KPiA+ICsgaW50KWN0bHItPm1heF9kbWFfbGVuKTsNCj4gDQo+IFRoZSBjYXN0IG9mIHRoZSBs
YXN0IHBhcmFtZXRlciBpcyBub3QgbmVlZGVkLg0KDQpPSy4gSSB0aG91Z2h0IHNpbmNlIGxhc3Qg
cGFyYW0gaXMgc2l6ZV90LCBjYXN0aW5nIGlzIHJlcXVpcmVkLg0KT0sgd2lsbCBkcm9wIHRoaXMu
DQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiAgICAgICAgICAgICAgICAgc2dzID0gRElWX1JP
VU5EX1VQKGxlbiwgZGVzY19sZW4pOw0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2hu
aWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxr
aW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0K
PiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMg
VG9ydmFsZHMNCg==
