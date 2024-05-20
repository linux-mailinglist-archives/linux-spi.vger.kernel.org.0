Return-Path: <linux-spi+bounces-2957-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190768C9D9F
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD41C241CD
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9355E6B;
	Mon, 20 May 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y5RCrHfE"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA350275;
	Mon, 20 May 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209022; cv=none; b=n8MW+8Ygs+cjsVwRO3Pmpkl7y0o3pIdl2NXvQOlVTuxyCDsA0+v7vb8KqTosEznLmYRgFj+4+x4Wa09o2Jzj7EvG/09YL0VLJ1wuZDmR1R4oFVUgYMK5/8uC9oKxJ+oRFOQrXx9LAn0/JTwfQrvYuuDpBvateIAUMLFMXOtD9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209022; c=relaxed/simple;
	bh=xN6NLJLMQbPFOVmGkO2AhqBxqsJOhKBpovNMWJiLCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQIcm8dI9TMvr1mEGldd+GyjePLPRqfei41zuAZYl0A9jXeNIw6KifGZY684KPMlWTNmSbWv0y1tYipCZ47kHpIOAOB5p0TFtabdW/k1oS4qSTKJzjY6i2MP1OEBNr9U4vnFDNWIZ3Us2Iuh+sQP5EI591APLEvBklIYo6gdqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y5RCrHfE; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 031BD40003;
	Mon, 20 May 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716209017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/bZqhMhLpFnI8MSy/Le7u2at2ACghAX1DiKyzwBhx8=;
	b=Y5RCrHfEI9cp4Rpl09xzDfPx1BWhLVhhOLEHYb9opBCpXwTY1wA5YxT1DhMtxvkIF0z72P
	sndEaNXUhO6IWJKkXjVfarump5Qgmku1xG1cfRL4aeyW+XeiSW7mXqIsQ3H/dMTJNP6i9i
	s6jjZqgodugbXGRncI0V7qGyQNohiLEuZjEBKjHgjuwRTlmAR8byVTLlFTjfQSwL7D7GaC
	VrUdT0F9boligLRphJRAvWpjC8TeuDKcXpD1TO2Gn44cSajLA55V/NnkDTDxBGJtsiafks
	yjx02pqWu8EuaTDIscuobgmBOeRbhNIAfBszQDWIOCFv1BzwkqcsZZ0q4tbBKA==
Date: Mon, 20 May 2024 14:43:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <richard@nod.at>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
 <quic_varada@quicinc.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v5 5/7] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <20240520144334.79c754e3@xps-13>
In-Reply-To: <434590e3-9298-dde9-f527-6596dbd1952b@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
	<20240508083637.3744003-6-quic_mdalam@quicinc.com>
	<20240516145642.644a7f1c@xps-13>
	<434590e3-9298-dde9-f527-6596dbd1952b@quicinc.com>
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

> >> +static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const =
struct spi_mem_op *op)
> >> +{
> >> +	int ret, val, opcode;
> >> +	bool copy =3D false, copy_ftr =3D false;
> >> +
> >> +	ret =3D qcom_spi_send_cmdaddr(snandc, op);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	snandc->buf_count =3D 0;
> >> +	snandc->buf_start =3D 0;
> >> +	qcom_clear_read_regs(snandc);
> >> +	qcom_clear_bam_transaction(snandc);
> >> +	opcode =3D op->cmd.opcode;
> >> +
> >> +	switch (opcode) {
> >> +	case SPINAND_READID:
> >> +		snandc->buf_count =3D 4;
> >> +		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> >> +		copy =3D true;
> >> +		break;
> >> +	case SPINAND_GET_FEATURE:
> >> +		snandc->buf_count =3D 4;
> >> +		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL=
);
> >> +		copy_ftr =3D true;
> >> +		break;
> >> +	case SPINAND_SET_FEATURE:
> >> +		snandc->regs->flash_feature =3D *(u32 *)op->data.buf.out;
> >> +		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
> >> +				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
> >> +		break;
> >> +	default:
> >> +		return 0; =20
> >=20
> > No error state? =20
>    We can't return return error here , since this API is not for checking=
 supported command.

I no longer remember exactly where this is called, but if there are
possible unhandled cases, I want an error to be returned.

>    We can return error only if we submitted the descriptor. That already =
we are handling.

...

> >> --- a/include/linux/mtd/nand-qpic-common.h
> >> +++ b/include/linux/mtd/nand-qpic-common.h
> >> @@ -315,11 +315,56 @@ struct nandc_regs {
> >>   	__le32 read_location_last1;
> >>   	__le32 read_location_last2;
> >>   	__le32 read_location_last3;
> >> +	__le32 spi_cfg;
> >> +	__le32 num_addr_cycle;
> >> +	__le32 busy_wait_cnt;
> >> +	__le32 flash_feature; =20
> >>   >>   	__le32 erased_cw_detect_cfg_clr; =20
> >>   	__le32 erased_cw_detect_cfg_set;
> >>   }; =20
> >>   >> +/* =20
> >> + * ECC state struct
> >> + * @corrected:		ECC corrected
> >> + * @bitflips:		Max bit flip
> >> + * @failed:		ECC failed
> >> + */
> >> +struct qcom_ecc_stats {
> >> +	u32 corrected;
> >> +	u32 bitflips;
> >> +	u32 failed;
> >> +};
> >> +
> >> +struct qpic_ecc {
> >> +	struct device *dev;
> >> +	const struct qpic_ecc_caps *caps;
> >> +	struct completion done;
> >> +	u32 sectors;
> >> +	u8 *eccdata;
> >> +	bool use_ecc;
> >> +	u32 ecc_modes;
> >> +	int ecc_bytes_hw;
> >> +	int spare_bytes;
> >> +	int bbm_size;
> >> +	int ecc_mode;
> >> +	int bytes;
> >> +	int steps;
> >> +	int step_size;
> >> +	int strength;
> >> +	int cw_size;
> >> +	int cw_data;
> >> +	u32 cfg0, cfg1;
> >> +	u32 cfg0_raw, cfg1_raw;
> >> +	u32 ecc_buf_cfg;
> >> +	u32 ecc_bch_cfg;
> >> +	u32 clrflashstatus;
> >> +	u32 clrreadstatus;
> >> +	bool bch_enabled;
> >> +};
> >> +
> >> +struct qpic_ecc;
> >> +
> >>   /*
> >>    * NAND controller data struct
> >>    *
> >> @@ -329,6 +374,7 @@ struct nandc_regs {
> >>    *
> >>    * @core_clk:			controller clock
> >>    * @aon_clk:			another controller clock
> >> + * @iomacro_clk:		io macro clock
> >>    *
> >>    * @regs:			a contiguous chunk of memory for DMA register
> >>    *				writes. contains the register values to be
> >> @@ -338,6 +384,7 @@ struct nandc_regs {
> >>    *				initialized via DT match data
> >>    *
> >>    * @controller:			base controller structure
> >> + * @ctlr:			spi controller structure
> >>    * @host_list:			list containing all the chips attached to the
> >>    *				controller
> >>    *
> >> @@ -375,6 +422,7 @@ struct qcom_nand_controller { =20
> >>   >>   	struct clk *core_clk; =20
> >>   	struct clk *aon_clk;
> >> +	struct clk *iomacro_clk; =20
> >>   >>   	struct nandc_regs *regs; =20
> >>   	struct bam_transaction *bam_txn;
> >> @@ -382,6 +430,7 @@ struct qcom_nand_controller {
> >>   	const struct qcom_nandc_props *props; =20
> >>   >>   	struct nand_controller controller; =20
> >> +	struct spi_controller *ctlr;
> >>   	struct list_head host_list; =20
> >>   >>   	union { =20
> >> @@ -418,6 +467,21 @@ struct qcom_nand_controller { =20
> >>   >>   	u32 cmd1, vld; =20
> >>   	bool exec_opwrite;
> >> +	struct qpic_ecc *ecc;
> >> +	struct qcom_ecc_stats ecc_stats;
> >> +	struct nand_ecc_engine ecc_eng;
> >> +	u8 *data_buf;
> >> +	u8 *oob_buf;
> >> +	u32 wlen;
> >> +	u32 addr1;
> >> +	u32 addr2;
> >> +	u32 cmd;
> >> +	u32 num_cw;
> >> +	u32 pagesize;
> >> +	bool oob_rw;
> >> +	bool page_rw;
> >> +	bool raw_rw;
> >> +	bool read_last_cw;
> >>   }; =20
> >=20
> > If all these definitions are only used by the spi controller, I don't
> > see why you want to put them in the common file. =20
>   We are using qcom_nand_controller{..} structure as common b/w raw nand
>   and spi nand. These all variables will be used by spi nand only , but
>   qcom_nand_controller structure is passed across all the SPI API, thats
>   why define these all variables inside qcom_nand_controller structure.
>   so that i can access directlty.

Maybe you can move the spi-nand specific variables in a struct, and the
raw NAND specific variables in another, and then use an enum in this
structure. This way only the useful fields are available. Or maybe you
can have two pointers and only populate the relevant one from the
relevant driver with the fields that are missing. But this is a generic
include, so don't put specific fields there just because it is
convenient.

Thanks,
Miqu=C3=A8l

