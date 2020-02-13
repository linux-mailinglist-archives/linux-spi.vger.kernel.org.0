Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0815CAA3
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBMSq2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 13:46:28 -0500
Received: from foss.arm.com ([217.140.110.172]:52204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgBMSq1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 13:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F84B328;
        Thu, 13 Feb 2020 10:46:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842C93F68E;
        Thu, 13 Feb 2020 10:46:26 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:46:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Message-ID: <20200213184624.GK4333@sirena.org.uk>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
 <20200212120753.GF4028@sirena.org.uk>
 <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline
In-Reply-To: <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 07:08:49AM -0600, Adam Ford wrote:

> The original author was copied on the initial commit.  I literally
> generated the patch from NXP's branch,  added my notes, and pushed
> them to the mailing lists after testing them on the  the Linux master
> branch.   I am a bit disappointed that NXP's author hasn't responded
> to any of the comments or feedback.  NXP knows their hardware and

Bear in mind that it's been the spring festival and there's been quite a
bit of delay in getting back to work in China resulting from coronavirus
stuff so hopefully it's just a delay in replying.

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FmYAACgkQJNaLcl1U
h9BIJQf/YCuS+PbvoZjpzEq+oZbCnmY0R0BkFrp7Sc1PV9zHgjKqGmQAr9RVSeSI
kfalZEPSUkUEpxgouX+I3VVvKPpQhDEhj46+y+IXYWH/Y0QA58bDv7ctWOhIBn+Q
vW7iTl/+CHsJdTptylbI5K0TiVP3D5wDGbiym/rvAjIGpe7FXzd9WUteXNKeLJMy
QmhJg6z+gAVwf/mYiyM03MRx1Gn1c5C/cMkan6s189g77et3avP4nEfKb6UyApgi
FY+BqvQCyBK7OSErmJ7H+NpqM9Rq0b7xJLknFwbfOLTpqvG8iRhGzvQyNg3uPAqt
aAm0o3dppPZAbuc4HFV4OF5n2YoGBA==
=r4u7
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
