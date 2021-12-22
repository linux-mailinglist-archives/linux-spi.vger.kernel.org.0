Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3947CDAB
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 08:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhLVHwv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 02:52:51 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10657 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVHwu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 02:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640159570; x=1671695570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5em8G3Wi84UcKn2mkEW3S3FBNw+gDAL/Jcq4YYjyP34=;
  b=V9Db3Ub36DgZ14+dju+ry1VBZJfPZj3SNeUjP3n/gj8W33kTStnbzRng
   wj6tNb9I7FaOZEdEZHfm+DRHNVGOFv2uR3lOAfZSo161a2CsrQt9lsDWD
   /GDVVISnMIymmt5kFStRb+LgYz/wa10hWBwJmnLiK1hseukLq0YEIFaW0
   brkcIfMM3ggvLfU3XjDnx27NTZW/Qo1ZI3LUAtP/kgORdqgwv4tXIRac8
   2bPxye7QJ3Br9RW4GOPZbhjLybnhKrG7o5uq6Yp1S4/umBwKFoA/o3W7G
   eciCaut8bPtNDOcApmiHhqDQQa+HlC0ms7LMhEudawN6gIMwm+YHjJIhX
   g==;
IronPort-SDR: JZfh+FuMTJG5Y4Ed0ZKCu8XMibNXSE3+x8aMLKbzD/KcyD7brbBsmNp2iQuUWjK7bXaYvAwjk0
 5307aVUi2HBFj7RF2zFrH1vWErA7PHZscPAkN5b7U455CZqZKP10is6KxY0FuUNrlabhVB3Mym
 Kzht9BAuZhxPXE94G3901DGdWlhOIpzci0kLh0/+qo10euElfpyYadIPEGWBnaPvNjgUuRuAva
 m8BGCOjPVyJYJt0m3qmR7Fvjo2BBlFms9/bUa85gmUNb1sbusneJ61MLgGvLWvIu5DKOAA0KT8
 C0UJrggYBGigW3gsRLO12Kb/
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="140569935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Dec 2021 00:52:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Dec 2021 00:52:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Dec 2021 00:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaOCDuzdXYrD4L+u2YKRXvLKQvivgvNbTeAbnlKF9oMWWCASuKzaG0DihTBFwaeXi9kB9MDOCCaAyXkbtF5miJvJ+FLbyMDdtc+vD1S40bw+47o2u+7QUxkQDcvmPBCng+qEOHSNvOYBIe//U3ZOhlGsfhU+bE1v2zTVb78e0BYTqUHllvKK/uIUP11mwz0XSsKipavyxMqrFnCBR7BmHxKxXduRumGKP2ByxvlaojSFAaeXef9rPEu4fmBR5UNilzfrWKqxNTJkzzQlvBwudK3FeuL6UwZjgeEMXBjLVFqRFGPTIETzl8sHOgOilGg9hM3964Ud9kZxPtOzp6iMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5em8G3Wi84UcKn2mkEW3S3FBNw+gDAL/Jcq4YYjyP34=;
 b=ewePDwir6VXsxurS4THgx3GLy7OOqq+mUstk55wcTsLQfzUGfqGM68dCAklFgFZgcBywzngrFcTqanHNiHFDzT+FjSC9znxsWe8V8eFDI+4GgcrfSTTSdEvsbJhhyoTKm9uMnR5QC0mXYwOhcJ8SEWqLv7vj7ISQLEns6tRBy6JYDKaGeEvfc+/YRCswgQXiqY43r8Dg6duj6KlqxohRpPUgyV2JK2UdKZkOVlHnX1iN+WvIB3kYnueCdZ3wzFbYJKQkEAHASMjNtLQy0/WVAnEQqDz5OY04YVEAy/4Rbl42s1HferzWyz+3KIGj/XdyXG1vD4+QvLOaHJCKN2SHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5em8G3Wi84UcKn2mkEW3S3FBNw+gDAL/Jcq4YYjyP34=;
 b=HbSImin3HBIM+NDbFbN9YM3BfVBr27hEXByUkEdfQA1QGGNoD8ZozEgvvQgIILGRhN0IvMg9VhwW0PT7Hq2D16EWzZgrQ09jM7NBK2XyBRaLWnB79EuafYo6xxtqREJokrHRfKcfxWSrBz/uwrEmBgJDf0N9UY/s5SuoRqZhZIU=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3423.namprd11.prod.outlook.com (2603:10b6:805:db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 07:52:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 07:52:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <monstr@monstr.eu>, <thomas.petazzoni@bootlin.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Topic: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Index: AQHX9wjnQ3zfS7UookqMlT7vSJeh9A==
Date:   Wed, 22 Dec 2021 07:52:44 +0000
Message-ID: <a11a0650-4624-0a9f-d0a5-c45393fead7c@microchip.com>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
In-Reply-To: <20211221170058.18333-3-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 697a06d8-a6ae-41c3-3baa-08d9c52009e1
x-ms-traffictypediagnostic: SN6PR11MB3423:EE_
x-microsoft-antispam-prvs: <SN6PR11MB342332B5D62CC1B037FF3728F07D9@SN6PR11MB3423.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chPZMlvtnoGJL8BxDMCPUneKRpSCtmw5PgcnYxWyiXLgpbMFgER5Dwpi0zod4MFUjM/MROPb81euVAhcjdKh9HlO1FdQz6e9fPzRxRIei8t2X9Ro/9FzSRcmAg61rq9Ni6EJHNLGt//p2Xzl7T0f8qaQePB/Hsvnumn1ny1CrL+GezfC2Px8+etR0P+3k4LxULeZYTOV7Sx+R+7kRp2Yrv2aB6WDd7d0Cnvo8yaqdfeo89evakkQ+pYpBxbtCtltI0mVerYojKT7F4iHc/ACbVZIxpGzpHPwXs+KJVt2VY8x6tsJ6WOUk6CHjOi6DmbW96IqX/ZviPsaBHBXPJQGXIE0KnkqkvgeJFQr3KSfTnJsis5KU0WRu/KkwAheAcvJN+gYm9ca5egQQV0DwVLcdiHh0Fvh1od5Egh1cIOUOnS8Yn0Tm6LkeSKCEu4krbIyZkGmBMcvSOOujqS4p2kk3GBMoqHKpi4+caqisVoy9rCZSuPLzx4SezYjpdIxt0JPkRkIKhT9JyZXAKqDj5Chf0oyJ58PeIwReu9mLem5zQRigriWRgRTa+u7ef3nkMymiP1yZcCvh96vV0e2l2JiZ7oovZMO7XFLD5IthpC3/ipXNBiVr9+uQsrMBpQbZd8RLay/Exr53gOJINThMWDRXPjYSzJ35hW86/S9++IndDcbdInOcTmS0pQbWA7YDccO4Ae4C401pr7xcdKwO8tPHzgEt28tNIR1hD2EB3zNiqgJWDCjDD0TxUdmm+EMcyio6y7C89MiEuE5E2MoXkh0gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(71200400001)(91956017)(76116006)(5660300002)(31686004)(6512007)(38100700002)(6486002)(122000001)(38070700005)(31696002)(4326008)(8676002)(66476007)(83380400001)(26005)(7416002)(2906002)(8936002)(508600001)(316002)(54906003)(110136005)(2616005)(86362001)(66446008)(64756008)(66556008)(186003)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGs4c2ZQd0NpOUk4QllKNVhaWWQ5MFlaSmFEMnlYZlJ3ODkvNnhBSVRzcFp4?=
 =?utf-8?B?RW9mMlFteFN6ZGx3b1ZyYk80ZVhsZG9mcldSRlZrN1RpS2s3dU5uQmV4aEFh?=
 =?utf-8?B?YW5LbTRHYllCRHJyTTZOZUI3MHZSUE9zblkzNTNyNnpYTTJiK0Zud2xKUUFk?=
 =?utf-8?B?M29uOFN1ekNhY3hyN2pDRkY5RVVyUXZuTnhINlYwcEVWNkVPMm9uUy82bE95?=
 =?utf-8?B?dklSai9IRkFHUFpaWGwveUZ3NXVMc05BNTdxdDNYTVNLeEdOdVRYM2lzd09x?=
 =?utf-8?B?MEc3aEg5d3FTOHJLeTdac2NWQzNrUUtTdDhUNERaTGZURndaTlNPRnJvcW01?=
 =?utf-8?B?bHBCME9QQ3lwVVV5SDRtZlJ1MmlXTGY4ZWxPZjhtTkhvMUQ1NFB5ZjJka0FU?=
 =?utf-8?B?NmkwZVN5dGIxSjN2QnB3am5mSFpJVmZWejdJeXp6K3BEdW1EVVdacmI5VDhq?=
 =?utf-8?B?ZmxsYTRpS3hHY2RweUlCdm1HVWNJQmw3cWJTVkY2bHk3YlpRdCs2NWZNQ25C?=
 =?utf-8?B?dkg0by83cmR3MnRPNzBjWk1kZnZmZTh1RitNUTFmb0lIMFZiNTNGR3Q4QktS?=
 =?utf-8?B?NG52U3FMUk1HUjFFZGsrOVJybStiT2RtMVNtaDRWOG1xQzJjdUR2QWVSNndh?=
 =?utf-8?B?M1JvNmY1aHVIcHdvS1B5aHJzczVWSUM4djBHempTS05pckYvdXFJbUVJUmo1?=
 =?utf-8?B?R1ovQXZMMVRsZENrbUJpMm1KSGcyWThuV1BlV2xQNnU1S0Z5VSt2dWdNWldE?=
 =?utf-8?B?UEpSYzMwZkRQQ0czdkJ3b2x2bmYyQloxRzJmNlZGeDFncWpTcXZUUHkrRHlo?=
 =?utf-8?B?eTJPMzFObE1MUmhheFUzN1o3L3RUbUYwQktsM25SeW1TWnF0am85WUdSSWtI?=
 =?utf-8?B?RWlVOFFERi8xaGtJOWtsand3dktvKytHNTh3Sjd5QTNWZ3lrRElsMW9kNU1m?=
 =?utf-8?B?LzdSRDFBZDZwc3NpbVBDelZEZVNMZkJWWFZabWlhM0srazNacVlia2hvUlcx?=
 =?utf-8?B?OEZoMjZwakFkYWh3RmVWZ2FYdTZnNENFa2ZKU2J4dkRSM3U0YzhnSnFUZjNJ?=
 =?utf-8?B?NVZBbXZzTVRtSVJZdnUwNmJZR055THRKNVErMDdMMEREaWQvNHZ5Wmp1OGw1?=
 =?utf-8?B?TytSNnp4dTlUN1NGVnZVb2diUnVVYlNuNUxNUjRvRTJ0MVo1eVI0ZTBldzZD?=
 =?utf-8?B?aHRhN2JrS1l3eUt4S2RzcGFSTndtSzBCajdTR1ZROFloRWg2bFZMTmt4RGdw?=
 =?utf-8?B?MGx5bXVyY3J5NXdXWHkrdGZaQUhNc2Z6aE9iZ0JrMnNNeXRRdUNjOU9nNzRr?=
 =?utf-8?B?QVMwS21FY3VRRnhaTGN3MENaTWg1Q25IWXgxZEJseGxudURGNk1RZVZFOXRH?=
 =?utf-8?B?V2I3TGlHY283RmJUekFHUU5OR0h4Z0taT1R6T0x5UXphMjV1b0lvMndubWtr?=
 =?utf-8?B?ejBwVkMvL2hxbThCN25oYllrQnpERGtkZlhENzRhaFVucC8zQTQ4Z21wR2Y3?=
 =?utf-8?B?U21ZWWFyQ2JoQUNpNTdhMGRJOXVFaFFFb2Nyc0NXZnVCV2JXM1BISHM3QjBV?=
 =?utf-8?B?dlp6WjFEVzR0VGFBMWoyN3JrYWpFWHMwcUQ0L3owdkdaQ2RncGFWd2IzVGhX?=
 =?utf-8?B?YVRYbmQ0WkVQV1BzNjlwSzF1aUdkUHA2RHB1aHVYTEtBRHVIY04wUHMzeWJm?=
 =?utf-8?B?VEQrbjN4ZmFMRWJZU1VkZit0eVZNR0dWZEt6clk4ZEtVSTFtTGMrck1lV00r?=
 =?utf-8?B?aVpYNEtGU0ZKVXdIR3EraE9YNjdrd3pIVkJObzVXVXhQUDV5U2I3amFvRnRR?=
 =?utf-8?B?UnJkbnNnMXU2Z0Y4SnF5ZldoSkJKU1A3ZFZScFNMZ2UwaHJQSDI0c3U3ZWIr?=
 =?utf-8?B?bUdycmhuclZMMUhlOXNSeW9Ob2wyUUVGbXhmMzVKVjUvMHROdEZYWlVWMlF0?=
 =?utf-8?B?NzVNT0xEWVduTHdlbDRQNDFramQvRmZOU25FbjBDUFZjajVpTVQwYmFlajlW?=
 =?utf-8?B?V2VuR2MvM1ZJSS9zMnlPSWNWVVFMVDBwa1UwMjVNbmFkck1SRlNNVnphU09v?=
 =?utf-8?B?UTJHWjlYeWJ2S1NmbjZLSDV5N1JFZFFJSjEzZTFaRXFrN0lSbjRlSjZCNUpm?=
 =?utf-8?B?d3g3WHlGZ09RK1N6YWs5YnVaVEtGTi8rdXhCYzNKNW5XdUQ0Z2dXdlJtelZx?=
 =?utf-8?B?QmtYUCtsV2R1M3IvK1VFOE9WalVtL3dhTWhyRWY5dXlkUzM5c2pQcjNHSWhQ?=
 =?utf-8?B?TXZ0ZEdJMHUyZ0xwUzZUbitnVTV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <302323580A4A7742A715D6D47FC6B30C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697a06d8-a6ae-41c3-3baa-08d9c52009e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 07:52:44.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBvlUO7HhPAffvFVUFRzKdCD/zGlNmXdMKOXYyJeAvL+qYbbITo6fq3LG8Z0rqSkS1759DSvD4QBVVqwZwSRIXRIsd23IPNuD3TWkpRGVdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3423
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvMjEvMjEgNzowMCBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEZXNjcmliZSB0d28gbmV3IG1lbW9yaWVzIG1v
ZGVzOg0KPiAtIEEgc3RhY2tlZCBtb2RlIHdoZW4gdGhlIGJ1cyBpcyBjb21tb24gYnV0IHRoZSBh
ZGRyZXNzIHNwYWNlIGV4dGVuZGVkDQo+ICAgd2l0aCBhbiBhZGRpdGluYWxzIHdpcmVzLg0KPiAt
IEEgcGFyYWxsZWwgbW9kZSB3aXRoIHBhcmFsbGVsIGJ1c3NlcyBhY2Nlc3NpbmcgcGFyYWxsZWwg
Zmxhc2hlcyB3aGVyZQ0KPiAgIHRoZSBkYXRhIGlzIHNwcmVhZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAN
Cj4gSGVsbG8gUm9iLA0KPiANCj4gSSBrbm93IHRoZSBiZWxvdyBkb2VzIG5vdCBwYXNzIHRoZSB0
ZXN0cyAoYXQgbGVhc3QgdGhlIGV4YW1wbGUgcGF0Y2ggMw0KPiBkb2VzIG5vdCBwYXNzKSBidXQg
SSBiZWxpZXZlIHRoZSBpc3N1ZSBpcyBwcm9iYWJseSBvbiB0aGUgdG9vbGluZyBzaWRlDQo+IGJl
Y2F1c2UgdGhlIGV4YWN0IHNhbWUgdGhpbmcgd2l0aCB1aW5nMzItYXJyYXkgaW5zdGVhZCBpcyBh
Y2NlcHRlZC4gVGhlDQo+IHByb2JsZW0gY29tZXMgZnJvbSB0aGUgbWluSXRlbXMvbWF4SXRlbXMg
bGluZXMuIFdpdGhvdXQgdGhlbSwgdGhpcyBpcw0KPiBva2F5LiBUaGUgbWF4SXRlbXMgYnR3IG1h
dGNoZXMgdGhlICJnb29kIGVub3VnaCB2YWx1ZSBmb3Igbm93IiBpZGVhLg0KPiANCj4gVGhlIGVy
cm9ycyBJIGdldCBhcmU6DQo+IA0KPiAkIG1ha2UgZHRfYmluZGluZ19jaGVjayBEVF9TQ0hFTUFf
RklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxl
ci55YW1sDQo+ICAgTElOVCAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MNCj4g
ICBDSEtEVCAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQtc2No
ZW1hLWV4YW1wbGVzLmpzb24NCj4gICBTQ0hFTUEgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wcm9jZXNzZWQtc2NoZW1hLWV4YW1wbGVzLmpzb24NCj4gICBEVEVYICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xsZXIuZXhhbXBsZS5k
dHMNCj4gICBEVEMgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3Bp
LWNvbnRyb2xsZXIuZXhhbXBsZS5kdC55YW1sDQo+ICAgQ0hFQ0sgICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLmV4YW1wbGUuZHQueWFtbA0KPiAv
c3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xsZXIu
ZXhhbXBsZS5kdC55YW1sOiBzcGlAODAwMTAwMDA6IGZsYXNoQDI6c3RhY2tlZC1tZW1vcmllczog
W1syNjg0MzU0NTYsIDI2ODQzNTQ1Nl1dIGlzIHRvbyBzaG9ydA0KPiAgICAgICAgIEZyb20gc2No
ZW1hOiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNvbnRy
b2xsZXIueWFtbA0KPiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
c3BpLWNvbnRyb2xsZXIuZXhhbXBsZS5kdC55YW1sOiBzcGlAODAwMTAwMDA6IGZsYXNoQDI6c3Rh
Y2tlZC1tZW1vcmllczogW1syNjg0MzU0NTYsIDI2ODQzNTQ1Nl1dIGlzIHRvbyBzaG9ydA0KPiAg
ICAgICAgIEZyb20gc2NoZW1hOiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvbXhzLXNwaS55YW1sDQo+IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0LnlhbWw6IHNwaUA4MDAxMDAwMDogVW5l
dmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCcjYWRkcmVzcy1jZWxscycsICcj
c2l6ZS1jZWxscycsICdkaXNwbGF5QDAnLCAnc2Vuc29yQDEnLCAnZmxhc2hAMicgd2VyZSB1bmV4
cGVjdGVkKQ0KPiAgICAgICAgIEZyb20gc2NoZW1hOiAvc3JjL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvbXhzLXNwaS55YW1sDQo+IC9zcmMvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxlci5leGFtcGxlLmR0LnlhbWw6IGZsYXNo
QDI6IHN0YWNrZWQtbWVtb3JpZXM6IFtbMjY4NDM1NDU2LCAyNjg0MzU0NTZdXSBpcyB0b28gc2hv
cnQNCj4gICAgICAgICBGcm9tIHNjaGVtYTogL3NyYy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiANCj4gDQo+ICAuLi4vYmluZGluZ3Mv
c3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwgICAgfCAyNSArKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJv
cHMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlw
aGVyYWwtcHJvcHMueWFtbA0KPiBpbmRleCA1ZGQyMDkyMDZlODguLmZlZGI3YWU5OGZmNiAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcGVy
aXBoZXJhbC1wcm9wcy55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPiBAQCAtODIsNiArODIsMzEgQEAg
cHJvcGVydGllczoNCj4gICAgICBkZXNjcmlwdGlvbjoNCj4gICAgICAgIERlbGF5LCBpbiBtaWNy
b3NlY29uZHMsIGFmdGVyIGEgd3JpdGUgdHJhbnNmZXIuDQo+IA0KPiArICBzdGFja2VkLW1lbW9y
aWVzOg0KPiArICAgIGRlc2NyaXB0aW9uOiBTZXZlcmFsIFNQSSBtZW1vcmllcyBjYW4gYmUgd2ly
ZWQgaW4gc3RhY2tlZCBtb2RlLg0KPiArICAgICAgVGhpcyBiYXNpY2FsbHkgbWVhbnMgdGhhdCBl
aXRoZXIgYSBkZXZpY2UgZmVhdHVyZXMgc2V2ZXJhbCBjaGlwDQo+ICsgICAgICBzZWxlY3RzLCBv
ciB0aGF0IGRpZmZlcmVudCBkZXZpY2VzIG11c3QgYmUgc2VlbiBhcyBhIHNpbmdsZQ0KPiArICAg
ICAgYmlnZ2VyIGNoaXAuIFRoaXMgYmFzaWNhbGx5IGRvdWJsZXMgKG9yIG1vcmUpIHRoZSB0b3Rh
bCBhZGRyZXNzDQo+ICsgICAgICBzcGFjZSB3aXRoIG9ubHkgYSBzaW5nbGUgYWRkaXRpb25hbCB3
aXJlLCB3aGlsZSBzdGlsbCBuZWVkaW5nDQo+ICsgICAgICB0byByZXBlYXQgdGhlIGNvbW1hbmRz
IHdoZW4gY3Jvc3NpbmcgYSBjaGlwIGJvdW5kYXJ5LiBUaGUgc2l6ZSBvZg0KPiArICAgICAgZWFj
aCBjaGlwIHNob3VsZCBiZSBwcm92aWRlZCBhcyBtZW1iZXJzIG9mIHRoZSBhcnJheS4NCj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50NjQtYXJyYXkNCj4g
KyAgICBtaW5JdGVtczogMg0KPiArICAgIG1heEl0ZW1zOiA0DQoNCldoeSBkbyB3ZSBkZWZpbmUg
bWF4SXRlbXM/IENhbid0IHdlIHJlbW92ZSB0aGlzIHJlc3RyaWN0aW9uPw0KDQo+ICsNCj4gKyAg
cGFyYWxsZWwtbWVtb3JpZXM6DQo+ICsgICAgZGVzY3JpcHRpb246IFNldmVyYWwgU1BJIG1lbW9y
aWVzIGNhbiBiZSB3aXJlZCBpbiBwYXJhbGxlbCBtb2RlLg0KPiArICAgICAgVGhlIGRldmljZXMg
YXJlIHBoeXNpY2FsbHkgb24gYSBkaWZmZXJlbnQgYnVzZXMgYnV0IHdpbGwgYWx3YXlzDQo+ICsg
ICAgICBhY3Qgc3luY2hyb25vdXNseSBhcyBlYWNoIGRhdGEgd29yZCBpcyBzcHJlYWQgYWNyb3Nz
IHRoZQ0KPiArICAgICAgZGlmZmVyZW50IG1lbW9yaWVzIChlZy4gZXZlbiBiaXRzIGFyZSBzdG9y
ZWQgaW4gb25lIG1lbW9yeSwgb2RkDQo+ICsgICAgICBiaXRzIGluIHRoZSBvdGhlcikuIFRoaXMg
YmFzaWNhbGx5IGRvdWJsZXMgdGhlIGFkZHJlc3Mgc3BhY2UgYW5kDQo+ICsgICAgICB0aGUgdGhy
b3VnaHB1dCB3aGlsZSBncmVhdGx5IGNvbXBsZXhpZnlpbmcgdGhlIHdpcmluZyBiZWNhdXNlIGFz
DQo+ICsgICAgICBtYW55IGJ1c3NlcyBhcyBkZXZpY2VzIG11c3QgYmUgd2lyZWQuIFRoZSBzaXpl
IG9mIGVhY2ggY2hpcCBzaG91bGQNCj4gKyAgICAgIGJlIHByb3ZpZGVkIGFzIG1lbWJlcnMgb2Yg
dGhlIGFycmF5Lg0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQ2NC1hcnJheQ0KPiArICAgIG1pbkl0ZW1zOiAyDQo+ICsgICAgbWF4SXRlbXM6IDQNCj4g
Kw0KPiAgIyBUaGUgY29udHJvbGxlciBzcGVjaWZpYyBwcm9wZXJ0aWVzIGdvIGhlcmUuDQo+ICBh
bGxPZjoNCj4gICAgLSAkcmVmOiBjZG5zLHFzcGktbm9yLXBlcmlwaGVyYWwtcHJvcHMueWFtbCMN
Cj4gLS0NCj4gMi4yNy4wDQo+IA0KDQo=
