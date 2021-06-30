Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E577B3B8852
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhF3S0Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 14:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhF3S0Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 14:26:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B1261474;
        Wed, 30 Jun 2021 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625077435;
        bh=4obaIe35ZSS+oHdciFheQSkU3RY3pDJCdjmKqHmoW0c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kPE8MHv6jyippasun8dBIOGhwO92UFHZtzoyINDLwN1vbW9pbA3NriPQbReU5u14O
         t0p9QUBbcOB8D2fIeLl2K/WklzVc4WUHkHVVxVEsCJN91IrwJfgwO8x8BUkvgGuTUU
         HkJ7snfL0VYFZ0Wbb6VtjCCmnNqW3RvDAUm2vpStdpr+PiJq0TwvYX5GkY42czNcoC
         1oia++zl10MZ9Gs5OAAmgfoTU2qacWXrBPUgUIKdmGuXZNUMkmAHpv/q0A29bAi/pd
         DDxxKqLRmSNSTc+ylRTzhRDF3ENccbgr8xkCDdtLDy+FkAWnU5Rnvlzc3DpRsD61Eu
         d1U4emwqkCVCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210630134702.7346-5-jon.lin@rock-chips.com>
References: <20210630134702.7346-1-jon.lin@rock-chips.com> <20210630134702.7346-5-jon.lin@rock-chips.com>
Subject: Re: [PATCH v10 04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Date:   Wed, 30 Jun 2021 11:23:54 -0700
Message-ID: <162507743443.3331010.11705732490811171559@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Jon Lin (2021-06-30 06:46:56)
> Choose the correct pll
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
