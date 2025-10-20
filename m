Return-Path: <linux-spi+bounces-10743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D464BF2F9D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 20:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 166384EADCB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA742D0283;
	Mon, 20 Oct 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivXVHfp5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2932C21F0;
	Mon, 20 Oct 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985712; cv=none; b=eAja8T+c3oykJigcwZb3F1skiCx8ShRwNwsZ128QluOfRcfdX/tUhckbeuO97gIgaN1qvBiE6QPEWl4n8yAVvDUdTSFuCCUuAuM2ykxQLVNQXUj0YAh7epJagmZZcq5mUl7XroC4Ispr7wKqjzPS5Scs+EGobn7heG9gXYqNbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985712; c=relaxed/simple;
	bh=KC5ynBTKwAPPm0Ypk6n9KoPtmJH7cvFRh2ciSY8Lgx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flgYdoyr745ahthlM8BIh46gJrufxv48i+pnwQpK8o2GnBpYMy8yYfcjwR/i3hBP1AUTr2jsBHgAh1fKwtinuIUuwXrnAAMTkUPoN0JCKrlWr8rdweGEMASKdaVVXNWqlqiE6dEK7JIbAOscm4I3i3t2p5hGQPBPLKtjM31Jyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivXVHfp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2113C113D0;
	Mon, 20 Oct 2025 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760985711;
	bh=KC5ynBTKwAPPm0Ypk6n9KoPtmJH7cvFRh2ciSY8Lgx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivXVHfp5mcc7Qs6T2dGRR3qWo5mpwJ/C2T3UqyXTZjjUdnK8XTbgGKD1yNGbzRcIW
	 gw1B/EaRizweTxKV2AvTHc85QcneaAaaiw3DQOOXBBFDwFzjXPWL1Ff4yPd7DF+TC1
	 rpHpJRTUxBmbLk9I7TLdorms7cO23bo5322qnKSt6S8+W8wrC8XVq2dTSqozQrc6QS
	 1E5NA0nu018nP4UMwxaTEQ8wHg4ySQaY0UcPIs93sM0qYQrGLNxGG1wcoVV+NDwugD
	 QXr9UdmZGeiY+MZb0KRiDguDywmupXimWUuO/OkULdKE/R7ntbykjAVwvXnLMF83K0
	 hZ3RiJWg1+h3w==
Date: Mon, 20 Oct 2025 19:41:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <20251020-unwound-cake-21799c9522a1@spud>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-utility-remedial-4b4dfc716409@spud>
 <08d99fcd-4d0c-4d81-a314-7e1a8bfaa64c@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S9zWXF20ApbbyoB6"
Content-Disposition: inline
In-Reply-To: <08d99fcd-4d0c-4d81-a314-7e1a8bfaa64c@riscstar.com>


--S9zWXF20ApbbyoB6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 01:06:50PM -0500, Alex Elder wrote:
> On 10/20/25 12:41 PM, Conor Dooley wrote:
> > On Mon, Oct 20, 2025 at 11:51:45AM -0500, Alex Elder wrote:
> > > Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.
> >=20
> > Also, you should really explain why this spacemit device is the first
> > one to be in what's been an fsl-specific binding for now in the commit
> > message.
>=20
> I'm not sure how much of an explanation you're looking for, but
> yes, I agree with you, it stands out that it's the first one, so
> I at least should have acknowledged that.  I'll add something
> here in the next version.

Even just mentioning that the register interface etc is nigh identical.
Otherwise this just looks like picking a random file to put the
compatible in. Remember, this is independent from the driver change and
must be justified in its own commit message.

>=20
> 					-Alex
>=20
> > pw-bot: changes-requested
> >=20
> > >=20
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.y=
aml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> > > index 0315a13fe319a..5bbda4bc33350 100644
> > > --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> > > @@ -22,6 +22,7 @@ properties:
> > >             - fsl,imx6ul-qspi
> > >             - fsl,ls1021a-qspi
> > >             - fsl,ls2080a-qspi
> > > +          - spacemit,k1-qspi
> > >         - items:
> > >             - enum:
> > >                 - fsl,ls1043a-qspi
> > > --=20
> > > 2.48.1
> > >=20
>=20

--S9zWXF20ApbbyoB6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPaCagAKCRB4tDGHoIJi
0ohiAQDQx8/ngIErenJDLWY4lU6RY+0qmrL51bMTNVAHh7sOwAEAghs7YSCh8Sjd
Sp5Y5uHh2P8M3xL2JiAL026goVBQXAg=
=a65U
-----END PGP SIGNATURE-----

--S9zWXF20ApbbyoB6--

