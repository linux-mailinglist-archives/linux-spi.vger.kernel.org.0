Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13683F62D3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhHXQkE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 12:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhHXQkD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 12:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC6B661183;
        Tue, 24 Aug 2021 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629823159;
        bh=grPffO/AYJoyOT5FvaovgDQ2otCA+lgEQi6Zpr0dwOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kg0rOWG0mpCHP1hYvApS13mg8W91KSr802Zm3OmGjeTvCEXlssWODJxXchovz/BbX
         a/AyY34qid54WM3HsJmcrRuCVJGCyJ/PPgOcawrwwQXHIdftB+LYSXUMD1nWoHit25
         uYadWaDrc3a2sW/nShZkotkPg1ydkoy3TPnb6SdcYcNdFs8B4fC1ghgeuamA1CTvcG
         LK8IfIzTi8dC30+hql4RXe2GGIQSPbz2/wUw67JPF5qys8HhKW1xYwO51DuA+F7i/6
         1Z5olpIhoXd3haI89F/0v812b8C1yUgafdu4GB2z6wYu84VwaoSmKDYl12Y0FkaH24
         oRSurtytDPXQQ==
Date:   Tue, 24 Aug 2021 17:38:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/9] spi: core: Add flag for controllers that can't hold
 cs between transfers
Message-ID: <20210824163852.GG4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-3-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-3-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 11:40:34AM +0100, Lucas Tanure wrote:
> Create a flag for a controller that has an automatic cs selection and
> can't hold cs activated between transfers
> Some messages send address and data split between two transfers, see
> regmap-spi, and without the cs held the data loses it`s meaning

These controllers just plain can't support multiple transfers in any
useful fashion, the flag name should reflect that as well as being a bit
less long for legibility reasons.

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElIJsACgkQJNaLcl1U
h9B7bwgAgzR4kI15DF4rHzaLfxoVt2tdfkCIdWHsNwWmD3IzicsD8pwNbeZfNhPu
HBwdwYzlfSZzYu+bDktqdHK83rr5UX1XKqzSysXzDIn/qtw4Yp51OTUBEo01XAJr
PzGTuPqLiKCjHXFHEgJ7APM+clI0vmi2oTbIjn5ffnSnxJLEyslR7FZPwXFZILil
ChBrzvoBTXQh2wyeT+El7v8EHdM0tL5mel+eVvi09jGwnny8MR749TZVy3OXiRG5
WhHWJZgYSMDa4fr86/u4J8jTpX/zS3AJGCZkPenQ88LN5kCwuTW8eJh47AuXMEqn
lUdSEo9Q5Umdw8fNWd1SaGH1+derHg==
=eRBm
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
