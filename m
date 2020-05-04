Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB11C3985
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEDMjd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgEDMjd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:39:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E022206B9;
        Mon,  4 May 2020 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588595972;
        bh=i4fiAeh4VhwmZB8llNY8Lh6OdtAPi+dy/P3OUnecCBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku5fmRCL5YRVD2QTwxpGCU8d9ouFCtyGPUYSszI/gPxHdxjerjZibRoZH7s46Xc/x
         bpnM8RMBWhbSY8orOvzHJdbzEORNRrN7ebtGPNnyuRwTO6Ye3j9PLg05H1Ht4DBNy5
         gJWUTKqmB312TkhZL7C7FoMkO034/rztZNCOOFEA=
Date:   Mon, 4 May 2020 13:39:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Message-ID: <20200504123930.GF5491@sirena.org.uk>
References: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504121151.1085-6-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504122614.GE5491@sirena.org.uk>
 <DM6PR11MB3721B4735D3250884A87BC69DDA60@DM6PR11MB3721.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3721B4735D3250884A87BC69DDA60@DM6PR11MB3721.namprd11.prod.outlook.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 12:37:34PM +0000, Wan Mohamad, Wan Ahmad Zainie wrote:

> DT changes for the feature addition is added to snps,dw-apb-ssi.txt.
> Then, I do the patch for conversion. Right?

Yes, exactly.

> Should I send v4?

Please - the code changes seem good to go, they're just held up by the
DT conversion patch.

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6wDQEACgkQJNaLcl1U
h9D8Kgf/Q1vAQeUow/L5PaWPMvxJ71KPWpIPEVh+uNgSJQ1rdY4SEYPdAeF9/WOA
PzbrO+bo567Ii28N8pa5LSJDK77eQQ3TSkunZkIFQCtrZ5VzSjw5d8+MxeNsvTwr
E+u66CDPCQLlmhBMRunN7/tRsvb77Kj0X/QSH4yUYb8lUnckSx3n6g0OC+Vy0TPK
JiwusdqvsmZuYgxkxCHSSMw6lO6jQY9IJ91Jkfpb53yfAkf4Xu/HPuEBKZPtS0ul
QRKf9HxOEBv4xRSdJCawoHXxJS4DBoiPwLVa8OHchlZGGuQV2ueXj7QCoDp2lgGI
mQgdwkCSnuXTd/6PmeiyLLKEU0W4/w==
=w7Eb
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
