Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED4F24C44D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgHTRPK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbgHTRPF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 13:15:05 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7623E208E4;
        Thu, 20 Aug 2020 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597943703;
        bh=uHl9rwumtu2rtih013lnF70L1ucw8l6/5BB+iJYt+6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7cEqDiMm+cN7TjgJG5SkIhf1Loo+IeVMmngS+zPnVPMf9ef31TtQbGTXrkeeJ0L0
         b0GudN+PV7zktBqe4YHYycKROj+Qidfnd8MLoqcG0y+eZqb4FhMTf0DjAQM+ui36Bh
         WnXYpM1GXgAcnS5XzjEViczd1TXeuxuHMKD+5lkg=
Date:   Thu, 20 Aug 2020 18:14:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 4/7] dt-bindings: fsi: fsi2spi: Document new restricted
 property
Message-ID: <20200820171430.GH5854@sirena.org.uk>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <20200820170228.42053-5-eajames@linux.ibm.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 12:02:25PM -0500, Eddie James wrote:
> Add documentation for the "fsi2spi,restricted" property which indicates
> a controller shouldn't sequence loops and therefore has a smaller
> transfer size.

In what situation might someone set this?  It sounds like a
configuration option rather than a description of the hardware.

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+r3UACgkQJNaLcl1U
h9Aq3wf/SqHPeYRrE3/ONd0Rh9Ufbay8ktjHb5kTNGZTI498NUBHdxCLAkaWuc2m
j+xGVCPGzSrjMA88WwQkzqiDA+KSO0oSzmCh7Q3U6sY24upbJVIWBltKfMJ8DOd6
A5qWIrI+m63MY83W1qQ7mO0dtd5U6b2cHwWKX8DMMdo3gqTI4FrkABHAdyDb3mdu
9WEdsck2qWf23Z3SQTxBlTdCmTeoA2Pm6vcj7hOuJ3nM6mO0d6eCFATIFGPL5Eai
7zLRyvoUt94GM/sSddLCwSwMfO1RtIxHPjX4+dJSMSEuGmcgCQY+nd4yO4QqcDjl
MZ9zDEDQkkbRoZWV0Fq6LVqi3NTvJg==
=lis6
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
