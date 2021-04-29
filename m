Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766A36F2B6
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 00:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhD2WtM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhD2WtK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 18:49:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FD9C06138B;
        Thu, 29 Apr 2021 15:48:23 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED2C722239;
        Fri, 30 Apr 2021 00:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619736502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpz2vUSKO6/55m06O1O//fMXB/R8r80PGS4qvX8VdOA=;
        b=KOaVJvx2SFj3w7VND+/8f0UbPBoIs2iOrXTSKfUdMbbBF3dPXNTB4A1VqL7QJYYmKKv5ky
        JiwTmts0NWMc0U7gYZ1q3tjXUtQ60O0yxgExMiq7EL/t9vkM8HRlAx4FUN8UepmmCTxszc
        QmHd5ITnUhYuaOPla46NvkRpgmApDiY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Apr 2021 00:48:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 5/6] spi: cadence-qspi: Tune PHY to allow running at
 higher frequencies
In-Reply-To: <20210311191216.7363-6-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-6-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <143b24c61109823f6e616cf91d28d16c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> +	if (of_property_read_u32(np, "cdns,phy-tx-start", 
> &f_pdata->phy_tx_start))
> +		f_pdata->phy_tx_start = 16;
> +
> +	if (of_property_read_u32(np, "cdns,phy-tx-end", 
> &f_pdata->phy_tx_end))
> +		f_pdata->phy_tx_end = 48;
> +

I didn't see a dt-bindings patch for these.

-michael
