Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965022B167B
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 08:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgKMHbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 02:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgKMHbo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Nov 2020 02:31:44 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD6B2085B;
        Fri, 13 Nov 2020 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605252704;
        bh=IxHFr+O2Qeh2nbz9XeXyx6Xdc9c/exv2Y07r+qrDnTE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a07F7osUltHrv80bza86dFbbwqa8o6pChOyptgMVnw1icH731bI5MQBphl5ha1WaP
         iNYgD3I7OohPhTAa1j0APFrCMDttT1nZ4bNLswvIkB3LYLTmKp7o97u370vJthEpkn
         u+DwZUMidzSuJMvo1haBpal+J1XvNDWH1ER1uLUk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201107081420.60325-9-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-9-damien.lemoal@wdc.com>
Subject: Re: [PATCH 08/32] riscv: Fix kernel time_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sean Anderson <seanga2@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-spi@vger.kernel.org
Date:   Thu, 12 Nov 2020 23:31:42 -0800
Message-ID: <160525270249.60232.12874105352298232293@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Damien Le Moal (2020-11-07 00:13:56)
> If of_clk_init() is not called in time_init(), clock providers defined
> in the system device tree are not initialized, resulting in failures for
> other devices to initialize due to missing clocks.
> Similarly to other architectures and to the default kernel time_init()
> implementation, call of_clk_init() before executing timer_probe() in
> time_init().

Do you have timers that need clks to be running or queryable this early?
This of_clk_init() call is made here when architectures need to call
things like clk_get_rate() to figure out some clk frequency for their
clockevent or clocksource. It is OK to have this call here, I'm just
curious if this is actually necessary vs. delaying it to later.
