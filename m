Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7166AF623
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCGTxC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 14:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCGTwk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 14:52:40 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2087.outbound.protection.outlook.com [40.107.12.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078741998
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 11:44:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLPnjV+3H/LmSDisK7jQ6LkE6d8jYUHwQoyXO4pgx+30pq1dYZvHlK0JnfLdFGy3HcRd/jqIRUJCJ2I8hLnm1LE29YQhBqij+MDBOv+yC4BWtib6la7oRbd921+rmSmHQSSGApB07CozheeJGuy3dsD6GD3Cgl+vK/rVAFB1DF2SURdHs8zD6hMWxjKPdaRCJy0hXRgT4/BNqjrQhDQsx6kAd9co6+nG6yNz+QjNtvNpy4DshyXnkH5J3D6XnCcEM2S1pIYQYbBSkpkzOwASP/2j0yOcloqP2OA8v4HMrnaiZOTWQAngcDeJNIWKiuwsnGpELGF+46XguVIssDhnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q64kvB4HXm1JhrrcbouF9MPxNpoeNFvJogmBgpmfHlw=;
 b=bdkR2eR6XUVWW653P/7r+mvihHOsibujwItaG4q8EmOWahBtSVUEfsesc11AUcBvLPgUs4P2ZGGH/4hPWHAXdF/Qfp8CKLT+o04b4vXhWhMW7jS/ruiOlPIHNMOY1zNpCS0BmcyNr8GpI/P01tWMFlVm/Uof9RIFwtAE1znRVxbOIUDFLFLwYc3HdWJ57Flw8zafZM8mOYTRnlLwwRcZnoIQS9QBalhFqyr4YwXIPU4o0YJWif5pfj4Ly2J9Ba4uFJ7x9gHj+/NZuQn6KOfAnyBxTwyIqTHvn71yxeaW8htuWaABoa0lFbjvPjlIvXBRXhJs8SujsIQ+ki1Qh4RNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q64kvB4HXm1JhrrcbouF9MPxNpoeNFvJogmBgpmfHlw=;
 b=TpUVsxNmunMYGJhtxTKU4jry7IQEyuUmkgBZ9J8c0pxcdlbPNddUoPAZ+yaGXqQNCKjgNDdH4s1Sh8h19xk0m05Kzwjx+BzCIzVZ5Vqiqwy7+MYMTck37T2d275Hxu4M8dc/cx3AmH5OuP/k5x3hXr3gxJCHFqtsr43bUP4Ur3JUiVtyfTeQ5YqI6DjMnjxnFooyvML8cNwn+8Ylgw47spPtRkRlGDJk1P2/yRJuVqjUofNzfAZDYDXS5bgbWtPCjica9Aqc6O4isvu3Ol+Pa5j/G3Lw6ep/GwDmfPS3Eodqaqreo7dhllkbHxyGy/I8+RMcY8DIL8Vc70nIMOIi0Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2367.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 19:43:42 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%8]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 19:43:42 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Topic: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Thread-Index: AQHZUSGn3z/bFjp5CkqfEb9Cr4ssTa7vpOwAgAAHYACAAATLgIAABuMA
Date:   Tue, 7 Mar 2023 19:43:42 +0000
Message-ID: <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
In-Reply-To: <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2367:EE_
x-ms-office365-filtering-correlation-id: 035db00d-d38b-482c-f984-08db1f4441dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bu6hKbCt14XatmfJvfdYFwa+ec/TvAZ+oWWNAS9RwmJJiaLFuIgEa0anbDPMncSknZ+PdaKVrdoCZfDITuGdVCJsoCQCdcXV94ojB9F3KIyti21ou52SBNH+SEyiN4s5QX1dTtLjI05yDH+7yGNQYC8vbTM5R9iX/Mxgae9rCrYvfq4qtRmyBzaQpauulgUI1rHkKAw8nvd7aSDSqvz33IhfPTDd9Ib464PQ5CaSSGiRdIN9OJO+4XtY/gfInGYx60cMnMkPITpG87F+ojQ5ANHmk5xjYA9qh715TsG3HrQK9/Tt/CKpt9O0VN+jdGEvW3DYB/xpIKEX4wxxw1qgnI6LNsU9xnMxc229f9++c+7bYQAka5dJYtb65JeCpJzZfkE9asL6UjoBzE3MyrCOQ4ZjPQ1fFaq9Dj/dlCypljm/NrL4HaQNMRdw9bnefrltbufp2XAPWLmRjpJJkBF5hI3Hl7N+Q5EhFZsVuJkmn0lHvXa5lyogkeP9FH9mgf3Z9HSbV1962eMzixu17Gef63o8941KKtUqe82gog4t84hctzkAkgLHDJCPi7kWJKaxAaAM8mHlmhn7pHRPIt0ydk51iXCOqFWHM/5J63krxIZENmAXfODOdxwBRUwcVZwBMWWawFeY0A4Jzu0C5dln5bgXTCf1epoHMlY7LbOJ+MOqgLWzvdaDweFrqPKaYjfWQNlSzqoL/J9WbdTTdO0op56iU9DXRXbZiK3XOyG0cyVfV7zzMqSdw4ZSeN7WbGB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(6916009)(4326008)(8676002)(41300700001)(91956017)(66446008)(66476007)(64756008)(66556008)(83380400001)(66946007)(316002)(66574015)(31686004)(76116006)(38070700005)(122000001)(36756003)(38100700002)(2906002)(26005)(186003)(5660300002)(2616005)(6486002)(478600001)(44832011)(966005)(86362001)(8936002)(71200400001)(6512007)(6506007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blkyMXRrMHRwWjRBcHNhWEpqdThLcEVXM3FLWi8vM3FiQm5uNTF5a0ZaZHM4?=
 =?utf-8?B?MVFUUkZlWVFFeFpXRDRNUk4vVThiNytnTE1GOVJTaUVoTXNPRHZrcERtM3Rp?=
 =?utf-8?B?MzBHN29VMTZnMWE1Wm1tVHJVdlFrajhYWDNXWkpOV1VXSjZyUUxNT0NGeHZB?=
 =?utf-8?B?bWpTZ0hBczVIK1h6QUJKRVhKQW9DaWphbDNMb203Qy9ZL0RCV0REQllON0JQ?=
 =?utf-8?B?cjhzelYxSGZpNHBrR2Y2NUhNVjQwK3ZITmgzTUNvRjZKZjJpeEhkMCs2eDJw?=
 =?utf-8?B?Zi9Ed2pSeTFZWWJXRUtyOUJYOU92dkpiNTZ4L3lpVzdZVDZjQzNUaGNqUG1Q?=
 =?utf-8?B?UTBuM2R6eXVCTEVTRFV6eWFVNFg1MEs0Y0FpTjFMS1djWGg3b0lFZnFFYms0?=
 =?utf-8?B?UDRmWmV2UnpKdkRpa0pLTE5VY0wwbFk2alQ0RHVGc2UvbFlLalovWmo4M0pU?=
 =?utf-8?B?OEU1d21HTmw0d3k2SlJXTTBKelRLSGw0R1VoVUttdWhKb0RZd21MWm5BSWJt?=
 =?utf-8?B?WlozTkViUWNDcVBRNXdBaTYxREFiUDluaThURThlZTVDSmdDMnRyZmVDSE9J?=
 =?utf-8?B?WmJYMXgxYWk5NkdCb253UXozWTNXYUtxcUczSTdSWm1PdlpUQnkxZzFody9u?=
 =?utf-8?B?OGg5VWZwK0pvVkdlWnNxRy9vMkd3N1ltNjJVcmxld05obDZIRGp2WHlQUmpp?=
 =?utf-8?B?WWozaFhRSmxJZTZXK3RwUnQ3RVhTYzAvdVdkWTdZU2ZiVm9pemNoTFhpMTUz?=
 =?utf-8?B?cWJpSktQQlhrM2V3b1E3NTJFMU9QRkNKNkhHTzdXR1dHcmo0OHdEbm9uOEdM?=
 =?utf-8?B?V3V0MmU4TFlaL1Z3Qy9ScHRkSC9OSlpERjBsQXlEU1Q0RURmaGJlT3NOcDdu?=
 =?utf-8?B?dEFDRDN0VEtRRXMrdkMydXAxWWZCV1dKdVZXdEphNkJoTVpTb1JNSEZaemhr?=
 =?utf-8?B?TXMrZ08zSU5WVU5DdjU5SDV4QWxCcFdVbXdXZ2x6YVZXWXVLa2VwcHU3NUVB?=
 =?utf-8?B?anpZT04xdmRTbS9OQmFyTWVPQ3VTbGJaMUF6QStCQ1dYK2piaEE1Yy90SnQy?=
 =?utf-8?B?Um5Jb3EwOHAwZzRTbzVQZmVBSEE4bU0wbXBZdnFYWEdaZ1pQb3V2SVJ1SlZp?=
 =?utf-8?B?VW5nbjJhV3JlS3ArY2NEUXZHcUE1WXRpVTV2RDY5S1pGWlF4RHZ1aHNmRlZ2?=
 =?utf-8?B?YnRzSURpSVJUUUVtaUo0bDZWRVpaN1dkb2c1elh0L3BqMWZsRS9GQkF5VlRi?=
 =?utf-8?B?N1RjSS9iY0VDZWFzLzV0QzJwY0Z6ang2Znp6WGhDa09uaGlTSlVLbGF0a09u?=
 =?utf-8?B?Z0xwelFkUDBHdzg2OGo0VUcwSWFOU3hVa2Q0TkdpcTRuN1lpU3BncHU5Zk9R?=
 =?utf-8?B?OXJRRmN5Y1JPZGEvU3FDd0FFUWRjM29yNmhMbHBJdTdDZ3dqSmFRTzZ1K1M5?=
 =?utf-8?B?aTZDU1VmRXE3TVdJTTVZb2JueTFqZWpNZkg1aXEwdzFDRmJtUGh4WnBuSW9G?=
 =?utf-8?B?RCt3bEJ3K2NiMDNpUW8rbFFyVVZqQ1NreUpLNnBvb3lsQXZlZzVRQmpZdGVY?=
 =?utf-8?B?cUxFbGx3YnFaK1B0czJSdE5aaVp5TG0xb3RMY1U5QjR3ejhsZm90TTRaOTZJ?=
 =?utf-8?B?ZHZCVzlPYWQ3alFuUWwveVRvUTJrZXRybU5MTUNSRWVDRVBONDA3VEd5MDVF?=
 =?utf-8?B?M0RZa0RvMkdxQlA5QUE1cXo0TFpZZEJaNHdTNW1uRUNLcFJaT3BERUFpaEsr?=
 =?utf-8?B?R3kzdnlEK2hrRDAyU2VTb3dCcmVlL3pZTXRWV2srZ0Q3K1ZZSXJDR2dIS1k0?=
 =?utf-8?B?UWNNREtvb21vM3lLaWdUcFdHdFFCK0wrdlRFN01Nck9WZitFK1JDWmNJMm90?=
 =?utf-8?B?Zkw2eFRLMEdYcjM4UFVzWnppQklPVWpUN1I0dUpuT1hVOXdieDZTNmJDZENu?=
 =?utf-8?B?TGl4SjdMRjNDbkRhYkhRK0VtMUNaL1Y4Z1YwZFdmRzYvcGE1c3pTSzIzbW5i?=
 =?utf-8?B?c0J6T1lFdkIwaTBWdG1oWlJYRGZqY2EvNDNMcnFId2dnVGhtMjhqb3BHVG1M?=
 =?utf-8?B?R0h6L0NBU25sUmxqWjJtbmJkNEFROXdsUHp3ZjM0WWJseVAzR1hYcHFwVTFv?=
 =?utf-8?B?MnIxdFZoN0dSZi9HVGh3Tm1OSnlXNjA4Tjl4WC9zTDcwZVA2cHU3R1pxTVJB?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F549CCAAC3CA6545BB62508445F39143@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 035db00d-d38b-482c-f984-08db1f4441dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 19:43:42.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EnQf9IR51cxZOX4K2xLUMyDVn2KOeVrNSucXZjAtjwjpOjbFaHA2LXtE/Co2rV0PhlwEQGnH/1q0CRloIoSMnMysQgxqKd0HxfDKlrOycQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCkxlIDA3LzAzLzIwMjMgw6AgMjA6MTksIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VHVlLCBNYXIgMDcsIDIwMjMgYXQgMDc6MDE6NTRQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4gDQo+PiBXaGF0IGFib3V0IGEgbmV3IGZsYWcgYXQgU1BJIGRldmljZSByZWdpc3Ry
YXRpb24gdG8gdGVsbCB0aGUgU1BJDQo+PiBzdWJzeXN0ZW0gdGhhdCB0aGlzIFNQSSBkZXZpY2Ug
ZHJpdmVyIHdhbnRzICJyYXcvbmF0aXZlIDE2IGJpdHMiIGRhdGENCj4+IGJlaW5nIHNlbnQgYXMt
aXMsIHRoYXQgbXkgbG9hZGVyIHdvdWxkIHNldCBpbiBvcmRlciB0byB0ZWxsIHRoZQ0KPj4gY29u
dHJvbGVyICJJIGhhdmUgcHJlcGFyZWQgdGhlIGRhdGEsIHNlbmQgaXQgaW4geW91ciBuYXRpdmUg
MTYgYml0cw0KPj4gb3JkZXIgbW9kZSIgPw0KPj4gQW5kIGZvciBhbGwgZGV2aWNlcyBub3Qgc2V0
dGluZyB0aGF0IGZsYWdzLCB0aGUgY29udHJvbGxlciB3b3VsZA0KPj4gZmFsbGJhY2sgdG8gOCBi
aXRzIG1vZGUuDQo+IA0KPiBPaCwgc28gdGhlIGlzc3VlIGlzIHRoYXQgeW91ciBjb250cm9sbGVy
IGlzICpub3QqIHN3YXBwaW5nIGRhdGE/ICBJbg0KPiB0aGF0IGNhc2UgaWYgMTYgYml0IHRyYW5z
ZmVycyBhcmUgbW9yZSBlZmZpY2llbnQgYW5kIGEgYnVmZmVyIGZvcm1hdHRlZA0KPiBmb3IgOCBi
aXQgdHJhbnNmZXJzIGlzIGFscmVhZHkgaW4gdGhlIGNvcnJlY3QgZm9ybWF0IHRoZW4gd2h5IG5v
dCBqdXN0DQo+IHRlbGwgdGhlIGNvbnRyb2xsZXIgdG8gdXNlIDE2IGJpdCB3b3JkcyB3aGVyZSBw
b3NzaWJsZT8gIE5vdGhpbmcgb3V0c2lkZQ0KPiB0aGUgY29udHJvbGxlciBjYXJlcyBhYm91dCBh
bnl0aGluZyBvdGhlciB0aGFuIHRoZSBtZW1vcnkgYW5kIHdpcmUNCj4gZm9ybWF0cywgaWYgdGhl
IGNvbnRyb2xsZXIgY29ycmVjdGx5IHBlcmZvcm1zIGFuIDggYml0IHRyYW5zZmVyIHdoZW4NCj4g
cHJvZ3JhbW1lZCBmb3IgMTYgYml0IHdvcmRzIGFuZCBpdCdzIGZhc3RlciB0aGVuIGp1c3QgZG8g
dGhhdC4gIFRoYXQNCj4gd2lsbCB3b3JrIGEgbG90IGJldHRlciBpbiBnZW5lcmFsLCBkcml2ZXJz
IGp1c3Qgc2VuZGluZyBhIGJ5dGUgc3RyZWFtDQo+IGFyZW4ndCBnb2luZyB0byAoYW5kIHNob3Vs
ZG4ndCkgYXNrIGZvciBhbnl0aGluZyBvdGhlciB0aGFuIDggYml0IHdvcmRzLg0KPiANCj4gV29y
ZCBzaXplIGNvbmZpZ3VyYXRpb24gc2hvdWxkIG9ubHkgYmUgdXNlZCBieSBhIGNsaWVudCBkcml2
ZXIgd2hlbiBpdA0KPiB3YW50cyB0aGluZ3MgcmV3cml0aW5nLg0KDQpObyBubywgOCBiaXRzIG1v
ZGUgaXMgc2xvd2VyLCBvciBzaG91bGQgSSBzYXkgaXQgY29uc3VtZXMgbW9yZSBDUFUgZm9yIA0K
dGhlIHNhbWUgY2xvY2sgcmF0ZSwgd2hpY2ggbWVhbnMgd2UgaGF2ZSB0byB1c2Ugc2xvd2VyIHJh
dGUgaW4gb3JkZXIgdG8gDQpub3Qgc2F0dXJhdGUgdGhlIFJJU0MgY29udHJvbGxlciBvZiB0aGUg
Q29tbXVuaWNhdGlvbiBQcm9jZXNzb3IuDQoNCldlbGwgSSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFu
IGJ5IHN3YXBwaW5nIC8gbm90IHN3YXBwaW5nIGRhdGEuIFBvd2VycGMgDQo4eHggaXMgbmF0aXZl
bHkgYSBiaWcgZW5kaWFuIHByb2Nlc3NvciBsaWtlIGFsbCBQUEMzMi4gQnV0IGl0cyANCkNvbW11
bmljYXRpb24gUHJvY2Vzc29yIChDUE0pIGlzIGFwcGFyZW50bHkgZmV0Y2hpbmcgZGF0YSBhcyBs
aXR0bGUgDQplbmRpYW4gd2hlbiB0b2xkIHRvIHBlcmZvcm0gdHJhbnNmZXIgb2YgMTYgYml0cyB3
b3JkIG9uIFNQSS4NCg0KU28sIG15IHByb2JsZW0gcmVhbGx5IGlzIHRoZSBHUElPIE1BWDczMDEg
ZHJpdmVyIHdoaWNoIHJlcXVlc3RzIDE2IGJpdHMgDQp0cmFuc2ZlcnMsIGJlY2F1c2UgdGhlbiB0
aGUgU1BJIGNvbnRyb2xsZXIgc2VuZHMgdGhlIDIgYnl0ZXMgaW4gcmV2ZXJzZWQgDQpvcmRlci4g
RG8gSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IGZyb20geW91ciBwb2ludCBvZiB2aWV3LCB0
aGF0IA0KZHJpdmVyIHNob3VsZG4ndCByZXF1ZXN0IGEgMTYgYml0cyB0cmFuZmVyID8gSXQgaXMg
ZG9uZSBoZXJlLCBpbiB0aGUgDQptYXg3MzAxX3Byb2JlKCkgZnVuY3Rpb24sIA0KaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMy1yYzEvc291cmNlL2RyaXZlcnMvZ3Bpby9ncGlv
LW1heDczMDEuYyNMNTANCg0KQmVjYXVzZSBpZiBJIGNsYW1wIHRoZSBDUE0gU1BJIGRyaXZlciB0
byA4IGJpdHMgdHJhbnNmZXJzLCB0aGVuIEkgY2Fubm90IA0KYW55bW9yZSBwZXJmb3JtIDE2IGJp
dHMgdHJhbnNmZXIgZm9yIGxvYWRpbmcgbXkgRlBHQSwgdGhlbiBpdCBtZWFucyBJIA0KbXVzdCBy
ZWR1Y2UgZGF0YSByYXRlIHRoZW4gbG9hZGluZyB0aGUgRlBHQSB0YWtlcyBhZ2VzLg0KDQpDaHJp
c3RvcGhlDQo=
