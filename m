Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0747E549E
	for <lists+linux-spi@lfdr.de>; Wed,  8 Nov 2023 11:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjKHK5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Nov 2023 05:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344395AbjKHK5h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Nov 2023 05:57:37 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015419B4;
        Wed,  8 Nov 2023 02:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEFw6RfgBj4MGvYn4t8cTkf+IFmXGfWCPMesXUGx3KbhU3UYTv2GNqj2qa0oEnHRY2ljg7oj/jo0ln/GjIgVtI17Hg7OTEk51YsqPSmWgsOO/WnzAmvbhIQk26E2tKIJhPOBZvBaVE9ZieG6Y27CX8ZqOAr2YXkwqyC63yhvfxM6kkMWscpf+lce0S45/StpYC1jsVuiZ3CsIMOe0xO7qpQtwur549SCViZF3wDAvAdJ6RKkvxlN12zvG76vyp+KrjTKZcV2rfg1naDaes7DTs4XA2/9ZW927FbjHE70Ureeey+pgZd7MIXovAv3hPGhLMG21erUpfxg03rXO8Wo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXcvjCovY+0hUBK5CYTV5QlDkJ5qKCBehRYLbSsjZQ=;
 b=nXi/NG1gD+/eePq95FLMXlClxNgj+yR0BjCxGQEpUG3qzMdxslWlxONoAzKuflTZuc/RFvVfLv0ijSB4nPGz1LYomSmXfIzq6G8OcNOJyvlSWzd9clGr2fC26gkJWblTLEAxhGB++tLdpLzRQcoUW1NGqaEb4cwrYluQ/+RjF3v0NMpUuX6iecrZicRx3XfXZDBQVnKUUk0uTHk4lf3r1RXtbUfGyKbzUdJQ5XcQvxgxo28UExOVYj0guJCnKeQMPEEUUyRnXfYoyKs82QGQwN0TEDSrTOLZbz/VfVLWOxs4MohFKgfDfVf5/O1o6qnyZ4qzER2Z1kZawRdLkETfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXcvjCovY+0hUBK5CYTV5QlDkJ5qKCBehRYLbSsjZQ=;
 b=oMUrAEHJfO0/0JjbzeQMVnxWusouWAkTdtVeVRlm4qg4Ve6sJwvq49mEC4IzkqUAUtRShm6PBjawXccITT5mHNLDBAgmreu1ZoIiG39zgNUEh8gMLxbZjtHqGZJJiOkZFGcPpchWNwkA0lPVp3LaqTOtm9qTbBFE6XahHz/8eO0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB11921.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:57:31 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6cb:4ed9:b0be:36c0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6cb:4ed9:b0be:36c0%7]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 10:57:31 +0000
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
Thread-Index: AQHZ21J3se5Zb26g9EyYNYpYnGOcfLAC8SaAgAAAdzCAFx0SAIAAB1IAgAAG7YCAAAE7gIAAAjsAgAADP4CAAAIPYIAABtiAgAAZoYCAAAzWMIAABSAAgAAFC3CAAAfDAIAABFoAgFZEibA=
Date:   Wed, 8 Nov 2023 10:57:31 +0000
Message-ID: <TYCPR01MB112697B3735BCA12924895A2C86A8A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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
 <OS0PR01MB5922AED5B1490E251669F45186F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <9bf6cf6f104145080d38c8658000c24b@walle.cc>
 <030c666c5284bcbd20f6d09caa8f077f@walle.cc>
In-Reply-To: <030c666c5284bcbd20f6d09caa8f077f@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB11921:EE_
x-ms-office365-filtering-correlation-id: ccc743fc-2acf-4eb8-fe5e-08dbe0498186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ac7WLy9y/zpRejoLZKjltE/GeY2wh+Il8PDPSCj9BPpgJC6rdiTRwNK33umyuReuX27vZJnM2jP7DO7s8PfiH5VLHSTFcF0oKlki/FIsdv2WoeFb4OE0XRMh0+LF9x61m0LqC10MAbbhve7xrL2D6IFMO1hIzkUceSJKvk01dPkPpgZr1tnKn14twBlAo3GJR11X/OI1Hj4INgJcSZ5RT3wCCEDS1QFOlweIKY1a/nDx6DgqYYB3la+vULgRy7dMyEsYWIZ6t+i+INcBGwuOyGgfEP1ZeGXZkjKIIIi3lFdsk70SWUlgWU8lnflu4UV0uOOTuHM90kcSV2DewyT4cAQjd5xiK5BgfKMwP0cBwXrccBEqQghYIuv63cbjP6PbIZNowVTUQrjDV/pJ4EBIio4piNyJdtnl45E67Qe1wTUr8tXPjmwl8g/IY8V75VuEis+qELkHf5h32m0q3rBKV1DbW3upl6XmcYZaZGyRgMka9KEhLqVFbD4yzskH+bKmSyEkK076VS9WmPukRiqHVQf1IfVab9RrEbH/BI4LDHLWBojL5oASVq4ErzjXWAT9cPIcWsyfmjT9yUJB/N1KxZ65JBFt1iFM5NItJKyykkelZJy7wEJp5zfyTJhZHINd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7696005)(83380400001)(9686003)(71200400001)(26005)(6506007)(66556008)(76116006)(478600001)(316002)(6916009)(66446008)(55016003)(66946007)(64756008)(52536014)(4326008)(38100700002)(8676002)(8936002)(54906003)(2906002)(41300700001)(33656002)(5660300002)(86362001)(7416002)(122000001)(66476007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lPN82Dj5K29u9Ht9H2LPdm+kNmZpxkg2tZWOqiRLFKyv/5SaTyJAS8aK/wQm?=
 =?us-ascii?Q?mpr3SiH3duyfsVFCByG1gklz/hHXGMurC8SD5N70/z+LNrfq8DL1ykmTj7MB?=
 =?us-ascii?Q?VcWe1IH355e8ClTMbrnBFw2brRDsmY9Oc+uMs0iIobpeY5UI2BNSxlNSCai7?=
 =?us-ascii?Q?FoWAvzrMN3HnT2VCuWJ8ZZZPE7iQfnxT+y4l6rnb8KKQhk2cAdSptfYfqDiA?=
 =?us-ascii?Q?MQ08VqWDXLdOchiq7bxh+N9IIZHVG9DYtmwad0r7B9KEuGBCRhqWdc/UVXIs?=
 =?us-ascii?Q?zD8PVyhuo/yKNLJwN5D3nNlxpVeiMyQzKg4zxwNVuFGHX65IZANxmGXi69vp?=
 =?us-ascii?Q?e5C8c33OObHjX2S14wDVxNbgU6+7cXO5TaCcMywlNs27QhyanTp/3lvuf7Ku?=
 =?us-ascii?Q?xiAQEY3B+FRKhgtJlXoFo4SZDUc7ZfqAJRxWam58yLBKy877aW7HL1IqKPT8?=
 =?us-ascii?Q?dxd3PI6fSnrtqhW1zvqV5xqC0aM/DszOMWGJOOAYu9NNw3qq6G8fCjxa/Ms1?=
 =?us-ascii?Q?7dkf5Lk+iH8uJqswCRIxQSiR61ovrlm4wZ0yWTZekT67sVKz1yojMQZgjQFt?=
 =?us-ascii?Q?edXQkMZi1RRPDnTPin3lQEq/vgbcFFgLHD40f4CCZcy4miFMrZlhssDwSf7Y?=
 =?us-ascii?Q?s5SdZfnFml0+hw5hFAWfWrxHX13EbAAmg/lDN8xY7nrcNcAWX3fDX8/ynhYv?=
 =?us-ascii?Q?peyeIDAKveyBYI/ibe4/HoV1b03kw6LF5Vz/+81JwysWyqlZuxyXk7H6s8wJ?=
 =?us-ascii?Q?HMadLgTAgl4hed/qaK2p3qO86LHfO3uaB+OGiDSw1gkTNTze5wO4DLN398tZ?=
 =?us-ascii?Q?OeEIkayPiMRmd0SLDZZSS5EJBHgJXYq3gUIII8BIXFMJrAYx3ve/pC0GQhvq?=
 =?us-ascii?Q?BaeoXDXlRpHqoVDeNDUQCE6Q4lTLM8Pdq4cjne+9Y7cN7LYUsqnXniWBDJDT?=
 =?us-ascii?Q?V6BQMKxzYmm7VPDDo+k5mezO30jpAsWiol2ebiddNZ5cKRtCcPEru+SWykc6?=
 =?us-ascii?Q?Fmj7u4fkK0vJgrLqZU5+Vg2iLrCSEed5SX91qFaOJnzDPKiHKDBGqNwKy8bD?=
 =?us-ascii?Q?700Q9kQOuWV4EwnTI85463t/D7tYUXXyNDZ4VKb85dwusIyv3AhfpdUWDMsi?=
 =?us-ascii?Q?iwIAovyUIjryF2cSpHNlkHzh5Do/lYCXwLrWg9oJvWP659+SnfxkGqZL7bCq?=
 =?us-ascii?Q?vxYygHy2J31+2hFXgqHGYkwSZl3YSluKovyKin+4IKZ/RRM59OKYYQr8E0wD?=
 =?us-ascii?Q?+huFySSAW+E9LhpENIgYvXiArxP/V/Myk3sF0XeKnpPaJONLtXx0xSCNdSYE?=
 =?us-ascii?Q?D1k7cXGkGBJzWNimSRmNIDHNLol+KpVRRtfCYaaXBpxH9dEMYJMdqmKQxZB/?=
 =?us-ascii?Q?qcj2cGYi59XtlgOgfmboBeCX9TEKs9PT4A4qqMXWwi7cqRhd0iQWH61ZodJb?=
 =?us-ascii?Q?bOIRzY6W6LW5iWT5+1ncnU2ZvfZ2Ntpr3EOBWi85nEgRx6746hw5hMSDNTs4?=
 =?us-ascii?Q?Wy/wKyABDOhsYVtKUOLvtmTxyy/zRrGfuWWnkpgdGZh80/lja1zIdAl2R856?=
 =?us-ascii?Q?SGuEAWGHd0fvNCc1daeQPoXgnaG1sNO9R4mxLhd2fVH25+sj1lZifM517BkT?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc743fc-2acf-4eb8-fe5e-08dbe0498186
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 10:57:31.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFgrt8TVjQLGEyoSYzbYzsHG1K94wy1V6hHabPEPMtraEO+TdPGFV90tAh8lNyTRviR0C1jnaH04W8TiqS/4oOBjkcGeWnw047r+Vijjk7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11921
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Michael Walle,

Thanks for the feedback.

> Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash
> type
>=20
>=20
> >> For eg: here Adesto flash requires HI-Z for IO3 pin and Micron flash
> >> requires setting "1" for IO3 pin for 4-bit mode to work.
> >
> > That is odd. You'd need to ask Micron, but I assume it is because
> > IO3 is shared with hold# and reset#. And there is a note "For pin
> > configurations that share the DQ3 pin with RESET#, the RESET#
> > functionality is disabled in QIO-SPI mode". So I guess the reason why
> > they asking for a '1' is because they don't want to reset the flash.
> > I'm pretty sure, we don't really support this in linux, so you'd
> > probably want to disable that feature, i.e. see Table 7, bit 4. You
> > could also come around this by enabling a pull-up on that line
> > (assuming the SPI controller 'drives' HiZ during command phase).
>=20
> Oh and I forgot. You probably can do some kind of fixup (where you set
> this bit) for this flash in drivers/mtd/spi-nor/micron.c.

Ok will send an RFC patch.

Cheers,
Biju
