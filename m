Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6D722C43B
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGXLUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGXLUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Jul 2020 07:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595589619;
        bh=arRSEr8IPPX809toYRR8JHHDg8+UT/cO7e1sfsNAsA4=;
        h=Subject:From:Date:To:From;
        b=fp5BcXhWu8lV+EeU6fK9d1gCysQBxsxohZZbIl16aqgfCKLTfRZEpG419o8+JD10m
         xo1tmlyIJ+1An+qk6B7F6GgVAXKbLLNOBraa6oe8+Sxb56PS7pgdVZp7S1eoGDP0uu
         zlv0tACwGpnam3q5ZTwxfnrndQSGzHYk5TS8Nwf4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159558961908.24236.2589222503612810455.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Jul 2020 11:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: Adding support for Microchip Sparx5 SoC (2020-07-24T11:13:58)
  Superseding: [v3] spi: Adding support for Microchip Sparx5 SoC (2020-07-02T10:13:23):
    [v3,1/8] spi: dw: Add support for RX sample delay register
    [v3,2/8] arm64: dts: sparx5: Add SPI controller and SPI mux
    [v3,3/8] spi: dw: Add Microchip Sparx5 support
    [v3,4/8] mux: sparx5: Add Sparx5 SPI mux driver
    [v3,5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus snps,rx-sample-delay-ns property
    [v3,6/8] dt-bindings: microchip,sparx5-spi-mux: Add Sparx5 SPI mux driver bindings
    [v3,7/8] arm64: dts: sparx5: Add spi-nor support
    [v3,8/8] arm64: dts: sparx5: Add spi-nand devices


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
