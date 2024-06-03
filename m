Return-Path: <linux-spi+bounces-3197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72A8D8236
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CBA1F23008
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB6912BF1C;
	Mon,  3 Jun 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeioYZuF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B012BF32;
	Mon,  3 Jun 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417601; cv=none; b=DQt0zLUb3YwaUyAH9WPnxQOYg6nxrTr3VMTeKSfeXDNH6DseCGRiIG1yzmjhdxJ69lDtXqTs47i4n/atUMmXGu7FntsgmmgYVxZJRL1DKFYdcg/e1RVsnSMH6ctrO9hEY4/Mez/oIpEwW+Zqlqji5OnX7vcSpF4C8bu6G4XikTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417601; c=relaxed/simple;
	bh=wIgymuL6XJI+YlOFmk0uxFgDEh3CdWaGsxUTfZGPfcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8Do51Go98lrHQtn/bCkrGyUVNi8tkKLy8FjOd9Ecc94S1NZcOHyfy1XJo9dWEifTkiLDVG2u867m9XP2weunGtntNEgJminarVChgryc80ewRTFLccQ8nB62pOdbZ715iiN/l537MDR9cCFlJ2oNBmdKPqVjzqE5+jfxLzVMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeioYZuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3375EC2BD10;
	Mon,  3 Jun 2024 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717417600;
	bh=wIgymuL6XJI+YlOFmk0uxFgDEh3CdWaGsxUTfZGPfcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeioYZuFWlDtHlXbGYUk9O6sJ1vZ6hQEH/GlEKicua6+yLSueykrlPu3Wwh3TteTO
	 jcojPsjtx+8J+9cZzeLZkPg/myb6ktuT0rRVsVdi1CUs9PRHV2MDZaseDaYsZi2fqZ
	 kYxXNDSwE6+To6PtdZD7/lxAcXsxH7UQBMD3+eltYb2mLE06Ibh5L7/UuYl/SOj6bv
	 BymDxJr9Br3Jwt+n8EDdMFZji/5L7DXu/CwCLFHLsFLqv2DzWPvrla9ofCsz+Yg90g
	 /AO3AfbFqnFqj5W/YQvphmRydvB6uExmu2hVlFyKnpYi2VcFlChRI95+6dxdEKu9Es
	 rb0JY2KNG/NVg==
Date: Mon, 3 Jun 2024 13:26:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <c258a169-cdbc-4a92-bae6-46bd38df86fb@sirena.org.uk>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
 <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
 <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
 <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SIGY3O7/MZTKNKtO"
Content-Disposition: inline
In-Reply-To: <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
X-Cookie: Don't let your status become too quo!


--SIGY3O7/MZTKNKtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 01, 2024 at 12:45:30AM +0300, Andy Shevchenko wrote:

> I have sent a new series where the last patch has a massive rework of
> the cur_msg_mapped flag. Would be nice to see if it passes your tests.
> The main idea there is to actually move to per transfer flag(s) from
> per message one.

That feels like a sensible cleanup but also a bit much for a fix with
all the driver updates...

--SIGY3O7/MZTKNKtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZdtnsACgkQJNaLcl1U
h9BTXgf/e92BbpQ83kYcfEUsyXFkvT1dLNSBrCkKbwW5PcUhUMuvwQO5/WCxwGbc
Ne2FNZOBLIlJU4AOkU1Nlcl7hREBbqqcy0ej0fcW3paMdxa5UpMeRBTVHtieNmSe
qiZemsK7uiZt/1kAGe0rtREIaoLnu1Byc7siFKEEhS9TQZ4FwAxAuDeVfxPmzwTW
2+iVgs1mUSCW5H1WgdSACemsDF6jwvmOUXd89JJnVNswFBBF0q4juKqCWBsXczQF
/T+4AuIfpmd13yFC6kaJaKbqWZe6mVYzXXnVBp74iw39LKpnTdu7ebqnTBip0VU7
aWXNBRdG64u2ztzUv30YjGm8vyZNqg==
=f3Fr
-----END PGP SIGNATURE-----

--SIGY3O7/MZTKNKtO--

