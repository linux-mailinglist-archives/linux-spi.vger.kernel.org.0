Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EEA3CA227
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhGOQVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 12:21:23 -0400
Received: from mail-eopbgr1400081.outbound.protection.outlook.com ([40.107.140.81]:19088
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231143AbhGOQVW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 12:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDZV3TVbyVXzTPIs7plXmcuDkzfcaGAfgkaxYprA+NUfs4rPNXvhHeDtbjmKIoyJVyWuDq53iv6ozon8bGJRo42yfAVkYydbK48oKyHSc6RMyEjEyrFgaDAiclsWaSM5cnvtbl9xSMIE8T2tHDB5mH2kin0uT6HgEruYTtMl3RILAMlcPDl+fyuRDsoF2yl9KMRMGR1NlPWA2QqnRrsioEaV4CXr5iric8H7/uR/RjIQt53Xbm6+C+7ru7/BP26M770Rl9nMHHgz2INwtCWWW+wTkeNSSnMvIYyVP+1MVODY39ZVVgSglRv7vzIifm6eCeICCGZIJcIi9iVi6qfMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR0l49O93NDMJMWS/G5zEOj4jSFo/czuzFsxM8bc7dY=;
 b=Chd2jXSySHnQEP0nJGLRTvDM3gw2T750eJxULLcZ4xrEtA84HQ7PeQ7QXQXdO1UXETBxbHlMs5TcDQ4VhK/4cYEkCzVabt8nSKCmx8Ow4XeE+uKYgnUTu1DR3dl7lxlrnDuboVIfsWLJUA0OSkX2ix3ehHT+04Z0xtKja1QsvXIeB9rxRPwy38/INrxy1196QuDZzOLBjk9IGHwV8AUgoL7ELgpTnne3UGDyVq62ZSLZDNlh3qv/Xmu6Vv+XNZB8mNXouhesBiezRcrqV0Vih5VwvtWsxEOGQG0qd63oHHPNYNQj5VYXeU8qq3TvJ/EubWqZPnX2zPhtqXooL0h/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR0l49O93NDMJMWS/G5zEOj4jSFo/czuzFsxM8bc7dY=;
 b=GVZlXwWsYWPeUWMNvtEICiNUnPQYSZa/1NvBv5kzkYgJuTD7wObGdBYPccYMcqs/DACMnqbqOZV6o8nPshwqQ6bzpoVW4Gy9y5ylhsGwnWDcPsT0eqtYXL2LeaDnjlU1nfwOZuTM+qy1oUKj/EvVWMiHUBo9xiT9yvKX7qhTeIg=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSZPR01MB6566.jpnprd01.prod.outlook.com (2603:1096:604:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 16:18:26 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 16:18:26 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXeRLRq9j2aM/2WUWyoM0xh6yPG6tD9nMAgABBeoA=
Date:   Thu, 15 Jul 2021 16:18:26 +0000
Message-ID: <2e432b44-9153-7dea-8403-52cf7217cdca@nskint.co.jp>
References: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
 <20210715122404.GA12949@sirena.org.uk>
In-Reply-To: <20210715122404.GA12949@sirena.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cbb58d-175b-4f0e-1353-08d947ac2d2a
x-ms-traffictypediagnostic: OSZPR01MB6566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB65661EF485F7CBED155F92248B129@OSZPR01MB6566.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1Dk0ypBrsvBWZn8u9xFXr6qYJjNep7ZJL9+w1La4DDWnvsmx3g4gPm5wRCfWe5KB1FroaEzrCSPv7tHonK9N4bBorixE7F3VsVNlmPK/1FRrift9pYOwlg1cmZsdo/4cmqpmF8bs5yW2R3FNQbqda56t/tKqdTUy7NWJ04Zv5RJOLy20XVONHo+tu/9ToEWgoB6Z+nTuoqTYe+xffgHBkhpVJz4Kfx7RvRVPKHOL27b5RyCxp1at+Ygc+CMrtkGbtBwLewUS8eb7NOFLRsMufnpZsUlccKvjanGhLC4tkj5VSePPv87n+EzAkC6jTYNc7nYx9abNSvR33WeTKw7fdW3Ma0w4fHBFpvN9aiMzCboOZgliIBjuybnI27lWqwrFFu0AZ+qy8eymVwLgIQv8RPEV09jmJHaV9cVv6Bfo8/HjUSrEnjblTBNkJh4Yo+SDxT4MXI+KONEq2rjWeBHs6IYDcK0KQWFk2SEdUqVyfNPg4gOFlUAFHEQDAIWoIZw92mxSLDy/BxF9YGbWYVfGQKymh7fHQmgc5RTFlNNe7tmst3an1C39iCianG3jQrsBPNpHRvljVcKxRimf7TzVJM1WfARmqWW6SOKLz+eQUU+rX5GYpJGhCQMcrKh30lTOghjH1g4OKpVyAx66LhFQTf8EGpMSWQrlTXQ5W9cRwfKIS4Y48Dwd4VhQGO5+dd8Mj255dyELEY91bI+VoanwUuNVvMbNvknk5nxmZOzeygHzYsNR0SfaT+mbIFrMRbX/gwd4Xb1GpWfIv5fCkk06g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39830400003)(366004)(346002)(396003)(38100700002)(122000001)(71200400001)(558084003)(186003)(54906003)(6506007)(64756008)(76116006)(66946007)(26005)(53546011)(31686004)(478600001)(316002)(66446008)(66556008)(6916009)(2906002)(31696002)(2616005)(86362001)(66476007)(8676002)(6512007)(4326008)(5660300002)(36756003)(107886003)(6486002)(8936002)(43740500002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K0l4cERzVVNMTXNITUMxWWpvNDNFeVN6dHBYLzhiQ04xTFVzNjkzU0Zz?=
 =?iso-2022-jp?B?T0ttNFozclE0aE5uMlNOQWp6RFB0RlJUSnpNQzRwOWJDY0FqSG5OVFNX?=
 =?iso-2022-jp?B?OWJncHNSRDd6RTA0N2FuQnN5eVNjSHcyOVBYU1I5a3I1N09kUENlLzhQ?=
 =?iso-2022-jp?B?UEk4cHVPUmlJWm80ejVGR25LM1lWdVh0N1N4ZFRZRGcrS1AzL0w1T3Fi?=
 =?iso-2022-jp?B?RmNSYWRGZ2NuVUZSS0xZaGpBaU9TdC9EcnhxWkU4bVhZYVJlVlhZbDNi?=
 =?iso-2022-jp?B?NkJmVFdBOVBvY0tQTUYrbHN0dWhBSmFuWmdjeUlXdzJnOGJJVXhXTUhX?=
 =?iso-2022-jp?B?NisrLzExVHhmNk9RaVliV0kxR2lhTlZ5VXRVMk5rOGpQTCsxcTRnZWV1?=
 =?iso-2022-jp?B?bzRZMG9mOHpmMmRVbmthcElOKy96UTlKUXZ1aUpJYUZvSk1GYWpJMm9C?=
 =?iso-2022-jp?B?bHZUTVFIUnZDVEc0SklLdkU1OVlrRG9SeHI1Y0E1YzRPeTZHTmpsWllI?=
 =?iso-2022-jp?B?S1I2YjdGRzZpM3BFemU2RXVBOXdwZUZ2U2llbTYyQjRkeWttYmJxVTFQ?=
 =?iso-2022-jp?B?UE9Cc3pHOWliaTMzVGZlNSt1a0pmMnhBdkhwUEptdU5uNnh5WVdhQ0Yz?=
 =?iso-2022-jp?B?djRpUEVTT01lRU1veDFLdUthNTZqYzMzK3JGV2lUdzBYZk9wTUFnRzhN?=
 =?iso-2022-jp?B?MWVHclhPeDJVRjU0N2l4WVcxb09KbWZ6SUFOZjM2dDN1UEp5QTUzUzJS?=
 =?iso-2022-jp?B?Q3ZzTlY2TnI2TXBoWUQvcytNaDNiR0huMEtwb05yVUNScWlFakh0RDAz?=
 =?iso-2022-jp?B?S3NvYXZ5UGxCMzNjMGprNmJOWXROTG1KSTFEU21LOENNaUpHeFFKazBD?=
 =?iso-2022-jp?B?dytRaUdpOHlsdUZud1hsSkk3TE5rTW5HUmpZSWhSTERZS0hjS2VJc2l4?=
 =?iso-2022-jp?B?UFlnTHJNdWM2WXNYV1FwTENyUGhYdXVrbTdDRmJOWjBXbXJ6djBoUjNT?=
 =?iso-2022-jp?B?cFZldGprOTFYNWxtNlNZekdHNURnZFhHOEdhMDJsNTEyK3Blbi9MV1RQ?=
 =?iso-2022-jp?B?RUhZUFJadmhyRmVxa0djaU1iSjM1YVZ6cEZQNitZZ254VXBTcmduR2c0?=
 =?iso-2022-jp?B?UTg5SUZ6RTB3WWpYNENFWkxXV09ZM1ZaYk9XalhwTFdnN0NwS1MxNGV6?=
 =?iso-2022-jp?B?dU01cmp1TW1WeThPRm00bTBWVnMyek9yM0c2SmhMRHRWOUswZFJHZmxo?=
 =?iso-2022-jp?B?cUplZXFPVi91OXE4aGFueWZJbm9Vb2twMTNsbnlHVytMeGlTYWVKZjQw?=
 =?iso-2022-jp?B?ZjFNVkRoZlViMVMzd0QyYWY3RzJkNXRuS0dab3RUNkdpemJHM1FGVEdP?=
 =?iso-2022-jp?B?Y2x5WXBPamw0WWlIeU9Md3FadEJlVFgwdFptUm81V0hmcW9POW8rR2p5?=
 =?iso-2022-jp?B?ZEVITE5FQTFRUk5SSHRibCtoRTh4SFNHc2hiV295NzJnb05pSGZ5MVhR?=
 =?iso-2022-jp?B?czZFUFl3UmQ5TnhZa3h0a2xPU1N0NW9NUDRadTZJbkU0QUs5WW9Vc203?=
 =?iso-2022-jp?B?RzZoNEoxQWdQWnpuOHJOaCtSbEwyZUVsMEJ1R1pURWNQa2Y1R0xuam54?=
 =?iso-2022-jp?B?RURMRXhhRTNmTERwOW5nN09xdFhMNkJjaWo0QmxObEtyNjdudUx2c0Fm?=
 =?iso-2022-jp?B?MlJJN3IvY0Z6RW1MZW5ac2NUOGJuS1l0M05BaUJsWkdZSDBqOWhkZHBU?=
 =?iso-2022-jp?B?MnlNTC9KRmo1ckpsTzcwN1VRTW11ekdVT0d5MEZaLzRZU2JXSEpGSmtw?=
 =?iso-2022-jp?B?WitQSngzRlh0NExxWEEzVWpvQnk4TG54QlpnS2JmOTVWVTBjZSs3U3gy?=
 =?iso-2022-jp?B?S3creEJKZkJDbHh2bGZpU2pRT1Arcnh2bXU5MGpKeG1rK2o0Q3RiM1hF?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DDD3D0D09A21B9439300A018B4E59971@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cbb58d-175b-4f0e-1353-08d947ac2d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 16:18:26.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDQ9i/Hi8TgeFxLLsRFFm8yAYlGDjjnhjq9kHWnirIe89yuGEjmGPj+TSqYW2GS57jUmb97hDkChgDtaxw4A9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6566
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/07/15 21:24, Mark Brown wrote:
> This doesn't apply against current code, please check and resend:

Sorry, the text was corrupted due to a setting in the mailer.
I will repost it later.
