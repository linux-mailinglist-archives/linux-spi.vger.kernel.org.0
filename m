Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583D2A81E7
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKEPLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 5 Nov 2020 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgKEPLh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 10:11:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C6C0613CF;
        Thu,  5 Nov 2020 07:11:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 08C0F1F464C0;
        Thu,  5 Nov 2020 15:11:36 +0000 (GMT)
Date:   Thu, 5 Nov 2020 16:11:32 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        <robh+dt@kernel.org>
Cc:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, <broonie@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Message-ID: <20201105161132.37eb3265@collabora.com>
In-Reply-To: <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
        <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
        <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, 5 Nov 2020 15:09:11 +0100
Cédric Le Goater <clg@kaod.org> wrote:

> Hello Chin-Ting,
> 
> Thanks for this driver. It's much cleaner than the previous and we should 
> try adding support for the AST2500 SoC also. I guess we can keep the old 
> driver for the AST2400 which has a different register layout.
> 
> On the patchset, I think we should split this patch in three : 
> 
>  - basic support
>  - AHB window calculation depending on the flash size
>  - read training support  

I didn't look closely at the implementation, but if the read training
tries to read a section of the NOR, I'd recommend exposing that feature
through spi-mem and letting the SPI-NOR framework trigger the training
instead of doing that at dirmap creation time (remember that spi-mem is
also used for SPI NANDs which use the dirmap API too, and this training
is unlikely to work there).

The SPI-NOR framework could pass a read op template and a reference
pattern such that all the spi-mem driver has to do is execute the
template op and compare the output to the reference buffer.


> 
> We should avoid magic values when setting registers. This is confusing 
> and defines are much better.
>  
> AST2500 support will be a bit challenging because HW does not allow    
> to configure a 128MB AHB window, max is 120MB This is a bug and the work 
> around is to use user mode for the remaining 8MB. Something to keep in
> mind.

Most SPI-MEM controllers don't have such a big dirmap window anyway, and
that shouldn't be a problem, because we don't expose the direct mapping
directly (as would be done if we were trying to support something like
XIP). That means that, assuming your controller allows controlling the
base spi-mem address the direct mapping points to, you should be able
to adjust the window at runtime and make it point where you requested.

Note that dirmap_{read,write}() are allowed to return less data than
requested thus simplifying the case where a specific access requires a
window adjustment in the middle of an read/write operation.

Regards,

Boris
