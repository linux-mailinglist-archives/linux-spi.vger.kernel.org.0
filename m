Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC12D55F6
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgLJI7m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 03:59:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56730 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgLJI7j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 03:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607590778; x=1639126778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wq7PpqRNxa9kbwfPhRxx63A+R7nvoGXblp2/rUlkb2E=;
  b=cFzGZ0wRnM6SynvJYhSW6HKCa061iklLYaiv7PthZ3Bb2MN4wF/MUf/D
   Tfoc/9b34bz0FH/8RF/Vl9CHmvy/3t4SLouXzxy8dfnL9fRZbch6unSlC
   ROhpz/BFGs1Z7RVKxU+XAo2EuGwqBOzI4BcyQLJPfZMkI9/27zl8ZkiNv
   xe2YxQFPX6TS7pooQHzBWBeYH+CBLWoC15sNwyCDoie/yCYTMrh+bLeqj
   abdesWz4DgKUc5OAmsSxb0wzGdxUeK93ONWVDch3Io8iJsDSw3LkMnBDe
   ZBMjn4YGHERtj44mfLHY5Zt4ajkw3YAzjiFRYldhEP7piMzX5AXlAtd2p
   w==;
IronPort-SDR: sv0TZkAAbT5NG7k5qfsbqDA7RCHHV9h5e0cnB5XB6Buw+P4w+yi4/P7ECOq5XviJlyJk5jnaYI
 jzQk4pSQJUqeubB/+OA+Ye6MrEt0z5Pr+FOLh6KeAHL0hEa8siKRPjBoqMMulVhYZrgdz89YmG
 pi2IA60twWlGvPx3yOc8O14SF99ln3Sy9ndE9JuwQ56in+jUiJm5ttpchOGbNukDJlvADJv5qF
 EIuM0I8Jl/tiCRL8J9uzc+Cx5l8pwFZuXkoKxWDg8GwJr2TD22/NQpyTfQt0Piec3t6+cHBNYd
 /24=
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="99331403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2020 01:58:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 01:58:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 10 Dec 2020 01:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJmlYIq57SawsJ/0GxqBnRzxnDrsWHHxeIIma4wqroCKx19Vs784J38jbNnp+mL3t+Nl023+xnKXfwr1B+wokT0iG0oUZZ48L49zREi28QowOwHvdk49gai6Tr8peZUjwBAJTIC+GKZgKxmwO4rYk0sA3Y3tkVRMWNqd+0nwVpy6ZOs43NZuSGs1cRBvIU8cqYkvBsNBr8+PpqWpw53lpuF/YlqcFepg8upI//Eyh57OXTu8zA8gN+iL4uBiic5PUzH6E+1k3kHuo9B93P6zBBie2+u413aqQR5qBdIj6DBFyJwO4loTOfNdgcAnzlKd4gkoyufBjt4AYO/Nfeo4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq7PpqRNxa9kbwfPhRxx63A+R7nvoGXblp2/rUlkb2E=;
 b=ebLezdaMVYtD4wQCTTiL7KwvZ7UBn54Z5gsudiA6GRXsJR+m1GNgcFS3jSFrZxl8YIXzXHL6ATaXVNESwhM58n1bqRftXPAhQmcKeobFM3wkcyiWHY84QV4ILvMHGwebASnTKb76BRxDRkzw2yKc2JNpry7/MrEk+m4wQ4SA7q3Q2/iqo7HO/LR/fjekE6/4BEO5t6RjsHqcjF6ZBB7I5pw5XrWfeeT24SwUTw6IO9q/Nz8+9vCRCbS58mWBpnu7fJJ7WC4qwZv/zOIzxz/SKHghztHZf/oKeZ+n6ejKtpXtE3V8eT5oTCBVmWQ61eW99Zjv/MxIPTxUF8lTw/giFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq7PpqRNxa9kbwfPhRxx63A+R7nvoGXblp2/rUlkb2E=;
 b=PNwrKvENOfEq1OeP98BNu/k22uTMxIiNMfos4vfVUuS4xLDidGyDDG72J7lUR8KAUGFf1RnTzts58lw8kZorCwylyfQHA7u2PhtocUyXiwrMAKp9PC9qF8C1lZQM4IgHRR7KVDml6gT5RytHQtROKFX9qVO0+uSerQRDuORWVPE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.22; Thu, 10 Dec
 2020 08:58:18 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 08:58:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <fancer.lancer@gmail.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Thread-Topic: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Thread-Index: AQHWztKZmHDw6aLncEO1O0nh7I/99A==
Date:   Thu, 10 Dec 2020 08:58:18 +0000
Message-ID: <48bf85a0-4a98-7e81-0802-c5fac762234f@microchip.com>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
 <20201209202552.GE4790@sirena.org.uk>
 <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
In-Reply-To: <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2875566-98d4-4b4b-38dc-08d89ce9bd01
x-ms-traffictypediagnostic: SA2PR11MB5130:
x-microsoft-antispam-prvs: <SA2PR11MB5130FDA1C7592909499D1E24F0CB0@SA2PR11MB5130.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JA6hPDVMCvDln4TOPHpDmpi4G+Xqg38vr/kCaZu0T5uLPfh0y0NAzY3+wEWlmSwOooAbVFlgCaIVfe2gyIAZ/eg8C5hFxoNwcW2EegpUBdFXr1WJK6f8aBeyQ//t+YBSCGIVQ1IhsmbdVJMOuwoaHeMRP0H7B9L0SuD4MYyv05RIyfvonB01djyk0r0dSgy8Vqyfc1YSpbJj16gw0KKd61rIbUJkA/Hn5kHF18oeHfs9q3wsTBTbOKI1J93zOUELuCj2Ap4Vh+ldwnbppSUQqXcB/8TgsN+rd8nUc+axc6CBld99obLXqo3vFX5G/y0n3woRsrUX9skkNb6vjENjAmcOvK6Gw8BnA3IZiu9AuaK1LP61x1sfyasCmSvvj/q4BsKQbKpsoa5C3V0h98tZXfW59AVmBrp9tC/ybWCXl/zw1uXAh2P3ybbNjmTaFNGaCMVdpEkaQBpViWsnrSjOT8nbUa83S9vlCqCtqh6y0IY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(508600001)(54906003)(966005)(110136005)(5660300002)(66446008)(6512007)(71200400001)(186003)(31686004)(4326008)(66946007)(53546011)(8676002)(6506007)(6486002)(66476007)(2906002)(26005)(66556008)(8936002)(64756008)(86362001)(36756003)(31696002)(91956017)(76116006)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZFFkZHNrVWRlSFkyVW9LNE9xWStlQVR5blBGb1VOc3EwS3VBL01wU3ppZlR6?=
 =?utf-8?B?MWp5VzEyNytxNVdZM3BhZnM1dmsvZzBiNFNmYUVvcHFCYmxYUitRT1ZIOVUw?=
 =?utf-8?B?YUR0VlhmMFJiV2hoUG1rS0hacUEvYlRZOW0wcmFUUDM2dTdVZU1tY0dHTElm?=
 =?utf-8?B?Rk51bXlza3BJWjJHazRJVTd5V04yRU16akgva1ZtVFNxQkNWMkw5RFkxUkZa?=
 =?utf-8?B?WFU1cVplK045dVJ4UjRsQmQyNUduTUpScVBYNmk2aWRScldncmJOMHc2ZzFP?=
 =?utf-8?B?amZEZFgwUVJxVGNrSDhQVkRoWVh0Rzc0SVo5aFo4QWNVMy9MTXhuWGFrVEFF?=
 =?utf-8?B?a2U3Zks0QnV3bndabzV2M1lVSVhBMUlYbHJLUHUxeUtsWEJYYzBacFNYNXJW?=
 =?utf-8?B?RW9KamtkTDZaZmpJZzV6R1YwVis3QVFhRHkzOEtqRE5SN3hyOVV4NDR2cDBI?=
 =?utf-8?B?U044YVRrT0p1QWJhQ3VzKy93MDhmNjBXV3NpVDlnR0FGNGxxdDZ6WlpFZjU0?=
 =?utf-8?B?QXlXczBnQmNidjBmbzd4UFlMWFJ3U0dZckw2Wm55NndISklQOGZyanFiaTcw?=
 =?utf-8?B?TGJ0bjFaZlVWc2FPRlY5ckxvN2gwcm1QKzJjeHdQZGUyUGxWK3FMcTJWNVdu?=
 =?utf-8?B?YVZ6VHkvUXdoT1N0RVRMS1Ewb2NWdlVERWtMZXdJcFFTS1V2SVQ1ZjI2cjl0?=
 =?utf-8?B?d0F1bUlsZzJzMExwMWRVTENLY3ZHcmJacHlUU2tTcXRvNTJSTU1YcHZHMlFR?=
 =?utf-8?B?VHR0RG5uWE9xTlU0bytjMnQ0MVkrVngxS3JtdUlhWG5NZk05NEJMQjcrRG9k?=
 =?utf-8?B?WDZ2akhxYzRpb3MwWGFSdStUS2VWNzRGbDVTODRCbkVXRzd6SHY2ZGFHSUdu?=
 =?utf-8?B?b0hvaHc4ZUNpTkdPbjUySTZrZ1BZeTkvZXBwMmVqcWZkL2tmOTRTUjhXd05N?=
 =?utf-8?B?UG1UdWdTUGFYcUJDZVNRYlFqenFQL1V4dTBlRzc2MGF6aWE1ZGhGNDc5eW45?=
 =?utf-8?B?TFlMb1lFN1NKSTNDd1Q1TFBpSkV1bk41TXNEU3NhVzAraFhJQ3VNT25DWFNx?=
 =?utf-8?B?WUFsb1lEczZRbm5RcU81c0xvUHV6MDB0Z2VoR3Z0QjFzcGxUV0NXTWtUcXJn?=
 =?utf-8?B?UWMvR1pIYnVER3JwMk9wV0wxOFlkbW9nY3NxbnkvSGVMWm5qbGFUazd0WU9C?=
 =?utf-8?B?b2NUKytPUC9JSCttNGhQZDk2MEpQYTcvMkt5YUFnZFd6Ly9qdnRWZExmR1Iv?=
 =?utf-8?B?aE96Q2diNDNxek9VcUdVc0F1d2Z6ZmxFVXlVaGFOMWFYQkEraExmQnBxOHFL?=
 =?utf-8?Q?I6m3ObqC6LA2Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D503DA57FFD71A4CA6751F8B2E469DD9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2875566-98d4-4b4b-38dc-08d89ce9bd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 08:58:18.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlfOtAYSKYBR8cDpvnWRMBNa5n61cHjWKV5qLYwiKrtSbstuF/rYP4J+AoK6J5Dj+vU9K18tMwkfMh7EIM2dZVXTEhodNTmCOs6QzIJMOJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIFNlcmdlLCBNYXJrLA0KDQpPbiAxMi85LzIwIDEwOjMwIFBNLCBTZXJnZSBTZW1pbiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIERl
YyAwOSwgMjAyMCBhdCAwODoyNTo1MlBNICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPj4gT24g
V2VkLCBEZWMgMDksIDIwMjAgYXQgMTE6MTU6MzVQTSArMDMwMCwgU2VyZ2UgU2VtaW4gd3JvdGU6
DQo+Pj4gT24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDc6NTQ6MjBQTSArMDAwMCwgTWFyayBCcm93
biB3cm90ZToNCj4+DQo+Pj4+IFJpZ2h0LCBpbiBnZW5lcmFsIHdlIGFpbSB0byBkbyB0aGlzIHNv
cnQgb2YgZml4dXAgb24gdGhlIHRyYW5zZmVycw0KPj4+PiBhbmQgbWVzc2FnZXMgcmF0aGVyIHRo
YW4gdGhlIGRldmljZXMsIEkgZ3Vlc3Mgd2UgbWlnaHQgYmUgbWlzc2luZw0KPj4+PiB2YWxpZGF0
aW9uIGluIHNvbWUgb2YgdGhlIGZsYXNoIGFjY2VsZXJhdGlvbiBwYXRocyBvciB3YXMgdGhpcyBh
biBpc3N1ZQ0KPj4+PiBzZWVuIHRocm91Z2ggaW5zcGVjdGlvbj8NCg0KV2UgbWlzcyB2YWxpZGF0
aW9uIGZvciB0aGUgU1BJIGNvbnRyb2xsZXJzIHRoYXQgcHJvdmlkZSB0aGUNCnNwaV9jb250cm9s
bGVyX21lbV9vcHMgd2l0aCBpdHMgZXhlY19vcCgpIG1ldGhvZC4gSW4gdGhpcyBjYXNlIHRoZSBT
UEkNCmNvcmUgZG9lcyBub3QgY2hlY2sgaWYgdGhlIG1heF9zcGVlZF9oeiBvZiBzcGlfZGV2aWNl
IG92ZXJyaWRlcyB0aGUNCm1heF9zcGVlZF9oeiBvZiBjb250cm9sbGVyLg0KDQpUaGlzIHdhcyBz
ZWVuIHRocm91Z2ggaW5zcGVjdGlvbi4gVGhlcmUgYXJlIG9jdGFsIFNQSSBOT1IgZmxhc2hlcyB0
aGF0DQpjYW4gcnVuIGF0IDQwMCBNSFosIGFuZCBJJ3ZlIGFsc28gc2VlbiBTUEkgY29udHJvbGxl
cnMgdGhhdCBhcmUgbGltaXRlZA0KdG8gMjAwIE1IWiAobWljcm9jaGlwJ3Mgc2FtYTdnNSBvY3Rh
bCBTUEkgZm9yIGV4YW1wbGUsIHdoaWNoIGlzIG5vdCB5ZXQNCmluIG1haW5saW5lKS4NCg0KPj4N
Cj4+PiBJbiBjYXNlIG9mIERXIFNQSSBkcml2ZXIgd2UganVzdCBtYWtlIHN1cmUgdGhlIFNQSS1j
bGllbnQgZGV2aWNlDQo+Pj4gc3BlZWQgc2V0IGluIHRoZSBtYXhfc3BlZWRfaHogZG9lc24ndCBl
eGNlZWQgdGhlIGNvbnRyb2xsZXIgU1BJLWJ1cw0KPj4+IGNsb2NrIGZyZXF1ZW5jeSBhbmQgY2xh
bXAgaXQgaWYgaXQgZG9lcy4gU28gdGhlIGRyaXZlciBpcyBzYWZlIGluIHRoYXQNCj4+PiBtYXR0
ZXIuDQo+Pg0KPiANCj4+IElkZWFsbHkgdGhlIGRyaXZlciB3b3VsZG4ndCBoYXZlIHRvIGNoZWNr
IHRob3VnaCAobm8gaGFybSBpbiBkb2luZyBzbyBvZg0KPj4gY291cnNlKS4NCg0KUmlnaHQuIEkg
dGhvdWdodCBvZiBkb2luZyB0aGlzIGluIHRoZSBTUEkgY29yZSwgcmF0aGVyIHRoYW4gZG9pbmcg
aW4gKGVhY2gpDQpjb250cm9sbGVyIGRyaXZlci4NCg0KU2VyZ2UsDQoNCkkndmUgbG9va2VkIGF0
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjEwLXJjNy9zb3VyY2UvZHJpdmVy
cy9zcGkvc3BpLmMjTDM1NzANClRoYXQgbGltaXRzIHRoZSB4ZmVyIHNwZWVkIGh6IHRvIHRoZSBj
b250cm9sbGVyJ3MgbWF4X3NwZWVkX2h6LiBTUEkNCmNvbnRyb2xsZXJzIHRoYXQgaW1wbGVtZW50
IHRoZSBleGVjX29wKCkgb3B0aW1pemVkIGhhbmRsZXIgYXJlIG5vdCBnb2luZw0KdGhyb3VnaCB0
aGlzIHBhdGggYW5kIGFyZSBub3QgY292ZXJlZCBieSB0aGUgY2hlY2sgaW4gX19zcGlfdmFsaWRh
dGUoKS4NCg0KPiANCj4gSWYgc28gdGhlbiB3ZSdkIG5lZWQgdG8gaGF2ZSBhIGRlZGljYXRlZCBz
cGVlZC1yZWxhdGVkIGZpZWxkIGluIHRoZQ0KPiBzcGlfbWVtX29wIHN0cnVjdHVyZSwgd2hpY2gg
d291bGQgYmUgYWNjb3JkaW5nbHkgaW5pdGlhbGl6ZWQgYnkgdGhlDQo+IFNQSS1tZW0gY29yZS4N
Cj4gDQoNCldlIGRvIG5lZWQgYSBtYXhfc3BlZWRfaHogaW4gdGhlIFNQSU1FTSwgYnV0IHByb2Jh
Ymx5IGZvciBvdGhlciBwdXJwb3NlczoNCk5PUiBmbGFzaGVzLCBmb3IgZXhhbXBsZSwgY2FuIGRp
c2NvdmVyIHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBmcmVxdWVuY3kNCmF0IHJ1bi10aW1lLCB3aGVu
IHBhcnNpbmcgdGhlIGplc2QyMTYgU0ZEUCB0YWJsZXMuIE9uZSBtYXkgY29uc2lkZXIgdGhhdA0K
dGhlIHJ1bi10aW1lIGRpc2NvdmVyZWQgbWF4X3NwZWVkX2h6IHNob3VsZCBoYXZlIGEgaGlnaGVy
IHByZWNlZGVuY2UgdGhhbg0Kd2hhdCB3ZSBmaWxsIHdpdGggdGhlIHNwaS1tYXgtZnJlcXVlbmN5
IGR0IHByb3BlcnR5LCBiZWNhdXNlIHRoZQ0KbWFudWZhY3R1cmVycy9qZXNkMjE2IHN0YW5kYXJk
IGtub3cvcyBiZXR0ZXIuIE9mIGNvdXJzZSwgaWYgdGhlDQptYW51ZmFjdHVyZXJzIHB1dCBhIHdy
b25nIG1heF9zcGVlZF9oeiBpbiB0aGUgc2ZkcCB0YWJsZSwgdGhhdCBjYW4gYmUNCnVwZGF0ZWQg
YXQgcnVudGltZSB3aXRoIGEgZml4dXAoKSBob29rLCBvbiBhIGNhc2UgYnkgY2FzZSBiYXNpcy4g
T3RoZXINCnRoaW5nIHRvIGNvbnNpZGVyIGhlcmUsIGlzIHRoZSBtYXhfc3BlZWRfaHogc3VwcG9y
dGVkIGJ5IHRoZSBQQ0IuIEZvcg0KZXhhbXBsZSBpZiB0aGUgU1BJIGZsYXNoIHN1cHBvcnRzIDQw
MCBNSFosIHRoZSBjb250cm9sbGVyIDIwMCBNSFosIGJ1dA0KdGhlIFBDQiBvbmx5IDE4MCBNSFos
IHRoZW4gd2UnbGwgaGF2ZSB0byBzeW5jaHJvbml6ZSBhbGwgdGhyZWUuIEJ1dCB0aGlzDQpzZWVt
cyBsaWtlIGEgZGlzY3Vzc2lvbiBmb3Igb3RoZXIgcGF0Y2guDQoNCkxldCBtZSBrbm93IGlmIHlv
dSB0aGluayB0aGF0IHRoaXMgcGF0Y2ggaXMgb2sgZm9yIG5vdy4gSSBjYW4gdXBkYXRlIHRoZQ0K
Y29tbWl0IG1lc3NhZ2UgaWYgbmVlZGVkLg0KDQpDaGVlcnMsDQp0YQ0K
