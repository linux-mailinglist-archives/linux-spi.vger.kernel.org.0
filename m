Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD227E93
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfEWNqc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 May 2019 09:46:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40576 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfEWNqb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 May 2019 09:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mfme33xseZptaUR1J0V/caYBOllJ3rsr79Z37c1uExY=; b=p03EHWT2EucM1oy2mwwkLoCa4
        cEClGv19UdrvGGd0zT2qpW5VR+hR7uqzOdMkk8Pq97xH1hF2IuNiIw8WCKa8qpFzoFcgidqqUxoFM
        qkFRSOWgyqaN+BmVvehSRKNxsehKedaX1zgRl/igV7NNJdWO7vlbzoLgwPplFrbbMbU6w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTo39-0000Dd-D8; Thu, 23 May 2019 13:46:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0250D1126D24; Thu, 23 May 2019 14:46:25 +0100 (BST)
Date:   Thu, 23 May 2019 14:46:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: Allow SPI devices to request the pumping
 thread be realtime
Message-ID: <20190523134625.GG17245@sirena.org.uk>
References: <20190515164814.258898-1-dianders@chromium.org>
 <20190515164814.258898-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20190515164814.258898-3-dianders@chromium.org>
X-Cookie: I brake for chezlogs!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2019 at 09:48:12AM -0700, Douglas Anderson wrote:
> Right now the only way to get the SPI pumping thread bumped up to
> realtime priority is for the controller to request it.  However it may
> be that the controller works fine with the normal priority but
> communication to a particular SPI device on the bus needs realtime
> priority.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-rt-pump

for you to fetch changes up to 924b5867e7bd6a6a98014f0517b747465b108011:

  spi: Allow SPI devices to request the pumping thread be realtime (2019-05-23 14:44:02 +0100)

----------------------------------------------------------------
spi: Allow setting pump to RT priority

----------------------------------------------------------------
Douglas Anderson (1):
      spi: Allow SPI devices to request the pumping thread be realtime

 drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzmpDEACgkQJNaLcl1U
h9AT8wf9HCQwiI9ChQBim3VkHh1VA8vwPgC20zoPo4PUGPcvvaWX5I3lrUoeCp1Q
vpMaUDp9J8OQ57wbmNFjqYYwLAK66XMUPQmqyH6q+1m1JSp5FP41aVGkJD32UOnk
wqsDdznTOvdDrgnVtJWtqjSWiK18M4OQJhIJGwe0wBRIfk+bpQDa+s+R34wgHCt8
xGJZcdJagggMsco0HvSgLuIRcIVuLbsCiu9Vxh1GR3ko3x7xLUVhkoKzxJ81qVu1
99KmShuE/rXn2IKU0lfC6WjItvey3r1RWyKFsSd7xKI6Izz45lNFrUlgrSOyLW4R
NqMXjQUeC/nEluG0IIC4X0mbopIIsw==
=Xgy/
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
