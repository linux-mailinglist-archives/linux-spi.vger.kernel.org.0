Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6AE3B8855
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhF3S0g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 14:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233243AbhF3S0d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 14:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71FE861468;
        Wed, 30 Jun 2021 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625077444;
        bh=85GRTiAN+qIhZQpgqk3uxumNiZTTSlxWORSeg0LMGI0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fjesTOkCm8B0e4KRQvhiv/12jAMnsjdPJwCJMKIqRR7tbd2Y3UaG6d+TppeYjldJd
         IkQdFVYuPhRxteCyQOLH6JjO6U8GkfQLsbALB41/nACzk0xSvUjEdPjAIoy3fiQxTs
         ENg7ga49Xy/qYgMR3tLo5s0eCnUYVgDyxY6PQE8YUygDXxQhKGvY8FUpFbqogyWNCC
         YQQ7Cy0rB8VQ+figCq6cQJNvKtpty2HEWxAc0wUW6Ogm2cROK4+w4goeHVeWpgtwcQ
         NnE05URIGUvtmJgC+c9NJ8qo0Dwmm+MO3u678Ok5ObeAJQjR6mUQuMfirFlbult276
         lX04K2Gi1X8/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210630134745.7561-1-jon.lin@rock-chips.com>
References: <20210630134702.7346-1-jon.lin@rock-chips.com> <20210630134745.7561-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH v10 05/10] clk: rockchip:  add dt-binding for hclk_sfc on rk3036
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Date:   Wed, 30 Jun 2021 11:24:03 -0700
Message-ID: <162507744324.3331010.10691354484108930102@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Jon Lin (2021-06-30 06:47:40)
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add dt-binding for hclk_sfc on rk3036
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
