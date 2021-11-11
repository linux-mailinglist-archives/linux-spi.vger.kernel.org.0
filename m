Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658BF44D163
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 06:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhKKFWO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 00:22:14 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:34933 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKFWN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 00:22:13 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7523A2801548A;
        Thu, 11 Nov 2021 06:19:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 654D519F82; Thu, 11 Nov 2021 06:19:23 +0100 (CET)
Date:   Thu, 11 Nov 2021 06:19:23 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
Message-ID: <20211111051923.GA19356@wunner.de>
References: <20211110160836.3304104-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110160836.3304104-1-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 10, 2021 at 05:08:36PM +0100, Michael Walle wrote:
> Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
> SPI buses") introduced a per-controller mutex. But mutex_unlock() of
> said lock is called after the controller is already freed:
> 
>   spi_unregister_controller(ctlr)
>    -> put_device(&ctlr->dev)
>     -> spi_controller_release(dev)
>   mutex_unlock(&ctrl->add_lock)
> 
> Move the put_device() after the mutex_unlock().
> 
> Fixes: 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SPI buses")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.15
