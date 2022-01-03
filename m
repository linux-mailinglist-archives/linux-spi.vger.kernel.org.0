Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEC482F0A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jan 2022 09:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiACIi1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jan 2022 03:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiACIi0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jan 2022 03:38:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81327C061761
        for <linux-spi@vger.kernel.org>; Mon,  3 Jan 2022 00:38:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 701B41F41E6D;
        Mon,  3 Jan 2022 08:38:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641199103;
        bh=/+2NvOoPgYjCW/sZCqGrcDcloFV0Na4KRVsqw1zqQG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9iDVYgZnbsZsbn8sOIrz20O+ere6mcnp2ebd1U65HKPc3VV34/fGN/jAoxg7Td2S
         OgQWNMj3RagAc/cjho/Gb3w5Va8f28ruOxbLXCKU+pVF4/F0XpG1hC5lQ7Q0wd2o/L
         6IDoGE4FsKP0+K0/Vc5owI0NOqvju53isdS2D867iDc1GumHxbdM6jCiBInCJp16ei
         u7T3qsjxQNyrErcxSukX2mj+WmUtk+DcIdwKzWGwfgzDmbcFLXULdmqKWjgqYTGc5f
         fV2Jnp+Wll1Cpse8813YtZ5taUTiyzOJxy5KbMwtgY2olXOgItI07eKzw1N+KiagjW
         9pcaK8MllGfeA==
Date:   Mon, 3 Jan 2022 09:38:19 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 04/14] spi: cadence: Provide a capability structure
Message-ID: <20220103093819.080e60fb@collabora.com>
In-Reply-To: <20211221120458.4l7expkdznnw6u3u@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-5-miquel.raynal@bootlin.com>
        <20211220185515.wujhgn66mnwns7bw@ti.com>
        <20211221111605.352285f5@xps13>
        <20211221104108.t563gg2hulfqt2uh@ti.com>
        <20211221121947.5c779bfd@xps13>
        <20211221120458.4l7expkdznnw6u3u@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Dec 2021 17:35:00 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> > 
> > Anyway, do you mind if we move forward first? Not that I don't think
> > that this choice should be discussed further, but I think this can
> > easily be changed in the near future if there is a desire to
> > reorganize spi-mem objects. In fact, these capabilities are accessed
> > through a helper so that hypothetic change would be almost transparent.  
> 
> Okay. I would still like to hear other opinions on this, but fine by me 
> if you want to take this in as-is.

I think we discussed that with Miquel, and I remember complaining about
mixing function pointers and actual data in the spi_mem_ops struct, but
honestly, it's just cosmetic concern, and I don't think it matters much
in practice. So I'm fine either way, make it a field of spi_controller
or spi_mem_ops, spi_mem is definitely not the right place though.
