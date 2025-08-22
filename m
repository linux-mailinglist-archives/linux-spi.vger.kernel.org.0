Return-Path: <linux-spi+bounces-9591-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE5B30F78
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 08:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7941896F78
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552E2C326B;
	Fri, 22 Aug 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBaQGSq8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208F2264A8;
	Fri, 22 Aug 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845224; cv=none; b=L5PK5JSny2rqVHeE3gy3tyZMen7FISqRUScBapixIMYpT9A7qZHX3bxZTMLG6Xk1ecFsEWZm2Q+89xWnWc25WObz+GRB8lprmg9trIo5vyPa1ZSFTmGy65SPhm8bEJ9b3f0sBAYcd4LJUJJEXA5zF3vx5F6rSrEfe0IjkUO8UYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845224; c=relaxed/simple;
	bh=pgdQoQpkKmouBhmB/S83yq7pnMsP7sTE0C4LmNARxTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgZ+DJjy2KgZhjmPwJb+Vfs43mYHpRVaDe3uO81+bJPzfpbNytQ4rGy7wHxYOi1Q77AE5cx9B4lw3An1K5dJs9wupeJXfH2SFKO9Be9ee3Z6rq/fqa1Nf+CM7HwQjKxMoe97jVJKC33nqYg3haxFp2R0T2HkjNGmvRLZebQg1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBaQGSq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F62C4CEF1;
	Fri, 22 Aug 2025 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755845223;
	bh=pgdQoQpkKmouBhmB/S83yq7pnMsP7sTE0C4LmNARxTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBaQGSq8QQ/C2T41lmBISqdWNNFv6c806ZGjBbOLbC+SK651cFMYXiNnYsscAOkIb
	 xqpdQOOLFYFABLpfs1WSWn0X8jtPieRPnAC/VBS2I2QUOpgU1CdvR86LFLOi3inDUJ
	 C35LeREUIyevau0MwbuXbomFMYpO8xzP/+CDSjpqEY8/fBBour2yOgag/qJOrCqhP7
	 Pq21jIK3spbfHsSPVNJM/XD7VYgMSoSDkbmeddlH4gAnJ1AJXBz4Ivzw9hXnflIzLm
	 EIhbFstqPN/ojSfHXWXtjXgnUiB9e3ft/NBZ64gpc14qCVneIVumcnjz2WpLWRUPE+
	 jt3zH/oGo/D7w==
Date: Fri, 22 Aug 2025 08:46:59 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
Message-ID: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
 <aKcEYn_hX0ZIusne@lore-rh-laptop>
 <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ZbTqGGtz4KCqJOZ"
Content-Disposition: inline
In-Reply-To: <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>


--2ZbTqGGtz4KCqJOZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 21.08.2025 14:34, Lorenzo Bianconi wrote:
> >> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
> >>>> This patch series greatly improve airoha snfi driver and fix a
> >>>> number of serious bug.
> >>>>
> >>>> Fixed bugs:
> >>>>  * Fix reading/writing of flashes with more than one plane per lun
> >>>>  * Fix inability to read/write oob area
> >>>>  * Fill the buffer with 0xff before writing
> >>>>  * Fix reading of flashes supporting continuous reading mode
> >>>>  * Fix error paths
> >>>>
> >>>> Improvements:
> >>>>  * Add support of dual/quad wires spi modes in exec_op().
> >>>>  * Support of dualio/quadio flash reading commands
> >>>>  * Remove dirty hack that reads flash page settings from SNFI regist=
ers
> >>>>    during driver startup
> >>>>
> >>>> Unfortunately I am unable to test the driver with linux at the momen=
t,
> >>>> so only the following testing was done:
> >>> It seems to me this is quite an important rework of the driver. I wou=
ld prefer
> >>> to have some test results for this series. Are you able to run mtd_te=
st kernel
> >>> module for testing?
> >> I'll try to build latest openwrt with this patches=A0 and mtd_test ker=
nel
> >> module and try it on one of our boards.
> > what board are you using for testing? If it is based on Airoha-7581 you=
 could
> > use the following repo for testing.
> >
> > https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stab=
le
> >
> > Regards,
> > Lorenzo
> What tests do you suggest to run?

IIRC I run all of them. Can you please report even if there are some
improvements (or penalties) in read/write speed?

> I have a single flash I boot from. It have only 2 mtd partitions:
>=20
> [=A0=A0=A0 2.980849] spi-nand spi0.0: Micron SPI NAND was found.
> [=A0=A0=A0 2.986102] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page =
size:
> 2048, OOB size: 128
> [=A0=A0=A0 2.994493] 2 fixed-partitions partitions found on MTD device sp=
i0.0
> [=A0=A0=A0 3.000856] Creating 2 MTD partitions on "spi0.0":
> [=A0=A0=A0 3.005651] 0x000000000000-0x000000020000 : "bl2"
> [=A0=A0=A0 3.011247] 0x000000020000-0x000010000000 : "ubi"
>=20
> Most of tests are destructive. So If I use "bl2" or "ubi" partition for
> test, next time I will be unable to boot :-(

yes, I flashed the device after carrying out the test.

Regards,
Lorenzo

> Do you suggest to patch u-boot & linux to have more mtd partitions?
>=20
> This is the results of the only read-only test I found.
>=20
> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_test.ko
> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_readtest.ko dev=3D1
> [=A0 159.121706]
> [=A0 159.123220] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [=A0 159.129053] mtd_readtest: MTD device: 1
> [=A0 159.132898] mtd_readtest: MTD device size 268304384, eraseblock size
> 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock
> 64, OOB size 128
> [=A0 159.147008] mtd_test: scanning for bad eraseblocks
> [=A0 159.152141] mtd_test: scanned 2047 eraseblocks, 0 are bad
> [=A0 159.157549] mtd_readtest: testing page read
>=20
> Mikhail
>=20
> >> Actually patches can be divided on to parts:
> >> * fixes of current driver (patches 1-10)
> >> * change of behavior to avoid reading flash page settings from SNFI
> >> registers during driver startup (patches 11-14)
> >>
> >> The changes are based on the code we are using for more than 3 years. I
> >> adapt it to latest linux/u-boot code.
> >>
> >> Up to now the only known issue appears on en7523 chips only. Here a
> >> corresponding patch description (not added to this series)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D spi: airoha:
> >> en7523: workaround flash damaging if UART_TXD was short to GND We found
> >> that some serial console may pull TX line to GROUND during board boot
> >> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
> >> booting in RESERVED boot mode. It was found that some flashes operates
> >> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
> >> affected by the issue, Winbond flashes are NOT affected. Details:
> >> -------- DMA reading of odd pages on affected flashes operates
> >> incorrectly. Page reading offset (start of the page) on hardware level
> >> is replaced by 0x10. Thus results in incorrect data reading. Usage of
> >> UBI make things even worse. Any attempt to access UBI leads to ubi
> >> damaging. As result OS loading becomes impossible. Non-DMA reading is
> >> OK. =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Regards,
> >> Mikhail
> >>
> >>
> >>> Regards,
> >>> Lorenzo
> >>>
> >>>>  * Driver compiles without error.
> >>>>  * All changes were tested with corresponding u-boot driver. U-Boot
> >>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
> >>>>    additional fixes for continuous mode.
> >>>>
> >>>> Changes v2:
> >>>>  * minor fix
> >>>>  * add comments to code
> >>>>
> >>>> Changes v3:
> >>>>  * add patch to prevent continuous reading
> >>>>
> >>>> Mikhail Kshevetskiy (14):
> >>>>   spi: airoha: return an error for continuous mode dirmap creation c=
ases
> >>>>   spi: airoha: remove unnecessary restriction length
> >>>>   spi: airoha: add support of dual/quad wires spi modes
> >>>>   spi: airoha: remove unnecessary switch to non-dma mode
> >>>>   spi: airoha: unify dirmap read/write code
> >>>>   spi: airoha: switch back to non-dma mode in the case of error
> >>>>   spi: airoha: fix reading/writing of flashes with more than one pla=
ne
> >>>>     per lun
> >>>>   spi: airoha: support of dualio/quadio flash reading commands
> >>>>   spi: airoha: allow reading/writing of oob area
> >>>>   spi: airoha: buffer must be 0xff-ed before writing
> >>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
> >>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG=
 and
> >>>>     REG_SPI_NFI_SECCUS_SIZE registers
> >>>>   spi: airoha: set custom sector size equal to flash page size
> >>>>   spi: airoha: avoid reading flash page settings from SNFI registers
> >>>>     during driver startup
> >>>>
> >>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++--------------=
---
> >>>>  1 file changed, 260 insertions(+), 248 deletions(-)
> >>>>
> >>>> --=20
> >>>> 2.50.1
> >>>>

--2ZbTqGGtz4KCqJOZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKgSYAAKCRA6cBh0uS2t
rCkLAQCXPfNkfjRYbh1mtbx8El7/T7e7Gh35r5YXdJopc728nAD/SYvKdetOGOSV
nyQzX0+J8Iixf9sztahWg2BVOfRtzQY=
=VzuW
-----END PGP SIGNATURE-----

--2ZbTqGGtz4KCqJOZ--

