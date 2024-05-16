Return-Path: <linux-spi+bounces-2864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786038C76F5
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD61F22D4F
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96E1474A3;
	Thu, 16 May 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QAOn2Mmo"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0F145FE2;
	Thu, 16 May 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864217; cv=none; b=dnTgSI8beP+CM5OQWROrsgNt1pU96f9ucZvM0Rkuwn0trpjog5ENxmF/IFqNGRtbJOuBzrFnq67wf8RrZUlSSgXfhbUkN4IZKBZ/2OO7ilj8gm39T7ES9YyJEHxsbAzgoPhSZ7EUKkWV2nCSWT5YSu2kl1L9q750F055GNyIWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864217; c=relaxed/simple;
	bh=dpVa7G479zxsvMr8u2zWcCsIj7wH+o97XdcxaHwbASo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZCactLskIw6AZNGTVwCcESgLYlOzh3U1nKLAdVGfSefKw+vDGWxxGj+ny5O15xPFbgpGs1KICyEFH+bpJ13yyIShm3n4RRVoJj6k9Im9tWk6zNAqv/zdLrYvnTFPjmwrBuvuqdLYRLVjp3UY1hrAXhbZe0mbod3YsUpk8v4uRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QAOn2Mmo; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6BAAFF804;
	Thu, 16 May 2024 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z2vq8zelYK0GvD16zOjZ/AuXmOgHF5RsOMoLyDARYQ=;
	b=QAOn2Mmo7PWCvAXA/J6U2vsbOs7+WF0cMtVQKyJ3d4HToLFW3Zlujpb/biOv5GJITAoI5z
	IaE8W2M6g9fZxOu8cWiY1QHWXmq5g8IPZqTUAjS7uH8MWaBLPbhQYajEglVsP5pdBUnC2y
	cdyG89ud+/zD9GT/mFzu/9LbJoagCgEtFsS+n2taOHEqV/joxujGCS2e98wXAq6B31XPBe
	s56VppiAhNvQRYXAHX0AkNO5cnJauekFn9DTDdnbuDvtwFFWUp9XxiOmJ1yybVoojedcti
	l29u7UAW7h4a6xb85GeS37i/pX7JXeD9klAGU20mQu78O70jShUA2mj4V+4RDw==
Date: Thu, 16 May 2024 14:56:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v5 5/7] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <20240516145642.644a7f1c@xps-13>
In-Reply-To: <20240508083637.3744003-6-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
	<20240508083637.3744003-6-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

> --- /dev/null
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -0,0 +1,1423 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + *
> + * Authors:
> + *	Md Sadre Alam <quic_mdalam@quicinc.com>
> + *	Sricharan R <quic_srichara@quicinc.com>
> + *	Varadarajan Narayanan <quic_varada@quicinc.com>
> + */
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_adm.h>
> +#include <linux/dma/qcom_bam_dma.h>
> +#include <linux/module.h>
> +#include <linux/mtd/partitions.h>

Not sure why partitions.h is needed here?

> +#include <linux/mtd/rawnand.h>

No raw NAND include.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mtd/nand-qpic-common.h>
> +#include <linux/mtd/spinand.h>

...

> +static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
> +{
> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> +	struct nand_ecc_props *conf =3D &nand->ecc.ctx.conf;
> +	struct nand_ecc_props *reqs =3D &nand->ecc.requirements;
> +	struct nand_ecc_props *user =3D &nand->ecc.user_conf;
> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> +	int step_size =3D 0, strength =3D 0, steps;
> +	int cwperpage, bad_block_byte;
> +	struct qpic_ecc *ecc_cfg;
> +
> +	cwperpage =3D mtd->writesize / NANDC_STEP_SIZE;
> +	snandc->num_cw =3D cwperpage;
> +
> +	ecc_cfg =3D kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
> +	if (!ecc_cfg)
> +		return -ENOMEM;
> +
> +	nand->ecc.ctx.priv =3D ecc_cfg;
> +
> +	if (user->step_size && user->strength) {
> +		step_size =3D user->step_size;
> +		strength =3D user->strength;
> +	} else if (reqs->step_size && reqs->strength) {
> +		step_size =3D reqs->step_size;
> +		strength =3D reqs->strength;
> +	}
> +
> +	if (step_size && strength)
> +		steps =3D mtd->writesize / step_size;
> +
> +	ecc_cfg->ecc_bytes_hw =3D 7;
> +	ecc_cfg->spare_bytes =3D 4;
> +	ecc_cfg->bbm_size =3D 1;
> +	ecc_cfg->bch_enabled =3D true;
> +	ecc_cfg->bytes =3D ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_c=
fg->bbm_size;
> +
> +	ecc_cfg->steps =3D 4;
> +	ecc_cfg->strength =3D 4;
> +	ecc_cfg->step_size =3D 512;
> +
> +	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
> +
> +	ecc_cfg->cw_data =3D 516;
> +	ecc_cfg->cw_size =3D ecc_cfg->cw_data + ecc_cfg->bytes;
> +	bad_block_byte =3D mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) =
+ 1;
> +
> +	ecc_cfg->cfg0 =3D (cwperpage - 1) << CW_PER_PAGE
> +				| ecc_cfg->cw_data << UD_SIZE_BYTES
> +				| 1 << DISABLE_STATUS_AFTER_WRITE
> +				| 3 << NUM_ADDR_CYCLES
> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
> +				| 0 << STATUS_BFR_READ
> +				| 1 << SET_RD_MODE_AFTER_STATUS
> +				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;

Can we please use FIELD_GET/FIELD_SET?

Also I think the coding style proposes:

	val =3D foo |
	      bar;

instead of

	val =3D foo
	 	| bar;


...

> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
> +				     const struct spi_mem_op *op)
> +{
> +	struct qpic_snand_op s_op =3D {};
> +	u32 cmd;
> +
> +	cmd =3D qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> +	s_op.cmd_reg =3D cmd;
> +
> +	if (op->cmd.opcode =3D=3D SPINAND_PROGRAM_LOAD) {
> +		if (snandc->page_rw)
> +			snandc->data_buf =3D (u8 *)op->data.buf.out;
> +		if (snandc->oob_rw)
> +			snandc->oob_buf =3D (u8 *)op->data.buf.out;

Quick comment: looks wrong, no?

> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
> +				 const struct spi_mem_op *op)
> +{
> +	struct qpic_snand_op s_op =3D {};
> +	u32 cmd;
> +	int ret, opcode;
> +
> +	cmd =3D qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> +
> +	s_op.cmd_reg =3D cmd;
> +	s_op.addr1_reg =3D op->addr.val;
> +	s_op.addr2_reg =3D 0;
> +
> +	opcode =3D op->cmd.opcode;
> +
> +	switch (opcode) {
> +	case SPINAND_WRITE_EN:
> +		return 0;
> +	case SPINAND_PROGRAM_EXECUTE:
> +		s_op.addr1_reg =3D op->addr.val << 16;
> +		s_op.addr2_reg =3D op->addr.val >> 16 & 0xff;
> +		snandc->addr1 =3D s_op.addr1_reg;
> +		snandc->addr2 =3D s_op.addr2_reg;
> +		snandc->cmd =3D cmd;
> +		return qcom_spi_program_execute(snandc, op);
> +	case SPINAND_READ:
> +		s_op.addr1_reg =3D (op->addr.val << 16);
> +		s_op.addr2_reg =3D op->addr.val >> 16 & 0xff;
> +		snandc->addr1 =3D s_op.addr1_reg;
> +		snandc->addr2 =3D s_op.addr2_reg;
> +		snandc->cmd =3D cmd;
> +		return 0;
> +	case SPINAND_ERASE:
> +		s_op.addr2_reg =3D (op->addr.val >> 16) & 0xffff;
> +		s_op.addr1_reg =3D op->addr.val;
> +		snandc->addr1 =3D s_op.addr1_reg;
> +		snandc->addr1 <<=3D 16;

Feels wrong as well

> +		snandc->addr2 =3D s_op.addr2_reg;
> +		snandc->cmd =3D cmd;
> +		qcom_spi_block_erase(snandc);
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	snandc->buf_count =3D 0;
> +	snandc->buf_start =3D 0;
> +	qcom_clear_read_regs(snandc);
> +	qcom_clear_bam_transaction(snandc);
> +
> +	snandc->regs->cmd =3D s_op.cmd_reg;
> +	snandc->regs->exec =3D 1;
> +	snandc->regs->addr0 =3D s_op.addr1_reg;
> +	snandc->regs->addr1 =3D s_op.addr2_reg;
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_=
BAM_NEXT_SGL);
> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_=
BAM_NEXT_SGL);
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret)
> +		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
> +
> +	return ret;
> +}
> +
> +static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const str=
uct spi_mem_op *op)
> +{
> +	int ret, val, opcode;
> +	bool copy =3D false, copy_ftr =3D false;
> +
> +	ret =3D qcom_spi_send_cmdaddr(snandc, op);
> +	if (ret)
> +		return ret;
> +
> +	snandc->buf_count =3D 0;
> +	snandc->buf_start =3D 0;
> +	qcom_clear_read_regs(snandc);
> +	qcom_clear_bam_transaction(snandc);
> +	opcode =3D op->cmd.opcode;
> +
> +	switch (opcode) {
> +	case SPINAND_READID:
> +		snandc->buf_count =3D 4;
> +		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +		copy =3D true;
> +		break;
> +	case SPINAND_GET_FEATURE:
> +		snandc->buf_count =3D 4;
> +		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
> +		copy_ftr =3D true;
> +		break;
> +	case SPINAND_SET_FEATURE:
> +		snandc->regs->flash_feature =3D *(u32 *)op->data.buf.out;
> +		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
> +				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
> +		break;
> +	default:
> +		return 0;

No error state?

> +	}
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret)
> +		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opco=
de);
> +
> +	if (copy) {
> +		qcom_nandc_dev_to_mem(snandc, true);
> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
> +	}
> +
> +	if (copy_ftr) {
> +		qcom_nandc_dev_to_mem(snandc, true);
> +		val =3D le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
> +		val >>=3D 8;
> +		memcpy(op->data.buf.in, &val, snandc->buf_count);
> +	}
> +
> +	return ret;
> +}
> +
> +static bool qcom_spi_is_page_op(const struct spi_mem_op *op)
> +{
> +	if (op->addr.buswidth !=3D 1 && op->addr.buswidth !=3D 2 && op->addr.bu=
swidth !=3D 4)
> +		return false;
> +
> +	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> +		if (op->addr.buswidth =3D=3D 4 && op->data.buswidth =3D=3D 4)
> +			return true;
> +
> +		if (op->addr.nbytes =3D=3D 2 && op->addr.buswidth =3D=3D 1)
> +			return true;
> +
> +	} else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
> +		if (op->data.buswidth =3D=3D 4)
> +			return true;
> +		if (op->addr.nbytes =3D=3D 2 && op->addr.buswidth =3D=3D 1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_m=
em_op *op)
> +{
> +	if (!spi_mem_default_supports_op(mem, op))
> +		return false;
> +
> +	if (op->cmd.nbytes !=3D 1 || op->cmd.buswidth !=3D 1)
> +		return false;
> +
> +	if (qcom_spi_is_page_op(op))
> +		return true;
> +
> +	return ((!op->addr.nbytes || op->addr.buswidth =3D=3D 1) &&
> +		(!op->dummy.nbytes || op->dummy.buswidth =3D=3D 1) &&
> +		(!op->data.nbytes || op->data.buswidth =3D=3D 1));
> +}
> +
> +static int qcom_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
> +{
> +	struct qcom_nand_controller *snandc =3D spi_controller_get_devdata(mem-=
>spi->controller);
> +
> +	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.op=
code,
> +		op->addr.val, op->addr.buswidth, op->addr.nbytes,
> +		op->data.buswidth, op->data.nbytes);
> +
> +	if (qcom_spi_is_page_op(op)) {
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +			return qcom_spi_read_page_cache(snandc, op);
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
> +			return qcom_spi_write_page_cache(snandc, op);
> +	} else {
> +		return qcom_spi_io_op(snandc, op);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops qcom_spi_mem_ops =3D {
> +	.supports_op =3D qcom_spi_supports_op,
> +	.exec_op =3D qcom_spi_exec_op,
> +};
> +
> +static const struct spi_controller_mem_caps qcom_spi_mem_caps =3D {
> +	.ecc =3D true,
> +};
> +
> +static int qcom_spi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct spi_controller *ctlr;
> +	struct qcom_nand_controller *snandc;
> +	struct resource *res;
> +	const void *dev_data;
> +	struct qpic_ecc *ecc;
> +	int ret;
> +
> +	ecc =3D devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> +	if (!ecc)
> +		return -ENOMEM;
> +
> +	ctlr =3D __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ctlr);
> +
> +	snandc =3D spi_controller_get_devdata(ctlr);
> +
> +	snandc->ctlr =3D ctlr;
> +	snandc->dev =3D dev;
> +	snandc->ecc =3D ecc;
> +
> +	snandc->oob_buf =3D devm_kzalloc(dev, OOB_BUF_SIZE, GFP_KERNEL);
> +	if (!snandc->oob_buf)
> +		return -ENOMEM;
> +
> +	dev_data =3D of_device_get_match_data(dev);
> +	if (!dev_data) {
> +		dev_err(&pdev->dev, "failed to get device data\n");
> +		return -ENODEV;
> +	}
> +
> +	snandc->props =3D dev_data;
> +	snandc->dev =3D &pdev->dev;
> +
> +	snandc->core_clk =3D devm_clk_get(dev, "core");
> +	if (IS_ERR(snandc->core_clk))
> +		return PTR_ERR(snandc->core_clk);
> +
> +	snandc->aon_clk =3D devm_clk_get(dev, "aon");
> +	if (IS_ERR(snandc->aon_clk))
> +		return PTR_ERR(snandc->aon_clk);
> +
> +	snandc->iomacro_clk =3D devm_clk_get(dev, "iom");
> +	if (IS_ERR(snandc->iomacro_clk))
> +		return PTR_ERR(snandc->iomacro_clk);
> +
> +	snandc->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(snandc->base))
> +		return PTR_ERR(snandc->base);
> +
> +	snandc->base_phys =3D res->start;
> +	snandc->base_dma =3D dma_map_resource(dev, res->start, resource_size(re=
s),
> +					    DMA_BIDIRECTIONAL, 0);
> +	if (dma_mapping_error(dev, snandc->base_dma))
> +		return -ENXIO;
> +
> +	ret =3D clk_prepare_enable(snandc->core_clk);
> +	if (ret)
> +		goto err_core_clk;

error labels should point at the next freeing instruction, they should
not be named against where they are called.

Same below.

> +
> +	ret =3D clk_prepare_enable(snandc->aon_clk);
> +	if (ret)
> +		goto err_aon_clk;
> +
> +	ret =3D clk_prepare_enable(snandc->iomacro_clk);
> +	if (ret)
> +		goto err_snandc_alloc;

This label is really badly named

> +
> +	ret =3D qcom_nandc_alloc(snandc);
> +	if (ret)
> +		goto err_iom_clk;

		goto err_dis_iom_clk; ?

> +
> +	ret =3D qcom_spi_init(snandc);
> +	if (ret)
> +		goto err_init;
> +
> +	/* setup ECC engine */
> +	snandc->ecc_eng.dev =3D &pdev->dev;
> +	snandc->ecc_eng.integration =3D NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
> +	snandc->ecc_eng.ops =3D &qcom_spi_ecc_engine_ops_pipelined;
> +	snandc->ecc_eng.priv =3D snandc;
> +
> +	ret =3D nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register ecc engine.\n");

Maybe you can print the error if we want the dev_err() call to be
useful?

> +		goto err_init;
> +	}
> +
> +	ctlr->num_chipselect =3D QPIC_QSPI_NUM_CS;
> +	ctlr->mem_ops =3D &qcom_spi_mem_ops;
> +	ctlr->mem_caps =3D &qcom_spi_mem_caps;
> +	ctlr->dev.of_node =3D pdev->dev.of_node;
> +	ctlr->mode_bits =3D SPI_TX_DUAL | SPI_RX_DUAL |
> +			    SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +	ret =3D spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed.\n");
> +		goto err_init;
> +	}
> +
> +	return 0;
> +
> +err_init:
> +	qcom_nandc_unalloc(snandc);
> +err_iom_clk:
> +	clk_disable_unprepare(snandc->iomacro_clk);
> +err_snandc_alloc:
> +	clk_disable_unprepare(snandc->aon_clk);
> +err_aon_clk:
> +	clk_disable_unprepare(snandc->core_clk);
> +err_core_clk:
> +	dma_unmap_resource(dev, res->start, resource_size(res),
> +			   DMA_BIDIRECTIONAL, 0);
> +	return ret;
> +}
> +
> +static int qcom_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
> +	struct qcom_nand_controller *snandc =3D spi_controller_get_devdata(ctlr=
);
> +	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	spi_unregister_controller(ctlr);
> +
> +	clk_disable_unprepare(snandc->aon_clk);
> +	clk_disable_unprepare(snandc->core_clk);
> +	clk_disable_unprepare(snandc->iomacro_clk);
> +
> +	dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
> +			   DMA_BIDIRECTIONAL, 0);

No unalloc?

BTW unalloc is a bit weird. "free" or "cleanup" might be better.

> +	return 0;
> +}
> +
> +static const struct qcom_nandc_props ipq9574_snandc_props =3D {
> +	.dev_cmd_reg_start =3D 0x7000,
> +	.supports_bam =3D true,
> +};
> +
> +static const struct of_device_id qcom_snandc_of_match[] =3D {
> +	{
> +		.compatible =3D "qcom,spi-qpic-snand",
> +		.data =3D &ipq9574_snandc_props,
> +	},
> +	{}
> +}
> +MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
> +
> +static struct platform_driver qcom_spi_driver =3D {
> +	.driver =3D {
> +		.name		=3D "qcom_snand",
> +		.of_match_table =3D qcom_snandc_of_match,
> +	},
> +	.probe =3D qcom_spi_probe,
> +	.remove =3D qcom_spi_remove,
> +};
> +module_platform_driver(qcom_spi_driver);
> +
> +MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
> +MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nan=
d-qpic-common.h
> index 096c15d3be76..dd2b56125bc1 100644
> --- a/include/linux/mtd/nand-qpic-common.h
> +++ b/include/linux/mtd/nand-qpic-common.h
> @@ -315,11 +315,56 @@ struct nandc_regs {
>  	__le32 read_location_last1;
>  	__le32 read_location_last2;
>  	__le32 read_location_last3;
> +	__le32 spi_cfg;
> +	__le32 num_addr_cycle;
> +	__le32 busy_wait_cnt;
> +	__le32 flash_feature;
> =20
>  	__le32 erased_cw_detect_cfg_clr;
>  	__le32 erased_cw_detect_cfg_set;
>  };
> =20
> +/*
> + * ECC state struct
> + * @corrected:		ECC corrected
> + * @bitflips:		Max bit flip
> + * @failed:		ECC failed
> + */
> +struct qcom_ecc_stats {
> +	u32 corrected;
> +	u32 bitflips;
> +	u32 failed;
> +};
> +
> +struct qpic_ecc {
> +	struct device *dev;
> +	const struct qpic_ecc_caps *caps;
> +	struct completion done;
> +	u32 sectors;
> +	u8 *eccdata;
> +	bool use_ecc;
> +	u32 ecc_modes;
> +	int ecc_bytes_hw;
> +	int spare_bytes;
> +	int bbm_size;
> +	int ecc_mode;
> +	int bytes;
> +	int steps;
> +	int step_size;
> +	int strength;
> +	int cw_size;
> +	int cw_data;
> +	u32 cfg0, cfg1;
> +	u32 cfg0_raw, cfg1_raw;
> +	u32 ecc_buf_cfg;
> +	u32 ecc_bch_cfg;
> +	u32 clrflashstatus;
> +	u32 clrreadstatus;
> +	bool bch_enabled;
> +};
> +
> +struct qpic_ecc;
> +
>  /*
>   * NAND controller data struct
>   *
> @@ -329,6 +374,7 @@ struct nandc_regs {
>   *
>   * @core_clk:			controller clock
>   * @aon_clk:			another controller clock
> + * @iomacro_clk:		io macro clock
>   *
>   * @regs:			a contiguous chunk of memory for DMA register
>   *				writes. contains the register values to be
> @@ -338,6 +384,7 @@ struct nandc_regs {
>   *				initialized via DT match data
>   *
>   * @controller:			base controller structure
> + * @ctlr:			spi controller structure
>   * @host_list:			list containing all the chips attached to the
>   *				controller
>   *
> @@ -375,6 +422,7 @@ struct qcom_nand_controller {
> =20
>  	struct clk *core_clk;
>  	struct clk *aon_clk;
> +	struct clk *iomacro_clk;
> =20
>  	struct nandc_regs *regs;
>  	struct bam_transaction *bam_txn;
> @@ -382,6 +430,7 @@ struct qcom_nand_controller {
>  	const struct qcom_nandc_props *props;
> =20
>  	struct nand_controller controller;
> +	struct spi_controller *ctlr;
>  	struct list_head host_list;
> =20
>  	union {
> @@ -418,6 +467,21 @@ struct qcom_nand_controller {
> =20
>  	u32 cmd1, vld;
>  	bool exec_opwrite;
> +	struct qpic_ecc *ecc;
> +	struct qcom_ecc_stats ecc_stats;
> +	struct nand_ecc_engine ecc_eng;
> +	u8 *data_buf;
> +	u8 *oob_buf;
> +	u32 wlen;
> +	u32 addr1;
> +	u32 addr2;
> +	u32 cmd;
> +	u32 num_cw;
> +	u32 pagesize;
> +	bool oob_rw;
> +	bool page_rw;
> +	bool raw_rw;
> +	bool read_last_cw;
>  };

If all these definitions are only used by the spi controller, I don't
see why you want to put them in the common file.

Thanks,
Miqu=C3=A8l

