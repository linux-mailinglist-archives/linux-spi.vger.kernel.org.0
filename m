Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091702F1C5F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 18:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbhAKRao (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 12:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388941AbhAKRan (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 12:30:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6950229CA;
        Mon, 11 Jan 2021 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610386203;
        bh=cEDPgWBcV1eG6A810kf7YJix0zQoEh8qWmqu3iQAKDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNDOX7RfPsMz1dYqXVJFUJwAqBq32G3EpVlRMJy9O7/7wifhfFE8FeGhtNSLzod9F
         Yj6HlFzR0Vm/pcQDdAuYBkET5taZoAV5VAWQk/cgbbo2gtoLTf+pSRvN0+zgtnhkd3
         bm1VYKBV7IYuvdwKi7Qkeb4thSAwBZSZROy+NKy5KcHnbmxRklUHBdzZTbXvdlMxhO
         GAFg5waGzsvtgZPDzYP6hnRX47d0pe3wn/r1A67mCQTrs58+yIe8R8kv890TmoF9PA
         xfKiV14qqfsf6sHiTLbgvJsWylf99j/xEeR0bPG3gMH0A2hEpzuMNiPFjzyR3MJoDX
         f+0MAeNunrpmg==
Date:   Mon, 11 Jan 2021 17:29:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     YANG LI <abaci-bugfix@linux.alibaba.com>, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
Message-ID: <20210111172930.GI4728@sirena.org.uk>
References: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
 <ec735a59-0fbd-3d4a-e997-895099a8e534@gmail.com>
 <20210111170556.GF4728@sirena.org.uk>
 <32b6ba61-91a8-ada3-1c8f-0e85d330f27e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <32b6ba61-91a8-ada3-1c8f-0e85d330f27e@gmail.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 09:21:11AM -0800, Florian Fainelli wrote:
> On 1/11/21 9:05 AM, Mark Brown wrote:

> > Honestly for super trivial stuff like this I'm not sure it's a useful
> > use of anyone's time to police this sort of stuff aggressively, it's
> > after the prefixes that matter so I saw it easily and I'm having a hard
> > time caring that it happens to be done as a prefix rather than saying
> > style somewhere else in the subject.

> That sounds fair, however it does look like people who submit trivial
> patches are typically the ones that also tend not to follow prior
> commits to the same file, and given the patch is trivial, enforcing a
> consistent subject sort of offsets the less amount of time spent in
> reviewing the patch.

Yeah, I do tend to moan if the commonly used prefixes aren't there but
I tend not to worry about anything after that.

> > I will generally hold off for longer with these trivial patches on
> > things where I expect to see some review but that's felt a bit patchy
> > with the Broadcom drivers.

> OK, we will try to be more reactive then, Kamal is in GMT-0500 and I am
> GMT-0800 so it make take a bit of time for us to get to our review backlog.

To be clear it's more that if there's generally a review of any patch
within say a week or a few days or something then I'll hold off until it
materializes but if it's likely to time out then I'll tend to just go
ahead immediately.

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8ivkACgkQJNaLcl1U
h9DtKQf9GJriRIMZQ3/g444Eo0/Jusfm/BRirkkkCcEl07tf/EohMvuNO1AjJkiZ
tm1pMV58W4vtNOYt6XWsPhlwPj5lm2gzBoEp3iTBvrZ32QMBZ+MrVTi/5PGPpZ60
K7Q3lQXy/wX5kZJE7xBWGSKejdTwAbfTOzfJvjbf90xM8zgZ3SD0ftsNooQpVtdE
NnXx6IuJkXM8frb/t7H1mNv/Ea/86QZbCmIPhyfRwO7u+huAGjuw10ar4wrFR+Yj
bpqEUnyC0F9gcQgtVVFLZDOrYuDzLy5ix38CT+21F+eu2pOMfEIAmt9+rB9VOBf7
a/OLezi4fobdwaaU4sXrn0HbgemE3w==
=wJfD
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--
