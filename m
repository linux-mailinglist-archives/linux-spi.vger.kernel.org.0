Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679E54CCC3
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFTLTS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 07:19:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfFTLTS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cv9BAECJiKHZb8J6bWn6ruPPRzIZNLYb+mCtLpPtisc=; b=Jbh6QBKqWpCfDwtaP2WTQYFyh
        MHxyBfZ4Ruhjt8RmOB+tCSdYoqyNFa63wZIsRwiIMB63ydNgu+OoNr/7IqhXX2XRSErJE8NOp/ZGp
        dqb35KmaO4XdaI4pzUdc2Gr2bcJPuA2HsydT4t0rHXK3yl4575u/j+Km/kb2D4VH2HPP0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdv5u-0000KI-73; Thu, 20 Jun 2019 11:19:06 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 61A41440046; Thu, 20 Jun 2019 12:19:05 +0100 (BST)
Date:   Thu, 20 Jun 2019 12:19:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
Message-ID: <20190620111905.GA5316@sirena.org.uk>
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com>
 <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
 <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com>
 <20190619144255.GG2640@lahna.fi.intel.com>
 <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com>
 <20190620104128.GW2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B104er4HUrzUbM9g"
Content-Disposition: inline
In-Reply-To: <20190620104128.GW2640@lahna.fi.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--B104er4HUrzUbM9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2019 at 01:41:28PM +0300, Mika Westerberg wrote:
> On Thu, Jun 20, 2019 at 12:33:41PM +0200, Ard Biesheuvel wrote:

> IMHO it's better to do:

> 	memset(&lookup, 0, sizeof(lookup));
> 	lookup.ctlr = ctlr;
> 	lookup.irq = -1;

> this also initializes chip_select and possibly other fields that get
> added to the lookup structure later.

I agree.

--B104er4HUrzUbM9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0La6UACgkQJNaLcl1U
h9ACdwf7B1QyJIxm8Gv4WsPgTNEduIBKhe6UFlLWQUnZpB1FSA9JOsJgxw+1DaAj
U+jpBdux/JBuGC54DhnK8Us1sBnQoeQ4aPM/YMtB7HsbYlTO1Zmdx5cXAvM8eJ7O
vuvHtVLa/llZE2rRQaxP5nZEOHf+qrS+zmZLMQoYZOEQlFxgWUXAfS8hmzy5E5qD
5OYnmnvi7o2ATtJdY81lWzGde6MTEgPSz9hmxPgypC2M+EHlEx0OFmUbSV3yYBne
Sat2Oy5FcazOYDZ9CatO/jSxdvmvhkJ7lz25m4L76EyHBsnRdF36XX3sMPD3JwPJ
CxPII3h3VES1nMCBbgMllLDZAkROjw==
=/vvV
-----END PGP SIGNATURE-----

--B104er4HUrzUbM9g--
