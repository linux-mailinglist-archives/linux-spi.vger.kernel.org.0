Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822DF44D798
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhKKN4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 08:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhKKN4M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 08:56:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6093561078;
        Thu, 11 Nov 2021 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636638803;
        bh=PC3AED/wdcnjt5pabpXHnmNl8TCQOHZSTsClFTB2r/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqFFiWklf43ktDgHLedObvQNaRHF2KZvKKLHhhlJQwlOYYqnm9nhHt7lXebOp4XSu
         P846cwdwvcqfvVzfsjTuppWppYR5qO1qVVeC4QRp+bpdEUySSxQaUpj+QSgSvU7jlp
         xqtzjaQmwQS4loJzmNTSuTFFmEETO5MlnXGa8kLRJvJIQ+O2PVC8VIeMEaW8L+IjOo
         6H6yaCYbOM/Z1VJUH1l0RUkPcrwkuACdHtOKzn8wupmm2jKUu3/whnp/XG480BqX2T
         sfDp9ZbHmt6Po+zwINsBMp2hP/QmaYnbm3496ANe/1cX5hjGvDGT6sWLF+613IDvrk
         jlFOk8WuDx5Ng==
Date:   Thu, 11 Nov 2021 13:53:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     fancer.lancer@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Message-ID: <YY0gTnvyzdMkCPQa@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RoXBPVi3d1kCLI/p"
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-2-nandhini.srikandan@intel.com>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RoXBPVi3d1kCLI/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 02:51:57PM +0800, nandhini.srikandan@intel.com wrote:

> +      snps,sste:
> +        description: Slave select line will toggle between consecutive
> +          data frames, with the serial clock being held to its default
> +          value while slave select line is high.
> +        type: boolean

This is not something that should be configured in the DT, it needs to
be controlled by the client driver.  Changing this without involving the
client driver will lead to data corruption.

--RoXBPVi3d1kCLI/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNIE0ACgkQJNaLcl1U
h9A1Rgf+NOYvhLV6S/alRWbYsG9Pzw9bVn6Bb7rGS1sYtYZy8CtTGTTbx1bLmVQz
pEANxG15iPKdhzLRbIsh/AMKFXyalptkQYnHvHqLJaKL6AkiOSrkabgyn+1ODp/6
XqkbVvLD2OyUd7PStloxw5TNWLB6dgmvYS5sdYnuniS9qQIEdd7H04HBADcmci4X
ZHc7KsiaHCMIKS8jYvRcYpLJJgXdnEQmJCht53sMqBx0KfygOoUuMti8XzQIdos6
zHrT9A5qxTq8RYukHfmWlo+iLg5/ANXbQ81YoM6NzbOfenqr653avEKoGFXigTMO
4/AB4GtXyZTtS34wOvaAx4btTh4f+Q==
=n+TN
-----END PGP SIGNATURE-----

--RoXBPVi3d1kCLI/p--
