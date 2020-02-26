Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0816FDCA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 12:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBZLdg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 06:33:36 -0500
Received: from foss.arm.com ([217.140.110.172]:34408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgBZLdf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 06:33:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5260F1FB;
        Wed, 26 Feb 2020 03:33:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C777F3FA00;
        Wed, 26 Feb 2020 03:33:34 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:33:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Herbrechtsmeier Dr.-Ing. , Stefan" 
        <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
Message-ID: <20200226113333.GC4136@sirena.org.uk>
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
 <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 08:36:37AM +0100, Herbrechtsmeier Dr.-Ing. , Stefan=
 wrote:

> I see two possible solutions.
> a) The complexity is handled inside the client. The client uses the
> controller exclusive and isn=E2=80=99t allowed to use the new panic trans=
fer during
> a normal transfer.

Then someone builds a system with two devices attached to a single SPI
controller...  besides, you've got no mechanism for controlling when a
kernel might panic or power might be lost.  I'm not sure a scheme that
relies on being able to control when stuff happens is going to be what
you need.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WV4wACgkQJNaLcl1U
h9Cj8AgAgZNMsG788wJYCsjCMZT2ULX1+Zz3UdAYOGSMyUntdkDcIaWXOX0WfuxR
+meEYXvkm7hq4Hy4jRv+Ate1vS3s9tqDcCYmRK6rxPmHvzXiI4dnuZUqrPOP2UDE
lWsIw3/rx6kdD5W+MOkMSJ3myaX7MoQIOtsAuYkzgxQxJRC8nXZFF/Sbvud/SU8G
baehLUhLYHck0QNzwYVOGk4t30L8+LQy/s34ESDGb+IZ+asuTwj95jyi8MWFrCjI
jq1Y8fCR4sqmZMRat0CxR/RaQr/sm7wG/L2DI9DIUO5wm0dARJp9oA/nBZU8tqhj
KwcLpMFfFuVjnvoGMFNcVgq3IgzTQA==
=5yJk
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
