Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0763D330230
	for <lists+linux-spi@lfdr.de>; Sun,  7 Mar 2021 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCGOoA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 7 Mar 2021 09:44:00 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:46247 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCGOnZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 7 Mar 2021 09:43:25 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2021 09:43:25 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 33805100D9410;
        Sun,  7 Mar 2021 15:36:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E9B45105B5; Sun,  7 Mar 2021 15:36:36 +0100 (CET)
Date:   Sun, 7 Mar 2021 15:36:36 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210307143636.GA10974@wunner.de>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
> +static int hisi_spi_setup(struct spi_device *spi)
> +{
> +	struct hisi_spi *hs = spi_controller_get_devdata(spi->controller);
> +	struct hisi_chip_data *chip;
> +
> +	/* Only alloc on first setup */
> +	chip = spi_get_ctldata(spi);
> +	if (!chip) {
> +		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +		if (!chip)
> +			return -ENOMEM;
> +		spi_set_ctldata(spi, chip);
> +	}
[...]
> +	master = devm_spi_alloc_master(dev, 0);

It would seem simpler to just pass "sizeof struct hisi_chip_data"
to devm_spi_alloc_master(), thus obviating the need to allocate
it on first incocation of the ->setup hook.

Thanks,

Lukas
