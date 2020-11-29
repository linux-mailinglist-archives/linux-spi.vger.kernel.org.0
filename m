Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F372C78D7
	for <lists+linux-spi@lfdr.de>; Sun, 29 Nov 2020 12:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgK2LgF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Nov 2020 06:36:05 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:33629 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2LgF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Nov 2020 06:36:05 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id A762C10189A3F;
        Sun, 29 Nov 2020 12:35:11 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id AD48A6106EDE;
        Sun, 29 Nov 2020 12:35:22 +0100 (CET)
Date:   Sun, 29 Nov 2020 12:35:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH for-5.10] spi: rpc-if: Fix use-after-free on unbind
Message-ID: <20201129113548.GA2587@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
 <9534f4fb-6f5e-b538-6903-e702a7301b1d@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9534f4fb-6f5e-b538-6903-e702a7301b1d@omprussia.ru>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 28, 2020 at 11:20:50PM +0300, Sergey Shtylyov wrote:
> On 11/16/20 11:23 AM, Lukas Wunner wrote:
> > rpcif_spi_remove() accesses the driver's private data after calling
> > spi_unregister_controller() even though that function releases the last
> > reference on the spi_controller and thereby frees the private data.
> 
> OK, your analysis seems correct (sorry for the delay admitting this :-).

Thanks!  Is it okay to take this for an Acked-by?


> Not sure why spi_unregister_controller() drops the device reference
> while spi_register_controller() itself doesn't allocate the memory... 

Yes, that's exactly what I'm trying to move away from with
devm_spi_alloc_master() (introduced in v5.10-rc5 by 5e844cc37a5c).
The API as it has been so far has made it really easy to shoot oneself
in the foot.


> > Fix by switching over to the new devm_spi_alloc_master() helper which
> > keeps the private data accessible until the driver has unbound.
> 
>    Perhaps the order of the calls in the remove() method could be reversed? 

I'm not familiar with power management on these Renesas controllers
but rpcif_disable_rpm() calls pm_runtime_put_sync(), which I assume
may put the controller to sleep.

SPI transfers may still be ongoing until spi_unregister_controller()
returns.  Specifically, this function unbinds and unregisters all
SPI slaves attached to the controller and the slaves' drivers may
need to perform SPI transfers to quiesce interrupts on the slaves etc.

Thus, the correct order is to call spi_unregister_controller() first
and only then perform further teardown steps.  So the order in
rpcif_spi_remove() seems correct to me.

The only thing that looks confusing is that rpcif_enable_rpm() calls
pm_runtime_enable(), whereas rpcif_disable_rpm() calls
pm_runtime_put_sync().  That looks incongruent.

Thanks,

Lukas
