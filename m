Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369E818AE13
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 09:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCSIJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Mar 2020 04:09:54 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10816 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSIJx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Mar 2020 04:09:53 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: QzUi4ejR28KxioeUmM5QW/Bbr9Wbx460WjfG5a9d+3/vXFwzNCoz47rvYGLwNBrHbgYqMVH48G
 6s7ZFwMBSOLojS+m5GzXN+m3vU8brIip72Jt1gfgcupZSrdEm+6urHkNHDkf+B2QrLTvj5ltX6
 43XtKpCsAim+I+Uw1kuSnHMqmLFsTFlyOXYqPIBQyT5+/rvnpyXZwl12QqQmVmNvroIMMNhqOW
 nIuutRZF7bzNFO7hbL55EiKAxIzX3bdHWyrgPMBf/T/SJ8EGfTWFy1ZVLlptgKn7oXhuaEsDjx
 eTY=
X-IronPort-AV: E=Sophos;i="5.70,570,1574146800"; 
   d="scan'208";a="69496616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Mar 2020 01:09:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 01:09:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Mar 2020 01:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S46pOKauVe30SKiCgRcw0B1O4gVNrguN4Z2F98MTJzBTaErh2vFTFPwmLPieaBFbow6SdjHa2/tqndSQqZOrCFD3c73ixBgpWnzB24/fH4vEfb4h2dKi4axdjJuQRek45PYzaAz2XHooaGcybWUwOfRDLpgT4ToTgrUqaPn7Li2l2LZCvZhToSNucBgyKOUgaLHL2PlmCcu7Wm1MFAWVKa7Nyul1Wmz4Gh31MRSKYt6pFE/Dh0RrngQslme0ZciIBDq16XpRV7W6REZWPkfjw9HbLcxqXEYI7a4I64IT8SlD3jH701ilmjKskZhNQyHpjrJw+uwynlrC2Ads5aegdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hldgLqgjq2uYFPUKtgPx0rkcSxVhjsa7KWR2ihvjF8=;
 b=DOPi4W2q4hfvfO7gE3hAkD4HC0q8ijYKOEKpd9s/kQDWqMxyzDcSJY4aUxFhsxpVSyIlZDEf+JK+xjnm2hDtfM4t1JfI6ofrSBz6trawPsRXyypdV8Ti2NM/pmDtGRjsRG+pqDV/K2W5Wakf8cRr43nkbDfUhGi82BI/WEnaMq/MvNF6MXItnAfX69UdWyEF9Xwq42tdU4GekaNhGRMWabriJb8p686pg121/eQ3akzEqp/STH/k1Dc6ILmG0vN123+485I2ysQmB/HAID8UXorpxFhcY8djt7rtmMEJtDrPJz4RJ6LExDykU9yNgASuXbHlBnuqP5yH/NjWd/5BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hldgLqgjq2uYFPUKtgPx0rkcSxVhjsa7KWR2ihvjF8=;
 b=V5fR53iVqgv91Frkuyy48obzFovOwq7Li8RplI+YDm0vkOPzJ36VTu1WOvR2v3sY34B4ia+9e9nWzy/OGzl0RF6texu9jdtcvcG8PsfHCBOa+8ZxpRtqxr6SRiGbqIGwCkeXpHC5PsnRFwHGQVsPL38H1B7qFUvWcbKSXvD8ogc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB3983.namprd11.prod.outlook.com (2603:10b6:208:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 19 Mar
 2020 08:09:50 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::b515:d8f2:b5f5:245f]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::b515:d8f2:b5f5:245f%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 08:09:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <marex@denx.de>, <devicetree@vger.kernel.org>,
        <tien.fong.chee@intel.com>, <tudor.ambarus@gmail.com>,
        <boris.brezillon@free-electrons.com>, <richard@nod.at>,
        <qi-ming.wu@intel.com>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <miquel.raynal@bootlin.com>,
        <cheol.yong.kim@intel.com>, <cyrille.pitchen@atmel.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v12 2/4] mtd: spi-nor: add spi-mem support in
 cadence-quadspi controller driver
Thread-Topic: [PATCH v12 2/4] mtd: spi-nor: add spi-mem support in
 cadence-quadspi controller driver
Thread-Index: AQHV/cXC4h+AkRdbxECIIUZlWmxQYA==
Date:   Thu, 19 Mar 2020 08:09:48 +0000
Message-ID: <3360641.Vn3sISamPi@192.168.0.120>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-3-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20200310015213.1734-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d94a6bb1-7f1a-4762-af80-08d7cbdce580
x-ms-traffictypediagnostic: MN2PR11MB3983:
x-microsoft-antispam-prvs: <MN2PR11MB3983C1C6553F11194808E481F0F40@MN2PR11MB3983.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(91956017)(86362001)(8676002)(14286002)(6506007)(81156014)(81166006)(53546011)(8936002)(9686003)(6512007)(4326008)(71200400001)(6486002)(54906003)(2906002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(5660300002)(26005)(110136005)(186003)(498600001)(7416002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3983;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mkzvjJ1m7JAaKqypoWtnahVUkqWY1kfsuXe3h/8udLFOuupy8y4H9PeK6MDgTmNi/lj8qE6PSH9c6Qr/HOFwYMPPkf+2/b9w/0cCiVwUlGv6aQFVcBEwF/QBKbsJJ70Mr9eHsoRmNP8eheV5w3M5A4/VnEpOo4FI4HzHg0dwM650IDgaU95pX2wYc1pedaOEu+vjy1g2BLsORuptnwMt/vALjo2m8zVnprRpu1x4ucRNnBH2+BIH9QjNC3UZkS2DW9qS7MPY3negwmkCKh3pVYgN8uuf/OAImn9npTfXOnIFzY+JVMdETRVIm/w5QgermV5e9zcWzMTb2W8ynRn+mwN80wKz/lV0vmPF8612D21AF/SP1wT1RxabiCl5d9jO759TJLcETvQLhHDPB0HQk171NNbvEWZPAlGpdQ8vZFv9Wi1Jt2VIW1AGMqOXQcbOj73ulE2wYLI0YHE3QUkKEuS0usm1ZuGJxhi/uxRu+iT+04VnyahnYmxKrg6wLhe
x-ms-exchange-antispam-messagedata: Fz68/S37sdsZ2Xi67fCbbHxoBC8AAPjjIcZMKjavCOO9i5dqpVGWoh6bc+avLO2KyURF1UmHEt8aP8G+9M6RFP9db/SdUwsfC4DaT4yPAbLLL3A13nhnrgmwrTcmg8dQ3u4TAdQmhHquNtcJ9SUVaw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25199907B81B19458032A2FCEAFA74F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d94a6bb1-7f1a-4762-af80-08d7cbdce580
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 08:09:49.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtXFeIsRb9y1uni821bHvMqBmINcdWRyUfB4lc600DOckkMbDy9GQFjDoLOQ/vrRD/zhwr77IaSd8gyWf/y7aa0FBzQl5KZHL1c91xid7kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3983
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tuesday, March 10, 2020 3:52:11 AM EET Ramuthevar, Vadivel MuruganX wrot=
e:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> From: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com>
>=20
> This patch adds a spi-mem framework adaptation over cadence-quadspi drive=
r.

you need to specify on which versions of the controller you tested this.

>=20
> Signed-off-by: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com> Signed-off-by: Vignesh
> Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 538
> +++++++++++++--------------------- 1 file changed, 209 insertions(+), 329
> deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c
> b/drivers/mtd/spi-nor/cadence-quadspi.c index 494dcab4aaaa..7b52e109036e
> 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -3,6 +3,8 @@

cut

>  struct cqspi_st {
> @@ -70,23 +66,20 @@ struct cqspi_st {
>         void __iomem            *ahb_base;
>         resource_size_t         ahb_size;
>         struct completion       transfer_complete;
> -       struct mutex            bus_mutex;

are we now supporting just a single flash on the bus? Does=20
CQSPI_MAX_CHIPSELECT make sense anymore?

>=20
>         struct dma_chan         *rx_chan;
>         struct completion       rx_dma_complete;
>         dma_addr_t              mmap_phys_base;
>=20
>         int                     current_cs;
> -       int                     current_page_size;
> -       int                     current_erase_size;
> -       int                     current_addr_width;
> -       unsigned long           master_ref_clk_hz;
>         bool                    is_decoded_cs;
> +       unsigned long           master_ref_clk_hz;

don't do changes for free, keep it were it was.

>         u32                     fifo_depth;
>         u32                     fifo_width;
>         bool                    rclk_en;
>         u32                     trigger_address;
>         u32                     wr_delay;
> +       bool                    use_dac_mode;
>         struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  };

cut

> -static int cqspi_read_setup(struct spi_nor *nor)
> +static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
> +                           const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
>         unsigned int dummy_clk =3D 0;
>         unsigned int reg;
>=20
> -       reg =3D nor->read_opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> -       reg |=3D cqspi_calc_rdreg(nor);
> +       reg =3D op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> +       reg |=3D cqspi_calc_rdreg(f_pdata);
>=20
>         /* Setup dummy clock cycles */
> -       dummy_clk =3D nor->read_dummy;
> +       dummy_clk =3D op->dummy.nbytes * 8;
>         if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
>                 dummy_clk =3D CQSPI_DUMMY_CLKS_MAX;
>=20
> -       if (dummy_clk / 8) {
> -               reg |=3D (1 << CQSPI_REG_RD_INSTR_MODE_EN_LSB);
> -               /* Set mode bits high to ensure chip doesn't enter XIP */
> -               writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
> -
> -               /* Need to subtract the mode byte (8 clocks). */
> -               if (f_pdata->inst_width !=3D CQSPI_INST_TYPE_QUAD)
> -                       dummy_clk -=3D 8;
> -
> -               if (dummy_clk)
> -                       reg |=3D (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MA=
SK)
> -                              << CQSPI_REG_RD_INSTR_DUMMY_LSB;
> -       }
> +       if (dummy_clk / 8)
> +               reg |=3D (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
> +                      << CQSPI_REG_RD_INSTR_DUMMY_LSB;

nit: we usually keep the operator on the first line

>=20
>         writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>=20
>         /* Set address width */
>         reg =3D readl(reg_base + CQSPI_REG_SIZE);
>         reg &=3D ~CQSPI_REG_SIZE_ADDRESS_MASK;
> -       reg |=3D (nor->addr_width - 1);
> +       reg |=3D (op->addr.nbytes - 1);
>         writel(reg, reg_base + CQSPI_REG_SIZE);
>         return 0;
>  }
>=20
> -static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
> -                                      loff_t from_addr, const size_t n_r=
x)
> +static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata=
,
> +                                      u8 *rxbuf, loff_t from_addr,
> +                                      const size_t n_rx)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       struct device *dev =3D &cqspi->pdev->dev;
>         void __iomem *reg_base =3D cqspi->iobase;
>         void __iomem *ahb_base =3D cqspi->ahb_base;
>         unsigned int remaining =3D n_rx;
> @@ -528,13 +508,13 @@ static int cqspi_indirect_read_execute(struct spi_n=
or
> *nor, u8 *rxbuf,
>=20
>         while (remaining > 0) {
>                 if (!wait_for_completion_timeout(&cqspi->transfer_complet=
e,
> -                               msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
> +                                              =20
> msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS))) ret =3D -ETIMEDOUT;

nit: unrelated change. You can fix all the checkpatch warnings in the drive=
r=20
at the beginning of the series in one dedicated patch, if you care of cours=
e,=20
but don't do it here.

cut

> -static int cqspi_of_get_pdata(struct platform_device *pdev)
> +static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> -       struct cqspi_st *cqspi =3D platform_get_drvdata(pdev);
> -
> -       cqspi->is_decoded_cs =3D of_property_read_bool(np,
> "cdns,is-decoded-cs"); +       struct device *dev =3D &cqspi->pdev->dev;

you dropped the reading of this property, but you kept the is_decoded_cs=20
member, shouldn't you drop the latter too? I guess this deserves a dedicate=
d=20
patch.

cut

>=20
> -static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> +static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  {
>         dma_cap_mask_t mask;
>=20
> @@ -1211,131 +1126,82 @@ static void cqspi_request_mmap_dma(struct cqspi_=
st
> *cqspi)
>=20
>         cqspi->rx_chan =3D dma_request_chan_by_mask(&mask);
>         if (IS_ERR(cqspi->rx_chan)) {
> -               dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +               int ret =3D PTR_ERR(cqspi->rx_chan);
> +
> +               if (ret =3D=3D -EPROBE_DEFER)
> +                       dev_err(&cqspi->pdev->dev, "No Rx DMA available\n=
");
> cqspi->rx_chan =3D NULL;

why do you print this just on defer?

> +
> +               return ret;

not initializing completion on errors needs a dedicated patch

>         }
>         init_completion(&cqspi->rx_dma_complete);
> +
> +       return 0;
>  }

cut

>=20
>  static int cqspi_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> +       const struct cqspi_driver_platdata *ddata;
> +       struct reset_control *rstc, *rstc_ocp;
>         struct device *dev =3D &pdev->dev;
> +       struct spi_master *master;
> +       struct resource *res_ahb;
>         struct cqspi_st *cqspi;
>         struct resource *res;
> -       struct resource *res_ahb;
> -       struct reset_control *rstc, *rstc_ocp;
> -       const struct cqspi_driver_platdata *ddata;
>         int ret;
>         int irq;
>=20
> -       cqspi =3D devm_kzalloc(dev, sizeof(*cqspi), GFP_KERNEL);
> -       if (!cqspi)
> +       master =3D spi_alloc_master(&pdev->dev, sizeof(*cqspi));
> +       if (!master) {
> +               dev_err(&pdev->dev, "spi_alloc_master failed\n");
>                 return -ENOMEM;
> +       }

don't forget to free the master on following errors

> +       master->mode_bits =3D SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;
> +       master->mem_ops =3D &cqspi_mem_ops;
> +       master->dev.of_node =3D pdev->dev.of_node;
> +
> +       cqspi =3D spi_master_get_devdata(master);
>=20
> -       mutex_init(&cqspi->bus_mutex);
>         cqspi->pdev =3D pdev;
> -       platform_set_drvdata(pdev, cqspi);
>=20
>         /* Obtain configuration from OF. */
> -       ret =3D cqspi_of_get_pdata(pdev);
> +       ret =3D cqspi_of_get_pdata(cqspi);
>         if (ret) {
>                 dev_err(dev, "Cannot get mandatory OF data.\n");
>                 return -ENODEV;
> @@ -1390,13 +1256,13 @@ static int cqspi_probe(struct platform_device *pd=
ev)
> rstc =3D devm_reset_control_get_optional_exclusive(dev, "qspi"); if
> (IS_ERR(rstc)) {
>                 dev_err(dev, "Cannot get QSPI reset.\n");
> -               return PTR_ERR(rstc);
> +               goto probe_reset_failed;
>         }
>=20
>         rstc_ocp =3D devm_reset_control_get_optional_exclusive(dev,
> "qspi-ocp"); if (IS_ERR(rstc_ocp)) {
>                 dev_err(dev, "Cannot get QSPI OCP reset.\n");
> -               return PTR_ERR(rstc_ocp);
> +               goto probe_reset_failed;

these 2 goto statements need a dedicated patch.

>         }
>=20
>         reset_control_assert(rstc);
> @@ -1407,15 +1273,21 @@ static int cqspi_probe(struct platform_device *pd=
ev)
>=20
>         cqspi->master_ref_clk_hz =3D clk_get_rate(cqspi->clk);
>         ddata  =3D of_device_get_match_data(dev);
> -       if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
> -               cqspi->wr_delay =3D 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> -                                                =20
> cqspi->master_ref_clk_hz); +       if (ddata) {
> +               if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
> +                       cqspi->wr_delay =3D 5 * DIV_ROUND_UP(NSEC_PER_SEC=
,
> +                                               cqspi->master_ref_clk_hz)=
;
> +               if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
> +                       master->mode_bits |=3D SPI_RX_OCTAL;
> +               if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
> +                       cqspi->use_dac_mode =3D true;
> +       }
>=20
>         ret =3D devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>                                pdev->name, cqspi);
>         if (ret) {
>                 dev_err(dev, "Cannot request IRQ.\n");
> -               goto probe_irq_failed;
> +               goto probe_reset_failed;
>         }
>=20
>         cqspi_wait_idle(cqspi);
> @@ -1423,16 +1295,28 @@ static int cqspi_probe(struct platform_device *pd=
ev)
> cqspi->current_cs =3D -1;
>         cqspi->sclk =3D 0;
>=20
> -       ret =3D cqspi_setup_flash(cqspi, np);
> +       ret =3D cqspi_setup_flash(cqspi);
>         if (ret) {
> -               dev_err(dev, "Cadence QSPI NOR probe failed %d\n", ret);
> +               dev_err(dev, "failed to setup flash parameters %d\n", ret=
);
>                 goto probe_setup_failed;
>         }
>=20
> -       return ret;
> +       if (cqspi->use_dac_mode) {
> +               ret =3D cqspi_request_mmap_dma(cqspi);

the driver was requesting the mmap for each available flash and now you do =
it=20
once, which is great, but this too has to be made in a dedicated patch.

> +               if (ret =3D=3D -EPROBE_DEFER)
> +                       goto probe_setup_failed;
> +       }
> +
> +       ret =3D devm_spi_register_master(dev, master);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to register SPI ctlr %d\n",
> ret); +               goto probe_setup_failed;
> +       }
> +
> +       return 0;
>  probe_setup_failed:
>         cqspi_controller_enable(cqspi, 0);
> -probe_irq_failed:
> +probe_reset_failed:
>         clk_disable_unprepare(cqspi->clk);
>  probe_clk_failed:
>         pm_runtime_put_sync(dev);
> @@ -1443,11 +1327,6 @@ static int cqspi_probe(struct platform_device *pde=
v)
>  static int cqspi_remove(struct platform_device *pdev)
>  {
>         struct cqspi_st *cqspi =3D platform_get_drvdata(pdev);
> -       int i;
> -
> -       for (i =3D 0; i < CQSPI_MAX_CHIPSELECT; i++)
> -               if (cqspi->f_pdata[i].registered)
> -                       mtd_device_unregister(&cqspi->f_pdata[i].nor.mtd)=
;
>=20
>         cqspi_controller_enable(cqspi, 0);
>=20
> @@ -1490,16 +1369,15 @@ static const struct dev_pm_ops cqspi__dev_pm_ops =
=3D {
> #endif
>=20
>  static const struct cqspi_driver_platdata cdns_qspi =3D {
> -       .hwcaps_mask =3D CQSPI_BASE_HWCAPS_MASK,
> +       .quirks =3D CQSPI_DISABLE_DAC_MODE,

The logic around CQSPI_DISABLE_DAC_MODE needs a dedicated patch.

Cheers,
ta


