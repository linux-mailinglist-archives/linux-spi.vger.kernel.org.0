Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D4E9BBF
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 13:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJ3Mq7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 08:46:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ3Mq7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mW32HZibqG8H3K2JKkGCdsKcxIGadKsZxcs54R+3TNg=; b=OIIPsMbik7Ryd+/KbsB6TfANA
        Nm7J4mmL3ezX8Xx6GeADWOfxzTdDjUZY+N6PNjq0zSCKdZOYIu1lHVr/uC5hezbbe4Rf1ZaKOdWpH
        +xVmQOpnRnoGJMzLOksE4TOznygPLKgqandaybBxhJFQ9mIr4yMMx6dBUQEa1bNVetLMY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPnNG-0004yz-MD; Wed, 30 Oct 2019 12:46:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EB34C27420F4; Wed, 30 Oct 2019 12:46:53 +0000 (GMT)
Date:   Wed, 30 Oct 2019 12:46:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH] spi: dw: Remove runtime PM enable/disable from common
 part of the driver
Message-ID: <20191030124653.GD7218@sirena.co.uk>
References: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
 <20191030113334.GA6693@sirena.co.uk>
 <57a61e72-f815-f5ef-885a-cd112c471140@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <57a61e72-f815-f5ef-885a-cd112c471140@linux.intel.com>
X-Cookie: Celebrity voices impersonated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 01:47:42PM +0200, Jarkko Nikula wrote:
> On 10/30/19 1:33 PM, Mark Brown wrote:

> > This will be because they look like already applied changes on the
> > branch...

> I see only Phil's 1e6959832510 ("spi: dw: Add basic runtime PM support") to
> be latest for spi-dw.c in for-next branch.

Weird.  I didn't do anything explicitly so it's something git decided to
do for itself when applying...  let's see what happens with this.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl25hj0ACgkQJNaLcl1U
h9AiUQf+KAUzS1yuCjKlgfnFr6JyNcLwLzKaTHPH2PbH+iv2DqsaK4EGjdb85arV
RFbc3E6zH1BFQ5iXMuuYWz0jLY16WnxiagTe30WOgxSKcRbEauDqc2EBwSRPdolS
qhzVBlwbyFcULqrgsNCsJJVvabqgIpyjEFQyBbGzZg2JL4oErNeONgGMPhNf0Mdx
qY80eVGUc9EIELAjtiV04ql+FDdgdGn1TSu1P90e56llhBJYxu/PKTBYkOOVTsa7
LYjtdXxKS99PLj41GpSFYqSXmlLgAFnayu38vQ3tuw+bjx9l1Ha3qm5MAAOtJDZd
XSFKrBKDDxO6URgblU1w+U1+ZuNjrw==
=0TsS
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
