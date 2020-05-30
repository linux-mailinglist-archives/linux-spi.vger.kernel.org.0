Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19221E91CE
	for <lists+linux-spi@lfdr.de>; Sat, 30 May 2020 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3Nu1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 30 May 2020 09:50:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23004 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nu0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 30 May 2020 09:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590846624; x=1622382624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V8e/b1eoMRt5JiaMN5+ubs2Kj5wRX+PXDq3lB65agaw=;
  b=finXDpeYX+oTTorM8+j/V53/mgfr699YilL/OQavsRXvdd1xLkAcJkYc
   8utoZTcN0pnSDmMpLA1C1NNWA1MeAECfv6bykCGxFCeGzAlc6yiG2zniw
   z6EC5ctwMXCro9fEVjnNur4Y05qlkeDzalGcn/4rNozzv2SbPVgtTQy4r
   sMn0rT9OaN5q4KJ67SD8AhUXkaGzTocRJo34KK1nftxO0yFwV7zSTlA6G
   G+5MHlnoIrRVKXjBqQJscNOmDfAu7dWA9X836La07RDxFs4camdwB6EoQ
   19aqvtV8LcIj/sIUC7Q/xICNH1WbUgEG2T7q97aZCblsEG/lJeHxhkaNY
   w==;
IronPort-SDR: z9TRRLjcjtAYceJnlIAv+MoRVsdNSavJdrrUHPcSehCHrt1JiLMpEtCi9AlCcToX7y+RAgWFtY
 yXWaYq2XUjiIYeX9PNQzlbTQCj4J7jP29IoQ1flxCIsVhnQRGL/bJHHZvd1D3j0pV2oZEpKd5U
 hVf2iXxsrE9eSwO0FpT4ua1S3xfBnFxrGImRzlMfLvwzUrsXdCBEr8JhoG6SJBOC74Zl/b/zWM
 gb84iO/y3CU+DYzAVY7Acu3gRh3JKhpenxAz6Xwkve8o8AQGVTUjM0KzM7+a/Vc6FnxkSNLTH+
 d64=
X-IronPort-AV: E=Sophos;i="5.73,452,1583218800"; 
   d="scan'208";a="81660336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2020 06:50:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 30 May 2020 06:50:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 30 May 2020 06:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxZAUwfxv34sOMUPPqXB6T24702t7n6yqoJDLdMLY+O89zTCusCxf8OdYiT2WOrxfW56mbC1dZjEL7DeNUTiEnOw+8uqqn6VH1QSckSPG7hBw72cdQuhWMZYVhFerfVIllX/kUAaktyzi055RMOnprpOIgsn7RHkaizHIpRGEpEH67RoaqjAzYVf6czFgSQQODgHBcArqnAbzCFrp6/20dBrDcOeiVo+wfMzrzJ+f/Qla5ptUKBxckMcoQjIeueNV9EWS8E/2Fw7rHGRaFuEcL/MweaoLUq41dHz4Z5eNpmCZGlNw2XxIGXp50PkFhx7PyvGNFIEmbx8La32DRf7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9qhxSvgtz1sHnpFJ+oVJ6ceCyi6PjyTAk0+SfnAfrE=;
 b=SH/+WEcRE1q0y5Wu2PppZW99vUcOe+kCqABpeuFX5Ms9zBuNaD7CjWEl4FPQ/BujErdQry19/Q/W+InMM1KnqclGUGsUOFV9WXdlCLzDU4piIavbaWyh/WXuV6ELGP1KWuiy8ne9kbr4fAI0Ehg/t4Uhx9aiYlfaiJ1yRnK0nHQeK2AAdvHaiHQlEy2kA++ufrhYuHQxbdsQhNSqCLi0RgJKEBANUZ1U8pe2cn0sYMyFgsabLg1r4QPb8HoUqWWziTJVoMAxCCwsa1JPeKgwGrxXf2IhwGfMNLsLn8Eh5FnOCb+pIaSLBg23KzJcjYY6+Vqt3AYVySgOj2xv/uF2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9qhxSvgtz1sHnpFJ+oVJ6ceCyi6PjyTAk0+SfnAfrE=;
 b=MIQYYPXEmPCvFzmmBj2fBQukahY6ecIq9M32oEjk3ci8QDzDXm+CbkjsnhDZCI5XVnTDAMXLYp8UtxmcMZIVLR1hfR/rovXdL4mbixEqSYJrjiwP7NwnvrhR1JYgGlvCD5OsxuPkhlWSt4wwZH7ZLqFGwYPXojz4HBoCuL8ilhY=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4150.namprd11.prod.outlook.com (2603:10b6:a03:190::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 13:50:19 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Sat, 30 May 2020
 13:50:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: Convert cadence-quadspi to use
 spi-mem framework
Thread-Topic: [PATCH v2 5/6] mtd: spi-nor: Convert cadence-quadspi to use
 spi-mem framework
Thread-Index: AQHWM0FbObzLUE3zbU2uk18n3E8gz6jAq/2A
Date:   Sat, 30 May 2020 13:50:19 +0000
Message-ID: <42194926.90UbduaAQf@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-6-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-6-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698e2bc6-32e0-4208-ec9d-08d804a06423
x-ms-traffictypediagnostic: BY5PR11MB4150:
x-microsoft-antispam-prvs: <BY5PR11MB4150CF8EDA22E38A402A19E0F08C0@BY5PR11MB4150.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JsSvK8Vy950oadRrbU7UAbT3xVEsdX3+gB2aqRjtokt5ElOtEs3oWsouvP4XF2rKHhZRdw8k1PyyEv7dKQm4z9E/8WnSasRTWmUnKnEB970CBYEzeop1SGUCGnRwsevi9yUcQ/esPztqwvk7OYx4Atc7U/+scTXMfYh5ZhT/gxiBSWBRrYqu/ZOPw+6QIwZtfMnO8N/aRLQPE4bVSmtpetL9th4hfcblgf72Mr+j8VjINq9KQ4Ia3Js5g73C18PGS8Jl/XkgUvrAqe3Bd5Ux82Yf498IoPsj7DIOU+/Kr/dgfPw/y+qhdRfB27ajz4A3xzzO4OSgSl3GjWHhqHs+1wTyhnuNjSbNrbInbwlqLTFsgM9X8vtlZQJNFoWg8ZLtjuMRqMhxHJsjWTrf/Mz1gkHcO2JSxuVjdjiixfKDvrp42WwiQvziS2VwwFyxMldHv0sBfnKFmhtnI+iHQQCdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39850400004)(376002)(366004)(346002)(83380400001)(966005)(5660300002)(64756008)(14286002)(91956017)(478600001)(66556008)(66476007)(66446008)(66946007)(4326008)(76116006)(71200400001)(86362001)(30864003)(6506007)(9686003)(8936002)(186003)(6916009)(8676002)(53546011)(54906003)(6512007)(26005)(2906002)(7416002)(6486002)(316002)(39026012)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: neVf/NNXCh5OvDOQcZ+/SQ3jD3Gxy7lbSBuveWVyoS9MeTN6tjZ28NlQk8eugOxx0YLbKWUNQXKaxUm55kyRCv7grAlMd0aoE5JLaWPMtH6yYqE/38nnMfeGn+IAP9kdoQHqlDggajHjCiFOOBOmiXRuL9jEw/1ef2jHX6I3cTp49qh4YuiecAHubXGh93Kk0s8rA+SQXSunvf8nJUwh8Kbn912ZhcFAUJvsC73DgVHSADe+wtjjKCT0ojnxBRB4pLablY8uBD6/XnSV8ny0nVQFQNH2vvEYJp04CRz929kw0Q8R5/DVPWHuHXtBfRcijqGYR55ZTMrZrOhdHZHRi7lJH7Mr6xp5RkOCGQvQAWFGjrqS6xxruQw9lSxOI9jcWiQ0/v2YMqS2FBXTcJCVZerKlEDvx0jT/uFhv3cgSKR+jrzHr0sk99w3C6abgenmTRrjRZHr3K7GTT/iH9hLzTrgeUgMxbhZe94UT3OZbOY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1377B88FD5F583469633C13885A4520E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 698e2bc6-32e0-4208-ec9d-08d804a06423
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 13:50:19.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4+JxgxaHrbIuqlyQUKb95ewHzIrTfE08GQt7V+OFTcg0wGcJC2eyONtazMuHuQeQ98UeWugdcWPh4a9aoKLeIIZ/+5oX0LJ8c8XNjW2Gv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4150
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Vignesh,

On Tuesday, May 26, 2020 12:36:03 PM EEST Vignesh Raghavendra wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> From: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com>
>=20
> Move cadence-quadspi driver to use spi-mem framework. This is required
> to make the driver support for SPI NAND flashes in future.
>=20
> Driver is feature compliant with existing SPI NOR version.
>=20
> Signed-off-by: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com> Signed-off-by: Vignesh
> Raghavendra <vigneshr@ti.com>
> ---
>  .../mtd/spi-nor/controllers/cadence-quadspi.c | 469 +++++++-----------
>  1 file changed, 183 insertions(+), 286 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c index
> 608ca657ff7f..c1df4b221889 100644
> --- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> @@ -3,6 +3,8 @@
>   * Driver for Cadence QSPI Controller
>   *
>   * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
> + * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
>   */
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> @@ -17,9 +19,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/mtd/spi-nor.h>
>  #include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -27,6 +26,7 @@
>  #include <linux/reset.h>
>  #include <linux/sched.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
>  #include <linux/timer.h>
>=20
>  #define CQSPI_NAME                     "cadence-qspi"
> @@ -36,16 +36,12 @@
>  #define CQSPI_NEEDS_WR_DELAY           BIT(0)
>  #define CQSPI_DISABLE_DAC_MODE         BIT(1)
>=20
> -/* Capabilities mask */
> -#define CQSPI_BASE_HWCAPS_MASK                                 \
> -       (SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |             \
> -       SNOR_HWCAPS_READ_1_1_2 | SNOR_HWCAPS_READ_1_1_4 |       \
> -       SNOR_HWCAPS_PP)
> +/* Capabilities */
> +#define CQSPI_SUPPORTS_OCTAL           BIT(0)
>=20
>  struct cqspi_st;
>=20
>  struct cqspi_flash_pdata {
> -       struct spi_nor  nor;
>         struct cqspi_st *cqspi;
>         u32             clk_rate;
>         u32             read_delay;
> @@ -58,7 +54,6 @@ struct cqspi_flash_pdata {
>         u8              data_width;
>         u8              cs;
>         bool            registered;

you can drop this, as it is no longer used

> -       bool            use_direct_mode;
>  };
>=20
>  struct cqspi_st {
> @@ -71,7 +66,6 @@ struct cqspi_st {
>         void __iomem            *ahb_base;
>         resource_size_t         ahb_size;
>         struct completion       transfer_complete;
> -       struct mutex            bus_mutex;
>=20
>         struct dma_chan         *rx_chan;
>         struct completion       rx_dma_complete;
> @@ -85,6 +79,7 @@ struct cqspi_st {
>         bool                    rclk_en;
>         u32                     trigger_address;
>         u32                     wr_delay;
> +       bool                    use_dac_mode;

is use_dac_mode better than use_direct_mode? If you prefer "dac", maybe you=
=20
can rename this variable in 2/6

>         struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  };
>=20
> @@ -283,9 +278,8 @@ static irqreturn_t cqspi_irq_handler(int this_irq, vo=
id
> *dev) return IRQ_HANDLED;
>  }
>=20
> -static unsigned int cqspi_calc_rdreg(struct spi_nor *nor)
> +static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         u32 rdreg =3D 0;
>=20
>         rdreg |=3D f_pdata->inst_width << CQSPI_REG_RD_INSTR_TYPE_INSTR_L=
SB;
> @@ -352,19 +346,21 @@ static int cqspi_exec_flash_cmd(struct cqspi_st
> *cqspi, unsigned int reg) return cqspi_wait_idle(cqspi);
>  }
>=20
> -static int cqspi_command_read(struct spi_nor *nor, u8 opcode,
> -                             u8 *rxbuf, size_t n_rx)
> +static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
> +                             const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
> +       u8 *rxbuf =3D op->data.buf.in;
> +       u8 opcode =3D op->cmd.opcode;

dedicated variable for opcode is not really needed, it is used only once.

> +       size_t n_rx =3D op->data.nbytes;
>         unsigned int rdreg;
>         unsigned int reg;
>         size_t read_len;
>         int status;
>=20
>         if (!n_rx || n_rx > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
> -               dev_err(nor->dev,
> +               dev_err(&cqspi->pdev->dev,
>                         "Invalid input argument, len %zu rxbuf 0x%p\n",
>                         n_rx, rxbuf);
>                 return -EINVAL;
> @@ -372,7 +368,7 @@ static int cqspi_command_read(struct spi_nor *nor, u8
> opcode,
>=20
>         reg =3D opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
>=20
> -       rdreg =3D cqspi_calc_rdreg(nor);
> +       rdreg =3D cqspi_calc_rdreg(f_pdata);
>         writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
>=20
>         reg |=3D (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
> @@ -401,25 +397,35 @@ static int cqspi_command_read(struct spi_nor *nor, =
u8
> opcode, return 0;
>  }
>=20
> -static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
> -                              const u8 *txbuf, size_t n_tx)
> +static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
> +                              const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
> +       const u8 opcode =3D op->cmd.opcode;

dedicated variable for opcode is not really needed, it is used only once.

> +       const u8 *txbuf =3D op->data.buf.out;
> +       size_t n_tx =3D op->data.nbytes;
>         unsigned int reg;
>         unsigned int data;
>         size_t write_len;
> -       int ret;
>=20
>         if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
> -               dev_err(nor->dev,
> +               dev_err(&cqspi->pdev->dev,
>                         "Invalid input argument, cmdlen %zu txbuf 0x%p\n"=
,
>                         n_tx, txbuf);
>                 return -EINVAL;
>         }
>=20
>         reg =3D opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
> +
> +       if (op->addr.nbytes) {
> +               reg |=3D (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
> +               reg |=3D ((op->addr.nbytes - 1) &
> CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
> +               <<
> CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;

you have a 80 chars checkpatch warning here, maybe replace it with smth lik=
e
	reg |=3D ((op->addr.nbytes - 1) &
	            CQSPI_REG_CMDCTRL_ADD_BYTES_MASK) <<
	           CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;

> +
> +               writel(op->addr.val, reg_base + CQSPI_REG_CMDADDRESS);
> +       }
> +
>         if (n_tx) {
>                 reg |=3D (0x1 << CQSPI_REG_CMDCTRL_WR_EN_LSB);
>                 reg |=3D ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
> @@ -437,73 +443,46 @@ static int cqspi_command_write(struct spi_nor *nor,
> const u8 opcode, writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER); }
>         }
> -       ret =3D cqspi_exec_flash_cmd(cqspi, reg);
> -       return ret;
> -}
> -
> -static int cqspi_command_write_addr(struct spi_nor *nor,
> -                                   const u8 opcode, const unsigned int
> addr) -{
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
> -       struct cqspi_st *cqspi =3D f_pdata->cqspi;
> -       void __iomem *reg_base =3D cqspi->iobase;
> -       unsigned int reg;
> -
> -       reg =3D opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
> -       reg |=3D (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
> -       reg |=3D ((nor->addr_width - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MAS=
K)
> -               << CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
> -
> -       writel(addr, reg_base + CQSPI_REG_CMDADDRESS);
>=20
>         return cqspi_exec_flash_cmd(cqspi, reg);
>  }
>=20
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

if (dummy_clk) should be enough. dummy_clk is either zero, or a multiple of=
=20
eight, or CQSPI_DUMMY_CLKS_MAX.

> +               reg |=3D (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
> +                      << CQSPI_REG_RD_INSTR_DUMMY_LSB;

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
> @@ -526,13 +505,13 @@ static int cqspi_indirect_read_execute(struct spi_n=
or
> *nor, u8 *rxbuf,
>=20
>         while (remaining > 0) {
>                 if (!wait_for_completion_timeout(&cqspi->transfer_complet=
e,
> -                               msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
> +                                              =20
> msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS))) ret =3D -ETIMEDOUT;
>=20
>                 bytes_to_read =3D cqspi_get_rd_sram_level(cqspi);
>=20
>                 if (ret && bytes_to_read =3D=3D 0) {
> -                       dev_err(nor->dev, "Indirect read timeout, no
> bytes\n"); +                       dev_err(dev, "Indirect read timeout, n=
o
> bytes\n"); goto failrd;
>                 }
>=20
> @@ -568,8 +547,7 @@ static int cqspi_indirect_read_execute(struct spi_nor
> *nor, u8 *rxbuf, ret =3D cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECT=
RD,
>                                  CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
>         if (ret) {
> -               dev_err(nor->dev,
> -                       "Indirect read completion error (%i)\n", ret);
> +               dev_err(dev, "Indirect read completion error (%i)\n", ret=
);
>                 goto failrd;
>         }
>=20
> @@ -591,32 +569,32 @@ static int cqspi_indirect_read_execute(struct spi_n=
or
> *nor, u8 *rxbuf, return ret;
>  }
>=20
> -static int cqspi_write_setup(struct spi_nor *nor)
> +static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
> +                            const struct spi_mem_op *op)
>  {
>         unsigned int reg;
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
>=20
>         /* Set opcode. */
> -       reg =3D nor->program_opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
> +       reg =3D op->cmd.opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
>         writel(reg, reg_base + CQSPI_REG_WR_INSTR);
> -       reg =3D cqspi_calc_rdreg(nor);
> +       reg =3D cqspi_calc_rdreg(f_pdata);
>         writel(reg, reg_base + CQSPI_REG_RD_INSTR);
>=20
>         reg =3D readl(reg_base + CQSPI_REG_SIZE);
>         reg &=3D ~CQSPI_REG_SIZE_ADDRESS_MASK;
> -       reg |=3D (nor->addr_width - 1);
> +       reg |=3D (op->addr.nbytes - 1);
>         writel(reg, reg_base + CQSPI_REG_SIZE);
>         return 0;
>  }
>=20
> -static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t
> to_addr, -                                       const u8 *txbuf, const
> size_t n_tx) +static int cqspi_indirect_write_execute(struct
> cqspi_flash_pdata *f_pdata, +                                       loff_=
t
> to_addr, const u8 *txbuf, +                                       const
> size_t n_tx)
>  {
> -       const unsigned int page_size =3D nor->page_size;
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       struct device *dev =3D &cqspi->pdev->dev;
>         void __iomem *reg_base =3D cqspi->iobase;
>         unsigned int remaining =3D n_tx;
>         unsigned int write_bytes;
> @@ -646,7 +624,7 @@ static int cqspi_indirect_write_execute(struct spi_no=
r
> *nor, loff_t to_addr, while (remaining > 0) {
>                 size_t write_words, mod_bytes;
>=20
> -               write_bytes =3D remaining > page_size ? page_size : remai=
ning;
> +               write_bytes =3D remaining;
>                 write_words =3D write_bytes / 4;
>                 mod_bytes =3D write_bytes % 4;
>                 /* Write 4 bytes at a time then single bytes. */
> @@ -663,8 +641,8 @@ static int cqspi_indirect_write_execute(struct spi_no=
r
> *nor, loff_t to_addr, }
>=20
>                 if (!wait_for_completion_timeout(&cqspi->transfer_complet=
e,
> -                                       msecs_to_jiffies(CQSPI_TIMEOUT_MS=
)))
> { -                       dev_err(nor->dev, "Indirect write timeout\n"); =
+=20
>                                             =20
> msecs_to_jiffies(CQSPI_TIMEOUT_MS))) { +                       dev_err(de=
v,
> "Indirect write timeout\n");
>                         ret =3D -ETIMEDOUT;
>                         goto failwr;
>                 }
> @@ -679,8 +657,7 @@ static int cqspi_indirect_write_execute(struct spi_no=
r
> *nor, loff_t to_addr, ret =3D cqspi_wait_for_bit(reg_base +
> CQSPI_REG_INDIRECTWR,
>                                  CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
>         if (ret) {
> -               dev_err(nor->dev,
> -                       "Indirect write completion error (%i)\n", ret);
> +               dev_err(dev, "Indirect write completion error (%i)\n", re=
t);
> goto failwr;
>         }
>=20
> @@ -704,9 +681,8 @@ static int cqspi_indirect_write_execute(struct spi_no=
r
> *nor, loff_t to_addr, return ret;
>  }
>=20
> -static void cqspi_chipselect(struct spi_nor *nor)
> +static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *reg_base =3D cqspi->iobase;
>         unsigned int chip_select =3D f_pdata->cs;
> @@ -745,9 +721,8 @@ static unsigned int calculate_ticks_for_ns(const
> unsigned int ref_clk_hz, return ticks;
>  }
>=20
> -static void cqspi_delay(struct spi_nor *nor)
> +static void cqspi_delay(struct cqspi_flash_pdata *f_pdata)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
>         void __iomem *iobase =3D cqspi->iobase;
>         const unsigned int ref_clk_hz =3D cqspi->master_ref_clk_hz;
> @@ -831,11 +806,10 @@ static void cqspi_controller_enable(struct cqspi_st
> *cqspi, bool enable) writel(reg, reg_base + CQSPI_REG_CONFIG);
>  }
>=20
> -static void cqspi_configure(struct spi_nor *nor)
> +static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
> +                           unsigned long sclk)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> -       const unsigned int sclk =3D f_pdata->clk_rate;
>         int switch_cs =3D (cqspi->current_cs !=3D f_pdata->cs);
>         int switch_ck =3D (cqspi->sclk !=3D sclk);
>=20
> @@ -845,14 +819,14 @@ static void cqspi_configure(struct spi_nor *nor)
>         /* Switch chip select. */
>         if (switch_cs) {
>                 cqspi->current_cs =3D f_pdata->cs;
> -               cqspi_chipselect(nor);
> +               cqspi_chipselect(f_pdata);
>         }
>=20
>         /* Setup baudrate divisor and delays */
>         if (switch_ck) {
>                 cqspi->sclk =3D sclk;
>                 cqspi_config_baudrate_div(cqspi);
> -               cqspi_delay(nor);
> +               cqspi_delay(f_pdata);
>                 cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
>                                        f_pdata->read_delay);
>         }
> @@ -861,26 +835,25 @@ static void cqspi_configure(struct spi_nor *nor)
>                 cqspi_controller_enable(cqspi, 1);
>  }
>=20
> -static int cqspi_set_protocol(struct spi_nor *nor, const int read)
> +static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
> +                             const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
> -
>         f_pdata->inst_width =3D CQSPI_INST_TYPE_SINGLE;
>         f_pdata->addr_width =3D CQSPI_INST_TYPE_SINGLE;
>         f_pdata->data_width =3D CQSPI_INST_TYPE_SINGLE;
>=20
> -       if (read) {
> -               switch (nor->read_proto) {
> -               case SNOR_PROTO_1_1_1:
> +       if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> +               switch (op->data.buswidth) {
> +               case 1:
>                         f_pdata->data_width =3D CQSPI_INST_TYPE_SINGLE;
>                         break;
> -               case SNOR_PROTO_1_1_2:
> +               case 2:
>                         f_pdata->data_width =3D CQSPI_INST_TYPE_DUAL;
>                         break;
> -               case SNOR_PROTO_1_1_4:
> +               case 4:
>                         f_pdata->data_width =3D CQSPI_INST_TYPE_QUAD;
>                         break;
> -               case SNOR_PROTO_1_1_8:
> +               case 8:
>                         f_pdata->data_width =3D CQSPI_INST_TYPE_OCTAL;
>                         break;
>                 default:
> @@ -888,36 +861,32 @@ static int cqspi_set_protocol(struct spi_nor *nor,
> const int read) }
>         }
>=20
> -       cqspi_configure(nor);
> -
>         return 0;
>  }
>=20
> -static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
> -                          size_t len, const u_char *buf)
> +static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
> +                          const struct spi_mem_op *op)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       loff_t to =3D op->addr.val;
> +       size_t len =3D op->data.nbytes;
> +       const u_char *buf =3D op->data.buf.out;
>         int ret;
>=20
> -       ret =3D cqspi_set_protocol(nor, 0);
> +       ret =3D cqspi_set_protocol(f_pdata, op);
>         if (ret)
>                 return ret;
>=20
> -       ret =3D cqspi_write_setup(nor);
> +       ret =3D cqspi_write_setup(f_pdata, op);
>         if (ret)
>                 return ret;
>=20
> -       if (f_pdata->use_direct_mode) {
> +       if (cqspi->use_dac_mode && ((to + len) <=3D cqspi->ahb_size)) {
>                 memcpy_toio(cqspi->ahb_base + to, buf, len);
> -               ret =3D cqspi_wait_idle(cqspi);
> -       } else {
> -               ret =3D cqspi_indirect_write_execute(nor, to, buf, len);
> +               return cqspi_wait_idle(cqspi);
>         }
> -       if (ret)
> -               return ret;
>=20
> -       return len;
> +       return cqspi_indirect_write_execute(f_pdata, to, buf, len);
>  }
>=20
>  static void cqspi_rx_dma_callback(void *param)
> @@ -927,11 +896,11 @@ static void cqspi_rx_dma_callback(void *param)
>         complete(&cqspi->rx_dma_complete);
>  }
>=20
> -static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> -                                    loff_t from, size_t len)
> +static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
> +                                    u_char *buf, loff_t from, size_t len=
)
>  {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
>         struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       struct device *dev =3D &cqspi->pdev->dev;
>         enum dma_ctrl_flags flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>         dma_addr_t dma_src =3D (dma_addr_t)cqspi->mmap_phys_base + from;
>         int ret =3D 0;
> @@ -944,15 +913,15 @@ static int cqspi_direct_read_execute(struct spi_nor
> *nor, u_char *buf, return 0;
>         }
>=20
> -       dma_dst =3D dma_map_single(nor->dev, buf, len, DMA_FROM_DEVICE);
> -       if (dma_mapping_error(nor->dev, dma_dst)) {
> -               dev_err(nor->dev, "dma mapping failed\n");
> +       dma_dst =3D dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
> +       if (dma_mapping_error(dev, dma_dst)) {
> +               dev_err(dev, "dma mapping failed\n");
>                 return -ENOMEM;
>         }
>         tx =3D dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src=
,
>                                        len, flags);
>         if (!tx) {
> -               dev_err(nor->dev, "device_prep_dma_memcpy error\n");
> +               dev_err(dev, "device_prep_dma_memcpy error\n");
>                 ret =3D -EIO;
>                 goto err_unmap;
>         }
> @@ -964,7 +933,7 @@ static int cqspi_direct_read_execute(struct spi_nor
> *nor, u_char *buf,
>=20
>         ret =3D dma_submit_error(cookie);
>         if (ret) {
> -               dev_err(nor->dev, "dma_submit_error %d\n", cookie);
> +               dev_err(dev, "dma_submit_error %d\n", cookie);
>                 ret =3D -EIO;
>                 goto err_unmap;
>         }
> @@ -973,99 +942,68 @@ static int cqspi_direct_read_execute(struct spi_nor
> *nor, u_char *buf, if
> (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
>                                          msecs_to_jiffies(len))) {
>                 dmaengine_terminate_sync(cqspi->rx_chan);
> -               dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
> +               dev_err(dev, "DMA wait_for_completion_timeout\n");
>                 ret =3D -ETIMEDOUT;
>                 goto err_unmap;
>         }
>=20
>  err_unmap:
> -       dma_unmap_single(nor->dev, dma_dst, len, DMA_FROM_DEVICE);
> +       dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
>=20
>         return ret;
>  }
>=20
> -static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
> -                         size_t len, u_char *buf)
> -{
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
> -       int ret;
> -
> -       ret =3D cqspi_set_protocol(nor, 1);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D cqspi_read_setup(nor);
> -       if (ret)
> -               return ret;
> -
> -       if (f_pdata->use_direct_mode)
> -               ret =3D cqspi_direct_read_execute(nor, buf, from, len);
> -       else
> -               ret =3D cqspi_indirect_read_execute(nor, buf, from, len);
> -       if (ret)
> -               return ret;
> -
> -       return len;
> -}
> -
> -static int cqspi_erase(struct spi_nor *nor, loff_t offs)
> +static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
> +                         const struct spi_mem_op *op)
>  {
> +       struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       loff_t from =3D op->addr.val;
> +       size_t len =3D op->data.nbytes;
> +       u_char *buf =3D op->data.buf.in;
>         int ret;
>=20
> -       ret =3D cqspi_set_protocol(nor, 0);
> +       ret =3D cqspi_set_protocol(f_pdata, op);
>         if (ret)
>                 return ret;
>=20
> -       /* Send write enable, then erase commands. */
> -       ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL,=
 0);

Dropping the Write Enable for erases can be done in a separate patch, since=
 it=20
is already done in the SPI NOR core. This would ease the review.

> +       ret =3D cqspi_read_setup(f_pdata, op);
>         if (ret)
>                 return ret;
>=20
> -       /* Set up command buffer. */
> -       ret =3D cqspi_command_write_addr(nor, nor->erase_opcode, offs);
> -       if (ret)
> -               return ret;
> +       if (cqspi->use_dac_mode && ((from + len) <=3D cqspi->ahb_size))
> +               return cqspi_direct_read_execute(f_pdata, buf, from, len)=
;
>=20
> -       return 0;
> +       return cqspi_indirect_read_execute(f_pdata, buf, from, len);
>  }
>=20
> -static int cqspi_prep(struct spi_nor *nor)
> +static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_o=
p
> *op) {
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
> -       struct cqspi_st *cqspi =3D f_pdata->cqspi;
> -
> -       mutex_lock(&cqspi->bus_mutex);
> -
> -       return 0;
> -}
> +       struct cqspi_st *cqspi =3D spi_master_get_devdata(mem->spi->maste=
r);
> +       struct cqspi_flash_pdata *f_pdata;
>=20
> -static void cqspi_unprep(struct spi_nor *nor)
> -{
> -       struct cqspi_flash_pdata *f_pdata =3D nor->priv;
> -       struct cqspi_st *cqspi =3D f_pdata->cqspi;
> +       f_pdata =3D &cqspi->f_pdata[mem->spi->chip_select];
> +       cqspi_configure(f_pdata, mem->spi->max_speed_hz);
>=20
> -       mutex_unlock(&cqspi->bus_mutex);
> -}
> +       if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.buf.in) {
> +               if (!op->addr.nbytes)
> +                       return cqspi_command_read(f_pdata, op);
>=20
> -static int cqspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_=
t
> len) -{
> -       int ret;
> +               return cqspi_read(f_pdata, op);
> +       }
>=20
> -       ret =3D cqspi_set_protocol(nor, 0);
> -       if (!ret)
> -               ret =3D cqspi_command_read(nor, opcode, buf, len);
> +       if (!op->addr.nbytes || !op->data.buf.out)
> +               return cqspi_command_write(f_pdata, op);
>=20
> -       return ret;
> +       return cqspi_write(f_pdata, op);
>  }
>=20
> -static int cqspi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf=
,
> -                          size_t len)
> +static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_o=
p
> *op) {
>         int ret;
>=20
> -       ret =3D cqspi_set_protocol(nor, 0);
> -       if (!ret)
> -               ret =3D cqspi_command_write(nor, opcode, buf, len);
> +       ret =3D cqspi_mem_process(mem, op);
> +       if (ret)
> +               dev_err(&mem->spi->dev, "operation failed with %d\n", ret=
);
>=20
>         return ret;
>  }
> @@ -1107,26 +1045,26 @@ static int cqspi_of_get_flash_pdata(struct
> platform_device *pdev, return 0;
>  }
>=20
> -static int cqspi_of_get_pdata(struct platform_device *pdev)
> +static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> -       struct cqspi_st *cqspi =3D platform_get_drvdata(pdev);
> +       struct device *dev =3D &cqspi->pdev->dev;
> +       struct device_node *np =3D dev->of_node;
>=20
>         cqspi->is_decoded_cs =3D of_property_read_bool(np,
> "cdns,is-decoded-cs");
>=20
>         if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_dept=
h))
> { -               dev_err(&pdev->dev, "couldn't determine fifo-depth\n");=
 +
>               dev_err(dev, "couldn't determine fifo-depth\n");
>                 return -ENXIO;
>         }
>=20
>         if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_widt=
h))
> { -               dev_err(&pdev->dev, "couldn't determine fifo-width\n");=
 +
>               dev_err(dev, "couldn't determine fifo-width\n");
>                 return -ENXIO;
>         }
>=20
>         if (of_property_read_u32(np, "cdns,trigger-address",
>                                  &cqspi->trigger_address)) {
> -               dev_err(&pdev->dev, "couldn't determine trigger-address\n=
");
> +               dev_err(dev, "couldn't determine trigger-address\n");
> return -ENXIO;
>         }
>=20
> @@ -1169,7 +1107,7 @@ static void cqspi_controller_init(struct cqspi_st
> *cqspi) cqspi_controller_enable(cqspi, 1);
>  }
>=20
> -static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> +static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  {
>         dma_cap_mask_t mask;
>=20
> @@ -1178,133 +1116,79 @@ static void cqspi_request_mmap_dma(struct cqspi_=
st
> *cqspi)
>=20
>         cqspi->rx_chan =3D dma_request_chan_by_mask(&mask);
>         if (IS_ERR(cqspi->rx_chan)) {
> -               dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +               int ret =3D PTR_ERR(cqspi->rx_chan);
> +
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(&cqspi->pdev->dev, "No Rx DMA available\n=
");
> cqspi->rx_chan =3D NULL;
> -               return;
> +               return ret;
>         }
>         init_completion(&cqspi->rx_dma_complete);
> +
> +       return 0;
>  }

Can we have the EPROBE_DEFER changes in a dedicated patch?

>=20
> -static const struct spi_nor_controller_ops cqspi_controller_ops =3D {
> -       .prepare =3D cqspi_prep,
> -       .unprepare =3D cqspi_unprep,
> -       .read_reg =3D cqspi_read_reg,
> -       .write_reg =3D cqspi_write_reg,
> -       .read =3D cqspi_read,
> -       .write =3D cqspi_write,
> -       .erase =3D cqspi_erase,
> +static const struct spi_controller_mem_ops cqspi_mem_ops =3D {
> +       .exec_op =3D cqspi_exec_mem_op,
>  };
>=20
> -static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node
> *np) +static int cqspi_setup_flash(struct cqspi_st *cqspi)
>  {
>         struct platform_device *pdev =3D cqspi->pdev;
>         struct device *dev =3D &pdev->dev;
> -       const struct cqspi_driver_platdata *ddata;
> -       struct spi_nor_hwcaps hwcaps;
> +       struct device_node *np =3D dev->of_node;
>         struct cqspi_flash_pdata *f_pdata;
> -       struct spi_nor *nor;
> -       struct mtd_info *mtd;
>         unsigned int cs;
> -       int i, ret;
> -
> -       ddata =3D of_device_get_match_data(dev);
> -       if (!ddata) {
> -               dev_err(dev, "Couldn't find driver data\n");
> -               return -EINVAL;
> -       }
> -       hwcaps.mask =3D ddata->hwcaps_mask;
>=20
>         /* Get flash device data */
>         for_each_available_child_of_node(dev->of_node, np) {
> -               ret =3D of_property_read_u32(np, "reg", &cs);
> -               if (ret) {
> +               if (of_property_read_u32(np, "reg", &cs)) {
>                         dev_err(dev, "Couldn't determine chip select.\n")=
;
> -                       goto err;
> +                       continue;

reg is mandatory, you should keep the behaviour as it was.

>                 }
>=20
>                 if (cs >=3D CQSPI_MAX_CHIPSELECT) {
> -                       ret =3D -EINVAL;
>                         dev_err(dev, "Chip select %d out of range.\n", cs=
);
> -                       goto err;
> +                       continue;
>                 }
>=20
>                 f_pdata =3D &cqspi->f_pdata[cs];
>                 f_pdata->cqspi =3D cqspi;
>                 f_pdata->cs =3D cs;
>=20
> -               ret =3D cqspi_of_get_flash_pdata(pdev, f_pdata, np);
> -               if (ret)
> -                       goto err;
> -
> -               nor =3D &f_pdata->nor;
> -               mtd =3D &nor->mtd;
> -
> -               mtd->priv =3D nor;
> -
> -               nor->dev =3D dev;
> -               spi_nor_set_flash_node(nor, np);
> -               nor->priv =3D f_pdata;
> -               nor->controller_ops =3D &cqspi_controller_ops;
> -
> -               mtd->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s.%d",
> -                                          dev_name(dev), cs);
> -               if (!mtd->name) {
> -                       ret =3D -ENOMEM;
> -                       goto err;
> -               }
> -
> -               ret =3D spi_nor_scan(nor, NULL, &hwcaps);
> -               if (ret)
> -                       goto err;
> -
> -               ret =3D mtd_device_register(mtd, NULL, 0);
> -               if (ret)
> -                       goto err;
> -
> -               f_pdata->registered =3D true;
> -
> -               if (mtd->size <=3D cqspi->ahb_size &&
> -                   !(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
> -                       f_pdata->use_direct_mode =3D true;
> -                       dev_dbg(nor->dev, "using direct mode for %s\n",
> -                               mtd->name);
> -
> -                       if (!cqspi->rx_chan)
> -                               cqspi_request_mmap_dma(cqspi);
> -               }
> +               return cqspi_of_get_flash_pdata(pdev, f_pdata, np);

drop the return. you now parse just the first discovered flash, whereas bef=
ore=20
your changes we parsed all the described flashes.

>         }
>=20
>         return 0;
> -
> -err:
> -       for (i =3D 0; i < CQSPI_MAX_CHIPSELECT; i++)
> -               if (cqspi->f_pdata[i].registered)
> -                       mtd_device_unregister(&cqspi->f_pdata[i].nor.mtd)=
;
> -       return ret;
>  }
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
> +       master->mode_bits =3D SPI_RX_QUAD | SPI_RX_DUAL;
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

spi_controller_put() to not leak memory.

Cheers,
ta

