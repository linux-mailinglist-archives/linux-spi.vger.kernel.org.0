Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A93B3E04
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFYHul (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 03:50:41 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57915 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhFYHul (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Jun 2021 03:50:41 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 60A1B22249;
        Fri, 25 Jun 2021 09:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1624607297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muVToPjbhEudsJJAmtZrtjaYbzMMnT/oWsAuUQB7DeY=;
        b=uvpeR03zX5HVoJhVXczBF1935yKR5tSpkMX0iwaXWRRGDNa2bZwkhs7zy9BzCpbThTzfO1
        5dCjy86V2SQ2dtSNeluBrmQsAoZv5Hbcn2UlK5Z0Oa2Atyct/f5FYM82KfNKGu9vchjSOE
        tmOdXknO4aVm/SG5J7TGdxLGQDsBSTk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Jun 2021 09:48:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v9 02/10] spi: rockchip-sfc: add rockchip serial flash
 controller
In-Reply-To: <20210625071702.10374-3-jon.lin@rock-chips.com>
References: <20210625071702.10374-1-jon.lin@rock-chips.com>
 <20210625071702.10374-3-jon.lin@rock-chips.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <118417b6dc18d345a1d1e10efd0c8a1a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

Am 2021-06-25 09:16, schrieb Jon Lin:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the rockchip serial flash controller (SFC) driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None

This look wrong. Wasn't there any changes in any patches but 1/10?

Please include a proper version history instead of putting the
burden to the reviewer.

-michael
