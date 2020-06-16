Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E71FB472
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPOcJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 10:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPOcJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 10:32:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405D42080D;
        Tue, 16 Jun 2020 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592317928;
        bh=AQEBglD1re8iMCYAQaMZEV0L5h/Oc59pqeZGe0n+MWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTatioz421DPyfsmMDJ0dAiwyraASuHcyB/AL2Lbob4vfzOsFOF3YE0rJDTXxytQF
         aRi8k7mt0M1oWIxm/TDEo6cSf/0wK06U/0V0OEreHv7lqgf/lLHLzcEFC514F3JNI8
         GiUROshXHbbnNAPwMVKrv9iMJot+Kpfra3j5RWUA=
Date:   Tue, 16 Jun 2020 15:32:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
Message-ID: <20200616143206.GN4447@sirena.org.uk>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
 <20200616083856.GF4447@sirena.org.uk>
 <6730033e-c966-d465-9273-75137e7ccbcd@cogentembedded.com>
 <20200616093404.GH4447@sirena.org.uk>
 <48df1997-31d8-06b4-7fce-a3b9b5cfaac8@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tb77rFjxeKqknTuc"
Content-Disposition: inline
In-Reply-To: <48df1997-31d8-06b4-7fce-a3b9b5cfaac8@cogentembedded.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Tb77rFjxeKqknTuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 03:55:24PM +0300, Sergei Shtylyov wrote:
> On 16.06.2020 12:34, Mark Brown wrote:

> > Nobody appears to have ever actually sent me these to me so they're not
> > getting applied...

>    Ah, you need to be explicitly CCed! I seem to be relying on the patchwork
> too much... OK, I'm going for v5 of the core driver/bindings later today
> (with r8a77970 added to compatibles -- I tested it yesterday).

Yeah, I won't see anything that's only sent to the list.  I don't use
patchwork at all any more, even in my scripting.

> > >     Everybody seems to be in a silent agreement. :-)

> > Or lost track of things given how long this has been going on :(

>    Sorry, there was a lat of hardware issues slowing me down. :-(

Sorry, didn't mean to get at you there - this has been going on for a
long time before you started working on it!

--Tb77rFjxeKqknTuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7o1+UACgkQJNaLcl1U
h9B5swf7BAjRgGW/6PvstixkStLyLE2qhXYPaTpGwOwRlKcVNYjTRB8bgLoRJ0ot
T2CYTApSGkdrbN5axybJf/35h75dK856kzoVQ/ubCTWYhHQ048LExVnL/y9XPqHI
8+BT9xLeb9fhIwazCpLrAvjzjOsA6XzzGw3Gyw+f+92P72TT+aAzJBylNnrwpPPO
0sh5k1xdwLP+JOHf8h0pMPRRS6h1Vz1EkSUYpTtqOiR8yaw2XuWul2pAi0Is68qZ
gzV4YTISgTUgUC7piGQv+690X97s20vHzjkFgehLe4Ya8YM4TWp7czj15mgnDPXP
rDcPnxs7ewvEPxv1VOwwdEbUrtnTEw==
=xUzd
-----END PGP SIGNATURE-----

--Tb77rFjxeKqknTuc--
