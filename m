Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E224262C5
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfEVLJR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 07:09:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfEVLJR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 07:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nzhXhsNahZAD2GGHFwC63OYGOeO5cNATHP2gOm+rReY=; b=wE0k9QLii9XBjOkByBbs3BCdJ
        HVjZA/0mGJxXPDJnD1o8MbK8YM4cxCG9D7mfHWKl+OGpkc9q/chMbPyhrvYZhkmrGXOt0sl6+FFrS
        BVpyJbnHZOSeuQL7r/QTA20mvMv5K+NofHh8iCHmGpgQ2bZejn/QqycqQ1hpu1LiCn25M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTP7K-000454-Ly; Wed, 22 May 2019 11:09:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 390091126D0E; Wed, 22 May 2019 12:09:06 +0100 (BST)
Date:   Wed, 22 May 2019 12:09:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer
 platform
Message-ID: <20190522110906.GD8582@sirena.org.uk>
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
 <20190521115958.22504-4-masahisa.kojima@linaro.org>
 <20190521181609.GB16633@sirena.org.uk>
 <CADQ0-X9yKQ2akerpxKfjxOxmRhPiaaxe7ALDO7VQiH+-+SHo3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <CADQ0-X9yKQ2akerpxKfjxOxmRhPiaaxe7ALDO7VQiH+-+SHo3w@mail.gmail.com>
X-Cookie: Does the name Pavlov ring a bell?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2019 at 05:27:23PM +0900, Masahisa Kojima wrote:
> On Wed, 22 May 2019 at 03:16, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 21, 2019 at 08:59:58PM +0900, Masahisa Kojima wrote:

> > > +     ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> > > +                             0, "synquacer-spi-rx", sspi);
> > > +     ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> > > +                             0, "synquacer-spi-tx", sspi);

> > The code looked awfully like we depend on having interrupts?

> I"m not sure I correctly understand what this comment means,
> should driver assume the case interrupt is not available?
> Do I need to support both interrupt and polling handling?

If the driver requires interrupts it should not just ignore errors when
it requests interrupts.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzlLdEACgkQJNaLcl1U
h9Bxtgf+O7Ql3XV1v0OFmPYGNxKhM7hKmFIojgupkf2VbuPOioXJq+YR4xqGXDpQ
b05un6ESQyyilrI/JXIY3m8pRYbBQh0AMscC/OxWEOThmZCVafXJS3WRxCeFhIqu
i3fA94KsTpAjgOOGhkDfOiBsthK9je+SMrE1S7eNqGRTi82IfmBVoGr4ecQPKFn9
dV8QHIcHuzqHKs4iCC+kYpTYpCH6s4VJk5ZkElABX6ewekbot17FBe5bFJp9pWni
uFC8d1xp66heSVTwc4lA7SbDqWY1zZbhJyeJDjw0Uv2PauyH3HgnN1MKFRCvGBRL
+ZO4mmN5t1jhZ90vlxbwPkyvODb+6A==
=mko4
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
