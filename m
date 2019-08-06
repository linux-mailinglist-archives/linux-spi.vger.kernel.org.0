Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378DF83133
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2019 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFMQQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Aug 2019 08:16:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMQQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Aug 2019 08:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qhMVapevkt7GGro5itwqbhs4kgXV6GMbDr4EtrsfY3A=; b=R7lP8lCrLZjQLhSWdDBL6I5Vg
        q8RWHe5JPteLEB8J4Z5ZgzeVYAp3RkzBPa7STUdzYAgoc7z/w+yBYZgYa0c/aExgGREJdhsyeUWCK
        JtXFr91mQ3reSbuCghmkUdjo9g3MlBepLvRAMKWR/3Dzim5xky+daS6F5wpllsKq3Dpus=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1huyNx-0003Mg-Tf; Tue, 06 Aug 2019 12:16:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 575E22742B67; Tue,  6 Aug 2019 13:16:12 +0100 (BST)
Date:   Tue, 6 Aug 2019 13:16:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Message-ID: <20190806121612.GB4527@sirena.org.uk>
References: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Cookie: All men have the right to wait in line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2019 at 03:44:34PM +0530, Rayagonda Kokatanur wrote:
> Switch back to BSPI mode after MSPI operations (write and erase)
> are completed. This change will keep qpsi in BSPI mode by default.

Why?

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Jb4sACgkQJNaLcl1U
h9DgGgf/XDjuMvbF0gxlnycvschMI54KdALlicilAY/EdgOqMP0nYuI2Aq5ajfLW
iyCZuqnv5yB8zvfCmgkQDpMHCFqvyzOD+1e0uaHzW87GiksgU34YADpCjdhYc+Qw
Ji2fr1lH0NCiCPeMc2ATQ+r431RO2f05Cgo1eUIdtdYdIMGeRt8r3NUbs9P/pTgf
SFvVWF8s+bb3nsQKiLizNjCCzBAjzPcKsxkKIlwYMu5v2dlQQJUVQNA/Wrs6bada
FRHWgV5N1VCYSAWxTG9X0nK9prvb6U2K4RLn4Sx4KQjG9+dXIcON3yIRjqCbIyCg
jWPS/FWELxU9yNtO0ja47BfU2zbm1Q==
=NEaP
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
