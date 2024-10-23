Return-Path: <linux-spi+bounces-5321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB49AD2F4
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A3FB2249E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CA1CDA31;
	Wed, 23 Oct 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux2lk5Zo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4A12D758;
	Wed, 23 Oct 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704796; cv=none; b=fvW6TsbFkB/AvHutnRNhL7Huekhw1NyFv0MfB3/iT39T/qKlJXFEaDQBJzSBzLTVzaTyUzDa5yWdWIVBdSjc61SrgeGcH9TKvvjWtwTpClb2opoJE0FtAzSnA3f8vi0mwEBrf4j/+pGr5XhWlt+eghkuCk2vQysxo7Lf4bnKZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704796; c=relaxed/simple;
	bh=aGy3efOls/wqURuBJE1uQzRTyfi1S8NKrQ2z7vHGVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1XVFPHPrfvgJZCJ4euML0YOGDvkDxMQ76Y6QwxfA9+1sw8i6l/j6wf9L6CysmFVJ8ndIHHW1t8p/UnnzqSCcJKieUoBYIwMyPykR4tCPps0Ikk0MRnnr/Gui+UcI9f0WRNZTj+OPV1aOHchf83tH1kghLCxUIgKAlllNe5vxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux2lk5Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B983C4CEC6;
	Wed, 23 Oct 2024 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729704795;
	bh=aGy3efOls/wqURuBJE1uQzRTyfi1S8NKrQ2z7vHGVM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ux2lk5ZozDdLWpl4Kd+qIYbwAsxnFCGlsccdGv6WN30NU38VrGdTasSZVxT+vbZwv
	 91GlM8JFRCLboEWdsQi5qgY53yENom7n3jkhCaIjNhVFJfDoV5Ldq7CsLL67zEaaqN
	 jd8GOocWwN67EHag7V4NmK0XP52yeFBS4+CmnHj5oL1HPBMksKXMDS/Cne2lh80RIN
	 upmoc+kA3CyGBlXkiUWsCfGKMWeCu1kskg4VpQXpWgbUxIhlpDcPpIEfK+Kdz6nzb4
	 XN3btZHxoEnDl225ydG1FUtuW2rGbS0rLkxo0XJN6Esks4rCYI+syk+nIfTQ3xzfXw
	 hyRxn5EEuEmHQ==
Date: Wed, 23 Oct 2024 18:33:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org, lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Message-ID: <94889e08-07b3-473c-9f52-bdeb5d1fd822@sirena.org.uk>
References: <20241023120015.1049008-1-festevam@gmail.com>
 <20241023-irritate-veal-0423be9e4c45@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MQWp88KTWMKl52II"
Content-Disposition: inline
In-Reply-To: <20241023-irritate-veal-0423be9e4c45@spud>
X-Cookie: A bachelor is an unaltared male.


--MQWp88KTWMKl52II
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2024 at 05:37:29PM +0100, Conor Dooley wrote:
> On Wed, Oct 23, 2024 at 09:00:13AM -0300, Fabio Estevam wrote:

> > +  fsl,spi-cs-sck-delay: true

> > +  fsl,spi-sck-cs-delay: true

> Why does this have fsl properties? I figure they're taken from the dts,
> but spidev doesn't use them, right?

These are controlling signal timing and implemented by the SPI
controller rather than the device - they're the timing the device
requires.

--MQWp88KTWMKl52II
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcZM1IACgkQJNaLcl1U
h9Ba4wf+P6T6pEg4ojke9DbwV0LBF1GepvDpkM2yO4LgsY9E1L63FDv5Fic5I646
WkJvG0U+s8RnZlv36dsnkyHIkjBC5Ab8JyIjtSZER/PrBZTc4jIbRjUXrd4PVBZN
n0fEF9K8Xxi41vpfrbpjm1vKw7ng+RxuxreeSnxj8qwMs6WYm8CZvqtAR2/HrjEP
YZmX+eUzRkQRXYcOu6yB8MH6IoIkFYUPmOY7cMrVdvxOZLqXHVbYhVcItvgbmD+1
LJMZNrIJQY5U5yx4NqlF6Sx4RlotC3GhUcI9HQxsTe8TeHQpUtYygj5mKuIddXBJ
5dJm9GeXYrayl/iBYlzN9P9eAlR1hg==
=FlHQ
-----END PGP SIGNATURE-----

--MQWp88KTWMKl52II--

