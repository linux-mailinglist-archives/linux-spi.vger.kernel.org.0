Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2E745895
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGCJlw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCJlv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 05:41:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C7CD;
        Mon,  3 Jul 2023 02:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbgFPX5HB50btl82IpyyPl6+J7+O76C7O4mioMxHumJ3/NOZcMPQoN8xmdWpYGXiEaCElfNSpe00EV9Y4uPZMtRPWsnqnF0cncuFOlk3nX4WRHfsETF7UBGjckDI85x7XsnMElc8mMluqu3TF8sNEjH8a+Ah8u//03BNwV1ShYJA1HmP7UV6tPX5TONWVTO/HF1CPgiNS7l4+QuZBHpf3Q3Xjlm+EKrfSJgWQus8JkyVt7tF6wUnWsRBfB+DCr/WScZpcotdWlCSe1J5ghd9cDGQ8EoKiik3XZkPpc7Shbyk2bllVfyysoPRC/krNCgzD+u98Ipw8zZR2EUuwjKbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udt/y1yUQuKFFXt13wkongKoAejj7ZoOQ4VT6ozYI10=;
 b=dw7Bvc579K1UXMvgNdDVyIwr9aaeQS11jSmpQOILb0/6OGSjZJk+O64cT3NrEmh+atWZpDlhwAx7+IWiegmnBvFoyHwGxHvWyDndjeA43EHKyOsO2QmBv12b0bb7FIJy54gYAo522DhioQFCGjQCWG0SExLqYwR0uSPdXc2hQxhc59H90y4MImlbzPBxKNSkJzY8LP/TOm5SSYGqgeD0noBwmK9wAwmALt7XafSvkPTXuUNM6hQ5dm3zg+fZsb/Yf7TjpdT7bYciXmk12+hUJfYta/A/HzTNiZgPiTWIUVaQOeYDloefplxxPw9HBQ9iWB819+kC8vtHUPYBlwkNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udt/y1yUQuKFFXt13wkongKoAejj7ZoOQ4VT6ozYI10=;
 b=YQd/E5N7MgdM9xJ7wq/LC+F94UnB9i4m/2eV0wk4ZtjpQ5HUuZsdPiQ7ZgUR1lxSX0gtMFQJ2cDvvVCFiiuu5aJkGCi+OT7N27U8BDDgXUcl3iZtStt3Pk4XVqr1GeCG3SpSlxm6bJoDXgDYzfSen2bTY9eup76EFJIZjuz6yd8=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB8701.jpnprd01.prod.outlook.com (2603:1096:604:15b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:41:42 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:41:42 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: rzv2m-csi: Fix SoC product name
Thread-Topic: [PATCH] spi: rzv2m-csi: Fix SoC product name
Thread-Index: AQHZrY2J8wJ7/wqAQkWCxEBK6v2DZa+nyW/Q
Date:   Mon, 3 Jul 2023 09:41:42 +0000
Message-ID: <TYWPR01MB8775FF455AE1C6D56E8D1208C229A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be>
In-Reply-To: <89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB8701:EE_
x-ms-office365-filtering-correlation-id: 424b6e63-509a-457b-923a-08db7ba9b591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8VPPlXLNbEz8oGerPpzxganlBRZ/POGWEpDgCkhBpsqH5GtkF0UicBTgS/8Df9S3JAOTuB7+jmioENp4YM1fdZEAjeXqqJLSKfuL3Tif4vNfFm145jTbZytyOgsm5zPMTCTgUzsdlTXw6ehG9PMcplAqsuo9gNr91d70g2CNmYlRuf1dWV4HvYREa50qoZaAQHqDZ66Mm/pmt+aETKLC5M4pIae157zybdggR21KGzE2/X8nfZGtb6XUdlXgaZ+bJZGpAy/Gc0R97Zb/oumP8U28Jvgmyu3hqKfWaAZv0NTFSPh+r/6KP1nkpyxaEO6Fj3pUYKRqv+7LcS04TUPXTU7ruQrg106UCbVXwAu9tZXMFMvNHCuRQiKNqQEemJ/e01Ti3FSx6MnSK2rDZvludmRQbZqoP4/zm2ZUPgEn8A0BpF2neBwLj6Mby5YErFO8eYKXLakq8Ozor2KBnc3945aRixK8oa25ycD5NWlyD/CngPiTPufa0lbI6to4qAHvnOzlFKRESduyRcCyerloXx69gl51KbAgZ+imXib2+/AL9pP4nlVAPpmr0noPIoGV0ajQimZDUbmgcZec7BEyTT8dmjbC8l/6HVK/HqcZG/lCdyjjUATh/3PMUevDxjH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(4744005)(2906002)(5660300002)(52536014)(110136005)(54906003)(316002)(9686003)(6506007)(26005)(478600001)(86362001)(4326008)(38070700005)(8676002)(8936002)(66556008)(64756008)(66446008)(66476007)(76116006)(41300700001)(66946007)(38100700002)(71200400001)(7696005)(83380400001)(122000001)(33656002)(55016003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/4RzdbSWCPakX3plFg3uAUYRhSmtmHGPau+ZZbl/8mjNheE9ZL05eUcpU3iK?=
 =?us-ascii?Q?LHkV1vp/bE9DoRYFzZFFM1yyDE788b20NYRMD1Xc9FDdt0axmLe1eFFJpUEv?=
 =?us-ascii?Q?s6qsz5VsghQAVuQXTXGj+A6ymrnt6aYoMdEMiF1Sj41kTP0l9tNDopBR6rbP?=
 =?us-ascii?Q?/NvTZT2fHdkFxknYTNCMHgV1pWbFko7Bx+T8i9CtUar6QXoFm2nIJ7gC38MK?=
 =?us-ascii?Q?ElBW1+/35eHKxAvOrZopSoDfkprUUc7oy/0ZgXbLoec0lbqCni8o/pZhP4/h?=
 =?us-ascii?Q?4fHxTc7X1P3nKDHGrB43uwMLk60DGnlCVM3+nBVLrTwCFfHKPZ4rN/iL8TjR?=
 =?us-ascii?Q?IOZIrTrZ6X0BqrXN9BxPcOwJ8OrO80BS9ZHKCzkhGkApfpORmBEOmSrUUZML?=
 =?us-ascii?Q?qv7NmUKSKIyeigJ7N69RXqhk6gDSOQ7rpkS57wGE/lrvW8AZXPMf/tLqRhJm?=
 =?us-ascii?Q?GGWFagzV93GIskTxJ3jFSghHEVmCxEX3Ir3WCTI3hHfVxHWMqYgbafd0VUdM?=
 =?us-ascii?Q?S3BgkVxZsnuBGbHxeHWmYJaQy8n/dyu5iQ/zXSsGZHIPm2GJ10MQwVB03QU4?=
 =?us-ascii?Q?d88kSPCNwaKsrJMm4y2l3avI/7mNuSWiMKZC/118E3ckfCIkJRZzRsw81SNC?=
 =?us-ascii?Q?/3P8BiPKD0vqJMaLTA7gWg537QEh4USBcrfUi6jv/xKwwXVlz181MLlheZWO?=
 =?us-ascii?Q?VucbGdl8brNYmojXX267UzFMx89ndatX40npUpPmb0z4GF7TpPWriAXSyp13?=
 =?us-ascii?Q?cDsSV9DXG3Qzt+8v/wLrREQn9fmKD0yJ6A+vbd4N14gUxsPsnXc2Ax39u+tL?=
 =?us-ascii?Q?estWYvJh+rfehS0HmrFaR8+h16x/WNip4S8umSCyDBnEFaWkhGiOXzo7fWQM?=
 =?us-ascii?Q?A3OkTjQqMoYpLluXur1RkGJ+4gZH33Y2rvv+X13UTOIIrmHXU2NN6mh9XAMZ?=
 =?us-ascii?Q?SnvHbI/rkiTNpxGKn0a+WHbAyO8UpsjpvzVXaR9fgiDkDhfP3datngGSIUxD?=
 =?us-ascii?Q?r8QxjftQCGKZgjMehCC0ICUMwl5pocOk6l2HSfqmloEBGh1BKfsfVxRCby6m?=
 =?us-ascii?Q?70pzxqmSNL+mIAuZqMOzd/WyWUxbpcljjD7zs/spQcnkIuELsWEEbpZgIifv?=
 =?us-ascii?Q?g4loDeHPoYYMbbpwE5a0tEnizxPv+9iv2gcWwIn0WPvMRi4yBgtzUbxOujtW?=
 =?us-ascii?Q?MeFylzjugDFeCGbe019jEe7CnWphrwSdkvI7NIQVi9EeG+oQwtliHRN64ymy?=
 =?us-ascii?Q?4sP+R2Ed4MbhMizHKtUQlaaj6PKopNEHwxHQcWH71Yt83zEdjiamcBC3pUdS?=
 =?us-ascii?Q?9FmcE379hGLKIUXtclysh5aU9KfV1LGC1xYY0kNO8nnMpJAET5CiOZ3sra+G?=
 =?us-ascii?Q?AO+KvSU0Js4liLh3wH8FcqvW0aRrtSytio/op3Wu+CBZJaWp24k0A/oi8VsP?=
 =?us-ascii?Q?qv4jU/qcbzazIimylfIcQaAxcL+DvWg8+AjYZor/4fvWnD2/TF4wVtTA63YP?=
 =?us-ascii?Q?BcZAhO+0QiDZdMBzt70g/E1/nr+MRGnB4YTDNE0cG1s1PCMv93o9Kak0bSR7?=
 =?us-ascii?Q?Bm8+K9En2tLrfDYP32tNXs8atYsq4oLp00UfJwb+p6bthB0ByWQ5NcR8p22s?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b6e63-509a-457b-923a-08db7ba9b591
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 09:41:42.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcbo00P5bwvH/2i+HPdtLk9vD76kRCjd0l1IBEImiIVCWH5U8pPCWkxuiRXIl/cD430IW+/AAosBdSqZv8V/sVPNgel9Q54frrcpZQSyMp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Thank you for your patch!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] spi: rzv2m-csi: Fix SoC product name
>=20
> The SoC product name is "RZ/V2M".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

> ---
> Fixes: 83c624d8842d7f6c ("spi: Add support for Renesas CSI")
>=20
> Please move the Fixes tag up if you think it is worthwhile.
> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index d9b3a16ef1ea9edc..02efce0e1086230c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -834,7 +834,7 @@ config SPI_RSPI
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>=20
>  config SPI_RZV2M_CSI
> -	tristate "Renesas RZV2M CSI controller"
> +	tristate "Renesas RZ/V2M CSI controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	help
>  	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
> --
> 2.34.1

