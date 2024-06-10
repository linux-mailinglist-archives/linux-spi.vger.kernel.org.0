Return-Path: <linux-spi+bounces-3364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A890267A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 18:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390AF289B92
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38957142E78;
	Mon, 10 Jun 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCBZuDqG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85E81754;
	Mon, 10 Jun 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036360; cv=none; b=Qf0Tx4OZiPAh+9UN5DBYycSc9ibX2Bov5cRNghcL0Wn1FrxhGoBcxNAsU0fNGZ1hqvcaHtVTR2Z6zGDr3+Zrn4hgl66urS/yV2xI9hqkj3/8hNr1Df3YI+1U90Mj3bNVn/qTP3xcUYxztjCCmYmR+gIU9NQCISQh/TqSM7NJX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036360; c=relaxed/simple;
	bh=BbqJ1v2auCLBE0bToKR5V2m6jVtwM9b3QEfzCJ0IEGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKe4/V0V9ulX9YeEzXsx7UGAvxBZG0nZX62es1vCf5ygD8aG++jdXJTU2ukLgNAL6guLXNPBCBFZbqv0201BWmc1wt2HvrWzpAZ3oicg7qtl1nZZlSrKjWp9P2PBOITbdhpeW81kY2pWRi1pvlGhzSio2M1k8x6U07fGFMUfqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCBZuDqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7C4C2BBFC;
	Mon, 10 Jun 2024 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718036359;
	bh=BbqJ1v2auCLBE0bToKR5V2m6jVtwM9b3QEfzCJ0IEGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCBZuDqGMZksQ02K0c6Tu0igtY4udAd2HSprodAzpj7y20CG1Rp94dBhi67W4sV4B
	 FhxwAU00PLHQNegE7o9BEdkh5U+D7udL5MwHWWoZrVh2WfsZGTz66KaZmYvVZQVLCf
	 xwGRR8JC3MnNGlePNimuEgxrBFE03d8DilPpCt5P5tdrZKUiM9AgItec9FwZva0xTX
	 KK7oBHuHbIXWXJSzDJy+m+WXd/pYdmKi1ZK6pr30JO5EADzooTkT8fu7Q5HaWrciHb
	 Dj6ZjPLUBy8/5Q0Am01/D1LK5yfOG+VtG+FipVcnVWt/TTN0x3Ivu/inudTdlekQ/t
	 qFyzKDvshmAGQ==
Date: Mon, 10 Jun 2024 17:19:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay xfer operation
 support
Message-ID: <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-5-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QscN4rSe5xkktnMl"
Content-Disposition: inline
In-Reply-To: <20240607151831.3858304-5-wsadowski@marvell.com>
X-Cookie: Your love life will be... interesting.


--QscN4rSe5xkktnMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 08:18:31AM -0700, Witold Sadowski wrote:

> +static int cdns_xspi_prepare_generic(int cs, const void *dout, int len, int glue, u32 *cmd_regs)
> +{
> +	u8 *data = (u8 *)dout;
> +	int i;
> +	int data_counter = 0;
> +
> +	memset(cmd_regs, 0x00, 6*4);

The magic numbers here aren't great...

> +static unsigned char reverse_bits(unsigned char num)
> +{
> +	unsigned int count = sizeof(num) * 8 - 1;
> +	unsigned int reverse_num = num;
> +
> +	num >>= 1;
> +	while (num) {
> +		reverse_num <<= 1;
> +		reverse_num |= num & 1;
> +		num >>= 1;
> +		count--;
> +	}
> +	reverse_num <<= count;
> +	return reverse_num;
> +}

I can't help but think there ought to be a helper for this though I
can't think what it is off the top of my head.  If there isn't it
probably makes sense to add this as one.

> +	/* Enable xfer state machine */
> +	if (!cdns_xspi->xfer_in_progress) {
> +		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
> +
> +		cdns_xspi->current_xfer_qword = 0;
> +		cdns_xspi->xfer_in_progress = true;
> +		xfer_control |= (MRVL_XFER_RECEIVE_ENABLE |
> +				 MRVL_XFER_CLK_CAPTURE_POL |
> +				 MRVL_XFER_FUNC_START |
> +				 MRVL_XFER_SOFT_RESET |
> +				 FIELD_PREP(MRVL_XFER_CS_N_HOLD, (1 << cs)));
> +		xfer_control &= ~(MRVL_XFER_FUNC_ENABLE | MRVL_XFER_CLK_DRIVE_POL);
> +		writel(xfer_control, cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
> +	}

Could this just be a prepare_transfer_hardware() and we could just use
transfer_one()?

> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		u8 *txd = (u8 *) t->tx_buf;
> +		u8 *rxd = (u8 *) t->rx_buf;
> +		u8 data[10];
> +		u32 cmd_regs[6];
> +
> +		if (!txd)
> +			txd = data;
> +
> +		cdns_xspi->in_buffer = txd + 1;
> +		cdns_xspi->out_buffer = txd + 1;

Oh?

--QscN4rSe5xkktnMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnJ4QACgkQJNaLcl1U
h9Dp1wf/WWCSFxYA9ICwOA6a517Qv5oZM6qYTRD9DXmo/lVgjct+IPOYv8EzpMJn
6R13HN446bDgxlYUEKBj3khExObjLdA+JbrEa50OV6ylKDWUcYfhGw7l4FNKQdmp
dlztImDchBdOisfrcVyLk/yzZZ5YHlFzmYldqrcVDQYQySDtuRt3uGm7wwWDdcu4
BaOSqwoBskBGobu3S/TFdOa1wNusmc8s6K3Ti5j6y0q0X1lgRfmanltHuD6XBWn5
NGrkO7xN/v2DyQKmCkKcDpSWUllFYEqHDhDZjr8EkrUQlkIvhtI5Tf1/E1r5qyOY
kkyDt6TcBguiNI+NuByW8RL9kB2QjA==
=LJaH
-----END PGP SIGNATURE-----

--QscN4rSe5xkktnMl--

