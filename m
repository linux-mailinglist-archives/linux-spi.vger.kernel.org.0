Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD603CFA44
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhGTMdG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Jul 2021 08:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238415AbhGTMcf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Jul 2021 08:32:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66AFB61106;
        Tue, 20 Jul 2021 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626786787;
        bh=al7tI0KVVLdEI4uEKfWFTCtxVhUgyhsr1HgYUh500/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dlu6Q+ySyWZD/KOuzvnza5z39lV+sx/aVol9fNomcLzbau6nuEWQ4LKJ8WvHxRgFM
         iAfLf4SxCoqV2s7L19ynzMrcOk4oPJzPfAK9bNwIEPMaotlhMhcqt9EyA4phEjyoA4
         g5s1Qtgj9z53VBqvMQVhCRoQ6TmP7anJTwRknLd7W0o34WL4x5E3Aoa/Kv+PwkKXZz
         hGW5yFzBGaDaAt48sLWTDNdN4hOwbJtfcHay+2TbXIKgMLJU4McVc2ddm4VvL1Nq2p
         xSZSInGNJkpO77wcCmuWjyTqBeAdZUqVrenD8uEXl/dEIHR0q1Pn4wnd6JuFTjX6nx
         gc2SAuESGV84g==
Date:   Tue, 20 Jul 2021 14:13:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Eddie James' <eajames@linux.ibm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: fsi: Reduce max transfer size to 8 bytes
Message-ID: <20210720131303.GB5042@sirena.org.uk>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
 <20210716133915.14697-2-eajames@linux.ibm.com>
 <20210716171936.GB4137@sirena.org.uk>
 <81a40f8690d297ebfb6697dbea63279bcf2f24fa.camel@linux.ibm.com>
 <20210719152010.GB4174@sirena.org.uk>
 <d2e07f0beda57ffeaa31e8cf5bf28edfbd982e58.camel@linux.ibm.com>
 <0a637d7704df4303abe783215080578d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <0a637d7704df4303abe783215080578d@AcuMS.aculab.com>
X-Cookie: Revenge is a meal best served cold.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 20, 2021 at 01:04:38PM +0000, David Laight wrote:

> Having said that, you might want a loop in the driver so that
> application requests for longer transfers are implemented
> with multiple hardware requests.

No, that's something that should be and indeed is done in the core -
this isn't the only hardware out there with some kind of restriction on
length.

> I do also wonder why there is support in the main kernel sources
> for hardware that doesn't actually exist.

We encourage vendors to get support for their devices upstream prior to
hardware availability so that users are able to run upstream when they
get access to hardware, this means users aren't forced to run out of
tree code needlessly and greatly eases deployment.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD2y94ACgkQJNaLcl1U
h9CU5wf/TxYsQY9aTbblj5w4EVv8uLKbvy6PBj1SnrM4wfytzyTYihrRE6uCLTAS
Nn9FkI1moqB5RREdDHk4HKQOiZQ2SD5FZn9jM5VV74hMRgyU70vk6DcgobQVYS2h
YE23Evtq4wcxvTHbPHhZcYYj8NcoUbsbabuGB8smW5DU0qP8uVe8T1bTPcnBWE6g
fXVdzjeRDykoTPTariCs1V02ZdqORUtSJF1TXJPaI2tLTqPEoBNPJzx2fgocdB7D
jK1YKiTQV/TI+GED/c9cbvs+QW/uhBcJ7WVvqHrDcg8JnpRwVPp0K/x61vX0VeLq
AN8yydmcf/WWsUCHBc1fwemQYA4WBQ==
=Dkpn
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
