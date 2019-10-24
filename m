Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B6E3478
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfJXNlU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 09:41:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbfJXNlU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 09:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jQ+K+Qkm5Eu3uAlOrgsS/hGb6gv3j9J+2wAQuR3xOJ4=; b=sFXM/igr8xbZq+syxmiIS4OWs
        7cikJfS3dYSX40kv9pPxZY77S4GMPWUdxpkhbLt8Lc56d+g0nhvSq0jPMlO3TWsowYzIlcFdudwoA
        JqCuaDWdt42q9DQdxl2T7qDVEiQ41Y/ZxGnItAq/GyKl7r4jDffefAeyc734/hSUHoMPI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNdMb-0003d8-C3; Thu, 24 Oct 2019 13:41:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8A642274293C; Thu, 24 Oct 2019 14:41:16 +0100 (BST)
Date:   Thu, 24 Oct 2019 14:41:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024134116.GF46373@sirena.co.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20191024131856.GA32609@salem.gmr.ssr.upm.es>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 03:18:57PM +0200, Alvaro Gamez Machado wrote:
> On Thu, Oct 24, 2019 at 02:11:29PM +0100, Mark Brown wrote:

> > No, that still leaves the slave driver thinking it's sending 8 bits when
> > really it's sending something else - the default is just 8 bits, if the
> > controller can't do it then the transfer can't happen and there's an
> > error.  It's not a good idea to carry on if we're likely to introduce
> > data corruption.

> Well, yes. But I don't think that's a software issue but a hardware one.

> If you have a board that has a SPI master that cannot talk to an 8 bits
> device and you expect to communicate with anything that accepts 8 bits
> you're not going to be able to. Either the kernel raises an error or it
> shuts up and tries its best. I understand the first option is better, but I
> also think that's not a software issue, that hardware simply cannot work as
> is regardless of what we do in software. The hardware devices simply can't
> talk to each other.

Sure, but then it's going to be easier to diagnose problems if the
software says that it's identified a data format problem than it is to
try to figure out the results of data corruption.  There is also the
possibility that if the formats the hardware needs to use can be made to
align through rewriting software can persuade things to interoperate
(eg, if all the transfers are multiples of 32 bits then a device can
probably work with a controller that only supports 32 bit words even if
the device expects a byte stream) but that requires explicit code rather
than just silently accepting the data and hoping for the best.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xqfsACgkQJNaLcl1U
h9AJPwf/eBixL70rvrXmAkP/RrgemqHi86jCbwZJYCVt6vx1k7YDsO2xH4caw5c7
fz+y7LOfHpPkXsZQJq82kaTxh8G62VWSvo8sGZw7yv5wQdhdVf1FCCzxAIsfZah0
oP9BCsWfrawXt8pG9MFbFtVkqFnOpiq+dG9ipC3VjMl0k59qxT5kvtap5YNMEKEG
fJn1ReujajXzf4FrcicPqqr7VFKeuwNrxxixVNQt60obrwnGyTy1irfRBCDQts8/
6lIPt3CBg/CL9ZuelWR+1Tv2Uu41JOoYKany8ougCpPfwplDhS1ejGCI9tO9scNG
AbCslema/C0KCwURbBXeTc2aHfv30Q==
=pijI
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
