Return-Path: <linux-spi+bounces-9634-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802CB3295D
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27E77AF8B1
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC1190472;
	Sat, 23 Aug 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBgy0cNd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD1264614;
	Sat, 23 Aug 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960165; cv=none; b=RH9c418Th0FFNwG0YKXw3ku2/Dibxs/CLT8WQ6ftyT3025B2NW3aBKwML476Birsgm+N2NMTKa+zTO21cR9szBV17JaQc5CATMA39Zp2pXKi9eLBerX23CJzmnRbF1w6EJGqlX70/q60tqS6ssTGgV6aS99zp1Mj5ENhI/6trhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960165; c=relaxed/simple;
	bh=z7ApHOWPs6UIakCI3RaTZXmAyFE6OH6UhPbV+KeOM7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+CGwg9zPauj+Cb1ALqPVrp7LSe7tXIIsq411bNNqrEmbv4HdSFwHllwN9myLE8zxk22wSdMoxCOn31MwV/FEtXLcJD4YPlXYc99e98EdqRGuxhiSN0uyBLz+cUB335ktoi+jp14u5TxbHEQcXO1ciMTqcYehwUx9dkJG3K7rDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBgy0cNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32572C4CEE7;
	Sat, 23 Aug 2025 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755960164;
	bh=z7ApHOWPs6UIakCI3RaTZXmAyFE6OH6UhPbV+KeOM7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBgy0cNdc34iJlNsbMepjFb5z58s7yJRiVrdERfLsDg5SRsxGjpRxetzD3JUDWlI3
	 aOQWD7/QoV7cxhMkg3p+nUkr2zsgsSMcrr6qZfXbStNryjYShPRo6UlnGdWLVvzd4q
	 BBIIabMm1xprDDpTCvAuo9KRh4VhifV1/iV95cjn/hXmCLyevz4pgzb8gUmNYLwvVB
	 bmgT2S/UdShVGOXePXv6Gqs1g2qr1EFL5dIWiYX/FJlbdVLGgKSAyHNCBoSTJKg3S8
	 6GI75t8+3EDMNqzHPWb4TlrjASSmJNsdyY4r6RrhdngTw8NKndxdk8wDXAoREetjnW
	 DwtK8rYfEtshQ==
Date: Sat, 23 Aug 2025 16:42:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/13] spi: airoha: add support of dual/quad wires spi
 modes
Message-ID: <aKnTYNsaBIkh6OBS@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-4-mikhail.kshevetskiy@iopsys.eu>
 <aKl43hTJJVqRE3Rt@lore-rh-laptop>
 <68130d82-edbe-4e23-9538-733f9c52123c@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gHh2E/ssa1RMJrZx"
Content-Disposition: inline
In-Reply-To: <68130d82-edbe-4e23-9538-733f9c52123c@iopsys.eu>


--gHh2E/ssa1RMJrZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 23.08.2025 11:16, Lorenzo Bianconi wrote:
> > [...]
> >> -static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,=
 u8 cmd,
> >> -				   const u8 *data, int len)
> >> +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
> >> +				   const u8 *data, int len, int buswidth)
> >>  {
> >>  	int i, data_len;
> >> +	u8 cmd;
> >> +
> >> +	switch (buswidth) {
> >> +	case 0:
> >> +	case 1:
> >> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_SINGLE;
> >> +		break;
> >> +	case 2:
> >> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_DUAL;
> >> +		break;
> >> +	case 4:
> >> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_QUAD;
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> > Since this is used in airoha_snand_write_data() and in airoha_snand_rea=
d_data()
> > I guess you can define a routine for it.
>=20
> It's not the same. It looks similar, but different constants are used
> for rx and tx cases.

ops, I missed TX vs RX.

Regards,
Lorenzo

>=20
> >
> >> =20
> >>  	for (i =3D 0; i < len; i +=3D data_len) {
> >>  		int err;
> >> @@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha=
_snand_ctrl *as_ctrl, u8 cmd,
> >>  	return 0;
> >>  }
> >> =20
> >> -static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, =
u8 *data,
> >> -				  int len)
> >> +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
> >> +				  u8 *data, int len, int buswidth)
> >>  {
> >>  	int i, data_len;
> >> +	u8 cmd;
> >> +
> >> +	switch (buswidth) {
> >> +	case 0:
> >> +	case 1:
> >> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_SINGLE;
> >> +		break;
> >> +	case 2:
> >> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_DUAL;
> >> +		break;
> >> +	case 4:
> >> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_QUAD;
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> =20
> >>  	for (i =3D 0; i < len; i +=3D data_len) {
> >>  		int err;
> >> =20
> >>  		data_len =3D min(len - i, SPI_MAX_TRANSFER_SIZE);
> >> -		err =3D airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
> >> +		err =3D airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
> >>  		if (err)
> >>  			return err;
> >> =20
> >> @@ -895,12 +935,27 @@ static ssize_t airoha_snand_dirmap_write(struct =
spi_mem_dirmap_desc *desc,
> >>  static int airoha_snand_exec_op(struct spi_mem *mem,
> >>  				const struct spi_mem_op *op)
> >>  {
> >> -	u8 data[8], cmd, opcode =3D op->cmd.opcode;
> >>  	struct airoha_snand_ctrl *as_ctrl;
> >> -	int i, err;
> >> +	char buf[20], *data;
> >> +	int i, err, op_len, addr_len, dummy_len;
> > nit: can you please respect the 'reverse christmas tree' here?
> will fix
> >
> >> =20
> >>  	as_ctrl =3D spi_controller_get_devdata(mem->spi->controller);
> >> =20
> >> +	op_len =3D op->cmd.nbytes;
> >> +	addr_len =3D op->addr.nbytes;
> >> +	dummy_len =3D op->dummy.nbytes;
> >> +
> >> +	if (op_len + dummy_len + addr_len > sizeof(buf))
> >> +		return -EIO;
> >> +
> >> +	data =3D buf;
> >> +	for (i =3D 0; i < op_len; i++)
> >> +		*data++ =3D op->cmd.opcode >> (8 * (op_len - i - 1));
> >> +	for (i =3D 0; i < addr_len; i++)
> >> +		*data++ =3D op->addr.val >> (8 * (addr_len - i - 1));
> >> +	for (i =3D 0; i < dummy_len; i++)
> >> +		*data++ =3D 0xff;
> >> +
> >>  	/* switch to manual mode */
> >>  	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
> >>  	if (err < 0)
> >> @@ -911,40 +966,40 @@ static int airoha_snand_exec_op(struct spi_mem *=
mem,
> >>  		return err;
> >> =20
> >>  	/* opcode */
> >> -	err =3D airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode=
));
> >> +	data =3D buf;
> >> +	err =3D airoha_snand_write_data(as_ctrl, data, op_len,
> >> +				      op->cmd.buswidth);
> >>  	if (err)
> >>  		return err;
> >> =20
> >>  	/* addr part */
> >> -	cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> >> -	put_unaligned_be64(op->addr.val, data);
> >> -
> >> -	for (i =3D ARRAY_SIZE(data) - op->addr.nbytes;
> >> -	     i < ARRAY_SIZE(data); i++) {
> >> -		err =3D airoha_snand_write_data(as_ctrl, cmd, &data[i],
> >> -					      sizeof(data[0]));
> >> +	data +=3D op_len;
> >> +	if (addr_len) {
> >> +		err =3D airoha_snand_write_data(as_ctrl, data, addr_len,
> >> +					      op->addr.buswidth);
> >>  		if (err)
> >>  			return err;
> >>  	}
> >> =20
> >>  	/* dummy */
> >> -	data[0] =3D 0xff;
> >> -	for (i =3D 0; i < op->dummy.nbytes; i++) {
> >> -		err =3D airoha_snand_write_data(as_ctrl, 0x8, &data[0],
> >> -					      sizeof(data[0]));
> >> +	data +=3D addr_len;
> >> +	if (dummy_len) {
> >> +		err =3D airoha_snand_write_data(as_ctrl, data, dummy_len,
> >> +					      op->dummy.buswidth);
> >>  		if (err)
> >>  			return err;
> >>  	}
> >> =20
> >>  	/* data */
> >> -	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> >> -		err =3D airoha_snand_read_data(as_ctrl, op->data.buf.in,
> >> -					     op->data.nbytes);
> >> -		if (err)
> >> -			return err;
> >> -	} else {
> >> -		err =3D airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
> >> -					      op->data.nbytes);
> >> +	if (op->data.nbytes) {
> >> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> >> +			err =3D airoha_snand_read_data(as_ctrl, op->data.buf.in,
> >> +						     op->data.nbytes,
> >> +						     op->data.buswidth);
> >> +		else
> >> +			err =3D airoha_snand_write_data(as_ctrl, op->data.buf.out,
> >> +						      op->data.nbytes,
> >> +						      op->data.buswidth);
> >>  		if (err)
> >>  			return err;
> >>  	}
> >> --=20
> >> 2.50.1
> >>

--gHh2E/ssa1RMJrZx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKnTXgAKCRA6cBh0uS2t
rD5rAP9q+OLLjrD024OMc/m4rI8znbC98tVfeHNtJZR8xHLcpwEA0u4O/FmcPXPG
MLZwtSE4dYcqa9hdaW66/QnKUaqtjAA=
=2Ox2
-----END PGP SIGNATURE-----

--gHh2E/ssa1RMJrZx--

