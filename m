Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9152EC27C
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbhAFRjJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 12:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFRjJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 12:39:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2186C20657;
        Wed,  6 Jan 2021 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954708;
        bh=gPZe3RwvYiI/TNiE18vbiIhIebJXS18w8JLeo0/9YTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejWNEiQZcdqta2bMRMawWXqqa7eECYbFPwC1f5nuimxbpCqcSPdUiqPKX1NWOH+XA
         D9FyYwkwbpR2Il7JaaEfnadzHIznKjIBhyOVxHBb37fHFtlEJ/e8/M31XpbTYrTpIe
         ePUBa9utTkKe00EaqmUCBzi2eQf75LLrf9nclAt5q7FhtDjSkdxGVWiBTEkCFN2VT8
         FwB+kwLJr535sZJxznqqKOVBRra8UTlaT1WvA5Q6Mjgq49jR5sENkWUnkaI3OBfZ2I
         p41DfWiftntQq5TqlCMVvQyPzOz15OyXcYIXnMwY5GF6VI6S1DFLoeonUSJFAZyfmA
         AC6SRJkegMANQ==
Date:   Wed, 6 Jan 2021 17:37:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
Message-ID: <20210106173759.GF4752@sirena.org.uk>
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
 <20210106130049.GC4752@sirena.org.uk>
 <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2021 at 12:06:19AM +0900, Vincent Pelletier wrote:

> FWIW, I am now getting a "normal" error message now:
> [  +1.046688] spidev spi0.0: SPI transfer timed out
> [  +0.005210] spi_master spi0: failed to transfer one message from queue
> [  +0.922799] spidev spi0.0: SPI transfer timed out
> [  +0.012172] spi_master spi0: failed to transfer one message from queue
> but it is getting late here and I have not investigated why (my overlay
> needs tweaking for 5.11 maybe ?).

I wouldn't have thought that would be something in your DT, unless it
was previously buggy and some issue has been exposed, but then nothing
springs to mind as being potentially relevant either.

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/19XcACgkQJNaLcl1U
h9Aqgwf/WUdyDN01gKCq4EAYpXhry3X/9BeQt5u8SinBwo3PJgQvaTaoQpbeGIbO
IU0NPlRSBbr8mdraXGo0+6Bg1cmONa2lCptlBJN6DAzy9L8mIuVRzvGCuWI9V+fP
0J9DHtO1IwqcYBrkOpDDMd5kSb1NPBoxGk/XPTtgZYiYPdgMlU1jYv5b984xnYOa
5dliE5h94Ys572vPbN45ONXzfC7+1BArqK7uRjXYtgBFf/nVwG4fimoFxlCdXlND
7I8dZy3xMnfTMe2uLiBrM5Teqq5FrTwzwWNtUy8560ANmU1ITsZPlXscJP1BL4jO
LWabHc/pgc9IMAU7sLyRBViM9U8iBg==
=wPhh
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
