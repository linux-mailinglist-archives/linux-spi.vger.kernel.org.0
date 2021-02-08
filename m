Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E6312EA5
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBHKOL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 05:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232026AbhBHKKf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 05:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C6264E92;
        Mon,  8 Feb 2021 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612778992;
        bh=IHPW+HGkDuPu2XY8DmS738vt0B50alZRoijoHns68Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWWUDPKG472WHRfs0Jh4HRmd2W6y9P3UbVMoQ++VzLwDnLiSV4TWPeQZ6PghL3i8w
         KGL5qFaa/yR1ZlX64xIw37dBMqeb7ea75DejsdpSnsH8mg3ozUmA8fQyuen4sNFEdc
         5OV0jGEtBPSQDcH6URWryKLlO0V7zo6PwCbeKesYUQtcHc+m3/ZwMkmCb2xJUDJ0SF
         a35VgOiu5NvUFPVOWX32JNOCyMfVAhs6dVTtAnrmuf6YIhHvw9+xVm1cZU4ZesmLYr
         uubuyd+BnlZq4UqpuJMr+TBr5uHK2NF/qW8I40QZ4SQmF2FqnYCVJHsjdCt3KP5DS4
         ZjtJUqw9urwuA==
Date:   Mon, 8 Feb 2021 10:09:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aleksandar Gerasimovski 
        <aleksandar.gerasimovski@hitachi-powergrids.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: tools: fix input string formatting
Message-ID: <20210208100901.GA8645@sirena.org.uk>
References: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
 <20210205162031.GG4720@sirena.org.uk>
 <VI1PR06MB4029DDA88C93EFBA0F69D838D2B19@VI1PR06MB4029.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <VI1PR06MB4029DDA88C93EFBA0F69D838D2B19@VI1PR06MB4029.eurprd06.prod.outlook.com>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 06, 2021 at 10:57:04AM +0000, Aleksandar Gerasimovski wrote:

> AG: to be sure we understand each other, you expect quotes to be sent to =
spi as well? That's expected by design behavior?
> Is there any possibility to avoid sending them then?

If you don't want quotes to be sent then don't send them - my
expectation would be that if you're driving this from the shell then the
shell would not be passing unescaped quotes through to the program.  For
example:

	$ echo "Hello, world!"
	Hello, world!

Here echo only saw the unqouted string so that's what it displays.  If
you're not using a shell and starting this from another program then I'd
assume there's some way to generate unquoted arguments in whatever
you're using.

>=20
> This appears to be requiring that anything passed into unescape() be a nu=
mber which isn't something we'd obviously want?  I'd expect the function to=
 unescape things, not to do other random validation which may or may not be=
 appropriate in context.
> AG: so by design is expected that everything is accepted here, e.g \"1234=
qwert\\xde\\xad\"? If yes than I understood this tool wrongly.

Yes, that's my expecation - it's just processing escape sequences and
passing everything else through.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhDbwACgkQJNaLcl1U
h9CCTwf+LhF9qadeHEkEay8vj52ptql3ZywaSYyalXLVn2F39iqOgIAV7W5doXh1
3hwUgr+VJ27hjWv2xtrWvHvwTY1LfU6bvjuno/NoUEVok3iommPN0+8gG/o5luHA
vaBaJwi2C/0cJyO5cElw5r2RL1G1HQmGPS30asLNXeGEnI2e6qzhE1f65+8AfWvU
VscqDku5+bl+jCgDnowgjYogu/iLrRVxuJdiaNjOL2EOY/hyApRCX0SI7frAPucB
vzvzslkwg3hnJwWclaANuspRu/i4iZUXkP9k+VEbsRfoRWWwoHD9V/EHGEGfE8A+
AAQv4z6Z8ujB05EvDASG4VaJRcb3Yg==
=yr5l
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
