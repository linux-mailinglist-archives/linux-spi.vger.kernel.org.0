Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4187C54479D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiFIJdD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiFIJdC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 05:33:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B8374EE6
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 02:33:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nzEX7-0002mY-1C; Thu, 09 Jun 2022 11:32:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BC3AD8FEFA;
        Thu,  9 Jun 2022 09:32:51 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:32:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, ore@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <20220609093251.22l6farvsmggttz3@pengutronix.de>
References: <20220524091808.2269898-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67porcnrpubyut32"
Content-Disposition: inline
In-Reply-To: <20220524091808.2269898-1-david@protonic.nl>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--67porcnrpubyut32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 24.05.2022 11:18:08, David Jander wrote:
> This change gives a dramatic performance improvement in the hot path,
> since many costly spin_lock_irqsave() calls can be avoided.
>
> On an i.MX8MM system with a MCP2518FD CAN controller connected via SPI,
> the time the driver takes to handle interrupts, or in other words the time
> the IRQ line of the CAN controller stays low is mainly dominated by the
> time it takes to do 3 relatively short sync SPI transfers. The effect of
> this patch is a reduction of this time from 136us down to only 98us.
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: David Jander <david@protonic.nl>

This patch (cherry picked on top of v5.19-rc1) explodes on 32-bit SMP
ARMv7 (imx6q) with:

| [    0.397493] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
| [    0.397514] caller is debug_smp_processor_id+0x18/0x24
| [    0.397544] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g6ae0aec8a366 #181
| [    0.397559] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
| [    0.397566] Backtrace:
| [    0.397576]  dump_backtrace from show_stack+0x20/0x24
| [    0.397616]  r7:81024ffd r6:00000000 r5:81024ffd r4:60000013
| [    0.397621]  show_stack from dump_stack_lvl+0x60/0x78
| [    0.397644]  dump_stack_lvl from dump_stack+0x14/0x1c
| [    0.397664]  r7:81024ffd r6:80f652de r5:80bec180 r4:819a2500
| [    0.397669]  dump_stack from check_preemption_disabled+0xc8/0xf0
| [    0.397690]  check_preemption_disabled from debug_smp_processor_id+0x18/0x24
| [    0.397714]  r8:8119b7e0 r7:81205534 r6:819f5c00 r5:819f4c00 r4:c083d724
| [    0.397719]  debug_smp_processor_id from __spi_sync+0x78/0x220
| [    0.397746]  __spi_sync from spi_sync+0x34/0x4c
| [    0.397772]  r10:bb7bf4e0 r9:c083d724 r8:00000007 r7:81a068c0 r6:822a83c0 r5:c083d724
| [    0.397779]  r4:819f4c00
| [    0.397784]  spi_sync from spi_mem_exec_op+0x338/0x370
| [    0.397810]  r5:000000b4 r4:c083d910
| [    0.397815]  spi_mem_exec_op from spi_nor_read_id+0x98/0xdc
| [    0.397846]  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:82358040
| [    0.397852]  r4:819f7c40
| [    0.397856]  spi_nor_read_id from spi_nor_detect+0x38/0x114
| [    0.397878]  r7:82358040 r6:00000000 r5:819f7c40 r4:819f7c40
| [    0.397883]  spi_nor_detect from spi_nor_scan+0x11c/0xbec
| [    0.397910]  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:c083da4c r6:00000000 r5:00010101
| [    0.397916]  r4:819f7c40
| [    0.397921]  spi_nor_scan from spi_nor_probe+0x10c/0x2d0
| [    0.397946]  r10:bb7bf4e0 r9:bb7bf4d0 r8:00000000 r7:819f4c00 r6:00000000 r5:00000000
| [    0.397952]  r4:819f7c40

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--67porcnrpubyut32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKhvkAACgkQrX5LkNig
013s1ggAlLIe2Y2WSmR9QRJcxw0uo3de57ZltDusBoZdQN2ARl+++2qp0HMmcpQn
Ay3Uvf/IkzYxT9Xwwkg8pFdYsCEUAuGV36Hw6CfHDtGhjMJd3htpcf5PXTMG5t16
2T027o/qFMGM3w+ixgsWheg/esgcj0/8AiAc2w3xItJMEroYH8nxeZXC3wFWo3Ng
4jHd+AaLsr7ejSUGTKqJ8uhTdrax8R0JCgivtGkC1Z/PI9GH3KcZX7q/LW/BuEnI
agr8npMztVuYnUlyYAFLQgt455XVbI9rP+/y9voD1ea2J5alercj28FgIAt7ojq9
OtXJa+oZgp4Dp5q7gSkiiYaOvCVtPQ==
=pr55
-----END PGP SIGNATURE-----

--67porcnrpubyut32--
