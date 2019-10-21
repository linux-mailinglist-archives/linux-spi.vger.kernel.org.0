Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979C2DEB09
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2019 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfJULf7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Oct 2019 07:35:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfJULf7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Oct 2019 07:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ItaU+MbAHgCye1IVUzSWHuGcjVdE+bPZonoTIyYtvSk=; b=TTDPyWToHHh8T4S3VKE3aoBSF
        9/nETwlA1TAi62o0j35cfOjNsIGpvP2N3gwweRO1tcfqGICQxXQOQWZl3j4InuMXp6RjDj9OVIDhg
        Pdos0yIfN39tLJcWV9IRFWmsc0RYPlOacXAryIlo9g8CHfO/EZqUVJrE4zdsYRNwKAl0k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMVyM-00042v-H1; Mon, 21 Oct 2019 11:35:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 00689274301C; Mon, 21 Oct 2019 12:35:37 +0100 (BST)
Date:   Mon, 21 Oct 2019 12:35:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma
 mode
Message-ID: <20191021113537.GB4691@sirena.co.uk>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <20191017064426.30814-1-daniel.vetter@ffwll.ch>
 <20191017070638.GB32742@smile.fi.intel.com>
 <20191021110857.GR32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20191021110857.GR32742@smile.fi.intel.com>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:08:57PM +0300, Andy Shevchenko wrote:

> Mark, can be this applied?

b2662a164f9dc48d

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2tmAkACgkQJNaLcl1U
h9Bmiwf+LpkNRvFDHKJlEidZWltSZa/YXEUiHkXF+RPQ50Dg7H7u4mTpMHYE6p4j
GzZoajbCmd20mLDAY/AV+PQc5AmjFdXmMk5/3vqbYPWL92Wmlfx/2pIX+O8NV/dz
MUaCFgYJf8ZStxwwsEKGYSxPzdkVi+e57w7GQZMZP8JKm1VfRjxHCBNV22ZmXD2L
WGxdBr9lIPfs34GplBpk2Gr3Y5dlDbHC03tgsxf1qcDQlRiG9HaX8zEiRF5CsnAh
XK2lkJmT86hCJiqRNP6QnT1SmjqahHwHbUXakBNNmS5nr1JYYZb3hCgSWPrdpbbg
UP2goIpeqbEN0JAhJNMQA9OQGT58kw==
=2kIE
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
