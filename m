Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7BEE338D
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502345AbfJXNLd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 09:11:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502256AbfJXNLd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 09:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wJ3jFCYlQZd2kaRLR+xIvrirC3xCD3jRhPw0luBkrKA=; b=bYcUG9RknlctV9QevFtZ0Bb4W
        C/W5nqL22uhUMQkmRSkpJTbh/iXp91S69hC7HHGqi2muhSzNBkXn+CrmefkzvN0DiFW3nKI4ME36H
        ohYNhhknYVW6Zp6Q8kuLONJZu9e/BTM1zbqTFnBXtfd9ooXuxhSh/SzMOrJ+H6edYZAu0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNctm-0003bt-9u; Thu, 24 Oct 2019 13:11:30 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5EAB7274293C; Thu, 24 Oct 2019 14:11:29 +0100 (BST)
Date:   Thu, 24 Oct 2019 14:11:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024131129.GE46373@sirena.co.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20191024125436.GA8878@salem.gmr.ssr.upm.es>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 02:54:37PM +0200, Alvaro Gamez Machado wrote:

> I think then the only way this would be feasible is to check if 8 bits is an
> acceptable number for the master and, if it isn't, apply the lowest
> available data width. I believe this cannot break anything, as it leaves 8
> as the default unless the master can't work with that number, in which case
> it really doesn't matter what client device wants because the hardware can't
> provide it.

No, that still leaves the slave driver thinking it's sending 8 bits when
really it's sending something else - the default is just 8 bits, if the
controller can't do it then the transfer can't happen and there's an
error.  It's not a good idea to carry on if we're likely to introduce
data corruption.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xowAACgkQJNaLcl1U
h9Dbvwf+JlNdjB1mAv8E3DjhhwMWcoNpOv05AG46S7LU51cjkDY50ZeI2MuNPWnd
ca0pkKBvTMT39wQeHSjSI6dtnQ8/QVJOXKZAv1hBGJXXnSuLa/SSO9DAc7cYecvd
MAL/mT85jy9KPizmf0lmqblRnAa/oT4oIvVpWEUxDMx134Hh1EwlnIKrPsqebgM1
F6B9ZoSf+zjbKTZELkynEt2+xbkefTekMNR7GIHXmjIyxqd2EHKdSBG53maQ3ajw
2b3cGjhjqV0QQpJbtq8lZy6CbEo/3TCF76qk/EBEcBEvgOyOEZczj3EjN/ZUhMyW
mn3nPfEXazfunseDYs8yoNN1nA2eig==
=1HfO
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
