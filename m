Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D12220E75
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgGONv4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 09:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgGONv4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 09:51:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BD620657;
        Wed, 15 Jul 2020 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594821115;
        bh=/bT6w4f5A2YqDbGUjn8qK0yZTKezWpn570rvkh4CPno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZHzSmPW6RxO6+AeMs5azY0kFob3acvs6hccoS8+7AaCqxhkGsr1EAz1rTr4OoaTW
         GzdGM7BqSU8L3jkomLXG59g9M1u0axICkVKONip1bH9DTzj+vpwdwVPBR1TUCCYmZQ
         GWmB0C26qLaOYmhRO9Z4B+/MiJTt90IQY5ToZM3U=
Date:   Wed, 15 Jul 2020 14:51:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200715135146.GG5431@sirena.org.uk>
References: <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
 <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
 <20200715113609.GD5431@sirena.org.uk>
 <824b8479-e204-d087-7887-a2dbefa0f844@kontron.de>
 <20200715131033.GF5431@sirena.org.uk>
 <ce532200-a18c-d618-7f73-6f6ac8f8522e@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <ce532200-a18c-d618-7f73-6f6ac8f8522e@kontron.de>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 03:48:37PM +0200, Frieder Schrempf wrote:
> On 15.07.20 15:10, Mark Brown wrote:

> > I'm not sure platforms like this are a great fit for DT TBH - the
> > trouble with DT is that it turns things into ABIs regardless of if it's
> > really a finished thing, platform data based systems were a lot more
> > flexible here.

> I see your point. Still it seems like the overlays would provide a
> sufficient alternative in matters of flexibility. Raspberry Pi uses it for
> years, which made me assume that some generic loading API is available. But
> it seems like everything is RPi-specific and downstream.

Yes, overlays would be fine if there were a way to use them for
connectors like this.  The connectors are a real problem, it's not just
RPi that has their own loaders/infrastructure downstream.

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PCfEACgkQJNaLcl1U
h9ClAQf7BaOgQgQ4X3u/iwrjv7DwfTmsmVKjeYTdVQS2HW1v7PpY8xIHLc+Dh8tJ
Pb87yfYyyk7YPIxjSFVL9Xfr5BObBkmGGRAozk9dN78KFZiWJP4Q08ZLAwzD8prX
+e27N1pSBWlZPIvxDpMe88nQrHVc9Cp8EytYCTU+uZn+IiFCzAE534mMcRgPvrAn
bcYgIWm60d7qDjdQJDj7ByN4TXQmAm0nQj5V0/qqf88aQ7cVk65nvzgun6ExE0ZO
Gng9RRfpmwD4w/6bbrEPFL2AO3jmKb2L48gtRsUBn348nvwGFCJ7dnmVNIR4IAxS
eOYOnjK/EmS3Qg1suU2eW/PJ1CYSlQ==
=Cwx6
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
