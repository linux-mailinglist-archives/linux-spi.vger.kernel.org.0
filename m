Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9F3CB0F0
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhGPDIZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 23:08:25 -0400
Received: from mail-eopbgr1400059.outbound.protection.outlook.com ([40.107.140.59]:64416
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhGPDIY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 23:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPPZpzFyd5AbsxqzYG4VEQIL6io6f0aXhCak9VvAB0tB//zrLUnivePcT0Dh6eii6sg71cTRm7QECKcZhP9Fmx64Om+v4MKxK3d364TDd3FjO2Cv8MfVoUsfi+A53bppPnYMCrzMMZGYe/iJu2M83R3YLTeXIAUmB6dauzsYGpI5FLqFy25vGnRNayv6LJfh29alNi9F0a3wnFU9oFxZp0xxa42XzXfHBdYsDqf11E+2MKAZJMWhRM3U8A1OywRcrJO1WqzIEGXSbd2Ku0BlFhwPz1mk2NTpY8zocl3gpT2CVbgL68kkJdZKGi00A4zmH/BZRGfjv/i3AMLLDlFgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpOiWS5vkunf/zWR2+bagap2TUOJtmviGNxP38xzp1A=;
 b=R8I83K+PhH02dJNMnTrs89sz+sUbcSHyu+vh4KDVMyF7fige2N1ttlqD+a48fIJh5AZNoHXd7O0pEjEUEOy+75dZjj7K+NPO70ZbI1qu7p6p/0TMdSAGh3viRmU2IIVmB2QYRQ9VAuFV7tAzfnRyONW83gDbRp0czhjfr/1XZ68/5vSMFg3J37YPYNvNzVqCBMRMqePxSTVUKK6f31kB903RLIzll8iVDkI/cqMJLIIlihktfk0VRJ38My2QhgKgWxmq2/Xti1x75KWjORvHbzlELFmxpzBYZEF7/hLMkVFsWBU+FNstbFVAlt+8Ln8bqwg/x4NpEKeORink05NCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpOiWS5vkunf/zWR2+bagap2TUOJtmviGNxP38xzp1A=;
 b=m6T23GJtiMq7tNhUekRyDfue1sdcKLyF8xS40tdISo63t9uAz3UnVAzhE1d0fGpZkhvyO+vZDU80VWP9bxuksW3Umj2xBwJLym+e8cD5OAM4dyRFUrp/qz9yUx9Jc4jlQ4g5N7UTKCYqL9v4AL36qfmEInK4nUV3Sg8puCm9L98=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB1816.jpnprd01.prod.outlook.com (2603:1096:603:1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 03:05:28 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 03:05:28 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: [PATCH v4 0/2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v4 0/2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXee9uS3EQZVe5Ik2PZmjPjAMZyg==
Date:   Fri, 16 Jul 2021 03:05:28 +0000
Message-ID: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deae5866-5335-4bd6-1420-08d9480690de
x-ms-traffictypediagnostic: OSBPR01MB1816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB1816B61A386B9AFBB47F3D688B119@OSBPR01MB1816.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HL4Bx/5K8VaMc3vHB8aoJBq3r7J0Z60nkTr0PtA0C+hNWOrbhwfLc5Xyp2TUCsylIpyW7jB8DmoztN1fEJU89vm6SLIrAwKiI6DFZ1G17vD/WucLCg15Ql/a+M1dFvlbcqbMVIyKOm5yIeVKsaPYdAkhqkjSr+H4dvcKPT1eWM59VGbjlBty57UKb8Tiyvmj4KlS+BCe7apo19NlDuSx/NXUsJZjD2jsSuciGmltZYgXrZoyxNtPXuUsitEHfSTGxtce6IKdX9tb8dYaztGl0BAjKavd/8/ym2Y2ncSEEL/oT5AL9jYHExfeK8UJFe+hFN6aVAdmCwPO0wTvJgdj+ufUIl0nrNvHZy7tBbTmZ565ojEBOdFQAAGSoF2TF34DrTKwkQZMdOHdf33+k0u/9WsxH2Nx1PTDgJm4tZQQ8v21H1AVLg6mZ9NMroVuq7YJncdImyhuIl/RkFR5JJ4+iOSWQh8vJ7rc40BLcvj6vnJkWjSLhmaiiQ0Y+qTZMqAwYBMp/YzaoUJbgbFm///FvT1/nNw6d9jI6ophukyKhlNTYMafuuqYDHHV6aQpSuarISVv25uaNsq06Y2sOCd/pz94+BDq3qR6X5KvzTPePyKhc5OW8zUlnMEHHCXaljXiIjMcniZUPP7Q1XxZFCYaLATHH7mBIEpue3y+t0malvd5TFyGkUXD3f3oKA1lajvUuNvwSKiINrzlCyZVLf/tJwgf6sdJVVeRzW+ru5AybMjYzn33ETnKHY2fUOsEYm4A3kijtFR+78PGGOKNOrTRfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39830400003)(31686004)(2616005)(36756003)(86362001)(31696002)(2906002)(6512007)(76116006)(66446008)(66556008)(186003)(26005)(66946007)(64756008)(66476007)(83380400001)(4744005)(6916009)(71200400001)(8676002)(478600001)(107886003)(316002)(8936002)(4326008)(6486002)(6506007)(5660300002)(122000001)(38100700002)(54906003)(38070700004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YjhFVEMwdnhHUDRGWXVyeDF4Yis1UHVVbFFGMlBFZkxNQUtGQSt3T0c1?=
 =?iso-2022-jp?B?Zzh3V2hRKzNjUnlnRFVaN3dyRVRTbkcwZVhVU2xGQWhhaTdiNVJTeGdi?=
 =?iso-2022-jp?B?YWxneEFPaDJteTJHTXlGZzVKc05ZdHo0SDRQZHhBblRFc05sSy9UTS8w?=
 =?iso-2022-jp?B?dSs4VmhNdXhsRHAvVlZTTStYNy9ZSmhRUm9pdGtVaUN6LzV5TDh3Ky84?=
 =?iso-2022-jp?B?a3RKajI5NUs2WVdld1hzNmptekJwSlNFK243LzNONDhOT0Z5UXFvTlFQ?=
 =?iso-2022-jp?B?V2NrNFdJUG5sUkZySTJBbmlUY1pxOVc2OENHUnNjY01tUkl3NWszRnhy?=
 =?iso-2022-jp?B?LzZOZXk2Q3RBVVBVYVZqTFVOSHdHYVYwV292WFZoSDZPSEIwSnpDQjFM?=
 =?iso-2022-jp?B?cU4yNEZRMU85V3Y2b3RaalUrRkRHOTdUelVHQS9LcUM5dzZ6RDJ4cHdY?=
 =?iso-2022-jp?B?MThKU0hybTRRWHFxRWhoMmw4SGtlVFpPOEh3bUErMGFRaDBZYUVnNVIx?=
 =?iso-2022-jp?B?c2QxcERpSFBPYUZBcFJXelVMck5nMVlXZ05idENnWnpaOGR2ZU1rdGRj?=
 =?iso-2022-jp?B?MlNjTTZXWXFmeVo3U2dWS0FCSEt3Z3hqTHNVckFaRVBpLytNZis1dDlx?=
 =?iso-2022-jp?B?TVY4TmF0T3Q3c1htRDFHVEhtbnZrano3WFhQTWJkeExQR0JnOFIySmwy?=
 =?iso-2022-jp?B?RVZvTGc0T0VqbnB6UjhhdkNHUCs0V2cxblZWMCtRQXcyamZER3I1V1N0?=
 =?iso-2022-jp?B?b3hjbWFMSEJUWitXcU4vNlU2bE5YT2ZVUm5oeVJHcEpNM3pwMGFTTXo5?=
 =?iso-2022-jp?B?eGFlN2kzWG1SSGI4Vi8ySmhaWFA0WWo3VUJnNmFUQkVWVlk1VkdlTWti?=
 =?iso-2022-jp?B?U3RnZUtPU3l3MHlpcDVLVHdVMTFRNXJhWVRYVVRKODZNNFRNZEFkNGFL?=
 =?iso-2022-jp?B?Y0h2QTJvOG5ZeXJqY0NqNEZXcEZWOHc5M2RkcE1jN3drdmMzNUt6WHVv?=
 =?iso-2022-jp?B?cDVmYVo5bmRtRHZlQkpndjNVOE1QeXEveHpBdWRoa1JhVFJ5SU9NdE1X?=
 =?iso-2022-jp?B?dmpoODQxMlREejlYbGRqcGtiL2lZd0RMcy94RGVHZVJJSUV5bGRCZW9q?=
 =?iso-2022-jp?B?SElEV09VazZQQUNuNEU5SXdIcVhsVFFFcE9rZys2eU1KUnNqUzZMUm1R?=
 =?iso-2022-jp?B?dUJFMEV4WElxZFNwSk0wUWJQdlByLytVOENKSGRFNmpSMUhBendmdnk1?=
 =?iso-2022-jp?B?aGRDMkkxN1l6cHlqeGpKb0Q3WTNNSER3R01heGhmL1JOMnVHVzVuS1VQ?=
 =?iso-2022-jp?B?S0ltNVF4UWdJMkkvaEJrOUdVTlFncFFBOEo5M2FaWHVqeEEyUWJ6NitH?=
 =?iso-2022-jp?B?U3NPRWZzQm5YWCtBd05kL0dxc3ZjQWYwT0l5VnBReUREc1E5eTFYWklN?=
 =?iso-2022-jp?B?bU5NQkNpYXZqME1PYlo1Z0dHUFR1anJNOFVNSFNQendWSXZGNVpJaGw2?=
 =?iso-2022-jp?B?Yjdxczg0THV3b0FzUXQ4ekluQ2ZGaTJxWjd6K0VMcXNjWkpVZGtubjdB?=
 =?iso-2022-jp?B?YTZNRDdoWlFUNUpoSThKT2JxNnhqdE5lSGJYZGxCMnlGS2tEZldnL0Mr?=
 =?iso-2022-jp?B?SElxSHhGUkIvUkhGTkV1OUdaMmcxa1FxbVlUWFFvMnRLNmZaSElVRXdr?=
 =?iso-2022-jp?B?M3hrVlNFRHBHWEtwVGRWR1E4UDk1Wm1BTUY4RnRmUlo0cjE0L3RueERD?=
 =?iso-2022-jp?B?L1V5cklFUm01Q1dhSllNRURyUmMvbE53U2VtcWNVV2d0M3djK3F3VXNw?=
 =?iso-2022-jp?B?dUdReEFFQ2o1M2g0SXcyWEhuWXpIRzBmb0ZMdlBvc2tvcmNja1dTY2l4?=
 =?iso-2022-jp?B?STB1a3NTVGdLc1ZOUWRGWnlBU1Z2VDNJa1ZRU1R0WGtCZHl0Y3FyY2lm?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <316E9E98559F37489C5981FF832B2908@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deae5866-5335-4bd6-1420-08d9480690de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 03:05:28.5708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F25IUL9rU3PCsR3Y99+oRcDz1zrFjF2x9cwducpTf6hgXuwt06jskQKViu+Rg5eYqyYzZNNMW4uEDq3z5GxoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1816
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
