Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779F817EDB
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEHRHT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 13:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfEHRHT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 May 2019 13:07:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11583AF6D;
        Wed,  8 May 2019 17:07:17 +0000 (UTC)
Message-ID: <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
Subject: Re: SPI regression with today's build
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        noralf@tronnes.org
Date:   Wed, 08 May 2019 19:07:15 +0200
In-Reply-To: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SB4OXbres4d+dyjP75sC"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-SB4OXbres4d+dyjP75sC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Small follow-up on this, and CCing Noralf as I forgot to add him on the las=
t
e-mail.

On Wed, 2019-05-08 at 17:01 +0200, Nicolas Saenz Julienne wrote:
> Hi, This has been seen on a Raspberry Pi 3B+, using a w5500 Ethernet SPI
> interface on the main SPI controller. The commit that introduced the issu=
e
> seems to be:
>=20
> c9ba7a16d0f1d2b1e70d47296eca5f612c753825 "spi: Release spi_res after
> finalizing message"
>=20
> Here's the kernel log:
>=20
> [  170.085704] Unable to handle kernel paging request at virtual address
> 0000000000100000
> [  170.097773] Mem abort info:
> [  170.101873]   ESR =3D 0x86000004
> [  170.105222]   Exception class =3D IABT (current EL), IL =3D 32 bits
> [  170.111599]   SET =3D 0, FnV =3D 0
> [  170.115040]   EA =3D 0, S1PTW =3D 0
> [  170.118484] user pgtable: 4k pages, 48-bit VAs, pgdp =3D 00000000ed70a=
017
> [  170.125511] [0000000000100000] pgd=3D0000000000000000
> [  170.130872] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [  170.136532] Modules linked in: fuse vc4 cec drm_kms_helper cfbfillrect
> brcmfmac cfbimgblt panel_raspberrypi_touchscreen cfbcopyarea drm hci_uart
> btbcm brcmutil bluetooth cfg80211 w5100_spi bcm2835_v4l2(C) w5100 v4l2_co=
mmon
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videod=
ev
> microchip lan78xx crct10dif_ce drm_panel_orientation_quirks i2c_gpio
> ecdh_generic edt_ft5x06 raspberrypi_hwmon ecc media rfkill snd_bcm2835(C)
> input_polldev bcm2835_thermal spi_bcm2835 bcm2835_dma pwm_bcm2835 bcm2835=
_rng
> rng_core virt_dma ip_tables x_tables ipv6
> [  170.186506] Process spi0 (pid: 1335, stack limit =3D 0x00000000fb9981f=
5)
> [  170.193133] CPU: 0 PID: 1335 Comm: spi0 Tainted: G        WC        5.=
1.0-
> nico+ #116
> [  170.200985] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
> [  170.207343] pstate: 60000005 (nZCv daif -PAN -UAO)
> [  170.212205] pc : 0x100000
> [  170.214864] lr : spi_res_release.part.9+0x7c/0xb0
> [  170.219631] sp : ffff000011303ce0
> [  170.222987] x29: ffff000011303ce0 x28: ffff00001122bc30=20
> [  170.228373] x27: 00000000cccccccd x26: ffff000010ee96c8=20
> [  170.233759] x25: dead000000000100 x24: dead000000000200=20
> [  170.239143] x23: ffff000010d28b78 x22: ffff80002fa60e80=20
> [  170.244528] x21: ffff80002567b000 x20: ffff00001122bc88=20
> [  170.249914] x19: ffff00001122bc30 x18: 0000000000000020=20
> [  170.255297] x17: 0000000000000000 x16: 0000000000000000=20
> [  170.260682] x15: ffffffffffffffff x14: ffff000010ee96c8=20
> [  170.266068] x13: ffff000010fd3388 x12: ffff000010fd2fb7=20
> [  170.271453] x11: 0000000000000000 x10: ffff000011303ce0=20
> [  170.276840] x9 : ffff000011303ce0 x8 : 000000000000000f=20
> [  170.282226] x7 : 0000000000000005 x6 : ffff000010fd264d=20
> [  170.287612] x5 : 0000000000000000 x4 : 0000000000000000=20
> [  170.292998] x3 : 0000000000100000 x2 : ffff80002fa60e98=20
> [  170.298384] x1 : ffff00001122bc30 x0 : ffff80002567b000=20
> [  170.303769] Call trace:
> [  170.306247]  0x100000
> [  170.308550]  spi_transfer_one_message+0x268/0x388
> [  170.313321]  __spi_pump_messages+0x200/0x508
> [  170.317651]  spi_pump_messages+0x14/0x20
> [  170.321630]  kthread_worker_fn+0xa8/0x188
> [  170.325694]  kthread+0x120/0x128
> [  170.328966]  ret_from_fork+0x10/0x18
> [  170.332595] Code: bad PC value
> [  170.335694] ---[ end trace d054c016d94fa755 ]---

It seems the SPI controller thread is racing with the device's thread.
Something like this:

     SPI Controller Thread                       SPI Device Thread

					    -> spi_sync_transfer() creates
					       spi_message on stack then
					       sleeps until finished

			[SPI transfer happens...]

-> spi_finalize_current_message()
   which wakes up SPI Device Thread

                                            -> spi_sync_transfer() returns,=
 the
					       message disapears from the stack

-> spi_res_release() there is no more
   spi_message and the memory is
   potentialy used for something else

I've been looking at the spi_split_transfers_maxsize() code and can't think=
 of
a reason why spi_res_release() couldn't be placed before
spi_finalize_current_message(). Which would solve the issue, but I guess No=
ralf
has a better perspective on the topic.

Regards,
Nicolas


--=-SB4OXbres4d+dyjP75sC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzTDMMACgkQlfZmHno8
x/4jOAf/VtMZ/D4uc8Jm/6XBbsiHZcfAXwUv0wkW8Nwha//0Y4gXJe8RX+rWeUiv
41XAXSac0u/oe/NECu+wm84C+3p4N8tYJlu9KL/CiyJxt2irlsnRLwwMhLF/AYhQ
IkccVssmMf77V6/Oyb+EGW9coU4ey+3qml6UHR/TGbHypvlDyx51pqMk/9Yt4Dh8
t61OqOhoWa6U0xLrlGWtd0tFuAdDzlwblwf9Q7zeu/W14kLhmg/XcTyXYSDtmfxf
pSpccUFPlIaHraUknDQu/twvx6UHZLwDXwLqiosFhu587G7cJs82bjAzLHXq+BA3
4wpvUi5AaLC5NDSJL98MEY1r1wXsRA==
=a33m
-----END PGP SIGNATURE-----

--=-SB4OXbres4d+dyjP75sC--

