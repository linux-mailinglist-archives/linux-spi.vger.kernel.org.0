Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248272B0700
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKLNut (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 08:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgKLNur (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 08:50:47 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280DC2085B;
        Thu, 12 Nov 2020 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605189044;
        bh=W6+q3fuVHjTd9OQ5HNL9J6IBxQv/Wqz4f3DF+KeN3ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPw2ZZfP9LNeHoxjgqRzDUWPC7XheT7GeL6SxEuJ/rpFFHz66yK8IrhzfsMaCdJwx
         PU885lrsRJU3ZYAUFb/9tWAA1ur/1rGovJ/wFFQGcE+3LvNbF+YX5WJgpRQ3XxVa0X
         4gjqG+WQFofeqo4sV6gLtcA0az5dRGyGsP6ggW2Q=
Date:   Thu, 12 Nov 2020 13:50:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 0/4] Use-after-free be gone
Message-ID: <20201112135028.GB4742@sirena.org.uk>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <cover.1605121038.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <cover.1605121038.git.lukas@wunner.de>
X-Cookie: Danger: do not shake.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2020 at 08:07:00PM +0100, Lukas Wunner wrote:
> Here's my proposal to fix the use-after-free bugs reported by
> Sascha Hauer and Florian Fainelli:

Please don't send new patches in reply to old threads, it can bury them
with the old discussion and can make things get missed.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tPaMACgkQJNaLcl1U
h9CvzQf/Thgajf1q40kV0fGcpfn/T4J1f9vsnby1eHOPgnoOk3hUlW/i7Ncks+Aw
NPK892iEcKQQO0akCR1smz14GRzR6rUjm5zgLyhjXZiU4gAk7DZZw6X8i8A+TwNX
q5+NtCl0GB930NdtYJP89L8v5VL3+guEthnvpoLSpOsFxBWv4opzhtT9tEJD9VDT
zYH3u6uuzL9if2gBG471Bo3McfwQ0y9fzBloxuMd5HEojsUSXzDgkv/on8fQ7c2g
UT9lIbgPGbVHXm3/opCGu6v1I7y5n9t+KNmmxfw0GXbnPzXJMEOs2KWuFMEcZwUf
aHOFmr9oDEq0tnB7vbBIUgUOkNX2/A==
=Ykt+
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
