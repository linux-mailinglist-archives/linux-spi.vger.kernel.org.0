Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08AB1F6991
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgFKODE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 10:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgFKODE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 10:03:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F250206C3;
        Thu, 11 Jun 2020 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591884184;
        bh=KwaNQt8CHB0EhbuxLaFyv3pyqaPwUgg4tG0QM0szqSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0OCEbE4kM0G44R+IPkLOHrhllos+I/kAIXU2VVFnidEhAuAeVDc8opKGAmJOCJrR
         W9HF128ZST0k9gj0ESz+vvc3vDFTMkjak1f9kycjmaPbqNjtqsF+YGjrw6o25UmMuW
         fdG3HPBPTNr23ERnNY1wpUqRr/RxJriluUs32lNQ=
Date:   Thu, 11 Jun 2020 15:03:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 5/6] spi: altera: move driver name string to header file
Message-ID: <20200611140301.GH4671@sirena.org.uk>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-6-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline
In-Reply-To: <1591845911-10197-6-git-send-email-yilun.xu@intel.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 11:25:10AM +0800, Xu Yilun wrote:
> This allows other driver to reuse the name string for spi-altera
> platform device creation.

This is a very unusual thing to do, normally we just have the users use
the strong directly.  It feels like if we are going to change this idiom
we should do so globally but that seems like far more trouble thanit's
worth.

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7iOZUACgkQJNaLcl1U
h9Da1gf+IVsNj1j6qCAsG0ClLwzynb1gwlrM9hM9V225dz0WnVCf+YvdK2cCN2ef
rCAyr1EvGLyKcg+gVV4laDFfkdJFecYWKiyPGCReduMlF2mtJh0G/SlWjxSl2pN0
v5pGgl8vDGT+tTpQcX9uRDLK+YV4RValFuMznvD0TiwifIr7UqLp69Ih4sxtbWeU
vr7mW9Tr6ILMOXo5Stee0Ept06ejaJX4QsoFVUb3cBV+m00V/wnJUX2Yq2M1ejNF
XsHy1J5N6aPng0+XkKZGIXViQ5ySxHFPtQPrt4X14Vi6eoLYX60ovHd7nAD8SK2e
97mUFhJU/WztGB/CN9q1vczboJsoFQ==
=Sc8J
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
