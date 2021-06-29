Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695073B76D6
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhF2REb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 13:04:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:8227 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhF2RE2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 13:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624986121; x=1656522121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=msJHfbDLH2Lrtp+wcPhUkGCqX3/poqIKIZYxLZkmBh0=;
  b=XpOg+PmiArfo3bAZK/JWNDh2qKYpt3YwgSzqgL0pAtPy3afsX2JABLRh
   ZGOZfNZreEeuhl12BUh1E+uYfRFny03Fb3zo4KXCAbYz7W/40Ns+KB8KC
   i5I1ETQDD/UrWO1I6md5v5bjWjsz7nDQMpZFH0y6sciJnEEUSqeNI9ciT
   R+bMW9NTkun8x6n+1o0FHmsOQIq8ttNgoanRFveciEeL1d3MbvAG2rEh0
   UpsZDeW8rGti7aDnX9+lJJd7V4YSkFNagzXasd+iHgmvL+QdlUzIUJeC+
   ME+GinpMpQg7NTIqQWuCM6FVVy+v9QBeLwghTOqnJeD0POsoaJ6Iax/V5
   g==;
IronPort-SDR: w4lHi/v3DR8W0idiTqELjsaMlAy5XG2yzB9a3EOt3Zb3WXwi6ytdqaXtYmt71KyhDfVUqMiMpu
 +pe4XHKwlz8mc0gurV0CavCdOZVpLqhDgDlJ4xwqBPIMVCe9bztLOlUw/PwurNxeD+Zhi3zHOJ
 YoyXssmOfz+CCgukYzzU41tYYN2KQroSrohPKvPSpsYa8wZDa9KzXHAh/ymTLtrWJPBgT5cs2w
 jm0HXyTVBrVJWFujUAzkDiBHLq1vXXB2i9oaYlUZhx96nDRiI8FS0rQJBbVxOsEGmNEHk8nxoi
 +a0=
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="120423594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2021 10:02:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 10:02:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Tue, 29 Jun 2021 10:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3/tYJky4LvaLL3+uYYolFDPy7CGIj9/5aS2pbaFkRFm1nzJBwV13MCozFjhtjBOpu++R23wuNE5NWgGzRvL6SZmXcfkd214Vst1RkV6bkzskk8I0C4774If9/RQz2n8O9RtSM8sauihc3FgGuMKvL/HxyqGVL7PqSBIboXc5186BmS4j9ubaW1vE2Fm7zmEzLjzrP0y4TVVsSbcIRtbnuhx3Bvv0W+nVyxsMStHD0R2yxzrCfygNcaMoq1ieOWECn519SRm6kLbJ/d1Y2EMx70bXg9+G8A69SmIdaje7/8CavGR0N5JowDiy8DW10N+TxxngryykeP2/5P5c2y4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PV47oQQCEo2XcMSHeRkGbfHqama39WGNgDY96iijdE=;
 b=LPYO8JAipzeLHvFvE1sAjsIjBnuneKtllpWf1cdwk6QhLLdfmtcJmYrdWJd5xRU9ktN6Np4Nyhy6EQg1wt48w3BBP5DHPrsVt8Qwq0i0PWFKNvY2Dv4dxAblycPkKRomLZxGMfiFuVK6dBeV+5Flz5PuMg8GZukfouZy8ILGuIfisdmdeLF6C6hb0GFX8j15DQ6gAYmVUaaxOqaOm+sLLXOqLLKitTXSrw8Mh4cOWwxjwWKDtcrc1PpmbRRJzL4OTmbs26hGDrweSv/D3/HxGJB6/b4QVvPV+DaL8oiMkDgTCqonHXKh+nmhPCzyyfNPuS6gGG1obQ5uYTMv99TWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PV47oQQCEo2XcMSHeRkGbfHqama39WGNgDY96iijdE=;
 b=sQhj0Ci9zb+XvaOPcFwH+U/LWAyXbH2XyuPd7AZwggb9/sZ4Tz1M8XB7W7lnZLX6gQnn1WW28pO81bY6BS9fA3MuYJ21fNx7Ki5F369a+DZfr+FjQFiBpOp9yC+9a/6TlFflE8JIvOMRxBjBcoQyLfS6DGdRSwCN7Z9x5lCgxUg=
Received: from BN6PR11MB4003.namprd11.prod.outlook.com (2603:10b6:405:7b::17)
 by BN6PR1101MB2161.namprd11.prod.outlook.com (2603:10b6:405:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 17:01:57 +0000
Received: from BN6PR11MB4003.namprd11.prod.outlook.com
 ([fe80::69e7:2972:2e57:3b8c]) by BN6PR11MB4003.namprd11.prod.outlook.com
 ([fe80::69e7:2972:2e57:3b8c%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 17:01:57 +0000
From:   <Dan.Sneddon@microchip.com>
To:     <broonie@kernel.org>, <Dan.Sneddon@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] spi: atmel: Fix CS and initialization bug
Thread-Topic: [PATCH] spi: atmel: Fix CS and initialization bug
Thread-Index: AQHXbQPwgV1WliYrJ0mjjxrwZijXiasrMuKAgAAEBAA=
Date:   Tue, 29 Jun 2021 17:01:57 +0000
Message-ID: <c849eb7a-d019-b88e-583a-78e1eba7624c@microchip.com>
References: <20210629162914.23286-1-dan.sneddon@microchip.com>
 <20210629164733.GE4613@sirena.org.uk>
In-Reply-To: <20210629164733.GE4613@sirena.org.uk>
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
x-ms-office365-filtering-correlation-id: 9bcba69b-f1a9-42d7-aabc-08d93b1f9aae
x-ms-traffictypediagnostic: BN6PR1101MB2161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB21615ECE8D14D36746681819E1029@BN6PR1101MB2161.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjVPeZ3mm0+7XJqsVgrjzMaRIQ4z097ctq+qDosmfjDvz3gXWmh0b1xXElhVZ1vH1LjsoKfMmKOflU51E7BFN5kIDt59ipZZs4k65sOFff7bjMdHs71J4BUotTW0Z04X8GPBkkr3K8EN5C6UU4dZMQNI5+Opy2aoyfhhx6pfVyHUh3Y1OZcfpheuQWIBkuvx8bP8kkCyI8lA0ycvt9LZDcRJ6ZVyEfRLGR4IIhAziEtDkRD+Tgj0Cf5ZSnsa5lynupe8+qPGcvLn+pvFu/yV8c4APDrUko8Svj8XS8zUcagve4E2IVt/XL4OXMB+OCfzTzS0efL3gbwSFXgHYCnuQRixj/vsF8WuewDtlNFbG7ea1RCY457/maSY+PQ/wSJLAcXcPrkEakI+eZ4xpyfFCD1A2eonSMTvrxgYInV96Fl5PPXqPy6dXNDOfWCToRmS+eirAjja6eUZ4UVUhDhwzBtqiELmXiwUFTwEPIhbOxV3UdNWLNVKy7aaVawu6E49Dz4qMBdnXBKHCXgOFcRzcKDotlbC+pvdl/IHaVIUEk8YcVoK/gXtsm2PTRS8Xqg+C3cGyIVxgXAiSHipXKdtnMLyepbr9HcjwVw5c1Tmd7DXPMSRKwHx3lq+pi3M7dKjiCmaavbjRd49lYXGljUsD7r9HVRoVQ0OcZtRLqaq8MQ2gCN6qhKDJOY4kewki7VIzLCFiDufh69Riz1ZeJ0zVaVY81l15SBY7ETsPy0gbke/OdxFpzovNZ7UwGEfZ1T7tSDXMK900crpUeL72WBefw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(71200400001)(38100700002)(4326008)(6512007)(31696002)(2616005)(186003)(83380400001)(107886003)(2906002)(26005)(66556008)(66476007)(66446008)(66946007)(64756008)(86362001)(91956017)(122000001)(8676002)(76116006)(53546011)(6506007)(5660300002)(6486002)(36756003)(8936002)(478600001)(316002)(54906003)(110136005)(4744005)(31686004)(45980500001)(43740500002)(299355004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+M5Usi9WajvhOD+KeLDvhkWjvLFI2LIkUAgj/amiqpfL5E0PMqb8PJ3M?=
 =?Windows-1252?Q?M58/bonqcU43vupKer9WX7N0t19rinLLErerFns9xKXXp7eZLfK8J4Rs?=
 =?Windows-1252?Q?omWM8cZ/OvtUHIAaeB+hyDSQzlnq4RsXE/RPIFm0iG/nxkEboRGqZASD?=
 =?Windows-1252?Q?Qz5hO6LeoAmlZQYiQCWwopo+74TBi37Y6qw6RqwaN4uAdT0jidxo30UV?=
 =?Windows-1252?Q?j6nYhHT7RKRjhnptMoqmKVVzUyIjFP5uHaqbE5i82GPwTc9lOAwr+zgQ?=
 =?Windows-1252?Q?dhGH0f7gXjOe6opiGnZwR0MQFbny58+Cgz0zgw9TddnK92290zLLLuOw?=
 =?Windows-1252?Q?hCFTU500jxqJX7DpvNoEODwWQacsVenIVubCtCUolycKkHRVGzYJ4gbj?=
 =?Windows-1252?Q?G7fkNt9JDR8YNiLd6w3HoaTVgXbqmYwMkn/0qdt4oMpsGZf0iQ9pMZqc?=
 =?Windows-1252?Q?k+HAnF5ILewBxmVrArQIK7Sg1hSs8NUsCoo82T0Bi2xGZJgP8jEdGrm3?=
 =?Windows-1252?Q?y+SFOZ5uIWX//l4CHRI4h1RFjqTXwpNV9MRHReoVeeL1U9iCx3MY6c50?=
 =?Windows-1252?Q?IbqjtSfoaYeJBV+hqloB7wr+itgt2nDYRURb7/nyy13hYV/pDa/gvrz0?=
 =?Windows-1252?Q?shzQgIC6ooU6kJ3mEL9pvGUXN463Ex3dDbjtoc9d/uW4sOfjorIXu4+P?=
 =?Windows-1252?Q?PvwDKt8UjWTpVTfqIPF4vO6UCjJA6OLyCLzugVBsQFOEYnlb5k8uvgBm?=
 =?Windows-1252?Q?YZsSnMom76b70lTSr/gnPoH828wrcOv3bz/h3sa5gagKyaceVBL24c3h?=
 =?Windows-1252?Q?WEqrwNRRPTJXPDtCyhVFEXOTt1QdWb4XadPpodAR6TPJpF2t6Pk787LH?=
 =?Windows-1252?Q?cW1bWagblfqA3eqI3isvFcOCJv9WqgeBQyAfUt0qm7B5Ux6oyvNewZOc?=
 =?Windows-1252?Q?wahW2vDrzmqkpn9J8Nscc1MyvHdnmXJvQIRFfNhNdSMD7pmd3PlyMcms?=
 =?Windows-1252?Q?pDnq98Hm/YoyvCxyyp8WYEAWazld2CKaM9M1qTiPPUgUkNPG7ANU9vFw?=
 =?Windows-1252?Q?LtbC3tn0PEbcXOTS9+dxyllZ6pmcnKFb7Lr1AEmIPWkWaVFdtupFA+LQ?=
 =?Windows-1252?Q?e1jArNbcyBKl2gAwZONx6XVtOfloZFLTpS8LxkIJCLmwIs77ZJP6fo5Y?=
 =?Windows-1252?Q?9G2lRMB+xwBvkWa4bIqXDgMvNH8mylZ5gId1Cf26p7UU1aBONiic9HGe?=
 =?Windows-1252?Q?4iiBQpZDm10SC/ryyjY7Mj4Arm2QPZEm1luKXwdD2Zyx3U5ZwALf/rDG?=
 =?Windows-1252?Q?lqccPwOROG2gfhZbV8NXI9IlhRyoxq2AoiqO9MxbS373UnEsjZAXZNL2?=
 =?Windows-1252?Q?+EYyFE6iDc8DvrGG6YI8ZXERbCNcZjq9BwI=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <76EB80215AC8714CA723557151CE056D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4003.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcba69b-f1a9-42d7-aabc-08d93b1f9aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 17:01:57.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epf8BrDRUAAuV7sF0wDST4oPJw6VsfqUQaQytAmhIf4WHQzeGLpjKRsOgYjLRf4HvYIOTiL6FOf7XY9pKred3X8QQyPg45OQzc/8Q0xRMHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2161
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/29/21 9:47 AM, Mark Brown wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
 > On Tue, Jun 29, 2021 at 09:29:14AM -0700, Dan Sneddon wrote:
 >
 >> spi_setup won't get programmed into the hardware.  This patch makes
 >> sure the cs_activate call is made even with a gpio controlled chip
 >> select.
 >
 >In what way does it do that?  I can't tell what the patch is supposed >to
 >do.

The SPI_MASTER_GPIO_SS flag has to be set so that the set_cs function=20
gets called even when using gpio cs pins.

 >
 >> -	enable =3D3D (!!(spi->mode & SPI_CS_HIGH) =3D3D=3D3D enable);
 >> =3D20
 >> -	if (enable) {
 >> +	if ((enable && (spi->mode & SPI_CS_HIGH))
 >> +			|| (!enable && !(spi->mode & SPI_CS_HIGH))) {
 >
 >This looks especially suspicious.
It's due to the fact that the spi core tells set_cs if the cs should be=20
high or low, not active or disabled.  This logic is to convert from=20
high/low to active/disabled.
