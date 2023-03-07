Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B654C6AF7C9
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCGVkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 16:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCGVkQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 16:40:16 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2070.outbound.protection.outlook.com [40.107.12.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674C9AFF2
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 13:40:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brsi3FRBgjpPli5nZnurbcBmwXPdaorzXUkQh8765+sIv1jCmJPCwfl7vpi/5mOoRsS4v32lQORFdHMVpNLK5+Q1ROwWGvSRa7RPjbNqACkc4gIw53nY79LBjPIDWba5EFtRZXotdiz/ZQep/d8JYzNUgxnsu8JwBWM4PWPtMKqjlKQWgr9EC9WOubGZkCpPz8so/r6DaUqBfA0g/dDR/zYUurEosJcVNAAn5LKb2adMLhumEh8MRCBXdQ69NZKlnAiR1/9OW+MwgoIdBCClZPgDv4+6/4pJmTJHTXvHdhVdhTqKjGUcGtNxeMz7Y09d0YjW+/P6HXBLsUsOuubq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMVsF/uv+DgSOVwO10DUEOKbaLQSx0mg26q4iDsPH8Y=;
 b=avMo4eHu7C94k84v2ql3/y7+zAhzSCZ5r6aexi9mbtOkYub3oReb8GloWq0m+mR/dsm6y/opaVNNoHzYeo6ZPrsW/sLNFQaspqmwFbQ+tjol0EsYV4oRDDjDI3bSk97OlDgsObLlQF3aNnwti63Iz+26tF4kiAyPm81J7Ho7x2XW0nAN56jB1Sk1PfUutLIpYxgh6YSvox2O9Q50Ek6BHXHfUsy9y6ayRn1AINvTpbg5/GSV8rBHhwITjRhncoyTqNstkrvgISHJvi11z2gua0r6tG9mUMKC7WpzVrQaIsm/kVo3dkRFEpkyJw4C4GFitsDiGL4gGDbz8Do4jfGLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMVsF/uv+DgSOVwO10DUEOKbaLQSx0mg26q4iDsPH8Y=;
 b=qbqQZGFLgdqwnubn0HD8WxyUHr13X91Qxbxh/VHWp4rfGdvVUEnN+9JSu0MTqTwQr4n5F1eUohhdigSxSyQsrU+CHb5GOKzTEcomgW9aiE6Or33VuSMdkkNhUH4PFy5FVUQZgFyZ+Epc/I606f4a1RSj2ZRHPz5wKafbrK9AeOR0XmYCfImrY/uMaM6Rlyik+lil1iSSCVhecPvXsSF6AFHLUu5Qg6sahxLLXkVv1RsuA29NOM2fjPj7T4Gfnn6bUyweXS8w22/ugb/Zs2C9YGLK7cmgJaUamNEA7jF7jG1wyNBA0LCSm8paCmWMmbb8duM/sbkk+Lvdt8Qxb52SWQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2088.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Tue, 7 Mar
 2023 21:40:09 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%8]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 21:40:09 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Topic: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Index: AQHZUSGn3z/bFjp5CkqfEb9Cr4ssTa7vpOwAgAAHYACAAATLgIAABuMAgAAYQQCAAAhIgA==
Date:   Tue, 7 Mar 2023 21:40:09 +0000
Message-ID: <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
 <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
In-Reply-To: <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2088:EE_
x-ms-office365-filtering-correlation-id: 3ea307dc-df9b-4599-b517-08db1f548696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a66gaRXREbtfNaaJE4HAVyaGJadcznBIB0muA7nX5FIbEgrfiNXF8xXeDmy+kml5z6LGgAu4tJMf7Z2f7+4Hbf3J+cs44Yh/JzwhZZN5JvaumkUTaGvKDPGJQMMCWSFF3OVas3QpvoLfbRXzqFUjwbVwL5WD1VEvV7I9w1cmIHCJZofB4DzaWtT1kklDCGJFJZCqsoGVcrLoR1iqE7S4PNs2SLAMO66to6yfdN/ck4qAovS0y+WneURnGEJpw0simj5JN5/uGcsOUtu/HAYPRWU/jVxdmUphx38juum/1qO9ocNG5JBkFvHy+l9r8HUSivb0s24xmrWxmttcLy52X53ltxDRvUKGrFO1H88yBjVV/kORIq5iup9TqrMkdXRj2rwxKVzcty7++DrxSRhO+NOlsY+n441e2YTMRldHKt8qYH3a05ckYjxLrf+yqJ0nNmGmIPL7eZ29edrl4Y4bZ28OR7GeAg+pI52nCZWyLV4uH3tEf9HXjksJV2oxCa6k3aybGPCW1jeU29Q/wb+H6pYhP2oHAhKvpKT7b/YAusNNbInP4sOfakuFefzl9+mJwXsWSFq17a6z8BX34e/SBXDi0HJ6iuA2kHliQDKv3mXyQ1FEh0qRAYuTa1FSoAPj+gPfucQsNJz4KEsymwcUpkXw+8TMaabmgWhl20R+CTau9k+olXQwS7yOJeF2813fRicPP8iCfXrJ3genqFchgcxB7qW3gpnI7Mxpur6D++vakOvWHZExeagx41uK/iNE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(31686004)(36756003)(76116006)(6916009)(4326008)(41300700001)(8936002)(66556008)(66476007)(66446008)(64756008)(8676002)(44832011)(5660300002)(2906002)(38070700005)(122000001)(86362001)(31696002)(38100700002)(66946007)(6512007)(6506007)(26005)(966005)(6486002)(71200400001)(478600001)(316002)(91956017)(83380400001)(66574015)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OURCeUR5NGtBRlBXR1hkS05jdm1vZ1JTK1AxTk9Dc1BvVzAzUldqZE41ek1C?=
 =?utf-8?B?cnBaNklKcDhqdnoxUDNxRWhqWHdaZzdwSzM2c3BTQ0xwcVlUWVlrSXdnUE9t?=
 =?utf-8?B?aXl1a3RDZGw1cVlBaXVOaFJvdkFKdHFSMm1yT0JGYTM2MU03WERFSXg2TFZT?=
 =?utf-8?B?c0VzZEJVWERlVFhmSFJ5OVZJS2x4UlY2MlVXMFY2bHA1SFBFUkxHTjVBekY5?=
 =?utf-8?B?ZDlNcG1WVUlrZDdzZU85bndndFlKK042eDZQRXNsalF1ZEM1MXJIcGVHbytT?=
 =?utf-8?B?ZjBRcFdTZnY0Y2M4Nk9vQnFkbXBsNjVpdU45aXpjTzYvWklhdG04cHRtTWp6?=
 =?utf-8?B?WVI1NmZENE1kMGV4VjdkZGxJZkU5enk0KzNJUHdLTVZIZGtUV0VIa1F6aWxG?=
 =?utf-8?B?VUQzUXBhakdzWnBNb3ZTRG5KUWUvNklUTDlkMCszZ2dFejl1UklKRVVEeVBh?=
 =?utf-8?B?S1VIb0ZmR2psYXRNQjFOemhRaVM5Rnp3c25wYzlXQlJmZmt4NzU1cGZseW5u?=
 =?utf-8?B?V1ZwbnQwNEowZVk0dkNRdW10b1BZOVVBS3hzbzFqYjdZVmxOU3lJWHY4RmZI?=
 =?utf-8?B?REk2YldGV3JrWHhaY3dMMGk1MjJwbnVGZXNYelZWK0djeHZ6QUh3ejlBVG1s?=
 =?utf-8?B?WVRPQUZ0Nkk3SkRxejljRE94QmZpUGJyc2p6ai9GcExsQVBPY2puT09wa3ZP?=
 =?utf-8?B?cmJoUk13cmFuMWtOUitMcXZXRlYvak1ab1lqRnJqNTR6aFd3UFArY3RnU3Vv?=
 =?utf-8?B?c3g1U3lNTmFWQnlJcnZ3NVdWYjBmam1wM242NDY2Z2h2K0pWdG9heWxaNWda?=
 =?utf-8?B?bmNPaVk5Y2Z0ZXVNSmdYQ1pkVk9nY3d3WHJXVlgzWDQwQmlybE9MdkJ6Z3Jv?=
 =?utf-8?B?Q2JXelJnK3R1QTNkb2lmU3kzT2xPZXpjK1EzakdiRmd6Y1QzODRlUHFudWtE?=
 =?utf-8?B?anNuZWZ6TDg3NHBIZXV5a2Rha1hvSDE2STJqblplN3NSQUhWcVZnbEVIYzh3?=
 =?utf-8?B?MHR6NkJzUGgxaWVqdjF1eC9LRVV3bm90R2xhdENwNnhMcXhoOFhCMmErL05i?=
 =?utf-8?B?TlpLZWk1RWFtTlAvcGRmMUJVdkd0U3M4Q1FnSzJJOGd2WUxFZVJJRkhwQmZr?=
 =?utf-8?B?dE90c01vZzF2cVd4WmFKTmE3VE0rYzRBQ2t2T2p0VEc4WjRoWUVPcENIN1Nv?=
 =?utf-8?B?eUJhNXZsaVdyMlViMmg2ME5razl0MnpjbnlJQ3lkYXkrenNhT3pkMEF2MG5N?=
 =?utf-8?B?YXVxL24wbHBzalFkL0ZlcExiakRXeEthUkYzN0d2aE4ySWwzVUNSeXdmTDhC?=
 =?utf-8?B?RkFtRFNnUmRkd2RTYnFiQ0Q2WnJCdW8yODcxc1VNRUVQV3BPSG5jRmVFNDZC?=
 =?utf-8?B?OElLVW5mOG5naDRTU3NrWDhXRTNhbzlPQm5qdnZMUHkvWXg4UGRTU1MxcFNq?=
 =?utf-8?B?cWNwQjI0TUlTQkhOWXhvK1RNdHFSbDBlT0NRT3p4TUpvQUhGMFR5UFNQcUpz?=
 =?utf-8?B?OTVqaUU3bThBcHYxaHRFOE1sSlloOXhMNGV0Wk94N3pNdEtQRHRqbEI5VVN0?=
 =?utf-8?B?TXhtREtyOG5va09LSnFhSGtYdDZnQ29nUmh4ZkRydFhCL0Y0ckt3aUdOVWdY?=
 =?utf-8?B?MjY3SWN3ZUJ0YkNEWUQ2TFhoeEFzSVVrYi9BdjE2clUwekVoOHhDSDh2U2Yy?=
 =?utf-8?B?N2htVjdsSlJKQWhDV1hrUWtzK2xTMFJ0L2UyUVoxOVZpRi96SGlmYmcxdEM2?=
 =?utf-8?B?QXBtaDlVWWVSTi9lTDU5eXR3Q1libWhzODc0RktydWQvSkQ3aHYxZ3VPTmk0?=
 =?utf-8?B?czR0Sk01MDJwVVhvNVg4amwyT3l2UGV6YXpsTHJaeVJXTHkrbG1zc1ZMOHpT?=
 =?utf-8?B?S0ZpdTdzbHFvUlFtTDVhTUt0Y0x3d0pWeFVyWWgwL1JXWmFXbkhEOTJOTVdG?=
 =?utf-8?B?VGNuUGM0N1UrUW40T1dJUnprMklxM29FRVU2QXc2S3BFbGdkRUVlaGtNUnZR?=
 =?utf-8?B?MFlXNTdoSkdvQnpuMnN0V3NuNzFzMk5hVWRGTDU3aU55MGVsZlRJUWZiZVZn?=
 =?utf-8?B?cm1SNUZGL0pBSFJaRTNTSFBFRlJjWERhVURRSXRJTnZjSEhVSEZJN213VzhN?=
 =?utf-8?B?RGlkK2tVaE42R0tCUEVvci9xRkJoa2UxM3h3cWhoR2dTaU1YZjAzTDV6cjU3?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF409A45794A66458C272D664179E109@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea307dc-df9b-4599-b517-08db1f548696
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:40:09.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgSbO5jPKfNV3CYcLXqTcxuKRx2jaTRdK7TyAsaMcLEaA7+QQsdyyeEvXLRTwM8evo5Oww4yGBu219swb0xgK5izi6EeAJOoSj2klqIeO+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCkxlIDA3LzAzLzIwMjMgw6AgMjI6MTAsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VHVlLCBNYXIgMDcsIDIwMjMgYXQgMDc6NDM6NDJQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IExlIDA3LzAzLzIwMjMgw6AgMjA6MTksIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoN
Cj4gDQo+Pj4gT2gsIHNvIHRoZSBpc3N1ZSBpcyB0aGF0IHlvdXIgY29udHJvbGxlciBpcyAqbm90
KiBzd2FwcGluZyBkYXRhPyAgSW4NCj4+PiB0aGF0IGNhc2UgaWYgMTYgYml0IHRyYW5zZmVycyBh
cmUgbW9yZSBlZmZpY2llbnQgYW5kIGEgYnVmZmVyIGZvcm1hdHRlZA0KPj4+IGZvciA4IGJpdCB0
cmFuc2ZlcnMgaXMgYWxyZWFkeSBpbiB0aGUgY29ycmVjdCBmb3JtYXQgdGhlbiB3aHkgbm90IGp1
c3QNCj4+PiB0ZWxsIHRoZSBjb250cm9sbGVyIHRvIHVzZSAxNiBiaXQgd29yZHMgd2hlcmUgcG9z
c2libGU/ICBOb3RoaW5nIG91dHNpZGUNCj4gDQo+IC4uLg0KPiANCj4+IE5vIG5vLCA4IGJpdHMg
bW9kZSBpcyBzbG93ZXIsIG9yIHNob3VsZCBJIHNheSBpdCBjb25zdW1lcyBtb3JlIENQVSBmb3IN
Cj4+IHRoZSBzYW1lIGNsb2NrIHJhdGUsIHdoaWNoIG1lYW5zIHdlIGhhdmUgdG8gdXNlIHNsb3dl
ciByYXRlIGluIG9yZGVyIHRvDQo+PiBub3Qgc2F0dXJhdGUgdGhlIFJJU0MgY29udHJvbGxlciBv
ZiB0aGUgQ29tbXVuaWNhdGlvbiBQcm9jZXNzb3IuDQo+IA0KPiBQbGVhc2UgcmVhZCB3aGF0IEkg
d3JvdGUgYWJvdmUuDQoNCkFoIHNvcnJ5LCBJIG1pcy1yZWFkIHlvdXIgdGV4dC4NCg0KU28geWVz
LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBjb250cm9sbGVyICppcyogc3dhcHBpbmcgZGF0YTog
aWYgSSANCmZvcm1hdCB0aGUgYnVmZmVyIHRvIGhhdmUgMHgxMiAweDM0IGFuZCB0ZWxscyB0aGUg
Y29udHJvbGxlciB0byBzZW5kIGl0IA0KYXMgYSAxNiBiaXRzIHdvcmQsIGl0IHdpbGwgc2VuZCAw
eDM0MTIgd2hlcmVhcyBpZiBJIHRlbGwgaXQgdG8gc2VuZCBhcyA4IA0KYml0cyB3b3JkcywgaXQg
d2lsbCBzZW5kIDB4MTIgdGhlbiAweDM0Lg0KDQpTbyBhIGRyaXZlciBsaWtlIE1BWDczMDEgd2hp
Y2ggd2FudHMgdG8gc2VuZCAweDEyMzQgYXMgYSAxNi1iaXRzIHdvcmQgDQp3aWxsIHdyaXRlIDB4
MTIzNCBpbnRvIHRoZSBidWZmZXIuIFRoZSBwb3dlcnBjIDh4eCBiZWluZyBiaWcgZW5kaWFuLCBJ
IA0KZ2V0IDB4MTIgMHgzNCBpbnRvIHRoZSBidWZmZXIgdGhlbiB0aGUgY29udHJvbGxlciBzZW5k
cyB3b3JkIDB4MzQxMi4NCg0KPiANCj4+IFdlbGwgSSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5
IHN3YXBwaW5nIC8gbm90IHN3YXBwaW5nIGRhdGEuIFBvd2VycGMNCj4+IDh4eCBpcyBuYXRpdmVs
eSBhIGJpZyBlbmRpYW4gcHJvY2Vzc29yIGxpa2UgYWxsIFBQQzMyLiBCdXQgaXRzDQo+PiBDb21t
dW5pY2F0aW9uIFByb2Nlc3NvciAoQ1BNKSBpcyBhcHBhcmVudGx5IGZldGNoaW5nIGRhdGEgYXMg
bGl0dGxlDQo+PiBlbmRpYW4gd2hlbiB0b2xkIHRvIHBlcmZvcm0gdHJhbnNmZXIgb2YgMTYgYml0
cyB3b3JkIG9uIFNQSS4NCj4gDQo+IFRoZSBkZWZhdWx0IHdpcmUgZm9ybWF0IGZvciBTUEkgaXMg
YmlnIGVuZGlhbiAoTVNCIGZpcnN0KSwgYXMgY292ZXJlZCBpbg0KPiBzcGkuaDoNCj4gDQo+ICAg
KiBJbi1tZW1vcnkgZGF0YSB2YWx1ZXMgYXJlIGFsd2F5cyBpbiBuYXRpdmUgQ1BVIGJ5dGUgb3Jk
ZXIsIHRyYW5zbGF0ZWQNCj4gICAqIGZyb20gdGhlIHdpcmUgYnl0ZSBvcmRlciAoYmlnLWVuZGlh
biBleGNlcHQgd2l0aCBTUElfTFNCX0ZJUlNUKS4gIFNvDQo+ICAgKiBmb3IgZXhhbXBsZSB3aGVu
IGJpdHNfcGVyX3dvcmQgaXMgc2l4dGVlbiwgYnVmZmVycyBhcmUgMk4gYnl0ZXMgbG9uZw0KPiAg
ICogKEBsZW4gPSAyTikgYW5kIGhvbGQgTiBzaXh0ZWVuIGJpdCB3b3JkcyBpbiBDUFUgYnl0ZSBv
cmRlci4NCj4gDQo+IExTQl9GSVJTVCBoYXMgb25seSBvbmUgaW4gdHJlZSB1c2VyIG90aGVyIHRo
YW4gc3BpZGV2IHNvIEknZCBxdWVzdGlvbg0KPiBob3cgb2Z0ZW4gaXQncyBjb3JyZWN0bHkgaW1w
bGVtZW50ZWQuDQoNCldlbGwsIG9rLCBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoZSB3aXJlIGJ5
dGUgb3JkZXIsIG9ubHkgd2l0aCBob3cgdGhlIA0KY29udHJvbGxlciBmZXRjaGVzIHRoZSBkYXRh
IGZyb20gdGhlIERNQSBidWZmZXIuIEknbSBub3Qgc3VyZSB3aGF0IEkgDQp3cml0ZSBpcyBjbGVh
ciwgaXMgaXQgPw0KDQo+IA0KPj4gU28sIG15IHByb2JsZW0gcmVhbGx5IGlzIHRoZSBHUElPIE1B
WDczMDEgZHJpdmVyIHdoaWNoIHJlcXVlc3RzIDE2IGJpdHMNCj4+IHRyYW5zZmVycywgYmVjYXVz
ZSB0aGVuIHRoZSBTUEkgY29udHJvbGxlciBzZW5kcyB0aGUgMiBieXRlcyBpbiByZXZlcnNlZA0K
Pj4gb3JkZXIuIERvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCBmcm9tIHlvdXIgcG9pbnQg
b2YgdmlldywgdGhhdA0KPj4gZHJpdmVyIHNob3VsZG4ndCByZXF1ZXN0IGEgMTYgYml0cyB0cmFu
ZmVyID8gSXQgaXMgZG9uZSBoZXJlLCBpbiB0aGUNCj4+IG1heDczMDFfcHJvYmUoKSBmdW5jdGlv
biwNCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjMtcmMxL3NvdXJjZS9k
cml2ZXJzL2dwaW8vZ3Bpby1tYXg3MzAxLmMjTDUwDQo+IA0KPiBJdCB3b3VsZCBjZXJ0YWlubHkg
aW1wcm92ZSBpbnRlcm9wZXJhYmlsaXR5IHdpdGggY29udHJvbGxlcnMgdG8gcmVxdWVzdA0KPiA4
IGJpdCwgYnV0IHNvIGxvbmcgYXMgdGhlIGRyaXZlciBpcyByZWFkaW5nIGFuZCB3cml0aW5nIGRh
dGEgaW4gdGhlDQo+IGV4cGVjdGVkIGZvcm1hdCBpdCBzaG91bGQgd29yayBwZXJmZWN0bHkgd2Vs
bC4gIExvb2tpbmcgYXQgdGhlIGxhY2sgb2YNCj4gYW55IGVuZGlhbm5lc3MgaGFuZGxpbmcgaW4g
dGhlIGRyaXZlciB0aGF0IGRvZXNuJ3Qgc2VlbSB0byBiZSB0aGUgY2FzZQ0KPiB0aG91Z2gsIGl0
J3MganVzdCBoYW5kbGluZyBkYXRhIGluIENQVSBlbmRpYW4gZm9ybWF0IHdoaWNoIGlzbid0DQo+
IHBvcnRhYmxlLg0KDQpJIGFncmVlLCBpdCBzaG91bGQgd29yayBidXQgaXQgZG9lc24ndC4NCldo
ZW4gSSBjaGFuZ2UgbWF4NzMwMV9wcm9iZSgpIHRvIHNldCBiaXRzX3Blcl93b3JkIHRvIDggaW5z
dGVhZCBvZiAxNiBpdCANCndvcmtzLg0KDQo+IA0KPj4gQmVjYXVzZSBpZiBJIGNsYW1wIHRoZSBD
UE0gU1BJIGRyaXZlciB0byA4IGJpdHMgdHJhbnNmZXJzLCB0aGVuIEkgY2Fubm90DQo+PiBhbnlt
b3JlIHBlcmZvcm0gMTYgYml0cyB0cmFuc2ZlciBmb3IgbG9hZGluZyBteSBGUEdBLCB0aGVuIGl0
IG1lYW5zIEkNCj4+IG11c3QgcmVkdWNlIGRhdGEgcmF0ZSB0aGVuIGxvYWRpbmcgdGhlIEZQR0Eg
dGFrZXMgYWdlcy4NCj4gDQo+IFdoeT8NCg0KTWF5YmUgd2hhdCBJIHdyb3RlIGhlcmUgaXNuJ3Qg
Y2xlYXIuIFdoYXQgSSBtZWFuIGlzIHRoYXQgaWYgSSBtb2RpZnkgQ1BNIA0KU1BJIGNvbnRyb2xs
ZXIgZHJpdmVyIHRvIGFsd2F5cyB1c2UgOCBiaXRzIG1vZGUgKGFzIGRvbmUgZm9yIHRoZSBRRSBT
UEkgDQpjb250cm9sbGVyIHZpYSBmdW5jdGlvbiBtc3BpX2FwcGx5X3FlX21vZGVfcXVpcmtzKCkg
KSwgdGhlbiBpdCB3aWxsIHdvcmsgDQpidXQgSSB3aWxsIG5vdCBiZSBhYmxlIHRvIHVzZSB0aGUg
c2FtZSBzcGVlZCBhcyBpbiAxNiBiaXRzIHRyYW5zZmVyIG1vZGUuDQoNClNvLCB0byBzdW0gdXAs
IHRoZSBzb2x1dGlvbnMgSSBzZWU6DQpBLyBGb3JjZSBDUE0gU1BJIGNvbnRyb2xsZXIgdG8gYWx3
YXlzIHVzZSA4IGJpdHMgbW9kZS4NCkIvIEltcGxlbWVudCBhIGZsYWcgdG8gYWxsb3cgYSBTUEkg
Y29uc3VtZXIgdG8gc2F5ICJwbGVhc2UgcGVyZm9ybSANCnRyYW5mZXIgd2l0aCB5b3VyIGJvZ3Vz
IGJ1dCBwZXJmb3JtYW50IDE2IGJpdHMgbW9kZSwgSSBoYXZlIHdvcmtlZCANCmFyb3VuZCB0aGUg
ZGF0YSBvcmRlciBmb3IgeW91Ig0KQy8gSW1wbGVtZW50IGEgYnl0ZS1zd2FwcGluZyBpbiB0aGUg
Q1BNIFNQSSBjb250cm9sbGVyIHdoZW4gYSBjb25zdW1lciANCmFza3MgZm9yIGEgMTYtYml0cyBk
YXRhIHRyYW5zZmVyDQpELyBNb2RpZnkgTUFYNzMwMSBHUElPIGRyaXZlciB0byB1c2UgOCBiaXRz
IHdvcmRzIGluc3RlYWQgb2YgMTYgYml0cyB3b3Jkcy4NCg0KU29sdXRpb24gQSB3aWxsIGRlZ3Jh
ZGUgcGVyZm9ybWFuY2UgYnkgZm9yY2luZyB0cmFuc2ZlciByYXRlIHJlZHVjdGlvbi4NClNvbHV0
aW9uIEIgbG9va3MgbGlrZSBhICJob21lIG1hZGUiIHNvbHV0aW9uLg0KU29sdXRpb24gQyBtZWFu
cyBjb3B5LWFuZC1zd2FwIGludG8gYSBuZXdseSBhbGxvY2F0ZWQgRE1BIGJ1ZmZlci4NClNvbHV0
aW9uIEQgaXMgLi4uLiB0aGUgYmVzdCBvbmUgPw0KDQpBbnkgb3RoZXIgaWRlYSA/DQoNCldoaWNo
IHNvbHV0aW9uIHdvdWxkIHlvdSBwcmVmZXIgPw0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
