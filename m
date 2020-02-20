Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3316579A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 07:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBTG1i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 01:27:38 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:60209 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTG1i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Feb 2020 01:27:38 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 01:27:36 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 658FB30002ABE;
        Thu, 20 Feb 2020 07:18:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 35DEEDAE47; Thu, 20 Feb 2020 07:18:30 +0100 (CET)
Date:   Thu, 20 Feb 2020 07:18:30 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Message-ID: <20200220061830.gzi67u555kgvrfah@wunner.de>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
 <20200220061122.srkb663imntm4c6a@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220061122.srkb663imntm4c6a@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 20, 2020 at 07:11:22AM +0100, Lukas Wunner wrote:
> -	if (spi->mode & SPI_CS_HIGH)
> +	if (spi->mode & SPI_CS_HIGH && !(ctlr->use_gpio_descriptors &&
> +					 ctlr->cs_gpiods &&
> +					 ctlr->cs_gpiods[spi->chip_select]))
> 		enable = !enable;

Sorry, I meant (spi->mode & SPI_CS_HIGH || (ctlr->...)
                                        ^^^^
