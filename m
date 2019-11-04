Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A752EE843
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDTYT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 14:24:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDTYT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 14:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=14g9oyYQ5ejwP+HUIBS3ppdCvtef/yyJ/Ou2n23wvc8=; b=DaH6+BIfshQ0a09JXhFX+7+Ve
        ocWCl5jQjr0NcdEy7TAyfTb4PkflhPzkycnSRVOxppcwKPJgCThtZXdwIC+3UW5otE5O93Wbp9uo+
        RFJ4CMQU7IT9Tqv/kQCjkrtpLI2UgDhQhr51Zq28U63aFosnxyo8xS13oNy1rZLN2mdes=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRhxR-00030B-2u; Mon, 04 Nov 2019 19:24:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6231A274301E; Mon,  4 Nov 2019 19:24:06 +0000 (GMT)
Date:   Mon, 4 Nov 2019 19:24:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20191104192406.GH5238@sirena.co.uk>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <1572886297-45400-3-git-send-email-john.garry@huawei.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:

> Only ACPI firmware is supported.

There's no ACPI dependency though?  If the driver only works with ACPI
I'd expect to see one with an || COMPILE_TEST like the architecture
dependency.

> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HiSilicon SPI NOR V3XX Flash Controller Driver for hi16xx chipsets
> + *

Please make the entire comment a C++ one for neatness.

> + * Copyright (c) 2019 HiSilicon Technologies Co., Ltd.
> + * Author: John Garry <john.garry@huawei.com>
> + */
> +//#define DEBUG 1

Please remove this.

> +#define GLOBAL_CFG (0x100)
> +
> +#define BUS_CFG1 (0x200)
> +#define BUS_CFG2 (0x204)
> +#define BUS_FLASH_SIZE (0x210)
> +
> +#define VERSION (0x1f8)

These could use some namespacing, especially the last one - it seems
quite likely there'll be some collisions at some point.

> +#define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
> +#define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10

Plus if we've got these long prefixes here it'd be good to be
consistent.

> +	if (IS_ALIGNED((uintptr_t)to, 4)) {
> +		int words = len / 4;
> +
> +		__ioread32_copy(to, host->regbase + CMD_DATABUF(0), words);
> +
> +		len -= words * 4;
> +		if (len) {
> +			u32 val;
> +
> +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
> +
> +			to += words * 4;
> +			for (i = 0; i < len; i++, val >>= 8, to++)
> +				*to = (u8)val;
> +		}
> +	} else {
> +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
> +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
> +			int j;

The more usual pattern for these would be to do some unaligned accesses
for the start/end of the buffer to get to alignment and then transfer
the rest as aligned data.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AetUACgkQJNaLcl1U
h9AUDggAhbUOC9Q2ExVskNhuRVMVMw5Xq0UlE6+60CYcvZfy1w/TQvgxMcP5764e
+EhXHAQ8BZ+JleaTtcuIoAg7OyBF1OOTQLEsSJ5AE5UOidvK1ft1Pud5D5rIXgYK
kUxszOb2BCfW/rZMaLiKB2ydw1o1TsUEH76COG9+J8rVnLoLC/BwcMat7DVFtnPW
orgevaNjPRUzmWOb7HuSziDLA+okmX+nLF+buquH1LR585JXMbTJd+1cgDk0aJFx
bojmWsK0E1Ra52pwKO7qFdJS9mIzFN6GOVUqT47XhZm3BVmUkTHiugVun+AKT7el
YpZbCCyYdb2H27r96NdBA3Ns3o/fJg==
=PHLm
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
