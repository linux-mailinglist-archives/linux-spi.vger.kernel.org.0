Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69516131BD5
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 23:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAFWvl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 17:51:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgAFWvl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jan 2020 17:51:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B36431B;
        Mon,  6 Jan 2020 14:51:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F02F3F6C4;
        Mon,  6 Jan 2020 14:51:39 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:51:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "dries.vanpuymbroeck@dekimo.com" <dries.vanpuymbroeck@dekimo.com>,
        "anthony.derosa@syscall7.com" <anthony.derosa@syscall7.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Multiplex SPI Chip Selects
Message-ID: <20200106225138.GE6448@sirena.org.uk>
References: <CAB595VxuL+iOQD3Re1PbjP50GD51XuMML8_R6Ku2ywAAHcOcdw@mail.gmail.com>
 <a0171241162171ffac6429d29edfaa83fbd9a2ba.camel@alliedtelesis.co.nz>
 <CAB595VzfMRU4Pejuzi0jODvu9p_mh473-cdK92jxSxk3yPHtqw@mail.gmail.com>
 <2db6a1c2463ca5cf41795b5348e17cfbd7de5fe3.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <2db6a1c2463ca5cf41795b5348e17cfbd7de5fe3.camel@alliedtelesis.co.nz>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 10:44:15PM +0000, Chris Packham wrote:
> On Mon, 2020-01-06 at 08:27 -0500, Anthony DeRosa wrote:

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

> > This proposed patch does exactly what I need to do:
> > https://patchwork.kernel.org/patch/2706151/, but I was wondering why
> > nothing like this already exists or why that patch had not been
> > included in the mainline kernel.

> I don't know why Dries' patch series didn't land. The reason my one
> didn't land was due to some implementation details and the ability to
> do something simpler with a fake gpio.

If you want me to review something you'l need to submit it; that patch
was from 2013 so predates me maintaining the subsystem so I've never
seen a copy.

My general instinct with this stuff is that it's likely to be more
sensible to describe this with GPIO chip selects, the state of
controller chip selects is such that a lot of devices use them anyway
even when the controller supports native chip selects as the controller
chip selects often suffer from unfortunate limitations that mean they're
not actually useful.

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TufkACgkQJNaLcl1U
h9DY5gf9Ey9Cx3vviBl/VgE4d7KdqgHAeFFQId61b91GhZyC2lYi0zADQfViUXGp
yXS01T4rA97hOYcGej7ryr63OdR8goERMtCz3Cxxwgcx92JSlyU0jDsmF+HQ1CC6
tQypSMSeduWrUx7ETJlK7jIruU4QrlKV234fg8hmpd2ar9NbUcnp66wsMkETd8p/
Bpl2J7eBVGVLn2xIc3x8htgLHHluSDDaVKXzEbzS+knUhilfk0GzMWJCWQIWLYHw
IxiOzb4wTcKwcXa0qOe+KOLW56SHv+t5Z5FQ+tNb+j70rqNEKJbpMpakCunUWuT0
oajV8VNGug+3e7YrPM2A1q6yxqL7BA==
=cNh2
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
