Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E26186B68
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 13:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgCPMts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 08:49:48 -0400
Received: from foss.arm.com ([217.140.110.172]:47844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbgCPMts (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 08:49:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81D430E;
        Mon, 16 Mar 2020 05:49:47 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B82E3F52E;
        Mon, 16 Mar 2020 05:49:47 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:49:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Message-ID: <20200316124945.GF5010@sirena.org.uk>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
 <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:

> Correct, the real problem is that I forgot to add a Fixes: tag for
> patch 5. I'll do that now.

OK.  The series otherwise looked fine but I'll wait for testing.
Michael, if there's issues remaining it might be good to get some
Tested-bys for the patches prior to whatever's broken so we can get
those fixes in (but obviously verifying that is work so only if you=20
have time).

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vdekACgkQJNaLcl1U
h9AveQf+LOqJCuZK/In2NusDJBny94rpuyf/MG3uFk4SGh94eJKbw08H9ChimU5Q
c+Coa95XkLCJzoVX6rdw1yjTgAP0n/YfaG3R4rTr24IfwqmZ/ggVl5WVQfdGTk2+
AZKXqBmHiNgK7zizWDT6cH+1fMWbLoJS2mAz3imnwdpiLypTai/zwvb5SH6N0oyS
FhIshW56cRhYj8UNpxwUm7Zr5C8L41rb4Isda5R3fUzaXwT20DdJ3tpYgsaL0NtE
FkEvdxQjg4o3ssNJ15Mdt4yRGHEXVH7cnguTLZhqOogdWLs6NXvPjwtGJt0WVH24
vudvOfP8tvVP1BjdzkMaPg3Go3Y/Jw==
=NXWG
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
