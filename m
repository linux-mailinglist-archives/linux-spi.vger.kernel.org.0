Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C914A601E
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 16:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiBAP2t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 10:28:49 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31954 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiBAP2o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 10:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643729324; x=1675265324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2MZOzWIUWy1BO8YzqQ5Y5Dlh88v2XduhyizTRckHQQo=;
  b=U+xFkGkW+mS5nchYaCTCsjIaAQtdMnf9WxgVB9TVoFwP0TZTBRHMRDqr
   eQ4ATzWKJVT+bGI/0ZgXKfw9zrUo2pnXWgudVvzWgonCCh/XxTaE/zM33
   q2kZEWGsn6rs/TdY9A23Ne5DPmAx9CSe5mg+UKiquKf+liX8qlEbKeJTD
   Y4IS/fUd6SL8e7sRgVpT+tdZvrp2Q+J3OT0TdMzFu4qT5lfpR95WCkUHr
   W+jwZHmIOluq1J0nLYw6g0FKu+ZrrPekApCDLHytGVdkJJ33d5kKQGbix
   XnoPEF6jiNS44A4LMqfJyyUXIDRoWsyW6+VfnLpg2G1zeZKHkVCgOjx2C
   Q==;
IronPort-SDR: cHTK9ekJNDjo8GcfYYO1K37DJ4hZFpBSwpBKX1LDTC+SgEJLrbi4wyFXBHbf14zNcYP6N8eT3R
 LKrViGmxdG6Xz/ZHOVEZPpJ7WKDqDZtzrg9SbAyUBcOKVeYEUW3q1zKX9LdCXQvPm8QJLyzniO
 42etjjg4pt7fl/YagipVpAywAF2uB4c4ikhgQhmOE8QbW5LvGvLkvs9WgXjjxtB74S8HNWBzCC
 MuXu/gwsjoGFB8v/G/vyUHMWeBAsnyGbLVFz2xBa11IWkOHJmSkMAwmuP8npsaNOtYrPWVz+rv
 Kweax5he7VB3T0XvXsY5pLPo
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="152113891"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Feb 2022 08:28:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Feb 2022 08:28:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 1 Feb 2022 08:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndWZOrZSwnObI7on+6qE+WZl9FlynayoTRr9EE2pGU8wXfVic8ayhYai6e1JvW+fg6DZrkbXKXdxzYQUSnuLoYyt4cKyixGGR5JPe7nzuURS0cNkqHMUvOb4zb2OxR9iHOTk3+jwWTGtPLyv0PotgsJ2w0Y4Fdb2ayCgnMkIXZP3N45iy/9M/TO/dzHf6krq+rSKgyOTcUEZSfHCMeVmPCJdrUxkR2tC7aRFs3txz6XcNRxfW9rZxcCqN1uoiucEaESsrDpO5XaG8aPZwq/XWmJPE8eJ4EbBi4iWs2kF8/30mNwDuuAjbNm2zav+/nP9OIaFgoQVkD1EbgZOpLf65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MZOzWIUWy1BO8YzqQ5Y5Dlh88v2XduhyizTRckHQQo=;
 b=LocY8APVKl7WGF+UF2i4kfLf4Hg4WcfxCVATuD+26fFzuki8acO8uPXeHIbkc4z8rA1uN3DjmwzyL3NaRP3ahKoRoHVOqd91ijrN+UTEWkTdAeXD8cOVmL5C7qNbjMEXsHxXWGg+xIUOnyncSsr6NxUg5Kn7F/edrZVSXkQGF/6t/TTqY23nigb/GcPWgk+hGtSaI5Yho2ZdW9YRAe1NgbGRylWvHaIPMf7E21uL69tRAGFENqcEGLrM/CK0xISYBbsDHuxRQu8yfNjgSETS68WaBZM4cb9lDGmT+PasbbW36lNhvqfA/C5pFTdh9MFTfwcOLP0xQNspXCbjOR1DHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MZOzWIUWy1BO8YzqQ5Y5Dlh88v2XduhyizTRckHQQo=;
 b=J7UqMHgrFn1/LvukoNoomvx/C+FPCMQwE8z8pqVRyWWqak+pfI/5b5SaHaH+4AavQknsb1saan/U4iR6aiJk27tm6D86IDb5ObXUgFe/Gf0t+Cn4YsHPKB05yG3SWtw6h22tKJRgH01SFRuzpBMwvliH2O2Ncd0RiEpuPVUEMnY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BY5PR11MB4497.namprd11.prod.outlook.com (2603:10b6:a03:1cc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 15:28:37 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94%2]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:28:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>, <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <boris.brezillon@collabora.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <corbet@lwn.net>,
        <mauro.lima@eclypsium.com>, <alexander.sverdlin@nokia.com>,
        <andriy.shevchenko@linux.intel.com>, <hans-gert.dahmen@immu.ne>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] Documentation / MTD: Rename the intel-spi driver
Thread-Topic: [PATCH v5 3/3] Documentation / MTD: Rename the intel-spi driver
Thread-Index: AQHYF4BhlTFbK5nkD0SprwZ8kLJ0Kw==
Date:   Tue, 1 Feb 2022 15:28:37 +0000
Message-ID: <b5d65bf9-80ac-3109-c81d-9877c44a7da8@microchip.com>
References: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
 <20211220164625.9400-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20211220164625.9400-4-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07743fdf-9f54-4bd6-3e87-08d9e597843f
x-ms-traffictypediagnostic: BY5PR11MB4497:EE_
x-microsoft-antispam-prvs: <BY5PR11MB44970A0F75B4E8A70F871FD3F0269@BY5PR11MB4497.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5Tit3U25p2nlmfgrkD3nMi5+4fIxX/eSkfBkuNJw/2siYVvzZEsB4fo/hDFWjToI713IM4EPVX+F06BFpgun6WeYDf0F311BKV55HH425aiBEQhoelgXL1T91lKaclEmXsRwCdFW1OR/WE5A03/bBFJfTqhiQ1qlkRozdyKt54rQnC6/ixHQr1b4E4voKXwzwC9NXP9SsL5KwUMJdsjLeAHCGePjXBozNHnwA9mrmoxIWdvZa0X44g2fNE5D4nIX6kzL/PjxD3eudeoCLTTSd7tKd5ZarljKTpMeLpTMOgduOlKl0AgJU1Hpe4S5T5Da/egULlCY9HKnA852ezD/f/h9hRcfkLd2eXAr55XG6UcIxEuT0y5SNI9phlcmy/Y3hKWqMLieJxowfw8jO2YuaMMQ9mWBH/+TSOM1+guI0ZZDof+jpN5W8TVQ7uZL02DYJ01H5yo7/PuWxTpedr0De531bxghyRkVtHjoSyE9YeuNFzabCedYBkU5wrqbfdBcmW5mStAArmAzV9MFVfbxrWq8mftPGTeQ1m4dsKaLkfBXYfgYI+BGc2ZPZh/EXxJ7xaD+DTSxQ1lpVUm2IqdIIRtJWSqRMMCNR5LQqD/PJPh7lIxKVaOGwTfmdB8kU+mLQ+Y9I6pHCbMlWmPa69IEn1KrbGiGHZjOb3JtHOkYQedoDDkL8AmIVNbZOYkgs4C5hotXfNnHMVf6Bq+nCPrTVP1i1xb5SC61j3q6uo7HgRrumL5T+03n1fExpqXTgXHBd0zEcFeFaG8a9gozPG3KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(508600001)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(91956017)(8676002)(8936002)(54906003)(110136005)(83380400001)(26005)(186003)(316002)(64756008)(38070700005)(6486002)(31696002)(2616005)(71200400001)(38100700002)(2906002)(36756003)(86362001)(122000001)(31686004)(5660300002)(7416002)(53546011)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnRybEQ2b1B1ZVJmQkM4anoxYkN5MXRhSis0OGN3cmNtN0JVQWxraEpBblpR?=
 =?utf-8?B?TEVsZEdXcVRnMDlQVTFYRHRVZ0JwUFdWNERsckVQV0RJZVJsalBOaksybUpV?=
 =?utf-8?B?d1NvOTM1RXM5aVMra3dlRkpQRTNXS1JMejkzR0ZNZFJ2YXR0RWdpL2xmcWQ4?=
 =?utf-8?B?QitoZGp0QktKYmQzWE9SNTUyUFhVaFhYSDZhbTFka0x2bmI3Wjk0elRYYlJn?=
 =?utf-8?B?SG1CYnpOSlNXSC9Tc1RFRUtBQi9KYmI5Rk80VjdTa01hZmQvYWZKVVNqU2da?=
 =?utf-8?B?d3NicWovKzBLdWhtNElHRWwxdGhicXFOSlB4MGxFQXZGeS9yVnU3YXlHeG9E?=
 =?utf-8?B?WTU2WklySWZaRGE1VVdLTzhteEltMTFjZWlxZkJPeFhSOW1ra2F3YlJDN0c0?=
 =?utf-8?B?dFFucU1OQXB0cHVoR2RtaFJRUkMwVmJNbjAwbG1UVW9XQkVacUdUbE9nQXJT?=
 =?utf-8?B?aVd4cjBqVXpkbEJ5ZnpIVFBFM3JGN3YrbHhsRUxGdWVpY1M0RWc1OTFRc256?=
 =?utf-8?B?VkhZU1BicnBzT0xSOHN1UE1lZmt0cjZDNVpzbmhYemgzeWJydzlJS2pjRTRZ?=
 =?utf-8?B?T0ZyNlRTS2IyOVpFNkMrYlRDb21WUnJLZ2xzR3JmSThjeEJFUW04UjZaNGQz?=
 =?utf-8?B?KzZKbmNpSnFveGZ5RUgwNjBRZEcybXQxYUtQRU1JWnc1SGw3WHpKWDk1cHZ0?=
 =?utf-8?B?aHpQRGZUekE0YVZNOEcvV05DYjh4VTNCNDMxZGhyaVdXMWdLNk1aM2EyYmpJ?=
 =?utf-8?B?aG9qTGdRclpFMllSdjhqZFlkM2NldFJDZ0hrcWpkM2p4OUxRQm5mZUFmM0Nn?=
 =?utf-8?B?dkhZOE94SnlzYXdpbXBVMHMvUzlXM2VlVWJGcWhGekJxUU5EbkZlOHpvSU1w?=
 =?utf-8?B?LzdyWjBOKzY0N01FN3RDeit5Zko3bzFuWHUrMTRDaWJOWTBIY1VEdURXZTJI?=
 =?utf-8?B?aElmLzNBcnlLNzJSS2dEZFljQTlzSjkxRHpEVytxb1FLelZTaGF1V2lBU01i?=
 =?utf-8?B?TEpzYWN2Vk1sM1ovYlEwZVJoRVVkblFiOWJMd1RjQnFGTEZHK1FqQm02ZnVV?=
 =?utf-8?B?UHpESVVFYUNLOUtvK0RRcGpqNWV6aGtLUGpLNXRaSjM4OUFaY05oRjI5eWR6?=
 =?utf-8?B?dkQzb1JFSVhLclhRQ0c1WXNzaEVqanRJaHVwQnk0OHNsOVZ6cmJORWZmSVMx?=
 =?utf-8?B?eUhkT2pHdkkvdSsyL04yVzVjeFBJOUVVQWVaZENwdXpDY2dvRDBFa3ZQeHpr?=
 =?utf-8?B?cWlRdHdvM1k4UlNHQ1ViOWxFVmhzUlloOU83bng4QnVSRkNxS3Iwem43Z3p1?=
 =?utf-8?B?WU5KbGNrNGVhM3o2NnpCbWxKUFM1bFFWZnZWeVoraVFYY2NTQmhOam9UckN1?=
 =?utf-8?B?bXpBaEJ5YU9URGs1NWFTK0crWEpQMXltS2Q4cGNyRlp2dnJ1M3pmSjJ2MmxP?=
 =?utf-8?B?N1RDdnRrYXdTaWpQRDRWUVdGRm1zeW95bHkzdzJkTU5uMjNzSngwLzRMUm9y?=
 =?utf-8?B?MGlQak1TRit3ZXowVkdzd0o3bXJRZER3cFZzK2JyMlgydlRMcityQzQ0YVpz?=
 =?utf-8?B?bmwxM2xMM3dvczFydW5OdDNQV1RQUE1hOUpTZ1g4T3ErWlVmNElGTURtcFVo?=
 =?utf-8?B?THF6bU9DZURNTnBvcTZBVm1jNlRrUDJablEwOFFqMkNQd25FQkwwS203S05I?=
 =?utf-8?B?NHpNOUVnNTFvaGNXUUs2VFVXV0JyNnVDMms5UmlwdE9XMEVJOFpTQS9jaGFZ?=
 =?utf-8?B?V3dwYktJRXlFRys0S3JLazhaOFp3MWNmdFdCZFhUOUhoaG5wZHJTR0V3YlE4?=
 =?utf-8?B?Z1gzZmd4RFc2V2MwelVYaVdSNWxmQzVsSlJOcEptSzRpUWRSMGVzTVM0ajZo?=
 =?utf-8?B?QXQzR2lBWlArdzF3Q1Y0aXVkVXhqVlZSMjBnNEpXckNaSGxySW9RN3JkOFJR?=
 =?utf-8?B?Vzc4L041MDFYdkhtaGN1R2F0N2NvSHhjSFF5R0pUdkhTS2EvazlsNkRudVA1?=
 =?utf-8?B?YWtkK2Q3S0NsekVuZTlrRlpjenUwNlJXTVNGaVJMWjZuWnFRaStCMGwzUldj?=
 =?utf-8?B?NFZHZ1JBUlI5NEd5SHJaWGQ1RE1DbHljd3RRZUNhaitlcEZFdXAwajgrMjd3?=
 =?utf-8?B?TE5aTFNteGZFNDZkKzVwa0o2am9PcGpKd2Z0L2FCMHRTVlp6T096dHlzNDZ4?=
 =?utf-8?B?NVlDUnZKVTUvSWdIZTAvYzQrcjE3REFHa1BHWjZYUDlHR0swbVl5em5MSVpV?=
 =?utf-8?B?K094aTFZZ0tXNUZUSlpPQTgrUU9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB979A999C6BDE48ABDC032233CA80DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07743fdf-9f54-4bd6-3e87-08d9e597843f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:28:37.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiyYQJh1lUl5V/IzpBiOgM4zO5rEIEAY1fKnAP+m6MgAmpf4qVQ+te5NU9qmJKDDnihcxkpySOJKBt7yiIkMbVTMWaStzElVPtELShB3BKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4497
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvMjAvMjEgMTg6NDYsIE1pa2EgV2VzdGVyYmVyZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTaW5jZSB0aGUgZHJpdmVyIGlzIHJlbmFtZWQg
KGFuZCBtb3ZlZCkgdXBkYXRlIHRoZSBCSU9TIHVwZ3JhZGUgZ3VpZGUNCj4gYWNjb3JkaW5nbHkg
ZnJvbSBpbnRlbC1zcGkgdG8gc3BpLWludGVsLiBLZWVwIHRoZSBndWlkZSB1bmRlciBNVEQNCj4g
ZG9jdW1lbnRhdGlvbiBiZWNhdXNlIHRoaXMgaXMgcHJldHR5IG11Y2ggc3RpbGwgYWJvdXQgTVRE
IGFuZCBTUEktTk9SLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlrYSBXZXN0ZXJiZXJnIDxtaWth
Lndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hl
bmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBN
YXVybyBMaW1hIDxtYXVyby5saW1hQGVjbHlwc2l1bS5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRv
ciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBEb2N1
bWVudGF0aW9uL2RyaXZlci1hcGkvbXRkL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgICAgfCAy
ICstDQo+ICAuLi4vZHJpdmVyLWFwaS9tdGQve2ludGVsLXNwaS5yc3QgPT4gc3BpLWludGVsLnJz
dH0gICAgICAgfCA4ICsrKystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbXRk
L3tpbnRlbC1zcGkucnN0ID0+IHNwaS1pbnRlbC5yc3R9ICg5NCUpDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL210ZC9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9u
L2RyaXZlci1hcGkvbXRkL2luZGV4LnJzdA0KPiBpbmRleCA0MzZiYTVhODUxZDcuLjZhNDI3OGY0
MDlkNyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL210ZC9pbmRleC5y
c3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL210ZC9pbmRleC5yc3QNCj4gQEAg
LTcsNiArNyw2IEBAIE1lbW9yeSBUZWNobm9sb2d5IERldmljZSAoTVREKQ0KPiAgLi4gdG9jdHJl
ZTo6DQo+ICAgICA6bWF4ZGVwdGg6IDENCj4gDQo+IC0gICBpbnRlbC1zcGkNCj4gKyAgIHNwaS1p
bnRlbA0KPiAgICAgbmFuZF9lY2MNCj4gICAgIHNwaS1ub3INCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS9tdGQvaW50ZWwtc3BpLnJzdCBiL0RvY3VtZW50YXRpb24vZHJp
dmVyLWFwaS9tdGQvc3BpLWludGVsLnJzdA0KPiBzaW1pbGFyaXR5IGluZGV4IDk0JQ0KPiByZW5h
bWUgZnJvbSBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbXRkL2ludGVsLXNwaS5yc3QNCj4gcmVu
YW1lIHRvIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tdGQvc3BpLWludGVsLnJzdA0KPiBpbmRl
eCAwNDY1ZjY4NzkyNjIuLmRmODU0ZjIwZWFkMSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kcml2ZXItYXBpL210ZC9pbnRlbC1zcGkucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJp
dmVyLWFwaS9tdGQvc3BpLWludGVsLnJzdA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtVXBncmFkaW5nIEJJT1MgdXNpbmcgaW50ZWwtc3Bp
DQo+ICtVcGdyYWRpbmcgQklPUyB1c2luZyBzcGktaW50ZWwNCj4gID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiANCj4gIE1hbnkgSW50ZWwgQ1BVcyBsaWtlIEJheXRyYWlsIGFuZCBC
cmFzd2VsbCBpbmNsdWRlIFNQSSBzZXJpYWwgZmxhc2ggaG9zdA0KPiBAQCAtMTEsMTIgKzExLDEy
IEBAIGF2b2lkIGFjY2lkZW50YWwgKG9yIG9uIHB1cnBvc2UpIG92ZXJ3cml0ZSBvZiB0aGUgY29u
dGVudC4NCj4gIE5vdCBhbGwgbWFudWZhY3R1cmVycyBwcm90ZWN0IHRoZSBTUEkgc2VyaWFsIGZs
YXNoLCBtYWlubHkgYmVjYXVzZSBpdA0KPiAgYWxsb3dzIHVwZ3JhZGluZyB0aGUgQklPUyBpbWFn
ZSBkaXJlY3RseSBmcm9tIGFuIE9TLg0KPiANCj4gLVRoZSBpbnRlbC1zcGkgZHJpdmVyIG1ha2Vz
IGl0IHBvc3NpYmxlIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBTUEkgc2VyaWFsDQo+ICtUaGUgc3Bp
LWludGVsIGRyaXZlciBtYWtlcyBpdCBwb3NzaWJsZSB0byByZWFkIGFuZCB3cml0ZSB0aGUgU1BJ
IHNlcmlhbA0KPiAgZmxhc2gsIGlmIGNlcnRhaW4gcHJvdGVjdGlvbiBiaXRzIGFyZSBub3Qgc2V0
IGFuZCBsb2NrZWQuIElmIGl0IGZpbmRzDQo+ICBhbnkgb2YgdGhlbSBzZXQsIHRoZSB3aG9sZSBN
VEQgZGV2aWNlIGlzIG1hZGUgcmVhZC1vbmx5IHRvIHByZXZlbnQNCj4gIHBhcnRpYWwgb3Zlcndy
aXRlcy4gQnkgZGVmYXVsdCB0aGUgZHJpdmVyIGV4cG9zZXMgU1BJIHNlcmlhbCBmbGFzaA0KPiAg
Y29udGVudHMgYXMgcmVhZC1vbmx5IGJ1dCBpdCBjYW4gYmUgY2hhbmdlZCBmcm9tIGtlcm5lbCBj
b21tYW5kIGxpbmUsDQo+IC1wYXNzaW5nICJpbnRlbC1zcGkud3JpdGVhYmxlPTEiLg0KPiArcGFz
c2luZyAic3BpX2ludGVsLndyaXRlYWJsZT0xIi4NCj4gDQo+ICBQbGVhc2Uga2VlcCBpbiBtaW5k
IHRoYXQgb3ZlcndyaXRpbmcgdGhlIEJJT1MgaW1hZ2Ugb24gU1BJIHNlcmlhbCBmbGFzaA0KPiAg
bWlnaHQgcmVuZGVyIHRoZSBtYWNoaW5lIHVuYm9vdGFibGUgYW5kIHJlcXVpcmVzIHNwZWNpYWwg
ZXF1aXBtZW50IGxpa2UNCj4gQEAgLTMyLDcgKzMyLDcgQEAgTGludXguDQo+ICAgICAgc2VyaWFs
IGZsYXNoLiBEaXN0cm9zIGxpa2UgRGViaWFuIGFuZCBGZWRvcmEgaGF2ZSB0aGlzIHByZXBhY2th
Z2VkIHdpdGgNCj4gICAgICBuYW1lICJtdGQtdXRpbHMiLg0KPiANCj4gLSAzKSBBZGQgImludGVs
LXNwaS53cml0ZWFibGU9MSIgdG8gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgYW5kIHJlYm9vdA0K
PiArIDMpIEFkZCAic3BpX2ludGVsLndyaXRlYWJsZT0xIiB0byB0aGUga2VybmVsIGNvbW1hbmQg
bGluZSBhbmQgcmVib290DQo+ICAgICAgdGhlIGJvYXJkICh5b3UgY2FuIGFsc28gcmVsb2FkIHRo
ZSBkcml2ZXIgcGFzc2luZyAid3JpdGVhYmxlPTEiIGFzDQo+ICAgICAgbW9kdWxlIHBhcmFtZXRl
ciB0byBtb2Rwcm9iZSkuDQo+IA0KPiAtLQ0KPiAyLjM0LjENCj4gDQoNCg==
