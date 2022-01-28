Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2779B49F4D7
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiA1IDw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 03:03:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31860 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiA1IDt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 03:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643357029; x=1674893029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gZCXdJQduEhm1wYYn04LrNK0mO5UzR8J15jH4+a8CJY=;
  b=0mSIQEaGALMjaD8UGgPATKKuABsY2291btd+m7CVu0nolgOjhVDmKGQh
   OZ4G17w46JvBhVRKPqtVKCujqGp/4+58M4oQmoQYTsN2plSNwpZgPc+EB
   K31AHAtyZ+WfYgsKqgMhaYhVutdXDss/BYUzaw6fmw2Kd2eOcfa9+QIin
   8yw748X9lqnEiFmcLNqAbdb5qqPxTgoD8Fyq0cMx/5sHSReJh3bJoYw8K
   +GlC3Rd+XbZ54YwO7r6J0WJBBq+NYoRRBWrC0o5NWnmIofcdXHs5TibgG
   FBKQBzPKHNwqEMOeKyKZCqtlcXo9EhjIae4iywarAto2DIPKap9CPgsyl
   Q==;
IronPort-SDR: uc/J1PjrNdLa8L/FCp4DRP5k9g3UZJYTd9aOs7jyIZDPyg1MzkDMzqFuFyyN4+tdBwE8enWfLj
 9U4nCR2Du7OoEw52whzWEBXa3nal5NM2sDzxHaMQWwCePWylVSQWOzhq6AxTyrEP2SON+hqprQ
 8xPUNr+dPvJoVwil7Rf562vBxbWySSrpXI1MpYM1AEEFrCLK6f6F28EpzckFQxfRuf2F34dqZG
 9MTb+Tz0aYMrSVI32g2jx8Yaozw+6oI2QlgIJkgVEqIs6zTM4PaX8GrwSsTA3rPSTzDHG/EXAe
 uc9rViZxSp0wx3nfSjYcdPdQ
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="160314105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2022 01:03:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 28 Jan 2022 01:03:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 28 Jan 2022 01:03:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgclmpb9hZiqvy/phexfAkzgg+BOzG++tedpLp9QY2mguWR3NIZDyAuiK/gRhsvVHQPfLyxVfJjnK9PQ9m+W6tcr6HimMu3iUMFlnlaExAPcFxjza6jZrQhWCrCKxIV6k6ILBeLUbGgMAFOfkZTwqFB7vS//+kdf9RTl7SJfugfa0WlFX/ydN6ipQUZgFZuE0HncHwQNxRsAmJw2UO5RRnhwxUs8t01dUDox10D2Zl0ALF3KKnu0yu1uYPHT/bgmy6D+vAFWUXg8kIEIop232H99/3t9sczwZnv5hvqC9lSqMs5suoKECkD9RFr1Q66FQZQ3uhhKNf0/E5fQLVNAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZCXdJQduEhm1wYYn04LrNK0mO5UzR8J15jH4+a8CJY=;
 b=Id3WS+1WOpxbMGfT2n9MJbnFKcJFXfOY42EGhou4BS1drJ6sv/U3xsmD5/NcNEF4A9+/bcBG9ppM9IDPMsSnAG+8tcQzuERde5F4SA02tfZAjlZJF1mEN6QGAU7iN9DqluZOnJFrBO1AbjNdZxdGr4ibnz4c5DZV6O+37bjkTOwXg4Qptci9B19RyOHOz45dKIEUDLAvw9Ci0HVQf/1VntdY01GMSXclwY/OEpgkLZ3N7jdwd0p4q8Suo1qJ5AbW0fFq/sVWtfDJZAdAp9RkABWxkKhitviFggb8nlu3+8DXwWzfcCqGsXKhR764rjTESCHE4Akt+LZu2h2gaQywuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZCXdJQduEhm1wYYn04LrNK0mO5UzR8J15jH4+a8CJY=;
 b=pKN/UVcSG0SHWaB4tkSQd021gsgQkit6qy6P5uxuSa8vLAAUUjNQyW2lO7b86whGtdayEjCQ650ArA7ROAeS3DwKRm8N/AdsV9hsdoWq1gyglIVtBlJg3MDru1AbfUsxszK5WEkYKuoeaiduTSksJ/gL25duYOQy/0ZD9LaygLs=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by DM6PR11MB4076.namprd11.prod.outlook.com (2603:10b6:5:197::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 08:03:42 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 08:03:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <thomas.petazzoni@bootlin.com>,
        <juliensu@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 06/13] spi: spi-mem: Add an ecc parameter to the
 spi_mem_op structure
Thread-Topic: [PATCH v10 06/13] spi: spi-mem: Add an ecc parameter to the
 spi_mem_op structure
Thread-Index: AQHYFB2QyOHe8cO4mk+ZdxB4Va1QQQ==
Date:   Fri, 28 Jan 2022 08:03:41 +0000
Message-ID: <5b5f4b09-ddc1-ec0d-12c3-b4f64e7ffd0d@microchip.com>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
 <20220127091808.1043392-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220127091808.1043392-7-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37feed8-88fc-4d18-75dd-08d9e234b318
x-ms-traffictypediagnostic: DM6PR11MB4076:EE_
x-microsoft-antispam-prvs: <DM6PR11MB40760012D78371664DD1CD63F0229@DM6PR11MB4076.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPOHjE5Zc5aFeP5sAZcC50fIcZcpdnfKVY7lo05OZTuzUa4mkIjpMFwc9giC+vxZbo4y6kVKpDDdXP0gGFuhHQIg+oVDBwwFqILdiVhkYIHv1HiQYC0iVhwRs7PZIlpgCEhZPn34+tl8bNb5VliDswGDOJGNo41zuRSZ76lRBLzmy68UsvyZV+oEtYLVwI/QBa+DkBJnL0cYmzE+ZxHLLjX4YwTDHCQtNTFg6+DoJETYdEs++oiVkt7C57DgaAqF05ulS2z0RyXGQoaxsKB9YU+8ZyImqSpkhkLJAXTPjJOgYnuc7CfbJK7ikEYqsKoXyKPdqaYMFodHhMzkluz/MB1iasOAZvMGqDRb+AaXsfqPEg1/v4xNz7jV5W58yWfSs/coKknmtTPER92nsQxUAy3cY1iTx0virS3MY+Ak8mPVtExbfv/a9DKgFvgoF9LscHRJ54BXuH4x5D/a+PoZZck5+HYHf7+KpFUvueH4muEsgWdyW0+aYFTmqLcHiG2W6UeZk6cLE1L7lRMYlPiQ6kBC6fpGeuTkXATJ++l2DyVQwiK+fQ91LkpqbFU5pgr0baQndgqPVmL2AuWjWupUAU2WW+1nVB1o5A+0wUDwHHjgeFkAeE2D1za/I+vxdNzmVfwG3pKCKTagulFYkZzpVL/AApbGxO4ESIPDwGWkJev0bqe2EsrapYAbwYjKAOcTuicWUDWOD4geFi/p8h5x5kmjw/5rJ/E9evHBkCof0diPZC167ezR19j/wYN980tLvQp9ljNdR57lzPZajDqywPGnnjAuLssjSdlnCJoTP0GxkPhQ9suscERyx+Qw3Ourp1TzhYHDaNu8FvADBSyN7DWilpm2h11buf1MhykqWi8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(38100700002)(122000001)(2906002)(31686004)(83380400001)(36756003)(186003)(966005)(6486002)(26005)(316002)(2616005)(7416002)(86362001)(53546011)(110136005)(71200400001)(6506007)(508600001)(54906003)(76116006)(8936002)(66946007)(8676002)(66446008)(4326008)(66476007)(66556008)(6512007)(64756008)(5660300002)(31696002)(91956017)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVjR0tZdUlYYTNDcFVnbk9HczQ2S1liekh0OUdpdFB0VXZpSDgvYVloTTJG?=
 =?utf-8?B?UUtyQW8weWpWWXp5aWt2OWpHOWNoaE8xUTdXSU9YL1lnekpuNlpMTjVmWGNS?=
 =?utf-8?B?Rlc5aS85d0xzbkxJc1l4Q1F2VzFxNGQzajZ3NW41dVlRbXJ4SmFyM1hpd1Fr?=
 =?utf-8?B?TWV3TmhJRHNBMXdabzVvcVFyUFU4bnpVNk1ZSWRmbUJrMkFPNkk0MkhGanlO?=
 =?utf-8?B?WU9ONDZpbGNiVW43Zjd0Y0FQbGNKQVIxUnZCQzZwMU9welAzV3o0MjdXM0Ir?=
 =?utf-8?B?Sy95Mk9kYXNIUmpDMDkyTmdyRFF0QVpNeHMzOERUVzJYOFMzSTE1eTRQM1U1?=
 =?utf-8?B?NTN6dFhRVzE2dTh6WWVkVG8vRkhqVjVEcWtmTnNSd2lFTUhwRVJpYXFFc29M?=
 =?utf-8?B?VVQvRjU1cXNzb1c1aFlYY3hNZTd4UEMvVkNKM3MwS2ljQWl5aU1kOXBudm1K?=
 =?utf-8?B?TkdIYUdZTGI4TUdwMXpZcHBBMEFkMmd4UGp2aGJwYVlTbDlkRW81dGhyeUxP?=
 =?utf-8?B?R1NlNmRoNTdyK3NKL2VYU0lEdTJ1SUVvUmNkOU44Y2xWdUttZ3Avd0Y4aVBW?=
 =?utf-8?B?TnJER1ZKaG1VWDJmMmkxUkc3R2NJNkMvcytVYTZzY0tnQzJNTE9hRjhTVXhr?=
 =?utf-8?B?YTIvR1ZxQ2g5MFdKcFZGVWh3d0hSOHF4U0lJVnptbmJmZm1HZGwwbUxXcUlW?=
 =?utf-8?B?N2FPZ3dGNEFQcnZEMlMzQklmV2JLbUxjaSt1T2wwWWJwdllSQTFPc3hXVTJO?=
 =?utf-8?B?MUdOUjNSZ0FMNGRHaHFlejRQK3JyeEZRM2xtcjc0dENmYlhTbTFuKzFITzdv?=
 =?utf-8?B?aHlBcXA5V0U0THdRS0M4N2I3S3FDZTZQQmhYWnl5QjBvdlphR3pLbXEzRVFS?=
 =?utf-8?B?cFBxcVA2dy9KRGdxVFRmdDN2QUlBN3hHZ0Y4SXl6ZEtpMlBxZm9KbWYyaHNS?=
 =?utf-8?B?RzFiT2V4ZmovWE42bGlkZElDQnNVVnNGTEdob00vbFNVdjZaNllESmVabGRQ?=
 =?utf-8?B?U3lrc1RhVHllb284MXplcEkwZnhUU2J3NjBvSk9wS2toQTk1L2wxdkhNcW9q?=
 =?utf-8?B?UTRGMWRWeGtDTE14NXRJR1YyZkZ6d0hBK1NXT3crcXpRbXppVmgwQ292UUlr?=
 =?utf-8?B?SzY4OVJWOXRjOUcxbjdObnhSRmFadFJLUi9qUmQ3TmNSNG5LK2oxR1AvRGc2?=
 =?utf-8?B?MDZac0VQSlpLZ0oraXk0MlRaQ1dqbTE1YjBxdFJHRXZZKzZyNW02ZCsrdGty?=
 =?utf-8?B?MWhFNkkxT0grNThFd1FMNVlobHVPSGFiVXBxTHFoRytOVkQzdCtCbnJlN3pQ?=
 =?utf-8?B?WW1IVSs0Sm9pZUJMVjlXTjNLaURxVDJLSzUyOGgzcDFhU1U5OWFKZmNUZTVp?=
 =?utf-8?B?UlFPcWNoOGxuRVNEdEJ5MVRoS0dSdUxNTWQrL1dJWU9tU3N3SFdDRHpxbDZl?=
 =?utf-8?B?MitMNXFhV0JNQjRlcU1VVHJoSG9EOTBRQ21aemhrM2NVMWR4WjE0NjgrajA5?=
 =?utf-8?B?ZnNvcFFnYlVXWnNkRzEyaldmN3V6YXFOSTFJbzlWdzJiWjhtRlh5TWtjajBy?=
 =?utf-8?B?R2wrWjZLM2g5QkpZUDBqS2JxVFJpWU5IVjlvb2xBdDQ5OWcrWlR4anBLY01H?=
 =?utf-8?B?UytaRTFnTW5ySGR4SWYwRHBqUld4aTlKaEJZTkY4ZVVwbDVzRmYyV2xvMVY0?=
 =?utf-8?B?b0FVa01RM3B1bHAza01Xc3pZZ2dlVU9vUnZ6VHk5NjY0K2dsdWlUazVxYkd1?=
 =?utf-8?B?MGUzaFRlTUhYQUxJZmk5RnB3Uk5BQVhTV3ZvZnJJVjVIcEtFaEM2N0lveGd4?=
 =?utf-8?B?MGh3QjJTV1lWaE9aYmlUNlRVTFhMS0xOZDZudEluZFZnb0M5RzJIQll3Zldl?=
 =?utf-8?B?M0YrV2JmZWV6TVZGNDVqY1d0Tkdac0xSSFJoQm53SzgweWQ1SmMyZ3EwSVZz?=
 =?utf-8?B?TlBvQXNWdXZTcWVIMnlwanVFVGVXMzN4VlNIZ1RQN3AzWERKa0xEY0V0VnAz?=
 =?utf-8?B?aDdMaWVxSUFGR09JaWV4TmczVWp1UHo5dXFaQUZyR1IrSGVBaEpkYmkwREw0?=
 =?utf-8?B?b1VOQmpBRzQreEIyMlZxdk54OEpSaDZ6VjdVUXFYTm5JWDJoTzZKbEE1MC9X?=
 =?utf-8?B?MGh5SWlZU3FLQ2pqWW1mVGdtRHBtS3NxUzUrL09kc1IrSlR2VUxXTUdPdHpX?=
 =?utf-8?B?eU1WVHlDQkxaLzJlYWJRb2xHMU1zYlZySHJoY0ZDZytoR1BFWmxRd3pwbFZV?=
 =?utf-8?B?UFRTb3MzNUxEQUREY0dMQkZVQ0lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D96822FB907CE4D9D17A277FE0E543A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37feed8-88fc-4d18-75dd-08d9e234b318
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 08:03:41.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSOgIc6Frii2llFEKc0UU4/prwGk7v173agmc0OWmp2xgRLCZIAoy2NpulFTVfUXaNflwH5y6p8XBYiAgboyXKGS0v+T55lpeAv7fui+UJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4076
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMS8yNy8yMiAxMToxOCwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTb29uIHRoZSBTUEktTkFORCBjb3JlIHdpbGwgbmVl
ZCBhIHdheSB0byByZXF1ZXN0IGEgU1BJIGNvbnRyb2xsZXIgdG8NCj4gZW5hYmxlIEVDQyBzdXBw
b3J0IGZvciBhIGdpdmVuIG9wZXJhdGlvbi4gVGhpcyBpcyBiZWNhdXNlIG9mIHRoZQ0KPiBwaXBl
bGluZWQgaW50ZWdyYXRpb24gb2YgY2VydGFpbiBFQ0MgZW5naW5lcywgd2hpY2ggYXJlIGRpcmVj
dGx5IG1hbmFnZWQNCj4gYnkgdGhlIFNQSSBjb250cm9sbGVyIGl0c2VsZi4NCj4gDQo+IEludHJv
ZHVjZSBhIHNwaV9tZW1fb3AgYWRkaXRpb25hbCBmaWVsZCBmb3IgdGhpcyBwdXJwb3NlOiBlY2Mu
DQo+IA0KPiBTbyBmYXIgdGhpcyBmaWVsZCBpcyBsZWZ0IHVuc2V0IGFuZCBjaGVja2VkIHRvIGJl
IGZhbHNlIGJ5IGFsbA0KPiB0aGUgU1BJIGNvbnRyb2xsZXIgZHJpdmVycyBpbiB0aGVpciAtPnN1
cHBvcnRzX29wKCkgaG9vaywgYXMgdGhleSBhbGwNCj4gY2FsbCBzcGlfbWVtX2RlZmF1bHRfc3Vw
cG9ydHNfb3AoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20+DQo+IEFja2VkLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0
aS5jb20+DQo+IFJldmlld2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBj
b2xsYWJvcmEuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQv
MjAyMjAxMDQwODM2MzEuNDA3NzYtNy1taXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tDQo+IC0tLQ0K
PiAgZHJpdmVycy9zcGkvc3BpLW1lbS5jICAgICAgIHwgNSArKysrKw0KPiAgaW5jbHVkZS9saW51
eC9zcGkvc3BpLW1lbS5oIHwgNSArKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW1lbS5jIGIvZHJpdmVy
cy9zcGkvc3BpLW1lbS5jDQo+IGluZGV4IGVkOTY2ZDgxMjllYi4uZjM4YWMzMTk2MWM5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3Bp
LW1lbS5jDQo+IEBAIC0xNzgsNiArMTc4LDExIEBAIGJvb2wgc3BpX21lbV9kZWZhdWx0X3N1cHBv
cnRzX29wKHN0cnVjdCBzcGlfbWVtICptZW0sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gICAgICAgICB9DQo+IA0KPiArICAgICAgIGlmIChvcC0+ZGF0YS5lY2Mp
IHsNCj4gKyAgICAgICAgICAgICAgIGlmICghc3BpX21lbV9jb250cm9sbGVyX2lzX2NhcGFibGUo
Y3RsciwgZWNjKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAr
ICAgICAgIH0NCj4gKw0KPiAgICAgICAgIHJldHVybiBzcGlfbWVtX2NoZWNrX2J1c3dpZHRoKG1l
bSwgb3ApOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoc3BpX21lbV9kZWZhdWx0X3N1cHBv
cnRzX29wKTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaCBiL2lu
Y2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaA0KPiBpbmRleCA0YTFiZmU2ODk4NzIuLjA1MTA1MGI0
MDMwOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zcGkvc3BpLW1lbS5oDQo+ICsrKyBi
L2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaA0KPiBAQCAtODksNiArODksNyBAQCBlbnVtIHNw
aV9tZW1fZGF0YV9kaXIgew0KPiAgICogQGR1bW15LmR0cjogd2hldGhlciB0aGUgZHVtbXkgYnl0
ZXMgc2hvdWxkIGJlIHNlbnQgaW4gRFRSIG1vZGUgb3Igbm90DQo+ICAgKiBAZGF0YS5idXN3aWR0
aDogbnVtYmVyIG9mIElPIGxhbmVzIHVzZWQgdG8gc2VuZC9yZWNlaXZlIHRoZSBkYXRhDQo+ICAg
KiBAZGF0YS5kdHI6IHdoZXRoZXIgdGhlIGRhdGEgc2hvdWxkIGJlIHNlbnQgaW4gRFRSIG1vZGUg
b3Igbm90DQo+ICsgKiBAZGF0YS5lY2M6IHdoZXRoZXIgZXJyb3IgY29ycmVjdGlvbiBpcyByZXF1
aXJlZCBvciBub3QNCj4gICAqIEBkYXRhLmRpcjogZGlyZWN0aW9uIG9mIHRoZSB0cmFuc2Zlcg0K
PiAgICogQGRhdGEubmJ5dGVzOiBudW1iZXIgb2YgZGF0YSBieXRlcyB0byBzZW5kL3JlY2VpdmUu
IENhbiBiZSB6ZXJvIGlmIHRoZQ0KPiAgICogICAgICAgICAgICAgIG9wZXJhdGlvbiBkb2VzIG5v
dCBpbnZvbHZlIHRyYW5zZmVycmluZyBkYXRhDQo+IEBAIC0xMTksNiArMTIwLDcgQEAgc3RydWN0
IHNwaV9tZW1fb3Agew0KPiAgICAgICAgIHN0cnVjdCB7DQo+ICAgICAgICAgICAgICAgICB1OCBi
dXN3aWR0aDsNCj4gICAgICAgICAgICAgICAgIHU4IGR0ciA6IDE7DQo+ICsgICAgICAgICAgICAg
ICB1OCBlY2MgOiAxOw0KPiAgICAgICAgICAgICAgICAgZW51bSBzcGlfbWVtX2RhdGFfZGlyIGRp
cjsNCj4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBuYnl0ZXM7DQo+ICAgICAgICAgICAg
ICAgICB1bmlvbiB7DQo+IEBAIC0xMjYsNiArMTI4LDcgQEAgc3RydWN0IHNwaV9tZW1fb3Agew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpvdXQ7DQo+ICAgICAgICAgICAg
ICAgICB9IGJ1ZjsNCj4gICAgICAgICB9IGRhdGE7DQo+ICsNCmRyb3AgdGhpcyBleHRyYSBibGFu
ayBsaW5lIHBsZWFzZQ0KDQpQYXRjaGVzIDEtNiBhcmU6DQpSZXZpZXdlZC1ieTogVHVkb3IgQW1i
YXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpDaGVlcnMsDQp0YQ0KDQo+ICB9
Ow0KPiANCj4gICNkZWZpbmUgU1BJX01FTV9PUChfX2NtZCwgX19hZGRyLCBfX2R1bW15LCBfX2Rh
dGEpICAgICAgICAgICAgIFwNCj4gQEAgLTI4OCw5ICsyOTEsMTEgQEAgc3RydWN0IHNwaV9jb250
cm9sbGVyX21lbV9vcHMgew0KPiAgLyoqDQo+ICAgKiBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXJfbWVt
X2NhcHMgLSBTUEkgbWVtb3J5IGNvbnRyb2xsZXIgY2FwYWJpbGl0aWVzDQo+ICAgKiBAZHRyOiBT
dXBwb3J0cyBEVFIgb3BlcmF0aW9ucw0KPiArICogQGVjYzogU3VwcG9ydHMgb3BlcmF0aW9ucyB3
aXRoIGVycm9yIGNvcnJlY3Rpb24NCj4gICAqLw0KPiAgc3RydWN0IHNwaV9jb250cm9sbGVyX21l
bV9jYXBzIHsNCj4gICAgICAgICBib29sIGR0cjsNCj4gKyAgICAgICBib29sIGVjYzsNCj4gIH07
DQo+IA0KPiAgI2RlZmluZSBzcGlfbWVtX2NvbnRyb2xsZXJfaXNfY2FwYWJsZShjdGxyLCBjYXAp
ICAgICAgIFwNCj4gLS0NCj4gMi4yNy4wDQo+IA0KDQo=
