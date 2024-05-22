Return-Path: <linux-spi+bounces-2995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3398CC14D
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBFF1C21E1F
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05FE81AD2;
	Wed, 22 May 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PQN0sewa"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B3130A53;
	Wed, 22 May 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381206; cv=none; b=QGq/t6ELQeQbomY8Wh888URtaXX5G4OwryqNB4BJw3Ts1x7CRicp04M+HXwOsILH2IEKDNxTEoSfxezrfVda2Ap8FwIPtFgiO3x/D+198sOTDdZVeefcJM6MhoRTGo9bOzt4Lz/ip5AHByc1y478Uv57f0Q+oKsJ0WnJpDzv76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381206; c=relaxed/simple;
	bh=EMhvfd4ILhEWsFWJgTd9LIrVGsi+7U3+WdORZpeDiew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc9pRCRFupZZi5kEzTwEcCVScVY8mQ4An0+gqkzV94s6GlaPjFNYoxQx2xBlOqS/lPpOWivTfURfqqfUmBSTPDT6wBPk/6JYwd6iwnIbERUGu8zzNo91LFb0ebMmn2SlxQLqYgOkmpbCIf1P9AYP0DfRbEVuCBMC4iwgUMGcA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PQN0sewa; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71DC41BF213;
	Wed, 22 May 2024 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716381200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4J4CYGBoBW9h9ZVxR2P3e6r3PhKjkKgpn0sAzWc+hM=;
	b=PQN0sewa7o74X7XHG9jJNLXCGqTq6dvbQnVsbAjK2VH9LBu8We3jOqSOl4lugWwnQ4EvZX
	7hfztpgkGJWuZhZM3LaH5cH+ajxvuom8/OtTzGK6HywyloiICj9JC3nveLDkIhNottyhL5
	Ot8dDhcA6u6nYPBuTGxv5AYKsKXOve/y5EmRIyXopeFGMixOaT8wGnvlWcbue0aDrB4X2I
	RviL4GzHh0Cd68a9dw+a9HMtVVG6HlBGRQvXFjYlWlOo7jv/sSNjbov8Gc+eYjOOyF6iRt
	54asP+RYiy/do2bPNZccGSMg1ERyGu+Jh58+lTyPtn1hwmmKKi/DfqIeGuJwMw==
Date: Wed, 22 May 2024 14:33:17 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <richard@nod.at>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
 <quic_varada@quicinc.com>
Subject: Re: [PATCH v6 6/8] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <20240522143317.07f78601@xps-13>
In-Reply-To: <5b96e24a-edcd-df85-9e70-332a6059ee73@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
	<20240521105532.1537845-7-quic_mdalam@quicinc.com>
	<20240521152410.7cff71ab@xps-13>
	<5b96e24a-edcd-df85-9e70-332a6059ee73@quicinc.com>
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

> >> +static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +				  struct mtd_oob_region *oobregion)
> >> +{
> >> +	struct nand_device *nand =3D mtd_to_nanddev(mtd);
> >> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> >> +	struct qpic_ecc *qecc =3D snandc->qspi->ecc;
> >> +
> >> +	if (section > 1)
> >> +		return -ERANGE;
> >> +
> >> +	if (!section) {
> >> +		oobregion->length =3D (qecc->bytes * (qecc->steps - 1)) + qecc->bbm=
_size;
> >> +		oobregion->offset =3D 0; =20
> >=20
> > No, offset 0 is for the BBM. This is wrong.
> > The whole oob layout looks really really wrong.
> >=20
> > ECC bytes are where the ECC engine puts its bytes in the OOB area.
> > Free bytes start after the BBM and fill the gaps until the end of the
> > area, except where there are ECC bytes. =20
>   QPIC NAND controller having its own page layout with ecc and without ec=
c.
>   The same layout we are using in raw nand driver as well, so i used the
>   same here. The below info is already there in qcom raw nand driver file
>   in page layout info.
>=20
>   QPIC NAND controller layout as below:
>=20
>    Layout with ECC enabled:
>=20
>      |----------------------|  |---------------------------------|
>      |           xx.......yy|  |             *********xx.......yy|
>      |    DATA   xx..ECC..yy|  |    DATA     **SPARE**xx..ECC..yy|
>      |   (516)   xx.......yy|  |  (516-n*4)  **(n*4)**xx.......yy|
>      |           xx.......yy|  |             *********xx.......yy|
>      |----------------------|  |---------------------------------|
>       codeword 1,2..n-1                  codeword n
>      <---(528/532 Bytes)-->    <-------(528/532 Bytes)--------->
>=20
>      n =3D Number of codewords in the page
>      . =3D ECC bytes
>      * =3D Spare/free bytes
>      x =3D Unused byte(s)
>      y =3D Reserved byte(s)
>=20
>      2K page: n =3D 4, spare =3D 16 bytes
>      4K page: n =3D 8, spare =3D 32 bytes
>      8K page: n =3D 16, spare =3D 64 bytes
>=20
>      the qcom nand controller operates at a sub page/codeword level. each
>      codeword is 528 and 532 bytes for 4 bit and 8 bit ECC modes respecti=
vely.
>      the number of ECC bytes vary based on the ECC strength and the bus w=
idth.
>=20
>      the first n - 1 codewords contains 516 bytes of user data, the remai=
ning
>      12/16 bytes consist of ECC and reserved data. The nth codeword conta=
ins
>      both user data and spare(oobavail) bytes that sum up to 516 bytes.
>=20
>      When we access a page with ECC enabled, the reserved bytes(s) are not
>      accessible at all. When reading, we fill up these unreadable positio=
ns
>      with 0xffs. When writing, the controller skips writing the inaccessi=
ble
>      bytes.
>=20
>      Layout with ECC disabled:
>=20
>      |------------------------------|  |---------------------------------=
------|
>      |         yy          xx.......|  |         bb          *********xx.=
......|
>      |  DATA1  yy  DATA2   xx..ECC..|  |  DATA1  bb  DATA2   **SPARE**xx.=
.ECC..|
>      | (size1) yy (size2)  xx.......|  | (size1) bb (size2)  **(n*4)**xx.=
......|
>      |         yy          xx.......|  |         bb          *********xx.=
......|
>      |------------------------------|  |---------------------------------=
------|
>           codeword 1,2..n-1                        codeword n
>      <-------(528/532 Bytes)------>    <-----------(528/532 Bytes)-------=
---->
>=20
>      n =3D Number of codewords in the page
>      . =3D ECC bytes
>      * =3D Spare/free bytes
>      x =3D Unused byte(s)
>      y =3D Dummy Bad Bock byte(s)
>      b =3D Real Bad Block byte(s)
>      size1/size2 =3D function of codeword size and 'n'
>=20
>      when the ECC block is disabled, one reserved byte (or two for 16 bit=
 bus
>      width) is now accessible. For the first n - 1 codewords, these are d=
ummy Bad
>      Block Markers. In the last codeword, this position contains the real=
 BBM
>=20
>      In order to have a consistent layout between RAW and ECC modes, we a=
ssume
>      the following OOB layout arrangement:
>=20
>      |-----------|  |--------------------|
>      |yyxx.......|  |bb*********xx.......|
>      |yyxx..ECC..|  |bb*FREEOOB*xx..ECC..|
>      |yyxx.......|  |bb*********xx.......|
>      |yyxx.......|  |bb*********xx.......|
>      |-----------|  |--------------------|
>      first n - 1       nth OOB region
>      OOB regions
>=20
>      n =3D Number of codewords in the page
>      . =3D ECC bytes
>      * =3D FREE OOB bytes
>      y =3D Dummy bad block byte(s) (inaccessible when ECC enabled)
>      x =3D Unused byte(s)
>      b =3D Real bad block byte(s) (inaccessible when ECC enabled)
>=20
>      This layout is read as is when ECC is disabled. When ECC is enabled,=
 the
>      inaccessible Bad Block byte(s) are ignored when we write to a page/o=
ob,
>      and assumed as 0xffs when we read a page/oob. The ECC, unused and
>      dummy/real bad block bytes are grouped as ecc bytes (i.e, ecc->bytes=
 is
>      the sum of the three).

Thanks for the detailed explanation (which would benefit from being
added somewhere in a comment, maybe at the top of the file).

Unfortunately, these ooblayout callbacks do work on a flat <data><oob>
layout, not on the hardware ECC engine layout. So whatever the real
physical position of the bad block marker within the NAND array, these
markers will always be at offset 0 and 1 in the OOB final buffer.

Same applies to the spare and ECC bytes. These layouts are totally
wrong and must be fixed. If the layouts are the same in both raw/spi
cases, maybe they should be part of the common file?

> >> +	} else {
> >> +		oobregion->length =3D qecc->ecc_bytes_hw + qecc->spare_bytes;
> >> +		oobregion->offset =3D mtd->oobsize - oobregion->length;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
> >> +				   struct mtd_oob_region *oobregion)
> >> +{
> >> +	struct nand_device *nand =3D mtd_to_nanddev(mtd);
> >> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> >> +	struct qpic_ecc *qecc =3D snandc->qspi->ecc;
> >> +
> >> +	if (section)
> >> +		return -ERANGE;
> >> +
> >> +	oobregion->length =3D qecc->steps * 4;
> >> +	oobregion->offset =3D ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_=
size;
> >> +
> >> +	return 0;
> >> +}
> >> + =20
> >=20
> > ...
> >  =20
> >> +static int qcom_spi_ecc_prepare_io_req_pipelined(struct nand_device *=
nand,
> >> +						 struct nand_page_io_req *req)
> >> +{
> >> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> >> +	struct qpic_ecc *ecc_cfg =3D nand_to_ecc_ctx(nand);
> >> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> >> +
> >> +	snandc->qspi->ecc =3D ecc_cfg;
> >> +	snandc->qspi->pagesize =3D mtd->writesize;
> >> +	snandc->qspi->raw_rw =3D false;
> >> +	snandc->qspi->oob_rw =3D false;
> >> +	snandc->qspi->page_rw =3D false;
> >> +
> >> +	if (req->datalen)
> >> +		snandc->qspi->page_rw =3D true;
> >> +
> >> +	if (req->ooblen) {
> >> +		snandc->qspi->oob_rw =3D true;
> >> +		if (req->ooblen =3D=3D BAD_BLOCK_MARKER_SIZE)
> >> +			snandc->qspi->read_last_cw =3D true; =20
> >=20
> > ??? =20
>    As per QPIC controller layout , the actual babd block marker will
>    be present in last code word. Thats why i have added this check.
>    to read only last codeword for bad block check.

You need to comply with the request. If ooblen is !=3D 0, you need to
read the codeword(s) where the oob is. Please don't try to be smarter
than that. Checking the _value_ of ooblen is an optimization I don't
think is worth.

> >  =20
> >> +	}
> >> +
> >> +	if (req->mode =3D=3D MTD_OPS_RAW)
> >> +		snandc->qspi->raw_rw =3D true;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *n=
and,
> >> +						struct nand_page_io_req *req)
> >> +{
> >> +	struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
> >> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> >> +
> >> +	if (req->mode =3D=3D MTD_OPS_RAW || req->type !=3D NAND_PAGE_READ)
> >> +		return 0;
> >> +
> >> +	if (snandc->qspi->ecc_stats.failed)
> >> +		mtd->ecc_stats.failed +=3D snandc->qspi->ecc_stats.failed;
> >> +	mtd->ecc_stats.corrected +=3D snandc->qspi->ecc_stats.corrected; =20
> >=20
> > Seems strange =20
>    In flash error check for each code word i am updating the error value.
>    So on finishing on io i am assigning that error to mtd variables so th=
at
>    upper layer check for error.

You don't clear the qspi ecc_stats so this cannot work properly.

Plus, I would welcome an else statement for incrementing the corrected
field.

> >  =20
> >> +
> >> +	if (snandc->qspi->ecc_stats.failed)
> >> +		return -EBADMSG;
> >> +	else
> >> +		return snandc->qspi->ecc_stats.bitflips;
> >> +}
> >> +
> >> +static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined =
=3D {
> >> +	.init_ctx =3D qcom_spi_ecc_init_ctx_pipelined,
> >> +	.cleanup_ctx =3D qcom_spi_ecc_cleanup_ctx_pipelined,
> >> +	.prepare_io_req =3D qcom_spi_ecc_prepare_io_req_pipelined,
> >> +	.finish_io_req =3D qcom_spi_ecc_finish_io_req_pipelined,
> >> +};
> >> + =20
> >=20
> > ...
> >  =20
> >> +static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,
> >> +				  const struct spi_mem_op *op)
> >> +{
> >> +	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
> >> +	u8 *data_buf =3D NULL, *oob_buf =3D NULL;
> >> +	int ret, cw;
> >> +	u32 num_cw =3D snandc->qspi->num_cw;
> >> +
> >> +	if (snandc->qspi->page_rw) =20
> >=20
> > I don't like this indirection very much. Can't you simplify this and
> > just follow the spi-mem op instead of constantly trying to add
> > additional stuff? =20
>    This indirection needed due to QPIC controller will not take all the i=
nstruction
>    one-by-one , once we will set CMD_EXEC =3D 1, then it will execute all=
 the instruction
>    at once.

The spi_mem_op structure already describes the whole operation. Why do
you split the operation in sub routines if you can't actually do that?

> >=20
> > The hardware is already quite complex, but it feels like your adding
> > yet another pile of unnecessary complexity. =20
>    Yes hardware is complex. let me check if i can further optimize as per=
 spi-mem op
>    as you suggested.
> >  =20
> >> +		data_buf =3D op->data.buf.in;
> >> +
> >> +	if (snandc->qspi->oob_rw)
> >> +		oob_buf =3D op->data.buf.in; =20

...

> >> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *sna=
ndc,
> >> +				     const struct spi_mem_op *op)
> >> +{
> >> +	struct qpic_snand_op s_op =3D {};
> >> +	u32 cmd;
> >> +
> >> +	cmd =3D qcom_spi_cmd_mapping(snandc, op->cmd.opcode); =20
> >=20
> > I've asked for switch cases to return an error in case they could not
> > handle the request. If you don't check the returned values, it
> > does not make any sense. =20
>   Ok, will fix in next patch.
> >  =20
> >> +	s_op.cmd_reg =3D cmd;
> >> +
> >> +	if (op->cmd.opcode =3D=3D SPINAND_PROGRAM_LOAD) {
> >> +		if (snandc->qspi->page_rw)
> >> +			snandc->qspi->data_buf =3D (u8 *)op->data.buf.out; =20
> >=20
> > What you do here does not write anything in a page cache. =20
>    No here just updating the buffer , actual write will happen in program=
_execute.
>    This is due to QPIC controller will not take all the instruction one-b=
y-one.
>    once we will set CMD_EXEC =3D 1, then it will execute all the instruct=
ion
>    at once. So accumulating all the instruction and then executing at onc=
e in
>    program_execute.
> >=20
> > I also don't understand why you would have to check against the
> > SPINAND_PROGRAM_LOAD opcode. =20
>    Because the actual write will happen in program_execute. and here
>    PROGRAM_EXECUTE command will also land, so that added the check.
> >  =20
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
> >> +				 const struct spi_mem_op *op)
> >> +{
> >> +	struct qpic_snand_op s_op =3D {};
> >> +	u32 cmd;
> >> +	int ret, opcode;
> >> +
> >> +	cmd =3D qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> >> +
> >> +	s_op.cmd_reg =3D cmd;
> >> +	s_op.addr1_reg =3D op->addr.val;
> >> +	s_op.addr2_reg =3D 0;
> >> +
> >> +	opcode =3D op->cmd.opcode;
> >> +
> >> +	switch (opcode) {
> >> +	case SPINAND_WRITE_EN:
> >> +		return 0;
> >> +	case SPINAND_PROGRAM_EXECUTE:
> >> +		s_op.addr1_reg =3D op->addr.val << 16;
> >> +		s_op.addr2_reg =3D op->addr.val >> 16 & 0xff;
> >> +		snandc->qspi->addr1 =3D s_op.addr1_reg;
> >> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> >> +		snandc->qspi->cmd =3D cmd;
> >> +		return qcom_spi_program_execute(snandc, op);
> >> +	case SPINAND_READ:
> >> +		s_op.addr1_reg =3D (op->addr.val << 16);
> >> +		s_op.addr2_reg =3D op->addr.val >> 16 & 0xff;
> >> +		snandc->qspi->addr1 =3D s_op.addr1_reg;
> >> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> >> +		snandc->qspi->cmd =3D cmd;
> >> +		return 0;
> >> +	case SPINAND_ERASE:
> >> +		s_op.addr2_reg =3D (op->addr.val >> 16) & 0xffff;
> >> +		s_op.addr1_reg =3D op->addr.val;
> >> +		snandc->qspi->addr1 =3D (s_op.addr1_reg << 16);
> >> +		snandc->qspi->addr2 =3D s_op.addr2_reg;
> >> +		snandc->qspi->cmd =3D cmd;
> >> +		qcom_spi_block_erase(snandc);
> >> +		return 0;
> >> +	default:
> >> +		break;
> >> +	}
> >> +
> >> +	snandc->buf_count =3D 0;
> >> +	snandc->buf_start =3D 0;
> >> +	qcom_clear_read_regs(snandc);
> >> +	qcom_clear_bam_transaction(snandc);
> >> +
> >> +	snandc->regs->cmd =3D s_op.cmd_reg;
> >> +	snandc->regs->exec =3D 1;
> >> +	snandc->regs->addr0 =3D s_op.addr1_reg;
> >> +	snandc->regs->addr1 =3D s_op.addr2_reg;
> >> +
> >> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NA=
ND_BAM_NEXT_SGL);
> >> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NA=
ND_BAM_NEXT_SGL);
> >> +
> >> +	ret =3D qcom_submit_descs(snandc);

And you really don't want to check the validity of the opcode with what
you support before submitting the descriptors?

> >> +	if (ret)
> >> +		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n"); =20
> >=20
> > typo =20
>   Ok , will fix in next patch.
> >  =20
> >> +
> >> +	return ret;
> >> +}
> >> +
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
> >> +	case SPINAND_RESET:
> >> +		return 0;
> >> +	case SPINAND_PROGRAM_EXECUTE:
> >> +		return 0;
> >> +	case SPINAND_WRITE_EN:
> >> +		return 0;
> >> +	case SPINAND_ERASE:
> >> +		return 0;
> >> +	case SPINAND_READ:
> >> +		return 0; =20
> >=20
> > You can stack the cases =20
> Ok
> >  =20
> >> +	default:
> >> +		return -EOPNOTSUPP;
> >> +	}
> >> +
> >> +	ret =3D qcom_submit_descs(snandc);
> >> +	if (ret)
> >> +		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", o=
pcode);
> >> +
> >> +	if (copy) {
> >> +		qcom_nandc_dev_to_mem(snandc, true);
> >> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
> >> +	}
> >> +
> >> +	if (copy_ftr) {
> >> +		qcom_nandc_dev_to_mem(snandc, true);
> >> +		val =3D le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
> >> +		val >>=3D 8;
> >> +		memcpy(op->data.buf.in, &val, snandc->buf_count);
> >> +	}
> >> +
> >> +	return ret;
> >> +}

Thanks,
Miqu=C3=A8l

