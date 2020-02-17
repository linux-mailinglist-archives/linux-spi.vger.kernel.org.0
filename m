Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC4161887
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBQRJD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 12:09:03 -0500
Received: from foss.arm.com ([217.140.110.172]:38890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbgBQRJD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 12:09:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42A111FB;
        Mon, 17 Feb 2020 09:09:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC023F68F;
        Mon, 17 Feb 2020 09:09:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 17:09:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <20200217170901.GS9304@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
 <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D+M1YvVlDncl3vD5"
Content-Disposition: inline
In-Reply-To: <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--D+M1YvVlDncl3vD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 05:18:10PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 14/2/2020 9:09 PM, Mark Brown wrote:

> > This will unconditionally handle the interrupt regardless of if the
> > hardware was actually flagging an interrupt which will break shared
> > interrupts and the fault handling code in genirq.

> Yes, you're correct, it doesn't check unconditionally, will update the
> INT flag in the INT_STATUS register after successful completion of
> read/write operation.
> but in this case it is dedicated to qspi-interrupt,not shared with any other
> HW/SW interrupts.

Currently, on the system you're looking at.  Given that this is already
a widely reused IP there's no guarantee that this will always be the
case, and like I say even without sharing it also defeats the fault
handling code.

--D+M1YvVlDncl3vD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KyKwACgkQJNaLcl1U
h9BRpQf7BBpw3svFemJ2cWh6h1EFnHHkZ/ZLCnfay3PkV8NcIfAhsFPqR7cppyO+
fd1j9FJjXESo+VN3avFmvA6owvPQOQ/nSxaW+i1a1/w8lx3hLfOaPfk7srq86rmE
wCWC6/JPdc3pGsez/Eps2ToT36hUWQQPKI5Af2hIbVJyC0BdbM4o6tA1HP0yzP5m
+ORv/DNeldo4WO2Vg6kQeSwOp8KPFNc8rwMYszVKuLMP35B+1yBS1/wqOibqd7D0
TtxA4X9VwLAN4uxa8QHrjyXKUZBH5w9WCebCV4OdjWlBYiwM8jK3hWqYQ1DeQqjM
/0Eg90UbfBNrqThe8eoiX1tuUwgT0w==
=xyLf
-----END PGP SIGNATURE-----

--D+M1YvVlDncl3vD5--
