Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5347DA3D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfHAL1D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 07:27:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAL1D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 07:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Kc+586cLBp8zFGNgc6TDcOHIhcpqIkYJZtL4/ooZqg=; b=CPeTun1XF7sNP7Qyt0LL/i7UK
        zUTT1p/jffhHQjvpzucB2OwPo/BCwvIFfXhNPsoXQCrPQB90Nr3WbGL5ONHkPWGAHirP0a8REBRa4
        M+g1kA+3hBz7s8EOQdpP9g4UPJiu8krgXPd5VSQPq525TzGO513JepWewd8/m23JOQwsA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ht9EW-0004a7-C9; Thu, 01 Aug 2019 11:26:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 43FAA2742C47; Thu,  1 Aug 2019 12:26:55 +0100 (BST)
Date:   Thu, 1 Aug 2019 12:26:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Message-ID: <20190801112655.GA5488@sirena.org.uk>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190801111541.917256884@infradead.org>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 01:13:53PM +0200, Peter Zijlstra wrote:

> The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.

I don't have a cover letter or any other context, what's going on here
with dependencies?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1CzHwACgkQJNaLcl1U
h9Bi1gf/R2RBFRK38yt4CRZFig5dJ3Fm/3wsfKj5hFNGFGrz8KB7AC0KdnjuX6wf
IveemuHcUiCpATP7HwY3w47Z6DFlFJSYaXFce8ku9+i/jmJ85e82GbikQHndMSqd
l3Kv2hC6y9wmWRgr2GJ4isTtRIH9vPei9nHWaGGUmkLwZQnphY7pbPLx+GPFBFHt
gIRwDK2kw4ivbCJrS6uwaXSlXPIKu5SxVF6o0kkyGUb2QxdlzqnuwxUQpoX+r183
iebAuHWZJEheKQtd/+yhAbSH8rGThdQ3sie3Q1e8KPf9Coc8RteL58NV47RFyYQj
B7gEl66Otu+l9uYADgMTz+VsY6d+uQ==
=tJYV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
