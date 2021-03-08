Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC4330925
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 09:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCHIHA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 03:07:00 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:43905 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhCHIGf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 03:06:35 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D9E7C100DA1B2;
        Mon,  8 Mar 2021 09:06:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 90FD310B0A; Mon,  8 Mar 2021 09:06:28 +0100 (CET)
Date:   Mon, 8 Mar 2021 09:06:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210308080628.GA16403@wunner.de>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210307143636.GA10974@wunner.de>
 <331fa0f5-7052-0dac-e375-df25789c56b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331fa0f5-7052-0dac-e375-df25789c56b6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 08, 2021 at 11:57:17AM +0800, Jay Fang wrote:
> On 2021/3/7 22:36, Lukas Wunner wrote:
> > On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
> > > +static int hisi_spi_setup(struct spi_device *spi)
> > > +{
> > > +	struct hisi_spi *hs = spi_controller_get_devdata(spi->controller);
> > > +	struct hisi_chip_data *chip;
> > > +
> > > +	/* Only alloc on first setup */
> > > +	chip = spi_get_ctldata(spi);
> > > +	if (!chip) {
> > > +		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> > > +		if (!chip)
> > > +			return -ENOMEM;
> > > +		spi_set_ctldata(spi, chip);
> > > +	}
> > [...]
> > > +	master = devm_spi_alloc_master(dev, 0);
> > 
> > It would seem simpler to just pass "sizeof struct hisi_chip_data"
> > to devm_spi_alloc_master(), thus obviating the need to allocate
> > it on first invocation of the ->setup hook.
> 
> Thanks for your review. "struct hisi_chip_data" is the private data
> of per-spi device, not the spi controller. So I think this method
> is not suitable here. Maybe we can allocate "struct hisi_spi" in
> this way.

Ah, I was mistaken then.  Yes, allocating struct hisi_spi with
devm_spi_alloc_master() would probably make sense.

Thanks,

Lukas
