Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62A2A32A7
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBSRF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 13:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKBSRF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:05 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD32F22226;
        Mon,  2 Nov 2020 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341024;
        bh=2/odKowhAlWAtshuYHyu0gkDHZKZNXHMacRxuGz6efU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tve+pgqJvczxkHtBcU8mFT2JBGU7D7mzy7I4hbA813eOfsbURuQYOLc7D2JyRDPaS
         PS7KuTSBvySF7uSs1qMaKKFPke7NqRB3zCnCa77cJceIAuLy1qQkdIUIUdVSSEYD3F
         AglXH5ZYoU5QHUIGBQ+VQ+oDSefSME24bWwHO9Jk=
Date:   Mon, 2 Nov 2020 18:16:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Subject: Re: [PATCH] spi: add runtime PM for transfer_one_message
Message-ID: <20201102181655.GC5014@sirena.org.uk>
References: <20201102112239.19218-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20201102112239.19218-1-zhang.lyra@gmail.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2020 at 07:22:39PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>

> Before transfer message, spi devices probably have been in runtime suspended,
> that would cause the kernel crash on some platforms once access spi
> registers, such as on Unisoc's SoCs. The spi devices can be suspended
> until message transfer completed.

This commit message is a bit hard to follow so I don't really understand
what the issue is.  We only ever call transfer_one_message() from within
__spi_pump_messages() which already handles auto_runtime_pm so I'm not
seeing the situation where we might get to transfer_one_message()
without having already runtime resumed the controller.  What exactly is
the error situation here?  This code has been around for a while and I'm
not aware of reports of issues here and I can't see anything unusual
that the Spreadtrum driver is doing.

Also why are we doing this in transfer_one_message() where it will only
work for controllers using that?  If we're missing runtime PM in some
paths then presumably controllers with a custom implementation are also
going to be affected as well, auto_runtime_pm is supposed to work for
them as well.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+gTRYACgkQJNaLcl1U
h9DpgQf/fsNdTAx1Ok5mFJtucgRm8rHojszj+RjuRxcRQMQ40rBzWUwhAEpDUj0r
XcYKd9vBWfldbPNj5lNrXTVLdbIB/b2UWL8ixa3Pj5rSnrZ+r2pDl8DuwnimR1Jw
lUjnZz8eBDVHVE6bgZanqn6SSXAX3WTnVo2kRZcSeTksA30xP9SHOSiM6krtQpsm
eUcc3wTHMGHtnQJsucXVnlFcyes3eBN0nzGK4bpmaPUE8QP84JU4ZcIUtY+qMHJ6
FdHUHT3KVzCXb/7dW7llaBWRHeDqLoPBnk8uUQHuwx8fR7CFm1jn2GPfBfocyJSo
i8aObNBlCKwWmShZroUBm3lNRPMclQ==
=YR84
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
