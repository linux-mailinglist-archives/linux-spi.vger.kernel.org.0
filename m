Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7384318300B
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 13:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLMSS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 08:18:18 -0400
Received: from foss.arm.com ([217.140.110.172]:33424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLMSS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 08:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106EA31B;
        Thu, 12 Mar 2020 05:18:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877583F67D;
        Thu, 12 Mar 2020 05:18:17 -0700 (PDT)
Date:   Thu, 12 Mar 2020 12:18:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
Message-ID: <20200312121816.GC4038@sirena.org.uk>
References: <20200312113154.GC20562@mwanda>
 <CAOMZO5CJ7G7yJZEEPfsm1P2SnrJ7kmOPmZCWiKwrvDZjPNOnWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CJ7G7yJZEEPfsm1P2SnrJ7kmOPmZCWiKwrvDZjPNOnWw@mail.gmail.com>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 09:11:44AM -0300, Fabio Estevam wrote:
> On Thu, Mar 12, 2020 at 8:33 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> > The commit message for commit d166a73503ef ("spi: fspi: dynamically
> > alloc AHB memory") is not very good.  Why is it necessary to allocate
> > the AHB memory dynamically instead of during probe?  Also I suspect that

> Agreed and I made the same comment during review:
> https://patchwork.kernel.org/patch/11361581/

Indeed.  There had been an earlier discussion of what it was doing IIRC
but it didn't make it's way into the changelog.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qKIcACgkQJNaLcl1U
h9BqVAgAhEVYC3gX7h7lG4zaL2N7m2EahKxIbHvpVFZF1cfdBiKQgF8Mj7ARC9Ll
rHHP0vQkgrHYVy5tmZJtF278eNq/QWAfgNOD17NDPiyd0HfL+tdnTmefLkSvzroE
E2cVcXprfYn6sasUvW2EF5iufc3XSKBSV4UrSKFjGSiie+lNxIzFj765PQXvS9gt
Va99+r5e5nTRRp3YUO/8cKTALx69BhK3qBFTAqG3HC9dWOxaftL3lxo8ppiKrrIO
+D2/CSOPqU+3kLlqrMWXxVs/oJVWg2QneYZP8DU4AOLQ6HjFXnYlkETS4V6uXBKH
0RcRBTtnwURqpgHOrIFN1ZcdlEmbAg==
=oAWz
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
