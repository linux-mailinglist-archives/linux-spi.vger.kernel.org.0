Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAABF99F2
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLTm2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 14:42:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLTm2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 14:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ufx9abnjCFiZMkVc20QJGrLEI8zqDpsCCQpJg7qZuQ8=; b=eHvg7pxsDGBwmo1U4d5XHq7xW
        rKM3wfPDvmwmlE1ODBu+LBSTLAnsPJv5MdFu7SlsbQnoAC0HHZgIBzzL045C54yvF4jeO/nkVZtHf
        fR64RtElxiBkXUuEXpbUCNjFRr05A80wccLu+AYjJ7NbHK6SRnwRY9baflXj/JxVYv5EA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUc3U-0000Hz-So; Tue, 12 Nov 2019 19:42:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E3B79274299F; Tue, 12 Nov 2019 19:42:23 +0000 (GMT)
Date:   Tue, 12 Nov 2019 19:42:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191112194223.GM5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Content-Disposition: inline
In-Reply-To: <20191112193653.GB13374@dtor-ws>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:

> As far as scheme goes - I hope that Rob could confirm that we can
> override number of interrupts and names in consumers of the binding, as
> needed.

Yes, I think that's the main worry here - if there's issue with the
framework bit we should be able to sort that.

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3LCx8ACgkQJNaLcl1U
h9CsMQf9EiGfHZdWSXq6DKiXomGkOIZ+BC27XAQ9dHxneP99B19i4vn584IKaeok
EcBi6YqjpD1oIf2KBBixy/vaTlJuA07QV5NoORICvMR75gWy4XvWYt0UCZxGs1vY
BNduo6rLmePAoRKjoBVT4e3H07cLkDxkZ6V4r0jZJIwleLZOsi5mDXlS8Rwd0C0k
p8YLQBgmFFqiVqiJae/WgxzWuYCU0PgX93YXIGlLZgyDav2SQ62nyYcK5iMEwU4q
15Y6cdvRZd4iRiMZJOaAW6cLdj607FKp7fj4Hh/uZKs7FzNnskcL0b+YpxNaRDIr
g1kjE11Jqb1i/tG8C42S5ylH7HdDiQ==
=MTTr
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--
