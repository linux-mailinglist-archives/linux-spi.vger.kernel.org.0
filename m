Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9602E3F6221
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhHXP7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 11:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236565AbhHXP7e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 11:59:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FF07600D1;
        Tue, 24 Aug 2021 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629820730;
        bh=U8+RW0mVTPZE39+nt5vVJlMy+0Wop2n2o4Ei54ETabg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QE/aBwWkLg4RPWAgV/v8ivnPelaFvUpa4y/Auz4C9JCzXSWkVJBdPx80MCpiHMFwX
         gRgnxwIVpcx2IP52qk9lOd+SDLy00qNlahEXjflKxZdPfddSt6dMrzZmyuz/8lEjx7
         qQzL29rI3D9jVDQeQqWuQfODupcu33rDf9wTMoi2r6cDXBD7tySa04wUVjuKpRCmsC
         dc2RFZD8ZcTgswno6qgdav9yvh+24cbQ2NvP9QHL43U7Q9zU8Gxo1CfaKiieeW/pdb
         nXawyPqadKfKEOLKHk9EvgNZcxU513SiMK4DqI1qs0Fig1YGYLJAljp7HM7Om4QkUA
         zUxWtE41hGTfA==
Date:   Tue, 24 Aug 2021 16:58:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
Message-ID: <20210824155823.GE4393@sirena.org.uk>
References: <20210824092745.2093640-1-zhang.lyra@gmail.com>
 <20210824092745.2093640-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <20210824092745.2093640-3-zhang.lyra@gmail.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 05:27:44PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> Convert spi-sprd-adi.txt to yaml.

It's better to put DT binding conversion patches as the last patch in a
series, there's often a bit of a backlog on reviews for them so putting
them after other changes means that the other changes can proceed while
waiting for the review of the YAML conversion.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElFx4ACgkQJNaLcl1U
h9DbtQf/Vh+leO67pIQqyyEidCXPZ+NLNuwZ+JzRnL2325ufCbh60R9OII20CSgp
AWQOkldMweKQ6kPAe6dTOuEjFfWj0u5EsLLn5gq0grGTs//EWu/v7h6GFPaaNs/z
E6jU+Slqf79MBF6QAd+/GaLImwoGQlIYHqBBLDU4sBIpxa3F1Mx2CJZAmwrsUkCn
5qfe08n5kTcP6/9Ow1Xb65kk9x0fiQM0d4/ucJ3+FD8KB6mZ6yCUXLtuDxd2xOEX
F9zBEhwDm9kUM6NC37uhUCvSld75PITssAY0dPdabn7ah6JbsgiT+u4OwlbgI17y
oM0bJCvTEXOlanADynzvkFsr3irJnw==
=QanL
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
