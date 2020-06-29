Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2D20D309
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgF2SzM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 14:55:12 -0400
Received: from muru.com ([72.249.23.125]:59956 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgF2SzK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32DD08199;
        Mon, 29 Jun 2020 16:28:13 +0000 (UTC)
Date:   Mon, 29 Jun 2020 09:27:18 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Convert to use GPIO descriptors
Message-ID: <20200629162718.GP53169@atomide.com>
References: <20200625231257.280615-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625231257.280615-1-linus.walleij@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [200625 23:13]:
> The OMAP2 MCSPI has some kind of half-baked GPIO CS support:
> it includes code like this:
> 
>   if (gpio_is_valid(spi->cs_gpio)) {
>         ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> 	(...)
> 
> But it doesn't parse the "cs-gpios" attribute in the device
> tree to count the number of GPIOs or pick out the GPIO numbers
> and put these in the SPI master's .cs_gpios property.
> 
> We complete the implementation of supporting CS GPIOs
> from the device tree and switch it over to use the SPI core
> for this.

Acked-by: Tony Lindgren <tony@atomide.com>
