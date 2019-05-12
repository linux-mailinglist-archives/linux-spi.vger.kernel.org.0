Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1A1AD55
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfELRFv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 13:05:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49608 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfELRFt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W0DkQ+1TxQPNtQm5eo0/nuDnG81c4oSAMBmhQhkgRnE=; b=fmHS3rVqBIL9tA/0oiLnBFZFO
        wDZF2VEQtFMgXAfBNjPYAA7rGW4KQcSCRQMopdT87y9DntRV+uV6jICovw2ASshPl1RyHmhCtPSGD
        veQOz7uVqmtc0BhwcVSx7gKNstiYVfkpsdQd0uJ+rG7Yjjb3Ez7EttRN3hrf3QAyC4hy8=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044e-7a; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 95E8944004F; Sun, 12 May 2019 09:13:16 +0100 (BST)
Date:   Sun, 12 May 2019 17:13:16 +0900
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Martin Sperl <kernel@martin.sperl.org>, kbuild-all@01.org,
        linux-spi@vger.kernel.org
Subject: Re: [spi:for-5.3 12/13] drivers//spi/spi.c:1134:12: error: 'struct
 spi_transfer' has no member named 'effective_speed_hz'
Message-ID: <20190512081316.GJ21483@sirena.org.uk>
References: <201905082026.uvt96l9r%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <201905082026.uvt96l9r%lkp@intel.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 08:29:30PM +0800, kbuild test robot wrote:

> All errors (new ones prefixed by >>):

>    drivers//spi/spi.c: In function '_spi_transfer_cs_change_delay':
> >> drivers//spi/spi.c:1134:12: error: 'struct spi_transfer' has no member named 'effective_speed_hz'
>       hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
>                ^~

Not sure how my scripts didn't run into this when build testing...
anyway, I'll revert for now.

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX1ZsACgkQJNaLcl1U
h9ACogf+O+tAPiBNw0jWWv88e/F/H0xYtH+WdJxwpfps4lDnIa6mL7KNCXgtOWEU
8qH0enbdXJTqQMxEmdT7yO9dkIcNPJzpoj2UGlrN4uYWbhm9tqJFnx6OlLqRlBmC
978fhhQDvBjn+BUvFLPtF0q3jRARfmKb8Gh6SGQakRNwK2GTSEhH9NkAgAHw9WkI
MvHkqfTtsVv0UnXlog6GDcSI712X4vP1y//Fqqx+rqRkQrE6Vm1M1AGjaOcrV4mB
rjBlzqQV1IlKss882dHnOK/Kdloewh+WJg2c0b7kq5mZ0Gxs/eIAhpyJjsxIeMCo
7sHi+btcM1htx6T+I29X5C/I8Fupfw==
=hoob
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
