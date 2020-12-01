Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890812CA5B4
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbgLAOba (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 09:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391401AbgLAOb3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 09:31:29 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2516C061A4F
        for <linux-spi@vger.kernel.org>; Tue,  1 Dec 2020 06:30:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C7DB630000899;
        Tue,  1 Dec 2020 15:30:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2B314155B8E; Tue,  1 Dec 2020 15:30:27 +0100 (CET)
Date:   Tue, 1 Dec 2020 15:30:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe
 error path
Message-ID: <20201201143027.GA23044@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
 <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 01, 2020 at 01:57:56PM +0000, Mark Brown wrote:
> On Mon, 16 Nov 2020 09:23:10 +0100, Lukas Wunner wrote:
> > If the calls to of_match_device(), of_alias_get_id(),
> > devm_ioremap_resource(), devm_regmap_init_mmio() or devm_clk_get()
> > fail on probe of the NPCM FIU SPI driver, the spi_controller struct is
> > erroneously not freed.
> > 
> > Fix by switching over to the new devm_spi_alloc_master() helper.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] spi: npcm-fiu: Don't leak SPI master in probe error path
>       (no commit info)

This patch is already in Linus' tree.
(You applied it to spi.git on Nov 17.)

Thanks,

Lukas
