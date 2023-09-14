Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91877A04AD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjINNAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjINNAH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 09:00:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF411FD9;
        Thu, 14 Sep 2023 06:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4otSgKBdYjKUOG6FEDNNtAE6u7VGkwrEE7qX+xjPBZ1++TCw09XfsSLlGsIdendRo0hwL5Dy+n75yUmWQX9cVBqri2/EAgFsXyRpQMjftbPdl5/mf/lb8hc0JdGAPy00wx7mf1eKxrUICXfrC4+gB6YLRBcIn+jLxMExN5bGvpmKq8Q8R2k/8K7bjvuAk/XXYMb9DsaIEsX1S7y5vM0APkJKsTageWT9R/dYP74pkevC5Imp6jS8ShH/Mo8XzXJg2Brka+8xET2CX7G9hqR7k5C/zs/MlVU9G21mV8Shcopj3r8z+cTNx7FceL0sumI5qimixtioNOG//zdNuPkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg2CJtMEShja4m4ZEKzOeikEGq361NFFqmrQ89J+9M8=;
 b=XzCuxMePpx+fDpt8ujKWLDTaT3OzAtDmOBzVwRASFVM5klMPeoAbP6+vu8aS1xlF9m6ilPjUMuAUioAkZ+oBfSTwAiFC0nyUuWM1/bpFX2td9csYd6U3w53sZoTb4sFugD+spYhiB9DTxJTqrghscFBky9DNaG44WPC5SIIPYeDmDbSqeVcS8SZhggprbDt7CbdtJH/9cYdMRe1VgFBkAWw1yWUecxDsDO/Qpo54yWw25UPl1/RNWOoQVPNutrAvT0sRM5TLAGXtGsxK3bH1W7iegvRUM79xmKfWsM7grR8eo7/1CEdnhmDI6ip9Ey54oTQgtSUlBHO0ylbJqbtbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg2CJtMEShja4m4ZEKzOeikEGq361NFFqmrQ89J+9M8=;
 b=i42mlYu5TMwxdEDmZsWbxweX4RPeBjqkA6Z45JESdFQTA1UN37YHMJ4d6uVaJJlQgQNy6AfTn8QcYABb4fg8UbmEj/BswzPd7D9AdngOh5q4snGHwZQRJ5TBDYooDhYB8iuqaoJ4ZbPhUeY5PEu2afmOUeyuMblGzJXVYUhV0J8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS7PR01MB11916.jpnprd01.prod.outlook.com (2603:1096:604:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 12:59:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.021; Thu, 14 Sep 2023
 12:59:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Walle <michael@walle.cc>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Topic: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Index: AQHZ21J3se5Zb26g9EyYNYpYnGOcfLAC8SaAgAAAdzCAFx0SAIAAB1IAgAAG7YCAAAE7gIAAAjsAgAADP4CAAAIPYIAABtiAgAAZoYCAAAzWMIAABSAAgAAFC3A=
Date:   Thu, 14 Sep 2023 12:59:59 +0000
Message-ID: <OS0PR01MB5922AED5B1490E251669F45186F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
 <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
 <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
 <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
 <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
 <737c6865703b8e294601d86a911691da@walle.cc>
 <OS0PR01MB5922A4F16DE8923373AA5DD886F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <41a960b2a039ab88cb8a6ed6ed21e067@walle.cc>
In-Reply-To: <41a960b2a039ab88cb8a6ed6ed21e067@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS7PR01MB11916:EE_
x-ms-office365-filtering-correlation-id: a4de98e7-a97a-4f91-1930-08dbb5228088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xM+Pu2TPB1lpCvNoPTmaT3CPLD4FX8slcr/olNU79G81I+eihMqLMFg7haKtnsXYWsYEUySMT5vPnWj83qrpxMHhCf7RWYtXvP81x89R5sF/R5AhL+1NsIVfoMWDkmF5lMq3hPU851vRhF382WZTd830ga3yXKqrCHog/KQW/ETKy6R7KOarFIIcJmBnYv2wSp9rnuJLGiIzUqRFqTzVqRK3GermmsjVD0pWeal/vIkGb7IFywQQL2VVxE7TCGlGPppXZb6KoEkizB16LSH1c91bPZvXMgrvKJDQQT2z6p6Q7N7LXs2p8ErhjP/iQCrW3jyaMnp4x8r9espSYHqoWRzcpt22FAb9L/n3+iRD4EibU1B8b8esvzyXp8i93hYgqHcdyUW7TrlPdfLFq2OB6tBBh0oO0NWu5H3jTUL6V3DtwBEYZdkRlp/jssdM3eMlc1rMl3hCt7IFLZKHx5knNL0/hLpGPvEjkGgrJyagAY6hZm5ItAeCfBqoRBm8t1+EA62jGFCSpTEiqX8ZtnDlWa6X0O7PgkWMMqzDIHNb9bgT+DFAZQ7VAeLDXNxNjq29jymE+GakwrlexHWbAo3yqs+BvbAELuTmgF0GVSSoxYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(83380400001)(9686003)(86362001)(38100700002)(122000001)(38070700005)(7696005)(55016003)(71200400001)(966005)(478600001)(76116006)(6506007)(26005)(4326008)(8676002)(52536014)(7416002)(316002)(66556008)(41300700001)(64756008)(6916009)(5660300002)(54906003)(66476007)(8936002)(66446008)(33656002)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FyT3B+ug1dhaUMS92tzMBvBcQ9pC+iZuU4rwcLoGmlpfE0y/MVd2kf+DUYmj?=
 =?us-ascii?Q?xlXMmDe0aD91eapv4989HNJyUuA5YL5WPTjeQgjcqzNrBx+fdAoN2Kk59Kyy?=
 =?us-ascii?Q?crcwQZDSgj+YW4A9OIAY+6O+Y8KzkLPNHMnyO6FcwRwreF6EvsZ4bD9e6WAf?=
 =?us-ascii?Q?A25aUOBW/rJq5H63qr2jlq1brRiR/oogyKCSQE/M6/pWOYZ9Ra2jvgvmmw0y?=
 =?us-ascii?Q?9tCPTiQzYtq5NFPMtZbcnsh+PT/w74FgPAQC45NeX8J4Odt9T/Ck4G5HPJ3d?=
 =?us-ascii?Q?h1j4y7uY6f7saZCExD8ZIaVn8f057Gw9eokw6bbujYsoI7kvI9nvIvyW/P1D?=
 =?us-ascii?Q?TXnVT4gp+MW7mgNVuwsqVnnhnxGBoDgU6l1sHZe+xWRtLNiv4/5gP6gePWje?=
 =?us-ascii?Q?onHHjk8TEZn0j7z4jv2jWzk1ckxsjNWiqlR5oX5rHuXJYgcTyA8Onzyiq3sT?=
 =?us-ascii?Q?l1jshLmgKRnrZ2I1gLfMaD5MCHrdkzOpPieLQsJmKuozyPPKsx7sMx0O02jx?=
 =?us-ascii?Q?V/M6E/wwr+8Ba94CnQ+Y/ZZSBvJ/ZeZChXLagECNrdO8spNTVMQUC75fdrIk?=
 =?us-ascii?Q?JtKhSwU8k42QsNOZ50tDXDdwnTZuahYiZ5M91dqR+DGC1envdlhLu4PUDZW6?=
 =?us-ascii?Q?T+M271faG+azTdfIAN8DH7PtXDrd6EUs7CddOZUlyLboxjmz5/pNkEL6PCuy?=
 =?us-ascii?Q?ASad68IuEwnsKxnGP4eZbOUlsenvoNb6Uvr6Uln32A5sTCbFf3MmKEnmwYuB?=
 =?us-ascii?Q?Hghbf65txDXejGRjxgo3bIZ0sjW0Ro1DGAVt2j94SP5qHQGiVVu/uOLvPCOj?=
 =?us-ascii?Q?ajkogqJY/VBnh9vCqLAyEy+Bjky1BOtLX93YWnOIIDL1oKpKVC/jRj+EcEZ5?=
 =?us-ascii?Q?Hn2/2YV0INjlu7ay9HAIwG9lRRNmK42uJ8rcCw/L4TC3LOaWWA6B2/aNn5k/?=
 =?us-ascii?Q?WMk5s7hA8UNjr1U/XnG9YRd+t0/Gz74gaE8MU1zX1QJoiDPO2JiMPuqPfsKF?=
 =?us-ascii?Q?UWofHzXDRl2BWZWFTTsfqT8mlhUq552an9tZ+wy9yY6aPBeJJDVUdOM2jSdy?=
 =?us-ascii?Q?Ed69TWQ2DQBaKACGSHd5vqy6R/CSQXcspF7u4594iwwWB9Q/GD1CPET+V3Yv?=
 =?us-ascii?Q?9lXwcboJBaZmW7XAwfFGGV/VAN8wOCJffKPQWIoEKs/sW/RCwfhBpxLToq9Z?=
 =?us-ascii?Q?PMHlANY7A/AMGkCnfcPgJq7h5AM28Xpn8ryp7+TPIBax2ALCwr3sVVRzaTWs?=
 =?us-ascii?Q?lOWOqIOIUX3CMDaiEGrAX/sKtQ1hsfhxHsCOT9QCSwsjNXiydRCLFRmCbpzK?=
 =?us-ascii?Q?DhPHls09pmWpaocItX2QMBtL1ggpAS0uzgV8SdVFlWMmf5tLdAXzhaRk7TLi?=
 =?us-ascii?Q?XJ70Qo3VBMY7qMoj/o8MIKiIhE2VJXQqc0JGZaDELZlN/fa5BpNgRxxLf3uG?=
 =?us-ascii?Q?3T9fz+/EEDd3/PNWF9NVQPoVEv9HF3IOzFf/7U2kv5BTiChuPptyBKkpZI0d?=
 =?us-ascii?Q?ugKBEr9vF9mbjpBr87UJ299sn3QRUVzCuiZIUEAKLemEK2Ll9nK/20j+iLQb?=
 =?us-ascii?Q?zL0O6eoSsfmIKLzkO+TsgL5oh/h/p57/nuIYWO/Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de98e7-a97a-4f91-1930-08dbb5228088
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 12:59:59.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t942Ad3F/Wna0L5cBRtzOK1gL6DFmp+SFuAyuGUg5Sg27DR1uG4gwtrus58bSPahtbCClOaC8ZYtQfNsyjOY1hWdE5VCTGqWcQdBvZNgRfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11916
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Michael Walle,

> Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash
> type
>=20
> Hi,
>=20
> >> >> > I'm not sure we can do that, as this code is part of the
> >> >> > hardware initialization during probing.
> >> >> > Biju: is this needed that early, or can it be done later, after
> >> >> > the connected device has been identified?
> >> >>
> >> >> I need to check that.
> >> >>
> >> >> You mean patch drivers/spi/spi-rpc-if.c to identify the flash type
> >> >> from sfdp info and pass as a parameter to rpcif_hw_init??
> >> >
> >> > Something like that.
> >> >
> >> > That configuration should be saved somewhere, as rpcif_hw_init() is
> >> > also called from rpcif_resume(), and when recovering from an error
> >> > in rpcif_manual_xfer().
> >>
> >> I'm not sure I follow everything here, but apparently you want to set
> >> the mode of the I/O pins of the controller, right? Shouldn't that
> >> depend on the spi-mem mode, i.e. the buswidth? Certainly not on the
> >> type of flash which is connected to the spi controller.
> >
> >
> > How do you handle the IO states sections mentioned in the HW manual[1]
> > and [2]?
>=20
> What do you mean by "IO states" you don't configure anything on the SPI
> flash, do you?
>=20
> I guess you should have to configure your SoC SPI pins in your
> .exec_op()
> callback according to the buswidth property.=20

Here, same 4-bit tx_mode IO pin (QSPIn_IO0 Fixed Value for 1-bit Size) to b=
e configured based on flash type and bus width right?=20

For eg: here Adesto flash requires HI-Z for IO3 pin and Micron flash requir=
es setting "1" for IO3 pin for 4-bit mode to work.

Have a look at the other spi
> drivers. I'm not that familiar with the spi controller drivers.
>=20
> > Without this setting flash detection/ read/write failing with tx in
> > 4-bit mode.
> >
> >  [1] Figure 20: QUAD INPUT/OUTPUT FAST READ - EBh/ECh
> >
> >  [2] section 8.14
> >
> > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=3D160=
8
> > 586
>=20
> Section 8.14 shows a Read with Quad I/O and the flash will tri-state the
> I/O lines during the command and dummy phase and drive them during data
> phase (and expect an address from the SoC on all I/Os during address and
> mode phase).

I agree, What about micron flash??

Cheers,
Biju
