Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0546B446
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 08:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhLGHsu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 02:48:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:14797 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhLGHrI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 02:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638863018; x=1670399018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X9HqK548D94ESs0bIKHKDpsrKCMBLP9oDYHCfMPO9Ic=;
  b=obzdkXJ3mr6Jz2B2eU+IkFAUM6MTOS83SoI85UNVf/yWnBeB4BWiCIj6
   QFtYQ8WxngUv962QEbln3vWQh7+MHfxVrAO1Z1Ek8jqkxBV2pFD3xlZyj
   Q/B5HfXskbM3LChQ9S6uj4BEkD4vkUUFQsj1phnceDI38h8n71RYwJ4cb
   y3+5wTMJokOxLeeCiBet0kBkCNF57/2sN9W04wkhCKHkXrfhP42GibKd7
   CFBU/U5HQ22xhKBocs+fDRfP0F5G6FJjOyKgiGNiVpo7qb9k7S8XqVGAG
   UCQ2/hjISwzfBOC8hRRf2SN9c0hAc6+Rvl8q+nfToOs2medmZsAOOMAeU
   Q==;
IronPort-SDR: oB6x380EZFJJxIoYDuDPoXzpJa8yM91phf6uAw1aAUb0voc6dO/PKvhWktOdvc7YSXogl1gwzQ
 xt2rtppUIsjxYFBpOhijRRw6XDknD37VA3SdDI31TxSl/2Hfhhj7rgBmn9CRROh1DctgraokUv
 /QnMdzet1w/LgkNTLl0oyQ35bK3TTL7xeIvn2shAC3sR8BAXHvY/oH+bjEl19HrzWcCokvnH21
 EfDAIuCvrPFCJsyRe8Ws8bnip/PPuzCmoCFHuRt9SJ9LLX03cMuCcCXBcxFPF7dMXLDPpe/uNa
 9BPrlZ81etFIv+SDGtfIghwz
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="78729180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 00:43:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 00:43:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 00:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC/OUno+j9ZUq7UklBVMBKq1qtmDHx869/hUVOziYv2yu3OFPaHw0aEmPjur8VBV5rMbS9LM5bgGc93fQNynzRsT8JdbAd1sWwXn85Uf4pd6Bt0XvEODx6dKo6jzb5nvJaUnSSy1g5IGNEX7SolfQtANe08fI0eAdlCPkZVuk3csx3KExeOf7K0Vw2KfazUOtfUtY+6MaPU0b85pVG5AczD1kcS2f5B3+Zf3OAr/G94KgVuJiD0f9jVq8it5kCkSppnZJklf3jv6v+QHM3QWY0A1xiwysDgs7Sengzk43C6pnWw8GCaZ7BWIRvKET3/jcZszRprjECu0QnQGTR17Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9HqK548D94ESs0bIKHKDpsrKCMBLP9oDYHCfMPO9Ic=;
 b=mi0W3AO6J+kNKDuL5pmyHL/a6e+3EXkO2GxHHFyVApT2Y7vkFEjjv84EgKjoLbiFglrRoKuk2XuZTWFzrr0TsgJNmfGayxJA2LXY5wJkSDjSZwgGbsFsmpCKIf0i/qdI+Pp8ImmR2/fV3//UwstCGcserOcDU0MhEUajY/G1yR2GFVKbMPqEENhDsHntObX8Bn3jaJyWk1OcjbXyDhZhR7rcCwfEWkmvZ6lPTdQ+Tw/gkv/s5teg2QoAf3wFtFw71acSODbAkw+zhneY15IqhHt4exKDOiHZABg2w6NqTbBCH6tlvYZxdaamJDQqeGHs8eUHCJW8eur8J3wx87Aclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9HqK548D94ESs0bIKHKDpsrKCMBLP9oDYHCfMPO9Ic=;
 b=loxArREJvbnb9UmZCo8wvuSklsSamNH8eusLWXCbIzWVcYTtKaiv+y4YthfukeaDIOLRmWo0NZb2t1CkyDIZNNtNuyM6oamrWA6E3FREvS/xJivqwtWlhhNgck2fcaU89ROg4XbIps3MW59XVONeqN1J3REDFCZ+gVKAiauo08I=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 07:43:26 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:43:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
        <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Topic: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Index: AQHX6z0TCMDia/NjPUS/CLh9E6BmLqwmpcIA
Date:   Tue, 7 Dec 2021 07:43:26 +0000
Message-ID: <11cb8408-1c5b-de83-dec0-5ec67305e772@microchip.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-3-miquel.raynal@bootlin.com>
 <20211207071406.c2ajc3shqybevvjj@ti.com>
 <0d97a420-685e-5120-3c09-d433382c02aa@microchip.com>
In-Reply-To: <0d97a420-685e-5120-3c09-d433382c02aa@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af26f949-13b7-416b-173b-08d9b955413c
x-ms-traffictypediagnostic: SA0PR11MB4704:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4704F311804B0C01DB943174F06E9@SA0PR11MB4704.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3k0KFvJcz8Lv0wFMRpw5ka1Ss4QrBHMMksKL01/Azan0vaXpuSXYYGTxGazmIJ3gw94guQr29PTuXCt0oQgz69UcCOy5mt5BOdy5ozzSwrXWHhbLydIY/euS1pCQNtTPAdOKw+ossN/nJujE96FT+gEiHap4qGM6WGHltSqqbAXR8BmjdqN+KVw4LBIBhZElhk1AB6oNnfWJvn5eYRI2FJlkVaffdZnep5acq+OKzh95124Nd4l39S+2Y4uIySGT64+5Ktb5V2hu+yrZ083+AyrvDcP6K1WS+S23d5r+12WPeScao35uYdCq7rdRv1VGGD9SoB5Bewuk+fLkLo/UCewcx4/jHMC8AcLAvqkLxKEyPdaMeN3arYF48BRpo0xNQcDx+UxfQvbp6J/b9vFowBpL44kOrVj05jBzSccjlJ9oD9P+bYI4dYNgXAIhK/yOD6vU+sgw9JsSWP3sYd1opIr4gi924G18NvqHkA7u/tOs689fDDIIp/e9Pj45X3z0l36lPK8HEk+ow7FIXAYWI664BKXj+OoeMNHbCFokWGmC5rSjdztaS6H9Y7ufh/tRQc0YHIzHKG6zJ289JwpIaJfIHUYnLY+7Yo58iPCj7EIFwiIVDhu4TmDGrNWTDlAZ9kCn6Q8dUBfJZnFbtQMXPLtlVwCXI2xDqaVIBJEEo0jUjIyWu6/wLmGg7/7DvJ/hk9twqeZ76xdjcNkt+9zS5CMm0rZzYL6z5nEu37wxSFyyF/X7ZILj8I8Pa6su+GnzwkCWqcYN0hjajtL2NrNBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66446008)(64756008)(316002)(38070700005)(6512007)(53546011)(86362001)(8936002)(91956017)(2906002)(36756003)(4326008)(8676002)(66556008)(7416002)(76116006)(122000001)(6486002)(66946007)(110136005)(186003)(66476007)(2616005)(71200400001)(26005)(31686004)(5660300002)(54906003)(508600001)(83380400001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGtyd3VnbEJobytOcUwzOU5EZVNhY1IxcWFKSldEN2czcjNoT2RBcDI3R2pk?=
 =?utf-8?B?Qlk2cksyMWJCeklHWGRHN1JqWGVGYm03ZUdtYlpFQ3IvQk5KaHpjNlZpUFZV?=
 =?utf-8?B?K09ERW1wRDMvNUlCQk8xNDVRa2kvbzBQZ2dpcFQxbWJxL0FxLzMzeG95cmF4?=
 =?utf-8?B?UG9XUlpsdjJtWW5NYzFNV2pYTUpzVEhGWjBGSERCdHdGYk5mckZUTkRmZWlw?=
 =?utf-8?B?L0Z0WDdadFdnMy9vN2Frc0RxLzVTNWxSMlF5eVk5K284ZlNlTTk2R1JSWitC?=
 =?utf-8?B?Q0xwRHpSbEtEdWFjZ1VRU0RYUDlLL2ROUnVUdENnbWh1Y1ZqYVB6eURQczU5?=
 =?utf-8?B?UUFVeEMrQ2dsc3RlckdPaTBERm5CL0RMVHFpZWFKN0NHYTFNK1ZLQUxpY1Ax?=
 =?utf-8?B?VHBkZlV5OXdZSHVRaVNUSSthN1V0UXNxblBUanJGMnJsbjBjYVZoQ0dkUFYz?=
 =?utf-8?B?NHJKTlFZOE5FQlJnUU5UY3VqZjRhVXlHWFo4VjJUaHNENW90TStIWDU0Y21G?=
 =?utf-8?B?M1daT0plRW1VVndPL3VWYk42QVVxSkRtS3JCeHEyS29ITU9pWlhHVjA2a2xn?=
 =?utf-8?B?NGdqTkkyeGlSYWJVYTFCMXhEWE81aUh1K3VpMXJIK1JNRlZ1aWxITXpJRmda?=
 =?utf-8?B?UXNjVnpSd2hIMm1pRU1zKzRKNGRWc05CMGgyQ2prQzZFeCtFVUI5UlRrSjlO?=
 =?utf-8?B?bUhyQVBzbmhsMjB0cmFvdWZEK2oydnpWREdRblVCei9CWEo5QXl0N0lycWVX?=
 =?utf-8?B?NkhBMXNJY3grTXlodlN4TTUva2tlZVBneFpGL1RpL1NtMXRMV2cwQVlQMjVh?=
 =?utf-8?B?RGVsS2NEZ3FGOVByVHAwR3dWVXM1KzhiaUhlekRyZ01TV1daUlV3TmUvVHdL?=
 =?utf-8?B?bURkeTBsWms3NVptbVowRndRcnd1eStRZG52MEU4QW5OYXQxWWROME1XZ0JU?=
 =?utf-8?B?dVk1ejAxbTdWQWsxTkh2TVkzRC9QMk1iOFRJVzREOWJJVlJHaWhlcEhnVXFn?=
 =?utf-8?B?K21rU1VCTTJUcEVPUVJ2bE9OVTQ5dlN0VXVzSld2WnM0NW42Nmd0MXJaRUNW?=
 =?utf-8?B?MjZudUtXSUpISE1jenExTFRwU29kL3Nod01uZDZhbkFaUnJVQjhrR3dLemhW?=
 =?utf-8?B?TE10SXY2TE1SZ2cwZ0NKd1JhbGJhSUQ5Q1l1elNIS1NHV3NOSEZhenVZQ0FC?=
 =?utf-8?B?eHdHRVpxaGc3TXhiMGVCZCtSdTFPNTZuMnhrK1F6b1NJam5RRmpwWUh1c01Z?=
 =?utf-8?B?UXZwbkFQVUJVVUpELzdRNzAvc09Oc0hsYTZjeXAzeU1jcE5lbGcvSDAvS1cy?=
 =?utf-8?B?YWJxZ2V0bXZyUXlYeXRYOU5ZRWtONHVpNWJnV05IK25FR2Y2cTZPK3o3Mm83?=
 =?utf-8?B?WFl2WnB6SVROV3RqbXFLaFJHRnFva0lNU2tNRHFkcVlFaXhOaFJZWTN0QzBh?=
 =?utf-8?B?alBGY1lsdm9wVlNySklBMlFoN1hZbkFiUlNES0RIbzB1ZW9GRlliSFhBOEFN?=
 =?utf-8?B?YTZJdkFpelVKNGJYU3N6Q1FGdHduKy9QTk8xWVN6TnZKK2taSlFLZWhjTVpP?=
 =?utf-8?B?eVVXRUY1TXlHMG5kdk85L3dIdlFrUGpqRzZEaHJiekxrdURFcXZBZXp4Q1k0?=
 =?utf-8?B?aTdpV1NrZ2FEOW9hb2lmN2dNeHdGSTNPVmZoNE1WZWk5RStEZWhGeG1MblFZ?=
 =?utf-8?B?MUh3a3Uzd3RXOFh2OTFiOHpLOXhsbEVOVVdxNGpaa05WV29sVHlvQk0zTFVt?=
 =?utf-8?B?WS90VnVMN1JZL0NWQUFwTUFVdVZEUUNDYkdDdTBIdlBaa0l2cU13T00zYnRU?=
 =?utf-8?B?SVl0bVJGKzRUb1p4NE8wNEptQXBWaE41S09oWkJ0QXcreXFPODQrREQvQ3pD?=
 =?utf-8?B?S0ZMTFVKM0k4QWVNN0xHV1JuSkt5WE45Z1lCVTlDdkVxK2gzYUVQamt4TkRD?=
 =?utf-8?B?bDhMM0paQ0lqVjh2REs0Sy9lYzM4NVNKTmd2SWx5ZVVxYm43WjNwYTBUSk5T?=
 =?utf-8?B?V2k1WXRBL3QrMTQ5S3BMUk5KQ2JNcUNCZnFoTElWZzFFOXJ1NlRTNmFMRGwz?=
 =?utf-8?B?WklPWStmUEROTlExTmtLYXl5OE51RmJTejh4UDIwVlNhcHRxc1VRZjlMU0pU?=
 =?utf-8?B?VUN3Z2M0citDd2FuY1djNVZEN3NXY1l3clphWEQ3U2R2QzNlQW11OFFTbnRL?=
 =?utf-8?B?em9UMmNmZEFUeFRvNzNGSFhaQ0JFODJoT3JrL2kzUlBUeGQ4aGlNcnVDSVkv?=
 =?utf-8?B?MlZaWGcvaS8yem5yNTNRcjF1TkVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DF3A8D32DF0B34DA4272540F3E0AD89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af26f949-13b7-416b-173b-08d9b955413c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:43:26.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6eNPjT+8Tp2W/ql0D1lfYPGdA1BixORA41viB8mGjZcT25Eg5JJI7tAbEwmS7AkWBkhCYkIj8sQf0AUXQnj7s7xZb3zM8kTs0PJF22aB20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvNy8yMSA5OjM1IEFNLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBPbiAxMi83LzIxIDk6
MTQgQU0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pg0KPj4gT24gMDYvMTIvMjEgMTA6NTlBTSwgTWlxdWVsIFJheW5hbCB3cm90
ZToNCj4+PiBEZXNjcmliZSB0d28gbmV3IG1lbW9yaWVzIG1vZGVzOg0KPj4+IC0gQSBzdGFja2Vk
IG1vZGUgd2hlbiB0aGUgYnVzIGlzIGNvbW1vbiBidXQgdGhlIGFkZHJlc3Mgc3BhY2UgZXh0ZW5k
ZWQNCj4+PiAgIHdpdGggYW4gYWRkaXRpbmFscyB3aXJlcy4NCj4+PiAtIEEgcGFyYWxsZWwgbW9k
ZSB3aXRoIHBhcmFsbGVsIGJ1c3NlcyBhY2Nlc3NpbmcgcGFyYWxsZWwgZmxhc2hlcyB3aGVyZQ0K
Pj4+ICAgdGhlIGRhdGEgaXMgc3ByZWFkLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4+PiAtLS0NCj4+PiAgLi4uL2Jp
bmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sICAgIHwgMjEgKysrKysrKysrKysr
KysrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBl
cmlwaGVyYWwtcHJvcHMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+IGluZGV4IDVkZDIwOTIwNmU4OC4uMTNh
YTZhMjM3NGM5IDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+
IEBAIC04Miw2ICs4MiwyNyBAQCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAgZGVzY3JpcHRpb246DQo+
Pj4gICAgICAgIERlbGF5LCBpbiBtaWNyb3NlY29uZHMsIGFmdGVyIGEgd3JpdGUgdHJhbnNmZXIu
DQo+Pj4NCj4+PiArICBzdGFja2VkLW1lbW9yaWVzOg0KPj4+ICsgICAgdHlwZTogYm9vbGVhbg0K
Pj4NCj4+IEkgZG9uJ3QgdGhpbmsgYSBib29sZWFuIGlzIGVub3VnaCB0byBjb21wbGV0ZWx5IGRl
c2NyaWJlIHRoZSBtZW1vcnkuDQo+PiBTdXJlLCB5b3Ugc2F5IHRoZSBtZW1vcmllcyBhcmUgc3Rh
Y2tlZCwgYnV0IHdoZXJlIGRvIHlvdSBzcGVjaWZ5IHdoZW4gdG8NCj4+IHN3aXRjaCB0aGUgQ1M/
IFRoZXkgY291bGQgYmUgdHdvIDUxMiBNaUIgbWVtb3JpZXMsIHR3byAxIEdpQiBtZW1vcmllcywN
Cj4+IG9yIG9uZSA1MTIgTWlCIGFuZCBvbmUgMjU2IE1pQi4NCj4gDQo+IElmIHRoZSBtdWx0aS1k
aWUgZmxhc2ggY29udGFpbnMgaWRlbnRpY2FsIGRpZXMgdGhlbiB0aGUgZGllIGJvdW5kYXJ5IGNh
biBiZQ0KPiBkZXRlcm1pbmVkIHdpdGggZmxhc2hfc2l6ZSAvIG51bWJlcl9vZl9jcy4gQXJlIHRo
ZXJlIGFueSBtdWx0aSBkaWUgZmxhc2hlcw0KDQpidXQgdGhlIHByb2JsZW0gaXMgdGhlcmUsIHll
cywgdGhlcmUgaXMgc3RpbGwgdGhlIGNhc2Ugd2hlcmUgdGhlcmUgYXJlIHN0YWNrZWQNCmRldmlj
ZXMgd2l0aCBhIHNpbmdsZSBjcy4gV2UnbGwgbmVlZCB0byBkZXNjcmliZSB0aGUgc2l6ZSBvZiB0
aGUgZGllIGluIHNvbWUNCndheS4NCg==
