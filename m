Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1075E1D9B0E
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgESPYx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 11:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbgESPYx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 May 2020 11:24:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0AC2075F;
        Tue, 19 May 2020 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589901892;
        bh=uXgtrxBllmyAxiipQjmUF4iuuKFIpnIVqViudd5vXDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVpMUSYt4TyUe62g7t0y6BeE63xb5MQfBbW+Zv/6h74z3Uk5MxLpLurOUfD5Ca4Bn
         6j0Kj/FIu+TTPbmeIZiqNZKbSnXejQkqMkF8PfLgFVwErSF3SKHwcNvxxZD2s7+Zgq
         zkfMOxVeNVYA8ht7pn1fjQSbw9hE/60YQ+M0ugc8=
Date:   Tue, 19 May 2020 16:24:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-spi@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200519152449.GM4611@sirena.org.uk>
References: <20200519163353.20c03286@windsurf.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vLGWvOrvbSM0Ba8"
Content-Disposition: inline
In-Reply-To: <20200519163353.20c03286@windsurf.home>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7vLGWvOrvbSM0Ba8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 04:33:53PM +0200, Thomas Petazzoni wrote:

> perf record/report gives:

>     19.42%  spi1             [kernel.kallsyms]  [k] finish_task_switch
>     17.42%  kworker/u2:1-ev  [kernel.kallsyms]  [k] finish_task_switch
>      9.22%  irq/50-spi1.3    [kernel.kallsyms]  [k] atmel_spi_transfer_one_message
>      7.76%  irq/50-spi1.3    [kernel.kallsyms]  [k] finish_task_switch
>      4.15%  irq/50-spi1.3    [kernel.kallsyms]  [k] schedule_timeout
>      4.15%  kworker/0:2-eve  [kernel.kallsyms]  [k] finish_task_switch
>      2.25%  swapper          [kernel.kallsyms]  [k] arch_cpu_idle
>      1.94%  irq/50-spi1.3    [kernel.kallsyms]  [k] __spi_pump_messages
>      1.84%  irq/50-spi1.3    [kernel.kallsyms]  [k] __spi_validate
>      1.78%  irq/50-spi1.3    [kernel.kallsyms]  [k] spi_finalize_current_message

> Does the very high CPU time spent in finish_task_switch() simply means
> that we're scheduling too much ?

> Any hints on how to improve this situation ?

Not thinking about this too deeply...

The copybreak for DMA in spi-ateml is 16 bytes so at 20 byte reads
(assuming that's what actually ends up as a SPI transfer) it might be
worth looking at tuning that and seeing if PIO helps, though I'm not
seeing any DMA stuff showing up there.

The other thing that jumps out looking at the code is that in the
interrupts to complete transfers the driver will just complete() and
wake the main transfer thread up, for the reads where we always have two
transfers per message this will cause an extra context switch.  If the
driver were able to initiate the next transfer directly from interrupt
context then it should schedule less (and generally reduce latency too).

I can't really see much obvious in the serial driver - it might want to
consider error checking, or if it doesn't care if transfers complete it
might want to switch to async SPI calls, but nothing that looks like
there's anything obvious for SPI related that you could do here.

--7vLGWvOrvbSM0Ba8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7D+kEACgkQJNaLcl1U
h9Baowf/dMH/+H6hpRulCNduC2W84iy5zd72f4DwhZf4UVAYss2E2YDjdXks6fHS
GMowK9lsgSMny7wukcPczzxb5psrNP4eSvHQYd6xRPETFbg3nKNMlk8wh3WAwYgG
mjmgpkFVBAZp/WkdOJF8beYOJ1oJvItNOKAb83MLhyTp2KD6US0UtQBlaA/dUktf
v3LU0iu5nw6tIQaZagNSQBZAYxHsirHDmw/1uE1gW0y4O7TEzcvXqyiB5xMC9Tky
FiaSIX8nVm5UkbgF099cY95h3cerNbH13mEjWwxcI0lY3KVIpVVuZ5qltxtvI+uq
zT+zvJf13mGB/qzwQdtpZdBdSKZOxw==
=D039
-----END PGP SIGNATURE-----

--7vLGWvOrvbSM0Ba8--
