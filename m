Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12560478941
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLQKwN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 05:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhLQKwM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 05:52:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0EFC061574
        for <linux-spi@vger.kernel.org>; Fri, 17 Dec 2021 02:52:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 21AA51F46C37;
        Fri, 17 Dec 2021 10:52:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639738330; bh=7OW2czdKX3FOlvIcEt9ndAFP8hy/VaLOI/2Yd90oy3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W74HTJ6QKDRz52ZWbSD+FVBQv/wR3evutz2llqYeH5+ldowDRSPzWYz4FNTxwoPO3
         BFpRavydFEFe2rQuArOnIisUB8rEsBPK8npBUzG7Uj2suLuBMQv1yhXmiZjRviX0Oi
         +p7j59IhqOzqmiaCPF9LnUnZXsxQZiSzWDEK1CfyDmXFSbQ2ASczaWgzH2GEvSQSW8
         Ko6DS1t5Zwg1ZPhur7T+hjIVIb/N7OwUS7PbzWX1FHZ5gg0kZ2POrTKh/8V7rAlRG4
         dTf3i0uZKmxRlCdadqB9yRoxzD2/q9TmNI4D+9dyIgSwmo+aKhN8C1r5Fj3uHoY0+U
         X+gaoWysGFnDA==
Date:   Fri, 17 Dec 2021 11:52:06 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211217115206.33da307c@collabora.com>
In-Reply-To: <Ybxotgb927kpCizL@lahna>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
        <20211118130543.11179-3-mika.westerberg@linux.intel.com>
        <20211216115100.448351e4@collabora.com>
        <Ybtn1VTsspxdIeT8@lahna>
        <20211216174347.69cf611c@collabora.com>
        <Ybxotgb927kpCizL@lahna>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Dec 2021 12:38:46 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Thu, Dec 16, 2021 at 05:43:47PM +0100, Boris Brezillon wrote:
> > Why no just
> > 
> > 	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
> > 	    iop->mem_op.addr.dtr != op->addr.dtr)
> > 		return false;
> > 
> > then?  
> 
> That would be too simple ;-)
> 
> I'll do this change in v5.

I didn't review the driver thoroughly, but it looks clean an tidy. Feel
free to add

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

One more thing. I think it'd be good to implement the dirmap hooks (in
a follow-up series, not here), so you don't have to iterate over the ops
table every time a read/write request is issued. Should be as simple as
storing the exec_op() pointer in the driver-private dirmap pointer, and
calling this function when ->dirmap_{read,write}() is called.
