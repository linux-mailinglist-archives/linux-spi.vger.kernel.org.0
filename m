Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE83F7B78
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhHYRWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 13:22:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233276AbhHYRWi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Aug 2021 13:22:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845F4D6E;
        Wed, 25 Aug 2021 10:21:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 136633F66F;
        Wed, 25 Aug 2021 10:21:51 -0700 (PDT)
Date:   Wed, 25 Aug 2021 18:21:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/9] regmap: spi: SPI_CONTROLLER_CS_PER_TRANSFER affects
 max read/write
Message-ID: <20210825172125.GN5186@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-4-tanureal@opensource.cirrus.com>
 <20210824163721.GF4393@sirena.org.uk>
 <4c604d13-f177-ff75-d21f-27613e1b763f@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Content-Disposition: inline
In-Reply-To: <4c604d13-f177-ff75-d21f-27613e1b763f@opensource.cirrus.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 06:13:01PM +0100, Lucas tanure wrote:
> On 8/24/21 5:37 PM, Mark Brown wrote:

> > This should be handled by the SPI core, it's already relying on being
> > able to do multiple transfers to handle message size limits and in any
> > case this is a super standard thing to do so many clients would require

> For a message with N transfers how can spi core decide what to merge or w=
hat
> not merge. If mergers everything and is less than max_transfer_size succe=
ss,

In the same way it does for transfers that are too long.  If the
controller has a property saying that it can't handle more than one
transfer then the core needs to either combine multiple transfers in a
single message into a single transfer or return an error to the caller
(modulo handling of cs_change).  If the controller can handle the
message it should just get passed straight through.

> but if bigger will need to stop merging and add an address in front of the
> next not merged transfer, but spi core is not aware of addresses
> And in the case of multiple addresses and data transfers, how it will know
> doesn't need to be merged?

The spi_message says what the message should look like on the bus.  The
semantics of what's in the message don't matter. =20

> For me seems more reasonable for the regmap-spi stop splitting address
> and data. Or at least if the controller has some flag change the bus for
> one where it uses different functions for gather_write, async_write etc

This would force us to marshall the data in memory prior to sending
which adds overhead.

> Can you point which way you think the code should go? Investigate more spi
> core to coalesce transfers or change regmap-spi to not split address and
> data anymore?

Like I said in reply to your driver patch it looks like this
fundamentally doesn't do what you want in the first place.

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmfBUACgkQJNaLcl1U
h9DVJgf+IQ1XLd/vG5JtVaMz0sv8hXhBJriORMUmROPFdsV7bG/6T/CVq33T5J9g
YTs2aPbOB/P0TByQ94cnSF9ctQcRUBJ60Qx8jFF6pA0YBgLKfWun0kN7jWxAqC0M
thjuAyHb6hdEenVzrimZ8AM/wc9tXk/PBdY98QxKCWCnEH/47wOUU4sGS+s8cr6o
2kpJ45vpNspbfHlbjCJj3U9gCVzoE5k5Ov7PBRS/A7Q4QVysYlLQanw02SiclbIh
hI+MJF/nnIBKV82JISZUx2fjb4CrnxkS8ujLyfXP9tNturvVrcU2tX/MZQFS/bQh
IpJYIxM3LsJz3sUGjjJA+YlAewREvA==
=IHSR
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
