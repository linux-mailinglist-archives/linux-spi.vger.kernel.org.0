Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF02A0C4C
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfH1VUl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 17:20:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37670 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1VUl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Aug 2019 17:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JKvFxTaIw4ze+wFQy7JhepfnKnFczjcF0kqC/gORddo=; b=Y0IjVu63m32RBVFGgH6347V27
        tNPXsKKoVfddMUlISVN20mfIjblfY/rA6KlKAY0Yw/+oVIPv5RWkB/l8PjQ5W13duFays3zME33dv
        mn90cdqw1gwngc2ST4iELesX9720zL+411xNqPytuzgZcExfq1C0E3feQaF0vkLEcDbeA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i35Mr-0006js-0u; Wed, 28 Aug 2019 21:20:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9FB9A2742B61; Wed, 28 Aug 2019 22:20:34 +0100 (BST)
Date:   Wed, 28 Aug 2019 22:20:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Message-ID: <20190828212034.GL4298@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
 <20190827155005.GA18581@bogus>
 <20190827195606.GA28879@sirena.org.uk>
 <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2019 at 03:01:15PM -0500, Rob Herring wrote:
> On Tue, Aug 27, 2019 at 2:56 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:

> > Well, you have been pushing people to change over to using
> > dt-bindings: so I guess you do care :(

> Well, yes. In the absence of any sort of pattern, I have pushed for
> some consistency. And to get rid of subjects like this:

> Documentation/devicetree/bindings: Add the DT binding documentation for foo-bar

> If subsystems are consistent with their own standard as you are, then
> as a maintainer I don't really care. My point was in regard to what
> submitters need to know and follow.

I agree that things should be more consistent.

> > It really does cause me
> > to miss stuff, especially where people don't even include the
> > subsystem name in the header.  I get quite a lot of CCs for

> I can't imagine filtering on subjects will ever be that reliable
> unless we add subject prefixes to MAINTAINERS and have checkpatch
> check commits against those. Filtering on the diffstat is the only
> thing that's kept things to a sane list for me (MAINTAINERS for DT
> used to tag of_* functions which just meant getting copied on *every*
> driver). This is done on the patchwork server side for me, but I
> imagine one could do it on the client side too.

Part of the problem for me here is that stuff that's flagged as just a
binding has a very high chance of being misdirected, I'm unlikely to
have much input unless it's for a driver or subsystem I maintain and I
get a lot of bindings docs for things like other bits of MFDs that have
a regulator on them or where there was some interesting interaction with
one of my subsystems that hasn't yet filtered out of get_maintainers'
view.

The other trick here is that sometimes I am actually being asked about
the thing that I'm getting CCed on so I don't want to actually filter
stuff out of my inbox, it's more of a scoring system thing with lots of
guessing going on.  I say filtering but it's more a strong signal than
strictly a filter.

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1m8CEACgkQJNaLcl1U
h9CrLwf/X5MQzBfb7KpPjUp6dJEyGZqPZF7kgvsPjAMXkY9IjIBIuCqeYj1aNCdU
iRKUACgqSXfN6cFrlsx4tINlbMoQA7I9QrDjEULrM92Q+ScjIlbBVfNc0tPNjNXW
jWoXqK0qjVkHC7A1IppMEU3Z8VtLCIe0pE51MSWl/IcLh0PlMNZBpnvOFz+M9LA+
dUnF9/4/oA4smOQ9rSH0iLi9ceXsag2Hva5dSDkbwmYC7+QavIK5fGWxvM7sCMgF
NMhlBwLZBjD1NWix97vbA2laF1unnRFEdxswTym4bmo/yMwSdgPUbryI0mtgiKtj
AEcGfuhWCTX9uZEBJOhs9d8+oA8RQw==
=uj8w
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
