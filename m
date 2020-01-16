Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC913FCBE
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 00:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgAPXMG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 18:12:06 -0500
Received: from foss.arm.com ([217.140.110.172]:34032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgAPXMG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 18:12:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C3D11D4;
        Thu, 16 Jan 2020 15:12:05 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009423F68E;
        Thu, 16 Jan 2020 15:12:03 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: sun50i: H6: Enable SPI controller
Date:   Thu, 16 Jan 2020 23:11:45 +0000
Message-Id: <20200116231148.1490-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Even though the SPI controller in the Allwinner H6 SoC is more advanced
than in the previous generations (it supports 3-wire and 4-wire mode),
the register set stays backwards-compatible. So we can use the existing
driver to use the "normal" SPI mode, for instance to access the SPI
flash soldered on the Pine H64 board.

These two patches allow this by adding the SPI controller nodes to the
DT. The compatible strings include an H6 specific name, so that any
future 4-wire enhancements for instance would be automatically usable
once the driver learns this new trick. For now we use the H3 fallback
name to bind the current driver.

This time I tested this actual branch  (on top of sunxi/dt-for-5.6),
on a Pine H64, both the internal SPI flash as well with SPI flash
connected to the other SPI controller available on the GPIO headers.

As the SPI0-CS0 pin clashes with the eMMC CMD pin, we keep this
node disabled by default, to avoid losing the eMMC if it probes last.
People (or U-Boot) can enable it if needed.

Cheers,
Andre.

Changelog v2 ... v3:
- use a more maintainable compatible description in the dt-bindings

Changelog v1 ... v2:
- comment on pinmux clash between eMMC and SPI
- disable Pine H64 SPI flash node by default
- add binding doc for the new compatible string

Andre Przywara (3):
  arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
  arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
  dt-bindings: spi: sunxi: Document new compatible strings

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      | 11 +++--
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 19 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 55 ++++++++++++++++++++++
 3 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.14.5

