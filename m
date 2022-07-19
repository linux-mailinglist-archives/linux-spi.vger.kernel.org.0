Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5AB579380
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGSGwX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSGwX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 02:52:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C5275C8
        for <linux-spi@vger.kernel.org>; Mon, 18 Jul 2022 23:52:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDh5b-0002mA-60; Tue, 19 Jul 2022 08:52:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E8FF3B3C41;
        Tue, 19 Jul 2022 06:52:13 +0000 (UTC)
Date:   Tue, 19 Jul 2022 08:52:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 05/10] spi: bcm2835: Drop dma_pending flag
Message-ID: <20220719065213.dxplydnkxcst4v7e@pengutronix.de>
References: <cover.1568187525.git.lukas@wunner.de>
 <062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d.1568187525.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ntj44kyht5x3yuib"
Content-Disposition: inline
In-Reply-To: <062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d.1568187525.git.lukas@wunner.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ntj44kyht5x3yuib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.09.2019 12:15:30, Lukas Wunner wrote:
> The BCM2835 SPI driver uses a flag to keep track of whether a DMA
> transfer is in progress.
>
> The flag is used to avoid terminating DMA channels multiple times if a
> transfer finishes orderly while simultaneously the SPI core invokes the
> ->handle_err() callback because the transfer took too long.  However
> terminating DMA channels multiple times is perfectly fine, so the flag
> is unnecessary for this particular purpose.
>
> The flag is also used to avoid invoking bcm2835_spi_undo_prologue()
> multiple times under this race condition.  However multiple *concurrent*
> invocations can no longer happen since commit 2527704d8411 ("spi:
> bcm2835: Synchronize with callback on DMA termination") because the
> ->handle_err() callback now uses the _sync() variant when terminating
> DMA channels.
>
> The only raison d'=C3=AAtre of the flag is therefore that
> bcm2835_spi_undo_prologue() cannot cope with multiple *sequential*
> invocations.  Achieve that by setting tx_prologue to 0 at the end of
> the function.  Subsequent invocations thus become no-ops.
>
> With that, the dma_pending flag becomes unnecessary, so drop it.
>
> Tested-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Tested-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Stefan Wahren <wahrenst@gmx.net>
> Acked-by: Martin Sperl <kernel@martin.sperl.org>

I think this patch breaks the bcm2835_spi_handle_err() function, which
may be called for non-DMA transfers, too. In my test case a non DMA, non
polling transfer runs into a timeout and produces this backtrace:

| [ 1651.800430] spidev spi3.0: SPI transfer timed out  =20
| [ 1651.800468] Internal error: Oops: 206 [#1] PREEMPT_RT SMP ARM
| [ 1651.800473] Modules linked in: can_raw can brcmfmac mcp251xfd can_dev =
spidev brcmutil bcm2835_codec(C) bcm2835_v4l2(C) v4l2_mem2mem bcm2835_isp(C=
) videobuf2_vmalloc bcm2835_mmal_vchiq(C) cfg80211 videobuf2_dma_contig dwc=
2 videobuf2_memops videobuf2_v4l2 videobuf2_common
| videodev raspberrypi_hwmon vc_sm_cma(C) rfkill roles spi_bcm2835aux spi_b=
cm2835 mc rpivid_mem uio_pdrv_genirq uio drm fuse drm_panel_orientation_qui=
rks backlight ip_tables x_tables ipv6
| [ 1651.800533] CPU: 1 PID: 766 Comm: SpiCanTest Tainted: G         C     =
   5.15.40-rt43-v7l+ #2
| [ 1651.800538] Hardware name: BCM2711
| [ 1651.800540] PC is at bcm2835_spi_handle_err+0x20/0xe0 [spi_bcm2835]
| [ 1651.800555] LR is at spi_transfer_one_message+0x54c/0x68c
| [ 1651.800566] pc : [<bf17ce9c>]    lr : [<c0a26000>]    psr: a0030113
| [ 1651.800569] sp : c2947d50  ip : c2947d70  fp : c2947d6c
| [ 1651.800572] r10: c21ce2f8  r9 : ffffff92  r8 : c1558340
| [ 1651.800574] r7 : c2947eac  r6 : 00000000  r5 : c21ce000  r4 : c21ce3c0
| [ 1651.800577] r3 : bf17ce7c  r2 : 00000000  r1 : c2947eac  r0 : c21ce000
| [ 1651.800580] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
| [ 1651.800584] Control: 30c5383d  Table: 03049980  DAC: 55555555
| [ 1651.800587] Register r0 information: slab kmalloc-2k start c21ce000 po=
inter offset 0 size 2048
| [ 1651.800599] Register r1 information: non-slab/vmalloc memory
| [ 1651.800604] Register r2 information: NULL pointer
| [ 1651.800608] Register r3 information: 5-page vmalloc region starting at=
 0xbf17c000 allocated at load_module+0xc98/0x2bc8
| [ 1651.800618] Register r4 information: slab kmalloc-2k start c21ce000 po=
inter offset 960 size 2048
| [ 1651.800627] Register r5 information: slab kmalloc-2k start c21ce000 po=
inter offset 0 size 2048
| [ 1651.800636] Register r6 information: NULL pointer
| [ 1651.800639] Register r7 information: non-slab/vmalloc memory
| [ 1651.800643] Register r8 information: non-slab/vmalloc memory
| [ 1651.800646] Register r9 information: non-paged memory
| [ 1651.800650] Register r10 information: slab kmalloc-2k start c21ce000 p=
ointer offset 760 size 2048
| [ 1651.800658] Register r11 information: non-slab/vmalloc memory
| [ 1651.800662] Register r12 information: non-slab/vmalloc memory
| [ 1651.800665] Process SpiCanTest (pid: 766, stack limit =3D 0x071eb77b)
| [ 1651.800669] Stack: (0xc2947d50 to 0xc2948000)
| [ 1651.800673] 7d40:                                     c3dada40 c4d9238=
0 c21ce000 c2947eac
| [ 1651.800678] 7d60: c2947dcc c2947d70 c0a26000 bf17ce88 c2947db4 0000000=
0 c3dad800 c3dad800
| [ 1651.800682] 7d80: 0147ae0e c10f7fc4 c140756f c21ce2f8 ffffe000 c140689=
c 00000000 c3dada40
| [ 1651.800686] 7da0: c21ce210 c21ce000 00000000 bf17d050 c2947ed0 c3dada4=
0 c21ce2f8 c2947eac
| [ 1651.800689] 7dc0: c2947e0c c2947dd0 c0a281a0 c0a25ac0 c025643c d55cd1f=
7 c21ce210 c3dad800
| [ 1651.800693] 7de0: c2947eac c21ce000 c3dad800 c2947eac c21ce000 c3dada4=
0 c21ce2f8 c0a23fc0
| [ 1651.800697] 7e00: c2947e5c c2947e10 c0a28920 c0a27dac c21ce288 c21ce23=
0 00000000 00000000
| [ 1651.800700] 7e20: c2947e20 c2947e20 c0d398d4 d55cd1f7 c2947e5c c3dad80=
0 c2947eac c3dad800
| [ 1651.800704] 7e40: c44987c0 c44987c4 c44987e0 000000ff c2947e74 c2947e6=
0 c0a28a1c c0a28700
| [ 1651.800707] 7e60: c3dad800 c36459e0 c2947f14 c2947e78 bf223a5c c0a289f=
4 c2947ee8 c44987c4
| [ 1651.800711] 7e80: 00000001 c4d92380 c44987e0 c3dad800 c36459c0 c44987c=
0 bf226000 000000ff
| [ 1651.800714] 7ea0: c36459e0 c4412100 ffffe000 c4d923e0 c4d923e0 c3dad80=
0 00000000 c0a23388
| [ 1651.800718] 7ec0: c2947e18 000000ff 00000000 ffffff92 c2947ed0 c2947ed=
0 00000000 c2947edc
| [ 1651.800721] 7ee0: c2947edc d55cd1f7 b6bd4cb0 40206b00 00000000 c50b200=
1 b6bd4cb0 c50b2000
| [ 1651.800725] 7f00: 00000003 c470a780 c2947fa4 c2947f18 c04726f4 bf22340=
8 b6f3c330 00000193
| [ 1651.800728] 7f20: c0200244 b6bd4cf0 00000010 00000000 00000673 c08601c=
c c2947f74 c2947f48
| [ 1651.800732] 7f40: c02b6cf0 c08601b8 00000673 00000000 2228e32f 0000000=
0 c2947f74 d55cd1f7
| [ 1651.800735] 7f60: b6bd4cf0 00000001 c2947fa4 c2947f78 c02c92b8 d55cd1f=
7 00000673 00000003
| [ 1651.800739] 7f80: 005020d0 00502000 00000036 c0200244 c2946000 0000003=
6 00000000 c2947fa8
| [ 1651.800742] 7fa0: c0200040 c04725e0 00000003 005020d0 00000003 40206b0=
0 b6bd4cb0 00000000
| [ 1651.800746] 7fc0: 00000003 005020d0 00502000 00000036 2202be12 b6f3501=
0 00000000 b6bd4e90
| [ 1651.800749] 7fe0: 00502044 b6bd4c74 004f17eb b6cd6da8 400e0030 0000000=
3 00000000 00000000
| [ 1651.800751] Backtrace:
| [ 1651.800754] [<bf17ce7c>] (bcm2835_spi_handle_err [spi_bcm2835]) from [=
<c0a26000>] (spi_transfer_one_message+0x54c/0x68c)
| [ 1651.800768]  r7:c2947eac r6:c21ce000 r5:c4d92380 r4:c3dada40
| [ 1651.800770] [<c0a25ab4>] (spi_transfer_one_message) from [<c0a281a0>] =
(__spi_pump_messages+0x400/0x930)
| [ 1651.800781]  r10:c2947eac r9:c21ce2f8 r8:c3dada40 r7:c2947ed0 r6:bf17d=
050 r5:00000000
| [ 1651.800783]  r4:c21ce000
| [ 1651.800785] [<c0a27da0>] (__spi_pump_messages) from [<c0a28920>] (__sp=
i_sync+0x22c/0x2f4)
| [ 1651.800795]  r10:c0a23fc0 r9:c21ce2f8 r8:c3dada40 r7:c21ce000 r6:c2947=
eac r5:c3dad800
| [ 1651.800797]  r4:c21ce000
| [ 1651.800798] [<c0a286f4>] (__spi_sync) from [<c0a28a1c>] (spi_sync+0x34=
/0x4c)
| [ 1651.800808]  r10:000000ff r9:c44987e0 r8:c44987c4 r7:c44987c0 r6:c3dad=
800 r5:c2947eac
| [ 1651.800810]  r4:c3dad800

> ---
>  drivers/spi/spi-bcm2835.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index f79f04ea42e5..532c58bcfd45 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
[...]
> @@ -927,11 +921,10 @@ static void bcm2835_spi_handle_err(struct spi_contr=
oller *ctlr,
>  	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
>
>  	/* if an error occurred and we have an active dma, then terminate */
> -	if (cmpxchg(&bs->dma_pending, true, false)) {
> -		dmaengine_terminate_sync(ctlr->dma_tx);
> -		dmaengine_terminate_sync(ctlr->dma_rx);
> -		bcm2835_spi_undo_prologue(bs);
> -	}
> +	dmaengine_terminate_sync(ctlr->dma_tx);
> +	dmaengine_terminate_sync(ctlr->dma_rx);

=2E.. because the ctrl->dma_tx and ->dma_rx are NULL.

> +	bcm2835_spi_undo_prologue(bs);
> +
>  	/* and reset */
>  	bcm2835_spi_reset_hw(ctlr);
>  }

The question is: Why runs the IRQ based transfer into a timeout? The
kernel that produces the crash has ecfbd3cf3b8b ("spi: bcm2835: Enable
shared interrupt support") applied (which was reverted on mainline in a
later patch).

I'll create a patch to fix the NULL pointer deref. As a interrupt based
transfer might run into a timeout for other reasons, too. So better
avoid a kernel crash in that case.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ntj44kyht5x3yuib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLWVJkACgkQrX5LkNig
011R3Qf+PgWqQQYhQt26IaVXzce3zQ7cE09ZERDMsxs+fsslNa6rVvJVedaviRdP
Ur3yHglQot5aD7+EYi930aGrrhrbzeddRysxzJGT9bgrWNx8u0WRD4WZh95X2Ato
eaA1knx52p/0a3a0uYg9D6KiKuwZsortvvXpic5Q4WvVvxaq2RUClFT+GfVbF8i4
EN8VPG5zYpXu3XOOtT85U9M3J+95Ct6RhZBBdUhfKsbDgWsz3aPDOcywH46+UEtG
4ii8qdq1J7T1mNTcQv6HuhIW3fAk5dyuJ2wOKCq3Jlsh0AbCTqgjMt9ZnprJJ0cd
EMRwH/HM5mBJC04rxwhMgupEdCKVrw==
=9oYQ
-----END PGP SIGNATURE-----

--ntj44kyht5x3yuib--
