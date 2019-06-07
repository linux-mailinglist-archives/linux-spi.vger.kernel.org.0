Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA839159
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2019 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfFGP7L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jun 2019 11:59:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbfFGP7K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jun 2019 11:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QfLQNuz62ZkrzG5uaqs9OVf1qsfu/iMrKSXqcbAwsb4=; b=XrmtleJm1Mo9N2a5FeFac8NH2
        jBnOuaePeoMzhVnYoPuIcvkdqUIS9UcsxuYJn+nl0q5CRdiCkY7V2LmtGfP97yIEagTFMaQtdDU96
        WGzYGWeuXUnzWcuSXguPyhZZgUTGa0/7VQOhmARqBuK7O26PyzB3BbrS4v4s1ay05epmc=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZHGm-0002r1-JW; Fri, 07 Jun 2019 15:59:08 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B605D440046; Fri,  7 Jun 2019 16:59:07 +0100 (BST)
Date:   Fri, 7 Jun 2019 16:59:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Message-ID: <20190607155907.GH2456@sirena.org.uk>
References: <20190607155631.15072-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J5NgmdQsYR8vwsNL"
Content-Disposition: inline
In-Reply-To: <20190607155631.15072-1-paul@crapouillou.net>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--J5NgmdQsYR8vwsNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.

Hopefully not since we might probe later on if something registers a new
device...

--J5NgmdQsYR8vwsNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6icgACgkQJNaLcl1U
h9Ad9wf/Wgtxk0TyVloO/xxpWXuSBoddyvwLGPNpQgU0WoznSXy9Q8G9bklGm2OY
YRQr42szaLb26rgpWfS6m73qNGAbroMwNAzOLIasQx4a1vMPVC7cgPqQBQ7rCOY1
lWLX0LsbTJM7lnrYxQVH48TTJtqg8JDAo4JuhrCO0Cd6USMmiBDXP1csXbYcdyLi
7MVQD5N04g2XvMAQ3l0Y8HPU2JmzvIr0lcRRlwUo+Q4ybRF9zoDlPaxvumhmJAam
6tbrW7iZPPdPtBgoAiDEjifXojCwPbfrL1GgUtkIRWKkkDcKGAwzTJvLFR6kVa7l
qL8dkCcwCADNwG/O09b3O+YyD8ksLA==
=P0kD
-----END PGP SIGNATURE-----

--J5NgmdQsYR8vwsNL--
