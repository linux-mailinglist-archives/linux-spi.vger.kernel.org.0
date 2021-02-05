Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739BE31129B
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBESwp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 13:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhBEPEk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04DC0614A5;
        Fri,  5 Feb 2021 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612542081;
        bh=a7Z+lMVA9/ZigX13Q0RIPSzBjbE3hutWIXG0gkKqk0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWrVlxs0VDv9SfFUqHytMiPYfL9njaAO/b08YerC5AIwMh2hWBOIHEqz91oxbuPre
         7Pwd6APTLKLNemLc/DC1RDIUYjb8wXNLvjmX3qDXsNyuP6edjK7GlScV297CApsf2W
         P//Jlv1PHYvYCeIpJQr5E7RSDvNlwL3EXS67On4QSxZNOXNiIXMR8wu/VXYxjOwjYU
         7IjYXk5ut/x4aGE40Ub+7+YVZe0Q0A75yI2M09YFuEbK9FYMQHqiyipW0f+7omCGUl
         KgA8dZbbC0TG9D+IQL3FHPM9a5XfYwXITJdz9KYt4G7VKcFMaK/S680NVSz12JMNYu
         MqPmnYNYc7lOA==
Date:   Fri, 5 Feb 2021 16:20:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aleksandar Gerasimovski 
        <aleksandar.gerasimovski@hitachi-powergrids.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: tools: fix input string formatting
Message-ID: <20210205162031.GG4720@sirena.org.uk>
References: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2021 at 08:04:10AM +0000, Aleksandar Gerasimovski wrote:
> The actual unescape implementation has two bugs:

This is two bugs with two separate fixes, it should be two separate
patches.

> 1. quotation marks from the input string are not removed and are sent
>   to the spidev, e.g: input string: \"\\xFE\\x01\" will be sent to the
>   spidev as 0x22 0xfe 0x01 0x22

It is not clear to me what the issue you see here is - could you be more
specific about where you see this input string and why you believe that
the handling is incorrect?  After going through the shell the above will
be

	"\xFE\x01"

which includes quotation marks which then get sent on to the device.

>  /*
>   *  Unescape - process hexadecimal escape character
> - *      converts shell input "\x23" -> 0x23
> + *      converts shell input "\\x23" -> 0x23
>   */

This is changing the documented input format and not mentioned in the
changelog?

> +		if (*src == '"') {
> +			src++;
> +			continue;
> +		}
>  		if (*src == '\\' && *(src+1) == 'x') {
>  			match = sscanf(src + 2, "%2x", &ch);
>  			if (!match)

This just appears to ignore quotes which isn't at all what I'd expect?

> @@ -108,6 +112,9 @@ static int unescape(char *_dst, char *_src, size_t len)
>  			src += 4;
>  			*dst++ = (unsigned char)ch;
>  		} else {
> +			match = sscanf(src, "%2d", &ch);
> +			if (!match)
> +				pabort("malformed input string");
>  			*dst++ = *src++;

This appears to be requiring that anything passed into unescape() be a
number which isn't something we'd obviously want?  I'd expect the
function to unescape things, not to do other random validation which may
or may not be appropriate in context.

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdcEgACgkQJNaLcl1U
h9B+7Af/SZQI+CEQyXLtfw7Do0XZ6974RwYOAgq9BZrqXwJl4zxEFPF8D4ncwkz5
MjmFLUS3k5uDlCkFOeCyGRXTNPSJ4NeDQnCTaJPJ/kX0m154dT+29nYpPpNWdVpj
jhh1nJMM0xg544BtCUXftxrnBoT4NCUhFJG2AxywahtJqV/5eLA9KIgoaLPNxQRg
r1K6N66Wfrm4vHY5cJ2CgWo7rENGEyeGXm14/Kr89uf3fQJn2ky/Yy88E2NYwqin
tHDfgvLRSdCLn99KUpUlZNVQqIsiJ37mH8lt5mUvvxBpeAjrpE6NAL701Cgd1/ae
uRTyzjBgRQBO/DPDWcwzX4dna0q62A==
=htnJ
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
