Return-Path: <linux-spi+bounces-6905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19485A43346
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 03:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81789189B6CC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770514387B;
	Tue, 25 Feb 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL1rKnIX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5628DA1;
	Tue, 25 Feb 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451616; cv=none; b=K6ftZYCoVxWkPBp/xgBBv1b80Th7lerJmGMY99fKmShQ5gFv3D55U+5m7Sq7tz9xseYsBGSii6e8O5eg6i2PCzXlfmZrFlxXWGhfMnefLScUl+0eWE/Q1xU8j8Tpe4X5GPjMhmXnmU0Up7KK3ER5mWpruIuWi+6ztns+Gsrzmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451616; c=relaxed/simple;
	bh=9sjMRPauckJrui2CkfrQ3cYi2VYBntbBubLUjwdMQjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QefgHbuXaKLNIpuHkAskcAoxXmR4udcMlnVNdCAv3m+t3BaZjCvNa3NA3y+WVaP/R9XIBDXNShN9YH7FkrZePZoUzBMJXVaAdVajbjkrr3HQMAmm8IgaObLLSYPIa7UoerKXjShWJE6B5N3Qyjje2mrKAWNvB4cAaUITOktnV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL1rKnIX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c665ef4cso88629705ad.3;
        Mon, 24 Feb 2025 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740451613; x=1741056413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmIWyDzbi7XG4PWOrNU7Jp5a97tuft4JsdTFHE1ZFT4=;
        b=dL1rKnIXD6Vhlp6rFkqPvnWaXp8QQXbgrYrTDr2I8Xm+tG06t8Hi84a/3Sv4HIq7Rc
         Dk0etgPwtkYxVYROVyL1+aZAA130TeHi7z5ACh/LNHvMQbkueQrW7vv498aMDV68B66e
         ZuQR+XQzeHqjeQVshWdM/QEu3YZU72PeZHZQAbRSymL2xpd9JgWusIqysGBkc8rLECur
         5mZ52d+XCRipG0E3Eszvf3gcCELv+6VuilXP3dmi8LbxBNZ28RTechAsyEhG62/qWJ2h
         ALE9bfQ0q4bovK1KSI0a3dwHmwzyK9fyHsfLI/idVHdyCJHttQSEsWY85DGAElX+i2CA
         WxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740451613; x=1741056413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmIWyDzbi7XG4PWOrNU7Jp5a97tuft4JsdTFHE1ZFT4=;
        b=qPolEimF7e7W9trSU3oeT8w+6e57Tz3bP6k8IUwayN1kpDfFhoDgVXBbg6Aplwxs2e
         pTwroGY6J1nsDD5XEbZhSlFKLM06gDPm0FGAvVkmC+P2kZVd2/nyVVROPGf33OvW/UHO
         N2ZS3hPU2T8KbM8q5kAhLoW2JPhKfV54x/FJfYCeVwKfCrLAOuw1mVae8GUvoQyxFmW1
         Z3QEVqN5eWbeXaSSVXWg/VHsH7oYNuUWZq73jZQCniBiV9glnQZ3rXxemwYB0cOkUj3m
         pUhFOzsWAdnPK2yfIGOgXEDvFS44ySDePtvAUCfEDwzyzaqPlhWJDPs56OYXqkqMeeUY
         I70A==
X-Forwarded-Encrypted: i=1; AJvYcCWCmo3b9qSz1NU4J/0/4fNYYEPOF+qeD6iJQFfBwpv4tdSVwBcVSbv2+7/rnFlxOvzeZcri27viPbn8ZyxX@vger.kernel.org, AJvYcCWGH1dXM93h97nR5/mUNN19n2LXo2PKpxrmEhuXdsW01FE3gUzNy9G993wS9DZAQFqrd5dZqJhYqPq7@vger.kernel.org, AJvYcCWhlpb+IaH3C8Jin0YAfHydJAEhXu8/LDwSsV/O6n29RHlWQEL1d37CWw6l1y0NdYfYAww0LQgsVYwS@vger.kernel.org
X-Gm-Message-State: AOJu0YzMObwc68SAdCPmopw/iHaY2sM6Csx57cRjW+VJm6feF0YJF+vl
	zrHjetd4I2Xh8tyfP7JSu/yHQQwIkI0CboASF/eMMAV1jJtZJ2kn
X-Gm-Gg: ASbGncs4U47eLzIFE2Z5Ugkw/4ecdop9TgCy5M8G+hewPVF0ZuNKf2HB1VKatGDYUTM
	PC9gqcFp6h5n7p/jE9WzwS3L3M+R7ifanY9ZoluBBrkqrd+ckkVIwObPdr0LEuCy1uXiVo/lea+
	2r+Z2EgVLF6rETMK6v2FtRfzjhnOXk+cpJZnmuFnCbBDSgP1jWvPDELKskSJ8eYN/xr7V628VtZ
	vOqMFF3LoK2HV2hEeAQnOgBRN/sitDzEqZ8snn/LPmXDmAvUb0KKlyOGNlcfBBknd5yMHnJiZs3
	G5oCgwzDkZofp6RksYKUrEA=
X-Google-Smtp-Source: AGHT+IG62mV9bUNCTrCikvFZ49tzCfx9NyDU8cgaFnBUFHLGXzqnYJ/ncZN2tiei9ufed4SF/bBPXw==
X-Received: by 2002:a17:903:41d2:b0:21f:33:ad2 with SMTP id d9443c01a7336-221a003892emr229965215ad.52.1740451613128;
        Mon, 24 Feb 2025 18:46:53 -0800 (PST)
Received: from localhost ([111.34.70.129])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a00ab6bsm3279565ad.58.2025.02.24.18.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:46:52 -0800 (PST)
Date: Tue, 25 Feb 2025 10:46:49 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	looong.bin@gmail.com
Subject: Re: [PATCH 2/3] spi: sophgo: add Sophgo SPI NOR controller driver
Message-ID: <6sjygqay4kpwupau7gx5uulo4t32c3rn5kiktqxp6t2phi45ly@elsqfqzpnumz>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-3-looong.bin@gmail.com>
 <20250224132115-GYA41655@gentoo>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224132115-GYA41655@gentoo>

On Mon, Feb 24, 2025 at 01:21:15PM +0000, Yixun Lan wrote:
> Hi Longbin:
> 
> On 18:12 Mon 24 Feb     , Longbin Li wrote:
> > Add support for Sophgo SPI NOR controller in Sophgo SoC.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >  drivers/spi/Kconfig          |   9 +
> >  drivers/spi/Makefile         |   1 +
> >  drivers/spi/spi-sophgo-nor.c | 501 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 511 insertions(+)
> >  create mode 100644 drivers/spi/spi-sophgo-nor.c
> > 
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index ea8a31032927..6b6d7b348485 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -1021,6 +1021,15 @@ config SPI_SN_F_OSPI
> >  	  for connecting an SPI Flash memory over up to 8-bit wide bus.
> >  	  It supports indirect access mode only.
> > 
> > +config SPI_SOPHGO_NOR
> > +	tristate "Sophgo SPI NOR Controller"
> > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > +	help
> > +	  This enables support for the Sophgo SPI NOR controller,
> > +	  which supports Dual/Qual read and write operations while
> > +	  also supporting 3Byte address devices and 4Byte address
> > +	  devices.
> > +
> >  config SPI_SPRD
> >  	tristate "Spreadtrum SPI controller"
> >  	depends on ARCH_SPRD || COMPILE_TEST
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index 9db7554c1864..9ded1de4b2fd 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -134,6 +134,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
> >  obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
> >  obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
> >  obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
> > +obj-$(CONFIG_SPI_SOPHGO_NOR)	+= spi-sophgo-nor.o
> >  obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
> >  obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
> >  obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
> > diff --git a/drivers/spi/spi-sophgo-nor.c b/drivers/spi/spi-sophgo-nor.c
> > new file mode 100644
> > index 000000000000..1139deeac327
> > --- /dev/null
> > +++ b/drivers/spi/spi-sophgo-nor.c
> > @@ -0,0 +1,501 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Sophgo SPI NOR controller driver
> > + *
> > + * Copyright (c) 2025 Longbin Li <looong.bin@gmail.com>
> > + */
> > +
> > [...]
> > +struct sophgo_spifmc {
> > +	struct spi_controller *ctrl;
> > +	void __iomem *io_base;
> > +	struct device *dev;
> > +	struct mutex lock;
> it will be great to document the lock

Thanks, but I don't think the function of this lock is complicated,
adding comments may be useless.

> > +	struct clk *clk;
> > +};
> > +
> > +static int sophgo_spifmc_wait_int(struct sophgo_spifmc *spifmc, u8 int_type)
> > +{
> > +	u32 stat;
> > +
> > +	return readl_poll_timeout(spifmc->io_base + SPIFMC_INT_STS, stat,
> > +				  (stat & int_type), 0, 1000000);
> > +}
> > +
> > +
> > [...]
> > +static ssize_t sophgo_spifmc_trans_reg(struct sophgo_spifmc *spifmc,
> > +				       const struct spi_mem_op *op)
> > +{
> > +	const u8 *dout = NULL;
> > +	u8 *din = NULL;
> > +	size_t len = op->data.nbytes;
> > +	u32 reg;
> > +	int ret;
> > +	int i;
> squash them which save one line:
> 	int i, ret;
> 

Thanks, I will modify it.

> > +
> > +	if (op->data.dir == SPI_MEM_DATA_IN)
> > +		din = op->data.buf.in;
> > +	else
> > +		dout = op->data.buf.out;
> > +
> > +	reg = sophgo_spifmc_init_reg(spifmc);
> > +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
> > +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> > +
> > +	if (din) {
> > +		reg |= SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT;
> > +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> > +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> > +
> > +		writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
> > +	} else {
> > +		/*
> > +		 * If write values to the Status Register,
> > +		 * configure TRAN_CSR register as the same as
> > +		 * sophgo_spifmc_read_reg.
> > +		 */
> > +		if (op->cmd.opcode == 0x01) {
> > +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> > +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> > +			writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> > +		}
> > +	}
> > +
> > +
> > [...]
> > +static const struct spi_controller_mem_ops sophgo_spifmc_mem_ops = {
> > +	.exec_op = sophgo_spifmc_exec_op,
> > +};
> > +
> > +static void sophgo_spifmc_init(struct sophgo_spifmc *spifmc)
> > +{
> > +	u32 tran_csr;
> > +	u32 reg;
> > +
> > +	writel(0, spifmc->io_base + SPIFMC_DMMR);
> > +
> > +	reg = readl(spifmc->io_base + SPIFMC_CTRL);
> > +	reg |= SPIFMC_CTRL_SRST;
> ..
> > +	reg &= ~((1 << 11) - 1);
> so this is a mask? use macro to define, instead of using magic number

Yes, this is a mask to init SPI Clock Divider, I will add a macro, thanks.

> > +	reg |= 1;
> > +	writel(reg, spifmc->io_base + SPIFMC_CTRL);
> > +
> > +	writel(0, spifmc->io_base + SPIFMC_CE_CTRL);
> > +
> > +	tran_csr = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
> > +	tran_csr |= (0 << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT);
> > +	tran_csr |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE;
> > +	tran_csr |= SPIFMC_TRAN_CSR_WITH_CMD;
> > +	writel(tran_csr, spifmc->io_base + SPIFMC_TRAN_CSR);
> > +}
> > +
> > +static int sophgo_spifmc_probe(struct platform_device *pdev)
> > +{
> > +	struct spi_controller *ctrl;
> > +	struct sophgo_spifmc *spifmc;
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
> > +	if (!ctrl)
> > +		return -ENOMEM;
> > +
> > +	spifmc = spi_controller_get_devdata(ctrl);
> > +	dev_set_drvdata(&pdev->dev, ctrl);
> > +
> ..
> > +	spifmc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(spifmc->clk)) {
> > +		dev_err(&pdev->dev, "AHB clock not found.\n");
> > +		return PTR_ERR(spifmc->clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(spifmc->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
> > +		return ret;
> > +	}
> you can combine above with devm_clk_get_enabled(), and simplify 
> return routine by using "return dev_err_probe(..)"
> 

Thanks, I will modify it.

> > +
> > +	spifmc->dev = &pdev->dev;
> > +	spifmc->ctrl = ctrl;
> > +
> > +	spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	ctrl->num_chipselect = 1;
> > +	ctrl->dev.of_node = pdev->dev.of_node;
> > +	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
> > +	ctrl->auto_runtime_pm = false;
> > +	ctrl->mem_ops = &sophgo_spifmc_mem_ops;
> > +	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
> > +
> > +	mutex_init(&spifmc->lock);
> strictly, you still need to do error handler, e.g, destroy mutex if probe fail

Thanks, I will add it.

> > +
> > +	sophgo_spifmc_init(spifmc);
> > +	sophgo_spifmc_init_reg(spifmc);
> > +
> > +	return devm_spi_register_controller(&pdev->dev, ctrl);
> > +}
> > +
> > [...]
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

