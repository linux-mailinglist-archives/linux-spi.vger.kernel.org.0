Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0D2CF713
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 23:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLDWrd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 17:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDWrd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 17:47:33 -0500
Date:   Fri, 4 Dec 2020 22:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607122012;
        bh=bsY5NfMnQ8G7v4Ar6KhgpsNhT/fd92SmlhSMiXZm9zo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4Cl75IHI1hixv8/YolFYhbHKnnWDHlHqZmkVFMWKOIYd2UV9HHhouVD0IZbdnrjn
         KMu8r9Lu530EZBtrRMu33J98BhfRJQwXcNqyRH6qI65FmD+bLje+QUxi42PPYcaYFr
         ucoaN3O5QJFgF8rDgCYYdsCf3qUEqtA3yw2PrEKq50b9073/lSZEYXMWZfD6S7HWjp
         9E9t6FLRH/+2Kow2wcgIdoWCI0NibBqBUw3LeTs3/NS7ymkaR1f56V/MUUkK9DpOQ8
         Zc5Jsk0wUm02gL6u1Zb68FIueT3xJNX4sZDpx7Te+KBCqwWLTUqHjgtKK/E2PJcboz
         AJgDXa70c9tTA==
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201204224648.GI4558@sirena.org.uk>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
 <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
 <20201204185223.GF4558@sirena.org.uk>
 <df8d6f25-c8cc-3b41-e4df-8e26c9b93475@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <df8d6f25-c8cc-3b41-e4df-8e26c9b93475@nvidia.com>
X-Cookie: Not a flying toy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2020 at 01:04:46PM -0800, Sowjanya Komatineni wrote:
> On 12/4/20 10:52 AM, Mark Brown wrote:
> > On Thu, Dec 03, 2020 at 04:22:54PM -0800, Sowjanya Komatineni wrote:

> > > Also unpack mode needs to manually put the bytes together from read data to
> > > SPI core rx buffer.
> > Could you be more explicit here, I don't know what "unpack mode" is?

> Tegra SPI/QSPI controller support packed mode and unpacked mode based on
> bits per word in a transfer.

> Packed Mode: When enabled, all 32-bits of data in FIFO contains valid data
> packets of 8-bit/16-bit/32-bit length.

> Non packed mode: For transfers like 24-bit data for example we disable
> packed mode and only 24-bits of FIFO data are valid and other bits are 0's.
> So during TX for FIFO filling and during receive when FIFO data is read, SW
> need to skip invalid bits and should align order from/to SPI core tx/rx
> buffers.

That's pretty surprising - is it really worth the overhead of using
non-packed mode compared to just doing the transfer in 8 bit mode?  In
any case it seems better to only do the memcpy() stuff in the cases
where it's actually required since it looks like fairly obvious overhead
otherwise, and the code could use some comments explaining why we're
doing this.  It may actually be that the implementation is already doing
the most sensible thing and it just needs more comments explaining why
that's the case.

> > This is not a good idea, attempting to reverse engineer the message and
> > guess at the contents isn't going to be robust and if it's useful it
> > will if nothing else lead to a bunch of duplicated code in drivers as
> > every device that has this feature will need to reimplment it.  Instead
> > we should extend the framework so there's explicit support for
> > specifying transfers that are padding bytes, then there's no guesswork
> > that can go wrong and no duplicated code between drivers.  A flag in the
> > transfer struct might work?

> As per QSPI spec, Dummy bytes for initial read latency are always FF's. So
> its not like guessing the contents.

The guesswork I was thinking of was deciding to do this rather than the
pattern being output - the bit where the driver figures out that the
intent of that transfer is to provide dummy bytes.

> Tegra QSPI controller HW supports transferring dummy bytes (sending FF's
> after address) based on dummy clock cycles programmed.

> To allow Tegra QSPI HW transfer dummy bytes directly, controller driver need
> number of dummy bytes / actual dummy clock cycles which core driver gets
> from flash sfdp read data.

Sure, the use case makes sense.

> So, we can add flag to transfer and based on this flag if controller HW
> supports then we can ignore filling dummy bytes in spi_mem_exec_op but
> controller driver still needs dummy_cycles value. So probably along with
> flag, do you agree to have dummy_cycle as part of transfer struct which can
> be set to nor->read_dummy value?

Yeah, or given that perhaps just skip the flag and do this by specifying
dummy_cycles.  Or if this is always a multiple of 8 (which I guess it
must be to do it using normal byte transfers) perhaps just have the flag
and use the existing length field to infer the number of cycles?  I've
not actually looked at the details at all so one or both of those
suggestions may not actually make sense, please take them with a grain
of salt.

I'd recommend doing this as a followup to introducing the base driver,
start off with the less efficient explicit writes and then add the API
and add the support in the driver - that way the new API can be
reviewed without it holding up the rest of the driver.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/KvFcACgkQJNaLcl1U
h9C5Wwf+IgFYd/IG6f/dcoYhADwDmE/1++KpwKFrAKBJEXYM3QMFPfiJR0txPYM9
uOzg0YiE2kPPvRI4BeW+/y6yrM+0tAOv3rVe3RFw+k19aYAZw6o0fiGTe80DoGGA
kGjF7CFkkxM8SdFAmCPgn2fh6VDiWj3PENkxtwb+ZtWV7xTEHhvQ4pZTvFZJ7qSe
blOPDnsp8cByOGBnsNTHE2GJfhxqTCCmFW+k5V2zPcrXcgXab4WOClK1nVo1I+mr
FZldTiEb8JxOjf0g+DRXteSfSqPqM1XZjw3PB/zqiB5/oWhH0PqDcmDI2j2Q/mHT
6s0HUvf3xDbMLhLh8ujctuj5Is02yg==
=k0ba
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
