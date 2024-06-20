Return-Path: <linux-spi+bounces-3502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC29107A5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34481C21424
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7D1AD499;
	Thu, 20 Jun 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoUAqF1T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AE1AB91B;
	Thu, 20 Jun 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892740; cv=none; b=eYIAaLP7yvzj2fioI0r2nPGkv1xtaTHbvWXRi0VeZnZXd+/CDdez1UB+Yzn3MGH6mluYxxs3EV5L5DA9OtOc5TbZ+urkxua0f+mJqVf6G88zfXqlhd/FG13tkRwbrhEjh6bg7LfYrCBWa2BWv5OHq1gkjSGm+ic1/7Du1gNGK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892740; c=relaxed/simple;
	bh=jaHtqvnl/8145WvpSmKxMsC0py9b0Z2+/5mdF/t2BVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5QJhatLCNv8a+QjDMCTVh7Spupfbhp/qJSr8xtCvvPBccquAFWx2rtxdTO587oOgYMpZ4RuOocnfT5jRMK86LY9FRjtaKrVKWpUf0GxNpYEZaxkVyaOlRj/T3Cm+sQX+OBYGtU69h/oQPFxeun5O+10Oz/Qp7dr5iqBhAKgD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoUAqF1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1893BC2BD10;
	Thu, 20 Jun 2024 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892739;
	bh=jaHtqvnl/8145WvpSmKxMsC0py9b0Z2+/5mdF/t2BVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoUAqF1TWisVXlKx1R6rbK7FF8PojsZbGDH/N21OijhxLrMzCDQGDHTdFgTzeOYF0
	 BFKwNlaHp8wC5JMnodyBFHkcHcbauG0s2HCd7E6tVAClWfnGDbIUcbiy7BrYky395T
	 W70Ov+aisUarLyr43Z9wq/7o3iTzvyhVk49HQvI26DwTmj8SRNchvO/VKe12DKXVFK
	 LVAhiD1wje3HGghF3UspexfNzkJYVn5q3Gq/l9rrql9Ga1k5WPdErK6IXkn/nogFXm
	 AIgiiJZUFe2M5HwCxywy3csXIYxwqmBSVlUSiniyGwX+1CJ0eGJpT3QBRiqaxNy+yU
	 2aqYg6ihn4M6Q==
Date: Thu, 20 Jun 2024 15:12:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable
 of getting as low as 400k
Message-ID: <20240620-sabbath-ambulance-b8764fb386e9@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
 <20240612-dense-resample-563f07c30185@spud>
 <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J7FzOIBzomdGrjSM"
Content-Disposition: inline
In-Reply-To: <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com>


--J7FzOIBzomdGrjSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 02:50:15PM +0200, Ulf Hansson wrote:
> On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
> >
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Some controllers may not be able to reach a bus clock as low as 400 KHz
> > due to a lack of sufficient divisors. In these cases, the SD card slot
> > becomes non-functional as Linux continuously attempts to set the bus
> > clock to 400 KHz. If the controller is incapable of getting that low,
> > set its minimum frequency instead. While this may eliminate some SD
> > cards, it allows those capable of operating at the controller's minimum
> > frequency to be used.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Looks reasonable to me. I assume you intend to send a non-RFC for
> this, that I can pick up?

I do intend doing that. How soon depends on whether or not you are
willing to take it on its own, or require it to come in a series with
the spi driver changes.

Thanks,
Conor.

--J7FzOIBzomdGrjSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnQ4vwAKCRB4tDGHoIJi
0h14AP9hHmPYyjRVNp3J/ZBQkJts0rC9TJWO3QCvwnoKZAnRUAEAkhi9CK031dYU
SHkj+T/cQaz5KRpEJqolTupL9bTZeg0=
=D39D
-----END PGP SIGNATURE-----

--J7FzOIBzomdGrjSM--

