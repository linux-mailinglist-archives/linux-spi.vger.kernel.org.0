Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8D24C448
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgHTRNr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgHTRNc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 13:13:32 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7773208B3;
        Thu, 20 Aug 2020 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597943610;
        bh=0zK3Lt+m6ZwamOH/bqQ5uwj6Q5PlpMUmoiCi8NwHY8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4fOlswe5a5q0z42oEZLkWuq7Vs4AOZryh17Uq1QQ71iExivXJHkhFj+P5AbvONWB
         xQPzPKFtBSSKe4JWKCvnzSBVMlWszH/jQd7E7F+Xx1m6kM05mR4a3g7iLarv63UBsL
         4vkVFheYqNdO/gMrpBpaY6DZP6f3QbEbFjqZQUmY=
Date:   Thu, 20 Aug 2020 18:12:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 2/7] spi: fsi: Fix clock running too fast
Message-ID: <20200820171257.GG5854@sirena.org.uk>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20200820170228.42053-3-eajames@linux.ibm.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 12:02:23PM -0500, Eddie James wrote:
> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
>=20
> Use a clock divider tuned to a 200MHz FSI clock.  Use of the previous
> divider at 200MHz results in corrupt data from endpoint devices. Ideally
> the clock divider would be calculated from the FSI clock, but that
> would require some significant work on the FSI driver.

Presumably this divider was chosen for FSI clocks that aren't 200MHz -
how will those be handled?

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+rxgACgkQJNaLcl1U
h9DW/Qf/b938F90Z7EgEuWYBPnb61c/NU3E60ICCbDXuBP5mOoZo1jtsF9yiB+Xu
StiK9pOsuydCJHWaUl4/SRoeV3yb9+Yt5hEjCe3z87bs1D3pRxqpeuD6uz7mcxwa
YHqwgcvASbc76xCCIYwS0eumwedVbNnno93kowiM5a50vY3mHVmjfoF97MyJ93aP
NkxAtZsTgs2prQUf+S59jFxkciKyAEXCQQYTTUyiHzWriyKAjKqE+QFKRlKxX6d1
FXvf3bQg1rTSC/1sQzFivWhJZLAoxWFTYM7gstE/M8I78RHy2B5eAG+yAuqbvPcM
xOw9SvRsLd7b9j7VcFx0Ieuf1COxXA==
=TcJ3
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
