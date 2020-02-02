Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89D14FD42
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBBNUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgBBNUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 2 Feb 2020 08:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580649610;
        bh=mvj+6lRcB24M8Sbn5+L5FS/4mRLtKSmiRpRJ05NdROU=;
        h=Subject:From:Date:To:From;
        b=hqhS4uN9xKLPc+xDAfPu+Pco6UQhfxbH4EY2IwPS2BihOKKWHP+9YohcLgj+cL7n5
         dv1vyI8OFyaxggCarEikt09Ggr9pbi/1p4MWwlF+GOTnlZqVSnDmIMRARpMiYlYlxh
         eTozADADNYF41RKoeM7lg69Qgu0BYavkAslqt7b4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158064961077.29711.16906860151963082273.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 02 Feb 2020 13:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: fspi: enable fspi on imx8qxp and imx8mm (2020-02-02T12:59:46)
  Superseding: [v1] spi: fspi: enable fspi on imx8qxp and imx8mm (2020-01-26T14:09:08):
    [1/5] spi: fspi: enable fspi on imx8qxp and imx8mm
    [2/5] spi: fspi: dynamically alloc AHB memory
    [3/5] spi: spi-nxp-fspi: Enable the Octal Mode in MCR0
    [4/5] dt-bindings: spi: spi-nxp-fspi: Add support for imx8mm, imx8qxp
    [5/5] arm64: dts: enable fspi in imx8mm dts


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
