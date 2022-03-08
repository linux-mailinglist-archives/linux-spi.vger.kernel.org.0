Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53364D1147
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 08:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbiCHHtC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 02:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCHHtB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 02:49:01 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B02459F;
        Mon,  7 Mar 2022 23:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk/Lnv1l4c02EWkhMxN1jg+UkrMJIL5Fp6Abk85pZEh+GBOHgTu/1/HZGK1l+dnWum2Ka+B1faxe+iMpAOiKHgb3tEGe2S4kcg5q9vY43gEPMCsG/KcdcKYVB016fLjkg+G9qpHNO2p83U1xJH0BiPvobjwxExkudsx+yVHSe2U3JCLdJ2Eoz/B8+uGbHU85+gtG3zTJiswr+Ym/BF8ELDJtYoHWhBHrgkE3SNgCc8sGrcB903ZZ8iuvODIowpo0lI21NaHnk2UPfKTWDRWF34PzEKCdB01jQ9vJtfjCcQmYUEEFR5IkY8GX95A3+29A33Z4b+e2+idiltpdou9yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqB739/GFfycVC5/oyltTXrHA08RbBcM3AZ1iV4U2E4=;
 b=CJjmQ3S7kw8KKBd9VwbF5eSR/u0l7SUclDIQ2czmZYh6AECZW818HRoIcaICBYJZI7Qy27QbZGxqyso1lWG9lSx0SFshnDlgRNL/IHlhwyXYW5ACbKoTBITU2WZI6ouXsJJfta8Om3Kw8yzkROi+Wqqc0doproYwb4gpydh9BnnLzsWYdQW9LEzm93o5MrsaBhrHleAZQD47BzsaYvyjPMw0dGwfVZvboq1ir0hlBjUOtUmSKLleUV0axmmmEOi3v6yam2aBpiTibulljmV7Dvu2jSeSD7OxmCPUaX6ZQC1tOup98OkmFBcDzoacgJeOydDY2oRHqgmfTViwd0ZrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqB739/GFfycVC5/oyltTXrHA08RbBcM3AZ1iV4U2E4=;
 b=j2p8Sx86kKhLCxWt3TnOQAZMmh1AaOwDbWRLdbDjhCx6+vavCl+cmNJVy0Lvlhv9EiJrWgCsHOK25syovbxbtJI/n02BY68RcVSnAFwu96WzJSMBhgDZRRS7KQ2X3yoVpQ9HjvBrKjZobo8oC6tA/2AOJZtZqanj8J1zlCDw3WA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB3890.jpnprd01.prod.outlook.com (2603:1096:604:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 07:48:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%4]) with mapi id 15.20.5038.023; Tue, 8 Mar 2022
 07:48:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: Fix invalid sgs value
Thread-Topic: [PATCH] spi: Fix invalid sgs value
Thread-Index: AQHYMk1bt5E5wl7NDk+Lte/agSpjXqy0N7sAgAACUqCAAOG0AIAAAQwA
Date:   Tue, 8 Mar 2022 07:48:03 +0000
Message-ID: <OS0PR01MB5922A976F1247AE38FA73B9586099@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
 <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWmvPnxyeJsVRdZdvxiFbt455us4ded9B30b01TLN3sQQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWmvPnxyeJsVRdZdvxiFbt455us4ded9B30b01TLN3sQQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c583de2-15a5-4a32-6d8e-08da00d7f99a
x-ms-traffictypediagnostic: OSAPR01MB3890:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3890E87A1C66AC9D863AB26786099@OSAPR01MB3890.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dS6uNBBAhb1E57FBxTfQ1URfWUobcAJLHXBrODVMyYVBat+GnPgOJ2aFvAQjeXEBUnVLLRE0at4B98b1xdRJsQ5pyl7Cgr7kdrRiAtyserMFp2P4Vnueill0bnX67bxo6xi7lsKKAny0sf5GYBUVEZyJAaK89U4jGx6O3Va2fdtkou0cvqYmF61dMBoL2+tSe/6UMgzlN/FmlGfsUYna/qCwOwd96RBPEm1wATHkqx3QoF8HUjNVXgXxbGc9g7c2AsM/AT/7J9piC4ABteshoh6uexzXwiwSlcZf9aJTDU0YT0L6bfmChr6gRcd06sd9BY2QcCQIsWKBzbMBduOoW56ouk2onsoAUyFGPdxezaSuPctw1Ot9drLXawbNxnECYZSGRzziDssRJb4TZI04e3zTHYamIU4zj6dUrN31JkyLAdz48AIEXcQbBvIjw7vkePn4KABNjoGDfhGhyMQ4Ni9d4A0i2oHpSctXiQIMxC0vgwbNS6TDjS//pRhOpWxhNNaXnVscLBF6Biqd4vfalvB0YjrLJngOLSuHWFD7jHz0RMvee1au5c4+wKha+JmgafXReuqgXygw4++fLBenso/K9UQji730xaiP5Jsimun54UVmzI+ccuKzkZHtmuElVgO+/RoFjYzRApF3seChMS7wA8srpo2mNFmCUM3ru3Jzr+WyOJkSsvG1zAP+/EkXx5dTS9ZskxcE1qszPVxJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(86362001)(53546011)(26005)(55016003)(71200400001)(7696005)(9686003)(6506007)(2906002)(4326008)(5660300002)(52536014)(66476007)(76116006)(33656002)(66556008)(8676002)(64756008)(66446008)(66946007)(38100700002)(54906003)(122000001)(316002)(8936002)(6916009)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3gxSjBZak5oQUFMVGVMVzdKZ1A0SURiZDMvem5GbkhqRytRMFQ0MVRocmli?=
 =?utf-8?B?dHQwdmM0ejlhOGJoSHp4eXRPenBpSW9XNzZUb2o1K3gvRHZUeDJRODdRdTcy?=
 =?utf-8?B?ekRWWmY4VTQ2SUNLU0tvaDBSU1lpV2ttNFppRndvZjBwd3cyc1FEamJWU1hy?=
 =?utf-8?B?bVRpbXcxbU1OU0RPYmpFZGh2QnhGSktETVdSdFRuYU80MXA1WkZkczV4UVdF?=
 =?utf-8?B?UG42NE94Vm1XaFplYjRldmxFNkhpa1ludlU4RnM2dklIRVZhdk00Yzdsbnor?=
 =?utf-8?B?QTJKVFNpcFFPWDQ3SU1HbEk3cmRQZVVUNXhTaEs5VHh0WlUyRmNaaytGTTVX?=
 =?utf-8?B?MjJPN1VKTW01Z3lmeDAyRHJSejhsQmFUb2ZhaDdkQ0c5YnI4NXFVSWh5VXhM?=
 =?utf-8?B?QnlsRU1XK05GL3I4c3BCMGhmbDFhMDFEbjZMMEFxNmFwY051L09UWFU1UWZh?=
 =?utf-8?B?RnZNb3NmTEhsQmw3d20xNTc0N1I3dEZhaDMrRXBWV2tUMUxhVUJ3MEptMnEz?=
 =?utf-8?B?N0QyeDlIdXdXdWwvSWJkV0Jqdm9jdjU2RGJSUUw2QmNDTDUyT2Q5YzBub3FJ?=
 =?utf-8?B?UmRyZ1FiTXZlVjkyNGxNTWVma3Bla1pwK1FMdEtHNi9TRjFxWGFhMXVHUlMy?=
 =?utf-8?B?cUJHaytkVmducDdOaHBYdHU0ZnNiRFhrMnlWeXlIUEc4TXJWUjRTTStiUFVC?=
 =?utf-8?B?QkV3NFVIYTR1WTNqMlgrQUVHMWhJNktRR2NjMjB2VEpFVDNqeXU1VkNaUk9C?=
 =?utf-8?B?RkRzT1I2aTM2d1JhK1QybDhybkdWQWNWSEpERlZrdGpRdDlQMSt2Z3RlclVo?=
 =?utf-8?B?c1lJeTRWNjRTamt5U1dibUpRUXB5bXorMWhBM3F0OSs5Q1FBdVRWMXNlcXVu?=
 =?utf-8?B?M3QvbWdjeGM1dnMzLzEyUjBJNWV2d1RqcEcyNEowS1l0SUg2Z2dNN2FaSlRK?=
 =?utf-8?B?YWpLbi9GK0FzU0FCdXBqR2V3RkoybGF1Mmx3SkZuMG1JZkZaT05Wczkzc3RS?=
 =?utf-8?B?N0dQRExBTXhtdmlkQTkyWHBjYWMyZmVma0EvTUNMcEEwVEtYWmJDYjVtUTJF?=
 =?utf-8?B?ZDNUYXdaVXdPWjB6ajcwU3MraFEyNGVCYnBFVlRONVpSOVFrMEJCNVJjOXNt?=
 =?utf-8?B?Q3BNVDdtdi9IeUJJYzZ4cWZHc3lUeXVGNTYyOVhMVmVqMjlJZXlaZVJNRCt0?=
 =?utf-8?B?S1ZXSGV0ZmhlMzhvTlU1YWR4elB6dW1RRE8vdUE4YzVYVmZGRGpzRGpNT0hv?=
 =?utf-8?B?eExNR2tleVF1emFjV1pZaWNKWW9wQURqdlpsQlVQT05DaFJ3UGNwdUwzTDVN?=
 =?utf-8?B?aGh2VGlRVVUvVnNRZis1eGZJYlRVWC8yTTJjTTg4WG1vcDFTM2NXNGVvNDFk?=
 =?utf-8?B?c2xEbUZYOFNMUzk0ZjhXbjN3Q0N4VmppSHBSY2FPK3MreC9IZE40b0dUOUV4?=
 =?utf-8?B?TmNHQld2bHMxNEFWaVlqRFhjeHNNMXhpY0xEek9jcDNuNDNvSlp5WlNoVFlE?=
 =?utf-8?B?OVl5cjBweWJDbDVHWWJ4Z2NmU3krRVFCRDBGeWo3bGpkaElrRFRZUkFUVm1R?=
 =?utf-8?B?NUFVN2hkZEFRdVBIYlpSSWdwaEs4OGJQOEpsNFlSaEJ3RVFnc3d0MWF2S2Ro?=
 =?utf-8?B?bzZOY3VHb2FsVUlTRGc4QWZqVjhLVGozTk5pbyttMXdWYXlNeHFiMTRTSVlS?=
 =?utf-8?B?NHlraWZDcCtTTkNTcy9nV2tiRDFoanV0YlUxN1dTODFIYVNJV21aQTI2ZElP?=
 =?utf-8?B?TWJaTkR5WHdFYU1oL1Nvak1LdUFvTVdvSUhDL2RZNGhmeDd4VTJLS1RmMzk5?=
 =?utf-8?B?MFBreXRzcHVBT1NJMXdFbFgyUHBSaXFRUEUxblVPRkZQbVVxNE9mSFl5RytH?=
 =?utf-8?B?K1VQYWcxZGtqQ1J4cDdmWnBBdnNRR0t5M2E1UHV2cUgyU3hCZjBjcnpRbXlF?=
 =?utf-8?B?K2tqOG45SVdGVi9neXE4bDhaN01hZGl0QUczVjRrR2k3ZzZySU1RLzVTZko2?=
 =?utf-8?B?Sndad0NFQzlOemxRMVgyb1V1ZkVad2NtTUxPa2tjejdROXRyeE45THBINUg2?=
 =?utf-8?B?b2d3WGZwWTEwTXI1SjlBUVhHNzBtOVp5bUd0bEFkR1lrTXVOMHY2UGJySE9u?=
 =?utf-8?B?RXNWZ2JxR3YwdDJNcG41b3oxemVxZWtwNHV2bXhkYjFlMjFrUTR1VGxSWXcz?=
 =?utf-8?B?L2k0cjVyblp1VkpjYWdISy9IVC92VTBndGJMdUJxTy9JYUZ4VFUvdXAyVjB6?=
 =?utf-8?B?N25kdCtwcFFVeExSRGhsSmw4OXFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c583de2-15a5-4a32-6d8e-08da00d7f99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 07:48:03.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzGZxa0m1/4QGxJKSTb3rjOov8ai9mureWjVumeh0L8F53y8hAyvezs4IZw/AQnVX6fafgM+tXgKK1DALw2W14XP5QR3lBUEP+1jwNzKDtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3890
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3BpOiBGaXggaW52YWxpZCBzZ3Mg
dmFsdWUNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBNb24sIE1hciA3LCAyMDIyIGF0IDc6MTcg
UE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNwaTogRml4IGludmFsaWQgc2dzIHZhbHVlIE9uIE1vbiwg
TWFyIDcsIDIwMjINCj4gPiA+IGF0IDc6MDEgUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IG1heF9zZWdfc2l6ZSBpcyB1bnNpZ25l
ZCBpbnQgYW5kIGl0IGNhbiBoYXZlIGEgdmFsdWUgdXAgdG8gMl4zMg0KPiA+ID4gPiAoZm9yIGVn
Oi1SWl9ETUFDIGRyaXZlciBzZXRzIGRtYV9zZXRfbWF4X3NlZ19zaXplIGFzIFUzMl9NQVgpIFdo
ZW4NCj4gPiA+ID4gdGhpcyB2YWx1ZSBpcyB1c2VkIGluIG1pbl90KCkgYXMgYW4gaW50ZWdlciB0
eXBlLCBpdCBiZWNvbWVzDQo+ID4gPiA+IC0xIGFuZCB0aGUgdmFsdWUgb2Ygc2dzIGJlY29tZXMg
MC4NCj4gPiA+ID4NCj4gPiA+ID4gRml4IHRoaXMgaXNzdWUgYnkgcmVwbGFjaW5nIHRoZSAnaW50
JyBkYXRhIHR5cGUgd2l0aCAndW5zaWduZWQgaW50Jw0KPiA+ID4gPiBpbiBtaW5fdCgpLg0KPiA+
ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA+IDxw
cmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gVGhh
bmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4NCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLmMNCj4gPiA+ID4gQEAgLTEwMTksMTAg
KzEwMTksMTAgQEAgaW50IHNwaV9tYXBfYnVmKHN0cnVjdCBzcGlfY29udHJvbGxlcg0KPiA+ID4g
PiAqY3RsciwNCj4gPiA+IHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+ID4gICAgICAgICBpbnQg
aSwgcmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIGlmICh2bWFsbG9jZWRfYnVmIHx8IGtt
YXBfYnVmKSB7DQo+ID4gPiA+IC0gICAgICAgICAgICAgICBkZXNjX2xlbiA9IG1pbl90KGludCwg
bWF4X3NlZ19zaXplLCBQQUdFX1NJWkUpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgZGVzY19s
ZW4gPSBtaW5fdCh1bnNpZ25lZCBpbnQsIG1heF9zZWdfc2l6ZSwNCj4gPiA+ID4gKyBQQUdFX1NJ
WkUpOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgc2dzID0gRElWX1JPVU5EX1VQKGxlbiArIG9m
ZnNldF9pbl9wYWdlKGJ1ZiksDQo+IGRlc2NfbGVuKTsNCj4gPiA+ID4gICAgICAgICB9IGVsc2Ug
aWYgKHZpcnRfYWRkcl92YWxpZChidWYpKSB7DQo+ID4gPiA+IC0gICAgICAgICAgICAgICBkZXNj
X2xlbiA9IG1pbl90KGludCwgbWF4X3NlZ19zaXplLCBjdGxyLQ0KPiA+bWF4X2RtYV9sZW4pOw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgZGVzY19sZW4gPSBtaW5fdCh1bnNpZ25lZCBpbnQsIG1h
eF9zZWdfc2l6ZSwNCj4gPiA+ID4gKyAodW5zaWduZWQgaW50KWN0bHItPm1heF9kbWFfbGVuKTsN
Cj4gPiA+DQo+ID4gPiBUaGUgY2FzdCBvZiB0aGUgbGFzdCBwYXJhbWV0ZXIgaXMgbm90IG5lZWRl
ZC4NCj4gPg0KPiA+IE9LLiBJIHRob3VnaHQgc2luY2UgbGFzdCBwYXJhbSBpcyBzaXplX3QsIGNh
c3RpbmcgaXMgcmVxdWlyZWQuDQo+IA0KPiBUaGF0J3MgZXhhY3RseSB3aGF0IG1pbl90KCkgZG9l
cywgYnV0IHVzaW5nIGFuIGVhc2llci10by1ncmVwLWZvcg0KPiBub3RhdGlvbjoNCj4gIm1pbl90
KHR5cGUsIGEsIGIpIiBpcyBlcXVpdmFsZW50IHRvICJtaW4oKHR5cGUpYSwgKHR5cGUpYikiLg0K
DQpUaGFua3MgZm9yIGNsYXJpZmljYXRpb24uDQoNCkNoZWVycywNCkJpanUNCg==
