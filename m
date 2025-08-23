Return-Path: <linux-spi+bounces-9628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF10B32796
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 10:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99F9A20A3A
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB0214A91;
	Sat, 23 Aug 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws7grytt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18888610B;
	Sat, 23 Aug 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936994; cv=none; b=IHmUN+s9Tj6lhl3JwtKd7HzHf1+OtDcrvlLE6YkQcXYvi68KBqXDOWttrmIkQWOoN5NtoJPaaeEhwEQX1waV5UBCNX9XMmF2fRoYWCChVEDizs5TxyJ+KGu8zxf/zoF0OlBeBEAv2hvkZ29ZoDSoIxM8e1mb8SDRrqjuKX70WG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936994; c=relaxed/simple;
	bh=EjPCml3xZf6e7X0R1TOHE2nxPXuWBODdoFUOAb2vj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DczXRBD9U/2r6wxE7leja9R0wWJpg4ClXcbZ+hmPmNKP+1JrD+RsDlX6X4m6nMv/bsJa8RqTWc5ThzzrdG9h8cAU7KuI80ritbUS0NIyInSdZNWjKbc/kvRrmjnxFbCvOb7IUxzBMA0ulGnkQtRl3Kd751hk5y9PuM162TgyQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws7grytt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8200AC4CEE7;
	Sat, 23 Aug 2025 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755936993;
	bh=EjPCml3xZf6e7X0R1TOHE2nxPXuWBODdoFUOAb2vj4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws7grytt4M/AAjL0Q7NVAoms6DeHKjmrnqf+NBZj5sleuqXnHk9NRs9IFse6tN1jD
	 9I1SDd9n8TZ0S9Rm3s5Hq0xvMWw36Mem3hq/RJft86UWK7YqqtOqk2UnH8wR2rdge8
	 bEqWS/mQ1/CGh0iOt46A/aWncTKQjVuoH15XvdxL86wAQ/rgXd+nIv7zuI8bofBQS0
	 13Pz43IaTAvJCDh413tSbH4rUt/5S9nkF0PDozKJu703LNiteeJsG+sKozfehkgqNf
	 +4Q+vuYwKQzVKQb4lp7ClEtrwV2+7401v7TknXijQlWg9bvGLzD4dtAbK9Pk/D6agY
	 RP7/Kb4xfR6Vw==
Date: Sat, 23 Aug 2025 10:16:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/13] spi: airoha: add support of dual/quad wires spi
 modes
Message-ID: <aKl43hTJJVqRE3Rt@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-4-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ero2GujmTOGzZXiu"
Content-Disposition: inline
In-Reply-To: <20250823001626.3641935-4-mikhail.kshevetskiy@iopsys.eu>


--Ero2GujmTOGzZXiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> -static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8=
 cmd,
> -				   const u8 *data, int len)
> +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
> +				   const u8 *data, int len, int buswidth)
>  {
>  	int i, data_len;
> +	u8 cmd;
> +
> +	switch (buswidth) {
> +	case 0:
> +	case 1:
> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_SINGLE;
> +		break;
> +	case 2:
> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_DUAL;
> +		break;
> +	case 4:
> +		cmd =3D SNAND_FIFO_TX_BUSWIDTH_QUAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Since this is used in airoha_snand_write_data() and in airoha_snand_read_da=
ta()
I guess you can define a routine for it.

> =20
>  	for (i =3D 0; i < len; i +=3D data_len) {
>  		int err;
> @@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_sn=
and_ctrl *as_ctrl, u8 cmd,
>  	return 0;
>  }
> =20
> -static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 =
*data,
> -				  int len)
> +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
> +				  u8 *data, int len, int buswidth)
>  {
>  	int i, data_len;
> +	u8 cmd;
> +
> +	switch (buswidth) {
> +	case 0:
> +	case 1:
> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_SINGLE;
> +		break;
> +	case 2:
> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_DUAL;
> +		break;
> +	case 4:
> +		cmd =3D SNAND_FIFO_RX_BUSWIDTH_QUAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> =20
>  	for (i =3D 0; i < len; i +=3D data_len) {
>  		int err;
> =20
>  		data_len =3D min(len - i, SPI_MAX_TRANSFER_SIZE);
> -		err =3D airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
> +		err =3D airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
>  		if (err)
>  			return err;
> =20
> @@ -895,12 +935,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi=
_mem_dirmap_desc *desc,
>  static int airoha_snand_exec_op(struct spi_mem *mem,
>  				const struct spi_mem_op *op)
>  {
> -	u8 data[8], cmd, opcode =3D op->cmd.opcode;
>  	struct airoha_snand_ctrl *as_ctrl;
> -	int i, err;
> +	char buf[20], *data;
> +	int i, err, op_len, addr_len, dummy_len;

nit: can you please respect the 'reverse christmas tree' here?

> =20
>  	as_ctrl =3D spi_controller_get_devdata(mem->spi->controller);
> =20
> +	op_len =3D op->cmd.nbytes;
> +	addr_len =3D op->addr.nbytes;
> +	dummy_len =3D op->dummy.nbytes;
> +
> +	if (op_len + dummy_len + addr_len > sizeof(buf))
> +		return -EIO;
> +
> +	data =3D buf;
> +	for (i =3D 0; i < op_len; i++)
> +		*data++ =3D op->cmd.opcode >> (8 * (op_len - i - 1));
> +	for (i =3D 0; i < addr_len; i++)
> +		*data++ =3D op->addr.val >> (8 * (addr_len - i - 1));
> +	for (i =3D 0; i < dummy_len; i++)
> +		*data++ =3D 0xff;
> +
>  	/* switch to manual mode */
>  	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
>  	if (err < 0)
> @@ -911,40 +966,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
>  		return err;
> =20
>  	/* opcode */
> -	err =3D airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
> +	data =3D buf;
> +	err =3D airoha_snand_write_data(as_ctrl, data, op_len,
> +				      op->cmd.buswidth);
>  	if (err)
>  		return err;
> =20
>  	/* addr part */
> -	cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> -	put_unaligned_be64(op->addr.val, data);
> -
> -	for (i =3D ARRAY_SIZE(data) - op->addr.nbytes;
> -	     i < ARRAY_SIZE(data); i++) {
> -		err =3D airoha_snand_write_data(as_ctrl, cmd, &data[i],
> -					      sizeof(data[0]));
> +	data +=3D op_len;
> +	if (addr_len) {
> +		err =3D airoha_snand_write_data(as_ctrl, data, addr_len,
> +					      op->addr.buswidth);
>  		if (err)
>  			return err;
>  	}
> =20
>  	/* dummy */
> -	data[0] =3D 0xff;
> -	for (i =3D 0; i < op->dummy.nbytes; i++) {
> -		err =3D airoha_snand_write_data(as_ctrl, 0x8, &data[0],
> -					      sizeof(data[0]));
> +	data +=3D addr_len;
> +	if (dummy_len) {
> +		err =3D airoha_snand_write_data(as_ctrl, data, dummy_len,
> +					      op->dummy.buswidth);
>  		if (err)
>  			return err;
>  	}
> =20
>  	/* data */
> -	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> -		err =3D airoha_snand_read_data(as_ctrl, op->data.buf.in,
> -					     op->data.nbytes);
> -		if (err)
> -			return err;
> -	} else {
> -		err =3D airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
> -					      op->data.nbytes);
> +	if (op->data.nbytes) {
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +			err =3D airoha_snand_read_data(as_ctrl, op->data.buf.in,
> +						     op->data.nbytes,
> +						     op->data.buswidth);
> +		else
> +			err =3D airoha_snand_write_data(as_ctrl, op->data.buf.out,
> +						      op->data.nbytes,
> +						      op->data.buswidth);
>  		if (err)
>  			return err;
>  	}
> --=20
> 2.50.1
>=20

--Ero2GujmTOGzZXiu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKl42wAKCRA6cBh0uS2t
rM2xAP4nzq2IBmkmwW41UNrGBqLA8KFF0d95d8iZVKb5shsp4QEAraoPWPC9xSxi
i9/lp10dXs/VXs6kOLhVE4YavJpVdg8=
=3RQS
-----END PGP SIGNATURE-----

--Ero2GujmTOGzZXiu--

