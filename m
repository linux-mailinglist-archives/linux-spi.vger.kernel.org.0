Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518C43C6B2E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhGMH0E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 03:26:04 -0400
Received: from mail-eopbgr1400043.outbound.protection.outlook.com ([40.107.140.43]:2263
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234098AbhGMH0E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 03:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/6DxcSb4jI7XKzRluoaQv1Iam/livjkyiViVaQqQVYex0darKJu2hFPOlJ8/t0Wf7FeRAZtaS8MAXnne9ajndY3Wp6A/yoXCFN1k5/wvB0Ow/xLlXaB+GdqsUt4OCOVwt3ca0HyIxt1pwu2Yh2FsOiGIL8Ig1HKnYIgD4pBGbQDyqUadcdsPHSslIoYL1NI5wUWfGb7hQt7hC/QLQxa7ApS+wFwTfQ6OCH0WFenXShqQfTiKHKUO5FoZdeKKXnfJPdmuCz7/I4aZ7fTv71XE0GWT5erdfLIxOoM0kRR8TgtYltRdEG99XfDM+ShhArp8Dryfcz0wGu+Nh4wzSg2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4UxUM4lqsmwJrbP8EHMfC+tJYpBMfgDRtOapiRAZWY=;
 b=d4R6ov2dKyD8yCLp+cdSTbawhLzhmCVx3k6J8l04w5dD4rPqXxGzz5kHRhe+g3oI6vFKJMa9SuQSovxA2Fl5qoRjXp41IISLvf6E/FswSllCJSQX6RiyiDF0tfVZ6oDDy0AdiMaR3ZpkIJ0CnVg0lXtCitK6bq+srWKNWI6otfMmy0EIt0X+47v8yf16jBGPqdzYhZtKpG8+Ujh2vhj4SOxYn68VGdzdgROFCSDxLUDfZDmbupGoyi++r7JmLbrt3eFQJGd2vnP/f7WVFogG98nDXLwR0X673KW+KVCaNLmcYt+5ApPaHCgKKrDAbZrj/sCtIK7tsfISXfkK91lCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4UxUM4lqsmwJrbP8EHMfC+tJYpBMfgDRtOapiRAZWY=;
 b=sSmaF24lFUvPAlM+v1FBifU7flkiLdZOwzCBwd8qFHKFTzpJctJ/41QvTupTxu4xC4r/W9pN9GUKjEUGtn+UwHv/sstdbVoA3ni1neHFer3uxKHis1dwXkf/djMHZ21hxOBOm9DqG0K6E3EW2hw1xC+CkUUeLvKXTcrbBpnFFyA=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OS0PR01MB5796.jpnprd01.prod.outlook.com (2603:1096:604:b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 07:23:13 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 07:23:12 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Index: AQHXd7fwKzEQWTvWzEqH2Qm18vEKNQ==
Date:   Tue, 13 Jul 2021 07:23:12 +0000
Message-ID: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbac61ce-1b65-4fc2-d9c5-08d945cf1308
x-ms-traffictypediagnostic: OS0PR01MB5796:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB579616308CD15EF4870E3B4A8B149@OS0PR01MB5796.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQVIztvQ+zzu05LW2/Zorwx4Qe8o899H1cM/yFlo48N+s0thkE0V035q/nAMS/wZNtqCefoc/xHfjXEVhS3FOJ/Or7DL7meuRdLBCPJPlsRsyQQgMJOgJyAbu/1Vw1IM37uYTLoIEKYHsej6q7Xm6B0SiBLz1kJ+kHYzMMhfqSE0mJOXJ/xtV0mKye2yGN56lQhULI0vv+XAly6toPaPY85lZht8gtl+S5gFuZyig98uQ1W8FxSoC7qHwVockB/5BCLiXaBFD2MDRmYxkDXGh3SL31FOX1uZARf8BeLBSO6L2GD7h269ZVOYH2NQp8/1nhirQPbwnab+cbSER+5S/OvmC6wZ3UVJy3LziyzKMQy3B0zVljJD0rLqOPGAf9IDzybpQZ8WH+XxHSEjkA3+2A2tRcFOKtJkea3XnNSdGSMyi4owwKLmOSkOZnX5SWlK9zTAO2cOPTBtDokFYwbPmJs7zwz3ccU7D7f8meauR4X2K3YKvukrxxCG8VVEF5XOlZMglxRKpJRAqzDEHrc68x08VpVGr3oXSoIdSTQyzhvlDE9RENCYoj2U+/ybVQkoXxwsKlRisMCWCP1xBqgzbOHO0Cn/NOYUus97gkqbqRxCZtS6foNsp/br3lENcbFVWskZtBW7zxMTwMT8CJLis32MWhGvBT0EXBhlLp260P0SSNBgzv61zXSh3G4EWYVvM7WMFm5Edm/HypYFJAQZ1SfYfX5pq9gnjKHvLTZUw/5VS6RZKSI4xhnzOmz1TKIkJWN0CxHRsXQqGYDFEEny1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39840400004)(136003)(396003)(346002)(2616005)(36756003)(54906003)(110136005)(316002)(83380400001)(31696002)(8936002)(31686004)(8676002)(122000001)(86362001)(2906002)(5660300002)(107886003)(76116006)(64756008)(66476007)(186003)(4326008)(6486002)(26005)(66556008)(6512007)(66946007)(66446008)(6506007)(478600001)(71200400001)(38100700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UmNxNG5ZU2grVlZCWUtGb3NpTnRzVWRLZUlzMmFTQmF1bVNIeUlFZy9H?=
 =?iso-2022-jp?B?a2lybmZQL2FVK2NoWXc4b3JwVU5Rb0hyS3VUajd1bDhBNy95NkJIbzFa?=
 =?iso-2022-jp?B?ZzROY1l5dURXRERYZXlHZEgxeGgrQkMrM2RqNFRmU3ZqbHNJUUxNb0ZB?=
 =?iso-2022-jp?B?czVwK0VlNDJBemZ6SWtsNzFubnhxSnIwczVvc3RiVTM3dFVraG5NcWZM?=
 =?iso-2022-jp?B?cElwUTNmMldHTVd6eWVBdUh0MTBzNVJlRkgrbzhlcDlyQWRUK1ZTY0VX?=
 =?iso-2022-jp?B?cTVsbzhkUmtlNkpjZ1RGaWZadlp1ZkMxL2NBQkxCa0g4NDZTaXhJZ3F2?=
 =?iso-2022-jp?B?MlBFVTRtVU5Mck5XM2h6NmUxM2FpRUYxQ3ZEaEVwWFZIQ2FvZ1ZXRXZx?=
 =?iso-2022-jp?B?ckdKTUlMM2NsWWJuVVNtQ3RHd1ZQK2s0OUZCTDlPS3c3MTRmWjNTTnZw?=
 =?iso-2022-jp?B?MW5BSFQ5Mi9Da3NoSzg5a0lVd0ZBQ01rQmFTMTVieU1XaFZES21pSUo2?=
 =?iso-2022-jp?B?MlU5TWdTL0ZEK05RWnhqQkd5K1ZjY2lPY0FxcEJ4R0NWODZVMnBHdnlR?=
 =?iso-2022-jp?B?VHI2MTZKY1drdXh6Ty82ZzVVRHFpRFg4SUM3VmNkZ0JTVFRSSERBN2dY?=
 =?iso-2022-jp?B?cXVXcWRwOVMvMm5zTWp5VHE3OUtFaGZFSkZMbGRENUdyS1JOQXNHTERi?=
 =?iso-2022-jp?B?ZjJmcjhIV1ljLzQzcGZ6TnRkdDVZNHF6VVlIb1hidktSWHJQS2llaDA1?=
 =?iso-2022-jp?B?T1Q3akRZY0lmdkN1VGNRUWlaZlZ0QVBQUUFiek55VjhlOTkzSWpEWkZB?=
 =?iso-2022-jp?B?dERoUjVLM3c1L3hwWnhBRHhCalZZV1hOWXFpZmpsQzFIK3RHTmRNejR4?=
 =?iso-2022-jp?B?QXpjZWhtY0pDTGtZY2VqVnVYbWkxenE1dEo4L2ZLaCtGN0JlWHNTRVEx?=
 =?iso-2022-jp?B?WUkxamZOWU9BeHR2RXZuSld1Q0IrRW96Vjh2UUw3TlNIVkpKVVRIc2wz?=
 =?iso-2022-jp?B?QWFPSklsQWZLZllPTVgvdTRqakZsYkxiVS9RVDFIcDg0cCthdTJSZXNB?=
 =?iso-2022-jp?B?b29NeHl2UFJUQWJNd0ZEM3E5aHVNVXByUFJpUVRmUzVLUGM2WGFZUEw2?=
 =?iso-2022-jp?B?S25iUUZEKytQZ2hFQzdqTG9nRHh3Qk55THJTUHYxUE9jSDQ4N2d5Z1Qy?=
 =?iso-2022-jp?B?ZVNHVm5VblliSkdjRURrKzlyeFlSQjBMcmFxbDhyMzc0VjEzQlV0R1Az?=
 =?iso-2022-jp?B?d3BUMlk1ZzNCSTZkYkFGUytTN0tIc0p2TTNKcityRlZta0V0UzFPZVR0?=
 =?iso-2022-jp?B?VzArOU1KWW83UkU1RTMzSGlpTTMvOVBrYlAzbEw4citrZW1SRTgySk90?=
 =?iso-2022-jp?B?c1d5TVhvZHNHTkxwOVMyM09USFNGSHVIUkNRWmt5RUlMaGcrcUNVOXVF?=
 =?iso-2022-jp?B?UlUyZWVWQ3QxVnN0WHh0VlM0eDFwNWIwRTFkZVVvTWNkNzJnU0JWRzhP?=
 =?iso-2022-jp?B?N1ZYelZvVzFzcjV4TnA5Nnh1Z2N4NGhESkZtNHVodWxFWEJDeGEyY25y?=
 =?iso-2022-jp?B?bVNqUDhLWitIMTc2N0lBaVdkaDcxN0tnbjlybk0vNWN2SnVubjA4Z01H?=
 =?iso-2022-jp?B?WlRLY1pxQVROV2pWVzhySDJFbzF4N2xGeHUvTlh1UDNFM1JjNzZQUTR1?=
 =?iso-2022-jp?B?UEtjdzhOM2t0RUNVanEwYUFocFQvZWdJUEhHU01hSFR4RXFpZS95WUQv?=
 =?iso-2022-jp?B?Z21MRk9PUDI5V05ZYXUwUHNERTY2Mm9DNXM5eXltOGJ3QkVnQ2J0ZWlj?=
 =?iso-2022-jp?B?cmpVelRuZTJUWmloVFlrNHM3K3ZLbmdrak83QkNCTlhLdndXTUgrTUJF?=
 =?iso-2022-jp?B?YXlNQlhrNzllYkpsejhPeDhaNURnSjZrdkl6MWJ2OHZ2NG1TNVBTc3JT?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <42D53C659E36DD4CB215CA309F77891F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbac61ce-1b65-4fc2-d9c5-08d945cf1308
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 07:23:12.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdKNABqiEoWtipHTNqGDRATRbRArRnA5GPKvoEHrUNfDbBp7Fp2rMtpvlxydi0u3SvZGV8tSpFmzsqs3McMaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5796
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix below division by zero warning:
- Added an if statement because buswidth can be zero, resulting in division=
 by zero.
- The modified code was based on another driver (atmel-quadspi).

[    0.795337] Division by zero in kernel.
[    0.797878] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-xxx-xxxx+ #=
1
[    0.803782] Hardware name: Altera SOCFPGA
[    0.806481] Backtrace:
[    0.807628] [<807fd2b0>] (dump_backtrace) from [<807fd554>] (show_stack+=
0x20/0x24)
[    0.813899]  r7:00000000 r6:60000013 r5:00000000 r4:80de1db8
[    0.818239] [<807fd534>] (show_stack) from [<80800e84>] (dump_stack+0xa8=
/0xc8)
[    0.824147] [<80800ddc>] (dump_stack) from [<807fd430>] (__div0+0x24/0x2=
8)
[    0.829712]  r7:00000000 r6:812edac0 r5:812edac0 r4:810ff9b0
[    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
[    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_=
exec_op+0x3b0/0x3f8)
[    0.846230]  r10:81d45c00 r9:812ed800 r8:812ed800 r7:810fe000 r6:81d47bc=
0 r5:810ff9b0
[    0.852731]  r4:00000000
[    0.853958] [<805ed79c>] (spi_mem_exec_op) from [<805df090>] (spi_nor_re=
ad_id+0x88/0x178)
[    0.860827]  r10:81d45c00 r9:0000000f r8:80946d4c r7:81c32040 r6:80946f3=
8 r5:81d45d20
[    0.867328]  r4:81d47bc0
[    0.868556] [<805df008>] (spi_nor_read_id) from [<805e00cc>] (spi_nor_sc=
an+0x920/0xa80)
[    0.875247]  r10:81d45c00 r9:0000000f r8:80946d4c r7:80946d78 r6:80946f3=
8 r5:81d45d20
[    0.881748]  r4:81d41c40
[    0.882976] [<805df7ac>] (spi_nor_scan) from [<805e1388>] (spi_nor_probe=
+0xac/0x2d8)
[    0.889409]  r10:00000000 r9:80dee720 r8:00000000 r7:810fe000 r6:81d45c0=
0 r5:81d45d20
[    0.895910]  r4:81d41c40
[    0.897138] [<805e12dc>] (spi_nor_probe) from [<805ed198>] (spi_mem_prob=
e+0x94/0xa0)
[    0.903571]  r8:00000001 r7:812ed800 r6:80dee720 r5:81d47bc0 r4:81d45c00
[    0.908947] [<805ed104>] (spi_mem_probe) from [<805e6934>] (spi_probe+0x=
78/0x8c)
[    0.915030]  r7:80ea6844 r6:80dee710 r5:81d45c00 r4:00000000
[    0.919368] [<805e68bc>] (spi_probe) from [<805894c4>] (really_probe+0xf=
4/0x4b0)
[    0.925458]  r7:80ea6844 r6:00000000 r5:80ea683c r4:81d45c00
[    0.929796] [<805893d0>] (really_probe) from [<80589de8>] (__device_atta=
ch_driver+0x114/0x144)
[    0.937095]  r10:00000000 r9:80ea6814 r8:00000001 r7:81d45c00 r6:810ffba=
c r5:80dee720
[    0.943596]  r4:00000001
[    0.944824] [<80589cd4>] (__device_attach_driver) from [<805872e4>] (bus=
_for_each_drv+0x94/0xd8)
[    0.952294]  r7:80589cd4 r6:810fe000 r5:810ffbac r4:00000000
[    0.956633] [<80587250>] (bus_for_each_drv) from [<80589a74>] (__device_=
attach+0x104/0x15c)
[    0.963669]  r7:812ed800 r6:81d45c44 r5:810fe000 r4:81d45c00
[    0.968008] [<80589970>] (__device_attach) from [<80589e34>] (device_ini=
tial_probe+0x1c/0x20)
[    0.975219]  r8:00000000 r7:812ed800 r6:81d45c00 r5:80dee7cc r4:81d45c00
[    0.980595] [<80589e18>] (device_initial_probe) from [<8058855c>] (bus_p=
robe_device+0x94/0x9c)
[    0.987888] [<805884c8>] (bus_probe_device) from [<80584fd4>] (device_ad=
d+0x318/0x7cc)
[    0.994491]  r7:812ed800 r6:810fe000 r5:00000000 r4:81d45c00
[    0.998830] [<80584cbc>] (device_add) from [<805eab2c>] (spi_add_device+=
0xc0/0x16c)
[    1.005175]  r10:0000010a r9:00000001 r8:00000000 r7:8122c210 r6:812ed80=
0 r5:81d45c00
[    1.011675]  r4:00000000
[    1.012903] [<805eaa6c>] (spi_add_device) from [<805eaf34>] (of_register=
_spi_device+0x248/0x374)
[    1.020371]  r7:812ed800 r6:810fe000 r5:9fbf25e8 r4:81d45c00
[    1.024709] [<805eacec>] (of_register_spi_device) from [<805eb748>] (spi=
_register_controller+0x6e8/0x870)
[    1.032956]  r9:80dee8b0 r8:80a2f8f8 r7:9fbf264c r6:9fbf25e8 r5:00000000=
 r4:812ed800
[    1.039369] [<805eb060>] (spi_register_controller) from [<805eb914>] (de=
vm_spi_register_controller+0x44/0x7c)
[    1.047963]  r10:80a237d8 r9:80a300ac r8:8122c210 r7:8122c210 r6:812ed80=
0 r5:00000000
[    1.054463]  r4:81d47a40
[    1.055690] [<805eb8d0>] (devm_spi_register_controller) from [<805f044c>=
] (cqspi_probe+0x648/0x90c)
[    1.063418]  r7:00000000 r6:00000000 r5:00000000 r4:812edac0
[    1.067757] [<805efe04>] (cqspi_probe) from [<8058baec>] (platform_probe=
+0x58/0x9c)
[    1.074103]  r10:00000000 r9:80def484 r8:00000000 r7:80ea6844 r6:0000000=
0 r5:80def484
[    1.080604]  r4:8122c210
[    1.081832] [<8058ba94>] (platform_probe) from [<805894c4>] (really_prob=
e+0xf4/0x4b0)
[    1.088346]  r5:80ea683c r4:8122c210
[    1.090610] [<805893d0>] (really_probe) from [<80589f2c>] (device_driver=
_attach+0xf4/0x104)
[    1.097649]  r10:80e13000 r9:80b35854 r8:00000000 r7:8122c254 r6:80def48=
4 r5:00000000
[    1.104150]  r4:8122c210
[    1.105377] [<80589e38>] (device_driver_attach) from [<80589fcc>] (__dri=
ver_attach+0x90/0x120)
[    1.112675]  r7:00000000 r6:8122c210 r5:80def484 r4:00000000
[    1.117014] [<80589f3c>] (__driver_attach) from [<80587210>] (bus_for_ea=
ch_dev+0x88/0xc8)
[    1.123878]  r7:00000000 r6:810fe000 r5:80589f3c r4:80def484
[    1.128217] [<80587188>] (bus_for_each_dev) from [<80588d9c>] (driver_at=
tach+0x2c/0x30)
[    1.134907]  r7:80de8b20 r6:00000000 r5:81d47580 r4:80def484
[    1.139246] [<80588d70>] (driver_attach) from [<80588774>] (bus_add_driv=
er+0x108/0x1f0)
[    1.145934] [<8058866c>] (bus_add_driver) from [<8058a6ec>] (driver_regi=
ster+0x9c/0x134)
[    1.152712]  r7:ffffe000 r6:80b22718 r5:00000000 r4:80def484
[    1.157050] [<8058a650>] (driver_register) from [<8058b810>] (__platform=
_driver_register+0x2c/0x34)
[    1.164776]  r5:80e07c60 r4:810fe000
[    1.167040] [<8058b7e4>] (__platform_driver_register) from [<80b2273c>] =
(cqspi_platform_driver_init+0x24/0x28)
[    1.175721] [<80b22718>] (cqspi_platform_driver_init) from [<80102414>] =
(do_one_initcall+0x60/0x2cc)
[    1.183535] [<801023b4>] (do_one_initcall) from [<80b01278>] (kernel_ini=
t_freeable+0x26c/0x2dc)
[    1.190924]  r8:80e07c60 r7:811d0240 r6:80b35834 r5:00000007 r4:80b59980
[    1.196300] [<80b0100c>] (kernel_init_freeable) from [<80806518>] (kerne=
l_init+0x18/0x130)
[    1.203257]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:0000000=
0 r5:80806500
[    1.209758]  r4:00000000
[    1.210986] [<80806500>] (kernel_init) from [<801000fc>] (ret_from_fork+=
0x14/0x38)
[    1.217239] Exception stack(0x810fffb0 to 0x810ffff8)
[    1.220979] ffa0:                                     00000000 00000000 =
00000000 00000000
[    1.227831] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    1.234680] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.239973]  r5:80806500 r4:00000000

Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
---
  drivers/spi/spi-cadence-quadspi.c | 10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 7a00346ff9b9..13d1f0ce618e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -307,11 +307,13 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_fla=
sh_pdata *f_pdata)
 =20
  static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dt=
r)
  {
-	unsigned int dummy_clk;
+	unsigned int dummy_clk =3D 0;
 =20
-	dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
-	if (dtr)
-		dummy_clk /=3D 2;
+	if (op->dummy.buswidth && op->dummy.nbytes) {
+		dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
+		if (dtr)
+			dummy_clk /=3D 2;
+	}
 =20
  	return dummy_clk;
  }
--=20
2.32.0
