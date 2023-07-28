Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF93766EFB
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjG1OCL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1OCK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 10:02:10 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51852D7B;
        Fri, 28 Jul 2023 07:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl1VZzrwOfYBZEkBxSdpP8uGrx40SSFGMM8Evd4LyojFa4epHQiXkUmQ3By+CDarQk4PH/guv28cx8RzUKQlujCjudMCCkQhxP3U4wTFKF4/XRW5y8oGY3qe5wp2wB2KPtRxVIij7ACmPaM+e2zSty2odeEJL3pFAzJuz20ZC9s6ADenWwxfBb1kw2GgY/hUGWmagvyc2oXaKWo3jWCeEgqxJwDi1yNGeeQEDcmzcEBcbWXczrpeC0IozaMcFiFywlTJjrcqW8f38Cztb5Voa6c27g8owla3PTjzC/WMMkCijeuU7JhBocDhYlZO3TOmvkRLyw05m5JvmN1SyWHU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QayTuuW+n/uW4Bg+8vheykhPm75RHSrCRErYHoXhqGI=;
 b=Qb/4Xnx7gEnedjay6P9ZdETz0+4dofg6U1xCtVw59T21g7XhUEkuusi3eXP8V5f4V+Xe7ey1vDPyCQKXWahlo8A2a4BNCVu5ydYXN7my0FvDyom7d4+nGURoZwd/7cFVl0uZLVFTc+RGZ8tkf1fjw/ZyZTBt1/qhYXjXMvliqy9rPBfPNGSV8f67vIygSDn8v1DKgB1m2uI9hxmnwd+CkxcFgj2/o1rc8ar9Nky0yB47k/MWZjYHP9VwUkTMFccvricYj7qLI21WFuVbjuVJ2LiQGg7sLEiM+UT35Q1N4Du+VP/qA4cSB6Hnp3lWNGZheO/eknPbJLNO6OKaJRURHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QayTuuW+n/uW4Bg+8vheykhPm75RHSrCRErYHoXhqGI=;
 b=L2+ppKaJghn2TVaQpl9fYDwxG1UtuCD5+0IDABR0F5Z29V97bGWyijcHRpk57CqSq4+J++0aaE6neEZc67XqlLtrcHSPsAiu43s09vF6A77ZKbOGOlIlvNiVozMqpuo2wrRXECkJX1q85G6cQeHCmh/TeLez+WZVoVjIh7n0sSA=
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:02:06 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::deed:f6b5:5c93:15]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::deed:f6b5:5c93:15%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:02:06 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
Thread-Topic: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
Thread-Index: AQHZwRnieuqJEhf8wEGMPlVLLgzVWq/PNWHw
Date:   Fri, 28 Jul 2023 14:02:05 +0000
Message-ID: <GV1PR04MB907188709BEA225CA0B327F49706A@GV1PR04MB9071.eurprd04.prod.outlook.com>
References: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9071:EE_|AS8PR04MB8562:EE_
x-ms-office365-filtering-correlation-id: 7038b9b3-3025-4f3b-a9bc-08db8f7339fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eRBxOPHzvxKo6WlsHvxaF3SQDDz/XK9f+q1y12S4azRww+C1wSqXrzl/YcjSWm/z33KI3R8fzAMVDan8fxfI/GmGEIC6/AYzITmv/I6pFExTuTn2QZD4vpyKz9yeZ4xvfwxCTbnvARUggvi2+TKK4T9GHIkv+cVFKlV3WmEUvv8etDy6+nh3GnjNuZ7JrfrSYolGsUsoPXyOoRoEYkJOff6P4rW46f2/BgU1VGYmJSue2kr3LCzwJRPEfM3KRLNDz7xI5DOeIgJI8QFGoRiLirHjtryOcKrqf7bTEdmM1LF2xdLdvacTrniDv/huMYYUVu4NV40y7wVQ4FmSb9RUexnvhQZxPG0BCji0nDmSD8cPAlYuEyitOGinb0LA2hj+XFXOuff7XCEgrHEBzEiiubWHjytR07prkwuTObDBJCec4Iypn8BS7TshAoh1Mx+O6S5r0NZkNH3wC5RztB535Y4VYzVoBnL0OpN8CmfQ/VHhi7z+UqPk2s4SEoTpRDcsGBIa2oADL3/gm9ykRcipipXKs9l+I6S7Dd1WYycxmmoARCFDOsTlEfT4xz4bgGALw9cvEebJtKpS0L/KRwQY9vBBq2BQLVrLFeVDxVKrlK7keSEAqgqe59GphfBTjHAi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(26005)(71200400001)(186003)(6506007)(2906002)(9686003)(86362001)(38070700005)(316002)(55016003)(8676002)(8936002)(64756008)(110136005)(54906003)(7696005)(4326008)(478600001)(122000001)(38100700002)(5660300002)(52536014)(66446008)(41300700001)(33656002)(76116006)(66476007)(66556008)(44832011)(66946007)(53546011)(83380400001)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bcCuMqTb02QhHx2h/AsniHiUAl04dLL1k+AdvV4oHNiO3RY2SjSzlf0YwqLk?=
 =?us-ascii?Q?MPcHx9CPU7iilRD8NgUE62v29/Jhf8PBx0117MaB6wtNVh3WqFGynpJ7Vtsp?=
 =?us-ascii?Q?E9Lum3iWEjcJClo82n6AelF1EkXB3FVWCu+GHamVMM7D9QLd+GeOKyw2ygv6?=
 =?us-ascii?Q?gMW7Q1KgXjvliPssbB4knwbnQqq1lLnKriK2Vn1LH4LRF7K7HzfohQpWgGvX?=
 =?us-ascii?Q?FqfVWp8i/YSZRDOsPLSkXDG3RkHzwGd5co+n+XyGBJcgrZTrlyAbydBLdRME?=
 =?us-ascii?Q?D/IrONEKcLwiXa3cYinERxBG5dM6JrpXCCFvR4dc+6GKO108af7Ii6YZvvaW?=
 =?us-ascii?Q?JBcCXdfbOAwsmJcv9v1SVYNisyL5vlmvcw9CHc9yXz8ZWzznYEu54sXHFf+7?=
 =?us-ascii?Q?vjtKV8eKCw/90EIZjJSXFkQJYiWd2HSIuAqU33HeDYgpHm6flhcIRrhs6w8c?=
 =?us-ascii?Q?e+G9zm17y7rfPgZiRSO2WVg/4n8tt2xXYor8m4YHSLVtTK8ETp30ApAvek+/?=
 =?us-ascii?Q?jWH5zmUgzwogP6OyAYQj0mfv2OvjFi9RmpPEC5mI6vPiLOYvzraVFAIQJvoQ?=
 =?us-ascii?Q?R0qbeJM/Og+RACDsG1OFtHSm54v0+RAkUldBH/HbQ9VJ0JEKCl8URh3poGjq?=
 =?us-ascii?Q?rhGTkFbAI6UbMx0nmRTcz5mf+D8LqDMvW/CVfL8+PD598cLb9XmMrJtqjPiZ?=
 =?us-ascii?Q?nag4SGdFY2OVqva7D0HhHoELFupO9jmGXAF2clWXltL/JOn2stjZE0++H7YI?=
 =?us-ascii?Q?ra9kwOaD91yZA6dz9H+rcFXwA2Es1LbEVaJOjUyzvDeDmJnErr9ST2XosNK1?=
 =?us-ascii?Q?8ipcmGdMcni4wVUXKH0Ep+7sjMv2lFmRiqD1Uyzox5ME31TnjmTFChrUDxtW?=
 =?us-ascii?Q?muH/YRmyONI7wgekWJ0UL7mfHMEao4RAR62ah1Kf+gC1MLk4V/XRDX7iacAt?=
 =?us-ascii?Q?ZtZ6wWve4Cpetb0B+fNy6HhUOO9mGwxSVfRLLSpIgYnv6aXWShZrOnjYEZhy?=
 =?us-ascii?Q?tT/zUOZTxIX7nTEr/dYqT1YCCBqlUAsOOjiOJ+WaB6hS/Ej0YKZ03drgoqcC?=
 =?us-ascii?Q?RojMaiuv0IN4r52VGLq4Vx4oyL4wldRJ4D9Cl48/dR11q8/EwlhncLVIia/r?=
 =?us-ascii?Q?ooE4iHhr6PCS70yRkD+k15VNs0/z3AqcSSbeOFTI4LVARDqjjPnRnuc942mt?=
 =?us-ascii?Q?ennB9V/jBNtqLsUYL+bUIn2daxyg+zt3hZHyyfIeumkauPj5+2AV1iSZeMlr?=
 =?us-ascii?Q?wMBOYDCCl0a0+jP0/pcTj6u/3dmf8K2AyGpNP594LNe7I67Q0moJ39acvdyI?=
 =?us-ascii?Q?ZrdNRq9qaaxO5huee7jame8R7T15AJYFRnOSEeKsNu2+A0Gdx3/wRWAIcAA9?=
 =?us-ascii?Q?MZq2NOA7I2t5nMRFcud3JYzg7xFp/5L0xKOFldfUwsz0SQYEiAZL9VbwlX++?=
 =?us-ascii?Q?do2KXOIaaMJgobkrTWvklbjzhX8RvC2zYAZpuSpj592BE2nw3jNKZ9PQQYsP?=
 =?us-ascii?Q?ygZ7+EfbCqI0vpIIBAe2mkiMiT0o46MUMtAQ3M2/wOz1t5AzTKAZ20nrpsfe?=
 =?us-ascii?Q?pjrIDgBkG84VxXoZ0bY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7038b9b3-3025-4f3b-a9bc-08db8f7339fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:02:05.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /46GPDdwtDsIXWYB48KLgRFlbvVNFP7YicEy7Awx3fIyPwFJ7R/NIqYPZM15v/Ij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Friday, July 28, 2023 1:08 AM
> To: Han Xu <han.xu@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> Yogesh Gaur <yogeshgaur.83@gmail.com>; Mark Brown
> <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
>=20
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Han Xu <han.xu@nxp.com>

> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index a813c971ecf65..7fd5911454800 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -45,6 +45,9 @@ properties:
>        - const: fspi_en
>        - const: fspi
>=20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --
> 2.34.1

