Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD857C8DF
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiGUKYy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 06:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGUKYx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 06:24:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0032445;
        Thu, 21 Jul 2022 03:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLjNMq1TLcVgcZ7o/pRwyYrUdkSVeRIGOpIE7A59otmkLI2g+WBx0XVxtzwsi3D/zNAChFL9e89DZA0Xjv2eMWmCdyB4oSLdP37Vgh2nLUJRSKN/x/11BvJfKP5GwmKfg8n8DOrPs22oqIG+1acaYL2kL6NJRObJ+O3zOHzTSnA6V40Jd15b0367+gWglWbXHCGpWbo/P7ld2qTWrwdB96sTV2PdQbtozzc1REgovpaFhhfdaBTYIIG/PVx5rM0hg+Ne2dDzREpwtcNaZVNyLtwkMRgfRXzYqXP/s33mHKzV+5kxmjk8AtZtV21jVICksCSfm9zLkRlM1V34E27apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE4rYhpaHTMhNfwMjT2hwyfRT3ugkC9e7gdtGj5h5Vs=;
 b=BCZIIdbWo6cAYXmg+Ys1Lm444dg0Y8p3BVvV9i7YDYwny1fTT5WxEhOYikZpSqzfSdnHc/sXLZIJoBL5g1wlBe5wvVKZsSfO3P1UEKIFfSOursHLvMHCkXKg6NxyQ1PaZSCsiRPhTrrf2j5+Ag8BTZOxywi0ejvtj7jQyF3rzrarpocgHDPohSZOx8pfkaghAQppIP5xNWhr0RSPiTldTDmSwnhfp420Lo86m4UCNd6oUkeMr5PtuVpm+ozMkwjDggW93XbWVwL5mOLtRR6ySQ9axRv0qy/em5mRdvgVi4PU47G9wOQ3XjaEcAMNKwv2QnEgFjBfrDf1qQA1BDigTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE4rYhpaHTMhNfwMjT2hwyfRT3ugkC9e7gdtGj5h5Vs=;
 b=eutfOhLpR5DyXybtM1OGuJopyTRJnhkqUh2RqbAfZG6owWE5Yc9ks/u+GacqhqDLn37Qpto3VB9Y+1Bw0VNYYsi+FGI3hGRYt9ordKOxRQdImcTtoQ9K99YQObXuK3iv0Qxeind7X7Yvrw0GkEKbMRpa2OAoi+GuUmb35XWkclM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB3819.jpnprd01.prod.outlook.com (2603:1096:404:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 10:24:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 10:24:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Thread-Topic: [PATCH v2 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Thread-Index: AQHYm4A/kvn+TAubrkWRxmRfQOAbga2IlveAgAAJR5A=
Date:   Thu, 21 Jul 2022 10:24:48 +0000
Message-ID: <OS0PR01MB592202AAB8EFC07FCB8C5C7C86919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
 <20220719150000.383722-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdWvyF3L=V+C9k_XqnyZyyUdCZ8nZD90d4uWPx8vh3MWHA@mail.gmail.com>
In-Reply-To: <CAMuHMdWvyF3L=V+C9k_XqnyZyyUdCZ8nZD90d4uWPx8vh3MWHA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f18737-6175-4617-bed8-08da6b033d3d
x-ms-traffictypediagnostic: TY2PR01MB3819:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFb73XG1Jz/3hvwllh1k8uBCMqnSN/oxdxc3scgVobGRgnhhI7c7QENlZlPl4Ap3Aa9bmsqWMkBngg3l5zpQ631Pe3oaB7Te63VkfTVP3e8GPeWFDHx6OswUe5Pm1tc92Ozz4ZwS09SbD6/840z6iojlanFMvb5nmhAO1EwJWPx3aeRwLRTcTCerxUrTZM6XQHKne08h9niffAfF5kDyCkTZ1sIbWvEIsE9tc+56xY/un54jcvBh2hnwDbAtQJ2cxST0nK9rBc4bxQ4hmfzxZyTP196X83HoZn2BZMFHe5gbTsOr0BlcC6EKmpr5C+vrrWqaPxifSn4MwtfuqGTpd0v6nocpODVO2AQYQsYDUnS7jO8gJD2E70oqFw3MwspNUawIUx+jL/4QAlIo+RkFkRda2wtyMLrcZXOLIsVVM4GJ5sQMymbSMZBlv5U+gJwkLYpS7yU7gbVNFRsD4HUvy4RmXPd6Iii2hw3YvsA4xOPLQh4sup65mstB9hg7XuhewJQ+3270gJCt2iF06vRpkPv5FhMYoIQTI5I6tmETX9I4907aiO39NKQ28L5Q3DT2pMvAxp+UqAYAwlc+fbiZ6vEjtqovtD8jEpqx8/uy+GeXp41vZl4ZaPa7Lz2QNmvPurT/9CAqhdOTxTL6Yv7m0HgRUgmTAgrpidfNZMdlNj3g0x4HGmnOfX49kRq9csEvMqrU4ocnaaj5RqyYW5MJnwnhUW4ZWkEKBEUGwv7vWO54IHDTIARhV/VvcKT8eM8Cjb4GE5MaWvxqnMnANNmkC15CTMtNatl9Q+VTAkokLGXNHAYn6kJ30GHJvugi31Kb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(33656002)(38100700002)(8936002)(66946007)(7696005)(76116006)(64756008)(66446008)(52536014)(8676002)(6506007)(4326008)(38070700005)(66476007)(6916009)(66556008)(53546011)(54906003)(5660300002)(186003)(41300700001)(478600001)(9686003)(55016003)(26005)(2906002)(86362001)(316002)(71200400001)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3YxZEowUGErL2hVQ01LSlJveng0QStEcTJCZTFYZXBHZ1RVZVE3S2xXcmw5?=
 =?utf-8?B?cDFmUThBTHE5Z21ZRUVWdnQwbFowa0kzK1BBSUhrMGJvN3RCSk1JSUZQMmlW?=
 =?utf-8?B?NW5BbVFWTHlEOC9uSDB1ZWhVRXNudGpHdU9mTFJFRjd6MDVPdStuTnc0NU5a?=
 =?utf-8?B?VXpRVGdCaUVSU1QrOXd6ME1SZnZyTkRnUjVJbUV6WDh2aDJicWhKaVllRTM5?=
 =?utf-8?B?dVZPYkFUV09NUnR6Wi9WQ3ZoNlU3NmluTUhKYmxiZVNGN0NYY3RESFpwVDN4?=
 =?utf-8?B?WXZDK1hnM2dQNTRTQUp3NjA5SWRGNWM1aVpuU21PbytOS1RzQTlZL2cvVEFB?=
 =?utf-8?B?Q3ozVVl2NlQ0UUh1TENCSlRaenBmL1dLRDVKaEcxVzdZYjMrWmhmMDhaQ3By?=
 =?utf-8?B?Smh6K3laajVqK0wrcEcwTDVFR2VqdHlveEl4RkZOR2FUaE0xMXRvUDN5OXhu?=
 =?utf-8?B?aXIxY1Y0aU0wdW1wWklQekVRY09aNjllZjRQOEVob0MzazNZWFRodDhFMHV2?=
 =?utf-8?B?OGZnbFZKUmRjcUZhYThLZlQ2MXdBL05iUnVrdk1qaG5MaENoZ0tYOTRGMGY5?=
 =?utf-8?B?SzVubDlQVVl3K20rWmkycnpyVVJIQXZBcng5VHFWbWxCWkVLU3BvbDd0NDZl?=
 =?utf-8?B?T0FubmZjN2NFcDlDNTh6YUQ2Qm5zWC8xR2FZYWlDVXRjY1hmVGkxMUNwbnhH?=
 =?utf-8?B?b05xSVFud3dMMElWbFJQdGQvWnlaTWpFK29pV1pGZjBkUWg5Uk9ycHRuSGZI?=
 =?utf-8?B?NkM2RUV5N2NPczFjSlZHc3FCUm5zcktvelZLVGpQUXkwaUZ5b294ZC9qanFv?=
 =?utf-8?B?WVVjS3RHL1dxL3lOY25MV212a3g3ZFJXQTBLeFV5Ylh2Rng0YXdvMmpFd21M?=
 =?utf-8?B?d2hld29iaUEza0p2aHUvQi9OeXJLS3pKUm5lYngyeVVGa281N0dEZ1BYSzNr?=
 =?utf-8?B?ZS8vY29BNEZJVlpLQ2JsYTZnNmJLZS8xK1lVRmRRNy9ScWN0RFowN3IzY1NE?=
 =?utf-8?B?Nys0cE53dWtGVEJaVDNSQi9RaTJjaVBrSVZqemMrdWE5bmJKTUFFdkc1d2lo?=
 =?utf-8?B?RjV1TmFPWi96VFI0bTNBMlNuU2d0dG04L056aDhNTzhDQjMrVk5QRjhBVnZI?=
 =?utf-8?B?eWhlRjFlVlZNVDZGWGI2b0pMYVZFYVEwTnhiNjdTYTM5WTB2V3U2Q1c5NGFa?=
 =?utf-8?B?eGRRZmtzMWNDSHFORCtHY1lmN1hxR29ZbnJnOXVvS1U5MDBvRHNreldqQWxV?=
 =?utf-8?B?NDJjY3BRUTBjRWtBRExhR3lrQjRaaEdWYU9Td01JNHFRY3ZTQmdOcWRJSjQz?=
 =?utf-8?B?bkRwOFp0VlI0N1VmaFVnYXo3NzA1NEtldjRzKzlBL3RCVVRub01TMkdGTWJX?=
 =?utf-8?B?N3VSdXA0dXZIbkNyWmJ4NVJzRTNOQkE3NXlUU0dYVjc4bVFKenU5Y3E2QjJz?=
 =?utf-8?B?ZDV3RFFtakRkN05QZXEzY0Q3MnVRV3VHMTBPQjNsT3ZTbjA1L3IrR242QWQz?=
 =?utf-8?B?R2NBUUlFTW9tVHdhS2hscXY1MkR6RldOMCtRV0o2MUh0dld5ZlArTVNwcnE3?=
 =?utf-8?B?c1FHY3lNOHN1bW5iUjBDOHRoVUxRdk5KMERsd004aEt0ZGhDRVMydHE0bGVt?=
 =?utf-8?B?OEhZN2h1OTZ4eGJMY1p4VXBnUVpwKzF2MlFmTEFiY1Z4cHF4c2xBVTVHNnJ2?=
 =?utf-8?B?MkJWbGVCd1J3aFpDQjBJaFhJbk9QSHZjU3REWUhnZS96NEp5OEppMlBkOHdV?=
 =?utf-8?B?bHY4Vm9nbmwzRFJ0Yi9MZmJjUTU3RlEydllrSVlQVVpRZWUzY2pXYUc3WWlF?=
 =?utf-8?B?ZmY5MlZjNG9RTDJsMFowRVhTK2RyeFJRQWwwWnhma1dFZXp4cU9yS2RYYlh4?=
 =?utf-8?B?a3VwcTN2TjhKMjRuSXhjRzh5K0QySXF2S0RZV3IwdTdXODVlWnFMM2ozWTJD?=
 =?utf-8?B?eitya3J0aGhOZ2lCcHpJMUpVZXovSGtwbm5tSUlUdzUxUm9yb3ljMVJrWDcz?=
 =?utf-8?B?MC8wTFlFK0hkV1JiSllyQ2Q0T2lrWjFPWnlma21mM3pUcjBFOWZva1JyYmdS?=
 =?utf-8?B?ZnoxcS9hb0diMDA2WWI5WWZRcUdWWjF0V1gyWnFxRHVmeGtFNHBFSmFrZEd4?=
 =?utf-8?B?MmNYU2N4WWZ1MitJbmlZd2dzSVVacmFsbUZRNFlZRUpic0l6RGpYY0xtRFg5?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f18737-6175-4617-bed8-08da6b033d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 10:24:48.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JCBgZakKfdvUoXAbXQpxKefcUJM6yMsSARt1jQLeq2VoRVDkagP/P9LN10sZBk71yJdOSVredU9yNS3MpMEI9UYsrRh2RLvIDmFOnR5LHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3819
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi8yXSBzcGk6IHNwaS1yc3BpOiBBZGQgbmVlZF9kbWFyX2NsciB0byBzcGlfb3Bz
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVHVlLCBKdWwgMTksIDIwMjIgYXQgNTowMCBQTSBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IFJTUEkg
SVAgb24gUlove0EsIEcyTH0gU29DJ3MgaGFzIHRoZSBzYW1lIHNpZ25hbCBmb3IgYm90aCBpbnRl
cnJ1cHQNCj4gPiBhbmQgRE1BIHRyYW5zZmVyIHJlcXVlc3QuIFNldHRpbmcgRE1BUlMgcmVnaXN0
ZXIgZm9yIERNQSB0cmFuc2Zlcg0KPiA+IG1ha2VzIHRoZSBzaWduYWwgdG8gd29yayBhcyBhIERN
QSB0cmFuc2ZlciByZXF1ZXN0IHNpZ25hbCBhbmQNCj4gPiBzdWJzZXF1ZW50IGludGVycnVwdCBy
ZXF1ZXN0cyB0byB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgYXJlIG1hc2tlZC4NCj4gPg0KPiA+
IEN1cnJlbnRseSwgRE1BIHRvIGludGVycnVwdCBtb2RlIHN3aXRjaGluZyBkb2VzIG5vdCB3b3Jr
IGJlY2F1c2Ugb2YNCj4gPiB0aGlzIG1hc2tpbmcuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMg
bmVlZF9kbWFyX2NsciBkZXZpY2UgY29uZmlndXJhdGlvbiBmbGFnIHRvIHNwaV9vcHMgYW5kDQo+
ID4gaXQgbWFrZXMgdGhlIHNpZ25hbCB0byB3b3JrIGFzIGFuIGludGVycnVwdCByZXF1ZXN0IGJ5
IGNsZWFyaW5nIERNQVJTDQo+ID4gYWZ0ZXIgRE1BIGNhbGxiYWNrLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0K
PiA+IHYxLT52MjoNCj4gPiAgKiBGaXhlZCB0aGUgdHlwbyBuZWVkX2RtYXJfY2xyLT5yc3BpLT5v
cHMtPm5lZWRfZG1hcl9jbHIuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+
IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1yc3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGkt
cnNwaS5jDQo+ID4gQEAgLTI0OSw2ICsyNDksNyBAQCBzdHJ1Y3Qgc3BpX29wcyB7DQo+ID4gICAg
ICAgICB1MTYgZmxhZ3M7DQo+ID4gICAgICAgICB1MTYgZmlmb19zaXplOw0KPiA+ICAgICAgICAg
dTggbnVtX2h3X3NzOw0KPiA+ICsgICAgICAgYm9vbCBuZWVkX2RtYXJfY2xyOw0KPiANCj4gRG8g
eW91IG5lZWQgdGhpcyBmbGFnPyBTZWUgYmVsb3cuDQoNCk9rLg0KDQo+IA0KPiA+ICB9Ow0KPiA+
DQo+ID4gIHN0YXRpYyB2b2lkIHJzcGlfc2V0X3JhdGUoc3RydWN0IHJzcGlfZGF0YSAqcnNwaSkg
QEAgLTYxMyw2ICs2MTQsMTINCj4gPiBAQCBzdGF0aWMgaW50IHJzcGlfZG1hX3RyYW5zZmVyKHN0
cnVjdCByc3BpX2RhdGEgKnJzcGksIHN0cnVjdA0KPiBzZ190YWJsZSAqdHgsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByc3BpLT5kbWFfY2FsbGJh
Y2tlZCwNCj4gSFopOw0KPiA+ICAgICAgICAgaWYgKHJldCA+IDAgJiYgcnNwaS0+ZG1hX2NhbGxi
YWNrZWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gPiArICAgICAgICAgICAg
ICAgaWYgKHJzcGktPm9wcy0+bmVlZF9kbWFyX2Nscikgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmICh0eCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYWVu
Z2luZV9zeW5jaHJvbml6ZShyc3BpLT5jdGxyLQ0KPiA+ZG1hX3R4KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAocngpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkbWFlbmdpbmVfc3luY2hyb25pemUocnNwaS0+Y3Rsci0NCj4gPmRtYV9yeCk7DQo+ID4gKyAg
ICAgICAgICAgICAgIH0NCj4gDQo+IFdoeSBub3QgY2FsbCBpdCB1bmNvbmRpdGlvbmFsbHk/DQo+
IElmIHRoZSBETUFDIGRyaXZlciBkb2VzIG5vdCBwcm92aWRlIGEgLmRldmljZV9zeW5jaHJvbml6
ZSgpLCBpdCBpcyBhIG5vLQ0KPiBvcCBhbnl3YXkuDQoNCk9LLCBjdXJyZW50bHkgcmNhciBoYXMg
dGhpcyBjYWxsYmFjayBhbmQgaXQgY2FsbHMgc3luY2hyb25pemVfaXJxKCk7DQpTbyBJIGd1ZXNz
IGl0IHNob3VsZCBiZSBvayBhcyB3ZSBhcmUgY2FsbGluZyB0aGlzIGFmdGVyIHdhaXRfZXZlbnQN
ClN5bmNocm9uaXphdGlvbiB3aXRoIERNQSBjYWxsYmFjay4NCg0KPiANCj4gQlRXLCBJIGRvbid0
IHRoaW5rIHRoZXJlIGlzIGEgaGFyZCBkZXBlbmRlbmN5IG9uIHBhdGNoIDEvMiwgc28gSSB0aGlu
aw0KPiB0aGlzIHBhdGNoIGNhbiBnbyBpbiB0aHJvdWdoIHRoZSBTUEkgdHJlZS4NCg0KT0suDQoN
CkNoZWVycywNCkJpanUNCg0KPiANCj4gPiAgICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAg
ICAgICAgIGlmICghcmV0KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigm
cnNwaS0+Y3Rsci0+ZGV2LCAiRE1BIHRpbWVvdXRcbiIpOw0KPiANCj4gR3J7b2V0amUsZWV0aW5n
fXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBn
ZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMg
d2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBCdXQgd2hl
biBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBz
b21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzDQo=
