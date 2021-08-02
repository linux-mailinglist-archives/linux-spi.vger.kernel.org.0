Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DF3DDB3C
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhHBOjz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 10:39:55 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29120 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHBOjy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 10:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627915184; x=1659451184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4w9w1C0p0Rewfaq6UEoAHETupDlNlU45V3hbqIpqQ1Y=;
  b=k9jQthH6IWSOndrLV8xf3elXPC9gHK5kYepSxIQTbEkdMGDLcpFNiUBN
   CMJ7Ne/x8mnC8H23nKAF5hnTRovtuX1TZ17L3gSyi7HtGhaeMDncMMNYT
   5dA93+wuwoutfzYKXbNqzfbDSpVCJhPz/BS7/mZfLP5P0s9AuaCVb3Idy
   MCnWfFwxduj8J/Wa6nBXfcSSuH2W7WM56ANKaWflz3U24s/dfa+dqoYe0
   6ysaYFaYEQT6EL9OmDJhwyYJHQ0O95sdiom+Q9vTSLN5c/APRyX//gZDQ
   aS1JVBRisiNszhEf6uAXu8qpGjtmB7T9ffnLAng7tSyu36ALdJxbuX4JT
   A==;
IronPort-SDR: 2P156TB/w/9y6urN06X1Q6oiE9l2Y810cWymYTzkkKzmNB7VyxNKcQ/qjEd32PQ4zrSBq2uH4/
 pMWtTJ6weJnFwZwlZT6b2GAFdahis8V00olR/kFOCkx0uv8seCC/62WweE5qF4WpRfbo8RS2R1
 TTNwD/EKYkXYNy43cHh2rDRIwXbFgTBAy64bqMwTpwl2YUpTOvDi1OoMAN7Q+QPvlqO6kzJb6k
 nVVZSLqEkHjxuvrZ4uR8uIcsI/dKr76xbIZjznqs+bc6fO8ctKqy/FQxm0fK4HMqC+hDMpVJ/4
 2vflDN6iE3ncgXAx3ePj3yII
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="138438677"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2021 07:39:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 07:39:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 2 Aug 2021 07:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx2SNgm/sbACkrmH4lXy7uxrtuAojQXGxFOwrlAa+2wdV9OrW7QACP/Y5XUkRrsZqrOVP+FsD4GiGArppiCPvV9RWrSpGWTtn3/cpVi1wu9qlJ3YHBEMFm5eo/PynmFpDpaSj0HS0TyknW1K3r68tALsSrIT8BBXJDTMXIbL3RVCfvQGChCkekGRxRCTsxHAqUZzO/66oqZ1mKTXQNgALVOLICq0NFSBFF1XxDb9RbcfumMrWKQNBN7k02h6xHUHvXRBdHDqJZrG64U9dSZ1UzgHaD4Zjn0BtMGjxDFxKOvqZeb2l5JWIcye3Nh+bBQWnGJDXROVRzWEi31tPsILQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w9w1C0p0Rewfaq6UEoAHETupDlNlU45V3hbqIpqQ1Y=;
 b=Z0KeXQtNZgYxxi+k8jBi1i9zBK1hhh/NUawyiET7dtWah9TUOPtJyNjDycZ2J8B2ZunfhPsg3ezeSz+CxZbow7/FfD/PEC3ZaNn35B4nJKE6cH44UjgSL7QcoUlx0aXBWY5LqwmWbENXdefhmylghGLGkdhKf0/cq0BxTRE4i3jujlLoF90v7GxeZ6kLfZbUgKNqPGNOko796variO4BS5yL9f0AmnQWttKQqpI9CAJIBSsPBykxuXV2s5nGjrJnjQtXNSudAnzjbT+Fni/m3wgYLUamX3CAo+W2eFruFClkhIEdYsi81dnqMzF0E/mWJoKpDjGVeCgWvFhCppPRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w9w1C0p0Rewfaq6UEoAHETupDlNlU45V3hbqIpqQ1Y=;
 b=RAbYmE78GitKUgwIb1r9BV6cmAkXUodlcu/4qHY8AgW2cIsdEBYepLCEsZRNJ/PMoBeapbFjC+6zkIym0f2Q8n9S4j7Rp3IDhYQTfbJBcPmnV1hYX+wq0sZILeR20nVxobek9+00zMd30yNtpSHc9Ed9GxAn1dwBLnwXWVHH1CE=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 14:39:43 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 14:39:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <zajec5@gmail.com>, <linux-mtd@lists.infradead.org>
CC:     <linux-spi@vger.kernel.org>, <kdasu.kdev@gmail.com>,
        <boris.brezillon@collabora.com>
Subject: Re: spi-nor 5.11 regression: Division by zero in kernel
Thread-Topic: spi-nor 5.11 regression: Division by zero in kernel
Thread-Index: AQHXh6w7feQOFoOjKU6jPSqwWqSZhg==
Date:   Mon, 2 Aug 2021 14:39:42 +0000
Message-ID: <b3d23f9d-5c84-c4cc-dede-85ec85135276@microchip.com>
References: <99bdb1eb-71a8-99e6-be03-a97185246740@gmail.com>
In-Reply-To: <99bdb1eb-71a8-99e6-be03-a97185246740@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0c2f029-5fbc-41c2-0555-08d955c35dce
x-ms-traffictypediagnostic: CO1PR11MB4996:
x-microsoft-antispam-prvs: <CO1PR11MB49966C1E7BE3789C0B09B7EDF0EF9@CO1PR11MB4996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6I/sSk5+kJCZBXD85hTcX5iy6lYeQjx3uRUe/h2ZSSGb4nmPZcywvgXCyg3Zjs17EuQJTe6zje9pXQzXaz1gnZ10ciwOY1l3040YA0d4cSlSgcZfJe5rPerJDHdhLTVSsgGrWPNs+gF9OwXn6QYen0rFZ8cBOODxXgVztAl/EwPZYjuxkcWtHbXNc0BOEh/+YshjbhP1jq4DpLY3QuxNeBQU/Rg/TIn+MsoX5wE/sY5iOx2PL5TRVTe0+iV+8tTllhDYN0hs3rBMLNLe28PJc8dRmz+PEeLVNlcn5zUFYmXeOEgVposFDczlA3Hxw+BAmtjsvyw+e0ig+A/PeS53Gi0K/dht1Sa/gc5cCj9YERTGf/N70cfJRHy033pXsaX8r3o3Zlt8fgkQNw7lQ9L2dC0AUQK9XC9wB7iu072TVfuz+BrxM+z1cqUQrqbfXO+aLDmcC/mhBkJV19rogCPHO7CRA+iOFLx+x42eQfbt1Mhg9t43t0P6QtWiLaV222XavshVh0j1ADejcgHXWP7i2x0T4glosiu255XXaBtFnpQORFTYl0nd0ueCWM28+3T7h7kMGOd5ej9+Sh9lXa3PG9BhzNGSVpSjR8tK6pt1yPLgkIfAk+yQXdwgIMSgGow+kuCSghpoj+kvPqc2N6A4CIrSZKWiTQaRlRj/3YxHU6iMutq75Id3hoJSK/O4WcFETQQM2wRW7nM6OULPG5nM37pgaKvA1QLSgkPoSI4+ZgIDSb0p9aahX71l/zxZcCVHhpG7gxUF74/z0uB5361minsPOkGG4rt4KaO5J6uLRpWaKvtNqvyQI4mzzsWusHlqwc3xT1HS/0F8Y8gnqVU/9YJFcw6vu4Zi9Z1Uu2nHOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(478600001)(31686004)(186003)(6506007)(38100700002)(53546011)(316002)(6486002)(26005)(36756003)(122000001)(66446008)(2906002)(64756008)(66556008)(966005)(4326008)(66476007)(6512007)(8676002)(5660300002)(71200400001)(31696002)(54906003)(38070700005)(2616005)(66946007)(86362001)(76116006)(8936002)(110136005)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWpyczhER3AveTErenpTY2loeUhUYVlGd2ZDTGxlSTRwc3pzYTJMSTVxN3Qy?=
 =?utf-8?B?U3BHcXI1MlNBZ1pEaVI4NDVzamxtc2JNRXdodFhJQXUwQmJIZm42UjlFU3U4?=
 =?utf-8?B?bTdFazlCR1dDQ2JxdGZhTk1vUUF3SlBqeC9WMnZDVDFJZXUrVGFqcGtoTzB3?=
 =?utf-8?B?MUFUSlUyVGlicXc4bFFmeE90ZENqdWxBZnAyYk9ybVFjOS9zRXBnN2xVc1RU?=
 =?utf-8?B?VEM1THFOMmhuTExpbS9nNVB3Ui9qc3ZVZVNmTk1hUVBBdGFUTUo0c3I1MFNF?=
 =?utf-8?B?RWdCYWw3YnRpbzZlNmFZQ0lvdFRHaThpYVlwdWZtZUFyeUtIQUVCWFNkMm5W?=
 =?utf-8?B?MkEySzZ0dFdQZ29vN1dQL082TkZMajU3S1I5TGtYL1Z2WWcwZnBINjhKK09N?=
 =?utf-8?B?eUhpKzZTV1RlN0c3MlhsdHN0dVVDYXZmdnJJWXVGTGFzZnZEbzBzU3pLMU1M?=
 =?utf-8?B?T3VFWHJuYm1nWGwzdWVGcHZOaXpHZWpUU1V5V01wc1kzQ1lqUXFReVFRODhQ?=
 =?utf-8?B?MTRzWFBCZ1dBV3g5SDNwVWcrWjJwZ21nRlhQNzRwZy95dUs1ZGZHNEZhbWdh?=
 =?utf-8?B?UWlaQ3UrbjJCcVJ5TVFWMlBnTnJiWUhUVXF4Mkxpd2RWckZscVZPNGptV2dp?=
 =?utf-8?B?YlpYcUVWY081Y1BHRitiZzZSRnZDeVlNQVBPR09HbjhCVHNTbjRZeWtYNGhY?=
 =?utf-8?B?dUFtaTNnQXJHUzlBeEpUWi9uL0YyMTQ0RVlEanlpV1NoWVJWdFNJOE85UVBu?=
 =?utf-8?B?QjhSTmErbW9uMjBKMHZuOW53YUJtWTZJc1FsY3VjYVdyblVhbkh2L2JWRUpm?=
 =?utf-8?B?THF1N0F6b0l4cmJXdG9JVHFpejdwYXZITzUwUzRCMlRxd1pNN0t4dWNWd2RU?=
 =?utf-8?B?Mld0dUN6TVppR0xBODRpM0NkZHVNZ3htWlN2NHQ5Y1pzQmd0RWYvTElEVzFK?=
 =?utf-8?B?YnpQZVdFUlBjOUdTNmxBTWdMZGl5b2J1MDNpTGJrTVhxUVNSdmpwbVZLWkRJ?=
 =?utf-8?B?Smpvd1NhMm5NdTVXV1BiYWZvZjZNcUc2aUg0WlR1cWtNS2ZuM1phazhkY0p0?=
 =?utf-8?B?bkV3MXNPalluOUR0elJCQ0tsVFRPcFpHVXpKaXViMFhoUjVadWZUTGdZUjNk?=
 =?utf-8?B?SVdxSVhvY1ZROUZsSCtsS2xuVnVhNzhQbGppRGZoN0NzNFh6bHZFbk0ya09F?=
 =?utf-8?B?UFNLK2EvN2lhd2daQU9vMEhVN1hTWFE0SEtKMFM5bGRuNmFXemZ2OHNVTmxU?=
 =?utf-8?B?S2V4TXcyYlBKR2lmcUlaVWRjVWZEUTJFQ1ltTDRmb0RCTFBhUFc3T3dFNkhl?=
 =?utf-8?B?Nk52aEIrQnJMbUxlK1FFV1UrdHc1THBwTXVGenQyZnVWekxTMVJBUHdnaHBO?=
 =?utf-8?B?TW01ZEtwSGFNanhhVWhNYWVBOUNONVBPRzBLZHpGS00zbCtaRTlhSjJEY1pj?=
 =?utf-8?B?SnRqSHpjNjNlR3JEVlFMOHh6RkJhWHBQa0NuZmlnczlyUmdFK2R4UVk1VEY1?=
 =?utf-8?B?bUV5WXJWZFNMMXZtKzFGdzhNa3VmTEVOTWM4ODNVYXliQ29xRlY5VzQ4SGdV?=
 =?utf-8?B?ZnNUYXZ4N1BlMzZ0UTBRUmtRaWZhbmtjOVlRSFJCNmZvMi9tS1JZZ1FYRlhK?=
 =?utf-8?B?S1ZZSlJ2MEhOajV4V0N5UmlZZ3lDb3dvVGdqT1FVc29KOWVDL2lCanJvWXBj?=
 =?utf-8?B?MHQzZi9jRVJhNE9zS2NLVGZwOGdHVUYxeWQraGNoZ3VtSnliMXZUM0xqODRw?=
 =?utf-8?Q?aQotJxwkiSAo9oegqA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE80D7388B274448CBF87A009640157@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c2f029-5fbc-41c2-0555-08d955c35dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 14:39:42.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/7vxG0WJdxuLa6vyda1Xa+DJy5uGmkMtu7vW32abhq4ThC72UK3K9zG96krK75mOGWYbSkSHq+jci96ljQGWX+D/BT84tScyZ46r44SpUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gOC8yLzIxIDQ6MjQgUE0sIFJhZmHFgiBNacWCZWNraSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCg0KSGksIFJhZmHFgiENCg0KPiANCj4g
SXQgc2VlbXMgdGhhdCBrZXJuZWwgNS4xMSBicm9rZSBzcGktbm9yIG9uIEJyb2FkY29tIE5vcnRo
c3RhciAoQkNNNTMwMVgpDQo+IHBsYXRmb3Jtcy4NCj4gDQo+IFRoZSBwcm9ibGVtIHNlZW1zIHRv
IGJlIHNwaV9ub3Jfc3BpbWVtX3JlYWRfZGF0YSgpIHdoaWNoIGNhbGN1bGF0ZXM6DQo+IG9wLmR1
bW15Lm5ieXRlcyA9IChub3ItPnJlYWRfZHVtbXkgKiBvcC5kdW1teS5idXN3aWR0aCkgLyA4Ow0K
PiANCj4gT24gTm9ydGhzdGFyIHRoaXMgaGFwcGVucyB0byBiZToNCj4gb3AuZHVtbXkubmJ5dGVz
ID0gKDAgKiAwKSAvIDg7DQo+IA0KPiBUaGF0IHJlc3VsdHMgaW4gYmNtX3FzcGlfYnNwaV9zZXRf
ZmxleF9tb2RlKCkgZGl2aWRpbmcgYnkgemVybyBpbiB0aGU6DQo+IGJwcCB8PSAob3AtPmR1bW15
Lm5ieXRlcyAqIDgpIC8gb3AtPmR1bW15LmJ1c3dpZHRoOw0KPiANCj4gQ291bGQgeW91IHRha2Ug
YSBsb29rIGF0IHRoYXQgaXNzdWUsIHBsZWFzZT8NCj4gDQo+IEdPT0TCoMKgwqAgNS4xMC41NQ0K
PiBCQUTCoMKgwqDCoCA1LjExLjIyDQo+IEJBRMKgwqDCoMKgIDUuMTIuMTkNCj4gQkFEwqDCoMKg
wqAgNS4xMy4yDQo+IEJBRMKgwqDCoMKgIDUuMTMuNw0KPiANCg0KSXQncyBoYXJkIHRvIGd1ZXNz
LiBXb3VsZCB5b3UgcGxlYXNlIGJpc2VjdCBhbmQgaWRlbnRpZnkgdGhlIGNvbW1pdCB0aGF0IGlu
dHJvZHVjZXMNCnRoZSByZWdyZXNzaW9uPw0KDQpUaGFua3MsDQp0YQ0KDQo+IFvCoMKgwqAgMS4w
NzU1MTNdIERpdmlzaW9uIGJ5IHplcm8gaW4ga2VybmVsLg0KPiBbwqDCoMKgIDEuMDc5MzU0XSBD
UFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjEzLjcgIzE4DQo+IFvC
oMKgwqAgMS4wODUzNzZdIEhhcmR3YXJlIG5hbWU6IEJDTTUzMDFYDQo+IFvCoMKgwqAgMS4wODg4
NzNdIFs8YzAxMDgzOTQ+XSAodW53aW5kX2JhY2t0cmFjZSkgZnJvbSBbPGMwMTA0OThjPl0gKHNo
b3dfc3RhY2srMHgxMC8weDE0KQ0KPiBbwqDCoMKgIDEuMDk2NjY2XSBbPGMwMTA0OThjPl0gKHNo
b3dfc3RhY2spIGZyb20gWzxjMDY5NjQ3MD5dIChkdW1wX3N0YWNrKzB4OTQvMHhhOCkNCj4gW8Kg
wqDCoCAxLjEwMzkyNl0gWzxjMDY5NjQ3MD5dIChkdW1wX3N0YWNrKSBmcm9tIFs8YzAzZTdmOTQ+
XSAoTGRpdjArMHg4LzB4MTApDQo+IFvCoMKgwqAgMS4xMTA2NTNdIFs8YzAzZTdmOTQ+XSAoTGRp
djApIGZyb20gWzxjMDY5OTI3ND5dIChiY21fcXNwaV9leGVjX21lbV9vcCsweDNlMC8weDc0NCkN
Cj4gW8KgwqDCoCAxLjExODUxMl0gWzxjMDY5OTI3ND5dIChiY21fcXNwaV9leGVjX21lbV9vcCkg
ZnJvbSBbPGMwNjk4NzQwPl0gKHNwaV9tZW1fZXhlY19vcCsweDE4NC8weDRmYykNCj4gW8KgwqDC
oCAxLjEyNzIzNF0gWzxjMDY5ODc0MD5dIChzcGlfbWVtX2V4ZWNfb3ApIGZyb20gWzxjMDY5OGJh
Yz5dIChzcGlfbWVtX2Rpcm1hcF9yZWFkKzB4ZjQvMHgxYzgpDQo+IFvCoMKgwqAgMS4xMzU3ODBd
IFs8YzA2OThiYWM+XSAoc3BpX21lbV9kaXJtYXBfcmVhZCkgZnJvbSBbPGMwNjk3ZDU4Pl0gKHNw
aV9ub3Jfc3BpbWVtX3JlYWRfZGF0YSsweDEzYy8weDFlYykNCj4gW8KgwqDCoCAxLjE0NTE5OV0g
WzxjMDY5N2Q1OD5dIChzcGlfbm9yX3NwaW1lbV9yZWFkX2RhdGEpIGZyb20gWzxjMDQ5OGQ2MD5d
IChzcGlfbm9yX3JlYWQrMHgxNmMvMHgxNzQpDQo+IFvCoMKgwqAgMS4xNTQwMDhdIFs8YzA0OThk
NjA+XSAoc3BpX25vcl9yZWFkKSBmcm9tIFs8YzA0ODM1ZDA+XSAobXRkX3JlYWRfb29iX3N0ZCsw
eDljLzB4YTQpDQo+IFvCoMKgwqAgMS4xNjE5NjRdIFs8YzA0ODM1ZDA+XSAobXRkX3JlYWRfb29i
X3N0ZCkgZnJvbSBbPGMwNDg1NWQwPl0gKG10ZF9yZWFkX29vYisweDg0LzB4MTQ4KQ0KPiBbwqDC
oMKgIDEuMTY5OTk3XSBbPGMwNDg1NWQwPl0gKG10ZF9yZWFkX29vYikgZnJvbSBbPGMwNDg1NmY0
Pl0gKG10ZF9yZWFkKzB4NjAvMHg5MCkNCj4gW8KgwqDCoCAxLjE3NzIzN10gWzxjMDQ4NTZmND5d
IChtdGRfcmVhZCkgZnJvbSBbPGMwNDhhYjUwPl0gKGJjbTQ3eHhwYXJ0X3BhcnNlKzB4MWQ0LzB4
NzQ0KQ0KPiBbwqDCoMKgIDEuMTg1MDg5XSBbPGMwNDhhYjUwPl0gKGJjbTQ3eHhwYXJ0X3BhcnNl
KSBmcm9tIFs8YzA0ODg1Njg+XSAocGFyc2VfbXRkX3BhcnRpdGlvbnMrMHgxODgvMHg0MjQpDQo+
IFvCoMKgwqAgMS4xOTM5ODVdIFs8YzA0ODg1Njg+XSAocGFyc2VfbXRkX3BhcnRpdGlvbnMpIGZy
b20gWzxjMDQ4NjAxOD5dIChtdGRfZGV2aWNlX3BhcnNlX3JlZ2lzdGVyKzB4N2MvMHgxYzApDQo+
IFvCoMKgwqAgMS4yMDM0ODldIFs8YzA0ODYwMTg+XSAobXRkX2RldmljZV9wYXJzZV9yZWdpc3Rl
cikgZnJvbSBbPGMwNDk5OGI4Pl0gKHNwaV9ub3JfcHJvYmUrMHgyMGMvMHgyZDApDQo+IFvCoMKg
wqAgMS4yMTI0NzFdIFs8YzA0OTk4Yjg+XSAoc3BpX25vcl9wcm9iZSkgZnJvbSBbPGMwNDZmYmY4
Pl0gKHJlYWxseV9wcm9iZSsweGYwLzB4NGRjKQ0KPiBbwqDCoMKgIDEuMjIwMjQ1XSBbPGMwNDZm
YmY4Pl0gKHJlYWxseV9wcm9iZSkgZnJvbSBbPGMwNDZkZDQwPl0gKGJ1c19mb3JfZWFjaF9kcnYr
MHg4MC8weGQwKQ0KPiBbwqDCoMKgIDEuMjI4MTg0XSBbPGMwNDZkZDQwPl0gKGJ1c19mb3JfZWFj
aF9kcnYpIGZyb20gWzxjMDQ3MDFkMD5dIChfX2RldmljZV9hdHRhY2grMHhmOC8weDE1YykNCj4g
W8KgwqDCoCAxLjIzNjQ2OF0gWzxjMDQ3MDFkMD5dIChfX2RldmljZV9hdHRhY2gpIGZyb20gWzxj
MDQ2ZWRkND5dIChidXNfcHJvYmVfZGV2aWNlKzB4ODQvMHg4YykNCj4gW8KgwqDCoCAxLjI0NDY2
OF0gWzxjMDQ2ZWRkND5dIChidXNfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA0NmM2YzQ+XSAoZGV2
aWNlX2FkZCsweDMwMC8weDg0MCkNCj4gW8KgwqDCoCAxLjI1MjYwNl0gWzxjMDQ2YzZjND5dIChk
ZXZpY2VfYWRkKSBmcm9tIFs8YzA0YjNkYzQ+XSAoc3BpX2FkZF9kZXZpY2UrMHg5Yy8weDE2NCkN
Cj4gW8KgwqDCoCAxLjI2MDI5Ml0gWzxjMDRiM2RjND5dIChzcGlfYWRkX2RldmljZSkgZnJvbSBb
PGMwNGI0ODJjPl0gKHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKzB4OGFjLzB4YmMwKQ0KPiBbwqDC
oMKgIDEuMjY5MTg3XSBbPGMwNGI0ODJjPl0gKHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKSBmcm9t
IFs8YzA0YjdiZDQ+XSAoYmNtX3FzcGlfcHJvYmUrMHg2MDAvMHg3MDApDQo+IFvCoMKgwqAgMS4y
NzgwOTJdIFs8YzA0YjdiZDQ+XSAoYmNtX3FzcGlfcHJvYmUpIGZyb20gWzxjMDQ3MWQzYz5dIChw
bGF0Zm9ybV9wcm9iZSsweDQ4LzB4OGMpDQo+IFvCoMKgwqAgMS4yODYwMzBdIFs8YzA0NzFkM2M+
XSAocGxhdGZvcm1fcHJvYmUpIGZyb20gWzxjMDQ2ZmJmOD5dIChyZWFsbHlfcHJvYmUrMHhmMC8w
eDRkYykNCj4gW8KgwqDCoCAxLjI5Mzg4MF0gWzxjMDQ2ZmJmOD5dIChyZWFsbHlfcHJvYmUpIGZy
b20gWzxjMDQ3MDVkYz5dIChkZXZpY2VfZHJpdmVyX2F0dGFjaCsweGYwLzB4MTAwKQ0KPiBbwqDC
oMKgIDEuMzAyMjU0XSBbPGMwNDcwNWRjPl0gKGRldmljZV9kcml2ZXJfYXR0YWNoKSBmcm9tIFs8
YzA0NzA2Nzg+XSAoX19kcml2ZXJfYXR0YWNoKzB4OGMvMHgxMWMpDQo+IFvCoMKgwqAgMS4zMTA4
ODhdIFs8YzA0NzA2Nzg+XSAoX19kcml2ZXJfYXR0YWNoKSBmcm9tIFs8YzA0NmRjNzQ+XSAoYnVz
X2Zvcl9lYWNoX2RldisweDc0LzB4YzApDQo+IFvCoMKgwqAgMS4zMTkwODZdIFs8YzA0NmRjNzQ+
XSAoYnVzX2Zvcl9lYWNoX2RldikgZnJvbSBbPGMwNDZlZmM4Pl0gKGJ1c19hZGRfZHJpdmVyKzB4
ZjQvMHgxZGMpDQo+IFvCoMKgwqAgMS4zMjcyODZdIFs8YzA0NmVmYzg+XSAoYnVzX2FkZF9kcml2
ZXIpIGZyb20gWzxjMDQ3MGNkYz5dIChkcml2ZXJfcmVnaXN0ZXIrMHg4OC8weDExOCkNCj4gW8Kg
wqDCoCAxLjMzNTM5N10gWzxjMDQ3MGNkYz5dIChkcml2ZXJfcmVnaXN0ZXIpIGZyb20gWzxjMDEw
MTZkYz5dIChkb19vbmVfaW5pdGNhbGwrMHg1NC8weDFkMCkNCj4gW8KgwqDCoCAxLjM0MzU5OF0g
WzxjMDEwMTZkYz5dIChkb19vbmVfaW5pdGNhbGwpIGZyb20gWzxjMDgwMTBlOD5dIChrZXJuZWxf
aW5pdF9mcmVlYWJsZSsweDI0NC8weDJhYykNCj4gW8KgwqDCoCAxLjM1MjMzN10gWzxjMDgwMTBl
OD5dIChrZXJuZWxfaW5pdF9mcmVlYWJsZSkgZnJvbSBbPGMwNjlhN2M4Pl0gKGtlcm5lbF9pbml0
KzB4OC8weDExOCkNCj4gW8KgwqDCoCAxLjM2MDUzNl0gWzxjMDY5YTdjOD5dIChrZXJuZWxfaW5p
dCkgZnJvbSBbPGMwMTAwMTMwPl0gKHJldF9mcm9tX2ZvcmsrMHgxNC8weDI0KQ0KPiBbwqDCoMKg
IDEuMzY4MTI1XSBFeGNlcHRpb24gc3RhY2soMHhjMTAzNWZiMCB0byAweGMxMDM1ZmY4KQ0KPiBb
wqDCoMKgIDEuMzczMTg0XSA1ZmEwOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMA0KPiBbwqDCoMKgIDEuMzgxMzg0XSA1ZmMwOiAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MA0KPiBbwqDCoMKgIDEuMzg5NTgyXSA1ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNzaW9uIG1h
aWxpbmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW10ZC8NCg0K
