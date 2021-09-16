Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB340E426
	for <lists+linux-spi@lfdr.de>; Thu, 16 Sep 2021 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbhIPQzi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Sep 2021 12:55:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44171 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343498AbhIPQxF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Sep 2021 12:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811104; x=1663347104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vZx+h7n7m3TcDk5WmeLEooFR5D/AArIGP1vWqU0Iobg=;
  b=bDxkF23jQfgYdp8N7+g9d8+gqkdneoDtypOnwolpXdiEGLux9uYJlCaA
   8Tki5paQI2aoFduGgP7W7WjwrAxvo6J/2Eo+2zDUKpW4K0QFU0pp93tqe
   nsVaZKL7MF7TJUuqjkMvU0UbZgoujbuvX+QoMs7puevpDER9EcrL8NEtM
   nXtuSYO5ugqdKAwwloOAGT6FxcBp1aAKnKv4bnibPhyyNGKjq1bdjBz+E
   EJpb5yyPhYA4d1V60IB67agbl0hdhLQf7kSS58XYuAm2NiCTgkW58U+mV
   VmEN1YGotB6BwdL+GiBHpvML14K56rsfSvOovNrgHEOU9xkFxp3416lkL
   g==;
IronPort-SDR: rbJrBcLKcrHtQFMpoMSTKiFmBZXWsOz5BScZRJ4ma2kl5SMIos0q+4iCX1Rxz+VkA1PkBOQgwH
 sVJRNnojf0TyF3GrCeI5pd7mA/Pf3DZsQmo+h8lsJYfbTofsgLWqikGWDsssn1rxqnKtqiUs5Q
 YsJGrxpPUYLbY5DjBALrzxNpOigC+rtanwfFZTsPsrz/kS7uXjkww1IjtanpqKCOA3QdcMvX/x
 dpeJAm+4NvzATdSnIKZCP6Q7VgISklVWp1ewshEHuG+NiRqSvVSB/Dux7cdCp8SRg+MX5fa4Hi
 GO8tMxxTBINc794abfHI/4r7
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="132090070"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:51:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:51:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaGX8+fRQiP449tqW8crjcktU4pyRP/mtceXz+AaN194/K17NII+zAT5FC3lG8GdV1OXkSGzx6etqnhgnGZ2t/ugkpb7MGLx7LPiEyoqgjOZFwiGzRvOwvMwcQ1ieCy+DSe1q25eYhU2JsKxFsyX4y7vNHm2gr8DdhsdRsJAlr/M+7gpD4xcKXHeO4QYm0IAaKG7e44Boqs+lZUem/g7alfwTU2EqKcfdtorVCsq8Mm0OjYGNBT26t/Zp3zDGTXWrzBnvPfMuk6dKuJjwSlqxge+/VXMcVlFyA2rLy/se/esA5gwnkZk98sGHxgA3r1T+Lxj2+WxIuSNAKb4WGQCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vZx+h7n7m3TcDk5WmeLEooFR5D/AArIGP1vWqU0Iobg=;
 b=oZM8nPclBadY2HeUKqi1zH17Wm/mVQRUTJqbGXGZ60gJexpAbvsL+YKwBpsTBiu/8foLerRSrIyL6COk5cwLs3NEkQBbmXNcwwf7vYgSak+GGRGfzUIpqQoJSQgM/lXAOpe9ROhnQcxb5BIZVWNxOJErsaa7iUw3tvL1mlqR6c60AlvqJqHLav3iLTeudNwn1dIh3jHOCuANlTLsV29ABxcARRkpbic1P1VGyMX1yRPMz7Zx0UWGdH21pwCS04Tf221vnW73rReZfmDF5PkJjXU4gjbz+ae38fZMk0hOxXQMsLnEYOmFCInXsRlaoetVov95RtXdDzIhwNODNgeX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZx+h7n7m3TcDk5WmeLEooFR5D/AArIGP1vWqU0Iobg=;
 b=eaxEu+9GV58/gXfkrjmfg6ASSweh523WRn0DjpNdHH35kzAMoSRT8es20CsOrvGnv1uRxoVGSbK5+OrzFMfCDx44C3O13u/PqWsG+SOsR49/wzZVc0TlLz2ANul6Q19eEsXL8oocNLfHwTAaTeH2qpY/BqnPuSqmjuccSsCI7Zc=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:51:42 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641%5]) with mapi id 15.20.4500.020; Thu, 16 Sep 2021
 16:51:42 +0000
From:   <Dan.Sneddon@microchip.com>
To:     <VilleB@bytesnap.co.uk>, <Tudor.Ambarus@microchip.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Dan.Sneddon@microchip.com>
Subject: Re: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Index: AderDWrzqf5xpvNgRsOaMaLInBknhQADbUMA
Date:   Thu, 16 Sep 2021 16:51:42 +0000
Message-ID: <748547ec-43bc-a6a1-f5fa-d717e7637ce1@microchip.com>
References: <3804cb61226e433fb1f7cde911a2785a@bytesnap.co.uk>
In-Reply-To: <3804cb61226e433fb1f7cde911a2785a@bytesnap.co.uk>
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
x-ms-office365-filtering-correlation-id: ac2ef9b8-f8e8-4e8f-f659-08d9793242c2
x-ms-traffictypediagnostic: SJ0PR11MB4830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4830571D7E2A13692114321EE1DC9@SJ0PR11MB4830.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVpws0WP73tS4bFDgHDxrWTSY6+CmqO6hajo7kWwowTfS/MniLVPpnFLANERiAwOmK5yYxvXxnE1O5UvtAM3ftZPNhXPhFt9y4EcXRiXKZRP0NfPT4mmC+xPjuWD5wfnkLJ6HmvL2DwAwr/dFArclXg+wm/KWEjyIzsMkpMbqkqxQbJ5P+YMOYCk7MU6L5CW4w84tRVMhgFJ1mEFV3ZmE4Lyb+NtWAuQaJUbYHDnHZFK7eD/T7NVWhv9f2xd83nQyJHCs/rDnn5lgv3z6xGTfmnBr94AXBie0GEXXZ0LzwKWBOLBoMBqnGEnb3g9EtXXGfE3qZH18H13A9P2LpKXhQK9/0RdIxVz3kyx9wEodJ+v85qhXctnhRr7vDWAI4GIQ/rwmmvo2uxUj5RnWwSge807RAFPdPRWTw2aO/1kZqTf2cRmQTtCRc/WQo7JfXcPPSl37wa93wBisoLjdVoAQiih0l4kvHxwvoKBx/91w/d5T+4bZikkzXO59XeJAtjyiiNlp8jcmnybbO3wXExihV/IxKJOj0Zdd9ejt1EYWliEV5sPHykpiiPXs2cdpd94N/LZ0L+uFvvGVpOlUBW+HvsF7uHAqX53SR8jY1gxb49n9aSHhq9SlUwJRKwwkjamw8Mzj4ehBWfjcA8uHuum9xxC8pGZH2bw5eaKx3wkxFt/FYsRx+P6pmY/mj3Wjbyz+q78roYiZFotmFTAoqdTPnWRGa2QDMro0ZRR58M5hpK3jdqsf2O3dg9/GGtHrIh3e38q/kwA+FxjTRMqgIImuF4yqDpnVojQX0klEfpNuwgnor97ysLs/zzi7i+9q3A2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(8936002)(122000001)(6486002)(966005)(478600001)(38100700002)(54906003)(6512007)(186003)(86362001)(5660300002)(26005)(38070700005)(31686004)(71200400001)(110136005)(4326008)(2906002)(66946007)(66556008)(66476007)(2616005)(107886003)(64756008)(66446008)(76116006)(6636002)(316002)(36756003)(8676002)(53546011)(6506007)(83380400001)(31696002)(45980500001)(43740500002)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REV5ZU84TFdaeTJrdFZSUUtGU1NJNGpXM1VaTHhYeGMwVEVNVFJoSWlDTDdj?=
 =?utf-8?B?Q1Bja3RrbXY4RWhsRDROM0c1T1p0WmxmaXZ6ZVBEUW0zVG5nRGw1Wm4vTWtS?=
 =?utf-8?B?Nk4zdUJtWU9udEg5djJMOG5Hb1dvWjY4U3U3N05kZzg3b09UdnBJS1EvazdV?=
 =?utf-8?B?T3ZmejBXNTQ1NVY0R2Jva1RCdVVJc29EUDc4RDMwYjIvMThCcjFQV3BiOFpl?=
 =?utf-8?B?Rk45b2RGazhUbFI5WUhuaCtCeHZvSXB2bGRoSk9NdFNjYWxCV3YvZVY4V1pm?=
 =?utf-8?B?Mm1CQitlWFhBYmZhcFZMU3V1dlFwNUc0RzFmaU1UL1R0MFcySEQwc2FGejI5?=
 =?utf-8?B?dHptOGgwSWRJT0NHRld4YnhrYjhDMXhtRzVpaDd5UXVLWVNDbW94dlJUcWFF?=
 =?utf-8?B?eldzZGVnWmdadmdFWWI4TFBhZzBENk5vajQ2ZGloa003NzMybEpXOWxxaDU3?=
 =?utf-8?B?UFhub0tmeDY3MnFlY0hxaDFIVWNOK3lVN2ZrWjNxNm9QRk1PMmMrWlNRcWR1?=
 =?utf-8?B?eStQZFpXRWJMVlhUSUg4N2dNT2wxSmRqUXloU2RrdldiWHUvYStTWFlNMlBl?=
 =?utf-8?B?QzdCeDJuK1AvcmhoalZwWERNSTEvdWtzKytzdGRic2V2UHRzeG1YSWhtTnZw?=
 =?utf-8?B?QkhBSDhQSFhNUmhkNERsd1JPNDIyVFZJYlQ5emhtSVJkd0grSEl0RVNyK09h?=
 =?utf-8?B?WVZTSEl4c0JTUWJIUUtkZitYUEFGdEcya3ZGL1hCRTc3aHJjL29xY1I2dlhl?=
 =?utf-8?B?QzY5Q0dSa3FuYnpsOGtzeEFTeXN6SUlaOGdOdkR0NUFhU05YRDRpbW5nN3Br?=
 =?utf-8?B?WXIyekZ6U0dKdlByZjNFMmF2MzFmUmNyUEl4aFlJcktRRjlSYU9va1c1L3hX?=
 =?utf-8?B?RWpwK3lDVWJSbGVjcC9ZaVlUT1dzUGZPOHExZ25KTm9WMVFzZjNvUTVKdVhL?=
 =?utf-8?B?QnBIMU9JZFAvQzEzeUFUS1RNeldWN2M0emhyaUllOVkybmtkWkxzY0RWc0JC?=
 =?utf-8?B?ZWtPOXVTTFhaa2dsZTYxMTRzcVpET3NsWWU3TVhQQ3RHOXd2RHkxWHRoZHRF?=
 =?utf-8?B?QU82cVNEVmNqS1UwcnlQMisrU01wZ0xSNCtWZkdQVVl1a0lCSTUzUXRyeDNw?=
 =?utf-8?B?RmZhbkVBZGxRQmxnL243bktmQnh1QXE1UjZNVkgvUXJ0RkdqOUdMLzhvODZy?=
 =?utf-8?B?YnRlSFNIY3hURTJOM0h2VHY4NVNTVnB0bm5aelVPNGEzL2NBT1FwdzUyMmwx?=
 =?utf-8?B?ZkZBVEFnV2VtM09LckJ2T21DNEVWYXZibXVRNi9aS0huQko0UmxwTHJSbzcv?=
 =?utf-8?B?VUtOdzZGcDRBZm1ndXFhSEd5R0xQU0pyelF0ZS9XdDcrYjNnM0t6aEJJQXkv?=
 =?utf-8?B?WGpPT01IZkE3cHUzdkdweWNDN1drY1U1bnpYamxXclFQY1k2clQvYjArS3NN?=
 =?utf-8?B?OXF5Q2FzVVI0UVltSHZRS1FCb2ZSa3FWZlR4TlViOGxQZzU5L1hEU01IZmpj?=
 =?utf-8?B?NnF0VXNYK1IySUhySFBTYzZmN09xRWVZWjQvYURBVUcwMktKK0Z5Q0lZRWlk?=
 =?utf-8?B?K0ZXMTdmV1NmM0ZrSC9ZMVlGQVBieitIMXNxYlYyMXdudDV4WWZnL2tQZmd5?=
 =?utf-8?B?ME9ZM09MbWVVOHVFNmVuM1JZbHFGbnFzalRBZHQ5dUVNbGNGckNnT1ZyYlNM?=
 =?utf-8?B?ekNPaElhNUtQUWw5amRzak1rZGpyeUFKRFhEVTVKYmVtVW1pNmVOUmNubm1Y?=
 =?utf-8?Q?A7sK+Irt7641sgdtszurzXYaxq7ff+tqnTFsjxx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16E73D3388BFC74AB1B17F33458A6753@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2ef9b8-f8e8-4e8f-f659-08d9793242c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:51:42.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNTYLRM6WIR1Ih/fmdkqjKgtYfgz5QHyIsq2+BUQqirCYEVFgNGRO+7o+tIAVDml0k6lSGdaHQ/68PwjDvOtXChZlaY0g7IoNdFrRMXl2wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgVmlsbGUsDQoNCk9uIDkvMTYvMjEgODoxNiBBTSwgVmlsbGUgQmFpbGxpZSB3cm90ZToNCj4g
W1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVt
YWlsIGZyb20gdmlsbGViQGJ5dGVzbmFwLmNvLnVrLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cDovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24uXQ0KPiAN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiAgRnJvbSA2MTRiY2Y1
MTVjYzhkYmQxYjc1NzNhMmZiZjM2OWZjODRmY2EwNTAxIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQ0KPiBGcm9tOiBWaWxsZSBCYWlsbGllIDx2aWxsZWJAYnl0ZXNuYXAuY28udWs+DQo+IERhdGU6
IFRodSwgMTYgU2VwIDIwMjEgMTQ6MTY6NDYgKzAwMDANCj4gU3ViamVjdDogW1BBVENIXSBzcGk6
IGF0bWVsOiBGaXggUERDIHRyYW5zZmVyIHNldHVwIGJ1Zw0KPiANCj4gQ29tbWl0IGQzNzBmNGIy
ODA4ZCAoInNwaTogYXRtZWw6IFN3aXRjaCB0byB0cmFuc2Zlcl9vbmUgdHJhbnNmZXINCj4gbWV0
aG9kIikgcmVmYWN0b3JlZCB0aGUgY29kZSBhbmQgY2hhbmdlZCBhIGNvbmRpdGlvbmFsIGNhdXNp
bmcNCj4gYXRtZWxfc3BpX2RtYV9tYXBfeGZlciB0byBuZXZlciBiZSBjYWxsZWQgaW4gUERDIG1v
ZGUuIFRoaXMgY2F1c2VzIHRoZQ0KPiBkcml2ZXIgdG8gc2lsZW50bHkgZmFpbC4NCj4gDQo+IFRo
aXMgcGF0Y2ggY2hhbmdlcyB0aGUgY29uZGl0aW9uYWwgdG8gbWF0Y2ggdGhlIGJlaGF2aW91ciBv
ZiB0aGUNCj4gcHJldmlvdXMgY29tbWl0IGJlZm9yZSB0aGUgcmVmYWN0b3IuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBWaWxsZSBCYWlsbGllIDx2aWxsZWJAYnl0ZXNuYXAuY28udWs+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvc3BpL3NwaS1hdG1lbC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3NwaS1hdG1lbC5jIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gaW5kZXggNzg4ZGNk
ZjI1ZjAwLi5mMDBlOWM5YjQyNmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1hdG1l
bC5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jDQo+IEBAIC0xMzAxLDcgKzEzMDEs
NyBAQCBzdGF0aWMgaW50IGF0bWVsX3NwaV9vbmVfdHJhbnNmZXIoc3RydWN0IHNwaV9tYXN0ZXIg
Km1hc3RlciwNCj4gICAgICAgICAgICogRE1BIG1hcCBlYXJseSwgZm9yIHBlcmZvcm1hbmNlIChl
bXB0aWVzIGRjYWNoZSBBU0FQKSBhbmQNCj4gICAgICAgICAgICogYmV0dGVyIGZhdWx0IHJlcG9y
dGluZy4NCj4gICAgICAgICAgICovDQo+IC0gICAgICAgaWYgKCghbWFzdGVyLT5jdXJfbXNnX21h
cHBlZCkNCj4gKyAgICAgICBpZiAoKCFtYXN0ZXItPmN1cl9tc2ctPmlzX2RtYV9tYXBwZWQpDQo+
ICAgICAgICAgICAgICAgICAgJiYgYXMtPnVzZV9wZGMpIHsNCj4gICAgICAgICAgICAgICAgICBp
ZiAoYXRtZWxfc3BpX2RtYV9tYXBfeGZlcihhcywgeGZlcikgPCAwKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQpMb29rcyBsaWtlIHRoZSBzYW1lIGNoYW5nZSBz
aG91bGQgYmUgbWFkZSBhdCB0aGUgZW5kIG9mIHRoYXQgc2FtZSANCmZ1bmN0aW9uIHdoZXJlIHRo
ZSBjYWxsIHRvIGF0bWVsX3NwaV9kbWFfdW5tYXBfeGZlciBpcyBtYWRlLg0KPiAtLQ0KPiAyLjE3
LjENCj4gDQoNCg==
