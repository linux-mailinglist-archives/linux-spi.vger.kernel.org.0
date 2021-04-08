Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9C35843F
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHNM1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 09:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHNM1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 09:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4745061164;
        Thu,  8 Apr 2021 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617887535;
        bh=UkxxqNBKlJ55P8VMwpXP5sFNvpwUPW3grgDAns1lO+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WT3GUcizBOlv68oy+sFxNpCQJMxP770siIVhSiAa3PcSwRRCCt5UYCA+kqinyniyL
         8dfoHqwNkzOAI0FWD23WqA5u2Oii5zAAKh0egy/xjx2RG9qd3PgdoSCRhaE6UXrO6u
         TQg1/ArMGf7gTMoyXGa/LITy+gYNmv9gUOASkGboVdnaP7dL6KI6jCmIpY31Q0AbVD
         OpiPkBO5Gkd1GP4FFr5BxTCBC7wnMkiFBHRX0nyFThv6j51E+x4mPkXno6jIKlwnIn
         0qJUOWTar82hUo1BOwgoyqIdIA6fCsng39Mhf4yBaE2FjES5bIMwnxUeGCDgfv+Dq+
         kX6yqUDjCxhWQ==
Date:   Thu, 8 Apr 2021 14:11:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "William A. Kennington III" <wak@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] spi: Fix use-after-free with devm_spi_alloc_*
Message-ID: <20210408131157.GD4516@sirena.org.uk>
References: <20210407095527.2771582-1-wak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20210407095527.2771582-1-wak@google.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 07, 2021 at 02:55:27AM -0700, William A. Kennington III wrote:

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 660 at lib/refcount.c:28 refcount_warn_saturate+0x108/0x174
> [<b0396f04>] (refcount_warn_saturate) from [<b03c56a4>] (kobject_put+0x90/0x98)
> [<b03c5614>] (kobject_put) from [<b0447b4c>] (put_device+0x20/0x24)
>  r4:b6700140

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvAR0ACgkQJNaLcl1U
h9DWxQf9FuZoEVNDQAMRserLJRVhn6/DB//c7KRBHDyxactPwrQJIEenVgurmpUs
KhSp0yV0H4AuM71aorlegp0JlDX54jLmkvTm7FiM17/qA26eOlVQOZeRiJiP7eb2
5gD/gumnUIHJZ/HMxP1WmFmxULLAChdlBrHw8Jje70JdageWSBVunvKhc8QqiKXb
of6WO8XWjKH43Cc9yVxTFFNi1XoPy6TktCq6sMNaISoQ3dgNrXhsetEPCLquFopj
BOw2ogS9fg7PJ7Y+QCgh5f/rnUQZvXSsCoL7XMki4bsOcWUdt9oUpRfiqnFG0H0L
HZhG4AVVwDUh4lq89ljAXqjcAlD2wg==
=sWeT
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
