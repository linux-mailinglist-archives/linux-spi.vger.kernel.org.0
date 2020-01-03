Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0712F287
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2020 02:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgACBEV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 20:04:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgACBET (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 20:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ozic6TqYruSpEFOoFH0HYCbh75txsD2Py+nk3nYG6TY=; b=GUSzzbSipkopZxcOEAsxR1eXx
        +naIE9vf2wwM0xnkUQ4Z2N4Bo6DVI2m2mNhzq0GmRjcyej8pOkgi5liUyMIjKQ3lDEElkLYINxpjV
        TmUKS7jJtgGh3BkRKS20HozIzTdKDvJVL3FCRY+ajYYX0nsPVrYjh3K20F2RcIVsdLo2k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1inBNq-0003Mk-Mz; Fri, 03 Jan 2020 01:04:10 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 14FA9D057C6; Fri,  3 Jan 2020 01:04:09 +0000 (GMT)
Date:   Fri, 3 Jan 2020 01:04:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kongxinwei <kong.kongxinwei@hisilicon.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, fengsheng <fengsheng5@huawei.com>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Message-ID: <20200103010409.GG3897@sirena.org.uk>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
 <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 28, 2019 at 04:31:53PM +0800, kongxinwei wrote:

> > I'd be much more comfortable here if I understood what this was
> > supposed to be syncing - what exactly gets flushed here and why
> > is a memory barrier enough to ensure it's synced?  A comment in
> > the code would be especially good so anyone modifying the code
> > understands this in future.

> Because of out-of-order execution about some CPU architecture,
> In this debug stage we find Completing spi interrupt enable ->
> prodrucing TXEI interrupt -> running "interrupt_transfer" function
> will prior to set "dw->rx and dws->rx_end" data, so it will result
> in SPI sending error

Could you update the commit message to say that, and ideally also
add a comment saying something like "Ensure dw->rx and dw->rx_end
are visible" please?

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4OkwgACgkQJNaLcl1U
h9AkFgf/fypiFJ4eRlJVOmkAYnGY01lAChSELOS/91cDAaOXJSQhz/hwB/cdeHjq
2KYpCiICZDeG8FB6y6dvAWUMCkVxGH0WVGS9/OlnmI+aDoPjqyiyJ5R1a+bRBAcE
YAaX12ARLr0uj9l9Fh6hhZxScRgit+ZKRB12T77pdyFFcoCh4kJLSD58D+78OmEO
YUXkkBxX7cayLE5CKvl2UrQp8K18T4EKZ4YX7jDCUuY4wXkoScvm7G3ik25DhEJR
jenBxAnbnw0De745jFhdI5VJygGUOF3caiWT3wc2tOIQwI1LJThI0cp4d3DRbphU
XpWJcoIuRXqY+TfLjulA4WjTtGsDew==
=Xa85
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
