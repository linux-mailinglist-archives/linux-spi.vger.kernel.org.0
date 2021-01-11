Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB94F2F1BCA
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbhAKRHK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 12:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbhAKRHJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 12:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1585229CA;
        Mon, 11 Jan 2021 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610384789;
        bh=J/sznXZARagNO3dLodSI/Tf4aehRsam4T+NdIpKHdw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFtHG9CDFig8Dgc1ay9WeQXCIuJ7o+op5IZnIBPM6Oq2uTbstWXtDo87WoImSeewA
         GD1nHHmwBNImq0SyWIwwPNgblexx+x9bTKexjBAHoYHfTRU3ImrTpg1Jv8kWOcatoo
         RRbp+IP2d6RWA5a54j/TCaJwMwbfLkjyJfGbLqS0fzAr71+lzDqX4L7dDff/x/RxUu
         czqz3pIphlHE/hypDQlaeIkqIXLyhVWOOPxNBeg70+fIXHm1mw6BPf+rzIJaROmukM
         FJ9tTIjWI5d9mxnG6SPgCyjCx8g+ei+zQcRq+sEIFx57RkAM0TxnL+arckxeX5TfiM
         uVoPWHGPeZNwg==
Date:   Mon, 11 Jan 2021 17:05:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     YANG LI <abaci-bugfix@linux.alibaba.com>, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
Message-ID: <20210111170556.GF4728@sirena.org.uk>
References: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
 <ec735a59-0fbd-3d4a-e997-895099a8e534@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <ec735a59-0fbd-3d4a-e997-895099a8e534@gmail.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 08:41:19AM -0800, Florian Fainelli wrote:

> > [1/1] spi: spi-bcm-qspi: style: Simplify bool comparison
> >       commit: 6650ab2a44268af8d24995d28ae199b57b2ebff8

> I don't think that "style: " is a subject prefix that is used commonly
> and it certainly should not belong in a commit subject. Mark can you
> please people at least 10-12 hours to review changes before applying
> them? This one is trivial except the commit subject does not match
> previous changes done to this file and it should have been fixed.

Honestly for super trivial stuff like this I'm not sure it's a useful
use of anyone's time to police this sort of stuff aggressively, it's
after the prefixes that matter so I saw it easily and I'm having a hard
time caring that it happens to be done as a prefix rather than saying
style somewhere else in the subject.

I will generally hold off for longer with these trivial patches on
things where I expect to see some review but that's felt a bit patchy
with the Broadcom drivers.

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8hXMACgkQJNaLcl1U
h9Dwgwf/YCFcxryTJnVKlTEM26muvYJidZX7j5hFAFMsUOcnTH8Y/TCcHxBx5d6a
NiC7G8gPDrsw8yByKD5NUuDkLWc7fbvjJUQTZ4LxIM+zoT7tC10L1DQAJzoYrDHI
d/5vr5rrHjJERjB0X4BvV9sNyfrbFtbCXZBl6m3bTD4p++rTpLHhzqR6c/GkpP2a
nM7u61sfQCKvp4yLxA1Q389Weiy3z20hs/vbBbWTml3ppjEqUbQlvPkaLpYRjv/L
EzOfirWtHoF286LL3KMH4d4doqSOnf/otbenLl4Bp8ahVc2bOtyklnJwJ6P1iFvm
XopmzF+1B8YnMvt0btDIgydsQaP21w==
=IhKH
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
