Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610793DE4F1
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 06:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhHCENe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 00:13:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:64789 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHCENe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 00:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627964003; x=1659500003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u79WXcTqJpQhB2LdFjhlnfX+rp97YksDiBlt8BGbOT4=;
  b=pr3cSaG4b4nCyBv31M4mi+VsJZ+nQJOWO5BoJm0PCyJanNYo2TUQTX7M
   MI4Hfed5SCtHHzYaH2NaFj9qSHlaPKi3JjdjO5cGmdMzIO62VDPZxvGbX
   HD1BLY34x/38zDytdoFrKWgxpbnGjTQmIcylZqP5sByYYFFQtQTX+xCAS
   HUNP87BkXXirt1/hPcCkrIgbsoXAdiJSe1pkc72W45wQ+Z1KxIz9YhMX+
   YDF8pNB2YyYQ8jYeEc6Wwi40LlvYBa3XOTH/GM24urDek4ZGb5BXaMlXx
   +wVy5tapQw9le4jLmJLkd1/AdoxTd6V6iH3rRothwrpcoTGZ8/94U6Ocf
   Q==;
IronPort-SDR: rNz6zBjcEyXUdxkYaCnN61LU3twtmgiWkAim8M+bXxDOWnISn9yQIuUr57hQTQhffz+G4fFMe+
 CJIvu9owiYgAjH7rUxCotZ0YuNXCiSgnbdaFBzfDOfwvcq3oSBO2EX4oZVO95hl/0xGBXr0Htx
 5XYQRCgdmTE5i/kCRh0GrjLyTkq5dSVLMCzxJRwIi3+j8LQkYnPkDDXI3oj3Iwu3bJgNdlEmzt
 sT8ZcHaaDeAJ/eppOMbR0wF5vMZ1fXkU1v08oVzkU9yi3oEzjJFD8/IaoDVbqliSPcp38MDywe
 4G0rKQBJq31QLlLdkUJ0BJq8
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="124356346"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2021 21:13:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 21:13:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 2 Aug 2021 21:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5BL+Sb026N8TDCS2Iw3L1uvYNwAQTkKwtbITmDq1WcmEnpzBbdrrX3hyV3afL+GPJ0oHXfE24//k0YRA/8wAcybRWhRgkrnuWtgpCHp8j2Qepzx3LUvwjBMn6K/knpbye7F6hN0CzWgT8sjdzpKfEMSf8zTni9Wl9Klpem3ewgOxIn+nG+Q9y03la1A+Np52AMQG/MmOffX3chu1n5T686+w4kJpUDPWrZeU+unwkCyzQXNI9iVKeJCGPce16rQN6FMU2N+RKfqR9CUaGLoQq2z0MKLL+z7Jn09TGDyYpLPmkL4Ki+1TLfF3jyK26OSLgtBl+Y6AwAAhHTcPAd8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u79WXcTqJpQhB2LdFjhlnfX+rp97YksDiBlt8BGbOT4=;
 b=RZpkwvJAU/EXU/Yt3hyuPQOIMn5Hq2RImXBo0zVaWgiHZBfVtCathfD2Ft0eLVAK5C99udEHM8/gxx8dtFGwjpAB4irCjMRB+AFbHUd0I6fSp1E5krG5+6PVdwoHk+SGSRdFnQS1noa7gM96COp8fIltEI0OwF8jydA81FQDsG8d2OO6d6UEcAW0qERayWMTqGpVtZVkhrNlBF7XlDZy5vAV+hEcyNz3OoludTZhnYr3+Z/G+EgbPD8R5jEl2mn/oreOtHcVrexD5+aJ/X48ecZMK5WPe+u7pbeN3a0inDDImg82dphSJmcYEEqSJNU/Kd0Hz8J5fPg2RTS5mOXeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u79WXcTqJpQhB2LdFjhlnfX+rp97YksDiBlt8BGbOT4=;
 b=Qb75Gc9idmN//y1qOuR/5lt/BBNp5ndLCNug9mu1VNHw4Pmq3ozVQv2dVj+gduSSYebOsRGoEGaZa1g17TfogN/o15Yym4koRf5zISD96r703EObJFQhumlkjYM3aKvbu3AtRCGLz+AEXc4WFWeMpPn9M3eLoL91OhqUbHPi7t0=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1517.namprd11.prod.outlook.com (2603:10b6:301:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 04:13:17 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 04:13:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <zajec5@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <kdasu.kdev@gmail.com>,
        <boris.brezillon@collabora.com>, <broonie@kernel.org>
Subject: Re: spi-nor 5.11 regression: Division by zero in kernel
Thread-Topic: spi-nor 5.11 regression: Division by zero in kernel
Thread-Index: AQHXh6w7feQOFoOjKU6jPSqwWqSZhg==
Date:   Tue, 3 Aug 2021 04:13:17 +0000
Message-ID: <49a27595-a0c5-24b0-e085-858bec2989d9@microchip.com>
References: <99bdb1eb-71a8-99e6-be03-a97185246740@gmail.com>
 <b3d23f9d-5c84-c4cc-dede-85ec85135276@microchip.com>
 <20210802181201.wkff3k32to3lin4n@ti.com>
In-Reply-To: <20210802181201.wkff3k32to3lin4n@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 162059fa-c1b2-495e-5fbf-08d95635054c
x-ms-traffictypediagnostic: MWHPR11MB1517:
x-microsoft-antispam-prvs: <MWHPR11MB1517DEB1204D62C1E4EC082CF0F09@MWHPR11MB1517.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcYjby+epvu/N2QKTTXFYULvbTUg7nSBe6aeWvpXVCNisom3kWiS4hScCJV6E3H6rW+1jy1dXTZoBIjsjF5KuJTieWB1pFKdnDuj7ZY8t3NkB6csqluojtfCCLAvqk9IkWqkrlG/oyWSWRXe5bOULq/qwrZx2hWir/1fOlWpt8BxovuIi8pLSkpNnmy1zE0Igu2pG9JJ8RsH3cKp5yKSsJwnZTbLzHyhb0hppJCxm3swsUpq9RsS5u1AmWj1toYebsVCwrjmwX2QjdXBFMTWukBecJnFD1KyIIXYGXM877qkM7+blUb9MQYwDJOj/BJ74Az/xc5RAXMPoV5pDMLh6IRWuG7qs2iJGUO7nuEjud65cDZ6JPMPHfseJ+6MMuh6NICIYaoRDfb5jS2ZntSHGLmNz+pzQnNlzGE15Bse0b8Wv9K7O49gj7LjvyyAL+xYN033uCp85bdowJVQzzNnSf8lpka/6c481uToQtI61nyst7KNr75AxhihiQoUiPuoEmMWKig1MPDwqYNmWOl/GmhjNlBRAPSv+kR0EiKLNu+aXdqUYj/4qeL8sEO6sgxv8cfmv3ptNgi2U1kMcWWXswn0OMkVTSr+TxVwcvp9aiLFOGmIk6cOrew4gmo/rxy14xgN2dIrdINoGo4yUynDJakzvfkwK2MLfmLpD/EsAh7nQ6Al5W7yqZCnIs4ssrr7j+sS5ESeTcXbPU3F3FCVziW3v0fVA2ugfxCygjNpUh1H5mKtqaRHBbXeBRRpIETQnxUCQZdXqZBclYQ3JAcFfkWrPcKuF04l3/icyH7cNnpMGCIu+bOa06We2ghdNFSzyE/du3NqWIY/S6OSVHi975f07iUNCng3e8F7IrdWUxQCRiBDCPU+NxnnqCo6IbhTURx7JbUgFevYn1nHYNw9tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39860400002)(346002)(4326008)(26005)(6506007)(53546011)(86362001)(186003)(8936002)(71200400001)(5660300002)(316002)(6486002)(66476007)(31696002)(54906003)(6916009)(478600001)(66556008)(66446008)(64756008)(122000001)(38100700002)(2906002)(966005)(2616005)(8676002)(6512007)(38070700005)(66946007)(36756003)(76116006)(31686004)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2hKRkJKbFpTSWpRK2RDSnVNU21JMlRDcDNqVGlpT3ZLb3VOOHJ1NFJKZjR2?=
 =?utf-8?B?WGpXelh3aWdrQ1VTeEthZkRrTmZ6VjNPYWtPdW5tbG5sZWkxNzhVRWp0cCtS?=
 =?utf-8?B?UTFmYTVCcFExOFROWkVIaEo3SnRLaWx0cjBNa1pKU216NFNHVlczRGpNMXVI?=
 =?utf-8?B?V2RkaGs5dlgzMzF4N3ViQnJNRTkvRnBCcFp2Z1BLNHYxV2JKOHk4RWVSbS9l?=
 =?utf-8?B?eFZtcWFYdlF2aU9LclhuY0FXUHgrWFNQTG9yTXhWYmN0MFVtQzJlUnl0VFVY?=
 =?utf-8?B?L3BJWHp6eElxOXI0S1ZuL1ljVWVNdmxlUmtobTlPaWFLc2pSMnU4Z2pHOXpF?=
 =?utf-8?B?dy9WQ2JTZ2IzdU5iekxiUklOYk5lRWRWdDh4S1ViOWpmbUE4emU0QnVSS0I1?=
 =?utf-8?B?QzBRVTRlcEFFdEZQbytGL1ozd2lRaGVhRSsreGYrQkFlVFU2RFJxR3NZOXNQ?=
 =?utf-8?B?eHlqVlFWNitoc3Z1WHFObkNvM01Oc3FVVXBFZGwrNjhzWGwzdjQybm1yaHVz?=
 =?utf-8?B?dGhOeElIbUpZVnA0eDU3Qk1qbWYrZjR2alpGbjEyalc5R21LTzl3ZC80RHBQ?=
 =?utf-8?B?cUN2REgzbmNJa1ZVZlQveGNXZHJPcUM4NUZjeEpSeStIK2hWMDRMY0EzN2tD?=
 =?utf-8?B?SmorL0g3Q1hwOThKRWJoZzBSaHJveTlUVHN0KzBidDc0S2pKNmdaMUUrSDBp?=
 =?utf-8?B?aGM4TE83dlRzck9KYUMvRS9FNjZqRlcwVXNPUkErOWRQb1N0d3hldnZVbnFh?=
 =?utf-8?B?dFBPT21ZcmMyOEdDTXJDYUJ5NEtZOUE1amxFK0VEZVNjdkpHYSs1a0UzM2o3?=
 =?utf-8?B?Y1FYQU5BNyszaldQNWhvOFJRUG9VTkYxNkVDbVllRFI2WmhSeGEydWhQK1ZV?=
 =?utf-8?B?bUUvWC9rTTdremdJSzVQb3c4elBCNk9FeHdQaWpUNWRQRFFlcFkxS3pjNGNU?=
 =?utf-8?B?TEFnenVNU05SZ3Y4WG9VcGJSbGNSdWY3S0NMaUNNY1RLSjhHRzhrTko0RE1q?=
 =?utf-8?B?dzlzRWRRdDRtY3dqZXVWNThuWVpMQ0t2SkFIeDZmQVpibXJQTm5NSm5tVENK?=
 =?utf-8?B?cTN2SVpYQjNwenExZVNLdFZnQWxLc2hmQTcyNFNlTXlJSFZzd1RNV1czMm5q?=
 =?utf-8?B?OEpDQXJ2RHFoNzM5UkdYcHdXVzg0bi9aT1FRWFZKWHRwaHljYUNwbitRdWdP?=
 =?utf-8?B?YkZvVjZTUm0yQ0V2TCt2djFobVY2RHlNanhCSExKbEdKbHlwUzl2aTZreWk2?=
 =?utf-8?B?N0dTcWQxSTJHRlhLc2s0RjZkYmZBYzVmVjNxa3RiTU1YK2J3VDVUNXZ4Qk40?=
 =?utf-8?B?STkzNjdXNUtmbnY1Q1k0N3I2K29NWncrZ1QvNE5PM2VEKys5b2FWK2QzWTZa?=
 =?utf-8?B?V1RmMnJvaWxrc29CNlNIRXBtSGloSngvb2tBUTVHUGhhdk90amJhMytRaS9k?=
 =?utf-8?B?M1plbE5EOEVTL3U2ekpOV1M3Q0ZDQllkTzA4MHg1YllvY2hjeUV2R0Z6dkIr?=
 =?utf-8?B?aW1SdzVsVXF5RS9Ta3Fndm54ZjI4WTdvbGVKQW9HcmRkdlVMeWVqc09td0xp?=
 =?utf-8?B?bzVqcElsSlFqdlB6ZVNPU3dmaU5QSVFyZW9mUDVwWVlhSlZrd0VvalUwN3lj?=
 =?utf-8?B?VXBYZVFmMUwrdHFmTXJBVFlISSt5dWREMCtpMm1RMUJic2JRa1FuRW82Tzhr?=
 =?utf-8?B?ZmdyV29vV2ZjUUZPTGo0ejVaYnI0NTQvYWpyYTBPUU9RYXVJQ0lTNFNVUy9I?=
 =?utf-8?Q?qey5ob2Ra0sPIVhDZc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <56950876C7E65F4D9D143C703973C594@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162059fa-c1b2-495e-5fbf-08d95635054c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 04:13:17.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOph3ih4XoszJ48GKOgfBSF3n74SS7A/8gxDJERykmqajoT4wT7MTwkpS9XCBcIn/RPUrmPZzcsF6PonNyLpWxJkfigpcpZf48qMWp0H7Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1517
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gOC8yLzIxIDk6MTIgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+ICsgTWFyaw0KPiANCj4gT24gMDIvMDgvMjEgMDI6
MzlQTSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gOC8yLzIxIDQ6
MjQgUE0sIFJhZmHFgiBNacWCZWNraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEhpLA0KPj4NCj4+IEhpLCBSYWZhxYIhDQo+Pg0KPj4+DQo+
Pj4gSXQgc2VlbXMgdGhhdCBrZXJuZWwgNS4xMSBicm9rZSBzcGktbm9yIG9uIEJyb2FkY29tIE5v
cnRoc3RhciAoQkNNNTMwMVgpDQo+Pj4gcGxhdGZvcm1zLg0KPj4+DQo+Pj4gVGhlIHByb2JsZW0g
c2VlbXMgdG8gYmUgc3BpX25vcl9zcGltZW1fcmVhZF9kYXRhKCkgd2hpY2ggY2FsY3VsYXRlczoN
Cj4+PiBvcC5kdW1teS5uYnl0ZXMgPSAobm9yLT5yZWFkX2R1bW15ICogb3AuZHVtbXkuYnVzd2lk
dGgpIC8gODsNCj4+Pg0KPj4+IE9uIE5vcnRoc3RhciB0aGlzIGhhcHBlbnMgdG8gYmU6DQo+Pj4g
b3AuZHVtbXkubmJ5dGVzID0gKDAgKiAwKSAvIDg7DQo+Pj4NCj4+PiBUaGF0IHJlc3VsdHMgaW4g
YmNtX3FzcGlfYnNwaV9zZXRfZmxleF9tb2RlKCkgZGl2aWRpbmcgYnkgemVybyBpbiB0aGU6DQo+
Pj4gYnBwIHw9IChvcC0+ZHVtbXkubmJ5dGVzICogOCkgLyBvcC0+ZHVtbXkuYnVzd2lkdGg7DQo+
Pj4NCj4+PiBDb3VsZCB5b3UgdGFrZSBhIGxvb2sgYXQgdGhhdCBpc3N1ZSwgcGxlYXNlPw0KPj4+
DQo+Pj4gR09PRCAgICA1LjEwLjU1DQo+Pj4gQkFEICAgICA1LjExLjIyDQo+Pj4gQkFEICAgICA1
LjEyLjE5DQo+Pj4gQkFEICAgICA1LjEzLjINCj4+PiBCQUQgICAgIDUuMTMuNw0KPj4+DQo+Pg0K
Pj4gSXQncyBoYXJkIHRvIGd1ZXNzLiBXb3VsZCB5b3UgcGxlYXNlIGJpc2VjdCBhbmQgaWRlbnRp
ZnkgdGhlIGNvbW1pdCB0aGF0IGludHJvZHVjZXMNCj4+IHRoZSByZWdyZXNzaW9uPw0KPiANCj4g
SSB0aGluayB0aGUgYnVnIGlzIHByZXR0eSBvYnZpb3VzIGhlcmUuIG9wLT5kdW1teS5idXN3aWR0
aCBpcyAwIHdoZW4NCj4gdGhlcmUgaXMgbm8gZHVtbXkgcGhhc2UsIGFuZCB0aGF0J3Mgd2h5IHRo
ZXJlIGlzIGEgZGl2aXNpb24gYnkgemVyby4gVGhlDQo+IGNvbnRyb2xsZXIgZHJpdmVyIGRvZXMg
bm90IGNoZWNrIGlmIHRoZSBkdW1teSBwaGFzZSBleGlzdHMgKGJ5IGNoZWNraW5nDQo+IG9wLT5k
dW1teS5uYnl0ZXMpIGJlZm9yZSBwZXJmb3JtaW5nIHRoZSBjYWxjdWxhdGlvbi4gSSBzYXcgYSBz
aW1pbGFyDQo+IHBhdGNoIHBvc3RlZCBmb3Igc3BpLWNhZGVuY2UtcXVhZHNwaS5jIFswXS4gVGhl
IGZpeCBpcyBvYnZpb3VzIElNTy4NCj4gDQo+IEJUVywgSSB0aGluayB0aGlzIHdhcyBpbnRyb2R1
Y2VkIGJ5IDBlMzBmNDcyMzJhYiAoIm10ZDogc3BpLW5vcjogYWRkDQo+IHN1cHBvcnQgZm9yIERU
UiBwcm90b2NvbCIpLiBJdCBzZXQgYnVzd2lkdGhzIG9mIG5vbi1leGlzdGVudCBwaGFzZXMgdG8N
Cj4gMC4NCg0KSSBzZWUuIElkZWFsbHkgdGhpcyBzaG91bGQgaGF2ZSBiZWVuIGRvbmUgaW4gYSBk
ZWRpY2F0ZWQgcGF0Y2ggZW5zdXJpbmcgdGhhdA0KYWxsIHRoZSBjb250cm9sbGVycyB0aGF0IGV4
cG9zZSB0aGUgbWVtX29wcyBhcmUgaGFuZGxlZC4NCg0KPiANCj4gVGhlIG1haW4gcXVlc3Rpb24g
aXM6IGRvIHdlIHdhbnQgdG8ga2VlcCB0aGUgYnVzd2lkdGggMCB3aGVuIHRoZSBkdW1teQ0KPiBw
aGFzZSBkb2VzIG5vdCBleGlzdD8gSXQgc2VlbXMgdG8gYmUgdHJpcHBpbmcgdXAgY29udHJvbGxl
ciBkcml2ZXJzLg0KPiBGV0lXLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIGl0IDAgc2luY2UgSSB0
aGluayB0aGF0IHdoZW4gZHVtbXkubmJ5dGVzDQo+ID09IDAgdGhlIG90aGVyIGZpZWxkcyBzaG91
bGQgYmUgImRvbid0IGNhcmUiLiBUaGUgcmVzcG9uc2liaWxpdHkgc2hvdWxkDQo+IGxpZSBvbiB0
aGUgY29udHJvbGxlciBkcml2ZXIgdG8gY2hlY2sgdGhpcy4NCj4gDQo+IFRob3VnaHRzPw0KDQpJ
J20gZmluZSB3aXRoIGtlZXBpbmcgdGhlIGJ1c3dpZHRoIDAgd2hlbiB0aGUgZHVtbXkgcGhhc2Ug
ZG9lcyBub3QgZXhpc3QuDQpXb3VsZCB5b3UgcGxlYXNlIGNoZWNrIGFsbCB0aGUgY29udHJvbGxl
cnMgdGhhdCBtYXkgZ2V0IHRyYXBwZWQgaW4gdGhpcyBhbmQNCmZpeCBhbGwgaW4gYSBzaW5nbGUg
cGF0Y2g/DQoNClRoYW5rcywNCnRhDQo+IA0KPiBbMF0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L3NwaS1kZXZlbC1nZW5lcmFsL3BhdGNoLzkyZWVhNDAzLTliMjEtMjQ4OC05
Y2MxLTY2NGJlZTc2MGM1ZUBuc2tpbnQuY28uanAvDQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+IHRh
DQo+Pg0KPj4+IFvCoMKgwqAgMS4wNzU1MTNdIERpdmlzaW9uIGJ5IHplcm8gaW4ga2VybmVsLg0K
Pj4+IFvCoMKgwqAgMS4wNzkzNTRdIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0
YWludGVkIDUuMTMuNyAjMTgNCj4+PiBbwqDCoMKgIDEuMDg1Mzc2XSBIYXJkd2FyZSBuYW1lOiBC
Q001MzAxWA0KPj4+IFvCoMKgwqAgMS4wODg4NzNdIFs8YzAxMDgzOTQ+XSAodW53aW5kX2JhY2t0
cmFjZSkgZnJvbSBbPGMwMTA0OThjPl0gKHNob3dfc3RhY2srMHgxMC8weDE0KQ0KPj4+IFvCoMKg
wqAgMS4wOTY2NjZdIFs8YzAxMDQ5OGM+XSAoc2hvd19zdGFjaykgZnJvbSBbPGMwNjk2NDcwPl0g
KGR1bXBfc3RhY2srMHg5NC8weGE4KQ0KPj4+IFvCoMKgwqAgMS4xMDM5MjZdIFs8YzA2OTY0NzA+
XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwM2U3Zjk0Pl0gKExkaXYwKzB4OC8weDEwKQ0KPj4+IFvC
oMKgwqAgMS4xMTA2NTNdIFs8YzAzZTdmOTQ+XSAoTGRpdjApIGZyb20gWzxjMDY5OTI3ND5dIChi
Y21fcXNwaV9leGVjX21lbV9vcCsweDNlMC8weDc0NCkNCj4+PiBbwqDCoMKgIDEuMTE4NTEyXSBb
PGMwNjk5Mjc0Pl0gKGJjbV9xc3BpX2V4ZWNfbWVtX29wKSBmcm9tIFs8YzA2OTg3NDA+XSAoc3Bp
X21lbV9leGVjX29wKzB4MTg0LzB4NGZjKQ0KPj4+IFvCoMKgwqAgMS4xMjcyMzRdIFs8YzA2OTg3
NDA+XSAoc3BpX21lbV9leGVjX29wKSBmcm9tIFs8YzA2OThiYWM+XSAoc3BpX21lbV9kaXJtYXBf
cmVhZCsweGY0LzB4MWM4KQ0KPj4+IFvCoMKgwqAgMS4xMzU3ODBdIFs8YzA2OThiYWM+XSAoc3Bp
X21lbV9kaXJtYXBfcmVhZCkgZnJvbSBbPGMwNjk3ZDU4Pl0gKHNwaV9ub3Jfc3BpbWVtX3JlYWRf
ZGF0YSsweDEzYy8weDFlYykNCj4+PiBbwqDCoMKgIDEuMTQ1MTk5XSBbPGMwNjk3ZDU4Pl0gKHNw
aV9ub3Jfc3BpbWVtX3JlYWRfZGF0YSkgZnJvbSBbPGMwNDk4ZDYwPl0gKHNwaV9ub3JfcmVhZCsw
eDE2Yy8weDE3NCkNCj4+PiBbwqDCoMKgIDEuMTU0MDA4XSBbPGMwNDk4ZDYwPl0gKHNwaV9ub3Jf
cmVhZCkgZnJvbSBbPGMwNDgzNWQwPl0gKG10ZF9yZWFkX29vYl9zdGQrMHg5Yy8weGE0KQ0KPj4+
IFvCoMKgwqAgMS4xNjE5NjRdIFs8YzA0ODM1ZDA+XSAobXRkX3JlYWRfb29iX3N0ZCkgZnJvbSBb
PGMwNDg1NWQwPl0gKG10ZF9yZWFkX29vYisweDg0LzB4MTQ4KQ0KPj4+IFvCoMKgwqAgMS4xNjk5
OTddIFs8YzA0ODU1ZDA+XSAobXRkX3JlYWRfb29iKSBmcm9tIFs8YzA0ODU2ZjQ+XSAobXRkX3Jl
YWQrMHg2MC8weDkwKQ0KPj4+IFvCoMKgwqAgMS4xNzcyMzddIFs8YzA0ODU2ZjQ+XSAobXRkX3Jl
YWQpIGZyb20gWzxjMDQ4YWI1MD5dIChiY200N3h4cGFydF9wYXJzZSsweDFkNC8weDc0NCkNCj4+
PiBbwqDCoMKgIDEuMTg1MDg5XSBbPGMwNDhhYjUwPl0gKGJjbTQ3eHhwYXJ0X3BhcnNlKSBmcm9t
IFs8YzA0ODg1Njg+XSAocGFyc2VfbXRkX3BhcnRpdGlvbnMrMHgxODgvMHg0MjQpDQo+Pj4gW8Kg
wqDCoCAxLjE5Mzk4NV0gWzxjMDQ4ODU2OD5dIChwYXJzZV9tdGRfcGFydGl0aW9ucykgZnJvbSBb
PGMwNDg2MDE4Pl0gKG10ZF9kZXZpY2VfcGFyc2VfcmVnaXN0ZXIrMHg3Yy8weDFjMCkNCj4+PiBb
wqDCoMKgIDEuMjAzNDg5XSBbPGMwNDg2MDE4Pl0gKG10ZF9kZXZpY2VfcGFyc2VfcmVnaXN0ZXIp
IGZyb20gWzxjMDQ5OThiOD5dIChzcGlfbm9yX3Byb2JlKzB4MjBjLzB4MmQwKQ0KPj4+IFvCoMKg
wqAgMS4yMTI0NzFdIFs8YzA0OTk4Yjg+XSAoc3BpX25vcl9wcm9iZSkgZnJvbSBbPGMwNDZmYmY4
Pl0gKHJlYWxseV9wcm9iZSsweGYwLzB4NGRjKQ0KPj4+IFvCoMKgwqAgMS4yMjAyNDVdIFs8YzA0
NmZiZjg+XSAocmVhbGx5X3Byb2JlKSBmcm9tIFs8YzA0NmRkNDA+XSAoYnVzX2Zvcl9lYWNoX2Ry
disweDgwLzB4ZDApDQo+Pj4gW8KgwqDCoCAxLjIyODE4NF0gWzxjMDQ2ZGQ0MD5dIChidXNfZm9y
X2VhY2hfZHJ2KSBmcm9tIFs8YzA0NzAxZDA+XSAoX19kZXZpY2VfYXR0YWNoKzB4ZjgvMHgxNWMp
DQo+Pj4gW8KgwqDCoCAxLjIzNjQ2OF0gWzxjMDQ3MDFkMD5dIChfX2RldmljZV9hdHRhY2gpIGZy
b20gWzxjMDQ2ZWRkND5dIChidXNfcHJvYmVfZGV2aWNlKzB4ODQvMHg4YykNCj4+PiBbwqDCoMKg
IDEuMjQ0NjY4XSBbPGMwNDZlZGQ0Pl0gKGJ1c19wcm9iZV9kZXZpY2UpIGZyb20gWzxjMDQ2YzZj
ND5dIChkZXZpY2VfYWRkKzB4MzAwLzB4ODQwKQ0KPj4+IFvCoMKgwqAgMS4yNTI2MDZdIFs8YzA0
NmM2YzQ+XSAoZGV2aWNlX2FkZCkgZnJvbSBbPGMwNGIzZGM0Pl0gKHNwaV9hZGRfZGV2aWNlKzB4
OWMvMHgxNjQpDQo+Pj4gW8KgwqDCoCAxLjI2MDI5Ml0gWzxjMDRiM2RjND5dIChzcGlfYWRkX2Rl
dmljZSkgZnJvbSBbPGMwNGI0ODJjPl0gKHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKzB4OGFjLzB4
YmMwKQ0KPj4+IFvCoMKgwqAgMS4yNjkxODddIFs8YzA0YjQ4MmM+XSAoc3BpX3JlZ2lzdGVyX2Nv
bnRyb2xsZXIpIGZyb20gWzxjMDRiN2JkND5dIChiY21fcXNwaV9wcm9iZSsweDYwMC8weDcwMCkN
Cj4+PiBbwqDCoMKgIDEuMjc4MDkyXSBbPGMwNGI3YmQ0Pl0gKGJjbV9xc3BpX3Byb2JlKSBmcm9t
IFs8YzA0NzFkM2M+XSAocGxhdGZvcm1fcHJvYmUrMHg0OC8weDhjKQ0KPj4+IFvCoMKgwqAgMS4y
ODYwMzBdIFs8YzA0NzFkM2M+XSAocGxhdGZvcm1fcHJvYmUpIGZyb20gWzxjMDQ2ZmJmOD5dIChy
ZWFsbHlfcHJvYmUrMHhmMC8weDRkYykNCj4+PiBbwqDCoMKgIDEuMjkzODgwXSBbPGMwNDZmYmY4
Pl0gKHJlYWxseV9wcm9iZSkgZnJvbSBbPGMwNDcwNWRjPl0gKGRldmljZV9kcml2ZXJfYXR0YWNo
KzB4ZjAvMHgxMDApDQo+Pj4gW8KgwqDCoCAxLjMwMjI1NF0gWzxjMDQ3MDVkYz5dIChkZXZpY2Vf
ZHJpdmVyX2F0dGFjaCkgZnJvbSBbPGMwNDcwNjc4Pl0gKF9fZHJpdmVyX2F0dGFjaCsweDhjLzB4
MTFjKQ0KPj4+IFvCoMKgwqAgMS4zMTA4ODhdIFs8YzA0NzA2Nzg+XSAoX19kcml2ZXJfYXR0YWNo
KSBmcm9tIFs8YzA0NmRjNzQ+XSAoYnVzX2Zvcl9lYWNoX2RldisweDc0LzB4YzApDQo+Pj4gW8Kg
wqDCoCAxLjMxOTA4Nl0gWzxjMDQ2ZGM3ND5dIChidXNfZm9yX2VhY2hfZGV2KSBmcm9tIFs8YzA0
NmVmYzg+XSAoYnVzX2FkZF9kcml2ZXIrMHhmNC8weDFkYykNCj4+PiBbwqDCoMKgIDEuMzI3Mjg2
XSBbPGMwNDZlZmM4Pl0gKGJ1c19hZGRfZHJpdmVyKSBmcm9tIFs8YzA0NzBjZGM+XSAoZHJpdmVy
X3JlZ2lzdGVyKzB4ODgvMHgxMTgpDQo+Pj4gW8KgwqDCoCAxLjMzNTM5N10gWzxjMDQ3MGNkYz5d
IChkcml2ZXJfcmVnaXN0ZXIpIGZyb20gWzxjMDEwMTZkYz5dIChkb19vbmVfaW5pdGNhbGwrMHg1
NC8weDFkMCkNCj4+PiBbwqDCoMKgIDEuMzQzNTk4XSBbPGMwMTAxNmRjPl0gKGRvX29uZV9pbml0
Y2FsbCkgZnJvbSBbPGMwODAxMGU4Pl0gKGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MjQ0LzB4MmFj
KQ0KPj4+IFvCoMKgwqAgMS4zNTIzMzddIFs8YzA4MDEwZTg+XSAoa2VybmVsX2luaXRfZnJlZWFi
bGUpIGZyb20gWzxjMDY5YTdjOD5dIChrZXJuZWxfaW5pdCsweDgvMHgxMTgpDQo+Pj4gW8KgwqDC
oCAxLjM2MDUzNl0gWzxjMDY5YTdjOD5dIChrZXJuZWxfaW5pdCkgZnJvbSBbPGMwMTAwMTMwPl0g
KHJldF9mcm9tX2ZvcmsrMHgxNC8weDI0KQ0KPj4+IFvCoMKgwqAgMS4zNjgxMjVdIEV4Y2VwdGlv
biBzdGFjaygweGMxMDM1ZmIwIHRvIDB4YzEwMzVmZjgpDQo+Pj4gW8KgwqDCoCAxLjM3MzE4NF0g
NWZhMDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDANCj4+PiBbwqDCoMKgIDEuMzgxMzg0XSA1ZmMwOiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMA0KPj4+IFvCoMKgwqAgMS4zODk1ODJdIDVmZTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwDQo+Pj4NCj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBMaW51eCBNVEQg
ZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8NCj4+DQo+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IExpbnV4IE1URCBkaXNjdXNzaW9u
IG1haWxpbmcgbGlzdA0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1tdGQvDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBQcmF0eXVzaCBZYWRhdg0K
PiBUZXhhcyBJbnN0cnVtZW50cyBJbmMuDQo+IA0KDQo=
