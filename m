Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0493F0DF6
	for <lists+linux-spi@lfdr.de>; Thu, 19 Aug 2021 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhHRWPe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 18:15:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44644 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhHRWPd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Aug 2021 18:15:33 -0400
Received: from [212.185.68.41] (helo=phil.client.m3-hotspots.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mGTpj-0001gc-9s; Thu, 19 Aug 2021 00:14:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, hjc@rock-chips.com,
        linux-rockchip@lists.infradead.org, p.yadav@ti.com,
        sboyd@kernel.org, macroalpha82@gmail.com,
        linux-arm-kernel@lists.infradead.org, yifeng.zhao@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        sugar.zhang@rock-chips.com, jbx6244@gmail.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Subject: Re: (subset) [PATCH v13 0/6] Add Rockchip SFC(serial flash controller) support
Date:   Thu, 19 Aug 2021 00:14:48 +0200
Message-Id: <162932487840.2867187.12225818198624183651.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210812134546.31340-1-jon.lin@rock-chips.com>
References: <20210812134546.31340-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 12 Aug 2021 21:45:40 +0800, Jon Lin wrote:
> Changes in v13:
> - Provide independent interfaces to obtain RX TX FIFO status respectively
> - Add more debug information
> - Depress DMA limitation
> 
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

[3/6] arm64: dts: rockchip: Add SFC to PX30
      commit: c68defec1585819af54f011fa4d47892b38fb74a
[4/6] arm: dts: rockchip: Add SFC to RV1108
      commit: 9d508827c7939242e8ed6b06f66aa87d9f7ea832
[5/6] arm64: dts: rockchip: Add SFC to RK3308
      commit: ab438ba2dc6b7bd3dce8e3c8b0f131905cd133d9
[6/6] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
      commit: f9576999b0aef399e7cb1065787032d42198c362

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
