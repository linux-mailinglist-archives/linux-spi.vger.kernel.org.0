Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5663C7B81
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhGNCNo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 22:13:44 -0400
Received: from mail-eopbgr1410040.outbound.protection.outlook.com ([40.107.141.40]:38432
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237428AbhGNCNo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 22:13:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXAgmMh4tSX/HmwEx4rpLL8fXrK33oZkbDAsyz+/XjVCeRvCtAqFBYo0zxyG6/hLPFto+zOAaByA+jtCDgg4dug8qYflkVjsZl57YvQgQoHTFLsGS6bJ5NDJVjCkMvj2Cr9I2LYCercJAoMAY2oT/rnzMWWFUUozyEr3c9S8dYCtlU2UHC5pjh3JVSQPE/exv/C6588Y4WMYCa69SeHSwWBbb8S6h5QSFWst9d6C5cfw1J4azJywldLm1/SGtJXuSs5UeCA1VuLhIvpBpq8pY9YRbcu+9k8HB0kd4dZ1aHkvUwJmiQsHz40CAQLIjYgstnjVJmXXNXc51aBoCEIRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHu5684tbo3QljJKA3WRY6reqYQr9g0KWWzb1BtjPkQ=;
 b=l4C9lIWt/6LgN64s8bf4A5Zmh1oCIXg8Zzrt2hkgvzjlrkP2siLVscxd8Q6QR/5xeDkIvNHMcYty7zE7mgdEaHhZlTf3Q3jEHJemKjOMkypANUE7z8+1Su8kZ/7cYP+qWHgh1DqjIlfJBsZNfLyiAilX2MtA9brSrKx0YNLa0tFVbxR/wCWVrtriXuVhsoexxaWFxEUxFgy0qHr8aOi/3WqbgPVvcT4N+LTnhY0VN9ySE5QGA5F/QrWFPiyhT4g/MkBtRitsvDA0g12MrZ8HTx69tLVvAL7wirmNCn5/XXOcSYQWHVWWZj19zUCeY0Z0Uc/o17bgWWrIfT+SXT0zAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHu5684tbo3QljJKA3WRY6reqYQr9g0KWWzb1BtjPkQ=;
 b=fLxEVofP6iyuT3d4K9Lgbur50D2ZamxGIhScwc1JQfeKyOgnj3Gvhm9peGRIMuE60rlvzPojhIE9X0nIG575Rdz5e96Kse6A8FqNubiJAGdm8yNkcJNM+PgH3y+ez9yyXtn0+uvua9GAKBJyVlHJpzj8xBqGkBawxhpccTkiw1M=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSAPR01MB2868.jpnprd01.prod.outlook.com (2603:1096:604:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 02:10:51 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 02:10:51 +0000
From:   =?iso-2022-jp?B?GyRCQ1NFRBsoQiAbJEI1QU40GyhC?= <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     =?iso-2022-jp?B?GyRCQ1NFRBsoQiAbJEI1QU40GyhC?= <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        =?iso-2022-jp?B?GyRCP2VDKxsoQiAbJEIybU01GyhC?= 
        <m.mizutani@nskint.co.jp>,
        =?iso-2022-jp?B?GyRCXFQ+PhsoQiAbJEI4JhsoQg==?= 
        <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Index: AQHXd7fwKzEQWTvWzEqH2Qm18vEKNatA1OMAgADmmQA=
Date:   Wed, 14 Jul 2021 02:10:51 +0000
Message-ID: <3b9745c1-ec32-793f-41c2-98c9f60057cc@nskint.co.jp>
References: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
 <20210713122528.GB4098@sirena.org.uk>
In-Reply-To: <20210713122528.GB4098@sirena.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55bfe9d1-0934-4341-def5-08d9466c9ac8
x-ms-traffictypediagnostic: OSAPR01MB2868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB286831E104AC3C7ED58BFF038B139@OSAPR01MB2868.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgG9hTh6gDGm8c6xJM+cA2OENjwOH1g1rohGOYBMQ2qzZvlgQEATxWzC28/Ut3A1EQ3QrA60BnNrmDfrWHbhFnuQB+Kk52mvb9t8pOE4V6cQjB3ebyDhf/PByiy/YELbvcjmv6uRUCO7DAQxUcNu0ICZ7in6YjKdcjp6tTXw6X9lsXRiJmIx2cZjY1p2auXP4vKRL22K5mh0JghGps2txL4LK0C77SFbdAtqRk8tpg/eZCpJ4+KXYOufldr4fzwsaRtqQjzNkvV4ewv4EI12OMDuvRzReQBt1m0RkZB0LGUDQWysr1NIfnX40ewYJpTN4iEghJZVBHIYLpX5pj3H5Ch06q/Uf5jnAtrotgWIWo1NVlizYcL1N5SIp+6KM1UoQVE6G8fw7an+W46KSMZLQKgiM/vo4kvcdyNeIdCav6bKgcKrtW24SNyDfIOdb3WLghp2RfALPauH7/zH14q0a+mSr8b6K3iH9M6zA81SLo+8XFg/2rx01l6E6U3mhfnoPcc+i7JxJ2Utx23hCd8Q1YrcgRLcT6SkA73NWUSzJPGBAbyt1H1MOBvBTgHaYvpVGxA8EIb/gQj6PKI5g4ZLytK9JihTkji8gjbxuoC0yxUIpu+Wd307uVPXMD5WRmjwLYsO1nUC8/ryuewCdeiCrFOWhfHqjcjgF7Kk5cxGbgqygHvn0i55WbJ2FAPHStyqbU0mfUNn/ftOiuoloDMEjE65ZjBn74X5FPyxPWg+pDFZzP4xTyH47f2PBzACW1M+iEMYo/obgolLlIp44NS0Ifw92eJc8+rJ9DZm3W2batE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39830400003)(31696002)(2616005)(76116006)(107886003)(8936002)(66946007)(2906002)(83380400001)(66476007)(316002)(66556008)(66446008)(186003)(64756008)(8676002)(31686004)(26005)(36756003)(478600001)(38100700002)(122000001)(6512007)(6916009)(6506007)(53546011)(4326008)(5660300002)(85182001)(86362001)(54906003)(6486002)(71200400001)(21314003)(38070700004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dUdpV3pWU0N2S3doSFZ3WDJuNVFNTVF5TWEwczA1bkZvZFJvaytpbEtU?=
 =?iso-2022-jp?B?Vlp0UmxDVGNXb0hwYWxaSVNxMlliN3BKbG1FeGRCQ0taVitvUEtxdWFV?=
 =?iso-2022-jp?B?QnVDdW81NC9paThTM2FxQ3A0SWwwQ3pSeVMwejJ0UmI3N0xtaElqblVw?=
 =?iso-2022-jp?B?SDYxSVZLRFh6bi9ud0xQeFFxcGpFaWdDNG11ckIvd3EwUjRSdU1XY3dN?=
 =?iso-2022-jp?B?NnN6NnljVHh2c041U3ZIZ3hYQXd6WTNOS29iMzlUdW1hTHBBSHpyemVT?=
 =?iso-2022-jp?B?bHVLVTBSVzdOSlVCOTJWY0dqZHdIQkhRQ2dHbVpOOVBIOFdrMUlFb0Nn?=
 =?iso-2022-jp?B?ZDhuMStRTG1JVk9HcktwQVpHRHBMRHBWUklSbW5nWnJnZTV3amUzdW1Q?=
 =?iso-2022-jp?B?dU9RVjFraGlEeTFpUStYc2lPaEQzY2o2cFFwZnlFM0liTzcyMHo1OGFI?=
 =?iso-2022-jp?B?ekwwVkNMR0llQVFodVR1SlBoSnlYZUM2MWZIaVE2dkVkeXBIaEpDalNh?=
 =?iso-2022-jp?B?dlNoaDVzWDdMbG5BMzBiYjIzUktIdUtqb2o2SHpVU1Mxd0pDMzUyM043?=
 =?iso-2022-jp?B?bEFNOWlvZ2x5K3RCM1hmdmdxVFVSdnBvcUhEYTFPSHNqei9xcktoYW9U?=
 =?iso-2022-jp?B?a2tlS0NVMXprS0Y2RnhOYVJYdTlocVZHbFd6TkI1M2Z5VnFXcUkxdVkv?=
 =?iso-2022-jp?B?SjU1ZFRtYjlHSHBuMzJjdGd2WjF4bWNyUTczbFZlWmlvR0lmdTFXUThU?=
 =?iso-2022-jp?B?blg5RGVQYWVIUXl2RE00RnNNN05Rb2VxYnd5Y2xuSVhWVlV4MUk2QXVL?=
 =?iso-2022-jp?B?cjNxRVRFelBOaXdRZ01iMW85RG5IS29kSjZuUWFhM0FXaU5QcFJmQ3Zw?=
 =?iso-2022-jp?B?WS9kN3R6ay9PZXNUYjBQcE0xL2FiS3Z1YnpBQ2h1MTEwRkdDdU45d1pj?=
 =?iso-2022-jp?B?MkNwalNzVFQ0OG55SCtLWHk3MmdWRHFXSC82eFo1TWsrSnhmU1FRSW5J?=
 =?iso-2022-jp?B?K0M4T0NPZ0psSmJUQi81NTJyZlRlbko0MExGWG5qZTJ6VHBudXVnU2dY?=
 =?iso-2022-jp?B?ZTVMMjRuaTdUQnVZTEI5NGlSdzNpNjRzblA2cWxzQW41M1ZYREM5eSt6?=
 =?iso-2022-jp?B?MWxoaWVlT1ZXMmdqb3lGZWFOa1AxSXF2b1lyMlh5QlNwdy9WWmJhRXA2?=
 =?iso-2022-jp?B?TS9BL1oyZ2wwMUorY01FVmpTSXdBa0s4S29uVTVrUXFWQWtOeTdXNGN0?=
 =?iso-2022-jp?B?TlJQUDVXNFN0VXhsZUZMV0dVREp0Z0t0RkZPMkcxcks1OWJ1dUZnMm4r?=
 =?iso-2022-jp?B?ZkR0NFVnWUpJazhGb1VISEx2OCs3eVV4RG4wcE1hSk0za1cyNGdQdFFF?=
 =?iso-2022-jp?B?d0V6YVdYK3l1dmNzSWlxMGlsa2J6bEZ1Y2UvZHk2RlZPWGZPbDdrZUg0?=
 =?iso-2022-jp?B?NzBBbHZjVFlJTGVvNUJxTmhiVUJKZUtQM0YzWFdpSDVYZDdzdjFGajJ3?=
 =?iso-2022-jp?B?dW1RSGQ4eXN5Um1USkZZdFZsZG5CZGFoQVVVSk8wWmhudWZ2M3pNSnd5?=
 =?iso-2022-jp?B?T1oyRkg2REw0bldoeGQ5cjFxSFNUR2VFNjlxUC9jZ1JBSUlCYmZWTkNw?=
 =?iso-2022-jp?B?aWRndW82ekM5VzBUejU3aGVHOStIZFlFVHBkcExhdTV4bmY3MUQ2M3Z0?=
 =?iso-2022-jp?B?TlZhSURua0NjMWpkQ2Y4RE9ON3g4a0pQS2JYazVkUWJGY2JONWZaS2o5?=
 =?iso-2022-jp?B?VXZIeENLN3hSV1B0cFYwWkw3RTVvU0pib1YvbHpoaThSZTRlN2prdGoz?=
 =?iso-2022-jp?B?QXk4Q1dzK2xXNEdrR24wNktMenZLSW02MzFRVWR6ZzlsZzJmRElRVlVR?=
 =?iso-2022-jp?B?N2oranBRRXlhNHVtUGk5SHIwSUN5T2htUXAyaW03YXNYU3NmT0ZkQjd2?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4831677C6594BA4C8BD4893DB488749F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bfe9d1-0934-4341-def5-08d9466c9ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 02:10:51.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP4O9EO3oZ/QLvaKvT35C2NoROqjPGePg+ZitjnT4RrthmEFehBLJWscF5TF1yKUIwY5G/Jh+3K9WpAgWlXHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2868
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/07/13 21:25, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 07:23:12AM +0000, Yoshitaka Ikeda wrote:
>> Fix below division by zero warning:
>> - Added an if statement because buswidth can be zero, resulting in divis=
ion by zero.
>> - The modified code was based on another driver (atmel-quadspi).
>>
>> [    0.795337] Division by zero in kernel.
>> [    0.797878] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-xxx-xxxx=
+ #1
>> [    0.803782] Hardware name: Altera SOCFPGA
>> [    0.806481] Backtrace:
>> [    0.807628] [<807fd2b0>] (dump_backtrace) from [<807fd554>] (show_sta=
ck+0x20/0x24)
>=20
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Thanks for the reply.

Indeed, I too think that the tracing part should be limited to the useful r=
ange.
I would like to modify the tracing part as follows and repost it.
Do you think I should narrow it down further or do you think it is too narr=
ow? Or unnecessary?

[    0.795337] Division by zero in kernel.
  :
[    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
[    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_=
exec_op+0x3b0/0x3f8)
