Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A15D6A8D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2019 22:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfJNUEj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Oct 2019 16:04:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49648 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfJNUEi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Oct 2019 16:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zIcLhqWDCIkIt0Dfh0/Dq1+XX6MY1i6Jb4ML8wWZQlc=; b=JFV3oHbBByqVDYYgDS0apQ367
        Wwdh126w0/GuA7Hei6HED09hiWOCoVX1mmMsIGqz07L1MH6PMBQq8+fQE19/hn34kLeLa2+2OD759
        rzKFy8nKWAW3Y+il2C1wuQJuYMwGiuV9NbigWu2vtOL8owF0HLQHOBoEwZ4rs0ZOFNAPA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iK6a1-0000Hs-Jz; Mon, 14 Oct 2019 20:04:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 15F762741EF2; Mon, 14 Oct 2019 21:04:33 +0100 (BST)
Date:   Mon, 14 Oct 2019 21:04:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: sh-msiof: Convert bindings to
 json-schema
Message-ID: <20191014200432.GF4826@sirena.co.uk>
References: <20190926102533.17829-1-horms+renesas@verge.net.au>
 <20191014195451.GA22084@bogus>
 <20191014195844.GE4826@sirena.co.uk>
 <CAL_JsqJe0+QHs=jfF8e6rSJMAy8=UpbtdPqy6aP2LeEQ974Hog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJe0+QHs=jfF8e6rSJMAy8=UpbtdPqy6aP2LeEQ974Hog@mail.gmail.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2019 at 03:02:53PM -0500, Rob Herring wrote:
> On Mon, Oct 14, 2019 at 2:58 PM Mark Brown <broonie@kernel.org> wrote:

> > I've been sitting on this (and another ASoC conversion) waiting for you
> > to review them - in particular with this one I've got another patch
> > queued up which depends on it so it'd be good to apply it to my tree.

> Okay, dropped then.

> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2k1NAACgkQJNaLcl1U
h9DjZQf/b2BSRbJD2zkKH6TB+rh2HDygl7MRYsb5OaP3iFgWEfgpmQPQ6gvfHY/v
pEJ6LZ3ChLWjZCkb3h/+K8xXWQUGmJcbBuckNjMIvDcpGWvJP5bUsPVbXKi9PEGt
r4X39b+S/b9cXmU52qjAPBLBwXExOQC94nCLlBmoy+yL9yX9URRgkjuqlwZDImUR
5/chjuwy2hqeumjHuxYXefhEFapQO+TMz+Z1s2YF5Klcqa99XitxqZl7F2wM1CsP
r/BpQCvl1q7/cNUGD4BTkIn9VWO5RJSz6kEVLK5VyFCkhKA5ntaEq2Zild7aKiQK
9pEFrzbZ+UNgTI+6Fc5pGZ56qH/5iA==
=GQnS
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
