Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30728B767
	for <lists+linux-spi@lfdr.de>; Mon, 12 Oct 2020 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbgJLNnU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Oct 2020 09:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgJLNmQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Oct 2020 09:42:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764AE208B8;
        Mon, 12 Oct 2020 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602510136;
        bh=rTaWeqywKyHZNaFmITXkZVv9/PkyyIX816PW7SNWlxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txq0RQbtTjH1t5L8PQng/aUUdcMyaEzgTF+Wdyor97lV/8MLcOQW522Cc7p0+wZIh
         QTgQ6Gds2xMhmUY9a0ADQL9x8mq6x4TVtK/rmyZg/9pVApNdabFVzRmVn14HHBvRTh
         k8+7TagrYe2Q2oWy43gCLXwEkUklTz+syiyCL4Fs=
Date:   Mon, 12 Oct 2020 14:42:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Christian Eggers <ceggers@arri.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Message-ID: <20201012134211.GE4332@sirena.org.uk>
References: <20201009042738.26602-1-ceggers@arri.de>
 <20201009073944.GA11648@pengutronix.de>
 <2670390.HS4A6M72fu@n95hx1g2>
 <20201012132821.GE11648@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20201012132821.GE11648@pengutronix.de>
X-Cookie: Fremen add life to spice!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2020 at 03:28:21PM +0200, Sascha Hauer wrote:
> On Mon, Oct 12, 2020 at 12:59:34PM +0200, Christian Eggers wrote:

> > What is the benefit of controlling the SPI clock with runtime PM instead of
> > doing it manually?

> The clocks are reconfigured less frequently with pm_runtime. Especially
> when enabling/disabling PLLs are involved pm_runtime can increase
> performance.

In particular pm_runtime has support for deferring the actual disable so
if you get lots of activity in quick succession you don't actually ever
disable things until the activity stops.  This can really help reduce
overhead.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+EXTIACgkQJNaLcl1U
h9A2Igf/WNXC40I0lSAeUPBKRg2IXrUnfh2VeWaz5yiHlMmmwFIF9/ZtJWMTVQyx
fXXw3bDDp4zeFexvmfjRCa8hJcF2YCZQ03LH5iq0ME7oxZ48PFZephUgbrL5TZon
8gJeup8UsLcmuNd3gapzw3ZvlRpUWIMOpNJuq9sfkKy8I62eULIKPkNM9xAZ7jqA
T+kTdUrqi9WeiphNu32wFk0aDCn9xKGWTs3msPLDjJDdagbFd4woXbGWl0Hneuwi
wgiSMiHQ5z8JAGq8WNaGiaS+9hXQ45OSP9XfLv3FqAW/+vXVJHyLR3EAW9qDh2ra
vfCRe+uh3oLM+GCLoYwa6Nj0DRN34Q==
=snZ0
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
