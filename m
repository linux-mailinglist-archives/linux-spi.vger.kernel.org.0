Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15B3EFBFC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2019 12:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfKELFV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Nov 2019 06:05:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKELFU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Nov 2019 06:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2eO07dXroFiq8sB6b0J/jgAEKIzUzmLjBTejnzmX9T0=; b=ozXkH0JPOhx0viZ0l6KaKifyv
        kzh0+OLvHPX5brnQfaeUpyJh8bw+wr/M5frXCJbajZMkRwqimILKGmXTc5a452eDrB2cve8DE4VSs
        TciJFOnooDYMwV0OHa3T4uz/D0k3tX6ekootqqfcwTstryJvnBSzFVYnD/z6wQPnbwqyQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRwe2-0006Kf-Ds; Tue, 05 Nov 2019 11:05:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2711827431C3; Tue,  5 Nov 2019 11:05:05 +0000 (GMT)
Date:   Tue, 5 Nov 2019 11:05:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20191105110504.GA4500@sirena.co.uk>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
 <20191104192406.GH5238@sirena.co.uk>
 <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
X-Cookie: Genius is pain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2019 at 10:58:39AM +0000, John Garry wrote:
> On 04/11/2019 19:24, Mark Brown wrote:
> > On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:

> > > +		if (len) {
> > > +			u32 val;
> > > +
> > > +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
> > > +
> > > +			to += words * 4;
> > > +			for (i = 0; i < len; i++, val >>= 8, to++)
> > > +				*to = (u8)val;
> > > +		}
> > > +	} else {
> > > +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
> > > +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
> > > +			int j;

> > The more usual pattern for these would be to do some unaligned accesses
> > for the start/end of the buffer to get to alignment and then transfer
> > the rest as aligned data.

> Yeah, I understand you, but for that I would need to generate multiple
> transactions in the driver, and I wanted to keep 1x transaction per
> spi_controller_mem_ops.exec_op call.

> So maybe I can do some trickery in my adjust_op_size method to generate
> these multiple transactions: a. any unaligned start data b. the 32b-aligned
> data b. unaligned end. I think that the HW should be able to handle that.

Right, that's what I was expecting.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3BV14ACgkQJNaLcl1U
h9BKZAf6Ash1CMprp9CmtoZgXDlZGjI+I84fZ7x4ZvMSHOMZ20e7KMwVEKBJ4UH8
onKbrC/sLhV9dOTh4KdW9H7QnPp7NQPru6ZartbDCKHDT2wT7SJCXlQWapZrg5Gh
E/xH29aG6yQrIxTvYtsqNjBw7cheRBDQUTAvMH+rqNMLtOQVnWgh+Tf09izlS1ve
6vJrCROj/xO319Oc2iAhRGRbXgr++392iYarO3qdad6SSGFZFVKCs9lU/U+9I8Dz
KG2nKTMal8tnwJw4GRJ5PqPVsrs3+UYJwey6mbPVeIXfp1Oe2H8igZmXdmd4o9F2
OHTRDQDXOG8K/Opk2MV79xBmKG+pKw==
=S6Z7
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
