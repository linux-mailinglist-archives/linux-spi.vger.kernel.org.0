Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD326B84CD
	for <lists+linux-spi@lfdr.de>; Mon, 13 Mar 2023 23:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMWdR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Mar 2023 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCMWdQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Mar 2023 18:33:16 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2043.outbound.protection.outlook.com [40.107.12.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4B19F1D
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 15:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9FyMa9rKnO2PhzOPMVfNdzJG165u70KOoimNvv3H/Jslj39zqYIXQUxKOiSsSmYftWpicrtKM/YcBWO81VeMBy0dJ2LL2a1RDYv98gNjmXWq9kHS8LCQZtT3AueJZguqndOMQzolcIDBdnjene8DlDdpKE85nleZY/9/sSuomhciqadIQ4W0Kq1K0O2+VnvvbacbxO/fqU7K4ItrmsAvMbKeQ+JsO6K//OEI8TwBfFUFHLPbsYhFmGxO4f0SxEkXvKYiVeeXjvzEGE5qTaXH4FmF+Gw6xxJQDkVDM+n72ejpiFYeSryl9CYVDXLTt+GjDAc9qu/f7b2O17K4o7iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru5dJ5/t7wHMpyahFlN8GpzsQOXpqab0kA+jz1hKEB0=;
 b=LET85VPlvZRHOuN0pb7jD4AXxHPvKxIoy8o7obH2JWX0KyBWgTJ3eDvkOGNQbOZDs0dxdcczzPVIk4Titx+2gEYEFlRqSmP5jpNxXbhsoCeIvkJd5tPa9YNrHfd6Z2V9TWAranhrAUMpv68eVPddsD6EE+PZDfNg8iiWUqMCOGEaAaTZAmJ8cn6h/jxUXggVB7mIFjYUtHhwOFadXJAQoJW7/gcO9c/JHV8ewURNWWhppkQpKwtxQ5sqmPrzFm2t8M0ruo4Jt6ggd0VhjEA5tW4HBwss0BxbkLiq3/Je0ZAXgWiHywkfd9xxHlCoc5WufJUPHRpNQ/5GMrWe0wBMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru5dJ5/t7wHMpyahFlN8GpzsQOXpqab0kA+jz1hKEB0=;
 b=NuJsxskKyEbXy6b17CbzRuZzUnZVZwcr/k6faUQ5zvQ4z/Fl24Cy6cnNY23WLCBAJLTHepffnbTBQwi1uhcg0CL/4rEs1I86V/rQfaFx/IixJnSTTq9w/LcymnDzODLZ/hVXpZUL7Aw9KdpQPW8PlyTnUqmze3P7Ndv9xHlNY/DEcH8NbUa28lGCMbx36TQUZ0GShOAavhS2ooTp23CH5mqPxSVHi+aU1MF5Vvp7KE/jaVuFF8Tja9nZjw+3jULyT3sdvnpg49N3AU97eq39PZ+h4ua98CESulOiejt1tes4Fb49lRUWI8OKKjrzLvvVgnPOv/vTxGrK1oluZl4giw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3116.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Mon, 13 Mar
 2023 22:33:11 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:33:10 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Topic: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Index: AQHZUSGn3z/bFjp5CkqfEb9Cr4ssTa7vpOwAgAAHYACAAATLgIAABuMAgAAYQQCAAAhIgIAACh8AgAlyrgA=
Date:   Mon, 13 Mar 2023 22:33:10 +0000
Message-ID: <69b1b437-1e8c-1854-a036-5cbc8a81cbab@csgroup.eu>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
 <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
 <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
 <4c46ffe5-6793-4149-998d-d76c37fca7aa@sirena.org.uk>
In-Reply-To: <4c46ffe5-6793-4149-998d-d76c37fca7aa@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3116:EE_
x-ms-office365-filtering-correlation-id: f836b9c6-69d2-428d-2291-08db2412ed25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtTy/BomPeiPFgx0NE7gGyCribhgK73vI0jRk3h1OtDOmf6WUrWDU7Vg55s9wDCYUPDdnT5XAelpHX1vFmw7Ue5lRGj1ygX2CrLRprQYmNkXGfB62tETILb/uMRRAFyaYWGGtFPJxUN8Ump038tFs83nYZc4nLLlNt45DaRA31+tWrIBPGerFRdL004eh5E2BhQJ2VJXuLVGXHRRclUnw+LhDZcptG63hOOTkXtZddFQNltSzjlQ2piKKqNUrgPzE80Kk1ecocWpYQjcQgBXWZ5wO9pBmuPZ9kn8d1p08VGas3qItPlSQVFeFxans9LZzBQWqAevQ24e+/fdf1oIWuyMBUERqZut91UYUtH/VaztFdm9EMot3xSJCmAtmpI0vQiV9y4FJhJEy1Oc0QbK0/ByuHKpd9fUF7XPQVPvsm9A2qLJlEYboBOdCX8pKCrobDBSOjvJnF/oKXlJcxFzZIiRhZJw2pDeXZ69zvVjJd9eLjG3uRtGsHnVLGGgFypExU0975tX2/FM3nxSXy0Po2ahy8nlFEWJWjkZxWH+mAMEIR4kaqwcwbEwtCGhgoMznYUNjxiA7hlFpHB0RTUIa/AzIQXLyZK9JsdiZOEtCE1Z05xU4sTBp0fVdn5qcaTarZLU18cmIPEKNsonw473kVNiBG4M5u/UPJpm3r9Z94T/qbVT5pISsZc31PBOaqYNFPXUryj2ZwhvVx8beJilJRbMsuEcLtgOYsfJBfsE1UP8qk5fQvpmUDH+K85ZzrnrYkueyCSTLHeYO1bOr4SMgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199018)(66574015)(86362001)(31696002)(478600001)(5660300002)(71200400001)(2616005)(36756003)(6486002)(2906002)(186003)(26005)(6512007)(6506007)(44832011)(41300700001)(38100700002)(91956017)(122000001)(4326008)(6916009)(31686004)(66476007)(66946007)(66556008)(66446008)(64756008)(76116006)(8676002)(83380400001)(8936002)(38070700005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdFd2JKUUhNcVMrUGQ2RjYyZUNVT0QzTUZPdDZGUnRkUUJzayt4Q2JuM1Iw?=
 =?utf-8?B?R3pWM1UvYVZ0aU9BZVZiUHRjK0wrOThpZDRmRXFxWlV4dGp6OFdPajRLYjRq?=
 =?utf-8?B?YVh0QlFDYisrWG1EZ2QvT3kvbCtiRnNDRCtIRUprQ0tjelpxd1B0ek0za2pk?=
 =?utf-8?B?RDZLVXRRQWZKUm9oV2xTaUlURm8vNTZwdEo2QlQ2ckpNYStFeXUxZFN6VGpY?=
 =?utf-8?B?MnpSQVRCeEJTZ0U0b1F0TVVoeVBsSTZQYi96Tm1sc1dJcHNpTXcyVStOdHE0?=
 =?utf-8?B?VDN4VVg1RW04VVJNWG1vSlNHdGpwWm05Z0lBY0VTZUlobzhDS1F2N0lBK2xB?=
 =?utf-8?B?VitrUFBFdTNSQjdHV1JHUnR0YTlmWXFBRXh1a0syWVh2VDROWjhNcVRGZ3VV?=
 =?utf-8?B?Q3Fuak1WUVFvUFRPamJHNkhqWEsrWmNSU3h4amdqQVRDaEc4YVk4M29Oam9Q?=
 =?utf-8?B?K1h4Vm4yNnd3U1hsUGZraXpHS0xvdFB0eElBWFZWakRkYzVtc3crT0tzTVZa?=
 =?utf-8?B?Y3NpeWcvYis5SzdqcEpsOVdxOVdsS0FqMVdmT1Q3M0RFQk14Slhzc3ltSlJ2?=
 =?utf-8?B?czUvODVqbW54b0VSREI1UjViN2NCaXlJdlRCZk5iN3I0R25WbFFlSmNhYWEx?=
 =?utf-8?B?b2NHclE4VFBSRHN4a3Z0czdqNHZFRHZNSUwvYVUzVUtqa2pkNnhyVlBDaFJ3?=
 =?utf-8?B?TGFVZEhmbndGbjFoUFduTnczUzA3b21qNmR1bkFGMXV4cFo4VFBQZDViRlV6?=
 =?utf-8?B?YTBNNlBxTXZ3Uk1uSisxWStsQXhGdk9odzdFLytSenk3WUF5MDJ2NHJQaUc3?=
 =?utf-8?B?RkhqdERFcFd2Q3lTZ1ozdGxoSEl5OVpMZWdOWXhaYjhPWFAvZUFvV0tRc1hq?=
 =?utf-8?B?cFB3citKRE04OGY2cTdnUVE0Qk04VnFjeUQxN2VPNnZFNUZleE1WOHBRSkp6?=
 =?utf-8?B?WlczK3J3dmlDU2lZSXhRUWdQeVFMS3Q1QzNCdGhKR0pyZ0ZqSk02RFFjUFhK?=
 =?utf-8?B?T1JLV1lLbTZXWks1ejNSNHNaWkxPMnRsVTYyM2QvKzJXUWpIQnU4VTVFb1ps?=
 =?utf-8?B?Y2JmQU0zUkZwdmw2YjljNkZMOFg1aUIyQ3UvNW9UTWh1ZlFTaHNHSHFVM2dR?=
 =?utf-8?B?WUR3aXN6OWRpVnVoYzlMOGhtLzluUXpNOGUrWU9Ga1ZtbGtHNGJyeExVa2Fx?=
 =?utf-8?B?OTlOZm96SlZLR3UrRkQzTXVibHhnVW9lK1AyNXpNKytOK3F3aXoxY0VlZVpG?=
 =?utf-8?B?aGJRM01vV2lmeFVpSE42NjJOd2N3QTRaU3gyZ0RHQXF2Q1g5WlhIb1ByL25C?=
 =?utf-8?B?UkdMNDJ0Smo0azFKMGVIWkh1aDFQNlJFa00zK2xXUm12S0d0cUh0Y2xWaVc3?=
 =?utf-8?B?aVg2aXRvQ3phQlljNFpDemNqRGxPeUNPWkI1WWRoZWZrSVNlQ040UFBvd0VR?=
 =?utf-8?B?MHl6TUNoS1ZXQmJ4MFRSUFpWTjUwVFBxQkl6OCs4SGZNaVlrVnYyVnVlQTU0?=
 =?utf-8?B?WDNiRDhWbTVZL3Job2ZYWU5DaWdtUHhqcHFVeEx2Tk5uczAwOWhtYytETnNl?=
 =?utf-8?B?eTYwSTkyVFhUMWx3Ty9VSzJHZTlOcDVPOVVSdDgrdnBFYkpacHpYeVlLQTZl?=
 =?utf-8?B?SHNseHVON3cxbVBXeXNvaVAvN1gzZUduRFBmOEhyV1RxM3daQ0RWOVlYYUZi?=
 =?utf-8?B?SnN1c3U0WFd5NGhZWSt1RThqbE94SlpKcTlNb2xZbUhkclgyaUFNaTBZOVVx?=
 =?utf-8?B?ZVJ2bGdxZnlxYi9FejFaR0pmK2Rzb25qaEFsNVp5VzJFSWl4WjY4Zk1vUDB1?=
 =?utf-8?B?dHZBeUkwVGNpMkw2bFFRZmlibDZRMWdxWGR2VUlCRGdobHlQSUtDRlFwUDRl?=
 =?utf-8?B?ZWVzZldjdzk4Nk12ODBVa1pLTTYxZjlzeWdBdENvVDRvTnJqTWZieWRqbndR?=
 =?utf-8?B?ZktyNkRXT3BlcDhWWHhYb2l5YWJJOXhJSFEzZWtuZTBJVXJncGtqQk5CbEs3?=
 =?utf-8?B?d0xNOERCT3ZtUlc4bmtucTFvb2dxYkNldUl2aWVPQldteG1KR09vQktNYXox?=
 =?utf-8?B?cWxnalRRcGphM1lrU1RDKytpSWlnbU9yYnlMQzRSVEVITmxTMHlJdC9zbFRZ?=
 =?utf-8?B?amg0bmZqZW5PRzFGaGtEaWx0YU5TQUxNYmlsS2NTUmlJRlRvTXd5QVlvY1dm?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81330D36EE439D45A632700A65131ADF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f836b9c6-69d2-428d-2291-08db2412ed25
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 22:33:10.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1pm3BOW9P6YocWCTp0qWEcaK0ZCQ4OR4oFFeoYTjQCszBqEtzNW/tJyUOcyk1ZE4h6mQbKI8oMUw4WP9GSA3G8omp4rJnlsyPmuqc5lNhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTWFyaywNCg0KTGUgMDcvMDMvMjAyMyDDoCAyMzoxNiwgTWFyayBCcm93biBhIMOpY3JpdMKg
Og0KPiBPbiBUdWUsIE1hciAwNywgMjAyMyBhdCAwOTo0MDowOVBNICswMDAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4+ICAgICogSW4tbWVtb3J5IGRhdGEgdmFsdWVzIGFyZSBhbHdheXMg
aW4gbmF0aXZlIENQVSBieXRlIG9yZGVyLCB0cmFuc2xhdGVkDQo+Pj4gICAgKiBmcm9tIHRoZSB3
aXJlIGJ5dGUgb3JkZXIgKGJpZy1lbmRpYW4gZXhjZXB0IHdpdGggU1BJX0xTQl9GSVJTVCkuICBT
bw0KPj4+ICAgICogZm9yIGV4YW1wbGUgd2hlbiBiaXRzX3Blcl93b3JkIGlzIHNpeHRlZW4sIGJ1
ZmZlcnMgYXJlIDJOIGJ5dGVzIGxvbmcNCj4+PiAgICAqIChAbGVuID0gMk4pIGFuZCBob2xkIE4g
c2l4dGVlbiBiaXQgd29yZHMgaW4gQ1BVIGJ5dGUgb3JkZXIuDQo+IA0KPj4+IExTQl9GSVJTVCBo
YXMgb25seSBvbmUgaW4gdHJlZSB1c2VyIG90aGVyIHRoYW4gc3BpZGV2IHNvIEknZCBxdWVzdGlv
bg0KPj4+IGhvdyBvZnRlbiBpdCdzIGNvcnJlY3RseSBpbXBsZW1lbnRlZC4NCj4gDQo+PiBXZWxs
LCBvaywgSSBoYXZlIG5vIHByb2JsZW0gd2l0aCB0aGUgd2lyZSBieXRlIG9yZGVyLCBvbmx5IHdp
dGggaG93IHRoZQ0KPj4gY29udHJvbGxlciBmZXRjaGVzIHRoZSBkYXRhIGZyb20gdGhlIERNQSBi
dWZmZXIuIEknbSBub3Qgc3VyZSB3aGF0IEkNCj4+IHdyaXRlIGlzIGNsZWFyLCBpcyBpdCA/DQo+
IA0KPiBZb3UgaGF2ZSBhIHByb2JsZW0gd2l0aCB0aGUgd2lyZSBieXRlIG9yZGVyIG5vdCBiZWlu
ZyB3aGF0IHdhcw0KPiByZXF1ZXN0ZWQgLSB0aGUgZGF0YSBzaG91bGQgYWx3YXlzIGJlIGJpZyBl
bmRpYW4gdW5sZXNzIG90aGVyd2lzZQ0KPiBzcGVjaWZpZWQuDQo+IA0KDQpMb29raW5nIGF0IGFu
b3RoZXIgZHJpdmVyIEknbSBldmVuIG1vcmUgcHV6emxlZC4gVGhhdCdzIGRyaXZlciANCmRyaXZl
cnMvbGVkcy9sZWRzLWRhYzEyNHMwODUuYw0KDQpJdCBhbHNvIHNldHMgc3BpLT5iaXRzX3Blcl93
b3JkID0gMTYgLCBidXQgaXMgdXNlcyBjcHVfdG9fbGUxNigpIHRvIA0KcHJlcGFyZSB0aGF0IGRh
dGEuIFNvIHRoaXMgb25lIHNob3VsZCB0aGVuIHdvcmsgd2l0aCBhbnkgaG9zdCANCmVuZGlhbm5l
c3MsIGJ1dCB3aHkgdGhlIGhlbGwgaXMgaXQgZG9pbmcgY3B1X3RvX2xlMTYoKSBpZiB0aGUgZGF0
YSANCnNob3VsZCBiZSBiaWcgZW5kaWFuID8NCg0KVG8gYmUgaG9ubmVzdCwgSSdtIHJlYWxseSBu
b3Qgc3VyZSBhbnltb3JlIHdoYXQgaXMgdGhlIHdheSB0byBnby4NCg0KQ2hyaXN0b3BoZQ0K
