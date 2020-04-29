Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E661BDB91
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD2MNP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 08:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgD2MNN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 08:13:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A292087E;
        Wed, 29 Apr 2020 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588162392;
        bh=u4q8FeVjq66c39pqaDcuSEyHVkmprJELW74mmEQTIaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkccZMaFK0HPa/lbTJpwOfhl8YJedaGt+oqHcEse9oxecOG+ePMQl8+6lXN291eQt
         XMOEz6IrJ3WVM70u8VUu+lzZReL1NMjGZKzI6S/iVHo09sj1mB7r8KpyAoFiY7glgP
         IM3XoNOsXV/iAUpplEFGhw3FFVTD9pPI8zvfFoQM=
Date:   Wed, 29 Apr 2020 13:13:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, robh@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200429121310.GH4201@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
 <46f31699-e781-ae33-3ee5-d51e6940ee43@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline
In-Reply-To: <46f31699-e781-ae33-3ee5-d51e6940ee43@linux.intel.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 04:20:53PM +0800, Dilip Kota wrote:
> On 4/28/2020 7:10 PM, Daniel Schwierzeck wrote:

> > actually there is no real bottom half. Reading or writing the FIFOs is
> > fast and is therefore be done in hard IRQ context. But as the comment

> Doing FIFO r/w in threaded irqs shouldn't cause any impact on maximum
> transfer rate i think.

Have you actually tested this?  Generally adding extra latency is going
to lead to some opportunity for the hardware to idle and the longer the
hardware is idle the lower the throughput.

> Also the ISR should be quick enough, doing FIFO r/w in ISR adds up more
> latency to ISR.
> Handling the FIFOs r/w in threaded irq will be a better way.

Consider what happens on a heavily loaded system - the threaded
interrupt will have to be scheduled along with other tasks.

> > for lantiq_ssc_bussy_work() state, the driver needs some busy-waiting
> > after the last interrupt. I don't think it's worth to replace this with
> > threaded interrupts which add more runtime overhead and likely decrease
> > the maximum transfer speed.

> Workqueue has a higher chances of causing SPI transfers timedout.

because...?

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pb1UACgkQJNaLcl1U
h9B5Xwf9HYTpgwJhe8Mt24YHCYdheKLib494VcuElZXJPwV8qe4CbHLu0OaMB8Nt
eMnwvPeuQwMCZdAVlUONXcAhodLdAqnQ/vW4Pv3EmsvTsIcpdQwS9U3ECZpg3GsQ
2/h0SN8MUv4abWuaINGq2aSzrkEo54IdDbKL2hX/EBgb3eYEbslZLADMPrj1GbUq
XZ/+4/hZYBJGOU0GhMhEICTVLRRn3WaX7D7zsKnhYuJSBy0MawdkHcvbTbMf/5mb
ueROU1mpDvze2eNPtzaAT/IC63tb9DCL1j3MeVc7Vfr1zbaB/AWtMr4hxjr9+6jP
tC0FaIJds95B1JxelaCLXRuR7GA0mw==
=/9PQ
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--
