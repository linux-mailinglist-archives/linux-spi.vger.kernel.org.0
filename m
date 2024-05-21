Return-Path: <linux-spi+bounces-2984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729898CAF55
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936D61C217BA
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46914770FB;
	Tue, 21 May 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="amP6BpdD"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4106EB5D;
	Tue, 21 May 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297860; cv=none; b=b7saaN/coe7Rf8Lgexc0lEZaliL6NqinpawdU1QfmgleqHkNWP8VjO5Ht+Hh4PZxUBF/qOHROH7jsXGIjOP4HEi70HUKBgEucaMhbs7/AB0QLfhht9AHMlOha7mzgSVoZCZmmYWrplghmTOrXNRyO5NuZbSmtc07mZ1gRFO9i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297860; c=relaxed/simple;
	bh=XE5Cmajq4TtuVFbLGKV427sERkxiIaKB04dIKxJtm9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWTU6Ei0xF8ySWSmlnxAJ88pKnTV4H1sqXTV82yBaCP8I1h5/kY3QyBhBup/42ueWXM/71gckG8gF9ij6hi5f+9UU/fqpDziY2ihJtqNOHLQnSPAs287y94xhry0LfygtXsBcHDM216K95I2WdZ1IdaVamhYvtv1XtqmjAQLDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=amP6BpdD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 681B21BF20B;
	Tue, 21 May 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716297854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHW9yaCA5KhU/nX6IBStFBScnVjslIbk+98nChBlJnk=;
	b=amP6BpdDo3jDhLN+DuTG1V4g7L51bFDJKbyTdh71Z3DrlK/J6Ca/tX2qVOQnEe7IxQ+FUZ
	NccDgpHf/ZNF+QUW9q5r7euXwW+NTU+K3knGjz3MqndYuCA16ExDm0l7ad3qoXkK+s9N8f
	FSCihgo20KDNxr9lgbqBwVNXAlv2DmumUEOZkoAL39ouYtFsS0nZiJwdHV7Gb1AxtmDI3d
	+X3IEqr9uQaGJ8WRZ8xbqQCgdLBNfPtzDu+EWbOhGJbpbXzEeHeTHEUx15Kk08Qm4XlLrn
	Icb3adSrFDKpvhXZPIFErsc/O3uR0I2ySl0mKlTnR7qpY5wL5x2bo/uZZdyrkA==
Date: Tue, 21 May 2024 15:24:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
Subject: Re: [PATCH v6 6/8] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <20240521152410.7cff71ab@xps-13>
In-Reply-To: <20240521105532.1537845-7-quic_mdalam@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
	<20240521105532.1537845-7-quic_mdalam@quicinc.com>
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

> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index e59106e0a3af..12ee33c4ac4e 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -5,6 +5,10 @@ obj-$(CONFIG_MTD_NAND_CORE) +=3D nandcore.o
>  obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) +=3D ecc-mtk.o
>  ifeq ($(CONFIG_MTD_NAND_QCOM),y)
>  obj-y	+=3D qpic_common.o
> +else
> +ifeq ($(CONFIG_SPI_QPIC_SNAND),y)
> +obj-y   +=3D qpic_common.o
> +endif

Same issue.

>  endif
>  obj-y	+=3D onenand/
>  obj-y	+=3D raw/
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a2c99ff33e0a..bb7579246f2f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -892,6 +892,14 @@ config SPI_QCOM_QSPI
>  	help
>  	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
> =20

...

> +static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_devic=
e *nand)
> +{
> +	struct qpic_spi_nand *qspi;
> +	struct nand_ecc_engine *eng =3D nand->ecc.engine;
> +
> +	qspi =3D container_of(eng, struct qpic_spi_nand, ecc_eng);

Please encode this into a macro and use it on the second line of this
function:

	struct qpic_spi_nand *qspi =3D ecceng_to_qspi(eng);

> +	return qspi->snandc;
> +}
> +
> +static int qcom_spi_init(struct qcom_nand_controller *snandc)
> +{
> +	u32 snand_cfg_val =3D 0x0;
> +	int ret;
> +
> +	snand_cfg_val |=3D (LOAD_CLK_CNTR_INIT_EN | (CLK_CNTR_INIT_VAL_VEC << 1=
6) |
> +			 (FEA_STATUS_DEV_ADDR << 8) | SPI_CFG);

FIELD_PREP ?

> +
> +	snandc->regs->spi_cfg =3D snand_cfg_val;
> +	snandc->regs->num_addr_cycle =3D SPI_NUM_ADDR;
> +	snandc->regs->busy_wait_cnt =3D SPI_WAIT_CNT;
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, =
1, 0);
> +
> +	snand_cfg_val &=3D ~LOAD_CLK_CNTR_INIT_EN;
> +	snandc->regs->spi_cfg =3D snand_cfg_val;
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, =
1, 0);
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->num_addr_cycle, NAND_NUM_ADDR=
_CYCLES, 1, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->busy_wait_cnt, NAND_BUSY_CHEC=
K_WAIT_CNT, 1,
> +			   NAND_BAM_NEXT_SGL);
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret) {
> +		dev_err(snandc->dev, "failure in submitting spi init descriptor\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *oobregion)
> +{
> +	struct nand_device *nand =3D mtd_to_nanddev(mtd);
> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> +	struct qpic_ecc *qecc =3D snandc->qspi->ecc;
> +
> +	if (section > 1)
> +		return -ERANGE;
> +
> +	if (!section) {
> +		oobregion->length =3D (qecc->bytes * (qecc->steps - 1)) + qecc->bbm_si=
ze;
> +		oobregion->offset =3D 0;

No, offset 0 is for the BBM. This is wrong.
The whole oob layout looks really really wrong.

ECC bytes are where the ECC engine puts its bytes in the OOB area.
Free bytes start after the BBM and fill the gaps until the end of the
area, except where there are ECC bytes.

> +	} else {
> +		oobregion->length =3D qecc->ecc_bytes_hw + qecc->spare_bytes;
> +		oobregion->offset =3D mtd->oobsize - oobregion->length;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *oobregion)
> +{
> +	struct nand_device *nand =3D mtd_to_nanddev(mtd);
> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> +	struct qpic_ecc *qecc =3D snandc->qspi->ecc;
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length =3D qecc->steps * 4;
> +	oobregion->offset =3D ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_siz=
e;
> +
> +	return 0;
> +}
> +

...

> +static int qcom_spi_ecc_prepare_io_req_pipelined(struct nand_device *nan=
d,
> +						 struct nand_page_io_req *req)
> +{
> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> +	struct qpic_ecc *ecc_cfg =3D nand_to_ecc_ctx(nand);
> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> +
> +	snandc->qspi->ecc =3D ecc_cfg;
> +	snandc->qspi->pagesize =3D mtd->writesize;
> +	snandc->qspi->raw_rw =3D false;
> +	snandc->qspi->oob_rw =3D false;
> +	snandc->qspi->page_rw =3D false;
> +
> +	if (req->datalen)
> +		snandc->qspi->page_rw =3D true;
> +
> +	if (req->ooblen) {
> +		snandc->qspi->oob_rw =3D true;
> +		if (req->ooblen =3D=3D BAD_BLOCK_MARKER_SIZE)
> +			snandc->qspi->read_last_cw =3D true;

???

> +	}
> +
> +	if (req->mode =3D=3D MTD_OPS_RAW)
> +		snandc->qspi->raw_rw =3D true;
> +
> +	return 0;
> +}
> +
> +static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *nand,
> +						struct nand_page_io_req *req)
> +{
> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> +
> +	if (req->mode =3D=3D MTD_OPS_RAW || req->type !=3D NAND_PAGE_READ)
> +		return 0;
> +
> +	if (snandc->qspi->ecc_stats.failed)
> +		mtd->ecc_stats.failed +=3D snandc->qspi->ecc_stats.failed;
> +	mtd->ecc_stats.corrected +=3D snandc->qspi->ecc_stats.corrected;

Seems strange

> +
> +	if (snandc->qspi->ecc_stats.failed)
> +		return -EBADMSG;
> +	else
> +		return snandc->qspi->ecc_stats.bitflips;
> +}
> +
> +static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined =3D {
> +	.init_ctx =3D qcom_spi_ecc_init_ctx_pipelined,
> +	.cleanup_ctx =3D qcom_spi_ecc_cleanup_ctx_pipelined,
> +	.prepare_io_req =3D qcom_spi_ecc_prepare_io_req_pipelined,
> +	.finish_io_req =3D qcom_spi_ecc_finish_io_req_pipelined,
> +};
> +

...

> +static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,
> +				  const struct spi_mem_op *op)
> +{
> +	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
> +	u8 *data_buf =3D NULL, *oob_buf =3D NULL;
> +	int ret, cw;
> +	u32 num_cw =3D snandc->qspi->num_cw;
> +
> +	if (snandc->qspi->page_rw)

I don't like this indirection very much. Can't you simplify this and
just follow the spi-mem op instead of constantly trying to add
additional stuff?

The hardware is already quite complex, but it feels like your adding
yet another pile of unnecessary complexity.

> +		data_buf =3D op->data.buf.in;
> +
> +	if (snandc->qspi->oob_rw)
> +		oob_buf =3D op->data.buf.in;

Same buffer pointed by the two pointers? hum

> +
> +	if (!oob_buf) {
> +		oob_buf =3D snandc->qspi->oob_buf;
> +		memset(oob_buf, 0xff, OOB_BUF_SIZE);
> +	}
> +
> +	for (cw =3D 0; cw < num_cw; cw++) {
> +		ret =3D qcom_spi_read_cw_raw(snandc, data_buf, oob_buf, cw);
> +		if (ret)
> +			return ret;
> +
> +		if (data_buf)
> +			data_buf +=3D ecc_cfg->cw_data;
> +		if (oob_buf)
> +			oob_buf +=3D ecc_cfg->bytes;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_spi_read_page_cache(struct qcom_nand_controller *snandc,
> +				    const struct spi_mem_op *op)
> +{
> +	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
> +	u8 *data_buf =3D NULL, *data_buf_start, *oob_buf =3D NULL, *oob_buf_sta=
rt;
> +	int ret, i;
> +	u32 cfg0, cfg1, ecc_bch_cfg, num_cw =3D snandc->qspi->num_cw;
> +
> +	if (snandc->qspi->page_rw) {
> +		data_buf =3D op->data.buf.in;
> +		data_buf_start =3D data_buf;
> +	}
> +
> +	if (snandc->qspi->oob_rw || snandc->qspi->raw_rw) {
> +		oob_buf =3D op->data.buf.in;
> +		oob_buf_start =3D oob_buf;
> +	}
> +
> +	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
> +		return qcom_spi_read_page_raw(snandc, op);
> +
> +	if (snandc->qspi->oob_rw && snandc->qspi->raw_rw && snandc->qspi->read_=
last_cw)
> +		return qcom_spi_read_last_cw(snandc, op);
> +
> +	snandc->buf_count =3D 0;
> +	snandc->buf_start =3D 0;
> +	qcom_clear_read_regs(snandc);
> +
> +	cfg0 =3D (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> +				(num_cw - 1) << CW_PER_PAGE;
> +	cfg1 =3D ecc_cfg->cfg1;
> +	ecc_bch_cfg =3D ecc_cfg->ecc_bch_cfg;
> +
> +	snandc->regs->addr0 =3D snandc->qspi->addr1;
> +	snandc->regs->addr1 =3D snandc->qspi->addr2;
> +	snandc->regs->cmd =3D snandc->qspi->cmd;
> +	snandc->regs->cfg0 =3D cfg0;
> +	snandc->regs->cfg1 =3D cfg1;
> +	snandc->regs->ecc_bch_cfg =3D ecc_bch_cfg;
> +	snandc->regs->clrflashstatus =3D ecc_cfg->clrflashstatus;
> +	snandc->regs->clrreadstatus =3D ecc_cfg->clrreadstatus;
> +	snandc->regs->exec =3D 1;
> +
> +	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
> +
> +	qcom_clear_bam_transaction(snandc);
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
> +			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
> +			   NAND_ERASED_CW_DETECT_CFG, 1,
> +			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
> +
> +	for (i =3D 0; i < num_cw; i++) {
> +		int data_size, oob_size;
> +
> +		if (i =3D=3D (num_cw - 1)) {
> +			data_size =3D 512 - ((num_cw - 1) << 2);
> +			oob_size =3D (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
> +				    ecc_cfg->spare_bytes;
> +		} else {
> +			data_size =3D ecc_cfg->cw_data;
> +			oob_size =3D ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
> +		}
> +
> +		if (data_buf && oob_buf) {
> +			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 0);
> +			qcom_spi_set_read_loc(snandc, i, 1, data_size, oob_size, 1);
> +		} else if (data_buf) {
> +			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 1);
> +		} else {
> +			qcom_spi_set_read_loc(snandc, i, 0, data_size, oob_size, 1);
> +		}
> +
> +		qcom_spi_config_cw_read(snandc, true, i);
> +
> +		if (data_buf)
> +			qcom_read_data_dma(snandc, FLASH_BUF_ACC, data_buf,
> +					   data_size, 0);
> +		if (oob_buf) {
> +			int j;
> +
> +			for (j =3D 0; j < ecc_cfg->bbm_size; j++)
> +				*oob_buf++ =3D 0xff;
> +
> +			qcom_read_data_dma(snandc, FLASH_BUF_ACC + data_size,
> +					   oob_buf, oob_size, 0);
> +		}
> +
> +		if (data_buf)
> +			data_buf +=3D data_size;
> +		if (oob_buf)
> +			oob_buf +=3D oob_size;
> +	}
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret) {
> +		dev_err(snandc->dev, "failure to read page\n");
> +		return ret;
> +	}
> +
> +	return qcom_spi_check_error(snandc, data_buf_start, oob_buf_start);
> +}
> +
> +static void qcom_spi_config_page_write(struct qcom_nand_controller *snan=
dc)
> +{
> +	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BU=
F_CFG,
> +			   1, NAND_BAM_NEXT_SGL);
> +}
> +
> +static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
> +{
> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_=
BAM_NEXT_SGL);
> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_=
BAM_NEXT_SGL);
> +	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +
> +	qcom_write_reg_dma(snandc, &snandc->regs->clrflashstatus, NAND_FLASH_ST=
ATUS, 1, 0);
> +	qcom_write_reg_dma(snandc, &snandc->regs->clrreadstatus, NAND_READ_STAT=
US, 1,
> +			   NAND_BAM_NEXT_SGL);
> +}
> +
> +static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
> +				const struct spi_mem_op *op)
> +{
> +	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
> +	u8 *data_buf =3D NULL, *oob_buf =3D NULL;
> +	int i, ret;
> +	int num_cw =3D snandc->qspi->num_cw;
> +	u32 cfg0, cfg1, ecc_bch_cfg;
> +
> +	cfg0 =3D (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> +			(num_cw - 1) << CW_PER_PAGE;
> +	cfg1 =3D ecc_cfg->cfg1_raw;
> +	ecc_bch_cfg =3D ECC_CFG_ECC_DISABLE;
> +
> +	data_buf =3D snandc->qspi->data_buf;
> +
> +	oob_buf =3D snandc->qspi->oob_buf;
> +	memset(oob_buf, 0xff, OOB_BUF_SIZE);
> +
> +	snandc->buf_count =3D 0;
> +	snandc->buf_start =3D 0;
> +	qcom_clear_read_regs(snandc);
> +	qcom_clear_bam_transaction(snandc);
> +
> +	snandc->regs->addr0 =3D snandc->qspi->addr1;
> +	snandc->regs->addr1 =3D snandc->qspi->addr2;
> +	snandc->regs->cmd =3D snandc->qspi->cmd;
> +	snandc->regs->cfg0 =3D cfg0;
> +	snandc->regs->cfg1 =3D cfg1;
> +	snandc->regs->ecc_bch_cfg =3D ecc_bch_cfg;
> +	snandc->regs->clrflashstatus =3D ecc_cfg->clrflashstatus;
> +	snandc->regs->clrreadstatus =3D ecc_cfg->clrreadstatus;
> +	snandc->regs->exec =3D 1;
> +
> +	qcom_spi_config_page_write(snandc);
> +
> +	for (i =3D 0; i < num_cw; i++) {
> +		int data_size1, data_size2, oob_size1, oob_size2;
> +		int reg_off =3D FLASH_BUF_ACC;
> +
> +		data_size1 =3D snandc->qspi->pagesize - ecc_cfg->cw_size * (num_cw - 1=
);
> +		oob_size1 =3D ecc_cfg->bbm_size;
> +
> +		if ((i =3D=3D (num_cw - 1))) {
> +			data_size2 =3D NANDC_STEP_SIZE - data_size1 -
> +				     ((num_cw - 1) << 2);
> +			oob_size2 =3D (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
> +				    ecc_cfg->spare_bytes;
> +		} else {
> +			data_size2 =3D ecc_cfg->cw_data - data_size1;
> +			oob_size2 =3D ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
> +		}
> +
> +		qcom_write_data_dma(snandc, reg_off, data_buf, data_size1,
> +				    NAND_BAM_NO_EOT);
> +		reg_off +=3D data_size1;
> +		data_buf +=3D data_size1;
> +
> +		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size1,
> +				    NAND_BAM_NO_EOT);
> +		oob_buf +=3D oob_size1;
> +		reg_off +=3D oob_size1;
> +
> +		qcom_write_data_dma(snandc, reg_off, data_buf, data_size2,
> +				    NAND_BAM_NO_EOT);
> +		reg_off +=3D data_size2;
> +		data_buf +=3D data_size2;
> +
> +		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size2, 0);
> +		oob_buf +=3D oob_size2;
> +
> +		qcom_spi_config_cw_write(snandc);
> +	}
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret) {
> +		dev_err(snandc->dev, "failure to write raw page\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_spi_program_execute(struct qcom_nand_controller *snandc,
> +				    const struct spi_mem_op *op)
> +{
> +	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
> +	u8 *data_buf =3D NULL, *oob_buf =3D NULL;
> +	int i, ret;
> +	int num_cw =3D snandc->qspi->num_cw;
> +	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
> +
> +	cfg0 =3D (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> +				(num_cw - 1) << CW_PER_PAGE;
> +	cfg1 =3D ecc_cfg->cfg1;
> +	ecc_bch_cfg =3D ecc_cfg->ecc_bch_cfg;
> +	ecc_buf_cfg =3D ecc_cfg->ecc_buf_cfg;
> +
> +	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
> +		return qcom_spi_program_raw(snandc, op);
> +
> +	if (snandc->qspi->data_buf)
> +		data_buf =3D snandc->qspi->data_buf;
> +
> +	if (snandc->qspi->oob_buf)
> +		oob_buf =3D snandc->qspi->oob_buf;
> +
> +	snandc->buf_count =3D 0;
> +	snandc->buf_start =3D 0;
> +	qcom_clear_read_regs(snandc);
> +	qcom_clear_bam_transaction(snandc);
> +
> +	snandc->regs->addr0 =3D snandc->qspi->addr1;
> +	snandc->regs->addr1 =3D snandc->qspi->addr2;
> +	snandc->regs->cmd =3D snandc->qspi->cmd;
> +	snandc->regs->cfg0 =3D cfg0;
> +	snandc->regs->cfg1 =3D cfg1;
> +	snandc->regs->ecc_bch_cfg =3D ecc_bch_cfg;
> +	snandc->regs->ecc_buf_cfg =3D ecc_buf_cfg;
> +	snandc->regs->exec =3D 1;
> +
> +	qcom_spi_config_page_write(snandc);
> +
> +	for (i =3D 0; i < num_cw; i++) {
> +		int data_size, oob_size;
> +
> +		if (i =3D=3D (num_cw - 1)) {
> +			data_size =3D NANDC_STEP_SIZE - ((num_cw - 1) << 2);
> +			oob_size =3D (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
> +				    ecc_cfg->spare_bytes;
> +		} else {
> +			data_size =3D ecc_cfg->cw_data;
> +			oob_size =3D ecc_cfg->bytes;
> +		}
> +
> +		if (data_buf)
> +			qcom_write_data_dma(snandc, FLASH_BUF_ACC, data_buf, data_size,
> +					    i =3D=3D (num_cw - 1) ? NAND_BAM_NO_EOT : 0);
> +
> +		if (i =3D=3D (num_cw - 1)) {
> +			if (oob_buf) {
> +				oob_buf +=3D ecc_cfg->bbm_size;
> +				qcom_write_data_dma(snandc, FLASH_BUF_ACC + data_size,
> +						    oob_buf, oob_size, 0);
> +			}
> +		}
> +
> +		qcom_spi_config_cw_write(snandc);
> +
> +		if (data_buf)
> +			data_buf +=3D data_size;
> +		if (oob_buf)
> +			oob_buf +=3D oob_size;
> +	}
> +
> +	ret =3D qcom_submit_descs(snandc);
> +	if (ret) {
> +		dev_err(snandc->dev, "failure to write page\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32=
 opcode)
> +{
> +	u32 cmd =3D 0x0;
> +
> +	switch (opcode) {
> +	case SPINAND_RESET:
> +		cmd =3D (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
> +		break;
> +	case SPINAND_READID:
> +		cmd =3D (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
> +		break;
> +	case SPINAND_GET_FEATURE:
> +		cmd =3D (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
> +		break;
> +	case SPINAND_SET_FEATURE:
> +		cmd =3D (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
> +			QPIC_SET_FEATURE);
> +		break;
> +	case SPINAND_READ:
> +		if (snandc->qspi->raw_rw) {
> +			cmd =3D (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
> +					SPI_WP | SPI_HOLD | OP_PAGE_READ);
> +		} else {
> +			cmd =3D (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
> +					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
> +		}
> +
> +		break;
> +	case SPINAND_ERASE:
> +		cmd =3D OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
> +			SPI_HOLD | SPI_TRANSFER_MODE_x1;
> +		break;
> +	case SPINAND_WRITE_EN:
> +		cmd =3D SPINAND_WRITE_EN;
> +		break;
> +	case SPINAND_PROGRAM_EXECUTE:
> +		cmd =3D (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
> +				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
> +		break;
> +	case SPINAND_PROGRAM_LOAD:
> +		cmd =3D SPINAND_PROGRAM_LOAD;
> +		break;
> +	default:
> +		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return cmd;
> +}
> +
> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
> +				     const struct spi_mem_op *op)
> +{
> +	struct qpic_snand_op s_op =3D {};
> +	u32 cmd;
> +
> +	cmd =3D qcom_spi_cmd_mapping(snandc, op->cmd.opcode);

I've asked for switch cases to return an error in case they could not
handle the request. If you don't check the returned values, it
does not make any sense.

> +	s_op.cmd_reg =3D cmd;
> +
> +	if (op->cmd.opcode =3D=3D SPINAND_PROGRAM_LOAD) {
> +		if (snandc->qspi->page_rw)
> +			snandc->qspi->data_buf =3D (u8 *)op->data.buf.out;

What you do here does not write anything in a page cache.

I also don't understand why you would have to check against the
SPINAND_PROGRAM_LOAD opcode.

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
> +		snandc->qspi->addr1 =3D s_op.addr1_reg;
> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> +		snandc->qspi->cmd =3D cmd;
> +		return qcom_spi_program_execute(snandc, op);
> +	case SPINAND_READ:
> +		s_op.addr1_reg =3D (op->addr.val << 16);
> +		s_op.addr2_reg =3D op->addr.val >> 16 & 0xff;
> +		snandc->qspi->addr1 =3D s_op.addr1_reg;
> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> +		snandc->qspi->cmd =3D cmd;
> +		return 0;
> +	case SPINAND_ERASE:
> +		s_op.addr2_reg =3D (op->addr.val >> 16) & 0xffff;
> +		s_op.addr1_reg =3D op->addr.val;
> +		snandc->qspi->addr1 =3D (s_op.addr1_reg << 16);
> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> +		snandc->qspi->cmd =3D cmd;
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

typo

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
> +	case SPINAND_RESET:
> +		return 0;
> +	case SPINAND_PROGRAM_EXECUTE:
> +		return 0;
> +	case SPINAND_WRITE_EN:
> +		return 0;
> +	case SPINAND_ERASE:
> +		return 0;
> +	case SPINAND_READ:
> +		return 0;

You can stack the cases

> +	default:
> +		return -EOPNOTSUPP;
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
> +	struct qpic_spi_nand *qspi;
> +	struct qpic_ecc *ecc;
> +	struct resource *res;
> +	const void *dev_data;
> +	int ret;
> +
> +	ecc =3D devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> +	if (!ecc)
> +		return -ENOMEM;
> +
> +	qspi =3D devm_kzalloc(dev, sizeof(*qspi), GFP_KERNEL);
> +	if (!qspi)
> +		return -ENOMEM;
> +
> +	ctlr =3D __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ctlr);
> +
> +	snandc =3D spi_controller_get_devdata(ctlr);
> +	qspi->snandc =3D snandc;
> +
> +	snandc->dev =3D dev;
> +	snandc->qspi =3D qspi;
> +	snandc->qspi->ctlr =3D ctlr;
> +	snandc->qspi->ecc =3D ecc;
> +
> +	snandc->qspi->oob_buf =3D devm_kzalloc(dev, OOB_BUF_SIZE, GFP_KERNEL);
> +	if (!snandc->qspi->oob_buf)
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
> +	snandc->qspi->iomacro_clk =3D devm_clk_get(dev, "iom");
> +	if (IS_ERR(snandc->qspi->iomacro_clk))
> +		return PTR_ERR(snandc->qspi->iomacro_clk);
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

Again, the label is better named when it describes what it point at,
rather than where it comes from.

> +
> +	ret =3D clk_prepare_enable(snandc->aon_clk);
> +	if (ret)
> +		goto err_aon_clk;
> +
> +	ret =3D clk_prepare_enable(snandc->qspi->iomacro_clk);
> +	if (ret)
> +		goto err_dis_iom_clk;
> +
> +	ret =3D qcom_nandc_alloc(snandc);
> +	if (ret)
> +		goto err_snand_alloc;
> +
> +	ret =3D qcom_spi_init(snandc);
> +	if (ret)
> +		goto err_init;
> +
> +	/* setup ECC engine */
> +	snandc->qspi->ecc_eng.dev =3D &pdev->dev;
> +	snandc->qspi->ecc_eng.integration =3D NAND_ECC_ENGINE_INTEGRATION_PIPEL=
INED;
> +	snandc->qspi->ecc_eng.ops =3D &qcom_spi_ecc_engine_ops_pipelined;
> +	snandc->qspi->ecc_eng.priv =3D snandc;
> +
> +	ret =3D nand_ecc_register_on_host_hw_engine(&snandc->qspi->ecc_eng);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register ecc engine:%d\n", ret);
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

Same: s/unalloc/free|cleanup/

> +err_snand_alloc:
> +	clk_disable_unprepare(snandc->qspi->iomacro_clk);
> +err_dis_iom_clk:
> +	clk_disable_unprepare(snandc->aon_clk);
> +err_aon_clk:
> +	clk_disable_unprepare(snandc->core_clk);
> +err_core_clk:
> +	dma_unmap_resource(dev, res->start, resource_size(res),
> +			   DMA_BIDIRECTIONAL, 0);
> +	return ret;
> +}

Thanks,
Miqu=C3=A8l

