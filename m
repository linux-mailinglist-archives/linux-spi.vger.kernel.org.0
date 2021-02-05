Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDA31062D
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 09:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBEIFB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 03:05:01 -0500
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:49879
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhBEIE7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 03:04:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+9nM8P74OX6u/LE40JTeb6makBGu+8DVojmutXH8XmYf17dZbLqmhVjctn1tNQKREhWnTxklFSllDt7F4U2DXkmEmTxiy97bKSkNxslNEWs0JD6pUV9GiWSzYTWr9a449bRHy7D7NGlv1FE4SSl6LdjPFZIG1C8RpXx9EQODZMivT2kT1Eq4WUK7NeHjeEtJbVv1G7efghX2lQV9ab3Pjx3hcPBtnlBZ1Sar5v/GR5L09pWPPjMBexmw2UDuLxoEBwQC17XPQZXU9tBxTlVVUE4vAJBjGbw/p2LK6ZAI1OMT+1YyijHF2F6U8E6iVtWS5BEzxo5Mrl59OYlJgXhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCi7xYO/1TIErzzIAiYBLfzHcnGeDgtF7uBSacsq5YI=;
 b=Udyq57mCrGel1SbX8lqsLUsjWVQKVY+kEEoHaWIHtr7+qrI3fOB+b39y/f8PqydOswez3mJb0KgcnudWX/yVUAgupePV9XRc9kH36iEnJr6exJ00YEuOTf9WNNGhpWnUp24z/9F0rMyY64/pDJeYG5mrkgx8Ut6niSaSdur6dvsHfp1THF2dG7MM2OfWf5MNPIw1BTyeln9hnScEbqfX2bx0YnkXVdvW58yZHpPTJ8mAR+0iwP6hKEsDk85W9R8JuwMvW3MQPuxoOJQFn/vl26Il6QtzuLg6Ut+za1EslUnA5xITK3Xb4JJofKVzuyGe3h969tWv5uuRQU3l17iNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi-powergrids.com; dmarc=pass action=none
 header.from=hitachi-powergrids.com; dkim=pass
 header.d=hitachi-powergrids.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachi-powergrids.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCi7xYO/1TIErzzIAiYBLfzHcnGeDgtF7uBSacsq5YI=;
 b=OyZK/dUV9YNy7K95uG+ax5zoS+bjhldnJG+eAePH8BYafH9w8BUi9IHD6GFqZznbRCHpZ7/Yqb8nxMjtTvgS9jHuJOwwzrT1jwGY6NqXuAhUc4M961Zc1Dy9M9H00AmbQ7csLuELl+tXviSJMfc5Cem6XYH/LRCgOmXzYqCmE+o=
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com (2603:10a6:802:5d::10)
 by VI1PR0602MB3247.eurprd06.prod.outlook.com (2603:10a6:802:c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 08:04:11 +0000
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e]) by VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e%4]) with mapi id 15.20.3805.025; Fri, 5 Feb 2021
 08:04:11 +0000
From:   Aleksandar Gerasimovski 
        <aleksandar.gerasimovski@hitachi-powergrids.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: tools: fix input string formatting
Thread-Topic: [PATCH] spi: tools: fix input string formatting
Thread-Index: Adb7lWXMIZfEJF6fRI2btRVdFMCGkg==
Date:   Fri, 5 Feb 2021 08:04:10 +0000
Message-ID: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=hitachi-powergrids.com;
x-originating-ip: [80.75.192.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21378f92-cd38-4f63-d5e1-08d8c9ac9ee0
x-ms-traffictypediagnostic: VI1PR0602MB3247:
x-microsoft-antispam-prvs: <VI1PR0602MB324769F307F9A085928A0A10D2B29@VI1PR0602MB3247.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMHQPmXTy/kkRoD+kmGXwu3aTXk2+efNk96lTRMWOxiAnuZq15FRVy+KJEtPqQ2BMJ8+CFhhFhOuGCX40YD8cTLmM9HnPfbZngoiDYtvXsixR4ie5Rm017wF55xQ14E2i5TjK4SRLFjBF2vm3/NKiWsytMy6nJDpAVWI3RDm0DAZQkl+/oz6RfXnmQ1I8ptgCcGROh9eRdpgu8Dj+Nq/d8NhNRGJOlDuXgc5GsiGbJwvv+tte9uqf6tkxPsCbIFnP0zRXjx/LO3diJJFITRbewE8aFavJTtcUibjK5QF/yFqYtd2QYnLliQgcuS47bmQTlwclEOQmcmIEnLoMuLEQSTpOrboV5h4NFV3vPjlOXMsJLg+hJkxn85rXFlIyd02C6vw1Sxa6QeiFadvzMZ6uuLxaVPGvQ+TZ31xQFSUDqMKqurlRJRAdF4zPoJxJKIuO9tYswDwbEWhMgeFW+4biw5oFb/v1wb6wz9+KtKZVUw7wTRUZ8pjQXShoaxdL4PSt4BTDCfAueMkVUFS5ujYXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB4029.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(52536014)(5660300002)(2906002)(64756008)(66556008)(66476007)(66446008)(44832011)(7696005)(26005)(66946007)(76116006)(71200400001)(8676002)(86362001)(8936002)(6506007)(33656002)(478600001)(110136005)(9686003)(55016002)(186003)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Pr3eLxApX90TfrS+TKFbuCXbHvbsG8fbHjIT0IDoXAMiz5O8sfwGyByLbI?=
 =?iso-8859-1?Q?mu5uGJGB7iBSBrXnegye/dY2O+Yl8nQX6QyTu7nRkPLpV9ZuHsCzwbaTQU?=
 =?iso-8859-1?Q?jfm82xxnBCPMhAWeeiNZKJ7E3StK3bS9vcDypsXScyY6mLBsUJzCuRnahi?=
 =?iso-8859-1?Q?WsW3yTAmuCJlmDGo4Oju0VWW+WLU3YTFRsumBCZWlbWxqkxWK4SSoDNdLO?=
 =?iso-8859-1?Q?semm3aSE8cEHRg0P1Pa95I6wTU1xjsQgKvUUFva2KZ4QNC6WHglBfI54pz?=
 =?iso-8859-1?Q?a2apxi0MJ/oU+g7hcPZDfmgxNIxcB6YO55Uc9cEujMNRqIgbU6czlrlxhx?=
 =?iso-8859-1?Q?jNQafqhUfX0zEwly9AvPG721p4B8gYukw7KcszKWG3tp1AYQXjeZPpoLki?=
 =?iso-8859-1?Q?4DuTUyfFQfZWAtRnbILwe/l5G381oPlCJ6TvDAygJXei5F6IGpLS4e/SAp?=
 =?iso-8859-1?Q?q1+EzNgHctws443xW9mgqiAxiR6a5tjM7ANsxjIiA5ronzHChevdUwG2Ye?=
 =?iso-8859-1?Q?a8nnYgHwi1TWGIuYzY/ExZgTfDMgSpK/uVR3ZU+JvU5f2l3k19Hpei5eg4?=
 =?iso-8859-1?Q?MccTyRg/rMxc5qJWdZRFrut7AJCgBB/8d9NyV+JmAX66nb752ay1yeYS6Z?=
 =?iso-8859-1?Q?YS6swZ/8AdOkxqsU0fBhT/5M3Vrrj5Css+0SrpOzHSj4rtM5iuhIoexz1+?=
 =?iso-8859-1?Q?qrMkU4aOW29jIHiUbrkFANUY0eVaW2mPv7Scu58DBW2YYUJTgi3AsfQzZ2?=
 =?iso-8859-1?Q?wi7RRoXdqLUQAHA30OERKq1YBj5LBh+jcgcks2wH9PhBJatDF07rgHEYjw?=
 =?iso-8859-1?Q?ZI7+SLvQ7Q6+NKjtxu0u+uHEPmJLYjzVMQGuqakMdUyvxMTJMzhbPz2W3s?=
 =?iso-8859-1?Q?+Gk3g5h+o2bbW9R2diF1E9034jisJoxv6Kd/5sALKUPBpT8tQgJuLbkMM7?=
 =?iso-8859-1?Q?0Iydz4kaAvdcT3McBSZBpkTvjGC9esViyrAnN2UnoOs6yb9/rVqk9sJPMF?=
 =?iso-8859-1?Q?hgll1dnrruzYtkpIhkc8bdIAeJBl/K1wtTuP7l8kGcTnEhwcyZ7PnYuULW?=
 =?iso-8859-1?Q?ObzMZRrAQwN8abhdwlMcpve++mQznrWdUlWi4d+VDbQBX/8IogmKtBPUyk?=
 =?iso-8859-1?Q?8jZNolu4D7DCeAz73Ox5TbXhQh+92BEFcdUaWhYlMThIFZL5yRsABJuhZS?=
 =?iso-8859-1?Q?hTj7mwULt47coWGt9oyZhtFrsx2ZM3CubJg3LhU59ZrXjojR66c2NZ8XOR?=
 =?iso-8859-1?Q?2i0xPaCReofbClqRMhidZRZMzt5vr7WAIU/tVZqwPaH0LO5UUSuQynVkxx?=
 =?iso-8859-1?Q?V11auSkpcvMR+IzOYInPWm6fpBu8s2VQqGTfrBczykUhPeponpie6RxbE1?=
 =?iso-8859-1?Q?57hdSzYzOv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachi-powergrids.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4029.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21378f92-cd38-4f63-d5e1-08d8c9ac9ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 08:04:10.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjX46fBTzOdiqaQIiyGwgEtTnltJ6XvyzWuQ53LlpociDgZGHoKtketCN+U1RWkCX1T4E73mCW4LQoqnWl8N6Si1tOl4fAOR0VsSRtuvxTFX6Jqy7Fa7ye1ZRECJZp4Bs1skLeO5n4UbSO78lnEZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3247
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The actual unescape implementation has two bugs:
1. quotation marks from the input string are not removed and are sent
  to the spidev, e.g: input string: \"\\xFE\\x01\" will be sent to the
  spidev as 0x22 0xfe 0x01 0x22
2. there is not format check for decimal input strings

First bug makes spidev_test unusable when strict spi sequence is needed,
second bug is not nice to have it in.

This patch improves=A0unescape function and fixes above listed bugs.

Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachi-pow=
ergrids.com>
---
 tools/spi/spidev_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 83844f8..7c36677 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -89,7 +89,7 @@ static void hex_dump(const void *src, size_t length, size=
_t line_size,
=20
 /*
  *  Unescape - process hexadecimal escape character
- *      converts shell input "\x23" -> 0x23
+ *      converts shell input "\\x23" -> 0x23
  */
 static int unescape(char *_dst, char *_src, size_t len)
 {
@@ -100,6 +100,10 @@ static int unescape(char *_dst, char *_src, size_t len=
)
 	unsigned int ch;
=20
 	while (*src) {
+		if (*src =3D=3D '"') {
+			src++;
+			continue;
+		}
 		if (*src =3D=3D '\\' && *(src+1) =3D=3D 'x') {
 			match =3D sscanf(src + 2, "%2x", &ch);
 			if (!match)
@@ -108,6 +112,9 @@ static int unescape(char *_dst, char *_src, size_t len)
 			src +=3D 4;
 			*dst++ =3D (unsigned char)ch;
 		} else {
+			match =3D sscanf(src, "%2d", &ch);
+			if (!match)
+				pabort("malformed input string");
 			*dst++ =3D *src++;
 		}
 		ret++;
--=20
1.8.3.1
