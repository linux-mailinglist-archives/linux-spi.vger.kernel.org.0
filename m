Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7152DD2EC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLQOWW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 09:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgLQOWU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 09:22:20 -0500
Date:   Thu, 17 Dec 2020 14:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608214900;
        bh=li+DKWydczVayV3fxJSZCI/0jX1LlUFmq+sbmhecoAA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWzcqO/nLJxG08HMAcq+J/RobDeiUFMSYkqaSrpHlGdCcpvCbfPoHSsb641h0QXdW
         vHCr5TD/k2BmmUsqDHwt07+h1COwaiYgBC9BYwVbNWc0avnkY/8FKBEGnnGsWww3F/
         RMayt8SOKMi2ag9Hx4CcHa4fs/jGhQfNcuJRRALN5FcdCn1WDbMIuD8pVMfZ0moFGp
         AIOwp/rwVdOCVR8Jr5IvcF3mLhOCILi3IN61DvL5Y7J1Zp2EhNLxkTx3Ll1Sv2ZtxV
         sb7K5yYcDLoVrwnTf+mr3mCXrWphAcC4lvs7XY/NrfohJNQx5ckCRDsn6Qe6ibDqZ0
         oJd1PzT1m0XAw==
From:   Mark Brown <broonie@kernel.org>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com,
        Ben Peled =?utf-8?B?KNeR158g16TXnNeTKQ==?= <bpeled@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH 2/3] spi: orion: enable support for switching CS every
 transferred byte
Message-ID: <20201217142127.GF4708@sirena.org.uk>
References: <20201217112708.3473-1-kostap@marvell.com>
 <20201217112708.3473-3-kostap@marvell.com>
 <CAPv3WKdRM_=t8Rn8LkRWTV2+WGQ3biStjmGXwfQD0z9yKR19jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <CAPv3WKdRM_=t8Rn8LkRWTV2+WGQ3biStjmGXwfQD0z9yKR19jA@mail.gmail.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2020 at 02:56:16PM +0100, Marcin Wojtas wrote:

> Regarding your comment from patch 3/3 that "spi-1byte-cs" should be
> replaced by handling based on the compatible string - do you mean
> dropping above parsing and updating SPI bus mode field with
> SPI_1BYTE_CS flag in the relevant SPI device driver?

There's more to it than that but like I said in reply to the patch
AFAICT we already support this.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/baWYACgkQJNaLcl1U
h9BsCQf+NJk49P43FpdrtvoDtEqZZ8gkVwtUiD1Stb1eBY+PGaFght9DddUn9ZNp
nN0PIUvhdIZgfZ0yEp4kdBAn1XIWexm152D9kj4af4SoSZ/viPoACLUTc2D9rHYB
6ibPBJjBSeYyJmyjf24diZyGc0/mEYxcDfQygwxhJZ04hme2rsrXHJ4Rm8RQNbNN
p0obTAeyKPPVnkx2O3WWqCQtGNPFlj1TxgopOJbzPZcGgPF2gBpZ4mZY+juW4VE5
ti8/K6EWRFPx/U9Syo68WOiV+65CLZ+v71aw659sJzDOwG9Jj2aSThuZtGSwcXIN
8OSIgWfLqZ02Q85ugF2ybdv3FIE+vA==
=1DkE
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
