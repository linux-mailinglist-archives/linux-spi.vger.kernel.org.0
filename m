Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB283E072A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 17:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfJVPUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 11:20:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387497AbfJVPUm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 11:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mOECADj6Dicthl/XJszjH7ZcS62Tu0/dvZtSt6Fycls=; b=bNvd0K5lrvwhT7MBg70/o2x0j
        abAgj+hZD9TRPcqSkDBo/iFaf9DWdZCx/bMHYBMi3ZZirLd8SUbZb75hMWl4pt0L6LzDfxfLUsV+z
        AK+I7DQs0oTEKnLjNzM/1JjCthjOYFNuWfmELJetq+hta7EbN81E3DYFT6O136sfejd3A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMvxg-0006uB-BV; Tue, 22 Oct 2019 15:20:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 81BD32743259; Tue, 22 Oct 2019 16:20:39 +0100 (BST)
Date:   Tue, 22 Oct 2019 16:20:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
Message-ID: <20191022152039.GH5554@sirena.co.uk>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk>
 <20191022102859.GA1928@salem.gmr.ssr.upm.es>
 <20191022112600.GD5554@sirena.co.uk>
 <20191022120610.GA28659@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <20191022120610.GA28659@salem.gmr.ssr.upm.es>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 02:06:11PM +0200, Alvaro Gamez Machado wrote:
> On Tue, Oct 22, 2019 at 12:26:00PM +0100, Mark Brown wrote:

> > This is still something that should be configured by the client driver,
> > if you send data with a different word size to that the client intends
> > it'll just get corrupted.

> The problem is that Xilinx's AXI Quad SPI core doesn't allow this. When
> instantiating the core you must choose *the* transfer width, not the
> *maximum* transfer width. So in my example above, no matter how I configure
> my IP core, linux'll believe that its datawidth is 8. I could override it
> hardcoding a 32 in spi-xilinx.c, but then what would happen with my other
> IP core that needs a datawidth of 8? Client code cannot configure IP core
> with a different datawidth because it simply does not allow it.

If the SPI controller can't cope with sending anything but 32 bits
that's fine, the slave still needs to know that it's supposed to be
handing the host controller data laid out in 32 bit words.  All the
components need to agree about how the data is supposed to be
interpreted.

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vHkYACgkQJNaLcl1U
h9DkFgf/T650X+w2L+/cNUgH9NS8yG/VU6E4kDyv+5ynCIPPkaLAUPDcPpG5OwH8
CaFcJ7hD2tkjnXAw4J3d7qYOyD3ePhfJR2yASyKBDP6rR6NDRwStNPAMgg87n+vr
yHEQCh+ZNKvdl7F16/qcZD69RfJCuLsIBov0KpYRUb99irIUwH3epftArxM5cRep
T6rBJvr0htBrGpzqOMRKNidY/8pCPBBPm7xxsBg/Yu+Ne1HyWqdTApuHUVame4+M
qwFFh3dxAz5JK7MAmD3tzymycoJZ2HEou8Z5Q4tg/dyw6kWTEkF49C+uVJ7opETN
PrrdzOpAUJlcTFXoRhuxVqeEgarGgg==
=acn7
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
