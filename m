Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E625186E58
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgCPPNX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 11:13:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbgCPPNX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 11:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911181FB;
        Mon, 16 Mar 2020 08:13:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E253F534;
        Mon, 16 Mar 2020 08:13:21 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:13:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Message-ID: <20200316151320.GI5010@sirena.org.uk>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
 <20200316121750.GD5010@sirena.org.uk>
 <20200316143455.GA19141@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <20200316143455.GA19141@qmqm.qmqm.pl>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 03:34:55PM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Mar 16, 2020 at 12:17:50PM +0000, Mark Brown wrote:

> > This is the opposite of the intended behaviour - we want to deassert
> > chip select at the end of the message unless cs_change is set on the
> > last transfer.  If this were broken I would expect to see widespread
> > problems being reported.

> This is unfortunate naming I suppose. I reread the spi.h comments
> a few more times and it seems indeed, that .cs_change =3D=3D 1 on last
> transfer means to a driver: "you may leave CS unchanged" - quite the
> reverse compared to non-last transfers.

cs_change also means that we should add an extra chip select transition
on transfers other than the last.

> Please drop this patch then.

OK.

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vl48ACgkQJNaLcl1U
h9DeXgf+Msgq0Fm5YFrl6BpPbINtM7Fs6PHQdsIBzUMHwaUxzJ476+0jR9ILxEvu
oCl/v/BLaAw/KY/8ThuxaxG4H6S4s2U81tyOzDDJGINf+DIkbsTytxcHzC8fHlmC
cCX7v80+PGdLbNklVqd34sNgTPPiG0GgLUBbFJu4J9ALVA158w4RBYQMVRACaOi7
iqxBkcb2LoZA3d4Ack098jTiyFEbV3yUJGWb3mkOzlvEsoZEbZOG5hU+1YH10roJ
rXsen2GpoQ01/kt0T0qoPSMBPyVSYHcbs3mc+I3JroIo0my4bVTOxvMip+G33jwe
ftkmcl8XS3KCBDNLs08TsBWjugPd0w==
=4bFZ
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
