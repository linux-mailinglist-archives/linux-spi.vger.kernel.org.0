Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5E2D24CF
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 08:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLHHpH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 02:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLHHpH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 02:45:07 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207FC061749;
        Mon,  7 Dec 2020 23:44:26 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8015930006267;
        Tue,  8 Dec 2020 08:43:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8B064ACE3; Tue,  8 Dec 2020 08:44:24 +0100 (CET)
Date:   Tue, 8 Dec 2020 08:44:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201208074424.GB29998@wunner.de>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201206181612.GA26286@wunner.de>
 <8ce3fa3a-88d7-e981-731a-9bce85047892@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce3fa3a-88d7-e981-731a-9bce85047892@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 07, 2020 at 04:14:53PM -0800, Sowjanya Komatineni wrote:
> On 12/6/20 10:16 AM, Lukas Wunner wrote:
> > However, be sure to use the devm variant to *allocate* the SPI controller,
> > i.e. use devm_spi_alloc_master() instead of spi_alloc_master().
> 
> Thanks Lukas. I see devm_spi_alloc_master() in 5.4 but not from 5.5

devm_spi_alloc_master() was introduced in v5.10-rc5 with commit
5e844cc37a5c and then backported to 5.9-stable and 5.4-stable.

Patches are pending to also backport it to 4.19-stable, 4.14-stable,
4.9-stable and 4.4-stable.

If your development branch is based on v5.5, just cherry-pick
5e844cc37a5c and you should be good to go.

Thanks,

Lukas
