Return-Path: <linux-spi+bounces-5679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 214799C4564
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA65EB216F3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF811AAE3A;
	Mon, 11 Nov 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNVHac76"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D331AA1FC;
	Mon, 11 Nov 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350438; cv=none; b=kO78CdTKBHc3kM8uiYJE+yfsW4Bpr0/ElI7CAN/9ih9xwdCazheUT2X3DSd4tdsTIGbJopbVZG4VPP/Wh+TPMEbc+fOLXbWiQ3FU6S7+xAmFwjuSQ0JpgTEJt8BwkJeqROKHco3SxiG90xZW+BGCARAi2U4ioEk6TJLBqTjo3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350438; c=relaxed/simple;
	bh=argA4IC79naaCW47Uh8xkDludQqNJZaYMhWC4/ygvdI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:Message-ID:
	 MIME-Version:Content-Type; b=XYCGKHBOgOvR9+puGLGptQGmwHnmQ2ifkreQcLyG964+X4NW+wWVTkArrX6WFH90SYj6nsYuaz6lsFvFKArFyildkwDH2l7qe/Zo/873lgkl52bi+yfDepIoOF7EtqbQO9/omWRDxNM+cHebghBLVI99+NSzex+3L6op2FCvdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNVHac76; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 731E31C0002;
	Mon, 11 Nov 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731350434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbEusmclcP4bjdhemPuToxgTwCMcNFpEROLUhTJ3RqM=;
	b=iNVHac76RZ+QVrideqhJUALHc6nT2/gP3XxvPndIkdh4LYXxYBvL7VEcxjOLhQp++J6TQi
	wVmVTOinL0TVTwOow2oiiogXhcnnr69Y/Qqz1kA9uZy14r18NRuTraSw52JdnAkxdi24jV
	UaXPG5JueeNpg7YpJoDB5D9NiBVZKXtHw1Y1kqrLwn1lhoF+0T6y2+rAvI5+sC6YD21T0X
	2fKuHfjZ+/OWCgAi/MyDdcoQat8edb5Sp16dHSncdo12nQMEiS9Kuv1xhdy5anVCmtwwAC
	hp9EHHE45GSCy+9JtXV3yNurkz/Z2Lx32kLAIaBGSWOWa8TWOGOq9yZunzaHag==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <andersson@kernel.org>,
  <konradybcio@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <manivannan.sadhasivam@linaro.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <quic_srichara@quicinc.com>,  <quic_varada@quicinc.com>
Subject: Re: [PATCH v13 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
In-Reply-To: <20241030121919.865716-3-quic_mdalam@quicinc.com> (Md Sadre
	Alam's message of "Wed, 30 Oct 2024 17:49:13 +0530")
Date: Mon, 11 Nov 2024 19:30:57 +0100
References: <20241030121919.865716-1-quic_mdalam@quicinc.com>
	<20241030121919.865716-3-quic_mdalam@quicinc.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Message-ID: <871pzh397j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 30/10/2024 at 17:49:13 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wr=
ote:

> cleanup qcom_nandc driver as below

Perform a global cleanup of the Qualcomm NAND controller driver with the
following improvements:
>
> - Remove register value indirection api

API

>
> - Remove set_reg() api

API

>
> - Convert read_loc_first & read_loc_last macro to function

functions

>
> - Renamed multiple variables

Rename

...

> @@ -549,17 +535,17 @@ struct qcom_nand_host {
>   * among different NAND controllers.
>   * @ecc_modes - ecc mode for NAND
>   * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
> - * @is_bam - whether NAND controller is using BAM
> - * @is_qpic - whether NAND CTRL is part of qpic IP
> - * @qpic_v2 - flag to indicate QPIC IP version 2
> + * @supports_bam - whether NAND controller is using BAM

Use the plain letters BAM acronym at least here

> + * @nandc_part_of_qpic - whether NAND controller is part of qpic IP
> + * @qpic_version2 - flag to indicate QPIC IP version 2
>   * @use_codeword_fixup - whether NAND has different layout for boot part=
itions
>   */
>  struct qcom_nandc_props {
>  	u32 ecc_modes;
>  	u32 dev_cmd_reg_start;
> -	bool is_bam;
> -	bool is_qpic;
> -	bool qpic_v2;
> +	bool supports_bam;
> +	bool nandc_part_of_qpic;
> +	bool qpic_version2;
>  	bool use_codeword_fixup;
>  };
>=20=20
> @@ -613,19 +599,11 @@ static void clear_bam_transaction(struct qcom_nand_=
controller *nandc)
>  {
>  	struct bam_transaction *bam_txn =3D nandc->bam_txn;
>=20=20
> -	if (!nandc->props->is_bam)
> +	if (!nandc->props->supports_bam)
>  		return;
>=20=20
> -	bam_txn->bam_ce_pos =3D 0;
> -	bam_txn->bam_ce_start =3D 0;
> -	bam_txn->cmd_sgl_pos =3D 0;
> -	bam_txn->cmd_sgl_start =3D 0;
> -	bam_txn->tx_sgl_pos =3D 0;
> -	bam_txn->tx_sgl_start =3D 0;
> -	bam_txn->rx_sgl_pos =3D 0;
> -	bam_txn->rx_sgl_start =3D 0;
> +	memset(&bam_txn->bam_ce_pos, 0, sizeof(u32) * 8);
>  	bam_txn->last_data_desc =3D NULL;
> -	bam_txn->wait_second_completion =3D false;
>=20=20
>  	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
>  		      QPIC_PER_CW_CMD_SGL);
> @@ -640,17 +618,7 @@ static void qpic_bam_dma_done(void *data)
>  {
>  	struct bam_transaction *bam_txn =3D data;
>=20=20
> -	/*
> -	 * In case of data transfer with NAND, 2 callbacks will be generated.
> -	 * One for command channel and another one for data channel.
> -	 * If current transaction has data descriptors
> -	 * (i.e. wait_second_completion is true), then set this to false
> -	 * and wait for second DMA descriptor completion.
> -	 */
> -	if (bam_txn->wait_second_completion)
> -		bam_txn->wait_second_completion =3D false;
> -	else
> -		complete(&bam_txn->txn_done);
> +	complete(&bam_txn->txn_done);
>  }
>=20=20
>  static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip =
*chip)
> @@ -676,10 +644,9 @@ static inline void nandc_write(struct qcom_nand_cont=
roller *nandc, int offset,
>  	iowrite32(val, nandc->base + offset);
>  }
>=20=20
> -static inline void nandc_read_buffer_sync(struct qcom_nand_controller *n=
andc,
> -					  bool is_cpu)
> +static inline void nandc_dev_to_mem(struct qcom_nand_controller *nandc, =
bool is_cpu)

No static inline in C code, you can also remove it.

>  {
> -	if (!nandc->props->is_bam)
> +	if (!nandc->props->supports_bam)
>  		return;
>=20=20
>  	if (is_cpu)
> @@ -694,93 +661,90 @@ static inline void nandc_read_buffer_sync(struct qc=
om_nand_controller *nandc,
>  					   DMA_FROM_DEVICE);
>  }

...

> +/* Helper to check the code word, whether it is last cw or not */

Helper to check whether this is the last CW or not


> +static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
> +{
> +	return cw =3D=3D (ecc->steps - 1);
>  }
>=20=20
> -static void nandc_set_reg(struct nand_chip *chip, int offset,
> -			  u32 val)
> +/**
> + * nandc_set_read_loc_first() - to set read location first register
> + * @chip:		NAND Private Flash Chip Data
> + * @reg_base:		location register base
> + * @cw_offset:		code word offset
> + * @read_size:		code word read length
> + * @is_last_read_loc:	is this the last read location
> + *
> + * This function will set location register value
> + */

...

>  	if (host->use_ecc) {
> -		cfg0 =3D (host->cfg0 & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +		cfg0 =3D cpu_to_le32((host->cfg0 & ~(7U << CW_PER_PAGE)) |
> +				(num_cw - 1) << CW_PER_PAGE);
>=20=20
> -		cfg1 =3D host->cfg1;
> -		ecc_bch_cfg =3D host->ecc_bch_cfg;
> +		cfg1 =3D cpu_to_le32(host->cfg1);
> +		ecc_bch_cfg =3D cpu_to_le32(host->ecc_bch_cfg);
>  	} else {
> -		cfg0 =3D (host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +		cfg0 =3D cpu_to_le32((host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> +				(num_cw - 1) << CW_PER_PAGE);
>=20=20
> -		cfg1 =3D host->cfg1_raw;
> -		ecc_bch_cfg =3D 1 << ECC_CFG_ECC_DISABLE;
> +		cfg1 =3D cpu_to_le32(host->cfg1_raw);
> +		ecc_bch_cfg =3D cpu_to_le32(1 << ECC_CFG_ECC_DISABLE);
>  	}
>=20=20
> -	nandc_set_reg(chip, NAND_FLASH_CMD, cmd);
> -	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
> -	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
> -	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
> -	if (!nandc->props->qpic_v2)
> -		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> -	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
> -	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
> -	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +	nandc->regs->cmd =3D cmd;
> +	nandc->regs->cfg0 =3D cfg0;
> +	nandc->regs->cfg1 =3D cfg1;
> +	nandc->regs->ecc_bch_cfg =3D ecc_bch_cfg;
> +
> +	if (!nandc->props->qpic_version2)
> +		nandc->regs->ecc_buf_cfg =3D cpu_to_le32(host->ecc_buf_cfg);
> +
> +	nandc->regs->clrflashstatus =3D cpu_to_le32(host->clrflashstatus);
> +	nandc->regs->clrreadstatus =3D cpu_to_le32(host->clrreadstatus);
> +	nandc->regs->exec =3D cpu_to_le32(1);
>=20=20
>  	if (read)
>  		nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
> @@ -1121,7 +1088,7 @@ static int read_reg_dma(struct qcom_nand_controller=
 *nandc, int first,
>  	if (first =3D=3D NAND_DEV_CMD_VLD || first =3D=3D NAND_DEV_CMD1)
>  		first =3D dev_cmd_reg_addr(nandc, first);
>=20=20
> -	if (nandc->props->is_bam)
> +	if (nandc->props->supports_bam)
>  		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
>  					     num_regs, flags);
>=20=20
> @@ -1136,25 +1103,16 @@ static int read_reg_dma(struct qcom_nand_controll=
er *nandc, int first,
>   * write_reg_dma:	prepares a descriptor to write a given number of
>   *			contiguous registers
>   *
> + * @vaddr:		contnigeous memory from where register value
> will

Please run a spell checker on your commits.

> + *			be written
>   * @first:		offset of the first register in the contiguous block
>   * @num_regs:		number of registers to write
>   * @flags:		flags to control DMA descriptor preparation
>   */
> -static int write_reg_dma(struct qcom_nand_controller *nandc, int first,
> -			 int num_regs, unsigned int flags)
> +static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vad=
dr,
> +			 int first, int num_regs, unsigned int flags)
>  {
>  	bool flow_control =3D false;
> -	struct nandc_regs *regs =3D nandc->regs;
> -	void *vaddr;
> -
> -	vaddr =3D offset_to_nandc_reg(regs, first);
> -
> -	if (first =3D=3D NAND_ERASED_CW_DETECT_CFG) {
> -		if (flags & NAND_ERASED_CW_SET)
> -			vaddr =3D &regs->erased_cw_detect_cfg_set;
> -		else
> -			vaddr =3D &regs->erased_cw_detect_cfg_clr;
> -	}
>=20=20
>  	if (first =3D=3D NAND_EXEC_CMD)
>  		flags |=3D NAND_BAM_NWD;
> @@ -1165,7 +1123,7 @@ static int write_reg_dma(struct qcom_nand_controlle=
r *nandc, int first,
>  	if (first =3D=3D NAND_DEV_CMD_VLD_RESTORE || first =3D=3D NAND_DEV_CMD_=
VLD)
>  		first =3D dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
>=20=20
> -	if (nandc->props->is_bam)
> +	if (nandc->props->supports_bam)
>  		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
>  					     num_regs, flags);
>=20=20

...

> @@ -2872,38 +2823,38 @@ static int qcom_param_page_type_exec(struct nand_=
chip *chip,  const struct nand_
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
>=20=20
> -	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> -
> -	nandc_set_reg(chip, NAND_ADDR0, 0);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
> -	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
> -					| 512 << UD_SIZE_BYTES
> -					| 5 << NUM_ADDR_CYCLES
> -					| 0 << SPARE_SIZE_BYTES);
> -	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
> -					| 0 << CS_ACTIVE_BSY
> -					| 17 << BAD_BLOCK_BYTE_NUM
> -					| 1 << BAD_BLOCK_IN_SPARE_AREA
> -					| 2 << WR_RD_BSY_GAP
> -					| 0 << WIDE_FLASH
> -					| 1 << DEV0_CFG1_ECC_DISABLE);

Please fix the coding style. The '|' should be at the end of the line.

Thanks,
Miqu=C3=A8l

