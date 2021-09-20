Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846C041175D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhITOq3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 10:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237708AbhITOq2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 10:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83BC760F6B;
        Mon, 20 Sep 2021 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632149102;
        bh=7cDcGS8H3dVH16lHnrmM5SjCWdPr+91GxGQ+fdE0o4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4pyCnG33eGm6pwYU4CfGQyxRPxkIWjJD/Hl4BrjL+/FG3RuRGoXE3Vc4LmzOClR2
         nZrdyOSYKZecUwPaJNfYA62XbP8KTgeNulG6YZwtCTeoYX490WAyUPt5dyolG4ShXF
         UcYgwJRwcQUqqQGc4arypKSeP9MblRKHv+hBJaPZVEZA9sL8cUct0l6uYBIJ6O7oMW
         fq1l7GzJnQoZ9rHzG1J3hK2CMSuMvgkZHTS4NnlxcXCSxffnMrifZ9jA1Cv5ohJUd9
         EbYCMmd2fVmWsEycF5XI9bDl0xaNrqruag0dRfxYYwgkuvfdxy91Uf3lesM+sLK17k
         Zj6909SBS+dBA==
Date:   Mon, 20 Sep 2021 15:44:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        michael@walle.cc
Subject: Re: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node
 name instead of 'spi-flash' in example
Message-ID: <20210920144418.GI4192@sirena.org.uk>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <20210920142713.129295-3-a-nandan@ti.com>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 07:57:13PM +0530, Apurva Nandan wrote:
> Change the nodename in the example with spi-nand from 'spi-flash@1'
> to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
> flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
> so make the spi-nand examples in dt-bindings use it too for uniformity.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFInkEACgkQJNaLcl1U
h9B3kgf8C0+e9onyf5hzlsH/Wy+bz8cm0v2pE7e7Jmbmb9T+l6SG5uVDV5XFg+hT
TRA+OdGbxzmVJmozgcBeJW3rZHyfcv38uWuAJp7iQx6HjtOB5zRskChX76HvZUHE
IlFilNB2KEW33E3eC+vBV8fzzwoG2Uu22OAHLAEIwZJmb+GdeQ5xPeGMuzjhdfva
QCTEAOSopxfcphryTUeWGGLl5roXvR/8QCuySX/SOD7/5IIPmPnNo2mxmc+AdlfL
rMAVTMBlzNvxY7MU2/zv75OEp2dgAixWaw+BhNKA5ns2HaNNTxGpJ1t3/oY0+3H7
VXHvTG5vturPUxiDm/v7b9D5RDzHrw==
=4fpd
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
