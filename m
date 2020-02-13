Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0315BCEC
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgBMKg6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 05:36:58 -0500
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:44515
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729466AbgBMKg6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 05:36:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX8St9iqhdjBja2JA37fCzf3uSO17YRVRO+uZz9diesGJA8NQldJsleRwUR873yyTjYPwJjFvoKXWHlUjSRF6UFKmTnmjknTzLqpRuprqx2VfBJViZI3JG9snpndCHpHQJhA2CD3Fr5Jvw8/ph40JcjDw8JnRlWzgTD6lCf/4CqiYCyVeLIJR8Hp6Ly2XLYmu1f45zxdu7D9OMJyN84B3uLvCv2Y3x46ufhKY+ctgykic2rEHaUYSIXvvUdl41K38huYjxwoAfs1hlQ4MAebU1Mms5wWrSnkGaClxapV81ARSOjgcZjk32u5HFkcbZgwmaexWF0kV0N2X50MO5+TgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TnEZzWey7sU73RtYvDyCdH1M3xKwHMzOaUS3FB5/ik=;
 b=l2s9mBdIWfkspKaG7gdrhEifQPOvSHUYLkmKcDVTQvWRW3SffyC9l8M47e3PH4PKLRs+RqCjKGijWTCdTW25DpylzJ+i2HPUsyqqRA0tncJDyuy9OlMOrqBx5zagmldCtNMZrS0bbTxO9MYhQMN+f31BUK/LD8o77+bso9WV7qYyE4ibH0w9b3vRDwbO5OAHBkW3QAYVPQxKtJgVVsjAW4t+SV+MoqVOEpTKz4OHu5TE6rd2kn4HYuukHnuO9kKeAEjLAozetWq5ZfKmhLkXzAPtE70qCalb225FHSHT7OvWqy0l7awZck+LAB+MPe6Egu56zLnC7ITeKrOeSAv/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TnEZzWey7sU73RtYvDyCdH1M3xKwHMzOaUS3FB5/ik=;
 b=chHajl01TvoQa9XdQ5Z/8m/fXTUpljp+EeV9Am/rjSG4M3LZLUQOFOifSxZYsKE8kf3mrP9xRBjk9t+jIB9BMBY4opmxg51gmYK56d2ULSeZMCipahJdxcYbnJI8qChgUh/CgspM8Q8SsjcjroosO0ahUioYWhUfmdte9hFJfAc=
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com (52.133.43.147) by
 AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 10:36:49 +0000
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3]) by AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3%7]) with mapi id 15.20.2707.031; Thu, 13 Feb 2020
 10:36:48 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        "alexander.sverdlin@nokia.com" <alexander.sverdlin@nokia.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: RE: [EXT] [PATCH 9/9] mtd: spi-nor: add support for Cypress Semper
 flash
Thread-Topic: [EXT] [PATCH 9/9] mtd: spi-nor: add support for Cypress Semper
 flash
Thread-Index: AQHV4OAD4cj1SRIK/02+bS4dVIBMLagY5ioQ
Date:   Thu, 13 Feb 2020 10:36:48 +0000
Message-ID: <AM0PR0402MB3556ACFC1EAB0FBD98099309E01A0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20200211133348.15558-1-p.yadav@ti.com>
 <20200211133348.15558-10-p.yadav@ti.com>
In-Reply-To: <20200211133348.15558-10-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2ee7d9e-4d83-4b45-fa80-08d7b070a16a
x-ms-traffictypediagnostic: AM0PR0402MB3570:
x-microsoft-antispam-prvs: <AM0PR0402MB35704227A8C15061933D080BE01A0@AM0PR0402MB3570.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(4326008)(186003)(30864003)(55016002)(26005)(6506007)(53546011)(76116006)(66946007)(316002)(478600001)(2906002)(64756008)(966005)(66476007)(66556008)(66446008)(71200400001)(9686003)(44832011)(52536014)(5660300002)(33656002)(81166006)(54906003)(110136005)(81156014)(8936002)(7696005)(86362001)(8676002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3570;H:AM0PR0402MB3556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f22r4JWINmU8r0CVT1I4/KdjweEDSxPLpiSd9Qlbfr2R4+PVcjAlWIgt3fAjs7xNsgVkPbyDfhSP31e+2oI1hLrEI0P1q7XpgNYzaldf8RphAM19ZHvavueH2QP6p42OEfxwB4zTsZ6AtupaZ5TzJoFKqxP9nByLOUwTLMO/n5lHCrsIhjDc7P0A7ybJlSscXhajSsXyW4M9LoTswk5mpwVOfKHV+egBw+T3u1lfmUzW7w81k1u7bTYnL4B3kcNgf1oR0zMSIdxtiNFGd2od3UVnDz3ya3WiwtLfDr8dw2woVKiRbzOMqRVuMfOA1AosikGUsaEcKdUfXrYf4ICAnWDuFS3VQOccglQ+0O+sZijMp3nUXIGfz7lrlP8uknafU7ccUeWoN/dSLC2FNN1pRUyNk9Sa/cIFY2rqTCZoIywfl9T4N1n+SeDsxs9ItcQKSKP9PMco6RZ3AxwZR3Zrly6JGuFk//DCJMuBkTCWFT8e7H+e6pMfNPPXOyJ5IgUTK37DHffM0xsLdhgBSiwByg==
x-ms-exchange-antispam-messagedata: huiOr64nzZPihzrf2uVAqu28t2ai9YBWg46hUvkCJvAYqiMTzKqAUv66lY0QnAQmy+AjLvAHBFlZMZfQGZDwQlFpyL4Sl7dNEN+VkxcNA1b4LdQbg9DovVYFNKHj2DbWkgvElTbtvq/uFEVo5V2qww==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ee7d9e-4d83-4b45-fa80-08d7b070a16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 10:36:48.6553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 319mb0x8oRxtzSUp+nEWkR8wtdGJZbnnY1yGfNn+dUr6nhJbKulYEIg2biBqC7W9NorihCvRhiIYo/x7uWx3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3570
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Alexander

Hi Tudor, Vignesh, Pratyush,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Pratyush Yadav
> Sent: Tuesday, February 11, 2020 7:04 PM
> To: Tudor Ambarus <tudor.ambarus@microchip.com>; Miquel Raynal
> <miquel.raynal@bootlin.com>; Richard Weinberger <richard@nod.at>;
> Vignesh Raghavendra <vigneshr@ti.com>; Mark Brown
> <broonie@kernel.org>
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; Sekhar Nori <nsekhar@ti.com>; Pratyush Yadav
> <p.yadav@ti.com>
> Subject: [EXT] [PATCH 9/9] mtd: spi-nor: add support for Cypress Semper
> flash
>=20
> Caution: EXT Email
>=20
> The Cypress Semper flash is an xSPI compliant octal DTR flash. Add suppor=
t
> for using it in octal DTR mode.
>=20
> The flash by default boots in a hybrid sector mode. Switch to uniform sec=
tor
> mode on boot. Use the default 20 dummy cycles for a read fast command.
>=20
> The SFDP programming on some older versions of the flash was incorrect.
> Fixes for that are included in the fixup hooks.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 192
> ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   |  14 +++
>  2 files changed, 206 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index 78e3475fa2a9..367e3d0f65aa 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -260,6 +260,12 @@ struct flash_info {
>=20
>  #define JEDEC_MFR(info)        ((info)->id[0])
>=20
> +/* Forward declarations that will be used by s28hs512t_setup(). */
> +static int spi_nor_default_setup(struct spi_nor *nor,
> +                                const struct spi_nor_hwcaps *hwcaps);
> +static void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
> +                                   u8 opcode, enum spi_nor_protocol
> +proto);
> +
>  /**
>   * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem
> op.
>   * @nor:               pointer to a 'struct spi_nor'
> @@ -2241,6 +2247,65 @@ static int spi_nor_is_locked(struct mtd_info
> *mtd, loff_t ofs, uint64_t len)
>         return ret;
>  }
>=20
> +/**
> + * spi_nor_cypress_octal_enable() - Enable octal DTR mode on Cypress
> flashes.
> + * @nor:               pointer to a 'struct spi_nor'
> + *
> + * This also sets the memory access latency cycles to 20, which is the
> +default
> + * in the spi-nor framework.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_cypress_octal_enable(struct spi_nor *nor) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       /* Use 20 dummy cycles for memory array reads. */
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       *buf =3D SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20;
> +       op =3D (struct
> spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG,
> 1),
> +                       SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR2V, 1),
> +                       SPI_MEM_OP_NO_DUMMY,
> +                       SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_warn(nor->dev,
> +                        "failed to set default memory latency value: %d\=
n",
> +                        ret);
> +               return ret;
> +       }
> +       ret =3D spi_nor_wait_till_ready(nor);
> +       if (ret)
> +               return ret;
> +
> +       nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].num_wait_states
> =3D 20;
> +       nor-
> >params.reads[SNOR_CMD_READ_8_8_8_DTR].num_mode_clocks =3D 0;
> +
> +       /* Set the octal and DTR enable bits. */
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       *buf =3D SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> +       op =3D (struct
> spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG,
> 1),
> +                       SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR5V, 1),
> +                       SPI_MEM_OP_NO_DUMMY,
> +                       SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the
> Status
>   * Register 1.
> @@ -2453,6 +2518,130 @@ static struct spi_nor_fixups gd25q256_fixups =3D
> {
>         .default_init =3D gd25q256_default_init,  };
>=20
> +static int s28hs512t_setup(struct spi_nor *nor,
> +                           const struct spi_nor_hwcaps *hwcaps) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       if (!nor->spimem) {
> +               dev_err(nor->dev,
> +                       "operation not supported for non-spimem drivers\n=
");
> +               return -ENOTSUPP;
> +       }
> +
> +       /*
> +        * This Cypress flash also supports hybrid sector sizes. Make sur=
e
> +        * uniform sector mode is selected. This is done by setting the b=
it
> +        * CFR3N[3].
> +        */
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3N, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_IN(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       /* Set the uniform sector mode bit. */
> +       *buf |=3D SPINOR_REG_CYPRESS_CFR3N_UNISECT;
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3N, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_err(nor->dev, "Failed to change to uniform sector mod=
e\n");
> +               return ret;
> +       }
> +
> +       ret =3D spi_nor_wait_till_ready(nor);
> +       if (ret)
> +               return ret;
> +
> +       return spi_nor_default_setup(nor, hwcaps); }
> +
> +static void s28hs512t_default_init(struct spi_nor *nor) {
> +       nor->params.octal_dtr_enable =3D spi_nor_cypress_octal_enable;
> +       nor->params.setup =3D s28hs512t_setup; }
> +
> +static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor) {
> +       /*
> +        * On older versions of the flash the xSPI Profile 1.0 table has =
the
> +        * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0=
xEE.
> +        */
> +       if (nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode =3D=3D 0)
> +               nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode =3D
> +                       SPINOR_OP_CYPRESS_RD_FAST;
> +
> +       /* This flash is also missing the 4-byte Page Program opcode bit.=
 */
> +       spi_nor_set_pp_settings(&nor-
> >params.page_programs[SNOR_CMD_PP],
> +                               SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
> +       /*
> +        * Since xSPI Page Program opcode is backward compatible with
> +        * Legacy SPI, use Legacy SPI opcode there as well.
> +        */
> +       spi_nor_set_pp_settings(&nor-
> >params.page_programs[SNOR_CMD_PP_8_8_8_DTR],
> +                               SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
> +
> +       /*
> +        * The xSPI Profile 1.0 table advertises the number of additional
> +        * address bytes needed for Read Status Register command as 0 but
> the
> +        * actual value for that is 4.
> +        */
> +       nor->params.rdsr_addr_nbytes =3D 4; }
> +
> +static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
> +                                    const struct sfdp_parameter_header *=
bfpt_header,
> +                                    const struct sfdp_bfpt *bfpt,
> +                                    struct spi_nor_flash_parameter
> +*params) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       /*
> +        * The BFPT table advertises a 512B page size but the page size i=
s
> +        * actually configurable (with the default being 256B). Read from
> +        * CFR3V[4] and set the correct size.
> +        */
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3V, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_IN(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret)
> +               return ret;
> +
> +       if (*buf & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
> +               params->page_size =3D 512;
> +       else
> +               params->page_size =3D 256;
> +
> +       return 0;
> +}
> +
> +static struct spi_nor_fixups s28hs512t_fixups =3D {
> +       .default_init =3D s28hs512t_default_init,
> +       .post_sfdp =3D s28hs512t_post_sfdp_fixup,
> +       .post_bfpt =3D s28hs512t_post_bfpt_fixup, };

As of now, s25fs512s flash also require post_bfpt_fixup proposed in this pa=
tch.
On other thread[1], Alexander was also trying to resolve the same issue.
Since s28hs512t is a hyperflash and require other fixups compared to s25fs5=
12s flash. I have a suggestion to make.

Let's make s28hs512t_ post_bfpt_fixup more generic "spansion_post_bfpt_fixu=
p" and use that fixup for s25fs512s.
A generic name will be better as this bfpt_fixup is needed for other spansi=
on flashes as well and not only for s28hs512t.
Please let me know your views.

Also, please see proposed diff output on top of this patch.

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b557c67..75da26c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2455,7 +2455,7 @@ static void s28hs512t_post_sfdp_fixup(struct spi_nor =
*nor)
        nor->params.rdsr_addr_nbytes =3D 4;
 }
=20
-static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
+static int spansion_post_bfpt_fixup(struct spi_nor *nor,
                                     const struct sfdp_parameter_header *bf=
pt_header,
                                     const struct sfdp_bfpt *bfpt,
                                     struct spi_nor_flash_parameter *params=
)
@@ -2490,7 +2490,11 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor =
*nor,
 static struct spi_nor_fixups s28hs512t_fixups =3D {
        .default_init =3D s28hs512t_default_init,
        .post_sfdp =3D s28hs512t_post_sfdp_fixup,
-       .post_bfpt =3D s28hs512t_post_bfpt_fixup,
+       .post_bfpt =3D spansion_post_bfpt_fixup,
+};
+
+static struct spi_nor_fixups s25fs512s_fixups =3D {
+       .post_bfpt =3D spansion_post_bfpt_fixup,
 };
=20
 /* NOTE: double check command sets and memory organization when you add
@@ -2732,7 +2736,8 @@ static const struct flash_info spi_nor_ids[] =3D {
        { "s25fl512s",  INFO6(0x010220, 0x4d0080, 256 * 1024, 256,
                        SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
                        SPI_NOR_HAS_LOCK | USE_CLSR) },
-       { "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_=
DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+       { "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_=
DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR)
+                       .fixups =3D &s25fs512s_fixups, },
        { "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
        { "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
        { "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },

Thanks=20
Kuldeep

[1] https://patchwork.ozlabs.org/patch/1233915/

> +
>  /* NOTE: double check command sets and memory organization when you
> add
>   * more nor chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
> @@ -2715,6 +2904,9 @@ static const struct flash_info spi_nor_ids[] =3D {
>         { "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { "s28hs512t",  INFO(0x345b1a,      0, 256 * 1024, 256, SECT_4K |
> SPI_NOR_OCTAL_DTR_READ)
> +               .fixups =3D &s28hs512t_fixups,
> +       },
>=20
>         /* SST -- large erase sizes are "overlays", "sectors" are 4K */
>         { "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K |
> SST_WRITE) }, diff --git a/include/linux/mtd/spi-nor.h
> b/include/linux/mtd/spi-nor.h index c653f6713cfc..e765272fc0f4 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -150,6 +150,20 @@
>  #define SR2_QUAD_EN_BIT1       BIT(1)
>  #define SR2_QUAD_EN_BIT7       BIT(7)
>=20
> +/* For Cypress flash. */
> +#define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any regis=
ter
> */
> +#define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any regi=
ster
> */
> +#define SPINOR_REG_CYPRESS_CFR2V               0x00800003
> +#define SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20   0x8
> +#define SPINOR_REG_CYPRESS_CFR3N               0x00000004
> +#define SPINOR_REG_CYPRESS_CFR3V               0x00800004
> +#define SPINOR_REG_CYPRESS_CFR3V_PGSZ          BIT(4) /* Page size. */
> +#define SPINOR_REG_CYPRESS_CFR3N_UNISECT       BIT(3) /* Uniform
> sector mode */
> +#define SPINOR_REG_CYPRESS_CFR4V               0x00800005
> +#define SPINOR_REG_CYPRESS_CFR5V               0x00800006
> +#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN    0x3
> +#define SPINOR_OP_CYPRESS_RD_FAST              0xee
> +
>  /* Supported SPI protocols */
>  #define SNOR_PROTO_INST_MASK   GENMASK(23, 16)
>  #define SNOR_PROTO_INST_SHIFT  16
> --
> 2.25.0

