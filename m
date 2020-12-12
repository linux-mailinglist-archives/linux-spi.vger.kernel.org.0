Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D2D8669
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgLLMTg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Dec 2020 07:19:36 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52033 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgLLMTg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Dec 2020 07:19:36 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id BC6D530000D27;
        Sat, 12 Dec 2020 13:18:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C0D9410A37; Sat, 12 Dec 2020 13:18:53 +0100 (CET)
Date:   Sat, 12 Dec 2020 13:18:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jayshri Pawar <jpawar@cadence.com>
Cc:     linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org,
        dkangude@cadence.com, mparab@cadence.com, sjakhade@cadence.com,
        Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH 1/2] Add support for Cadence XSPI controller
Message-ID: <20201212121853.GA5065@wunner.de>
References: <1607500678-23862-1-git-send-email-jpawar@cadence.com>
 <1607500678-23862-2-git-send-email-jpawar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607500678-23862-2-git-send-email-jpawar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 09, 2020 at 08:57:57AM +0100, Jayshri Pawar wrote:
> +	master = spi_alloc_master(dev, sizeof(*cdns_xspi));
> +	if (!master) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Failed to allocate memory for spi_master\n");
> +		goto err_no_mem;
> +	}

Please use devm_spi_alloc_master() to simplify the probe error path.
It was introduced in v5.10-rc5 with commit 5e844cc37a5c and is also
available in 5.9-stable and 5.4-stable.

The memory allocater already emits an error message if it can't satisfy
a request.  Emitting an additional message here isn't really necessary.


> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cdns_xspi->iobase = devm_ioremap_resource(cdns_xspi->dev, res);
> +	if (IS_ERR(cdns_xspi->iobase)) {
> +		ret = PTR_ERR(cdns_xspi->iobase);
> +		dev_err(dev, "Failed to remap controller base address\n");
> +		goto err_spi_master;
> +	}

Please use devm_platform_ioremap_resource().

Thanks,

Lukas
