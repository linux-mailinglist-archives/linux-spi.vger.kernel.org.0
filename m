Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26655353B62
	for <lists+linux-spi@lfdr.de>; Mon,  5 Apr 2021 06:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhDEElz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Apr 2021 00:41:55 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:44280 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhDEEly (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Apr 2021 00:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617597709; x=1649133709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WnXtELp3D7a6PQDpl1K2Creclu/+jz/xdyRrxXRo1AU=;
  b=I9D9kzP7/0xO2d4RG4Nm27C9okzio1g+7IIDAubemW3vMASyTMPyNcGE
   SBymSwURZ+gWKTGlCYvCj3WX/hoGA1sDyDd/N/19fY7eAyQj7Ls30J4sH
   ggDJsUookbb082jkdnOG/KstPlCc/K94K+I2CQ/hTr72uvlRcSUvJ1SRJ
   zmZxf/nVEkYSCn3GvEyopYZwX1s5bW8lfCVxMy5lkHX5EztNoXhHsQt6X
   J5mFH3BLDmpYZuwjlm1X2oi7Gv3InT2ey+YQxw9vm/zltJlhm24tPNiIS
   ty9CbBUJDpqCYCvEy2K5Zhq8lL67v0gQr27tEXXqBrOLLDa09dGsKqKCT
   Q==;
IronPort-SDR: Idu0odK4ONUGgf2oJoaY+BPL4aC6fsMD9XFjXARPPUiqJsMYDhTHpKNtUfzMAKSXLtHITFC+Hi
 w9PWpYHc3ZHdBnXycXYLAQoZowOZUxlXB+OGxnhqSAumSCJRpqv6kUO70CcLOPGwss8AF3Rd5H
 pFPEyaSHM57h7Tcsvq5cxuMQyPvsPs30Gki/6+zeqy/T2p9j3ggxQ4oNoUX/t7v6hCLLmJMetm
 ym6dWAw6x/pAg8TdhSvGojeL7RmRoQLGk+CDbixpXrYqxr0lqo9zhutTY6WQQfAlBX7nBB6V7P
 Whk=
X-IronPort-AV: E=Sophos;i="5.81,305,1610434800"; 
   d="scan'208";a="115809604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2021 21:41:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 21:41:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Sun, 4 Apr 2021 21:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFaZ4E+uiHMyMeVB6n4gvaMMrp/6/XWgECUuoJ1+TWxH50Dgnq9N9IHKepOs2NYbbnSvjF4O7qu4F6u+aS9D0hxjq8bwZvYrgz3dtz4Ff+R7JcvAq7/PE60haUbvFj5akMKpvZQsWDDSi4pbTDMgBkAvLYC3mhScQGZ7lFedt1sgEe5VvJ9VdhPWS8s38KyzGs4jmmvbI55bk+SmFPqUKavy9Ezyb3NP3C7YiYqmoDyrQkDHexrIpH1I8CV4p2lIWRLDcdkvBCRAWe/v3YvlldtkG7yyU1GaStAko4SqwyKnaIkdY1V2ZK+VbFGHPfvUWRU6YUO44oJyuyILHAWxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnXtELp3D7a6PQDpl1K2Creclu/+jz/xdyRrxXRo1AU=;
 b=mYzrD+56ZIScGiCtWgrTSCZ3Y3/RaFNkEx2f8jVPbIy0LXBaQQxOy/aSlaY4nomhnt5yZR38fYgCt/mJgtN2zJIildh5IT9VJk/21U2b5XLF5j8Os5OUeV6x9xlGtueCDyV19ER9zO+kRF31u4P1Q77uU74JCP3QvZ9PWI7jyRtWPck3Ep9/vVAyGEyDFbyZBJktQoeyKLG3+wBIIWsYgLwDqgcqVvEdAw685IfiA4JMANuge3d4RcJUYoxuppRhjS7lG0ScqbZbKvpJxlzqY+0UKMjJez11T41nSf+12mgRvvefNdqfhFxAYG3kHCJx5cL9QmQ8LhDtwYAe+5e6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnXtELp3D7a6PQDpl1K2Creclu/+jz/xdyRrxXRo1AU=;
 b=rtVtThMzwvmAWrfP0VnLqx+34EMsveeJynbzla9b2UQp5bTAiOkInUt5yqe9wK6Y2o5oXoT/Cm9LjGBmZN1/0wKCaZbkMFMKy8yAf1lbpB5wlaCoVfP4jlVNSRhHB3QUMUPVHqSxuViybvTBW6xz+cUezBSxrWsJixzDTWw/5Z4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 04:41:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9%4]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 04:41:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <zhengxunli@mxic.com.tw>
CC:     <geert@linux-m68k.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <p.yadav@ti.com>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <juliensu@mxic.com.tw>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Thread-Index: AQHXKdX6WnvagKwi3Uiv46ipns2iGw==
Date:   Mon, 5 Apr 2021 04:41:44 +0000
Message-ID: <4e8cf363-827d-8a29-29a4-af85e7ca0fd9@microchip.com>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210205104736.2771074c@xps13> <20210205133404.esqqeokhlp4askpq@ti.com>
 <20210223141344.7ad25831@xps13> <20210223133649.GD5116@sirena.org.uk>
 <20210223152504.jtq4uxfepz7bdxhl@ti.com>
 <CAMuHMdVQUCaiBwdU=KdFOu=D71kYbGqoqp9V3pLsXXE0AAdCog@mail.gmail.com>
 <20210223181424.GJ5116@sirena.org.uk>
 <OF5890F10B.27BC3B4B-ON482586A7.001FE05B-482586A7.0024305D@mxic.com.tw>
In-Reply-To: <OF5890F10B.27BC3B4B-ON482586A7.001FE05B-482586A7.0024305D@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b01590a4-26a7-4539-fdfe-08d8f7ed1d85
x-ms-traffictypediagnostic: SN6PR11MB3197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31972E5E6C6F312397284DF3F0779@SN6PR11MB3197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjM94sMBQff/b739VSU7N0VnZhuBwm6jqcGudJUoAkPL44AkjuV/XU0HCqeAXt/IMPgVbbH0lM/AdE/rMj+oeN4Aa4rggTH6TerSX5oiBv0aDZ7JQ+/WTuR6le8TJr/XGN9N5NLxZy2LFbPfz700BIJOGNccFn7Yli1FDv1PWkfubAis7VeDVsdsPDTkkU0uy81OLm3I1kRKy+Nm0XlLcDzqWIWe6aJGYKJKXbZAWK6/1k3gOn5VNNUt0LepaelmX9a/hFPjLVjLDXDAeUDaunEr9lUJGnecFCASfE5RHc110B2TyymLuf5F+1kXwI7jB2AO9LF3oU0RUCx9OulzjoICYQ2uzrJIVm+0bVp3ekWSDtN+M5+eE3AXO/TCb9R2TJ788SPw+cpThrQ3yY0wvHIfa6nlm+gKoISCg5Ul9shx9OCxwUcqx5Va5I1hW88uTfLMaXhP8UpgSWkYvNoJdoVcpl6KmemyCdOHzVOCWSlFFfq3wPIce+yluhqQLf22EIBRQsVAUO3QHp0NzM3OvBQPu8ufbVwSzI/AO+1AHD1j/J95LVOHY0sHJ7nfx/f2i5vl/WTZPvEZyrGBEkaUa5R0SfAOlucJrEHoNacNs0zfvdNRBo8M86XZ8KRma8dh6hdzgx2tQNcrk2npIDxaGe2VipSUdMEJDsheQ45Q+nnP/6fKy4Zkl9hOVdPCFLqyvMhosv2Ic3ictvRgXgAALF5D7FFTod3GUUb7HWZ8EAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(376002)(136003)(346002)(4326008)(8936002)(5660300002)(6916009)(2616005)(6512007)(38100700001)(316002)(91956017)(66556008)(478600001)(31686004)(66476007)(54906003)(76116006)(6486002)(86362001)(31696002)(66446008)(26005)(53546011)(6506007)(36756003)(558084003)(84040400003)(186003)(71200400001)(2906002)(8676002)(64756008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SjBacmhMUjFnRUdEWE5vcEp4SzNZRlVkdzQrdjN0R3YyWVZmVm1Zd2xBT25B?=
 =?utf-8?B?TSsxWWtuMGdrcVcveEhrM2M3MkFCSlFsMlh6Y1dpaTcwbytHTUZvOURZQ2NH?=
 =?utf-8?B?UnlDRlZzSnFDM01rNllveTBFck9EdVlCUDgrMGwxNXZDUjlXREJneUNLSEQv?=
 =?utf-8?B?U1BhbGEreVdnUFd6bUNlekdOeldSL0lPRTQwN2dXUnYvUWFnSk9NV0hpTHFh?=
 =?utf-8?B?b0xXSk5DZHhlUkI4U2pKTEZlVnhsMkhoK0VmN1Y1MnFPZk5yZU9IbklSU2kx?=
 =?utf-8?B?RjltUk92SkRIMUdQOWZ3dyt2aUNpQTlRdUZ0d2tvdVZ2SG56RlJaZW9naWxu?=
 =?utf-8?B?WDdaU2xUbFlybGVkUStoSlhCcU5jeWVLYVhuTnh5NlJNNVFjYW5lcVlXYTFI?=
 =?utf-8?B?SVJCZzE4SWxCcHpnTHd3VUtLdkdoV3BxSjgyMy80a0hCb1pUcCtOaVY1NWV0?=
 =?utf-8?B?NlFrK3BVR2VGNy8xcFgrTG1xbUs3ODhvaEVrbGFwdXVXRFFGVHN2eEt3eXFD?=
 =?utf-8?B?UGpIVWlPUWNWZ0dieC9KTGdDWlZwWlFWUmRpVkx0Uk9sbXJJcE9zOXFHbENl?=
 =?utf-8?B?ZGxIeEVhTVpZeFFWdC9NOEtCU010REw2b1BJRkRTbG9Ra1l3ZzAxU2tWSXVp?=
 =?utf-8?B?N2k5U3ZBQnYzSnB0WU5rdTVUbGhtRXN6SG45MHNwcFROR2UrZnhoQm9jc3VX?=
 =?utf-8?B?akRoVUhobTMwdHRZcHAxU0ZWY25jRVN0ekM4czdtcjFwWll0RnFsU3ROOWIw?=
 =?utf-8?B?NklrQk14MEVXMDZqYUpMOG9HdUVBeUZtTDhEazN2eC90S2thUG16WUlLK3lX?=
 =?utf-8?B?MFhsZ2JwOGlSVkZXd0l0bmpHbE1UVk95Y1NHVEhacWtrNm9XSXhYVTV3dmxM?=
 =?utf-8?B?bjRPT0xzckdwbVFrT3IyYXR6QWRqWnZQcTZhT3E4VXBJK1Y1U0xRM3E1MUdx?=
 =?utf-8?B?OEhjcjVxR3NUbHVBdzNxQ2pyM1Irc29SajJHd1FNZlhCNTZlL1B3TkVYR2l2?=
 =?utf-8?B?NHVuWWF0WEthbll1aGp6akpKSkdoWHZ2Uk5pZXA5T3JCRzlJem00UE9acTRV?=
 =?utf-8?B?S0VwVUZpK096eHY2NDUxa0JHZ1ZmR3ZGQXFtVXljREdCMWhsTHdYblZGa2JS?=
 =?utf-8?B?YlNNd2RDcmxaQWhRYW9EN1lKOTExUTBHZFpKdzRDTkRmaTZsL2JvVENSV2tM?=
 =?utf-8?B?eUdxTFhaNXhIRnM3akp5c0dzSEJoMndjNE1qOXFMbXRXT3MvbFVTQThBbUFM?=
 =?utf-8?B?SEtjR3FHSjVlS3hyTXpIOXR2NUx0YnVHV2VDdE1xMTlyNzgvQlJONCs0cVNQ?=
 =?utf-8?B?TzRZWXk0V3NoaDhkT1lLY2tsRG5yeEFqTTZkQk1kSXEwYnd1REdlVW1naXUx?=
 =?utf-8?B?R016V2phMGtPUHBHem1WenkrcitHdkxHd01KclNyOVcvVENhT25JRnBPOEpG?=
 =?utf-8?B?b2l0UWh5U3FyY3doSmtWYlhsaHdoSGp2MzJmRUVzVklSZnVqakpmeFZ0YlR2?=
 =?utf-8?B?bGYrVmcrbWZMenlvaHF6L1pUTEZoWEs4OUh2aGl4V2RVd0M3bEFVd3ZmNEVM?=
 =?utf-8?B?U0VoQmdpTGJEb2xjVjZ6eHh3T3NzQWpMdVd2V2lXbGhFWGNCNDZYcDlxdFVy?=
 =?utf-8?B?cVdBUFVPVm5xeE96eG9Nazd4T3hhSWJEbDFrQ0xBVTBHK3A2L0tEZjFacEVW?=
 =?utf-8?B?Uy8zak1Wdm4vd0UzbEt6bUJqdVlWZUk3Wml6YSt1QTRDamJpOW4rd08rZkM4?=
 =?utf-8?Q?zIuRLM/444/6vhbcsk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6F9EBFF306D141AFB89EF86B4D6D00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01590a4-26a7-4539-fdfe-08d8f7ed1d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 04:41:44.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcaglJpgTD3mr/gy/J4E8MAwJMkEGDswaJqc0RsUV6BJ1QH5Tz/loPXbo6b7dt0d2lBmbz83DqnE0DiLMiG8g9EM/8d43NBr5UspVxP8uhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMy8yOS8yMSA5OjM1IEFNLCB6aGVuZ3h1bmxpQG14aWMuY29tLnR3IHdyb3RlOg0KPiBIaSBU
dWRvciwNCg0KSGksDQoNCj4gDQo+IFdlIGFyZSBkaXNjdXNzaW5nIGZsYXNoIGR1bW15IGN5Y2xl
IGFuZCBTUEkgc3BlZWQgc2V0dGluZ3MsIGJ1dCB0aGVyZQ0KPiBhcmUgbm8gbmV3IGNvbW1lbnRz
LiBDYW4geW91IGhlbHAgY29tbWVudCBvbiB0aGlzIHNlcmllcyBhbmQgcHJvdmlkZQ0KPiBzb21l
IHN1Z2dlc3Rpb25zPw0KDQpTdXJlLCBJJ2xsIHByb2JhYmx5IGJlIGFibGUgdG8gbG9vayBhdCB0
aGlzIG5leHQgd2Vlay4NCg0KQ2hlZXJzLA0KdGENCg==
