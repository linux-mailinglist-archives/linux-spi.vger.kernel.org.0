Return-Path: <linux-spi+bounces-10733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8099DBF2C3E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009BF4639AB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C4331A65;
	Mon, 20 Oct 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMFgLSI1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D9283FC3;
	Mon, 20 Oct 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981971; cv=none; b=ZTyrAzrFMWuUcQnoMdR7Wf/+TVoQdvdSFFlBcm6imoxZpSjpFXojA1c6u/oJ6UrZIjsasCRR/VpHktyuRKDMo2KSGdJ6bXhGEEHnqb8B84KJ6c0numRVJGwEU3J52K1iBx4Xgb64sd1fUYVvN/FEe3Cstl8WRVRaRkQ7aCQuehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981971; c=relaxed/simple;
	bh=CrfF6HDbxJVfeklUuZ9rurUFTFP0Q4f+NGC+Mm7jVfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrUtDGUj+tCo6l0dNIjAYRpz8Vkd35zcW2rUEyml4R8cmpSv8Xih+Jic4dk4l1FZjbnnNHPcqsrcR6Ymvnzo3aYpEh3f+SM/0BVltcDgXLm6VgEEdrwarhKCLrX6RR0DmmaAN7LblIreDkWsxCShy3at1XcmkGnsBCNepn0Q7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMFgLSI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60184C4CEF9;
	Mon, 20 Oct 2025 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981971;
	bh=CrfF6HDbxJVfeklUuZ9rurUFTFP0Q4f+NGC+Mm7jVfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMFgLSI1CEJqgyck8ld6dGNIEh9MmHVPLcVhTlTJaO8N1dKogXE0y8tJlggrMaE2e
	 Ibvzjir7DwlIJ4ACY6wMlRCPKB0cN+EI92VvA/6SVbe8wty59wquEgi2md4bCtTtYr
	 oQs462VGImx0oeeajqhQCTAYgunYyr/fzah/wu8T3TGqwn9GNLkMtl9BaamWcwWY4M
	 /NkD2fLKOvBswkbgCQhPzk5Rvi1uIRUCW2x/VDlPc2iy+iuGc1sYSokO7rvGyZZ3yR
	 ZiB/sg105ruiKfWi4z6jKbBB8YNIxwAOEPjEStCGkhI8qjz5ZgZTkAaI/dyEZS8wpm
	 Gcz55/aUitH3w==
Date: Mon, 20 Oct 2025 18:39:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <20251020-blinked-primary-2b69cf37e9fe@spud>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h9bnZ0Qvvq6hacya"
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-3-elder@riscstar.com>


--h9bnZ0Qvvq6hacya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:51:45AM -0500, Alex Elder wrote:
> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml =
b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index 0315a13fe319a..5bbda4bc33350 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -22,6 +22,7 @@ properties:
>            - fsl,imx6ul-qspi
>            - fsl,ls1021a-qspi
>            - fsl,ls2080a-qspi
> +          - spacemit,k1-qspi

Are the newly added resets mandatory for the spacemit platform?

>        - items:
>            - enum:
>                - fsl,ls1043a-qspi
> --=20
> 2.48.1
>=20

--h9bnZ0Qvvq6hacya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZzzgAKCRB4tDGHoIJi
0kswAP9b+/liNkMQCp6Ke+y5UQUGUAbD7vBZB+rfyvxgqBNLcwD/Tv29tJBXshLX
kh3QQ3TDjVtGX4xd3SvbxGWnXDGO3Qk=
=idEQ
-----END PGP SIGNATURE-----

--h9bnZ0Qvvq6hacya--

