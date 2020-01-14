Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3D13ADC1
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgANPfQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 10:35:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANPfP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 10:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TnevzhVUZF4pyGCopDfMXcwhuhw/gLXqKk9L1QZKo8Y=; b=OfpfFDbwC+s7nxwz+wOkEdDGR
        pRZxN38c9nl2FWne4V8pximq6dGeG1L3rFOGWY3bz8QR3EpC7b55OK/qApDpSmeRwglL5ACd/Xjxp
        DY1Qz6Dbr5/ywscSBhqCrLy7KHZbvbEwBeAoNNiAhQvhUWNXTjzQORNayiNpx+u7N3aWc=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irODk-0000DR-LB; Tue, 14 Jan 2020 15:35:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 48FC8D04DF5; Tue, 14 Jan 2020 15:35:08 +0000 (GMT)
Date:   Tue, 14 Jan 2020 15:35:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] spi: fsl: simplify error path in
 of_fsl_spi_probe()
Message-ID: <20200114153508.GY3897@sirena.org.uk>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
 <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Content-Disposition: inline
In-Reply-To: <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:17:16PM +0000, Christophe Leroy wrote:
> No need to 'goto err;' for just doing a return.
> return directly from where the error happens.

This doesn't apply against current code, please check and resend.

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d36sACgkQJNaLcl1U
h9C3zQf/cMvkTc+QF3yMKYXxlmxQDKATcaQNF7uNysSG2s4+eOCqDd8drWV92HRz
AM7/spEm4cUKbeKJNtl5fXAnxI89PdE/e0bDH316EkA5L7NOJAI2dGjHDVJcgKMu
azrTo4dbu1+bt2JXOtHrTO9nIU8IRbQL9QcuLG/52cqD0wB3xWb4LE6ToQftfMoC
+96ALK3iJyYK8dhJI4Ip+oXBQGE2Fu2YU/C1lTvHnsrgqwnolt2u9z+HEXGu8rkE
DGmxnns+uSmLrCbSETb5ooxW3GVnis5IlROQKGBXZ+LDdTA41owEQLdqXIaeaIDu
Fiz2D//oT5xGwJgH7rM8LpEcSnodNA==
=EOzq
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--
