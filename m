Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C381B99F
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfEMPM1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 11:12:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEMPM1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 11:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=25XK2QV3mzd/RZlso5+EL6Yh9tvNSkUrkIoGtKKgtpU=; b=VE1LDk+E1hpsLn/thjZDyhs5w
        k9kGhLabtxcGuHqY2+p2oTM8KbPNk0ycrPxCIaejkA1aRSqtdBrfN6dH3c91wkESk1BhUSznf2xRs
        XqWCx4CpWGfQZNDC5k/EfvVG39JzlbN1aU1rNAd8vqLqoirGpZFYq765aBb/6ynp9jl4k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQCci-0006rY-OP; Mon, 13 May 2019 15:12:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DD3431129232; Mon, 13 May 2019 16:12:14 +0100 (BST)
Date:   Mon, 13 May 2019 16:12:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [resend] [PATCH 5/5] spi: bcm2835aux: support effective_speed_hz
Message-ID: <20190513151214.GB5168@sirena.org.uk>
References: <20190223150705.10729-1-kernel@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20190223150705.10729-1-kernel@martin.sperl.org>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 03:07:05PM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Setting spi_transfer->effective_speed_hz in transfer_one so that
> it can get used in cs_change_delay configured with delay as a muliple
> of SPI clock cycles.

This needs rebasing against current code.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZiU4ACgkQJNaLcl1U
h9DUMwf9HVUWCWikiFC7SUxOGSqhM2/tdziY9oZvOLbKO5fqkF9etxS2JQMCLyFK
SOceSXWZO+JOX5BR780dE6Mi4OwWjt7edeQmhGfrz6FbQ2kBOTeDyx5VVg2UCm4x
fphwn4/EwX1IQAz6ZBqmVE1WSuZBede/dT+7GeRKRRMlhqY8r8T1AElKOKbQsdlO
RbZ8SaizniMo68tqXDX595rt9Vy73yeAE2WFchucJjQPzj9mU6gDzoyBv6b9EL/R
jBegJsUNzmrdlDL4I0wAIdLrOZiF+LTN5EUZDTlV5R5do8eLl9ErRHQyF9iAExpO
vqGdIyW/QMtJXQvxOHrEsO6ce9CiBw==
=3EQn
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
