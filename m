Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7681E3C26
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgE0IfK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 04:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388119AbgE0IfJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 04:35:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0503E2084C;
        Wed, 27 May 2020 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590568509;
        bh=ExRWKKtWjwjMfUMo3XFsagCD3+PJwFwlQH9y9gF24co=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oIUSl5eMOR1MZzMDvtFWB0YQE3IPL/ZM/1HMr0RMhTmwYvrsKFVWiQAh4G6mHvd+Q
         3H28kUP+38zAqybb2CWyvvgwuV3h90u5Tfnvz/c4lyACL6RqPaJ15NHoJ0zHzmZxK2
         qYZPvrf1QmWw+rQ4Uy7yVLf9PFu9DpYQJomN8HPg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590564453-24499-7-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com> <1590564453-24499-7-git-send-email-dillon.minfei@gmail.com>
Subject: Re: [PATCH v6 6/9] clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after kernel startup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
To:     airlied@linux.ie, alexandre.torgue@st.com,
        andy.shevchenko@gmail.com, broonie@kernel.org, daniel@ffwll.ch,
        dillon.minfei@gmail.com, linus.walleij@linaro.org,
        mcoquelin.stm32@gmail.com, mturquette@baylibre.com,
        noralf@tronnes.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        sam@ravnborg.org, thierry.reding@gmail.com
Date:   Wed, 27 May 2020 01:35:08 -0700
Message-ID: <159056850835.88029.9264848839121822798@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting dillon.minfei@gmail.com (2020-05-27 00:27:30)
> From: dillon min <dillon.minfei@gmail.com>
>=20
> stm32's clk driver register two ltdc gate clk to clk core by
> clk_hw_register_gate() and clk_hw_register_composite()
>=20
> first: 'stm32f429_gates[]', clk name is 'ltdc', which no user to use.
> second: 'stm32f429_aux_clk[]', clk name is 'lcd-tft', used by ltdc driver
>=20
> both of them point to the same offset of stm32's RCC register. after
> kernel enter console, clk core turn off ltdc's clk as 'stm32f429_gates[]'
> is no one to use. but, actually 'stm32f429_aux_clk[]' is in use.
>=20
> Fixes: daf2d117cbca ("clk: stm32f4: Add lcd-tft clock")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
