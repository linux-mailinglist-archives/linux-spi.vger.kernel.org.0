Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C51776A72
	for <lists+linux-spi@lfdr.de>; Wed,  9 Aug 2023 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHIUnN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Aug 2023 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIUnM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Aug 2023 16:43:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0617.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE844FF;
        Wed,  9 Aug 2023 13:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWOe0sY/bAh+tDGNXLkbTD8j5QBkPLGudzOkrpqHiDS5PoZfu0BsSn8XaRjc13xoMQMbcALrnBJPpzyVEPGJmt4iaKQl9RGGo5kiaoQy4WA7LPunQ9VIEEOHx5+NczuMH6Mrx9u74/06CK25P6ZZIXEk9h4YHAsJeOLnhrf3y59jMwNQFY+fiEspCXtU3G0tGRJaEM8RXfvX7jmQe5qldsAmA0PJmOZ99xiOSSU9LirKojeKcJSNEzs/RN+JQT+NBztGfZYtLvmBvB0Z+R0q0DqdL+UPqABTy4L5kHBgwEun2MJ30oVRIdQ7+E512IeZjw8CeJWlHWceKjuZyoFCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuxcAF4Pi6oRsoRC1AH5St3RX2dXWhRqw7PkeZGlqI0=;
 b=CC+7DAeIOgFtLQEuL/Mkomipia1AlS6kfC1QjjH8GXeP3gO6FvDCObhyjq/HpP7k/HopvWNIUCdVfhnx+PTbAVzsFnsyGn8x7eryPE5rrNx2vj4uy0M7Mh1s3xt6eE1/PVSOvwPALsfICmEAgQNoFLd8iJTBP1oyLmPhTVfAZtnsmILjuABkOsqzWMTmbuXGR0+cshHoTH52Z8FlthA2XmYX9/KfaGVOVvER20jR1v/dk4Uz9kDUouud36+5xnvV75WJpIepjBt0s+Z7PWljNlgbSuNGk/RHHSrCWriKL/D6VSQdWpipnJi6mowxaKNGVbMQYn8fzvXvIUhbhAB++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuxcAF4Pi6oRsoRC1AH5St3RX2dXWhRqw7PkeZGlqI0=;
 b=Dst6CFAdWanlkVX5JdEgPZMEPH2WkLzBhzQy+dM0rclL42Bq3bXi1kwu8/3bxNxB+uKDpV9v4496e7JVmEon3A/hZ3n/IwQbChCTMZYJiOZaxhrtCAD8hGKu3jfJlvv8mjiF9E/P6FDMb5QV9AiKZUNe9dByLdUH5POUu4m6QBs=
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 20:43:04 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::64f5:2270:18e4:883a]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::64f5:2270:18e4:883a%6]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 20:43:04 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     Conor Dooley <conor@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks
 property
Thread-Topic: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks
 property
Thread-Index: AQHZywIYlVrfSQ7sjkmfhPeXL9W8Xw==
Date:   Wed, 9 Aug 2023 20:43:03 +0000
Message-ID: <AS4PR04MB9244D1BD535A188356683DD58F12A@AS4PR04MB9244.eurprd04.prod.outlook.com>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
 <20230724-unscrew-bonnet-3c86da806df3@spud> <1908243.taCxCBeP46@steina-w>
 <20230726170141.GA1568248-robh@kernel.org>
In-Reply-To: <20230726170141.GA1568248-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9244:EE_|PAXPR04MB8943:EE_
x-ms-office365-filtering-correlation-id: fa4cd282-f117-49af-dcc0-08db99193aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ji7tR4gkA/p465Z8IMfVwbZ+nywvayVm16eHfVQsg4hoDdzPRjxs7Xo6GT6ZTDjwCBw7pb/Ke9RCJmYBqtd4drWs7a/EAO2m5j5bt+VS4NlH87XmfSTK+V++L50Hws2G04Q5kCZDuaoSVosE8vlPJu9b22flQwhxQGfHiMUKv8lNgBN85ZI0sulWCCdBhYgat4TpnKzj88A/tq/5UhMjezVqIiMQ57J+ka4nBUFlCK88Nprb9AWBYfOnSJUjHY5AqPTWIp7loJyzSaARrvaK2h24gM7fEG1sTsTLR7QPzEtAO0THUBfb8UGcLpt8dI9RrptpM9oQa7o9IgpHpcUv4A0IFe/Z+ClGUegQKLNOgCfPZ4TP+hjMlNoezEqiYG7rWAYpvk0ashYYtBmoiaSre0mqhymYmJpWP32WDRhEffPapataBoEDIRXmf7/7dBjrNpPBFSPfQjwT9YCsf3FoNomQpx5DKsrr5ZMkl3z/UogXjzi3+apF1yW/M6u4w7GGo0ewwGTNtZwEwao014o0PTOnoYuetj8z5+YbfZJy9yVycVERNJfXaUcY5wORlEyMUVFWsjABWVvL+gxD6EN3nGEiC3njwMLaJ7B+7qYFdbtn56llOiPDCkM7aNyWRuW1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(186006)(1800799006)(83380400001)(110136005)(2906002)(38070700005)(71200400001)(54906003)(7696005)(66556008)(66446008)(76116006)(66476007)(66946007)(5660300002)(64756008)(33656002)(122000001)(9686003)(4326008)(55016003)(316002)(38100700002)(41300700001)(86362001)(44832011)(8676002)(8936002)(26005)(7416002)(6506007)(53546011)(55236004)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XfiNGacEPnSaqlog858SdyJxNyBzs0hBspeCTVQBN7CPPLigPrfZEVEwoV05?=
 =?us-ascii?Q?gEDgRiqRG78XigJlr5VV8VJnKJkwSbOM+s9o0u6Kakb6dvitVyuNgF4RQst1?=
 =?us-ascii?Q?6C8xJaPvteGUrjLtpsxSwH6dQ/Cb9rhUSrL0l/vGb79Kml5eNfm76dVKUWkT?=
 =?us-ascii?Q?UpU5Kb1hnV4kccDzbzlGJsJ1UHZhYnFSMzU1YGZSNCzb4pmEEYVlVl9oldrT?=
 =?us-ascii?Q?69c3HPy98Jww8qx2Pg9i7bsfniqYIPl1MElU45HaztqJjI44LSuqTCDqVyLN?=
 =?us-ascii?Q?Ul0FKfcxvI3du7kfXSqhMZdYSLNnrIALt5xfEVNaL9dotUa5hxs1ieV/sGx1?=
 =?us-ascii?Q?B/8rUEcnWkc5NMpCiax0KHCPIlNZAjBf8nS4n65DKdwxqZhHIaZkp9sEsL8J?=
 =?us-ascii?Q?OUKAUVMXt504yhhnm2j3CX3YsDfe5bvQywIusSQH4rH1WgjjY0SddHLq1AAc?=
 =?us-ascii?Q?5rpCDgyIkNIF7o+361Sj0AdXs2Pra3sU9Dw13Ou1iTHuv6fkBJcs/gjnUwRZ?=
 =?us-ascii?Q?fZdx+wNjtEqP8/vbxNxzp3uyEGX6cYIBmqTalRT0Hrn7iY8yMWzqlP2AGTod?=
 =?us-ascii?Q?PLsv1cgTjG+vwnedIvwMUtPrISE5eGt748rhspG71cFiivoL08xCiqOEtME4?=
 =?us-ascii?Q?lZvb9Lmc1anWLYKw02zXXyOP4Jqed/bMxOZw0qFWl50sHYkVE3yYx4Q4216K?=
 =?us-ascii?Q?mIreLPGUkDdkD4hET3NSFaXwZtVGWTAaFKKwwfjlMb7y/w3t7NJeokMZz8p+?=
 =?us-ascii?Q?QDmXWeGAQSvBiyET45TTNLPwh8Mj3g8a33GielqNqy62eoNZDZwvZSJi/ktC?=
 =?us-ascii?Q?ITzJ+LzteuPCfZG9iE9LpgYB5yUtmmi+DyBygpfWSTN0RVaZHpCwRURRqDcA?=
 =?us-ascii?Q?gfMYKQFlvJN0sEx2GoMS2RJXJPWGqX5un0vPQ3OymT4q+gaaHqu2nknETPDP?=
 =?us-ascii?Q?Menn4VGx+aF/lzWy6pDjiZitQHaK3/35K+Pn1z0htJBP8gp3EZKaB7giixno?=
 =?us-ascii?Q?b4qTHH9t75danRHpVfJKlnp1fyhY0Xig2S3Une0FsN2TT1MoSZxP3dQb6HJ2?=
 =?us-ascii?Q?ukz73m1/aLLS1bzDMRokzNOpLmVJP0HSbeYRSwnZi2lL4mecXlXJVEP+hBHF?=
 =?us-ascii?Q?NeCXs1ku9j/KFkvi+TYuZKBd+G13Vd8uop/3acTOCFIBDgqPCMqBENhxF3LX?=
 =?us-ascii?Q?hHmBlqmKn4xLKwWnrGE8nCTtX/CLlsCVaStOYzdZy6O/Nm32crIXCaugslF1?=
 =?us-ascii?Q?CzaBch9WYPtkKFz47CcZKeHhEcTHj6c2uw7sX6wRfgtf/KqnZf4dd4wjn9HG?=
 =?us-ascii?Q?PRJ7ydKX5PeKEDxkV2vxK/ranhR6ReCpkzxzdcqxc6kEjloP04aPZ0/+u4SN?=
 =?us-ascii?Q?bASut5OB5q/FJEIO3vpdXbZRsS4GyCQ3t3raYqgp3QDKaZJGueu2G2aFL8jR?=
 =?us-ascii?Q?Kso6h79hc/IeVDMvZhsO/N18hz8+GK8CnbRcxfBfYSDhAksfKnRdd04S5YmD?=
 =?us-ascii?Q?ok5zwiZPCNU0nSYU8WbKVDWGLEwq0SKzOY/tQOodja7kEFW39HkP/3RfSNZv?=
 =?us-ascii?Q?k5Fx5Z2GUGB2YsvckYX6w3iPcdO3NqVj4qhfH+Uo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4cd282-f117-49af-dcc0-08db99193aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 20:43:03.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svhBNG4qn07bwSaDQvNFIzPJP6fP/rXP0BZVmBSUHW4qFAhy0A4BIg50QAv50VSaJiaeskmNv/v/7FSyxjIacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, July 26, 2023 8:02 PM
> To: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Conor Dooley <conor@kernel.org>; Mirela Rabulea
> <mirela.rabulea@nxp.com>; Ming Qian <ming.qian@nxp.com>; Shijie Qin
> <shijie.qin@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Fabio Estevam <festevam@gmail.com>; Mark Brown <broonie@kernel.org>;
> Anson Huang <Anson.Huang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; linux-
> media@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-spi@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clock=
s
> property
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Tue, Jul 25, 2023 at 07:31:55AM +0200, Alexander Stein wrote:
> > Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
> > > On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> > > > i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> > > > Add clocks and clock-names properties accordingly.
> > > >
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > > Changes in v2:
> > > > * None
> > > >
> > > >  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++=
++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > > b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml index
> > > > 3d9d1db37040..2533e16720f2 100644
> > > > --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > >
> > > > @@ -46,6 +46,14 @@ properties:
> > > >      minItems: 2               # Wrapper and 1 slot
> > > >      maxItems: 5               # Wrapper and 4 slots
> > > >
> > > > +  clocks:
> > > > +    maxItems: 2
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: per
> > > > +      - const: ipg
> > >
> > > What do "per" and "ipg" mean? I assume "per" is peripheral?
> >
> > Actually I don't know what "ipg" stands for. It's a quite common name
> > on i.MX platforms though. I opted for the names currently used in the
> > DT. The driver doesn't care for the names currently.

Hi,
Sorry for the late response.
Yes, the driver uses now the clk_bulk functions, so it does not care for th=
e names anymore (in the past it used the per/ipg names to get the clocks).

>=20
> Those names date back about 25 years to Motorola Mcore GSM SoCs. IPG came
> from IPG bus which IIRC stood for IP gasket. Essentially the bus was some=
thing
> like Arm APB being slave only. The IPG clock is essentially the bus and r=
egister
> access clock. 'per' is the functional clock in cases that need a defined =
clock rate
> such as UART baud clock.
>=20
> There is also a shared (between CPU and DSP) bus called SPBA from the sam=
e
> time which still lives on even though it isn't shared in i.MX chips.

Unfortunately, I cannot provide an explanation for the IPG acronym, I asked=
 around, will come back if I get an answer.

>=20
> > But cross-checking the reference manual these clocks seems to be called
> "jpeg"
> > and "ips", individually for both jpeg encoder and decoder.
>=20
> Given this block is probably licensed IP, seems like it would use somethi=
ng
> different and be directly connected to AHB or AXI.

Yes, the Cast JPEG Decoder/Encoder is a licensed core, and it there is also=
 an NXP JPEG Decoder/Encoder Wrapper, which provides the interface for the =
Cast JPEG Decoder/Encoder. The wrapper also provides AXI DMA engines for fe=
tching Jpeg bitstream from memory and feed it to the Cast Jpeg or for stori=
ng the decoded pixel data into system memory through AXI bus. The wrapper a=
lso provides APB interface for wrapper and Cast Jpeg register access.

From our hardware team, I got the information that: for jpeg wrapper, it ha=
s two clocks(axi and apb), for CAST IP it has one clock(axi, whose clock so=
urce is same with wrapper on chip).

>=20
> > Mirela (added to recipients): As the original author of the DT nodes,
> > could you provide additional information regarding the clock names?

I understand that "ipg" usually is IP bus clk for register access, but I am=
 not sure. Experimentally, I was not able to get register access unless bot=
h clocks were enabled. I'll get back if I get more details.

Regards,
Mirela

> >
> > Best regards,
> > Alexander
