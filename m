Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B477698AC4
	for <lists+linux-spi@lfdr.de>; Thu, 16 Feb 2023 03:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBPC7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPC7R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 21:59:17 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BCB1E297;
        Wed, 15 Feb 2023 18:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwI8SJb9kPY04DFgnpVxEYyN/+KIKbyBNXy+aXXhaWjOvTjv5DKXwmcRwPzyzJEKR0XtkhKQAEpQwSq39I5dHvlmm2N0qBezD7DJKNRxe+rP+VvJyUdGmD/2ZbiiwydARk4tlL1Glmwhs+Edhg8UgVP9deOWrRGQsEYTYha3X5dpwAwFuGpLzvUQxcPm+qiOBhvXJpciTMdhhF41VSPWJRq9pkBNtzevO6KmoJzVSWN7+piT2xjTRsN9ZJ1TcM/iyfkpFqMdsbTPMqcDAz4UW/DojGLLIOZWoU51bPKhCr7g6OE/7jknMAbKnLJqRNUANCieNwkP6UXub/+xptoVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqvWNxbqdw29PCojD3iHx6rUMcr0IWR+GXnoZDqiAJM=;
 b=FI2XqhXKfYFuObbc86DmmvBAPqs838hFwU93gik29WVe6eQj75LrcxY77HR4OmJ2cb99RsYYqvsst3au8TWc4ZjH6SG6dy7+L50HNRiwMMjkGbsKbpAzQUC83PFCuM4HUlM8wbay3C9x1WegOoa+9SBzTHpkMncpnlL7CtaHnxN+l5RgTTJITR7x4v0493tA7Qk0V5FWmSWJVLwCBhD4sosr9f9RzxLU6+tuftsAI5eykCB5cOJNfzH2r/vkyGdSzoEcNiUO6EtyJlqKYWSeiF/Li/MG2vzvRa8ohZnj9x71BtUu3uIPAeTqQnHCMFftAqEP6mKv4qfF1ykoba9yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqvWNxbqdw29PCojD3iHx6rUMcr0IWR+GXnoZDqiAJM=;
 b=OtuCltu8M651N9p9SV45H6lXu6J67Zi6hUjXfJycUHYWgckOxw58x3HYZ0ml8cMyekJEZPHDfbU/E94OkvvvjkylkPwfQmCUle1FhrDS1LoWSPhZ3Oo+eI6YiFE35tVukjujaIt4aJOh9q0vpLA9pjUbdsxTSup9zIiEhl0mhoo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10853.jpnprd01.prod.outlook.com
 (2603:1096:400:2a9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 02:59:13 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 02:59:13 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Thread-Topic: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Thread-Index: AQHZL8gXKp3JZtRDpEmbwmYHk3J1bK7RBMaw
Date:   Thu, 16 Feb 2023 02:59:13 +0000
Message-ID: <TYBPR01MB534179AA91204D6C52725ABDD8A09@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10853:EE_
x-ms-office365-filtering-correlation-id: 7d5db608-4cbb-475d-07df-08db0fc9c8ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vn2zvb1U0dQf6IVmqGipO7WQQkGVhXNsBFmMESzl7PtwR/NggT8zjQtGkky5EukWoAcw5yGJkzq55hrBeBjAmMo/oLdjbwHBYHaqAWt1V2hFevsEFjc5ekfwbn62xf/Ao7uL0+rueRGI16Jiyu7qQlBwlukj4VwUDU/sv/5fiBrla7aaxxaU0Nd/yG7zI/kS1PyVTUPhWcVDpvw9JHuT614oHvwLommVRKB/qty5+9ruQYfF2U8SLr7xatTWNcD7gisPxPtBMzikUiwjWwwBL3Aca3eWaJD3cMJNmQQLbhHuf5gv7nz03AUoOvVS6IsVY1kmUZMUfVMqm3iI7iSRNzciXjR+UPQ178y926nUWOsNY/dN99jYrkbFJkQpDftvC+dm3iqbHfJXlXJZaPA+JpUOtESNjkrTU1RhqdPV/jDH36PjFgw6i3nCIWjSPYKAku2zqcYD3aM56XAv95BQLIJbFWruC9rUbxQXLDj8YeoUcsLJCLbu4dNZwkE8zR51D76Qj7M6X1EOfMMG3S1y/dWCYpEUjXH4ATLZ5h/0fypyod/HwPsJEHl8Tw6l7TRWErPP0YmxXK0ew5LI6SZWCuK8IpFhY25G3nV+ZXct0FrLYLuK5CaeM9WpH2eIvGLIxK/z/eS41TB/W4lPxwPjCyQgf/8GPu6UE8c9u1HduQDu+2+kXWHcatin3eY6NQEtyGP66Nq0iQwCaBRd2QRIQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(5660300002)(41300700001)(52536014)(2906002)(4326008)(76116006)(54906003)(316002)(110136005)(66556008)(66476007)(66446008)(8676002)(64756008)(66946007)(7696005)(71200400001)(478600001)(6506007)(9686003)(186003)(8936002)(33656002)(86362001)(122000001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zaEBnALnatT2JhoLNGhobijBm1z3ZMh6vumHbtCFbnhgcO2KvWt4Pn2jCwdJ?=
 =?us-ascii?Q?HqpJ07b7WylPrPEqERaXYxu1dToN29y1JObqKkTxP50s0lNBAHTNa3TqZykG?=
 =?us-ascii?Q?AIg1m0ojhkm3nutA7/+zrpmoTUBy1x7YeoRuWa5/m41tUkJm4KZth01qDsWv?=
 =?us-ascii?Q?rqpBoOT0snqp1Ad1QZZohpXJY2D1T+XEKqiX6698EDXzkYAtpaMy6Gpu6dz4?=
 =?us-ascii?Q?b40T5yygAmOLAmgqUXnFHyT7J5U+xwzRj3BiB/3NkJPUe934el7j3XQ9vDoy?=
 =?us-ascii?Q?BTTs/26hEwfvlNBIT7A4SNf1YcNp9ADvNbIl8yWdUMW3caVrwMmzTcXgddST?=
 =?us-ascii?Q?Y/D6OnO35rWmeP5hd+jyAJAM4z2lOBhZaIOxOleGTgGdnuH7CeXqeRTbOy47?=
 =?us-ascii?Q?aakGgTFxFzjG97PVgIK9ffi9/MbUalXIrcXw4QGiQBm+hXAcxFZjEKRYJ6hp?=
 =?us-ascii?Q?cKeaxJvlu9649jkzJmUOkxasEsq7n/Q3UzS2pSBEvfTHYEG89syU2uQEa3I2?=
 =?us-ascii?Q?d4Es2f1YnyrxkxzqRR/D1Vt+TaxCVJXrjG3AjXNu76GruDFgu8QyXQM6owD0?=
 =?us-ascii?Q?1GyVPrevtSCxm9uQ3XohK49WacP0yE7oZgnyoZnwY1ijjz/s9SP4lQ37jrEm?=
 =?us-ascii?Q?PuLJfF7m4zz02I+uBqDPdsnZ30bvd5twvSOcXh08IHO7PWj/bCQMjehKMLo6?=
 =?us-ascii?Q?tI41qdK2OcMCBMcgGP+F0cX6nShBS9HlrD1LZRol5M3CNOnz7P43bwA4Yw8a?=
 =?us-ascii?Q?nEJkjuC/PfrSPNw1aenoWNO0c/bwX/UGOzooOH934MN9KsJ5YOKunFmarNh7?=
 =?us-ascii?Q?KyTcAdvIPDZWgwqZqYytj2eRL37Zpo74n122g7P8oru5AcVx506Y1Qang8sz?=
 =?us-ascii?Q?thg8P+zI5gmuvxtGIIBg9+hWxHw6a3m8Ne8APMcWJ7JarLZZLhLUU2byPQIq?=
 =?us-ascii?Q?C763rNskRyVtqtqaolMVRmVRAtl4aCedCgV6csDrh1D+9fBX34cqf+I4jMlG?=
 =?us-ascii?Q?N4Ms8xZXN5z/VhnZXq8OAnxHM/KqVXXZsVsJoP8tvGfV9itNbPqcUcT8azlS?=
 =?us-ascii?Q?TtR8yj/gVveaWvpMgAjoeFON9ig3jQ8hI8AHxhCQ2tG3kpU9wN/vqDHAm0Rp?=
 =?us-ascii?Q?jOSMT/V7Kq0uS8DGAW0OXAwzALvwb6FLyau7df5RB//KVtY8aAxOZ/Yofl5F?=
 =?us-ascii?Q?vxYTBngtLpcYsyIQDgwFGxiETrtWglNgWeaY+ETpLL+8EJZbJ3Iid2qWt+qc?=
 =?us-ascii?Q?BMN9TPyoxpSiAi9fFlNXyXF7Yf87sXmM99KLHNLibV00VUsITVetJxxgaEZd?=
 =?us-ascii?Q?QS9iiuZCB186LHUUSq11JGL4GrnD9WP7T3sZMGLFS6cChwHd6o4WTH/LqCX2?=
 =?us-ascii?Q?sLQ5J259595I4GsFGRqIyRBl4U8Bc1XMxi9/mhgtwjJjzxpBrzCX9+MpJc1d?=
 =?us-ascii?Q?Gax/f1KSdzVBYOjQ7ozWXlJ4IBWU5EizeBwtpI66G60yVKmscsHNiAQHqEsZ?=
 =?us-ascii?Q?2zJFXQhIkFS+WQsTnlGYBamDXZYQa3J/PB2Mb2gD7G+T3WBZAotM088gd7BA?=
 =?us-ascii?Q?j6NCU56Djh9zASmBUrtu1JOo4NqVeNcpWgmLSQa3EXd3BTp+y4uCD9B6CTDX?=
 =?us-ascii?Q?DBTf20RXxWpdTpLZARiUwYrWyVPGc7fVSZHMGr4YlxsxU7XbYx3/dICARxiW?=
 =?us-ascii?Q?JNH4ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5db608-4cbb-475d-07df-08db0fc9c8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 02:59:13.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9HAPPGJWw0kFcJO6L5sQKiSgtGNx9dU2Ag3SKkTuJYCmCHTn/EE4y2HV3IGNE1JdvtvuZk49sP4KY5ISkstzXQpNNa1F0xuAnP2IyjjbSL/i0llitpQyRb0VSe2ssbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Wolfram-san,

> From: Wolfram Sang, Sent: Tuesday, January 24, 2023 4:47 PM
>=20
> Documentation says only DTDL of 200 is allowed for this SoC.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>=20
> Tested with MSIOF0 on a Salvator-XS with R-Car H3 ES2.0 by creating a
> loopback with a wire.
>=20
>  drivers/spi/spi-sh-msiof.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 9bca3d076f05..609f48ec84dd 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -30,12 +30,15 @@
>=20
>  #include <asm/unaligned.h>
>=20
> +#define SH_MSIOF_FLAG_FIXED_DTDL_200 	BIT(0)
> +
>  struct sh_msiof_chipdata {
>  	u32 bits_per_word_mask;
>  	u16 tx_fifo_size;
>  	u16 rx_fifo_size;
>  	u16 ctlr_flags;
>  	u16 min_div_pow;
> +	u32 flags;
>  };
>=20
>  struct sh_msiof_spi_priv {
> @@ -1073,6 +1076,16 @@ static const struct sh_msiof_chipdata rcar_gen3_da=
ta =3D {
>  	.min_div_pow =3D 1,
>  };
>=20
> +static const struct sh_msiof_chipdata rcar_r8a7795_data =3D {
> +	.bits_per_word_mask =3D SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
> +			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
> +	.tx_fifo_size =3D 64,
> +	.rx_fifo_size =3D 64,
> +	.ctlr_flags =3D SPI_CONTROLLER_MUST_TX,
> +	.min_div_pow =3D 1,
> +	.flags =3D SH_MSIOF_FLAG_FIXED_DTDL_200,
> +};
> +
>  static const struct of_device_id sh_msiof_match[] =3D {
>  	{ .compatible =3D "renesas,sh-mobile-msiof", .data =3D &sh_data },
>  	{ .compatible =3D "renesas,msiof-r8a7743",   .data =3D &rcar_gen2_data =
},
> @@ -1083,6 +1096,7 @@ static const struct of_device_id sh_msiof_match[] =
=3D {
>  	{ .compatible =3D "renesas,msiof-r8a7793",   .data =3D &rcar_gen2_data =
},
>  	{ .compatible =3D "renesas,msiof-r8a7794",   .data =3D &rcar_gen2_data =
},
>  	{ .compatible =3D "renesas,rcar-gen2-msiof", .data =3D &rcar_gen2_data =
},
> +	{ .compatible =3D "renesas,msiof-r8a7795",   .data =3D &rcar_r8a7795_da=
ta },
>  	{ .compatible =3D "renesas,msiof-r8a7796",   .data =3D &rcar_gen3_data =
},
>  	{ .compatible =3D "renesas,rcar-gen3-msiof", .data =3D &rcar_gen3_data =
},
>  	{ .compatible =3D "renesas,rcar-gen4-msiof", .data =3D &rcar_gen3_data =
},
> @@ -1280,6 +1294,9 @@ static int sh_msiof_spi_probe(struct platform_devic=
e *pdev)
>  		return -ENXIO;
>  	}
>=20
> +	if (chipdata->flags & SH_MSIOF_FLAG_FIXED_DTDL_200)
> +		info->dtdl =3D 200;
> +
>  	if (info->mode =3D=3D MSIOF_SPI_SLAVE)
>  		ctlr =3D spi_alloc_slave(&pdev->dev,
>  				       sizeof(struct sh_msiof_spi_priv));
> --
> 2.30.2

