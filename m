Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A21EBDB8
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBONK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 10:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgFBONK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 10:13:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0DE206E2;
        Tue,  2 Jun 2020 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591107189;
        bh=eoCV77ebnGXc80BKlBswulqCHVzwy3/Grt/NEStAdkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDExaWXh/vvrizG/Ny8gDiqzvGDrYpQcN8GhkpAzbJzaksTXATbU5SYXNSgvjIlIz
         m1RK0VgQFCQKCw1+n4suuwoqS8qGrXdEP9P8xzpzh1/f4buCReS7qyKO1NhlEhircG
         en3LPCIuungYQaEaYLAnxz/AHEmz2OfRLLpt2Eg4=
Date:   Tue, 2 Jun 2020 15:13:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get
 failure
Message-ID: <20200602141306.GH5684@sirena.org.uk>
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
 <20200602094947.GA5684@sirena.org.uk>
 <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 12:02:11PM +0200, Markus Elfring wrote:

> > The original changelog is perfectly fine, please stop sending these.

> I find this commit message improvable also according to Linux software
> development documentation.

Causing people to send out new versions of things for tweaks to the
commit log consumes time for them and everyone they're sending changes
to.  Pushing people to make trivial rewordings of their commit logs to
match your particular taste is not a good use of people's time.

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7WXnIACgkQJNaLcl1U
h9BIPAf/Qg3X33LluXMNn6+or5b8wx23/eNT76IKOCDLt2nsBUFeX0RTB14vx2Ij
wQwNT/+zdryOjbNaDuuxsRM0DV4SawkJVlaUJ81/HDGRTzyD7LbZwDy7GMSrkhW/
suZlkonuFDGJ07yuMaYGcGykfALQc8/37nX5+WSOX682mHkqnpzIy1uZL231RcLg
hhccjsA7NflG4vQzHy6cdAnoRTVdXtp9EZ50jXdrQjS6BaAtJniAn9B6j7ifz8s/
f3j0pUuLHqkXXY+yP5B8I0QWoTUkFSd/f+LL8PdwG5qfp17iswdqZoutqVwwzsOw
aQeBit3pr2gLrZOVf6/Ehu7Je1Jnqw==
=e8Ou
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
