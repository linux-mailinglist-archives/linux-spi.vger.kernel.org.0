Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABDE4A93
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2019 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393573AbfJYL47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Oct 2019 07:56:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJYL47 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Oct 2019 07:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x/6eiM9BhqvxQhK00NRhiUmYBu8gULRPzd+UFzEpnsc=; b=lySZxGyzza2R5r11U7yL7TzQy
        mTnQyAl06jrTNSOWQlx5iXyKBFJGrEo/FAz9vlEZXbECYwIjhsbFA/kWXbS5EWYHaXBJs4g5LC7xj
        2eCgWHrPMzdm/AQ3Zj/oSZzQG9HP5h54YcRzpw4bU61tHwGDVGDWT5BwcTulr11MOEHVc=;
Received: from 188.30.141.58.threembb.co.uk ([188.30.141.58] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iNyDA-0006qe-No; Fri, 25 Oct 2019 11:56:56 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AF78ED020A1; Fri, 25 Oct 2019 12:56:55 +0100 (BST)
Date:   Fri, 25 Oct 2019 12:56:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191025115655.GA4568@sirena.org.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
 <20191024134116.GF46373@sirena.co.uk>
 <20191024140731.GA2950@salem.gmr.ssr.upm.es>
 <20191024174033.GG46373@sirena.co.uk>
 <20191025063947.GA19665@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20191025063947.GA19665@salem.gmr.ssr.upm.es>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2019 at 08:39:48AM +0200, Alvaro Gamez Machado wrote:

> to claim the specific SPI slave. It may be spidev as in my use case, or it
> may really be any other driver. But its probe() function is never going to
> be called because the error is not raised inside the driver, but immediately
> after forcibly setting the default value to 8 in spi.c

Then you need to extend the validation the core is doing here to
skip this parameter when registering the device and only enforce
it after a driver is bound, we don't have a driver at the time we
initially register the device so we can't enforce this.

> I can't modify spidev because spidev doesn't even know this is happening.

You are, at some point, going to need to set your spidev to 32
bits per word (spidev does already support this).

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2y4wUACgkQJNaLcl1U
h9BpgQf/XNJ5nBjhjdIb2Tnl7FFtf6n6D1axZ7AGYAlnL5KAiV+sXtRT4oWE4DGr
+FxtPUOTroHbqtBB7BBqexVPNw1xQYsGFxYbD3gz2Il7USTBzMMDJ/8YVCRtSXzr
pFZrd7uFHokcKl9r2ca/dPuNWnO5z/7jqnpq4syJ0A+bGJE/DgUmmzdpeBRY42eh
dAbnJrNF7DWZRcFzXXr6nwYNjFQBWiTwPXAEdCuQp+5G4FrEQMWoAbm4/7xg9IdY
Cb46HR8VkmtyUCafWgQBeUjVGrMPgsewcFMevjO3WDshe9HOLjFRcgymTgaE0Ds/
5uFapLE00/Cu2/K8NPYDgmOCaSH6ZQ==
=9y3V
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
