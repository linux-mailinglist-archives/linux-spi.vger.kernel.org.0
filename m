Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9F44D8F7
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhKKPRW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 10:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKPRV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 10:17:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 610C7610D0;
        Thu, 11 Nov 2021 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636643672;
        bh=8oWIFjKJYfepUE0yUuIBYsOHlHH1aA0rTbbQyMWoEVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU2HBgAjfIYLlEa6u5AH2kLoGXGwsX6XZZWesuHrWj6mjV3KrvxufJ30tLZfV29Pw
         RpNo8f1kOdxjNv55UbFbFYSkTF7sq36+jLHaDHU018M546J1FjnphlbGMsE7+NWnwy
         MRJo6c14zhgrT49evQbHPSXvEJQ8l5gFzYHd3FtU4Ow8Q4V1szF0+6tsfdejejwWsR
         cBikrw7ISff9agnTsSCnW2xf95MPnXk6EVtrBqWgBeAi7odOrm+Zh4BGjB9Gv/DJVL
         Bjsc+uxTjfpbhuOQYZKuNZ4TwcRjb2Ydho8zWCBBY6uDNH//8Db8fbEEQUWzjY6CxR
         Uy+RWUA9/rkCA==
Date:   Thu, 11 Nov 2021 15:14:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        nandhini.srikandan@intel.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <YY0zUjjVobtg85o6@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qOF30QiOQ5dKRXqf"
Content-Disposition: inline
In-Reply-To: <20211111145246.dj4gogl4rlbem6qc@mobilestation>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qOF30QiOQ5dKRXqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 05:52:46PM +0300, Serge Semin wrote:
> On Thu, Nov 11, 2021 at 02:16:05PM +0000, Mark Brown wrote:
> > On Thu, Nov 11, 2021 at 02:51:59PM +0800, nandhini.srikandan@intel.com wrote:

> > > Add support to select the controller mode as master mode by setting
> > > Bit 31 of CTRLR0 register. This feature is supported for controller
> > > versions above v1.02.

> > Clearly older versions of the controller can also run in this mode...

> Yes, but the driver doesn't support the slave mode at the moment.
> So always enabling the master mode seems natural. (see my next comment
> also concerning this matter)

The commit message makes it sound like master mode is only supported for
the newer versions.

> > This makes the configuration unconditional, it's not gated by controller
> > version checks or any kind of quirk any more meaning that if anything

> We have already discussed this feature in v2:
> https://patchwork.kernel.org/project/spi-devel-general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/
> Since that bit has been reserved before 1.02a but is no available for
> any DWC SSI controller and the driver doesn't support the SPI-slave mode
> at the moment I suggested to just always set that flag for the DWC SSI
> code. Please see my reply to Nandhini here:

Given that people seem to frequently customise these IPs when
integrating them I wouldn't trust people not to have added some other
control into that reserved bit doing some magic stuff that's useful in
their system.

--qOF30QiOQ5dKRXqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNM1EACgkQJNaLcl1U
h9BQqgf+Ktvr1mK1EqevOPqFESomNifxKhKNtnddhk7MbW/7grkqkDYon1DwMvab
v6t5B3QTFgiuiDSTNicmR9faFNUgzpWr1RP6TgDJadLT6fKzhf8W/I8+2s0nbPkK
RJIwXKD9ogiEwAswOVYn5cJ06U0THIy+uknqTD4+AKAT+FShqZISg4bAyVe6+ZV2
ybEyAOy54umUnlbyYq7N1fHb7LkODNInFrT4fNYn6lRKf0ozf5j9Iwt/Wb3orsbn
Qu8i0VRx7URdwV9IjtZo4b1PFsDSFZ0PqGQMlM1MVqcuyjciq1iK6/ExJitXa6m+
84rz0NM9l6B7PyJ4RVt4FA0Zw5aa1Q==
=/FWn
-----END PGP SIGNATURE-----

--qOF30QiOQ5dKRXqf--
