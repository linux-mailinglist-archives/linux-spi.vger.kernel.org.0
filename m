Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC026139318
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 15:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgAMOGu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 09:06:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOGu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 09:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6KFeNs3JL0rvY1BgoRK7VKDE3sUTxPx6uvM/wOGZ2Y0=; b=A99ZYAhVVv9OhsChQogilnnY1
        GbC0wKY23VKU5dwFKYEIDClgwCt54tcvUMG0Qmlr5TMmRDMEFxwFk/ZmiDmY2J1VbMkoM2cA9wopW
        LKoaehJEc8bw0RTIo1du7yTNdniOz3M9nVwYS/BMT8FnYWAqNL0Y6MS0BySIA/wESMKMY=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir0MO-0002fp-0G; Mon, 13 Jan 2020 14:06:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9D2A6D01965; Mon, 13 Jan 2020 14:06:27 +0000 (GMT)
Date:   Mon, 13 Jan 2020 14:06:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com, linuxarm@huawei.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, xuejiancheng@hisilicon.com,
        fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200113140627.GJ3897@sirena.org.uk>
References: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline
In-Reply-To: <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> On 13/01/2020 11:42, Mark Brown wrote:

> > The idiomatic approach appears to be for individual board vendors
> > to allocate IDs, you do end up with multiple IDs from multiple
> > vendors for the same thing.

> But I am not sure how appropriate that same approach would be for some 3rd
> party memory part which we're simply wiring up on our board. Maybe it is.

It seems to be quite common for Intel reference designs to assign
Intel IDs to non-Intel parts on the board (which is where I
became aware of this practice). =20

> > In general there's not really much standardizaiton for devices,
> > the bindings that do exist aren't really centrally documented and
> > the Windows standard is just to have the basic device
> > registration in the firmware and do all properties based on
> > quirking based on DMI information.

> OK, so there is always DMI. I hoped to avoid this sort of thing in the li=
nux
> driver :)

Yes, there are some merits to an approach like that.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ceWIACgkQJNaLcl1U
h9BaSQgAhHJyOShaR9eNX0h/1w/gPwom3WJq37NV0iDGPxwM7bufN6CmYlEn2VT5
14DC0ypUzhgmLxSy/+4YjpVoqHfK24ubjJmdQOaYHBDXtUv7C/R+Yg5Rs+SVwwNb
dAL9mO11neDUCRVlJP4Lw3tx8feN0SZeUjX6P0pdx3NQSa/pQSww3ZSwG+PoBgWF
cdwu0JWwvx5k2X5O27NehGYxWXo+alYY3AcVcEsEStyhwpQHYcy8jmE6tP14UI/P
26/o3Nmt4G8zM605sRu9AIJb5eFWtIPOzrisnK0KLkxtbHJfrd/cRrJ2ANSCjVAX
L7YeVR4vNDZ98Wz0z/eg21M6wsb8Vg==
=Mq70
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
