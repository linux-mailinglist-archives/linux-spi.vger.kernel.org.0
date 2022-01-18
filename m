Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481CD49246B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 12:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiARLOP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 06:14:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:8953 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiARLOM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 06:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642504452; x=1674040452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t6s2b9xtzF8qHXUKiarnhRufYMiIG5EPZ/A7rmFPv8s=;
  b=ouJ+/Vik6V5kzu0tlYs9g+q2g5srfrOapPom9Z1OARZF/NdWMDqYkTu5
   nFjok/EjHZ8DM2KSx1255RPmHLNAdjtm437Sn1ruT3pS/bzokP2HynEKP
   XsHMMdFNVSs587my4a0YiXqX4KRlJ8hevf1n4nf7dDKDFshNhlYeL+cUf
   9R4R3S8WhNpOhcVGZhwO9V+KYLSW+pFS1j6sB59Fn81I8t8CfMMH7Kumg
   2xAtYbqcfMv/bl1kregde+tTGn58mKXIDCsuoV7tlddMhUnhqvVv0QdiE
   5JRpIlXONFN8i8BPYc2yBKfYGW5LafZ0+scQCZ4UGlOAWTOUDofbGkxSQ
   Q==;
IronPort-SDR: eVRSdINdbDTFo3U1uUhduXzZJLEOiYoKEPJk8ASqW/ljRGk+JaoEAwwKx2sO2RaunrqBp+DQ6q
 iXYu7VQgvZFxq/gUq2sOhJEdLrr2LnTLJgDW+sJA6csIGx74mm4l+iZTWg2O5Ixw8GKtRGJv1o
 LWyn37GERvdDwmBssYPTSdjmpLOstyZJqRKMonE9rIZm5S/czfLEBhXx2LbtTxR5FYNVR3uxWa
 gGhsuuSlM484fnVAN7YQhKDQSSu7R3Y4ndTyMbeLX4nt+Gn4h9UiCEMkkYretBAntdNbUNjAIq
 GpVCAMxgpWlX641KjTBW3A14
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="82841482"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jan 2022 04:14:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 18 Jan 2022 04:14:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 18 Jan 2022 04:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ8tL1aqoQHdJqqEbdZSJ/2yDoIiyRtjAH6z+VvIRRuSkD/BXf9Cv9SLAjOtxRoEljGQj99c2BiZYCGhTJe0gz1E5dMteIp1QfFQLEPLntSLijit9eJ+ihlLMpwEemvXMDqqqSsR+LN02bqsl/90QmQ4eEqittx6eTMDNyxQ3AJg/VUjIRXM1djYbigqW5XF86Ban1ld2MtYY45UpB9QTd7luW0k/8zShQRPQX6mYoPCU4dnFuFkBc5f8RFLdNHy2pOtMnc5OeLE764WWGWGZlL/FLjzmcA8e2N5/ntNISsC3VMeZKJ7aUTd5nN71q8qF7PAkT1Dmg8uCOljlMcR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6s2b9xtzF8qHXUKiarnhRufYMiIG5EPZ/A7rmFPv8s=;
 b=aK4rRgRpUfLmPbOhiUFcA4kcjGUFHEye1kBwMltXaXkVjrGxNyQh61BLwzDck77ot81HTxF6PXwvJCCur+dqWbl48qTUY5qQ+/Mfg/IieA4GUCnNDRFwNJoiJEO6zasVtcAmGwDx+JO9tK2ptrSYmEIwhvmzK1cz3a6qx6UI1J3pEqowvNo9PqicPrYK5yDjRxZvfd2h5MmFYD3VnOCHpI94OrUv0ohuK2Su8kXFSGUCR5aaGH94/vSiRU5n4Dn64W47kXNMYEkn4q8RZdgKNKK1Rs/pkh7cW/l4uM0CHeT+iOy9zjmYCGqCE9htSX4u1VdOaNdMgPTIXoCrRwFChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6s2b9xtzF8qHXUKiarnhRufYMiIG5EPZ/A7rmFPv8s=;
 b=jBkjHHVWyCEf43FlU+71FlSbSxFmTxj5BoHBUP35o4Z8NXs06dJ3SleWJ+Egy9LHIlk+gX/sqRCTDLiduRw6Jnvxerq1ADOpOVtT7O/4xDe/C/Y3KT8kwMSjN43Y+kLivMjt/K7TE/1/Mzr8tH7zLlYVqxXHTmMoy4/CdNfddyY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by DM5PR11MB1274.namprd11.prod.outlook.com (2603:10b6:3:12::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Tue, 18 Jan 2022 11:14:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3%9]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 11:14:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <geert@linux-m68k.org>,
        <bin.meng@windriver.com>, <heiko@sntech.de>,
        <Lewis.Hanly@microchip.com>, <Daire.McNamara@microchip.com>,
        <Ivan.Griffin@microchip.com>, <atishp@rivosinc.com>
Subject: Re: [PATCH v4 11/14] riscv: dts: microchip: refactor icicle kit
 device tree
Thread-Topic: [PATCH v4 11/14] riscv: dts: microchip: refactor icicle kit
 device tree
Thread-Index: AQHYC5JrH64PK2OptEWJglhbAWJ60KxoopSA
Date:   Tue, 18 Jan 2022 11:14:03 +0000
Message-ID: <3ffaaaa0-4cd7-5609-e17e-0294f804fe44@microchip.com>
References: <20220117110755.3433142-1-conor.dooley@microchip.com>
 <20220117110755.3433142-12-conor.dooley@microchip.com>
In-Reply-To: <20220117110755.3433142-12-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35c88b7f-569a-43b9-54a3-08d9da73a308
x-ms-traffictypediagnostic: DM5PR11MB1274:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1274268A4EF612AFF25EE0FD98589@DM5PR11MB1274.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMsk596/Howeo4K9WXeuMrR+3HXT01V18zyve/V8BF8aU07MOwwPN2P8eryUFPShmNX+gVnhyz/Mc+10TzqrlinVnXXpHq4uunOEj3SF5W/gRIhkskz/Y9BlAv27FG8V7F4mMs+81zr+I3uGMDjayYmvs7vkCEJMgpLlj8fwm8Z42Qk1dz64PSJYNsaRAl92cUOMNit5UVUPEbXdIOetIept7lIZw+MhNkyi4UZlhh2c069lVGZg7bh+WlLQD0db2h9eIjCNcsnsQzaFDC+v5cP4bZCsX8tQbpz1TmCKRU4ierEIIdCTfDqM5ujRgwzE2xa3ZeCK2NETrAj0wdlqr9XgDZM0zK69+dP89MeZo8DNa2a+mv8E9GaUpHZtD53PfiH8pw0cpE5uSWMoEAUxTcG1t+piUdH0U1GN0vKRov2GVTuMcEQ6+ITBUeqj7JsEpnjIKAf2g6ekGdcOA4dSopjC7p1KrBSQ9m0YQlrJHy3Oku5GhlwRJW8Mt8gPySkX76UGIL3w1wh0tLnwKvZU/SnPHv/oGgiQHsWQyG9Duh1aIxJ8OZTdg35uxWmE9Q/vpil94zAH0Lm5YL5j3c6lB4/KcwSNkZTbM4J2Zfgt6SNgx6jIRP+hxJK7gRMyNw2OFRYoad6NhgpK+y7hanyLNKQ5YeZXPlSljhOwZs8YidESNhKy+mqpHwDVnnPUe27zNmDliy5kW5mratP4N9z9AVRuN9KSp+Us5TcFkp939XsOV6eHSQyZUfR77jx69vXYL9G+zK2fflAqTfW4lq+n+iEqolPZ+k1IZAI3GHWS/oI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(66946007)(4326008)(921005)(71200400001)(316002)(54906003)(110136005)(66476007)(31696002)(66556008)(76116006)(91956017)(6486002)(36756003)(64756008)(66446008)(6512007)(122000001)(7416002)(53546011)(186003)(6506007)(2906002)(2616005)(5660300002)(26005)(38100700002)(31686004)(508600001)(83380400001)(8676002)(8936002)(30864003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3FFSmRRME5HWTgxTWhOdGxHOXhnU3FlTW5OWld2ZW0yTXBPckhvQWo5TzhH?=
 =?utf-8?B?L2VtZzhhOEhGRTROV0lHSDBkT2thQmNkUFVFblVzTDhvNGJqMFl4aE1JOTli?=
 =?utf-8?B?NFkyV3o1UHlmb1c4TTN4T2tYUFA3MHNGQ1BkNG95SU41NUVqQkVsV1ZJNFZ5?=
 =?utf-8?B?Z3R4Tzg0cTA3ZXFSbEd0dkFzVGJoOUJYL0c0L3dXWlZRSWV6Zm5RYnB5RDhK?=
 =?utf-8?B?VnJURnVJRGY4UXFqWDdEOTgwTUI1Ymg1NEZTbktPOWVZUG1PNnlYOWpVN1cx?=
 =?utf-8?B?ajJVcng2eEhxM2MwZlRsbFhUNFRoUHljdmpPK2dzbGtBUnY3OFZiL3l4UjhE?=
 =?utf-8?B?dWErR0ZJN0dtclJaSXRQNU5SZjhTektZM3h5K3VWRUszUWxMamlLU1YwNk9y?=
 =?utf-8?B?bW9ZdXMvcFQvT0dxdGF5V0ZTZERSRVNhQjJmWStmMllXb0FJZlFqTTRYVHFR?=
 =?utf-8?B?TGtoNjIxQ1RyTTJBOU1CUkpZN0laUm5GOS91N0JKSStoZGlpOERUelFhQ3Va?=
 =?utf-8?B?c242UysrZ0dKZ3BFN240cytrd2FzbVR6R09Dc0JtMjZ0NHdKVlk2RU9rUjBv?=
 =?utf-8?B?clBjdkNpM1hIOFNGUmlDajlBazZ1V2s1YldwWFEzWkZvVE02TW1VQW53MWxz?=
 =?utf-8?B?cE1JTWZ6WDRaM2FKTFNLcGVsNExpOWljU2d2SUhnc3hSUXRxdzZML1JoL0ZN?=
 =?utf-8?B?RCtJT054aUdOVE1lL1Q1bjlSSGtxeDV6V1ViNnltZndyMXNVVFdxV0g4eVd2?=
 =?utf-8?B?aUttZzN2b0UzQ0tVRVZma00xUkZIcDluVXlvZDNGamFRMi95bjd2bHhaQ1lw?=
 =?utf-8?B?amhURGdrUE45dlpKVEdpTktTaEVtK0xhdGcyK2NpNDFmRzFTT2hkdmxyR1ow?=
 =?utf-8?B?NG5IUmpvVnkzRTlISGhad1FsNnRXR1M4L0JDMjhaKzlNNzViYUM3V1RvdHRF?=
 =?utf-8?B?TElCUXQrZktVVXpESEpWUnFxZUZKVTNHRkZQWUw4d1YwK3FPNXh2RExLS1Fx?=
 =?utf-8?B?VXNQQjZqaE9PSHRRZ0ZjeGxXMmcrSDlaTGFKNzd5WVozTUhNVElUb1dVRFNn?=
 =?utf-8?B?K1VOR29QL1pKWnhERlkySTZxSHIzYS9zRzU5UndTdS9pSEM2dkhyc0krT0FD?=
 =?utf-8?B?aXRMMmFWZjRPdHNLZ2dFNlpCa3RKc1kvbTlybHVuaW5PN2NETCtLamVGQUJq?=
 =?utf-8?B?QnhkbW4ya0Z2Q2Iyait4T0Q3V3hmb1ZjeDl2Q25JTUZsUUFzQ3hkRXA3TTlG?=
 =?utf-8?B?M0NMNFUzc0d6SWdTdkR0MGNueTlyeG5SRXRzQnY4Sm1ZaSsrM2dBdXFRY0Ft?=
 =?utf-8?B?K2VuN1JvRG5zVlAzZ05qYVREVTNwT1hmUjdyb0w4dGQvcEZQa1VtVW9qQmd5?=
 =?utf-8?B?d2FKK3B5MCtQalNab00yOXhveVdoTXUrOFN0Qk4yclF4cTgrWVVma1U2QTZU?=
 =?utf-8?B?cWlLV2JubzZZeUZYa2c1N1hLT29RL3RBNGF0Znp2Z3NGdFczVVMxUzV4cUxw?=
 =?utf-8?B?aEVmZjRZSXYxbWRVWUdHS2tIcVFwZkRqZGFiMzluWWE4Q2tBOFgveFVTSk84?=
 =?utf-8?B?UnRYRnhwUnBnLzVjbFZJZVJmOWl5bGg4SloxRG5yRCtydGhUVzVYbjFFMkty?=
 =?utf-8?B?cWczdlJicjJuYlM3NFZEamNWL2dYbmxaVGtMNjY0QlUvTkdvNG9MMHFaRTdn?=
 =?utf-8?B?aUJkc3NwM1dQbVpWUVo3SXVkQlJUVmJwbWZRQ1VWV3ZKQUptdjI5alYyVVR6?=
 =?utf-8?B?bG4zSHprekdOaXhyM1I1ZXQ0STQ4MmZ2d3pMZ1huN2VuZzVLYUtUMW9HVnVz?=
 =?utf-8?B?U3lTT2FGMEtSV0dIMWl6TWx0M0FudWJZdGZkOW5pS2x4OHI4MjVoTzNoOC8v?=
 =?utf-8?B?YzM5L0crNWljakhQZkhYUFozYklMU3JXZEVxRHpkNW80K204VUh5anQ1Y3NN?=
 =?utf-8?B?bDZKdlhVVTRCdlBiZElpdzBwYmZrbmxKUG1jWklPeUpOSDVveDRldUpidkVB?=
 =?utf-8?B?aFJZNnhSLzUyR2hpRGJhRnVxNnk0bllCd1RCYlpXUXEyN25uMVF6VTVmdC8w?=
 =?utf-8?B?d2owcUhnWmhvUVV1MWpKdWUvMDNuRjdKSkxBaFpEajBYbjc4b2w3RmxPYW5B?=
 =?utf-8?B?YndiSFZLVnB5cUlaVTJsWTlKYloxUFc1MzBMR2J6MHlWUmpiSzBkREYxLzZo?=
 =?utf-8?B?MFNqOVB6dE5hV0tMT0x6MlRJS3EzcjVUS25CTGpUWkI3Nkc2NlhMS0xlUVBK?=
 =?utf-8?B?UlUwbUs5dVNoZGRYMHR1bVYrRjh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F7261D64E4CF4FB09220584EF92121@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c88b7f-569a-43b9-54a3-08d9da73a308
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 11:14:03.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kXAw35AsMwbK1BdQAJ4wg8sh0bsRFSBwpSEbSXnHMODfhLIGHP2wugSWcuUajF0am8YF1B8Y8nv164YYyGTbHZ/Wu5Rc8vxiYNsxxicn3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1274
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTcvMDEvMjAyMiAxMTowNywgY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBB
c3NvcnRlZCBtaW5vciBjaGFuZ2VzIHRvIHRoZSBNUEZTL0ljaWNsZSBraXQgZGV2aWNlIHRyZWU6
DQo+IA0KPiAtIHJlbmFtZSBzZXJpYWwgdG8gbW11YXJ0IHRvIG1hdGNoIG1pY3JvY2hpcCBkb2N1
bWVudGF0aW9uDQo+IC0gbW92ZSBwaHkwIGluc2lkZSBtYWMxIG5vZGUgdG8gbWF0Y2ggcGh5IGNv
bmZpZ3VyYXRpb24NCj4gLSBhZGQgbGFiZWxzIHdoZXJlIG1pc3NpbmcgKGNwdXMsIGNhY2hlIGNv
bnRyb2xsZXIpDQo+IC0gYWRkIG1pc3NpbmcgYWRkcmVzcyBjZWxscyAmIGludGVycnVwdHMgdG8g
TUFDcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWlj
cm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgLi4uL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2lj
bGUta2l0LmR0cyAgIHwgIDM3ICsrLS0tDQo+ICAgLi4uL2Jvb3QvZHRzL21pY3JvY2hpcC9taWNy
b2NoaXAtbXBmcy5kdHNpICAgIHwgIDY1ICsrKysrLS0tLQ0KPiAgIGFyY2gvcmlzY3YvY29uZmln
cy9pY2ljbGVfa2l0X2RlZmNvbmZpZyAgICAgICB8IDEzNA0KbGFzdCB0aW1lIGkgY2hlY2tlZCB0
aGlzIHdhcyBub3QgYSBkZXZpY2UgdHJlZSBjaGFuZ2UuDQp3aGF0IGEgbWVzcyBpIG1hZGUgb2Yg
djMuLi4NCisrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTg2IGluc2Vy
dGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jp
c2N2L2NvbmZpZ3MvaWNpY2xlX2tpdF9kZWZjb25maWcNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cyBi
L2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQu
ZHRzDQo+IGluZGV4IGFiODAzZjcxNjI2YS4uYzUxYmQ3Y2Y1MDBmIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0
cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1p
Y2ljbGUta2l0LmR0cw0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiAtLyogQ29weXJpZ2h0IChjKSAyMDIwIE1pY3Jv
Y2hpcCBUZWNobm9sb2d5IEluYyAqLw0KPiArLyogQ29weXJpZ2h0IChjKSAyMDIwLTIwMjEgTWlj
cm9jaGlwIFRlY2hub2xvZ3kgSW5jICovDQo+ICAgDQo+ICAgL2R0cy12MS87DQo+ICAgDQo+IEBA
IC0xMywxMSArMTMsMTEgQEAgLyB7DQo+ICAgCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMt
aWNpY2xlLWtpdCIsICJtaWNyb2NoaXAsbXBmcyI7DQo+ICAgDQo+ICAgCWFsaWFzZXMgew0KPiAt
CQlldGhlcm5ldDAgPSAmZW1hYzE7DQo+IC0JCXNlcmlhbDAgPSAmc2VyaWFsMDsNCj4gLQkJc2Vy
aWFsMSA9ICZzZXJpYWwxOw0KPiAtCQlzZXJpYWwyID0gJnNlcmlhbDI7DQo+IC0JCXNlcmlhbDMg
PSAmc2VyaWFsMzsNCj4gKwkJZXRoZXJuZXQwID0gJm1hYzE7DQo+ICsJCXNlcmlhbDAgPSAmbW11
YXJ0MDsNCj4gKwkJc2VyaWFsMSA9ICZtbXVhcnQxOw0KPiArCQlzZXJpYWwyID0gJm1tdWFydDI7
DQo+ICsJCXNlcmlhbDMgPSAmbW11YXJ0MzsNCj4gICAJfTsNCj4gICANCj4gICAJY2hvc2VuIHsN
Cj4gQEAgLTM5LDE5ICszOSwxOSBAQCAmcmVmY2xrIHsNCj4gICAJY2xvY2stZnJlcXVlbmN5ID0g
PDYwMDAwMDAwMD47DQo+ICAgfTsNCj4gICANCj4gLSZzZXJpYWwwIHsNCj4gKyZtbXVhcnQwIHsN
Cj4gICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgIH07DQo+ICAgDQo+IC0mc2VyaWFsMSB7DQo+ICsm
bW11YXJ0MSB7DQo+ICAgCXN0YXR1cyA9ICJva2F5IjsNCj4gICB9Ow0KPiAgIA0KPiAtJnNlcmlh
bDIgew0KPiArJm1tdWFydDIgew0KPiAgIAlzdGF0dXMgPSAib2theSI7DQo+ICAgfTsNCj4gICAN
Cj4gLSZzZXJpYWwzIHsNCj4gKyZtbXVhcnQzIHsNCj4gICAJc3RhdHVzID0gIm9rYXkiOw0KPiAg
IH07DQo+ICAgDQo+IEBAIC02MSw3ICs2MSwxMCBAQCAmbW1jIHsNCj4gICAJYnVzLXdpZHRoID0g
PDQ+Ow0KPiAgIAlkaXNhYmxlLXdwOw0KPiAgIAljYXAtc2QtaGlnaHNwZWVkOw0KPiArCWNhcC1t
bWMtaGlnaHNwZWVkOw0KPiAgIAljYXJkLWRldGVjdC1kZWxheSA9IDwyMDA+Ow0KPiArCW1tYy1k
ZHItMV84djsNCj4gKwltbWMtaHMyMDAtMV84djsNCj4gICAJc2QtdWhzLXNkcjEyOw0KPiAgIAlz
ZC11aHMtc2RyMjU7DQo+ICAgCXNkLXVocy1zZHI1MDsNCj4gQEAgLTcyLDIyICs3NSwyMiBAQCAm
aTJjMiB7DQo+ICAgCXN0YXR1cyA9ICJva2F5IjsNCj4gICB9Ow0KPiAgIA0KPiAtJmVtYWMwIHsN
Cj4gKyZtYWMwIHsNCj4gICAJcGh5LW1vZGUgPSAic2dtaWkiOw0KPiAgIAlwaHktaGFuZGxlID0g
PCZwaHkwPjsNCj4gLQlwaHkwOiBldGhlcm5ldC1waHlAOCB7DQo+IC0JCXJlZyA9IDw4PjsNCj4g
LQkJdGksZmlmby1kZXB0aCA9IDwweDAxPjsNCj4gLQl9Ow0KPiAgIH07DQo+ICAgDQo+IC0mZW1h
YzEgew0KPiArJm1hYzEgew0KPiAgIAlzdGF0dXMgPSAib2theSI7DQo+ICAgCXBoeS1tb2RlID0g
InNnbWlpIjsNCj4gICAJcGh5LWhhbmRsZSA9IDwmcGh5MT47DQo+ICAgCXBoeTE6IGV0aGVybmV0
LXBoeUA5IHsNCj4gICAJCXJlZyA9IDw5PjsNCj4gLQkJdGksZmlmby1kZXB0aCA9IDwweDAxPjsN
Cj4gKwkJdGksZmlmby1kZXB0aCA9IDwweDE+Ow0KPiArCX07DQo+ICsJcGh5MDogZXRoZXJuZXQt
cGh5QDggew0KPiArCQlyZWcgPSA8OD47DQo+ICsJCXRpLGZpZm8tZGVwdGggPSA8MHgxPjsNCj4g
ICAJfTsNCj4gICB9Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9t
aWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gaW5kZXggYzdkNzM3NTZjOWI4Li42MmJkMDAwOTJi
Y2MgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hp
cC1tcGZzLmR0c2kNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMuZHRzaQ0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiAtLyogQ29weXJpZ2h0IChjKSAyMDIwIE1pY3Jv
Y2hpcCBUZWNobm9sb2d5IEluYyAqLw0KPiArLyogQ29weXJpZ2h0IChjKSAyMDIwLTIwMjEgTWlj
cm9jaGlwIFRlY2hub2xvZ3kgSW5jICovDQo+ICAgDQo+ICAgL2R0cy12MS87DQo+ICAgI2luY2x1
ZGUgImR0LWJpbmRpbmdzL2Nsb2NrL21pY3JvY2hpcCxtcGZzLWNsb2NrLmgiDQo+IEBAIC0xNSw3
ICsxNSw3IEBAIGNwdXMgew0KPiAgIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAgCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCj4gICANCj4gLQkJY3B1QDAgew0KPiArCQljcHUwOiBjcHVAMCB7DQo+
ICAgCQkJY29tcGF0aWJsZSA9ICJzaWZpdmUsZTUxIiwgInNpZml2ZSxyb2NrZXQwIiwgInJpc2N2
IjsNCj4gICAJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPiAgIAkJCWktY2FjaGUtYmxvY2stc2l6
ZSA9IDw2ND47DQo+IEBAIC0zMyw3ICszMyw3IEBAIGNwdTBfaW50YzogaW50ZXJydXB0LWNvbnRy
b2xsZXIgew0KPiAgIAkJCX07DQo+ICAgCQl9Ow0KPiAgIA0KPiAtCQljcHVAMSB7DQo+ICsJCWNw
dTE6IGNwdUAxIHsNCj4gICAJCQljb21wYXRpYmxlID0gInNpZml2ZSx1NTQtbWMiLCAic2lmaXZl
LHJvY2tldDAiLCAicmlzY3YiOw0KPiAgIAkJCWQtY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47DQo+
ICAgCQkJZC1jYWNoZS1zZXRzID0gPDY0PjsNCj4gQEAgLTYwLDcgKzYwLDcgQEAgY3B1MV9pbnRj
OiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ICAgCQkJfTsNCj4gICAJCX07DQo+ICAgDQo+IC0J
CWNwdUAyIHsNCj4gKwkJY3B1MjogY3B1QDIgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAic2lmaXZl
LHU1NC1tYyIsICJzaWZpdmUscm9ja2V0MCIsICJyaXNjdiI7DQo+ICAgCQkJZC1jYWNoZS1ibG9j
ay1zaXplID0gPDY0PjsNCj4gICAJCQlkLWNhY2hlLXNldHMgPSA8NjQ+Ow0KPiBAQCAtODcsNyAr
ODcsNyBAQCBjcHUyX2ludGM6IGludGVycnVwdC1jb250cm9sbGVyIHsNCj4gICAJCQl9Ow0KPiAg
IAkJfTsNCj4gICANCj4gLQkJY3B1QDMgew0KPiArCQljcHUzOiBjcHVAMyB7DQo+ICAgCQkJY29t
cGF0aWJsZSA9ICJzaWZpdmUsdTU0LW1jIiwgInNpZml2ZSxyb2NrZXQwIiwgInJpc2N2IjsNCj4g
ICAJCQlkLWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Ow0KPiAgIAkJCWQtY2FjaGUtc2V0cyA9IDw2
ND47DQo+IEBAIC0xMTQsNyArMTE0LDcgQEAgY3B1M19pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxl
ciB7DQo+ICAgCQkJfTsNCj4gICAJCX07DQo+ICAgDQo+IC0JCWNwdUA0IHsNCj4gKwkJY3B1NDog
Y3B1QDQgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAic2lmaXZlLHU1NC1tYyIsICJzaWZpdmUscm9j
a2V0MCIsICJyaXNjdiI7DQo+ICAgCQkJZC1jYWNoZS1ibG9jay1zaXplID0gPDY0PjsNCj4gICAJ
CQlkLWNhY2hlLXNldHMgPSA8NjQ+Ow0KPiBAQCAtMTUyLDggKzE1Miw5IEBAIHNvYyB7DQo+ICAg
CQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiAgIAkJcmFuZ2VzOw0KPiAgIA0KPiAtCQlj
YWNoZS1jb250cm9sbGVyQDIwMTAwMDAgew0KPiArCQljY3RybGxyOiBjYWNoZS1jb250cm9sbGVy
QDIwMTAwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAic2lmaXZlLGZ1NTQwLWMwMDAtY2NhY2hl
IiwgImNhY2hlIjsNCj4gKwkJCXJlZyA9IDwweDAgMHgyMDEwMDAwIDB4MCAweDEwMDA+Ow0KPiAg
IAkJCWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Ow0KPiAgIAkJCWNhY2hlLWxldmVsID0gPDI+Ow0K
PiAgIAkJCWNhY2hlLXNldHMgPSA8MTAyND47DQo+IEBAIC0xNjEsMTAgKzE2Miw5IEBAIGNhY2hl
LWNvbnRyb2xsZXJAMjAxMDAwMCB7DQo+ICAgCQkJY2FjaGUtdW5pZmllZDsNCj4gICAJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gICAJCQlpbnRlcnJ1cHRzID0gPDE+LCA8Mj4sIDwz
PjsNCj4gLQkJCXJlZyA9IDwweDAgMHgyMDEwMDAwIDB4MCAweDEwMDA+Ow0KPiAgIAkJfTsNCj4g
ICANCj4gLQkJY2xpbnRAMjAwMDAwMCB7DQo+ICsJCWNsaW50OiBjbGludEAyMDAwMDAwIHsNCj4g
ICAJCQljb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1jMDAwLWNsaW50IiwgInNpZml2ZSxjbGlu
dDAiOw0KPiAgIAkJCXJlZyA9IDwweDAgMHgyMDAwMDAwIDB4MCAweEMwMDA+Ow0KPiAgIAkJCWlu
dGVycnVwdHMtZXh0ZW5kZWQgPSA8JmNwdTBfaW50YyAzPiwgPCZjcHUwX2ludGMgNz4sDQo+IEBA
IC0xNzQsNiArMTc0LDE1IEBAIGNsaW50QDIwMDAwMDAgew0KPiAgIAkJCQkJICAgICAgPCZjcHU0
X2ludGMgMz4sIDwmY3B1NF9pbnRjIDc+Ow0KPiAgIAkJfTsNCj4gICANCj4gKwkJZG1hQDMwMDAw
MDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJzaWZpdmUsZnU1NDAtYzAwMC1wZG1hIjsNCj4gKwkJ
CXJlZyA9IDwweDAgMHgzMDAwMDAwIDB4MCAweDgwMDA+Ow0KPiArCQkJaW50ZXJydXB0LXBhcmVu
dCA9IDwmcGxpYz47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPDIzPiwgPDI0PiwgPDI1PiwgPDI2Piwg
PDI3PiwgPDI4PiwgPDI5PiwNCj4gKwkJCQkgICAgIDwzMD47DQo+ICsJCQkjZG1hLWNlbGxzID0g
PDE+Ow0KPiArCQl9Ow0KPiArDQo+ICAgCQlwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBjMDAw
MDAwIHsNCj4gICAJCQljb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1jMDAwLXBsaWMiLCAic2lm
aXZlLHBsaWMtMS4wLjAiOw0KPiAgIAkJCXJlZyA9IDwweDAgMHhjMDAwMDAwIDB4MCAweDQwMDAw
MDA+Ow0KPiBAQCAtMTg4LDE1ICsxOTcsNiBAQCBwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBj
MDAwMDAwIHsNCj4gICAJCQlyaXNjdixuZGV2ID0gPDE4Nj47DQo+ICAgCQl9Ow0KPiAgIA0KPiAt
CQlkbWFAMzAwMDAwMCB7DQo+IC0JCQljb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1jMDAwLXBk
bWEiOw0KPiAtCQkJcmVnID0gPDB4MCAweDMwMDAwMDAgMHgwIDB4ODAwMD47DQo+IC0JCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gLQkJCWludGVycnVwdHMgPSA8MjM+LCA8MjQ+LCA8
MjU+LCA8MjY+LCA8Mjc+LCA8Mjg+LCA8Mjk+LA0KPiAtCQkJCSAgICAgPDMwPjsNCj4gLQkJCSNk
bWEtY2VsbHMgPSA8MT47DQo+IC0JCX07DQo+IC0NCj4gICAJCWNsa2NmZzogY2xrY2ZnQDIwMDAy
MDAwIHsNCj4gICAJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLWNsa2NmZyI7DQo+ICAg
CQkJcmVnID0gPDB4MCAweDIwMDAyMDAwIDB4MCAweDEwMDA+Ow0KPiBAQCAtMjA0LDcgKzIwNCw3
IEBAIGNsa2NmZzogY2xrY2ZnQDIwMDAyMDAwIHsNCj4gICAJCQkjY2xvY2stY2VsbHMgPSA8MT47
DQo+ICAgCQl9Ow0KPiAgIA0KPiAtCQlzZXJpYWwwOiBzZXJpYWxAMjAwMDAwMDAgew0KPiArCQlt
bXVhcnQwOiBzZXJpYWxAMjAwMDAwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEi
Ow0KPiAgIAkJCXJlZyA9IDwweDAgMHgyMDAwMDAwMCAweDAgMHg0MDA+Ow0KPiAgIAkJCXJlZy1p
by13aWR0aCA9IDw0PjsNCj4gQEAgLTIxNiw3ICsyMTYsNyBAQCBzZXJpYWwwOiBzZXJpYWxAMjAw
MDAwMDAgew0KPiAgIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgCQl9Ow0KPiAgIA0KPiAt
CQlzZXJpYWwxOiBzZXJpYWxAMjAxMDAwMDAgew0KPiArCQltbXVhcnQxOiBzZXJpYWxAMjAxMDAw
MDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEiOw0KPiAgIAkJCXJlZyA9IDwweDAg
MHgyMDEwMDAwMCAweDAgMHg0MDA+Ow0KPiAgIAkJCXJlZy1pby13aWR0aCA9IDw0PjsNCj4gQEAg
LTIyOCw3ICsyMjgsNyBAQCBzZXJpYWwxOiBzZXJpYWxAMjAxMDAwMDAgew0KPiAgIAkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICAgCQl9Ow0KPiAgIA0KPiAtCQlzZXJpYWwyOiBzZXJpYWxAMjAx
MDIwMDAgew0KPiArCQltbXVhcnQyOiBzZXJpYWxAMjAxMDIwMDAgew0KPiAgIAkJCWNvbXBhdGli
bGUgPSAibnMxNjU1MGEiOw0KPiAgIAkJCXJlZyA9IDwweDAgMHgyMDEwMjAwMCAweDAgMHg0MDA+
Ow0KPiAgIAkJCXJlZy1pby13aWR0aCA9IDw0PjsNCj4gQEAgLTI0MCw3ICsyNDAsNyBAQCBzZXJp
YWwyOiBzZXJpYWxAMjAxMDIwMDAgew0KPiAgIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAg
CQl9Ow0KPiAgIA0KPiAtCQlzZXJpYWwzOiBzZXJpYWxAMjAxMDQwMDAgew0KPiArCQltbXVhcnQz
OiBzZXJpYWxAMjAxMDQwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEiOw0KPiAg
IAkJCXJlZyA9IDwweDAgMHgyMDEwNDAwMCAweDAgMHg0MDA+Ow0KPiAgIAkJCXJlZy1pby13aWR0
aCA9IDw0PjsNCj4gQEAgLTI1NywzNyArMjU3LDM2IEBAIG1tYzogbW1jQDIwMDA4MDAwIHsNCj4g
ICAJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLXNkNGhjIiwgImNkbnMsc2Q0aGMiOw0K
PiAgIAkJCXJlZyA9IDwweDAgMHgyMDAwODAwMCAweDAgMHgxMDAwPjsNCj4gICAJCQlpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gLQkJCWludGVycnVwdHMgPSA8ODg+LCA8ODk+Ow0KPiAr
CQkJaW50ZXJydXB0cyA9IDw4OD47DQo+ICAgCQkJY2xvY2tzID0gPCZjbGtjZmcgQ0xLX01NQz47
DQo+ICAgCQkJbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+Ow0KPiAgIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAgCQl9Ow0KPiAgIA0KPiAtCQllbWFjMDogZXRoZXJuZXRAMjAxMTAwMDAg
ew0KPiArCQltYWMwOiBldGhlcm5ldEAyMDExMDAwMCB7DQo+ICAgCQkJY29tcGF0aWJsZSA9ICJj
ZG5zLG1hY2IiOw0KPiAgIAkJCXJlZyA9IDwweDAgMHgyMDExMDAwMCAweDAgMHgyMDAwPjsNCj4g
KwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICAg
CQkJaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47DQo+IC0JCQlpbnRlcnJ1cHRzID0gPDY0Piwg
PDY1PiwgPDY2PiwgPDY3PjsNCj4gKwkJCWludGVycnVwdHMgPSA8NjQ+LCA8NjU+LCA8NjY+LCA8
Njc+LCA8Njg+LCA8Njk+Ow0KPiAgIAkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWzAwIDAwIDAwIDAw
IDAwIDAwXTsNCj4gICAJCQljbG9ja3MgPSA8JmNsa2NmZyBDTEtfTUFDMD4sIDwmY2xrY2ZnIENM
S19BSEI+Ow0KPiAgIAkJCWNsb2NrLW5hbWVzID0gInBjbGsiLCAiaGNsayI7DQo+ICAgCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gLQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtCQkJI3Np
emUtY2VsbHMgPSA8MD47DQo+ICAgCQl9Ow0KPiAgIA0KPiAtCQllbWFjMTogZXRoZXJuZXRAMjAx
MTIwMDAgew0KPiArCQltYWMxOiBldGhlcm5ldEAyMDExMjAwMCB7DQo+ICAgCQkJY29tcGF0aWJs
ZSA9ICJjZG5zLG1hY2IiOw0KPiAgIAkJCXJlZyA9IDwweDAgMHgyMDExMjAwMCAweDAgMHgyMDAw
PjsNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MD47
DQo+ICAgCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47DQo+IC0JCQlpbnRlcnJ1cHRzID0g
PDcwPiwgPDcxPiwgPDcyPiwgPDczPjsNCj4gKwkJCWludGVycnVwdHMgPSA8NzA+LCA8NzE+LCA8
NzI+LCA8NzM+LCA8NzQ+LCA8NzU+Ow0KPiAgIAkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWzAwIDAw
IDAwIDAwIDAwIDAwXTsNCj4gICAJCQljbG9ja3MgPSA8JmNsa2NmZyBDTEtfTUFDMT4sIDwmY2xr
Y2ZnIENMS19BSEI+Ow0KPiAtCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAJCQljbG9jay1u
YW1lcyA9ICJwY2xrIiwgImhjbGsiOw0KPiAtCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0J
CQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgCQl9
Ow0KPiAtDQo+ICAgCX07DQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvY29uZmln
cy9pY2ljbGVfa2l0X2RlZmNvbmZpZyBiL2FyY2gvcmlzY3YvY29uZmlncy9pY2ljbGVfa2l0X2Rl
ZmNvbmZpZw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY0
ODQxMzBlNzIzZA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvcmlzY3YvY29uZmlncy9p
Y2ljbGVfa2l0X2RlZmNvbmZpZw0KPiBAQCAtMCwwICsxLDEzNCBAQA0KPiArQ09ORklHX1NZU1ZJ
UEM9eQ0KPiArQ09ORklHX1BPU0lYX01RVUVVRT15DQo+ICtDT05GSUdfTk9fSFpfSURMRT15DQo+
ICtDT05GSUdfSElHSF9SRVNfVElNRVJTPXkNCj4gK0NPTkZJR19JS0NPTkZJRz15DQo+ICtDT05G
SUdfSUtDT05GSUdfUFJPQz15DQo+ICtDT05GSUdfQ0dST1VQUz15DQo+ICtDT05GSUdfQ0dST1VQ
X1NDSEVEPXkNCj4gK0NPTkZJR19DRlNfQkFORFdJRFRIPXkNCj4gK0NPTkZJR19DR1JPVVBfQlBG
PXkNCj4gK0NPTkZJR19OQU1FU1BBQ0VTPXkNCj4gK0NPTkZJR19VU0VSX05TPXkNCj4gK0NPTkZJ
R19CTEtfREVWX0lOSVRSRD15DQo+ICtDT05GSUdfRVhQRVJUPXkNCj4gK0NPTkZJR19LQUxMU1lN
U19BTEw9eQ0KPiArQ09ORklHX0JQRl9TWVNDQUxMPXkNCj4gK0NPTkZJR19TT0NfTUlDUk9DSElQ
X1BPTEFSRklSRT15DQo+ICtDT05GSUdfU01QPXkNCj4gK0NPTkZJR19DTURMSU5FPSJlYXJseXBy
aW50ayBlYXJseWNvbj1zYmkgZGVidWcgdWlvX3BkcnZfZ2VuaXJxLm9mX2lkPWdlbmVyaWMtdWlv
Ig0KPiArQ09ORklHX0pVTVBfTEFCRUw9eQ0KPiArQ09ORklHX01PRFVMRVM9eQ0KPiArQ09ORklH
X01PRFVMRV9VTkxPQUQ9eQ0KPiArQ09ORklHX0JMS19ERVZfWk9ORUQ9eQ0KPiArQ09ORklHX1BB
UlRJVElPTl9BRFZBTkNFRD15DQo+ICtDT05GSUdfTkVUPXkNCj4gK0NPTkZJR19QQUNLRVQ9eQ0K
PiArQ09ORklHX1VOSVg9eQ0KPiArQ09ORklHX0lORVQ9eQ0KPiArQ09ORklHX05FVExJTktfRElB
Rz15DQo+ICtDT05GSUdfUENJPXkNCj4gK0NPTkZJR19QQ0lfREVCVUc9eQ0KPiArQ09ORklHX1BD
SV9IT1NUX0dFTkVSSUM9eQ0KPiArQ09ORklHX1BDSUVfTUlDUk9DSElQX0hPU1Q9eQ0KPiArQ09O
RklHX0RFVlRNUEZTPXkNCj4gK0NPTkZJR19ERVZUTVBGU19NT1VOVD15DQo+ICtDT05GSUdfQkxL
X0RFVl9MT09QPXkNCj4gK0NPTkZJR19CTEtfREVWX05CRD15DQo+ICtDT05GSUdfQkxLX0RFVl9O
Vk1FPXkNCj4gK0NPTkZJR19CTEtfREVWX1NEPXkNCj4gK0NPTkZJR19CTEtfREVWX1NSPXkNCj4g
K0NPTkZJR19BVEE9eQ0KPiArQ09ORklHX05FVERFVklDRVM9eQ0KPiArQ09ORklHX01BQ0I9eQ0K
PiArQ09ORklHX1I4MTY5PXkNCj4gK0NPTkZJR19JTlBVVF9NT1VTRURFVj15DQo+ICtDT05GSUdf
SU5QVVRfRVZERVY9eQ0KPiArQ09ORklHX1NFUklBTF84MjUwPXkNCj4gK0NPTkZJR19TRVJJQUxf
ODI1MF9DT05TT0xFPXkNCj4gK0NPTkZJR19TRVJJQUxfT0ZfUExBVEZPUk09eQ0KPiArQ09ORklH
X1NFUklBTF9FQVJMWUNPTl9SSVNDVl9TQkk9eQ0KPiArQ09ORklHX0hXX1JBTkRPTT15DQo+ICtD
T05GSUdfSFdfUkFORE9NX1BPTEFSRklSRV9TT0M9eQ0KPiArQ09ORklHX0kyQ19DSEFSREVWPXkN
Cj4gK0NPTkZJR19JMkNfTUlDUk9DSElQPXkNCj4gK0NPTkZJR19TUEk9eQ0KPiArQ09ORklHX1NQ
SV9QT0xBUkZJUkVfU09DPXkNCj4gK0NPTkZJR19TUElfUE9MQVJGSVJFX1NPQ19RU1BJPXkNCj4g
K0NPTkZJR19TUElfU1BJREVWPXkNCj4gK0NPTkZJR19HUElPTElCPXkNCj4gK0NPTkZJR19HUElP
X1NZU0ZTPXkNCj4gK0NPTkZJR19HUElPX1BPTEFSRklSRV9TT0M9eQ0KPiArQ09ORklHX1BPV0VS
X1JFU0VUPXkNCj4gK0NPTkZJR19NRURJQV9TVVBQT1JUPXkNCj4gK0NPTkZJR19NRURJQV9VU0Jf
U1VQUE9SVD15DQo+ICtDT05GSUdfVVNCX1ZJREVPX0NMQVNTPXkNCj4gK0NPTkZJR19WNExfUExB
VEZPUk1fRFJJVkVSUz15DQo+ICtDT05GSUdfRFJNPXkNCj4gK0NPTkZJR19EUk1fUkFERU9OPXkN
Cj4gK0NPTkZJR19EUk1fTk9VVkVBVT15DQo+ICtDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRT15
DQo+ICtDT05GSUdfVVNCPXkNCj4gK0NPTkZJR19VU0JfWEhDSV9IQ0Q9eQ0KPiArQ09ORklHX1VT
Ql9YSENJX1BMQVRGT1JNPXkNCj4gK0NPTkZJR19VU0JfRUhDSV9IQ0Q9eQ0KPiArQ09ORklHX1VT
Ql9FSENJX0hDRF9QTEFURk9STT15DQo+ICtDT05GSUdfVVNCX09IQ0lfSENEPXkNCj4gK0NPTkZJ
R19VU0JfT0hDSV9IQ0RfUExBVEZPUk09eQ0KPiArQ09ORklHX1VTQl9BQ009eQ0KPiArQ09ORklH
X1VTQl9TVE9SQUdFPXkNCj4gK0NPTkZJR19VU0JfTVVTQl9IRFJDPXkNCj4gK0NPTkZJR19VU0Jf
TVVTQl9QT0xBUkZJUkVfU09DPXkNCj4gK0NPTkZJR19VU0JfSU5WRU5UUkFfRE1BPXkNCj4gK0NP
TkZJR19VU0JfU0VSSUFMPXkNCj4gK0NPTkZJR19OT1BfVVNCX1hDRUlWPXkNCj4gK0NPTkZJR19N
TUM9eQ0KPiArQ09ORklHX01NQ19TREhDST15DQo+ICtDT05GSUdfTU1DX1NESENJX1BMVEZNPXkN
Cj4gK0NPTkZJR19NTUNfU0RIQ0lfQ0FERU5DRT15DQo+ICtDT05GSUdfTU1DX1NQST15DQo+ICtD
T05GSUdfUlRDX0NMQVNTPXkNCj4gK0NPTkZJR19SVENfRFJWX1BPTEFSRklSRV9TT0M9eQ0KPiAr
Q09ORklHX0RNQURFVklDRVM9eQ0KPiArQ09ORklHX1NGX1BETUE9eQ0KPiArQ09ORklHX1VJTz15
DQo+ICtDT05GSUdfVUlPX1BEUlZfR0VOSVJRPXkNCj4gK0NPTkZJR19VSU9fRE1FTV9HRU5JUlE9
eQ0KPiArQ09ORklHX1VJT19NSUNST0NISVBfQ0FOPXkNCj4gK0NPTkZJR19VSU9fTUlDUk9DSElQ
X1BETUE9eQ0KPiArQ09ORklHX1VJT19NSUNST0NISVBfRE1BPXkNCj4gK0NPTkZJR19NQUlMQk9Y
PXkNCj4gK0NPTkZJR19QT0xBUkZJUkVfU09DX01BSUxCT1g9eQ0KPiArQ09ORklHX1BPTEFSRklS
RV9TT0NfU1lTX0NUUkw9eQ0KPiArQ09ORklHX1BPTEFSRklSRV9TT0NfR0VORVJJQ19TRVJWSUNF
PXkNCj4gK0NPTkZJR19JSU89eQ0KPiArQ09ORklHX0lJT19TV19ERVZJQ0U9eQ0KPiArQ09ORklH
X0lJT19TV19UUklHR0VSPXkNCj4gK0NPTkZJR19QQUMxOTNYPXkNCj4gK0NPTkZJR19QV009eQ0K
PiArQ09ORklHX1BXTV9NSUNST0NISVBfQ09SRT15DQo+ICtDT05GSUdfRVhUNF9GUz15DQo+ICtD
T05GSUdfRVhUNF9GU19QT1NJWF9BQ0w9eQ0KPiArQ09ORklHX0ZBTk9USUZZPXkNCj4gK0NPTkZJ
R19NU0RPU19GUz15DQo+ICtDT05GSUdfVkZBVF9GUz15DQo+ICtDT05GSUdfRkFUX0RFRkFVTFRf
SU9DSEFSU0VUPSJhc2NpaSINCj4gK0NPTkZJR19FWEZBVF9GUz15DQo+ICtDT05GSUdfVE1QRlM9
eQ0KPiArQ09ORklHX1RNUEZTX1BPU0lYX0FDTD15DQo+ICtDT05GSUdfTkZTX0ZTPXkNCj4gK0NP
TkZJR19ORlNfVjQ9eQ0KPiArQ09ORklHX05GU19WNF8xPXkNCj4gK0NPTkZJR19ORlNfVjRfMj15
DQo+ICtDT05GSUdfTkxTX0NPREVQQUdFXzQzNz15DQo+ICtDT05GSUdfTkxTX0NPREVQQUdFXzg1
MD15DQo+ICtDT05GSUdfTkxTX0FTQ0lJPXkNCj4gK0NPTkZJR19OTFNfSVNPODg1OV8xPXkNCj4g
K0NPTkZJR19OTFNfVVRGOD15DQo+ICtDT05GSUdfUFJJTlRLX1RJTUU9eQ0KPiArQ09ORklHX1ND
SEVEX1NUQUNLX0VORF9DSEVDSz15DQo+ICtDT05GSUdfU09GVExPQ0tVUF9ERVRFQ1RPUj15DQo+
ICtDT05GSUdfV1FfV0FUQ0hET0c9eQ0KPiArQ09ORklHX1NDSEVEU1RBVFM9eQ0KPiArQ09ORklH
X0RFQlVHX1NQSU5MT0NLPXkNCj4gK0NPTkZJR19TVEFDS1RSQUNFPXkNCj4gDQoNCg==
