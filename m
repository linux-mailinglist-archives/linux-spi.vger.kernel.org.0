Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99F23B6E50
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhF2Gjc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 02:39:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12148 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2Gjc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 02:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624948625; x=1656484625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Mnzj29eIRM16sACWvzisWfjedpCx9taKr18TxytdJY=;
  b=RYcUcW2S4/ivP4+rPwF5eR43qJivPc1DTMa5TNievJZkoT8B5TijjCR/
   eo0ABS9w4mQffjyPflWxoZYstr1xnN5E1Ruravwdv7J6OsOb/k1+HWQl1
   uGDJ+rDKA0mNT98gABfrxMjkBW/JbQ9+8khI1NiTrfXQn4Jh+U9SpwVIG
   t/Y9lkhXtgLweMw1u+2KWNk7PGXP7steUBfvBeOcxjW1bh9YmzCR1lID9
   MtQfu2cTONNinMryVX0auruien/rtmKpnlG3hiN0wlRYgkCzzZ1auEjtY
   zR89U9AIpMVpVcG39xm/KVxrMx0b0w5HQaqEsfA250bldHmn4+y1pmdKY
   w==;
IronPort-SDR: 1pEubXjgxomXB4Eq6pVPuj69JOq5VbHHMkFmDZTznjua1BsqcRMtlvO5ZkAe8THr53+oYegDLt
 pa4R9AmZO3e0iATyqe087hjpArnT9bfQ9i7jW7L86lOYqD/nLy2ZgPDd/H04AxU7e1Hda+bt2K
 gqJlQC7Wjxx6g7lQUeYwqFUKzqutQZQ3qpJ5bwQYn31m3JylY4+E95W6Lw2rZuPnSzANKey4lU
 O/nIYejiM5Vr8U0loweltxWegTehe4aAzgdkAE/nsz5pHjMSkPRSeWG6OtdeWEuhZtUwaUSKFr
 4W4=
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="126998658"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2021 23:37:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 23:37:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 28 Jun 2021 23:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Gy13F5pIcK3PS8rGcPZQWoigydU/kWLdEiDzKuXM0nwpQ7Eov5niFYJVWq+5hCFkoRVYbTBZc5iyX4BVsTULP5HOVFEbeLcHOHBLKxTXwvvKxV+bm28FrgGFZidQddSosbiijHyXnnPjo966suA1JERKvrwUIIi8IlSU596qB/xHBatv6+UvmD62Gfwv5fTn7a7Q1XuFuFZ0pG0E4QEDQV3+MMljP00R4WgCnY21D/GSldXuh+y+Rw3i6HsUUxFodyvDOQLeVUGVvgyLXHNx7mzy/LrGYfH3UDlQJyF0bVrQenkeD9DaNcKo6inSh0cpYa3D1seXoBxDmk6MR4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mnzj29eIRM16sACWvzisWfjedpCx9taKr18TxytdJY=;
 b=M9tdwiasC0VTbCSaRNygIxNAa4ab/vIDkP8jWiRrkO/hiFk5GFiQ4i31aTrCklC9mYOAYwXqgprmdvMuVoDW5XIWIW0vPA3+l7XYGpVFCKg5zePftk9e8SPVVWSKJQXQMrLwPKIyd6y/xeRTG+sLA/A8jHalm7gKRik53PFDPy9mDq0xEXkLNc76BboR5Peaffr8W907LyYtFjqASsnypW6o+gNB81tDBlhLFFOGDrOwveMhZqqQkS2ammeC/7U9nlxq0YKeN8Q8qk3g9uyfYBPa7BTv9Z2Mzk4zUkgEnEtda+dZAOOFo0rNXqwjT69e04/nzewqpbm0meY5qhX3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mnzj29eIRM16sACWvzisWfjedpCx9taKr18TxytdJY=;
 b=jkRO2f8yGx5Y1qAgYfUsXLnTRRq6NvzzIqXu349z+Db4Mh1mt84NNoBY0Aqugn0pS2QAAqf8J15TxW6l2wT1oGy5RIAzLybMvkFYjqS3fhcYOuorgS4wUYW3aiYISNiSNPthWH5EPH6U5eatpGYRxi/tBcg7ee7BJ3QdlBl+U9Q=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB4919.namprd11.prod.outlook.com (2603:10b6:510:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 06:37:01 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:37:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <zhengxunli@mxic.com.tw>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Thread-Topic: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Thread-Index: AQHXbLEq6Sj/2A0DlUip4R14yxJLfA==
Date:   Tue, 29 Jun 2021 06:37:01 +0000
Message-ID: <59855ba0-31d8-25b4-3000-ca493a83fe00@microchip.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw>
 <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw>
In-Reply-To: <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fe1bd49-d22c-4c25-28df-08d93ac84d6c
x-ms-traffictypediagnostic: PH0PR11MB4919:
x-microsoft-antispam-prvs: <PH0PR11MB4919DF3C8B86497921E096D2F0029@PH0PR11MB4919.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/r/LmqIMXM9mrRDE7YZhUxVI0HXfJqaPAhENsQtx62d/HH/Xi0SGY5q0I4dT0kETMPqJvDYMM7aGUciVik3ZDcfOqE5+VzczI9MsKucuzMjofQx65VoszHUWRw87pUzhinXSB79Gip+cg1FzRgUkWeNTURTawTIb99i8TtlSfvBvin7BCcylFn3Mz5Zm9j4rR4aenyhYFITQR7pbkc32xepFcuKEc5NMRigQW4WK5YYWcPu5mCXOT1GTPA7MJqGlcGDL38rvT0lHAY53QdY05iI3IdpdFNk7GMmVsJDBAMXzVXcKRNm9iSE+iLAtQLlYeJworufJ6BPuz0T6wyBHV9O3IcQfN9taLeRFlqFpgQNacSIeMp9JhxBhxIfd8lcQV40lyoz4Qspc9/DFDjGZimcfo9v7VWNy63RGLjeKN0zlEiCUU97MVYDHobM4Ih9MDuAWDsU4VX7lRZZ61p1WLUp9Ze6k4icgOUeRVaHzJvI1JGAaPLZhdLnZKPKPghuOOPHYyQ9xHU5ZcUW3di36zCUqwBEcwySP8auEGumeIaTRLiYSngo60ei5GZLnEOdZk3qcsYLiyOqZUe7paDo5w0UIR3/MxfWP+YzHudO9nKkH9F1a3N9YjyS5kqfWvxVgTO3emGrgnh2tOlPESIz5R7Pn5KEcN/7i784vfHwbYTd0PEeVCsJitltkOTEM3e/HZd6gQ75aGRtoBnAms87X1jolp7bItW+P769MVn6Lk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(136003)(376002)(396003)(38100700002)(122000001)(4326008)(31686004)(53546011)(26005)(6506007)(71200400001)(8936002)(6486002)(8676002)(2616005)(186003)(2906002)(91956017)(76116006)(5660300002)(4744005)(36756003)(478600001)(6512007)(86362001)(110136005)(54906003)(316002)(31696002)(66556008)(64756008)(66446008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlloTm5mVGtvZjZHT3VlWVNsL3hIdnhFcGxKNWdUQ1Bma1puRjd1RHRORU9Q?=
 =?utf-8?B?d3VoazFvYnlHVXZyRTJ1d2oxL0pOc0FHdnAwS0J2UUNHaDl2NTVPUGovU1lN?=
 =?utf-8?B?Kys1MVcvN3IzZEx0Vjh3NnROYXJ4RUZPVGJHY29RWUIxVGMzdGJ5c3hNdWpn?=
 =?utf-8?B?Y2dWMWZNdmtkTENRQ1ZXcDRuTEgxNnRseXdNUHROdThoYjFvaTg2L29DbXI5?=
 =?utf-8?B?OTJOYnJaNlNWSUI0cTBIblU5eDFvQnFrbVlOQzFkT0JjQlpVS3dCNFd4REFw?=
 =?utf-8?B?Qk1DTkJkSEROYndsOVp4SXhTYnhEZnV1UTRzcDhwdzhOMVZWMHY5MCtJTE9h?=
 =?utf-8?B?MC9iWGpJWU0zc0tucVJSdlgxNWtsT3BKUG9OTWx1eExLMG5VSFhPQXl3WUJR?=
 =?utf-8?B?UzVDN0xINkJ2UXpyaXluVkIvZkdDTzRlcndHeGJUdDl6OEZtRHJRNHE5WVk0?=
 =?utf-8?B?UG9OaXdVbEZlK2p2Q1hZeGpkc3hTRS8xV083MldHUjhsV1luSVZwSS9lTFpL?=
 =?utf-8?B?bUNKZGZKbWtYSFFBWFl6eS9xT2UyNGwwNkpaWklmUzAydllLc3h0bTlYN2JN?=
 =?utf-8?B?U0gxUGZpNC9XOHVhWklWQUlHN2wzNTQyZS9VL0dDNk95emJxeDA4RXgyMjRr?=
 =?utf-8?B?QXJJR0tISzJ2RkJxM0lkd3kwYlRDVXFSUm4yRUpsbjhqclgrTi94VjFnbER6?=
 =?utf-8?B?ZzcrSFh4bkxrTE14MWcrZWlzOCtsMHhIbURrWGNtN0JOYkh5WDh4QWZ6SzM0?=
 =?utf-8?B?ZmVwTkgvejAwOExBMXZwT2NsRHdFU1dtZ05OTEp2T1g5eUlWMHRma3BHSnZ1?=
 =?utf-8?B?bkNPby9JdTBoWXYzaTdhckxtNjZML2JBbmxFRnhLaWtQL1BLbGNUcTdiNXM0?=
 =?utf-8?B?WThOTENNS01zWFYrUmJ4dWdSWjBNd3hiT2lmWHYwd0paWUtYQ2w5SXhYNEJW?=
 =?utf-8?B?RThUS0NCZ250VHZlMWZ0ZW02QjVCSzBISGtTUlBwTVVlbWI2YS91d0ZQWEFv?=
 =?utf-8?B?V0dHRHB5Z01ucUwyRmswVU8wU0tVVDRlTGRlaDNMMmZONW9tTGVrdWkrNzVp?=
 =?utf-8?B?dUp5WStwcExQM0t3VDRsVGluOXROMTBQcFlUVWoxTzJaRHgzZUFFdWQ3RnhF?=
 =?utf-8?B?bXRyOVRYMUhKNTVHMUlCdTE0UUdXb2ZHcFlMcUhuamluZjBtYWRVWWNhVnRi?=
 =?utf-8?B?T0w1Sk00SXBMTlBMVWdURDd2SVhjekRmRlM5TGxDcFZxVW16eGZMMzZrTUFV?=
 =?utf-8?B?M0ZMcW9uNk1yNzFWd3Yvc3RKVmk2alBDaXlHSXdiYU4vYnhEVDdYeDJ2OERP?=
 =?utf-8?B?RjRYNk9qTVlzWXk5ZURraEpVSDlqVWJuMWJPMmxHWnRRNU5PMXh3dGFSOVpj?=
 =?utf-8?B?Z3ZmVG05bEloZzNBUzRzY1B4eWxxOTJLODV0M0Vnc3lHMzI4ZVBZVURwdXdp?=
 =?utf-8?B?VWx0aTdMTlQ4WE1aaXVMOUMrOCtMNmppUllTSi8wOGRkK3pmczRIbC9BWWNE?=
 =?utf-8?B?UGk5Ky8wem5ad3R5cEIwSDh6dE1QdXEwSlVHR215L0syVWxLdDRtNGR2TGRE?=
 =?utf-8?B?bFh4Vk11V0R6by9iajVLc0V0WWR0ZklzZmhVUVpKVW9rQ1huWXBkRTFTZzNG?=
 =?utf-8?B?dllhYnloTHJnQlNCWXNUNy8xazY4RGZIeWNINkZtVUU2cE92WWdIcENSLys0?=
 =?utf-8?B?U042ZVhwK2UrS25zVXFTdjkwb0NqRzhCOXNIUGpKZ3ZrenVId01XM2JTYmlX?=
 =?utf-8?Q?Zyoxbs/UXCmRckQxrM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F72524BE71994A41B5ABC130B404C812@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe1bd49-d22c-4c25-28df-08d93ac84d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 06:37:01.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fYc4n3gto4sk57yNSW2ekAbm4jWUCEmC5fOARK/vB5BDVNQoV+kYOenKu+8WdQ8tZRWmbqg2A66KWMwwj+UiJZuxgzchgDzrGqxAs/vGQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4919
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNS8xNy8yMSA5OjE0IEFNLCBaaGVuZ3h1biBMaSB3cm90ZToNCj4gKyAgICAgICB7ICJteDY2
bG0xZzQ1ZyIsIElORk8oMHhjMjg1M2IsIDAsIDMyICogMTAyNCwgNDA5NiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfT0NUQUxfRFRSX1JFQUQgfA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX09DVEFMX0RUUl9QUCB8IFNQ
SV9OT1JfNEJfT1BDT0RFUykNCj4gKyAgICAgICAgICAgICAgIC5maXh1cHMgPSAmb2N0YWZsYXNo
X2ZpeHVwcyB9LA0KDQpJIGhhdmUgYSBteDY2bG0xZzQ1ZyB3aGljaCBkb2VzIG5vdCBkZWZpbmUg
U0ZEUCB0YWJsZXMsIGhvdyB5b3UnbGwgZGlmZmVyZW50aWF0ZQ0KYmV0d2VlbiB0aGUgdHdvPyBN
aW5lIHdpbGwgZmFpbCBhZnRlciByZXNldC4gSSdtIHdvcmtpbmcgdG8gYWRkcmVzcyB0aGUgZmxh
c2ggSUQNCmNvbGxpc2lvbnMsIHdpbGwgc2VuZCBwYXRjaGVzIHNvb24uIEkgd29uJ3QgcXVldWUg
YW55IG5ldyBmbGFzaCBhZGRpdGlvbnMgdW50aWwNCndlJ2xsIHNvbHZlIHRoZSBJRCBjb2xsaXNp
b25zIHByb2JsZW0uDQo=
