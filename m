Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D32D9E30
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407785AbgLNRtR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 12:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408828AbgLNRtO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 12:49:14 -0500
Date:   Mon, 14 Dec 2020 17:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607968113;
        bh=NcqAS0fdk9ddPfR571pdN63Yp0bFOzwqCtafAiwa0Mg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNmmvYml2MNGeb+1OLX1V7rfTCqp5bNGLdXL9oMr05FR+lJujOeYbEmWg9/mppLgl
         FlojAqt/+wgn8kqstqSP3qkMN2Gh3Vw8s96yfhv318MKroqChPYhbmhDKuyQlGkLn7
         5ruqWFfAqbbS2AHYS8vbC05m2iEuWid38KGnX/EvP51Y81RLV46q+xx0hLy+ByNrFd
         UyhCCLPd9eTn0Pgf/GQmwpq0VpxdIO8Rbubjazqg7CRQQWlmp9prYxLca7YJ4O9t5V
         DptZ9BBWPHCEQBp7XE+gZiHKnw+URjzsA306qZdttBijySBmrl1KVJY9//X6/3wQLJ
         Sd/mEfWCXjS1g==
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juxin Gao <gaojuxin@loongson.cn>
Subject: Re: [PATCH v3 1/4] spi: LS7A: Add Loongson LS7A SPI controller
 driver support
Message-ID: <20201214174822.GC4880@sirena.org.uk>
References: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
X-Cookie: Everything you know is wrong!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 14, 2020 at 01:58:51PM +0800, Qing Zhang wrote:

> +static int ls7a_spi_do_transfer(struct ls7a_spi *ls7a_spi,
> +                               struct spi_device *spi,
> +                               struct spi_transfer *t)

This does a lot of configuration, as far as I can see only the clock
rate can actually vary per transfer though?  The mode configuration
looks like it should be moved to prepare instead, the divider settings
can be done with a read/modify/write.  It's also not clear to me why
spcr and sper are being stored in the driver data, we never read the
values outside of this function.

> +static int  ls7a_spi_transfer_one(struct spi_master *master,
> +				  struct spi_device *spi,
> +				  struct spi_transfer *t)
> +{
> +	struct ls7a_spi *ls7a_spi;
> +	int status;
> +
> +	ls7a_spi = spi_master_get_devdata(master);
> +
> +	status = ls7a_spi_do_transfer(ls7a_spi, spi, t);
> +	if (status < 0)
> +		return status;
> +
> +	ls7a_spi_write_read(spi, t);

This is kind of confusing - _do_transfer() doesn't actually do the
transfer so far as I can see, write_read() does the transfer?  Probably
both functions should be renamed, or even just inlined here - it's
really configuring the clocks and transferring the data.

Otherwise this looks good.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/XpWYACgkQJNaLcl1U
h9BzHAf/Rwxgo7t4Z5IvsSKHACOvItQQHanhkcSmK862aYJBHTRvoVpnQQzEtqU6
Wodl6E4dZFq15FhWH12EsOBDv2LPsm4XiaYWbUljPip0ZEfbJNpoOUg43UZZSHri
cjThPcPGG2UEQEDjyWivFKyip8ws8PJw9o2+2Wm5KygxoIsXX6sIIKQRpzgxcdqw
k8774KI3eR1lKc6lWstuI442xqfUMGbBPfor59NB6iRkXlG1FlOo2grXwWhrwC4+
Yvk45cnZDLQvrK5E72VLMVjK9JeA+K0Tkkkg0UGzR5m8YsgDCrWxW4rjCYEIdxpY
tcpeQhGyu80pqDTE8b8y8k/ldAAC8g==
=U/sN
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
