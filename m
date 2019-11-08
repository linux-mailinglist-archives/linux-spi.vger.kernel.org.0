Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E5F4A38
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfKHMHn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 07:07:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733084AbfKHMHj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 07:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mjGtniboMTM2RIT/gqY2m+20i8WqeKlHM9VBLi7C4QM=; b=Z3EmqP/dmXsGyR25IwH8ovthD
        j8FIlVRD2nkUWPRrlCLyIEdwmK/kYF9uWN37WdYWXVSJl3m/b7jfgIjp8KD/D79C0ruSD/l4yzl3q
        i/w3Xn8QIutxsE9twSFV3vP7WgiYp/fn1yJQo+KUgpc0zMr+bYSxAXEAhJ0ChByuc7mVY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT337-0007DA-Am; Fri, 08 Nov 2019 12:07:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C62372740C6C; Fri,  8 Nov 2019 12:07:32 +0000 (GMT)
Date:   Fri, 8 Nov 2019 12:07:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 1/7] spi: zynq-qspi: Anything else than CS0 is not
 supported yet
Message-ID: <20191108120732.GB5532@sirena.co.uk>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
 <20191108105920.19014-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20191108105920.19014-2-miquel.raynal@bootlin.com>
X-Cookie: Life is like a simile.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 11:59:14AM +0100, Miquel Raynal wrote:
> Unlike what the driver is currently advertizing, CS0 only can be used,
> CS1 is not supported at all. Prevent people to use CS1.

This (and the rest of the series) doesn't apply against current code,
please check and resend.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3FWoMACgkQJNaLcl1U
h9CyRAf+OzujcGHVTH3TILnu1RcNmDMHsq5AWnHviUgP3ljXhKwem+t3Es+mYTXt
yTLfHFCRlv6wLltW/V10d3fQDQIBlT6oBAx+jmQMzJOA3CNNk+2kDhUhjmyv0HKv
QKhIWqPg5StiQmmcvKz5zVoSyT2owP/glVMI6tNPqJD95QtHxj3GDUTI22B/xnZ7
ObnQqXLs5pcAklyLlkOFEhfzfOrKGKIsH9p46svKT68upTTZbYm4RINOdGYSXPwL
Xf28mCljPVXy/kHSnGcci8hXcXrwEzMalt6a3eCvp1vpxqmA8P2cj8hjW/67IiQw
sJ4ofqNSUWB3YP42i1vj2olILm8/Lg==
=lXpj
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
