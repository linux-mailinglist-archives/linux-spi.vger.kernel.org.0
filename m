Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6E41F6B3
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354645AbhJAVOe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 17:14:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26056 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354551AbhJAVOe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 17:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633122769; x=1664658769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=baPzjLn3o/ZPvaMIWQey6kKMbrjrEsSZXuuq5YdE6nw=;
  b=yL6CxNDwkAl6NVD8YmXhM/8JDjLYYIMuQiFYS+Q8wpXHUANYwlaJXqm9
   qnnJNhAfDjj9/J/4DaiIosrKsvc9pfdogXab35VypyzKTSubGTMkDX1l/
   dpM4CJZroqSddf9tmFsKm9RG4PAGuQzC2bAmHHCPlbTF8GqzhWMQ4+0y9
   npj6o+6e9v9Al+/cV83Os940FnTyB48LqA0Ye/3vLhS5klVSeXSU+Irk1
   uQA6BFQ2sisBEZfgKL9WZVK+yrw5LU1z2vV+stlzkRWiuay3JF0QP4kFV
   fW18/6rF0W3qIF6607oau0F30NFiwZlAVywo2CYp0DP2unz+rNphQ6BHi
   A==;
IronPort-SDR: CU4v01gb1pcEgU6CX6PdIi67aZJSMrUc45Y5IKkn8kAbTqlnZgAhuuJEvRzLOjq14xNxHsjnia
 gxOXHmV3ShCRN5SRlwFsnrdkcoiyGrFwxDYPD/Z5cpRzolK0wPnaa7Bs5gpAn/UvsgrXBSVgRp
 SLwWuCH7Z29mMHhr+RC08OFlwxCcclz4fpgx7wLY+oE5gcHYUo+o9Junsh7kVWme9W7i35+9U5
 cb2OkZPUkAu0Foar7Wop8sdY/Ja9r4TTrFo3J9eR0oZNcmW3GlkMCYj5XcKrH6q3ClewnmCUtH
 bU/sBQAWVq7/EW7HlvgGQ312
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="71426743"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2021 14:12:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 1 Oct 2021 14:12:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 1 Oct 2021 14:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko2XiWEMucA6uFKkNbBVKjascRbRpxg02YmR9c5LlOPGW+n/7AGOJ6377w20ZceTWOJmSi/lRrbLKvIy5/iJWAbpa3LmWPEnx1JUPXZPmHBG75JIgaW0WngwuklDXb4c6S2VYauW2tNFmFNBC2me/gx2aRrievn0WLK7cB1JuaOsiJgqRVuuog/09FJdQwkyGzHL8AxFTsBGFpGiIe4bn5nKauEMLfGDx+2djxq/2xlEMRhSFO80wrBSBCWk6NTTSrgaMlRFjPdA07nrAc5IPF81Uo5xYIWfiqOJ/jgVPB2iTkBAitosm+VWS+MfVJ403zyx2mhmPu0npsMJSKYkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baPzjLn3o/ZPvaMIWQey6kKMbrjrEsSZXuuq5YdE6nw=;
 b=aF/jRJAqP+fNSeem9vjvYDwu++rEKZHeK90fIYycA/zPU8tysFexiiOyYiV1oQ6U9ZgIwd+2oSu+gwDGttOxd5FKyPY2UV7QnWopDxcT8tyGMCfZCrq/X8wCk2HgIE0is5+VGX5Id8N71faJbIvPECn8pHJ3bWeeCxKea79jt1Hu/czBaF/sPqz2hMzZRMCvt6qeRwoChAmd36+PsO7KyIaPAQ8QeaovOc0NMnx2BOIqHyvFPEvv/E6afSrmFIUHSavDHy/kCYNMBLugzz8Aig3XUQBmNsXANoSHzXWqSZYHCACG80UK4blDSTVvpOUv2Uju7HG1RwVPwLvu0ZbWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baPzjLn3o/ZPvaMIWQey6kKMbrjrEsSZXuuq5YdE6nw=;
 b=nlzsj0c+CxVGDV8+KtyUZskzz8deANiDdZnmfVJVnNZRfyp8TeXj3lU1rbaHa6jj0Nfr42318Uf2v6peXyGpbZcbPJV4FnNgr+w7KdECmX6PJGvO1dZ62UIxZx5NFMcCmKj//cIK1qponhbhSlPYwRzq8f6lBGFJ3pASaMgH3dw=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28)
 by BY5PR11MB3896.namprd11.prod.outlook.com (2603:10b6:a03:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 21:12:46 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 21:12:45 +0000
From:   <Dan.Sneddon@microchip.com>
To:     <villeb@bytesnap.co.uk>, <Tudor.Ambarus@microchip.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH v4] spi: atmel: Fix PDC transfer setup bug
Thread-Index: AQHXtwkUNSlsEXmDvE65QnZT5HX4kg==
Date:   Fri, 1 Oct 2021 21:12:45 +0000
Message-ID: <e151c019-269a-8dbb-610b-2a57cc855e1b@microchip.com>
References: <20210921072132.21831-1-villeb@bytesnap.co.uk>
In-Reply-To: <20210921072132.21831-1-villeb@bytesnap.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: bytesnap.co.uk; dkim=none (message not signed)
 header.d=none;bytesnap.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92b1afa9-3ee8-4017-026c-08d98520371e
x-ms-traffictypediagnostic: BY5PR11MB3896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3896A32D8A66C2AF4A2F8993E1AB9@BY5PR11MB3896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlT/N8a3wXLEo+Tduob0/n889/j8ZVJ5noIFjKawLl4JDWnX+EbEM7t91qYL50jKY7osBctliRbSFc8DwNO3v1g/lWxPCm1dOr73C43MJOTfwlvFQOUHqguUb0jz4cjUyHY58YWwRaFCoL2VG2yeXEAS5lPZYxUM8Zr1CV2ZgZFK8VwZ83jKkFhLWI6OZB/9PmV8nItXgK56+oy2U+G5sSUJcYoS5dCQ/9CYhH4LyZhjDON1DkTVzmJ0PFK//tyNm/MGA/jZmTobg7XrP2xiaUzPDNniVjJwhYHNmlBNplzUjL9moBbsdpUJEydm804XUvOesENr5LxDrh5CyhIjX9/wn1JZ50ApZLeMGOrwMr1sFKCKwR7Zs5tWpee8NDm04UoI0ySDWPMM82gUpzoEVn77eU5rmWM2rjQY/79zWgaz6myaeDByDwMAomd+FAUm1yFFqL9xglGCesu9ExCHqTU1QZ6nweDIghML5UF2fi4Ppwq/8vN05XUTzDbFWlcN8ikQzLvP/XRPpRcwOYypBSHd0fNR1R97mMu7bTpDRi93D3/204wTIruegrweXhmjuz8l7sBJsLUkd+uid3RvftewGV5j+BKBmlBnpcTLd9jOlcMiayeTWnksGX+0jCulj6CD2shac4QcSEm5Bn2qHrGSnTAJobpA51sHeEw3Lju0yvjJcw/aMliQYCIVTilfvMrF0HR0kU+UCZ1FvAH+OjEY6YKP87V+cj0c5vITJDQJlFnuFbNBhQDF3pRmWm0y/jMcDa6778wf3r8uTX1FJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(2906002)(38070700005)(38100700002)(5660300002)(31696002)(8676002)(2616005)(54906003)(86362001)(83380400001)(91956017)(71200400001)(316002)(110136005)(4326008)(8936002)(31686004)(66476007)(6512007)(66446008)(76116006)(53546011)(26005)(186003)(66556008)(64756008)(36756003)(508600001)(6486002)(6506007)(66946007)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUdsZEdjd2xneG5Yakp4UEd2VmMrWFN4V0pOenY5NkhIUHhEbUk4NytHaFQv?=
 =?utf-8?B?dEprOTlrV252c2Q2VDdnenc5MWFQM2ZFUTRDRUh5Y1pJSThIQmZvRUlqTUhF?=
 =?utf-8?B?ZCtTM2tFYno0RDRVb2pIZWNhcEY0UktyN0haUUNXdi9RbkpJMzBWZnc1a3hV?=
 =?utf-8?B?ayt0VzN5Z04zazZKQXFxZkFIVjRpL0tZMVl3Z2gzSzdCM0kvZ3Z2eXJBQWZP?=
 =?utf-8?B?NHJndVRieXp0MlFIMU9wckV1Q2pZM2hPbFdOZytIbVdCVGJNZkxoMFlOQ2Ny?=
 =?utf-8?B?dlRiUlk0SWVTNHAwQUEwYVZxMjkrcnNxRC9wSGR5STBnTXlXNnRZbjMwZ0ZS?=
 =?utf-8?B?UjM5YTNxTG93MVZacERJL01JS3VGUVZOZjBqZ0o4LzZPaUR0OXJYQ2RlZlRC?=
 =?utf-8?B?VGhYbTdxTE9UVUNIT2R1M2R3VXlrcDVWZ0VTUS9uUGF3b2pKRklVSElrR1RD?=
 =?utf-8?B?T2h6d3ZITUl3dDUzRjdGbEhpdDBlZitJMWZyUHMzTTJJMkpSNFdTRWpVTE5B?=
 =?utf-8?B?N3hDRnU3VXI4cWI4bVFjVzJNYm9ZallTQVdac1B5UWNQRVhCTjkwREd1UkR3?=
 =?utf-8?B?R2hueG5ueVd0cVdwckMxT3JLNVorYlU1S3JsVWxtUWpCVHc1ZndEU0lsZUl1?=
 =?utf-8?B?dkYyYUJHOTRRTnIyNXVhbjBFYWlRNStjM1NqWjZ0VFBpRlVoa0hpRXp4Q3Jv?=
 =?utf-8?B?VWJiaFVoaDV0MS9LMC9uNlNDZlhQeTFCZWlNU3VNcFpud1kwY2NDRm0wdElh?=
 =?utf-8?B?WTF0K0piUTJJeDgwaEV3ZXVkb0NkczU2bTY3QUx5SFZHVkF3VHVKSXhsV2kv?=
 =?utf-8?B?ZkFPV0VLaTFaaW1zbUFxN2pZcDRKMHdhakU4dUVKVVRhdG8rcURONndrSDlB?=
 =?utf-8?B?RUxHOGJMY3pBOUs1SnQxZlcvYzRCU3NHN3JoZmRscjFWVkNaN0N3dkRFaUx1?=
 =?utf-8?B?cHFrbWdISW1JWTJRZUZyREd2OXFHbDNLSjU4WldXY292SXZWRTBGYlY1cXBs?=
 =?utf-8?B?SVJYYWYwbUlUYnY4ZWNFbDdkbWJiQi9wOU93OEJhbmc2S2JwWDRKcGlzOEd5?=
 =?utf-8?B?alU2SXJtTWZPUC9BbjVSQWV0UEo0V0RITGRjMVFrd0FBeGxuMVNkMGd1QnY1?=
 =?utf-8?B?R005UzJXenc4NHFZcWsxTXlQS3FxZHRnN3NEckk1R2pnUHdvWitrV3BnbDRG?=
 =?utf-8?B?NGtFb2N1MXMzTmp0UGhCUmNQNURocmNDdTBqSFZPekZQY1RYdUtaeUFnYzda?=
 =?utf-8?B?VXEyNkRPdmRVRXRRdEdyazJtQ1k5WWFpRDUxQ3RyWU1xcWJpYlJINDNiL3dM?=
 =?utf-8?B?RnQrY1RuQXcxZlRvUkJXTENUbnlOd2ZGbXI5WEsvNU13VUc1TFQxTjdkSGpZ?=
 =?utf-8?B?TVhKWUs0cS93eDRJeE5sZXJjaXh4U1dkbXNQcVFLbndER2NzbFpGeWtzaTVn?=
 =?utf-8?B?cGNzU2ZaZ3RTakVBVE5EU1pUVXFvVnU4dUU3SFMwM1VGUVR0Ky9lTFI2d1JY?=
 =?utf-8?B?ZXJ2TjdWdkxsVXdBcjVvODk4dVJSdlZ1dHZZcGhORzRLc1FpejF0UDBlM3M3?=
 =?utf-8?B?VmEzUjV3UVRTWU9ZVk5CckNEVzNKZHc1elBEMFBadFNkbTFPNi94dUFYWTFm?=
 =?utf-8?B?VERtdGRIa0RHd0IrTFFxb3lzTzFBd1pwMEtsY21oSW1lbEtwNGRjQ3hPTld1?=
 =?utf-8?B?WG1RT2xmSUNWRjVEcmQrQmpnUWx2bUh6aXR4OEdZUVlrWWZmcTNJZFkzZ01G?=
 =?utf-8?Q?1hxpGkBbXHFtAsd5KMhD5Xi90Xz4TSbHTzABvvy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D680A81C7C98C488B1BBF1E297F78CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b1afa9-3ee8-4017-026c-08d98520371e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 21:12:45.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T2tOV+L8eBbBjvF+LfIdQ/88Ly26Gr9KH8A6qVagsTMyFGcxUUhzXJyQqy+TOt1CqLfoY+HUphOikMix5yHZ9+YDIPGhdJT7bwM9J6GHuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3896
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgVmlsbGUsDQoNCk9uIDkvMjEvMjEgMTI6MjEgQU0sIFZpbGxlIEJhaWxsaWUgd3JvdGU6DQo+
IENvbW1pdCA1ZmE1ZTZkZWM3NjIgKCJzcGk6IGF0bWVsOiBTd2l0Y2ggdG8gdHJhbnNmZXJfb25l
IHRyYW5zZmVyDQo+IG1ldGhvZCIpIHJlZmFjdG9yZWQgdGhlIGNvZGUgYW5kIGNoYW5nZWQgYSBj
b25kaXRpb25hbCBjYXVzaW5nDQo+IGF0bWVsX3NwaV9kbWFfbWFwX3hmZXIgdG8gbmV2ZXIgYmUg
Y2FsbGVkIGluIFBEQyBtb2RlLiBUaGlzIGNhdXNlcyB0aGUNCj4gZHJpdmVyIHRvIHNpbGVudGx5
IGZhaWwuDQo+IA0KPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIGNvbmRpdGlvbmFsIHRvIG1hdGNo
IHRoZSBiZWhhdmlvdXIgb2YgdGhlDQo+IHByZXZpb3VzIGNvbW1pdCBiZWZvcmUgdGhlIHJlZmFj
dG9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmlsbGUgQmFpbGxpZSA8dmlsbGViQGJ5dGVzbmFw
LmNvLnVrPg0KU2hvdWxkbid0IHRoaXMgaGF2ZSBhIEZJWEVTIHRhZz8NCj4gLS0tDQo+ICAgZHJp
dmVycy9zcGkvc3BpLWF0bWVsLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Bp
L3NwaS1hdG1lbC5jIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gaW5kZXggNzg4ZGNkZjI1
ZjAwLi5mODcyY2YxOTZjMmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5j
DQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jDQo+IEBAIC0xMzAxLDcgKzEzMDEsNyBA
QCBzdGF0aWMgaW50IGF0bWVsX3NwaV9vbmVfdHJhbnNmZXIoc3RydWN0IHNwaV9tYXN0ZXIgKm1h
c3RlciwNCj4gICAJICogRE1BIG1hcCBlYXJseSwgZm9yIHBlcmZvcm1hbmNlIChlbXB0aWVzIGRj
YWNoZSBBU0FQKSBhbmQNCj4gICAJICogYmV0dGVyIGZhdWx0IHJlcG9ydGluZy4NCj4gICAJICov
DQo+IC0JaWYgKCghbWFzdGVyLT5jdXJfbXNnX21hcHBlZCkNCj4gKwlpZiAoKCFtYXN0ZXItPmN1
cl9tc2ctPmlzX2RtYV9tYXBwZWQpDQo+ICAgCQkmJiBhcy0+dXNlX3BkYykgew0KPiAgIAkJaWYg
KGF0bWVsX3NwaV9kbWFfbWFwX3hmZXIoYXMsIHhmZXIpIDwgMCkNCj4gICAJCQlyZXR1cm4gLUVO
T01FTTsNCj4gQEAgLTEzODEsNyArMTM4MSw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfc3BpX29uZV90
cmFuc2ZlcihzdHJ1Y3Qgc3BpX21hc3RlciAqbWFzdGVyLA0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAg
DQo+IC0JaWYgKCFtYXN0ZXItPmN1cl9tc2dfbWFwcGVkDQo+ICsJaWYgKCFtYXN0ZXItPmN1cl9t
c2ctPmlzX2RtYV9tYXBwZWQNCj4gICAJCSYmIGFzLT51c2VfcGRjKQ0KPiAgIAkJYXRtZWxfc3Bp
X2RtYV91bm1hcF94ZmVyKG1hc3RlciwgeGZlcik7DQo+ICAgDQo+IA0KDQpSZWdhcmRzLA0KRGFu
DQo=
