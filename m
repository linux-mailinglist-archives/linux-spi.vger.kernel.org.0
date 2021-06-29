Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765A03B776C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhF2RxU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 13:53:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12983 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhF2RxR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 13:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624989049; x=1656525049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g0PiKqGVBSqaTZ7WZ77Xvi3q4EcmCR5NqaRydf8WHFQ=;
  b=c9kA6VB8l3LRwCqzy8IkFuvxOeuSQuqjgfU+s86hsfZZiusLuRR1KNh2
   2sXMG9xvWyYG4m1HWlwfhN3DYP6Es+LWtKrFK8D3D3HZQDMakJyHWFOF1
   O7/6V60GTvYwxDr52jatW/epDcw1bIvhyg78VboDGKW5e1c5lG2UC4lY4
   /2MmtzgBbQXrhcY+78xB5SSA6GaJAKtMR+1WWEkFDQArQfXiYedOr1rHF
   DwFreevH+CQAPG1ccF9Yc52BrE7XfErJIsDxugrprp+51Ryc1KGF9S6mn
   ikk+Bh9whaM+wv242CNC2WC7ELhpLoCnd4hPcuNfqcV7Cys/g9cLalZ0n
   Q==;
IronPort-SDR: J3M+42+h4DRfAU0RnTqA72xHPX318OpcaNxRHFgkdpfg0piLfHjVyXsHgUttBXlKdPOEWpkXrg
 CMiyULzAVdp/OMoTSYuV8GAsVhNaT9pJUW1AN3ZK/2Z6xOl01xLYhgNLaqKgApaEoqk2DhZlQm
 A8NvYmPkq+KspJIZqjNpiQFP5aqlF2RW4f1SAVk+7eKHhI+YOaFczgDytfECQrWZ+vTRkeOPUW
 D41Xoxh31uBamRR2Z9KkqJRMlB3Pggg46aBwDzmMq67sSAEsqhTk4EW+zS7eDSPLY8KiuV1X7s
 AyY=
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="120430740"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2021 10:50:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 10:50:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 29 Jun 2021 10:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0tVsCbfyjVcO+5N5NvaVKINVQEsRLxWrwZD4k6TrZmFaUUzrWY6Mg+7SVosXwIu6MbAInW9FRY64oSzKFF6CTd6QF7NgOSPf12LvvNIOtNNLnUPdtLnv2WZjNT+5NpFAfYM6LFMIu8PEeIgiRJidCkTTV83Ntx/MZCyV7RAZRB5QQ/dBE7HsNzBIZ8vQF/pj/jRrjhCsXit/GFt83F4qy/n0RzqFFmSUQlwI42WOwZKBONC11ddBNWsLekaWTMmwn0pNkJiWrqsjbBJ+R+Pf/Z7mftYwxSwWiJ+fAa/rgk1VU3y9V3qn4KebBFOGd61FsLnt3k0/tAHXXvEV+RXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JohjZLgkhaNvqMvbI6HYoyVHFoJ4jeQO/az0nefwraM=;
 b=UFGQ4CUFqIZHELG3Bc0+D4R0npXC+VY/wcjgM4aeeVSVZs5l3UdS4GAZ6+sxJaacJhxTANia3pJWDZwXW9uqvNfYS97NJsOOezp/mWXXnar2EDysCon9CO5kIFoFMoY99P1yvmajqV6FsArFbvrczo+nBBtVm0/jAMpP6AllbY00t/RXm+RwiyiMaTVi3jfBoce4m3cBdOHY+/y8Pk3L5G308+CT3lUl8iun0SXsdecTreYOrcHS1PQ3FjuE+iYzkxfA2SrYTGWSp12iZs3POLRwsK0pHH3TwcYnxot1llBDQ3mcxJWZJwG8TkTfFYG8vyXbp73yNgjQAAMFEg61GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JohjZLgkhaNvqMvbI6HYoyVHFoJ4jeQO/az0nefwraM=;
 b=ANegW3VXRjKcSKn2xdOp0u219hsyGIVQ9HY7vuQ/E6vBq+pFlzdVsPmGXuCQF2+z0QOQOwS+DSrLZR97oHTtA1DaesmATlpcNL7K9TpMCn/g6FbF1Ot4cwYVxgNTLAZBjdVfGZ+o74pO2+7rji0tY7LNLPtUWaOqBHn92b9dBdY=
Received: from BN6PR11MB4003.namprd11.prod.outlook.com (2603:10b6:405:7b::17)
 by BN6PR1101MB2097.namprd11.prod.outlook.com (2603:10b6:405:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 17:50:45 +0000
Received: from BN6PR11MB4003.namprd11.prod.outlook.com
 ([fe80::69e7:2972:2e57:3b8c]) by BN6PR11MB4003.namprd11.prod.outlook.com
 ([fe80::69e7:2972:2e57:3b8c%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 17:50:45 +0000
From:   <Dan.Sneddon@microchip.com>
To:     <broonie@kernel.org>, <Dan.Sneddon@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: Re: [PATCH] spi: atmel: Fix CS and initialization bug
Thread-Topic: Re: [PATCH] spi: atmel: Fix CS and initialization bug
Thread-Index: AQHXbQPwgV1WliYrJ0mjjxrwZijXiasrMuKAgAAEBACAAAGcgIAADAcA
Date:   Tue, 29 Jun 2021 17:50:45 +0000
Message-ID: <cb709000-7816-3817-b734-e03735788723@microchip.com>
References: <20210629162914.23286-1-dan.sneddon@microchip.com>
 <20210629164733.GE4613@sirena.org.uk>
 <c849eb7a-d019-b88e-583a-78e1eba7624c@microchip.com>
 <20210629170741.GF4613@sirena.org.uk>
In-Reply-To: <20210629170741.GF4613@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [198.175.253.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cdef14f-ff62-4611-6529-08d93b266be8
x-ms-traffictypediagnostic: BN6PR1101MB2097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2097A7D21CB8A06E625CE54AE1029@BN6PR1101MB2097.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMfCWMlAE1rmA3X+Z7a01R0n3FvpmdzCWmleen7pfR3Dwlw7eNJ3L2jgDFAMdFgZtP3gWAQvMYc+GPtjvyjPfTgIlEYqYBWSw78MZNlNQItc5T/cwUuRuFKLWA+JYXCjtn6i7ZcrPEer2KNXi1TLpt6Zhg+iASKlw8voSR94WNCsj+rZh1+bDZM1v5LeUPiVthSF9Jbn8Ml48izLEMdwTyrNjz8rFSpdiCC9Ccz5JFszXuovl5TGk/zK7diOH/qNxRUdZaN8dKn3MnQoXsum81iN9YB0u9kBaFAUDwKIyoUhsWzmcPOJ57Kughue5wSgF2vapBqOjT401yndqSDiQBBFQrdOVnVqlEFXmzJtTP7vdSqmjfkFMW5zUjw0P+undScXs8KEpMLJu7NLUTKWBGOoEEk9l+hny/utv3Ka71cqV9P72rQKaKySEbb3AD/A+j91emmCvESoFBFSc+9aboXV4YTFEz1F/SjvTMZb0aayOsCaOtaZsWg9eOOno1Ewkgg9KM3hCYkHj1eKvQX/twNZufdcS61UE/bhfGSRElcZ5uUifhVFdmM6B4MJaSQARMmBPpA39hb207J5Tbzwx558CT9fzhc+aYja0g02fOVRWzYJqCb5/94/mb+Tr2X+ZYCNy4au2i0E6KN2GjsrQynbRjdJ6eCCtErsdZ2+xGRXnwh6v0FVwxNDGFjpTyZVxBTBxlRQgYlEiJBuGPFxcZmBRZ+pMoxNRVmswCWN+Gd6e6+/yc+43q9P1d82vik/MWnbNi7SjMlQ3uAzBbggOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(2906002)(38100700002)(86362001)(36756003)(122000001)(53546011)(5660300002)(186003)(26005)(6506007)(83380400001)(6486002)(478600001)(6512007)(2616005)(31696002)(107886003)(66556008)(64756008)(110136005)(66446008)(8676002)(31686004)(71200400001)(8936002)(4326008)(54906003)(66946007)(66476007)(76116006)(316002)(91956017)(43740500002)(45980500001)(299355004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?v8ivgaPYJoanHvGV7WwzYPMJ58TFRJXZAY2QxERwK+J9PQf5XwUsh4Zg?=
 =?Windows-1252?Q?503j4tk/7iIjBTXJyV1WZ31M8RJyCtFmn9RtvurkRumJKPYeHvyZI0bi?=
 =?Windows-1252?Q?dW/bOL29LufQRUMYy+aBEuupVFHk45YI0Je6PXrhLTOLULHVRN5cF12R?=
 =?Windows-1252?Q?pCdAR7wq5N1fcRfiVgijSQHr1+wq/wEUzj9tIVe/aHGwdK98a7H+1ZS5?=
 =?Windows-1252?Q?EKNthdjLordOLivMzzeqvYozd6jBEpuupomksWXXKZakSf4LDCQNeFMG?=
 =?Windows-1252?Q?CPTMd9j/JtHx7z+fbWOQxM9fGT77iM9GRHMdg/fticu4X2Vai9rFmXoz?=
 =?Windows-1252?Q?ipHlRnx+Ym7RBq6cb3EFrTYj+v08jTva9kfCCnbrYPgAWmoYl0NBYtVg?=
 =?Windows-1252?Q?8DyK9DDpyS6Ds3u2PstrPfdZyQJoUx0Fh4Bhd3QM3De8nGLvcjApF7dT?=
 =?Windows-1252?Q?mH6SPwuKDpt3nKYClw9NgJyV/wwIPnq8jxxxpaCiePBRVakCOMxbfOxs?=
 =?Windows-1252?Q?wETELtCVyf0GjTpDMXvrKs3Z5+hZkv0zlYyuG0pCjEjAVDrPC0B1lEzo?=
 =?Windows-1252?Q?CvergDw/EWR+H0eLnk7+Z2WM+QIB20iJPCIEkvmyJObrzwM1nolhhCfb?=
 =?Windows-1252?Q?PlT/In0bcaOwit9s8zyrYVONcVcyEdZq23pY22UR6X7qs6pcPghmEhiN?=
 =?Windows-1252?Q?wmYALnsSPlyCpjGsAXE66pIMW1O9senskV6K8+syQfxC8fpn5VZrOP0A?=
 =?Windows-1252?Q?IE2daC0n/Vk/T3rzWmvWCnpTqsEq5VwDnyyCMnNfQMCQtF6yOA1Kgdo/?=
 =?Windows-1252?Q?t5EfVB1megEbhCAQSABRNr4Ia0LrHWAHOQ3e6/yDRCKMy9XE+26N9hi5?=
 =?Windows-1252?Q?vajNVKcGRsU51YPSQrnA8JhhMjWmcaUX3zRbrkgN3OkRvEIYxImF8yW5?=
 =?Windows-1252?Q?7DugsaT/D93m1pHvWz/1g81ACpHDsCLABl1LUi/kjROlXTCOUltko85Q?=
 =?Windows-1252?Q?4uyPngAGadtmzkY/vd/4lizT0d4slumgpE1mGytvED4KODGyJ0bjal9z?=
 =?Windows-1252?Q?rtWRdGLB3cUI753dY8OCxACLVKWnrEcYmxYhpogxIm2dcvj6lRyj9q3I?=
 =?Windows-1252?Q?s4YH+bFXLKvTaV8/ao/3vgFFksPnODi3McGZWcItZoYoUFmx12dnjNsb?=
 =?Windows-1252?Q?m4VO/1KuTXzK6dIemNwC/B6VL4xuS5k066pzu8SEvH2paUiE+pasYyvk?=
 =?Windows-1252?Q?JpzX96W7MCKRKFHvLP1JZ9XfGSd874C2tCeY8q4K8QBJE2vVPw4+/Jf3?=
 =?Windows-1252?Q?5YSazeg1apMubJmA4QSK4y99M6pJR3U51LyiFS2+Tctv8xGOcexN/XV9?=
 =?Windows-1252?Q?EQZqiyrETUMw6ZI2LCzRMXrExr1p8Yx7OcaWNCs26eDcVbH8Jqr8BKq3?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5C08E4F664CA7E409CB16FA78A8382E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4003.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdef14f-ff62-4611-6529-08d93b266be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 17:50:45.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUQy2bPlItfAySGz7xHmpK60FUtJN15cViVJyLDvJkOkeuH9Zw9WbUE06ZrxJ0psPxVBfeuvgySsTyQcN81cJfi0nBsNlpWEiR3+0iwbJnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2097
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/29/21 10:07 AM, Mark Brown wrote:
> On Tue, Jun 29, 2021 at 05:01:57PM +0000, Dan.Sneddon@microchip.com wrote=
:
>> On 6/29/21 9:47 AM, Mark Brown wrote:
>=20
>>   >In what way does it do that?  I can't tell what the patch is supposed=
 >to
>>   >do.
>=20
>> The SPI_MASTER_GPIO_SS flag has to be set so that the set_cs function
>> gets called even when using gpio cs pins.
>=20
> This all needs to be clear in the changelog.

I'll update the commit message.

>=20
>>   >> -	enable =3D3D (!!(spi->mode & SPI_CS_HIGH) =3D3D=3D3D enable);
>>   >> =3D20
>>   >> -	if (enable) {
>>   >> +	if ((enable && (spi->mode & SPI_CS_HIGH))
>>   >> +			|| (!enable && !(spi->mode & SPI_CS_HIGH))) {
>=20
>>   >This looks especially suspicious.
>=20
>> It's due to the fact that the spi core tells set_cs if the cs should be
>> high or low, not active or disabled.  This logic is to convert from
>> high/low to active/disabled.
>=20
> spi_set_cs() handles SPI_CS_HIGH...  this looks like a separate existing
> driver bug, it should just be ignoring SPI_CS_HIGH if it's providing a
> set_cs() operation and letting the core implement SPI_CS_HIGH for it.  I
> only checked breifly but it looks like spi-atmel is trying to use the
> core support for chipselect handling here.
>=20



