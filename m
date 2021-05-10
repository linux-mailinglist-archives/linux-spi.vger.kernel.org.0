Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBF378ECD
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhEJNcA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243491AbhEJMLm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:11:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36D0613DE;
        Mon, 10 May 2021 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620648632;
        bh=LDVAdlR+VMCba4GWFXIi0m+j0tXX4AqaAF0jAJM1Fi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8M/5ecxIiiaNCLz1lwPxU7vvx8vMNqoOZScYGZOoNmWBd6NFlEmwscHxTRHaLZar
         zsegEkmv7AJ5zKd0zyt4isw3Xr8u3gQ5oG5iL6dmj5Fy8Nobm1gwMNx9bgl7iVe46e
         yv58e6QbJc6A44/+uaogTxcqQ3lRhRQZUjGMab0pRZRLK4tZaqerNws3ZUV0G8NPCt
         vL1z6gzNjo9xC7zmpk12qVjQRYiQGcsYayMSH+YmPo9YnGVAoOKB8ytmabY6tWQBFp
         PEz6M9LorNP+VYTRQBnERgQII9uvZNgcqZznieI3YS4q8w7bb/KGXQc0jTj16dRF5n
         HuhS85MIsGs1A==
Date:   Mon, 10 May 2021 13:09:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset()
 helper
Message-ID: <20210510120953.GA15173@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
X-Cookie: Thank God I'm an atheist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 09:24:34PM +0300, Andy Shevchenko wrote:
> Currently we have three times the same few lines repeated in the code.
> Deduplicate them by newly introduced int_stop_and_reset() helper.

This doesn't apply against current code, please check and resend.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCZIpAACgkQJNaLcl1U
h9Cp/Qf9HjrqO+Ih1Zy7jNct0FMPG4OiaQ8HJZJnYADG4PqR6JvW8eFqW4oT2pUG
cL+1pv2rRUH9usmD0W9lvTpygFCV562BwChfVFxefotUym0XVHKkHjHXIvbD0ofJ
5tiT0Gmt3en0flelPBhJLnDJ1v/EJ4LEdDG7g+ND3gDuluHJNlzdhVQKEqaQ2/lG
kjYZbAEN9IsNYo8SMrmdLoHWk1yNPf0mViXCfOwmZE+hNTbms+y62FfiPGLzftAT
aBM5HFR3GhqkRF/s9xbPGcJvx/SRGU6cxiqUwxeEoyjANcNhLM9gboRbhj8diH+q
BAK7h8jG9sLLUtvLfa3HOVn6wLP3Yw==
=d+gt
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
