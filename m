Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D678512A
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 09:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjHWHL0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHWHLZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 03:11:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E34CD1
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 00:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C59nFZubldU+gDnkYX7TAIqx2/yAipuT2I39aPvHyUDuNxHAFFZKkAXaFqk0S9pvaogUxsk+V9oPpJZCaN0zDavJrgMLqbZEMrCVLVBrtadCRexa/Y4P9DmXuGfN2ptCTecN0SXjtT1IYYfb+zf0v1NxRS8KZ2JXNuyjAIEHWSC8DWNwkwrmNjIhuc3SqrbwrdcBUP8tGqkOi2RlJ5mZllfDPSev9l7jwyTD2YxD57SystpktTdQ9Fl8VKbDy9chby1QqBjj5Xfe3ZKJ/nJlsVHJHwauQwouQEAp8betcv6gHGRbweSdleZpQlQBjbaHcFiDvljx5TWMOd41AhVqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7xSverx84p1FkG7XUOE1Uhtjz9zbU2K14Uh7EYXy7M=;
 b=isdgJ9xih/6d2BtXRJYhZXfwoKYhh3ON7Sd2VtzZ2LP5bJ0YN+bLgFqryAQ5ldBtowD9A6nl+1AWHJCBZOxRYQg5YHcnJIh94QwL9ImVQzIRDPBi2SskiOnskIbcIDQpCi7Cu2+4N8f7xbLwb42KztSCBToE5Wsq9qRvYM1FVnzfVKMVivDsH4ZufIv98haZl4LTsjHbvDUwPiZrS9OdndWdDRdkYjw+SR9XG3Rm8I7CyToxrqYCt1bDycmhpihX0NWUlJCJDVOfRy/xhCV+UOLc3dt86AecfAmO+seM+TQ81mw5d+O5Xf8wVC4Z+OmkNcE5l0LCm2eoXI6rUUb2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7xSverx84p1FkG7XUOE1Uhtjz9zbU2K14Uh7EYXy7M=;
 b=ZUWlN3WSxMqN4xnMG4fHiVTnJQhqF3ORdVfciTJIjW+RSGD9o2yxI5Ro0cOKfTy0WIC14vUsXMgO8pmEPzK4xBd4p/YVP2V03tuize0EOc/AdotFSHuxbu1uoAX/7vMwKzsRg7/GOuApLoivV3R+GpjzDRZkB9zP7o8eoRwRVLQOHG+lBNHmEBFYnnWzDg9MoeF0mpuLmzI34v9nlqpY8aIA+11wQ/54e1oneb+b0fqNGYb/xTKjr9sYCQlsCxSGC4K5oPlQMTV1yEVFmohwy0nG/aZVGdjrcV/OuAKMIt/UvFL4sNp24huue5QmjXt9/vBbAg/PndN01t+X0teVmg==
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9)
 by SG2PR06MB5360.apcprd06.prod.outlook.com (2603:1096:4:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Wed, 23 Aug
 2023 07:11:19 +0000
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::c404:538d:e090:f7b]) by TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::c404:538d:e090:f7b%5]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 07:11:19 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Li Zetao <lizetao1@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "clg@kaod.org" <clg@kaod.org>, "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "tali.perry1@gmail.com" <tali.perry1@gmail.com>,
        "venture@google.com" <venture@google.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "benjaminfair@google.com" <benjaminfair@google.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH -next 03/25] spi: aspeed: Use helper function
 devm_clk_get_enabled()
Thread-Topic: [PATCH -next 03/25] spi: aspeed: Use helper function
 devm_clk_get_enabled()
Thread-Index: AQHZ1Ppmytx9atFtzEKmu2Zv4vvkIa/3d2Ew
Date:   Wed, 23 Aug 2023 07:11:19 +0000
Message-ID: <TYZPR06MB520349C9A467FD2D43E6F345B21CA@TYZPR06MB5203.apcprd06.prod.outlook.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-4-lizetao1@huawei.com>
In-Reply-To: <20230822131237.1022815-4-lizetao1@huawei.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5203:EE_|SG2PR06MB5360:EE_
x-ms-office365-filtering-correlation-id: 2aec4954-4ee9-476e-46df-08dba3a82606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UksuVfA07KeYylAFTzYVwnR03vKUXPV1+C+/WfIt3E/yJeHHyOQFE0AeGU+psE8dqDZlvI1tamMx3ttkFGvLDhHcgmL8VglaiB1ltIoFJVi4hxrkM8ru+Z5jV/ouaL0dxD66i2Y3NAsZTWWlWM+HRYxBxVrtXPf14tVb/8UnXuPOKsBV9gCLErY5yOZO7Y3El6dXHLR/XbTdxskoZ/sRV4bGxfvFYiUXk0VSyF03P4d9Cps/7bMTBTO82ZkujaQ7n09q5Njs5miA83r7z/4o2TPp+N3rzRJa4zG1OXszJ3CKDE3wrkFZ+irkuITgfnYi+WjWvJIBN3R5YNXC8x2d4XmH/pubVrbsxLrFkDPG+L00B8G7L3sUWhDeQnEkOLYLvtn175xyla0vdVOqq13GX8Fr3k0PPi6E++fQcetMeyxNf+vzDfWasHp9PUvBiF8ODRVQT7G99x3t2TdFQ0TbGeHsfvD5iEsFWm+bJKOTZzEZYQ49ZUXaR39RGkIKDCmkKyKBJqUxXXYzvFbrYubb7GD8ZYnQXCnnjOKEapD6HUiRBWRfnyerEZ9QHfAU+8V5MtptVrOKS/SrUVI3UO9dOvbN9tkRcp/kX4I9sU14qxwbZtSbsWH0C+l3QIXB9bGH4RE3ErDJp422tnyP3to/aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5203.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(396003)(346002)(136003)(451199024)(186009)(1800799009)(26005)(9686003)(38070700005)(122000001)(55016003)(33656002)(38100700002)(86362001)(921005)(83380400001)(8676002)(8936002)(110136005)(66556008)(41300700001)(316002)(76116006)(66446008)(64756008)(54906003)(2906002)(66946007)(52536014)(5660300002)(4326008)(66476007)(7416002)(7406005)(71200400001)(7696005)(6506007)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piirPloeETUiZDsm2mshr/STo7mKeHNoEE9xLsd6ZDB7EQqgDNl6jTOKUB8t?=
 =?us-ascii?Q?8pi8nE1YXuUlw/keJmT5XtJ0fb/8DoYSkzWYH04NUHpk5Ue1BkdGcB1vy0Mw?=
 =?us-ascii?Q?HedxUum+IlS8K0xCSjjKO/1WXarbwzwSB7Vvewxm9uv7vihVh9S2v+atSky2?=
 =?us-ascii?Q?l0ACvtpo19kPFM1otC1Jph+scqrUhkYdrjmehV1dbe/5mprIKPJD+ShVu1hM?=
 =?us-ascii?Q?tuUzs1FUe0WYsM3cwR5svoiVP1SoBYyIgHYzb1GDA4yzaINWBtzvgjXgn1fH?=
 =?us-ascii?Q?LUZj7MfRt2sbwe0kWIqptcv4WeQU/huC3ZRPoSoymrJ5e+V5+xxEpLTn94yf?=
 =?us-ascii?Q?NLjU9iuYUjA1JNkL3oc0bgL+SBd4txZwdAlsKe1ELdXeVCFPx4KDaKoZ4wu/?=
 =?us-ascii?Q?UGhyWHrUBfjiP86aErivfFdieJ57PEDkBOODwDXdipu8AD+8+r8E6DufsS1a?=
 =?us-ascii?Q?EfTv0N2jzeq99eXmcOjXiV0kq3wMXCkRur9MgNhOCFP4HQ5bLK8SG1nwbVGL?=
 =?us-ascii?Q?Dj1d1t5NuccVZluWMf+gevjbvLJhgioK9nsSQdkSXxGVpg/90wfFIam3mK66?=
 =?us-ascii?Q?D1Z3DmHijy87SKCFjpGGVOg+gWYZUV7YthrdqZHQYCozLyDS9CHW8EaH6qUx?=
 =?us-ascii?Q?1n3CA59XkoZPTDIM9ZF5o+e8qWXAiCVfE/9Mokb0Gzkj4udC+u/ro2jUVT3O?=
 =?us-ascii?Q?RzBioAS84FqwW73Ou1yaQI8MpV9lXLtYoIIZ2N1NXWcEnLGI1QFX5DbSzwBt?=
 =?us-ascii?Q?kJIhKZAWiqfs8tEF1io8zax5OXx2qcxwxesWzjil15MhIwJe/ugJk9gdKqcm?=
 =?us-ascii?Q?TqHPgbgefpjA21xfVDXz0+yZ9Z6yyS4peUyYvw49nb/2vVT6cgzouyhnZAjd?=
 =?us-ascii?Q?jE62xJyMWwqWoZeTInreNZvpjbc8TBSCa34POz1FYufU8C2vZoB56hIaWBC7?=
 =?us-ascii?Q?MnogW44ehRkhwnKAoL6YC0O+i6vcG/0Xt+/+FGa+YWNCjTATTzL0snIzW8DQ?=
 =?us-ascii?Q?zMnFUgZvqRNckWmtuu581+JOZnyoktvAcSMHsOpsRZKR5ok/azkQTOK6jaJg?=
 =?us-ascii?Q?V2N6W7EWkKrIDQU2a+Tmcr5/J2XxW9oIpBYvlkGTm2VqCBFL8lKMOxJ9ml3A?=
 =?us-ascii?Q?0U2X99qS0Zi6zleKkjkzyghJL8yPOqQNDGdk3Rrko4yvnOMAMPZD8cP+QrW3?=
 =?us-ascii?Q?DvG2Nzlm9w/Z2bnBCsp/keST7P+Ao3Yuy+/tnO6tzrWVhUuGBoWYxqv2bp32?=
 =?us-ascii?Q?XllweDmuSSg5S0J6muBUkC30bUG80AWOVGQSMrH+XfLCPx7PC31woAMQ4xYw?=
 =?us-ascii?Q?Kh/IgC4QCMi1NNQKrwQ1FQkhyijJY1FvK9Wl8Ki8neIhMgIAa2Hon0Hw6J2T?=
 =?us-ascii?Q?RXLuUPw+dRPY1bVmwVvRLRT/ruNkMzUatFAEj3gDDjHzFdQYZPV2ZKc6nu9X?=
 =?us-ascii?Q?7MDHEeLZmd7MWpzMEAcqQrSd83zZgkN9z4Bgx9trX8UVpE1YXfuwqzDg8na8?=
 =?us-ascii?Q?bTPay5h+xPebI/f2doPOZkpmZCKuqMEm9njUO7HxFhCMDv0hF4hk0I+oTEfF?=
 =?us-ascii?Q?wS7ktDs9JCaI2uRWtgnT92nLgtG6pqJGQUCz9Sy614YAw5ByWTlmOhuZq5Y8?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5203.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec4954-4ee9-476e-46df-08dba3a82606
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:11:19.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Kt7NHf6kT+F7gf3XSI4DaWUAkIdrym/uf/uEEoRCaqwOpuJ4oY3DscO6Y5ZbR0DTYVendSZh83KK2xtwyM7njgJu8rnFYDA5xszVViGpXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> -----Original Message-----
> From: Li Zetao <lizetao1@huawei.com>
> Sent: Tuesday, August 22, 2023 9:12 PM
> Subject: [PATCH -next 03/25] spi: aspeed: Use helper function
> devm_clk_get_enabled()
>=20
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepare=
d
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it i=
s no
> longer necessary to unprepare and disable the clocks explicitly.
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/spi/spi-aspeed-smc.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c =
index
> 21b0fa646c7d..bbd417c55e7f 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -748,7 +748,7 @@ static int aspeed_spi_probe(struct platform_device
> *pdev)
>  	aspi->ahb_window_size =3D resource_size(res);
>  	aspi->ahb_base_phy =3D res->start;
>=20
> -	aspi->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	aspi->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(aspi->clk)) {
>  		dev_err(dev, "missing clock\n");
>  		return PTR_ERR(aspi->clk);
> @@ -760,12 +760,6 @@ static int aspeed_spi_probe(struct platform_device
> *pdev)
>  		return -EINVAL;
>  	}
>=20
> -	ret =3D clk_prepare_enable(aspi->clk);
> -	if (ret) {
> -		dev_err(dev, "can not enable the clock\n");
> -		return ret;
> -	}
> -
>  	/* IRQ is for DMA, which the driver doesn't support yet */
>=20
>  	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_TX_DUAL | data->mode_bits; @@
> -777,14 +771,9 @@ static int aspeed_spi_probe(struct platform_device *pde=
v)
>  	ctlr->dev.of_node =3D dev->of_node;
>=20
>  	ret =3D devm_spi_register_controller(dev, ctlr);
> -	if (ret) {
> +	if (ret)
>  		dev_err(&pdev->dev, "spi_register_controller failed\n");
> -		goto disable_clk;
> -	}
> -	return 0;
>=20
> -disable_clk:
> -	clk_disable_unprepare(aspi->clk);
>  	return ret;
>  }
>=20
> @@ -793,7 +782,6 @@ static void aspeed_spi_remove(struct platform_device
> *pdev)
>  	struct aspeed_spi *aspi =3D platform_get_drvdata(pdev);
>=20
>  	aspeed_spi_enable(aspi, false);
> -	clk_disable_unprepare(aspi->clk);
>  }
>=20
>  /*
> --
> 2.34.1

Reviewed-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

