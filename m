Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4550D4342B4
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTBEr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 21:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTBEr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Oct 2021 21:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C9660FDA;
        Wed, 20 Oct 2021 01:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634691753;
        bh=lKe57nP/sxW4RigSphLlW5WD04hN/bPiQPe5cPzBQ8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ea5SjwCXltSE/D1Ghqt5oBKkViKk642YHLL9Iza4AxGpJHPYWeYVeaMC+/ynjOKa3
         Gs3hsSdGMsXCK/UdZH7s+JrVrr4eqcgIQ5UF+Om0zwq+3XDu4BNqbicCF6wqElUzFG
         utxLTcNLcV993qXXIpZa6zZsjNNV6wvahsRUhyFSL6R0HuskoDK7jy6UxOEcc5MRK4
         Wn1vAMx3RO/8fQOaW4UleGd55VoEr5UeGD1OE3FuB8WbBtnr5Ux+dAnn/suZH4mSY5
         3h2IIllAzrjRoZPobS5UtPeF7lGTjb6sSg+13hI+aPyvCOG4G332UwePTKaWJ3tExx
         meKJyga8bOoKw==
Date:   Wed, 20 Oct 2021 02:02:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Message-ID: <YW9qpi2Pu49emDXg@sirena.org.uk>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
 <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rVUWWoXc4cg5dODj"
Content-Disposition: inline
In-Reply-To: <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
X-Cookie: Minnie Mouse is a slow maze learner.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rVUWWoXc4cg5dODj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 18, 2021 at 05:27:38PM -0700, Russ Weight wrote:

> If there are no concerns with this patch, it will need to have the "cc stable"
> tag added for earlier kernels.

This feels like a risky change to introduce into stable kernels
given that while people shouldn't rely on stable number
assignment they may well have done so.  I'll skip the stable tag
though if you want to request a backport with the stable team
they might be OK with it - it definitely feels like it should
have a discussion rather than just going in with a tag.

--rVUWWoXc4cg5dODj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFvaqUACgkQJNaLcl1U
h9DTtQf/S5x9JjmhmJncX7ieS2OvWbDp+HEzX+S+zk8dEKdN+LItKBtwZxVJZoEH
alHSwU/wqCLSaR7bwk10dO4ysY2rdwHLf0eKOLJOvjvZsdYEKdtvvhaGnSQXcEra
RrndKesi4kMwpCq2Ck9KSim3VHlh0iPrmIVHxQ9mwgWVP4IXbSSQpInT5EnI5ohx
b0GdO/5uIdQfwO3bNt3SuXpELB19gSsoDcP6wpNMVoEtkFPqkwiuWYlr3wJOyQU+
MU7NnEEp2jDtf+tBX2H8eWn4rJ3IDB0c2HgpIQCTP/nWSoOmKeKwBsIIOYn2YkO7
eIREGt1JmFSp5MTFiFCye8X9gZDOgw==
=IM32
-----END PGP SIGNATURE-----

--rVUWWoXc4cg5dODj--
