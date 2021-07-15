Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCE3CAF55
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 00:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhGOWp5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 18:45:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53596 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhGOWp4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:56 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4J-0005t7-7I; Fri, 16 Jul 2021 00:42:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, macroalpha82@gmail.com,
        sugar.zhang@rock-chips.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        p.yadav@ti.com, hjc@rock-chips.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        linux-clk@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rockchip@lists.infradead.org, broonie@kernel.org
Subject: Re: (subset) [PATCH v12 00/10] Add Rockchip SFC(serial flash controller) support
Date:   Fri, 16 Jul 2021 00:42:54 +0200
Message-Id: <162638886253.651069.9476890727039205269.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210713094456.23288-1-jon.lin@rock-chips.com>
References: <20210713094456.23288-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 13 Jul 2021 17:44:46 +0800, Jon Lin wrote:
> Changes in v12:
> - Remove useless oneOf lable
> - Add sfc controller discription
> - Remove the limitation of SFC_MIN_SPEED_HZ
> - Add IRQ_NONE method for irq handler
> - Add SPI_MASTER_HALF_DUPLEX flags
> - Add sfc interrupt mask bits and status register initial progress
> 
> [...]

Applied, thanks!

[04/10] clk: rockchip: rk3036: fix up the sclk_sfc parent error
        commit: 0be3df186f870cbde56b223c1ad7892109c9c440
[05/10] clk: rockchip: add dt-binding for hclk_sfc on rk3036
        commit: b13c1fff66cc255c0a9d48561d05f0f7e8ffd385
[06/10] clk: rockchip: Add support for hclk_sfc on rk3036
        commit: d61eb8a1f5184f32ddc5ac03c930cff8e9a6fae9

I've just picked the clk-related patches for now, as they're
not dependent on the sfc being applied itself.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
