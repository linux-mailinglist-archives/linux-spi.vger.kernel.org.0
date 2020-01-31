Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9B14E73A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 03:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgAaCkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jan 2020 21:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgAaCkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jan 2020 21:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580438409;
        bh=MbZ9irYDNdsa/D5G53HE+XO4omMCKBmX23K3rlvaphA=;
        h=Subject:From:Date:To:From;
        b=FAd3I9nwb6jETSBdNUfyQrdq8SczBcGfnNZ8lKbZ5/gfMxUB6eZASB0wuTHH9UmPj
         UUEtN034lOCumhLmTkQKBGYCAT0hC7via5kzQEzSu0MMz9JAPB17fuToZKTFtNX4U1
         4OVLPbnkX8rNO//WFGNT9jtfGMaA3gpM5JQNSnxc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158043840987.13944.10283457353641161994.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 31 Jan 2020 02:40:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] SPI bus multiplexing (2020-01-31T02:34:31)
  Superseding: [v3] SPI bus multiplexing (2020-01-27T21:04:13):
    [v3,1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
    [v3,2/2] spi: Add generic SPI multiplexer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
