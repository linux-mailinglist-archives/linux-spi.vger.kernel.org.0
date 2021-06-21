Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770AE3AEB95
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUOoN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 10:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFUOoM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 10:44:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134C360FDC;
        Mon, 21 Jun 2021 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624286518;
        bh=UWHY/UcN47baJLI7/YeObX+ZkttlGB0VwRROPQl9x0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azgYrZnORmZHcjr+MooCuAKC3EeOVGVChoL1PCetvqOkXVBJiAonmlxBtoZLTUR7e
         sP5ZUyIOvD94INT3jJDlh8IAByT4LAF5AEOiG3e1bu28HUjLGVljzoJ7il46WUMIhA
         lLOGcR8lpKAkUzKpMmMYh3z6nKloRVJAbatYi8puZHXuSvrh2r7lbv6O6B3FnEplU9
         2H3JVq0/C6KLIOcTPf+GUuWXYH8VTuGv/gv663lfT5ba2ZwFues+4zNt4fNZ67XrZ0
         Oc5fVQnOyVFG9BgC7KdNKIeZG/GNBQ521CFmCnzqr1qHK3Q21w1+4fXag57p+AXnG3
         P+PAXjzbT2yOw==
Date:   Mon, 21 Jun 2021 15:41:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spidev: add platform driver support
Message-ID: <20210621144135.GI4094@sirena.org.uk>
References: <20210527084531.18989-1-christian.gmeiner@gmail.com>
 <CAH9NwWfh9-2+kLoTXJgkVSStb1cHHvC-He5jnfFxMpUngMeAtA@mail.gmail.com>
 <20210616194347.GC6418@sirena.org.uk>
 <CAH9NwWffSZB5xkXJ+1EOs5Su3UOifqn+oJHtCGMs=xWvCW4xbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <CAH9NwWffSZB5xkXJ+1EOs5Su3UOifqn+oJHtCGMs=xWvCW4xbg@mail.gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2021 at 03:57:02PM +0200, Christian Gmeiner wrote:
> Am Mi., 16. Juni 2021 um 21:44 Uhr schrieb Mark Brown <broonie@kernel.org>:
> > On Wed, Jun 16, 2021 at 09:16:44PM +0200, Christian Gmeiner wrote:

> > I replied to your mail some time ago...

> It did not land in my in-box and I do not see your mail here:
> https://patches.linaro.org/patch/449250/

Speak to Linaro about their systems, they're nothing to do with me.

> In the end I found it only here:
> https://lore.kernel.org/lkml/YK9wDd%2F+c1uAjwk7@sirena.org.uk/

Lore provides links to download mboxes FWIW.

> The biggest pain point is that this system controller or the used FPGA
> can be updated via SPI. And
> I see no suitable subsystem to handle this update case.

> That's why I have chosen to expose the SPI device also via spidev.

OK, so you need a driver or subsystem that implements FPGA updates then
- depending on what that looks like the FPGA or MTD subsystems seem
likely to be candidates, or perhaps the MFD for your device should
provide something as part of the core functionality.  All the issues I
raised earlier apply here, spidev is rarely a good idea for production
use and certainly not in cases where there are actual drivers sharing
the device.

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  If there have been
> > review comments then people may be waiting for those to be addressed.

> I am aware of the rules.. but as I told you I got nothing in my in-box
> for 2 weeks.

You need to take this up with your mail provider.

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDQpR4ACgkQJNaLcl1U
h9Ba4Qf+PH41WaBq9wZNKOE1ZjTtGN7+wfby5RYep9tzn5fPAz1IYQuGA2knCur2
KYdhUUVvDbuc3VN5yQArkxzfN0VLyRXqGYAiEeB23ik8Kjz/Hx6643twL8q+VoPN
Wc917WnZkTj4GjtYdj/dnTWI+hZ1M1C4Z8FDIKOWJYDCge0Cov2RPSbDWO7gy5St
BuHC2u5n0QJaR+HQQOHaVPh0k3KJLQHpc7YPq5bofHhpX65Hea8NRE+PQEkfFaJr
2uJTH1s3fngZsbSIEqd49jj2owyZw26IEgX+TuMsPtEfAB9jq+2PNqv2MrLbqaXT
gfoGrlSNWLiW/7chykCXvbdkFOcXKA==
=ymgs
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--
