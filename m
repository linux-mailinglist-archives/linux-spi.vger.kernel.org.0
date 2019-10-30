Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2EE9AD7
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 12:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfJ3Ldl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 07:33:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfJ3Ldk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 07:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/yC7rc3ICYIiVvJnwOMAmhVT5UNkYFhGQmUy97pmbG0=; b=iGWV1IFDD6anUoyPD/gJ75nCI
        8bARNA3ppX5+74wEISzzYBx51kPW3S49zvhTSMTtYRDk4DKi5S86AVw5wTh54DPXHu4KQzvaGzfZ+
        zgrVBLyfI9jgdYPKC69wQ97CzuPIR0M+ZJnR7ccCt84JrbP3jUC9hS0qACMNd5MPXWEts=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPmEJ-0004ot-S9; Wed, 30 Oct 2019 11:33:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 79DAA27420F4; Wed, 30 Oct 2019 11:33:34 +0000 (GMT)
Date:   Wed, 30 Oct 2019 11:33:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH] spi: dw: Remove runtime PM enable/disable from common
 part of the driver
Message-ID: <20191030113334.GA6693@sirena.co.uk>
References: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
X-Cookie: Walk softly and carry a BFG-9000.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 01:31:37PM +0200, Jarkko Nikula wrote:
> Committed version of the commit b9fc2d207e54 ("spi: dw: Move runtime PM
> enable/disable from common to platform driver part") does not include by
> some reason changes to drivers/spi/spi-dw.c that were part of the original
> patch sent to the mailing list.

This will be because they look like already applied changes on the
branch...

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl25dQsACgkQJNaLcl1U
h9Dougf+JLHZn4+vrlPAS0ndjsbwl63eaN09KrittDvjx9giYOIofJ4Lb9v9tljz
SG6TEMs9SAuwrSXcnm97rSe9pAc+kr0fGNJACmfbe88FYxWiqCuoeM1qQ60eBT8B
4dkES9SKVmeCcx52I+nglxYdDx4ACtjzgctbJNFIhVb2gF6wsrq3EM5y1/+StH85
cib48F65SMoUs/OJptWh1o0oyA4iqdjnkR4MHkSfnQUIot/xrAY5tAIQXxBIYZ6/
g3kHtznUpcle0tLkSz+0Ptz6sJPp5/xQ0jGkPhrSjjEOfcTxf9FQ5i1s5t1siCNc
KYfc9k81dlrQH0tBPuvxFQUhP46hUw==
=jmtK
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
