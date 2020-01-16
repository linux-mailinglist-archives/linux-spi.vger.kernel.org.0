Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2294113FCF3
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 00:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbgAPXUN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 18:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390580AbgAPXUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216810;
        bh=ce5X4ZSpkQ0SmCHv8UtylAKsRxA2GKTMx508fC+XnGM=;
        h=Subject:From:Date:To:From;
        b=fz9FWJ6W2B0+pr8jxj6Q55f81n9HPADoh3qS8yWvJodwVcy4V8oywlTcsYQ2Tf1Rf
         rR3eOE5e4Aq6iMkaOkZbBsYciiM8bApO/BFm0QdaHBpCjHynakOVU+NtsFUfenzraT
         dnHX3gkOkd06z3eC9cbypTLdpAESVM0si1Xhny98=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157921681080.17946.6582206907327101035.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 16 Jan 2020 23:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] arm64: dts: sun50i: H6: Enable SPI controller (2020-01-16T23:11:45)
  Superseding: [v2] arm64: dts: sun50i: H6: Enable SPI controller (2020-01-16T00:56:51):
    [v2,1/3] arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
    [v2,2/3] arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
    [v2,3/3] dt-bindings: spi: sunxi: Document new compatible strings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
