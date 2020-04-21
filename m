Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FDA1B2A8C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUO7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 10:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUO7a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 10:59:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDEA2068F;
        Tue, 21 Apr 2020 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587481170;
        bh=uyT1aLMoqiSFZASoifttJFHl8XFalhQXY/HRvDYt9gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZ5b54x6PEBvfk2CBXWUWG1lbn6HZK0vUI5a4z0vypnlk6sWBXWgn3ZuQKQsRGbq0
         +M5Sdc0840AwBZEuvNWohj71sChwj+1M/0FZUeH7QY3c2chy6Lf+YucZKkTWhvoI7D
         MCzYar525Ub0F3xcQzu/jVBbux6X8HKc+dgPhf+E=
Date:   Tue, 21 Apr 2020 15:59:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists
 only on legacy controllers
Message-ID: <20200421145927.GC4540@sirena.org.uk>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-10-kdasu.kdev@gmail.com>
 <20200421125025.GB4540@sirena.org.uk>
 <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 10:53:57AM -0400, Kamal Dasu wrote:
> On Tue, Apr 21, 2020 at 8:50 AM Mark Brown <broonie@kernel.org> wrote:

> > If this is a fix it should have been near the start of the series before
> > any new features to make sure that it can be applied cleanly as a fix.

> Yes it could can be after [Patch v3 3/9] spi: bcm-qspi: Handle lack of
> MSPI_REV offset

That's not a fix though, that's adding support for new devices?

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6fCk4ACgkQJNaLcl1U
h9AViQf/bQFHPo9FjLFZTBCau3RztJGYN74b26UHdDWiIMJ+X5YamwmzXtgO/f+S
T0WrmGDL4ursd0B2KhmoEguH2wLCNO5GtIeo+Wrat8QDl+6t10veayzpdVB8GJ8G
HNsEBoELbsZ65vmw2isZAtdx6ADSgRkDSfZkIjzip9+5EALsxbGkUTEqh6Kg8tRe
CyOZlYj0QfqUE8gNIXj0rJlHCP1stMaTiU7RRAxiSzfXNXdh+diFFUXTu/KjSFQW
fC2QPMQitnNBoZPw+A7DyIPaGO94iJDD4YzSzzLVz1HEdjwMPSlijtEhPQWjkWsg
hsqoUs0b34snt53dUAGyYBr2lldUlg==
=Bw/m
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
