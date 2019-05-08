Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93917F35
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEHRk0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 13:40:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbfEHRk0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 May 2019 13:40:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B3AFAB7F;
        Wed,  8 May 2019 17:40:24 +0000 (UTC)
Message-ID: <b30ad865e0dee8d62defb2c41f5eb7d272765233.camel@suse.de>
Subject: Re: SPI regression with today's build
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Date:   Wed, 08 May 2019 19:40:22 +0200
In-Reply-To: <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
         <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
         <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qiLPKIjNSnDiHE/mTvO4"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-qiLPKIjNSnDiHE/mTvO4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-08 at 19:33 +0200, Noralf Tr=C3=B8nnes wrote:
> [cc:Martin]
>=20
> Den 08.05.2019 19.07, skrev Nicolas Saenz Julienne:
> > Small follow-up on this, and CCing Noralf as I forgot to add him on the=
 last
> > e-mail.
> >=20
> > On Wed, 2019-05-08 at 17:01 +0200, Nicolas Saenz Julienne wrote:
> > > Hi, This has been seen on a Raspberry Pi 3B+, using a w5500 Ethernet =
SPI
> > > interface on the main SPI controller. The commit that introduced the =
issue
> > > seems to be:
> > >=20
> > > c9ba7a16d0f1d2b1e70d47296eca5f612c753825 "spi: Release spi_res after
> > > finalizing message"
> > >=20
> > > Here's the kernel log:
> > >=20
> > > [  170.085704] Unable to handle kernel paging request at virtual addr=
ess
> > > 0000000000100000
> > > [  170.097773] Mem abort info:
> > > [  170.101873]   ESR =3D 0x86000004
> > > [  170.105222]   Exception class =3D IABT (current EL), IL =3D 32 bit=
s
> > > [  170.111599]   SET =3D 0, FnV =3D 0
> > > [  170.115040]   EA =3D 0, S1PTW =3D 0
> > > [  170.118484] user pgtable: 4k pages, 48-bit VAs, pgdp =3D 00000000e=
d70a017
> > > [  170.125511] [0000000000100000] pgd=3D0000000000000000
> > > [  170.130872] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > > [  170.136532] Modules linked in: fuse vc4 cec drm_kms_helper cfbfill=
rect
> > > brcmfmac cfbimgblt panel_raspberrypi_touchscreen cfbcopyarea drm hci_=
uart
> > > btbcm brcmutil bluetooth cfg80211 w5100_spi bcm2835_v4l2(C) w5100
> > > v4l2_common
> > > videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common
> > > videodev
> > > microchip lan78xx crct10dif_ce drm_panel_orientation_quirks i2c_gpio
> > > ecdh_generic edt_ft5x06 raspberrypi_hwmon ecc media rfkill snd_bcm283=
5(C)
> > > input_polldev bcm2835_thermal spi_bcm2835 bcm2835_dma pwm_bcm2835
> > > bcm2835_rng
> > > rng_core virt_dma ip_tables x_tables ipv6
> > > [  170.186506] Process spi0 (pid: 1335, stack limit =3D 0x00000000fb9=
981f5)
> > > [  170.193133] CPU: 0 PID: 1335 Comm: spi0 Tainted:
> > > G        WC        5.1.0-
> > > nico+ #116
> > > [  170.200985] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT=
)
> > > [  170.207343] pstate: 60000005 (nZCv daif -PAN -UAO)
> > > [  170.212205] pc : 0x100000
> > > [  170.214864] lr : spi_res_release.part.9+0x7c/0xb0
> > > [  170.219631] sp : ffff000011303ce0
> > > [  170.222987] x29: ffff000011303ce0 x28: ffff00001122bc30=20
> > > [  170.228373] x27: 00000000cccccccd x26: ffff000010ee96c8=20
> > > [  170.233759] x25: dead000000000100 x24: dead000000000200=20
> > > [  170.239143] x23: ffff000010d28b78 x22: ffff80002fa60e80=20
> > > [  170.244528] x21: ffff80002567b000 x20: ffff00001122bc88=20
> > > [  170.249914] x19: ffff00001122bc30 x18: 0000000000000020=20
> > > [  170.255297] x17: 0000000000000000 x16: 0000000000000000=20
> > > [  170.260682] x15: ffffffffffffffff x14: ffff000010ee96c8=20
> > > [  170.266068] x13: ffff000010fd3388 x12: ffff000010fd2fb7=20
> > > [  170.271453] x11: 0000000000000000 x10: ffff000011303ce0=20
> > > [  170.276840] x9 : ffff000011303ce0 x8 : 000000000000000f=20
> > > [  170.282226] x7 : 0000000000000005 x6 : ffff000010fd264d=20
> > > [  170.287612] x5 : 0000000000000000 x4 : 0000000000000000=20
> > > [  170.292998] x3 : 0000000000100000 x2 : ffff80002fa60e98=20
> > > [  170.298384] x1 : ffff00001122bc30 x0 : ffff80002567b000=20
> > > [  170.303769] Call trace:
> > > [  170.306247]  0x100000
> > > [  170.308550]  spi_transfer_one_message+0x268/0x388
> > > [  170.313321]  __spi_pump_messages+0x200/0x508
> > > [  170.317651]  spi_pump_messages+0x14/0x20
> > > [  170.321630]  kthread_worker_fn+0xa8/0x188
> > > [  170.325694]  kthread+0x120/0x128
> > > [  170.328966]  ret_from_fork+0x10/0x18
> > > [  170.332595] Code: bad PC value
> > > [  170.335694] ---[ end trace d054c016d94fa755 ]---
> >=20
> > It seems the SPI controller thread is racing with the device's thread.
> > Something like this:
> >=20
> >      SPI Controller Thread                       SPI Device Thread
> >=20
> > 					    -> spi_sync_transfer() creates
> > 					       spi_message on stack then
> > 					       sleeps until finished
> >=20
> > 			[SPI transfer happens...]
> >=20
> > -> spi_finalize_current_message()
> >    which wakes up SPI Device Thread
> >=20
> >                                             -> spi_sync_transfer() retu=
rns,
> > the
> > 					       message disapears from the stack
> >=20
> > -> spi_res_release() there is no more
> >    spi_message and the memory is
> >    potentialy used for something else
> >=20
> > I've been looking at the spi_split_transfers_maxsize() code and can't t=
hink
> > of
> > a reason why spi_res_release() couldn't be placed before
> > spi_finalize_current_message(). Which would solve the issue, but I gues=
s
> > Noralf
> > has a better perspective on the topic.
> >=20
>=20
> The problem was that spi_res_release() restored the original transfers
> before spi_unmap_msg() is called in spi_finalize_current_message() thus
> dma unmapping the original transfers, not the split ones that was mapped.

Ok, now I get it.

> This is the accompanying change to the driver that hasn't been applied:
> [v5,3/4] spi/spi-bcm2835: Split transfers that exceed DLEN
> https://patchwork.kernel.org/patch/10899587/

It's applied :). I'm actually preparing a patch on top of that so it only
splits the messages if DMA is really available.

> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
> suggestions, I think we should just revert this patch.
>=20
> Apparently I need to go back to the drawing board with this.
>=20
> Noralf.

Regards,
Nicolas


--=-qiLPKIjNSnDiHE/mTvO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzTFIYACgkQlfZmHno8
x/5HxAgAi6MdS4tbB7+iu87efYlMouCktTOVEljvUgfm89OF425e+BOLuxwbqEZ/
5gbG02V7+z6RzyFc/hAsdNi97IgMdh33AvfbT6tryaYm+EzAZv56WDS0ePb18YQ4
cHAiBV8KW5QNkECJIzL2ROxDVmhelHelPjyFux4x1+CKN/mEt104Wl8f0mXkOUON
8Ha3efiMZNL7+/IhFgDmi2/p9/xSj2WuqrpXZ8ui4nq/vNtGbFFh91ZV3wR5WujH
srH9YVNMksPrevpGZOhTyk9DQnNC8rp6zUI+hGL2kcrwEn6DZ+2IjcndKLMnSnIw
H3InK/mHxaDWbKY8dnS2C1kQhurvyw==
=PrPX
-----END PGP SIGNATURE-----

--=-qiLPKIjNSnDiHE/mTvO4--

