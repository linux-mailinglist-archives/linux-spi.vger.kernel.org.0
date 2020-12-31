Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190E62E803A
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLaNhq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 08:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgLaNhp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 31 Dec 2020 08:37:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A56C9223DB;
        Thu, 31 Dec 2020 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421825;
        bh=9oiIOqu0e3lAi2ckyUuiATWFM7DoY7Bz0/fXL+Gw6rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyXQ9a/ncvp/A8ZpnWMkNXGzp3TUTrjDxqCkDbH9hB3Gg2ZLM6bH3gL+3tLE338SD
         gCgnFo3NGiU+rIzSOGEAN2jd1yZTxi4AnfKC0tEwe2CyPeJ4q5gsEs06+tVw6ov7QC
         A+qHQp07loGekb2sKdSELqliJbmS+ibYJcOKK80tZ8NRRACzwEhHuT9p+fRduaccez
         yr0AR95o1/+TcF6QdWA1NtoPS8MXsdIELfzdyZab/seO3VRWqocA47oc2ogxVFlmvY
         oS+7oNuDFSgFe1GXjS72m16QJXQIRiQ+ImnFc2lg5JudT9yVdoCja6uB1wHbSgKm7/
         6lFC2iDrW+71A==
Date:   Thu, 31 Dec 2020 13:36:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer
 waiting time
Message-ID: <20201231133641.GB4720@sirena.org.uk>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
 <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
 <20201229131308.GE4786@sirena.org.uk>
 <20201230022420.GF14854@yilunxu-OptiPlex-7050>
 <20201230134644.GE4428@sirena.org.uk>
 <20201231032337.GA7980@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20201231032337.GA7980@yilunxu-OptiPlex-7050>
X-Cookie: May I ask a question?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 31, 2020 at 11:23:37AM +0800, Xu Yilun wrote:
> On Wed, Dec 30, 2020 at 01:46:44PM +0000, Mark Brown wrote:

> > > BTW, Could we keep the spi->max_speed_hz if no controller->max_speed_hz?
> > > Always clamp the spi->max_speed_hz to 0 makes no sense.

> > Right, that's the fix.

> Seems it still doesn't fix the case that neither controller nor client dev
> provides the non-zero max_speed_hz. Do you think the patch is still
> necessary?

Right, something like this would help if we genuinely have no idea.  We
probably shouldn't do it at validation stage which would be the other
thing since it might cause us to realy hurt performance on systems which
happen to have a sensible default in hardware but don't specify a
maximum - we might set too low a default speed for the actual transfer.
Please fix the coding style issue I mentioned and resubmit.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/t0+gACgkQJNaLcl1U
h9DEJwf/crSGJ4AiCxml6EFFAQnO3u1C5ZGjO2DXeQzAVs6SSr1EFClRUfn7Xd9R
lfHl+UjBZxqA/0l0xx5YhGiTWy5Pnux8S4PVmIaQDSVMx97zkXWWsc+fjfRw+B5w
jVquYc0FkmtPJ6qYPWeqLBEkU8SqK/BLou/h9sW49KdSe7vo8aOT9DXjF6SvTBcM
0eDH8ZVuSzT37vLk3FWB7DTKY5BrlW1Vn6NO1OBTu87Gax1/9UPpGl+midGrIR2i
V73MV0bBPMHFv9RQBUS6PvECKB3xsZgp++/szdsdHVVA6HbUszoBDCTouGb+VKw3
xcx1rDEaGFbf8zifGS7u6ZO7zE8S9A==
=EwSW
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
