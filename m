Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A101FAB69
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFPIi7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 04:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgFPIi6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 04:38:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18CB206F7;
        Tue, 16 Jun 2020 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592296738;
        bh=W+dLY/h0ugin9KCsJhw5FBNazpfugknbf5LbmeUElIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLrVx3wZJg3VyThQJ0Dm9odntAftnITMIawgwPKiJPZjcl6k+7vhtA19zRBlnM/UM
         x6JjAXzQTODRMGSry/sSd12RQ+aw7ZqQX7jdRrINejUYTUS083PtKCWb1CtNhzE0UP
         toT4wHhaCizBcfettHSp2LtGrmXVLyOu6pcpFaas=
Date:   Tue, 16 Jun 2020 09:38:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
Message-ID: <20200616083856.GF4447@sirena.org.uk>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NG5rUlMnWRrIcOiS"
Content-Disposition: inline
In-Reply-To: <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NG5rUlMnWRrIcOiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 11:24:55AM +0300, Sergei Shtylyov wrote:
> On 16.06.2020 2:41, Mark Brown wrote:

> > All being well this means that it will be integrated into the linux-next
> > tree (usually sometime in the next 24 hours) and sent to Linus during
> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or reverted.

>    You realize that the SPI driver won't build alone, w/o the
> drivers/memory/ core driver merged, right?

Those aren't merged yet?  There was no mention of any dependencies in
the patch, no feedback for months on the patch and I've not seen any
ongoing discussion.=20

--NG5rUlMnWRrIcOiS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ohR8ACgkQJNaLcl1U
h9B8egf/RFBNEySlBS/UM5c77KNB9UrvQMgNXygzSeeSOVc0e3tlk3TcMziMWc2J
ZSg63O1cg+ohdW/PXzwTJOqDV7s3RTYC22tip5lL41z8lRQ30xzEUGG3Tq3JM2w4
7OPOVqZR8Ef95OpSc4NAyMJQ28zmhsd2IB36Zb8EKjwGkPQRL091bBVbI4FMQGzO
0RqqmKftSPO8oH+vBS2KMhj/qUZz+iX9yOEdATTuMFLhA76cLTbrqhgSb+tZF6kc
L3FzlxQsEU94Dw3312gqeWOpjjkLHPYMz0aDALdWW6jy6McKUWgr2xT9uxt5W+kD
L5Els5Rr2A4PJNoHW3Hd6rm66UtcLg==
=q29G
-----END PGP SIGNATURE-----

--NG5rUlMnWRrIcOiS--
