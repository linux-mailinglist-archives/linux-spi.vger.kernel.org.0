Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED462A061D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3NCd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 09:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3NCc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 09:02:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B22206FA;
        Fri, 30 Oct 2020 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604062952;
        bh=zD7Qg76r3Z156bimr1LI8xN1/pnNPPdLFzNeHDf/AB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjdYr9F6WBbAPPFOPhMidkMEAF2gAY65ZVWiOOM0NIPoNCiC20zIh/lxIeg7r3wYh
         UqUgQ8bocnv6nxvJzldx7XTmmxBDXgyIOqa1YFPykLVVfzI/g7OGsXPsmQ2BCbLJgQ
         hCwT3rgb0Y8iGvuG/3WJcCsLwLMlc/FTQjzXiMkI=
Date:   Fri, 30 Oct 2020 13:02:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     olteanv@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201030130224.GA8802@sirena.org.uk>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20201029084035.19604-1-qiang.zhao@nxp.com>
X-Cookie: <Omnic> another .sig addition
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2020 at 04:40:35PM +0800, Qiang Zhao wrote:

> [   64.587431] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000020
> [..]
> [   64.756080] Call trace:
> [   64.758526]  dspi_suspend+0x30/0x78
> [   64.762012]  platform_pm_suspend+0x28/0x70
> [   64.766107]  dpm_run_callback.isra.19+0x24/0x70
> [   64.770635]  __device_suspend+0xf4/0x2f0
> [   64.774553]  dpm_suspend+0xec/0x1e0
> [   64.778036]  dpm_suspend_start+0x80/0xa0
> [   64.781957]  suspend_devices_and_enter+0x118/0x4f0
> [   64.786743]  pm_suspend+0x1e0/0x260
> [   64.790227]  state_store+0x8c/0x118
> [   64.793712]  kobj_attr_store+0x18/0x30
> [   64.797459]  sysfs_kf_write+0x40/0x58
> [   64.801118]  kernfs_fop_write+0x148/0x240
> [   64.805126]  vfs_write+0xc0/0x230
> [   64.808436]  ksys_write+0x6c/0x100
> [   64.811833]  __arm64_sys_write+0x1c/0x28
> [   64.815753]  el0_svc_common.constprop.3+0x68/0x170
> [   64.820541]  do_el0_svc+0x24/0x90
> [   64.823853]  el0_sync_handler+0x118/0x168
> [   64.827858]  el0_sync+0x158/0x180

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cDuAACgkQJNaLcl1U
h9C3JAf9GsF97P7cX8CwfBVS2GiJmhAmCayrZOxT1GhgmcBN9DLxCPSr5J9thdUD
JjVGZx9jmk7ba6ol77504gSdEJ2gxl8uf5WoJuMOQKbqEKg4yMTYBS5lLh1M1Vwo
sS1713ekVQhbLjH3WnTyAI6YXJIe1Ue5OgYbpqGt2QEnSgt76bEkyr2Cka2QcKSf
CwIy9QxVA2i7POSeUn9XXEt6m64ZWAqQvdJg32A9EYi03XGCVcfZjBnCiiQ0pbiB
ICtXm1+glZd0x4lKEc8zg4itMEY+7yTNkA00uzr529DcMZcSN+d/rTPPL8qg7nJ1
UmFW7X6XHVBH4oqsrVqj04tU+L7vHg==
=110T
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
