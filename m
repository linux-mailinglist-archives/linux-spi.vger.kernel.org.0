Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E83CB8B5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhGPOeW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 10:34:22 -0400
Received: from mail-eopbgr1410045.outbound.protection.outlook.com ([40.107.141.45]:31424
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhGPOeV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoCLZKsHAEAzSgepxEGUEHstaK1PRukJjwe1VDX2BElwWqQuuCTAgAQp9i2VdDtB3WHFbJGmBUpY3dylA9qthfWrYIb2hWbgfW498ZSiQ3PC42SNJrxSX8TgRmBfO7x0j4Vj8DOC3t1xuGDpcmAtyCsyUzPJuShzxiSG/A0stKK/vvKV8QgKk1p+6toYyYaBbMuDd4eNj9j7e5nd2gMA44d4oWS/Al0Maw3UuYqpaOm+whJ76QJWFSEumJijndSYm7xTPB5b1qtmrrab0mFlUZMF3iFx7DteFDVr5sAUgCM/Ow53riCMSTS7ZkdkeZgOkirv702mSCOZdqY1yVM2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUChWJyB28Kbp9RZR/YWYiiVQ6u9ZDEVj1N2oVqy/mc=;
 b=IGShG6I+Ls54KvHb8Q/isVEsCShBIjF76Z1jWg+dThSuXnTBLASg3O/NsUkbgGGx8voC2QTw/QS1nEnhcttlE+vivXGrOgNaLuJ3lHeiIQQLvI6TmBAXrVdK4CyKsUzbRxHdhkMTf5dpml3qMOmKwXqmG5cNHr+rdIxsyGYqSIHrAfnoKImVhXxf8k68qVSrw90CvWOK207moVhW+4TWJpqP/eUyD/PABnDW058nyM9dE5gWCT97sKoWYUMZ7VlSUmYgiQQgol0DN2vfZVqodr6tsGhO2OFidvTxww4diI0Gex+k8G/ynRorLE3zSe3IYyUU9B5VDLxu0VCEIWOJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUChWJyB28Kbp9RZR/YWYiiVQ6u9ZDEVj1N2oVqy/mc=;
 b=Nb4z/0OJQaqIJgvGfgRSXLc5+EQfcfxhy7BYtlzBl4ULwF90XC4U2aVgiP/AXhZbrhi/uuVEpKnzRpOlMIp3v6Ke91A9RoIwyHXTOVtxWHYmrmpd7SyZI//BFX6qVTb371OuR1ikxrS3PrWSxJdMwBpw+fwjgjk+QljKsnBQ2hI=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB4278.jpnprd01.prod.outlook.com (2603:1096:604:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 14:31:25 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 14:31:25 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v5 0/2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v5 0/2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXek9B/swp0s+P6Ei6qvXLG2oy3g==
Date:   Fri, 16 Jul 2021 14:31:24 +0000
Message-ID: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e53a4ae2-f3e7-429f-51c9-08d9486663ff
x-ms-traffictypediagnostic: OSBPR01MB4278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB42780FEE6D0A3D6D483C97B48B119@OSBPR01MB4278.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfkwuGjhgN9lSAtDMWecr/YhpF6kjpiYziv7fpTHBvq00k6R/Z1IZVIVzEzM+uygo+/rgLjjsuYeT3wQH8MEHs/S0puRB/dC9ooo42rop9oVO5ntQoE7y0YlOLnpBxLyuVpwkLIiiwv6yS80sv/Gf5x26pc1LvMrJwCaWsiEKJLxPOzOzoN3LWhGPnEKpqAC9iEVQp/gX+aGkJq3/1o1XUfe7dAWrkHnXKR5A5aBQLET1ZHX8kJuu59b0fj0kfUV71UKSTdexRpUHJ/TvVuyxLMhR5hCQgBTByjfi5mEjiWmLgpCQQSENrsHi1EdcrI4c3XHg+SlV6VWz463nsyfAwQt4Uz9Ufbu5Y5yVxfQwr3gd5cwwd3VBXwxyDCVq4AgmTd36i7DK82ldkF5KplR/OXz0/zq0THQCNi+qMBPUS/gx+dDCnIlSDn+FWPzs1OUS/PyfWuuChW5Ms+yu7PiuBYITtOW/rqZbWgG+bR4roiaCnubWlLWkXxUrLKCkU67he26wd4JykslS93gHahmYgvkBOppesl7f7vNgBmvweYoDkrv+4EzPLS7VuewJ4uCM56ysGyFPeFiDCHFCnZJqjvYhB+HbwB0d7EfGCHPluHXCzp3CpEk8EiPsILDbzpPTbpHFGJPLskGmjbLbfXQPpS8XyKGBMqaWW6rzQTjktBIM+V2zzy0SG8fWor5TKuCPHaVbQaUKpBaFzs9fkw6aF/DxquGHwLdBLnFbAkAsRvbdwnu1aVuPnbZAT99tw/hjEmJjZsFOiKYzkt4632V/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39840400004)(136003)(366004)(376002)(122000001)(38100700002)(6512007)(83380400001)(6506007)(6916009)(54906003)(31686004)(36756003)(31696002)(107886003)(8676002)(86362001)(8936002)(2616005)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(6486002)(316002)(4326008)(186003)(478600001)(71200400001)(4744005)(5660300002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cnRTQmg1RUN5QW54bHA3bllGVzhmUDBGVkJSSktPMTdUTzVZRVF6eFR2?=
 =?iso-2022-jp?B?U3BiVE9hQjUyNXh4WU5acWxVNXgzSWVabjZMaEZxdzBNejhCb2drT3kw?=
 =?iso-2022-jp?B?L2ZkaFRLK2s2bGNsVHA3MU40ZG9MQisvTG5scFUwdEYyVG8zUGNYbTBM?=
 =?iso-2022-jp?B?WE1NaWhvUUhWT3B6ZHpTbTZYUGcxSm5idG1IY0NoYUdXYlVucmNaZUNP?=
 =?iso-2022-jp?B?eEdScG1XaWRUeStSelVXblJicVFIQ0pVdzZFb2N6SmtnczdmV0FJRG1K?=
 =?iso-2022-jp?B?QXVyV1ArOTZaUUZDMDVpVTREOHJ2dkx6VkJPNkhqKzRsTy91MHlxN2pB?=
 =?iso-2022-jp?B?dDQ4TnRRSEZjRXkyeW95VkN2dzVpTkMyT00vOGdac0lrTk5KU1RXZWs5?=
 =?iso-2022-jp?B?cjl5Wml5enhhN2k1cGI3L1FaYkMwSyt1ZHJROHQ1S2w3eUpOMVZPeGpn?=
 =?iso-2022-jp?B?Z09rb0UxYXFXMU4zVmZmbGMxZmJsNGtia0NIL3AxQXZmTlEwVFVKdFc2?=
 =?iso-2022-jp?B?YVlQSmVKdFJJQ29ZZmdlZ29VTFVCV3dhZmpZMEJMWjdJMVB5K2gxNzFp?=
 =?iso-2022-jp?B?Z0JiWmxLd29GUmlKclluVzFzVi9MUHFDdEdmSk93M09paDhQY1o2WVpZ?=
 =?iso-2022-jp?B?VjBWeUhwRHpaL1BIWXJ3TzRFL2Z1Uldrb2dhUnFuYnFkc09oNDZxc1Ji?=
 =?iso-2022-jp?B?T2F4aHlSak50VHdBTHU3NHMwWFJyYzB1RE9yVDZURXJxQmlhM0tZR0V4?=
 =?iso-2022-jp?B?dVJpa0hibU1WMlhUKzA4b094RENiSDFQa3U4eFQrSDl0QlB3TzJvb3h0?=
 =?iso-2022-jp?B?ZEhqSVhWWXFuWWl0SFM3Y1ZraXZtV3MrcmY2Unp3SytMbVhOL0g3WU1s?=
 =?iso-2022-jp?B?bE80SjV0eEc4bkxLVVVaeHRqV25leXpVQlRYcEpBT3I0aWx1UHQzN29Q?=
 =?iso-2022-jp?B?T0FkR3ZLUWtQMGlCS09PT21lZ0xxeUJGSk5QRHR5VmJuOHhDVEw3TkdE?=
 =?iso-2022-jp?B?V2srallKR3BPSGsvbEw2cmlha1graFhxNElUZnB5U0I3Qk52SlF4Q1Rn?=
 =?iso-2022-jp?B?SDZ1VGpybm41TmRqRnY5cnA0VkdWVTd0REI3OUs4OEp6eTR2MDNuZURG?=
 =?iso-2022-jp?B?cnViRzU5VXVLRllETTBNditoSjdXS2N4MUpLYTZ2KzF0SkVDbnJQWDdC?=
 =?iso-2022-jp?B?TFJXaHh3Vnl3NHlydW9PWWZVdWRvS1VkMHhLQUhzRG5vZUxLUEN0a0sz?=
 =?iso-2022-jp?B?NUp4bDhqaXVUK1FjMytmNDFRQ3ppQUU2OWovcEVsTUd4d2dWbUZMeXhp?=
 =?iso-2022-jp?B?ejlGS3ZuRXlFVlpJcmtFdWJCSHRvNnNTdUc2b20rbXNkWE5qSWUybS9j?=
 =?iso-2022-jp?B?RVJ0NVNDcUNBdjM4VUliQll0NDFZWEg1WWdOZGkzZ1ZVRWkxWld3WmtE?=
 =?iso-2022-jp?B?eFNYUEhvekd0MVV0d0R5M3E0WTQvWWZZVkNYUGF5SncvbzYrWDN5YjNG?=
 =?iso-2022-jp?B?ekw2Y0hjQkhVV3ZQblJFdWgzZjd0KzE4UGQ1cXFPZzBUVUpLQ1E0R0dX?=
 =?iso-2022-jp?B?QmF3b0pPMm5SbWRmS2FzcXJGdnFtMUxqL2wybXJtNEk5NXphUWdPWWlw?=
 =?iso-2022-jp?B?aGpFNGhmY1NJV0dwVUZjRTRMWHdiRlJvYmtJamRNcUQzRVdxODRHek5U?=
 =?iso-2022-jp?B?Ym5VdVF2d2dINS9rZUR2bndpdWxLRXhIWm9LUXllaDZoUXg5SHNIVEZs?=
 =?iso-2022-jp?B?R1Z4MWxZOXJHN1JGemwxbm92bHRTMFBrMXh0YnhkMUJjRjZSLzRvblk5?=
 =?iso-2022-jp?B?TGZKeUZOekJQUmxoNGxRekxzWDgrUW5CR3hvcXF2a3poUEx5WS8rUU5U?=
 =?iso-2022-jp?B?aXpOUkpTYjd6K1pRZ1YyMFBIWUx1aWxVaHlscEl1NFFZSW1sQXlxd2NY?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1A3780D75108024E92D15EC83757FC78@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53a4ae2-f3e7-429f-51c9-08d9486663ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:31:25.0041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ffDo+f3HuakfnqjKDjZsRvtLVHwtVbe82dGUpBnr6bPsDUdjAlT5i4z6Uc6nD+UiK/xdlJheNfTA7RuN/stwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4278
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

v5:
- Added Signed-off-by and Reviewed-by.

v4:
- Changed to better code.

v3:
- repost.

v2:
- Fix commit message.

Yoshitaka Ikeda (2):
  spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
  spi: spi-cadence-quadspi: Fix division by zero warning

 drivers/spi/spi-cadence-quadspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)


base-commit: f77d261b522e1202ef1a0925b8ebe0d73ae79e1e
--=20
2.32.0
