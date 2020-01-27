Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408D014AB86
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2020 22:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA0VUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jan 2020 16:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgA0VUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jan 2020 16:20:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580160009;
        bh=ZckG5w2yk31EDnQUacImGs2u/T7194O4MEmnADasOHY=;
        h=Subject:From:Date:To:From;
        b=Kx66jy9PxYHf4HwkjXGU0d0wGlh6CQvmPVVBuLK9hG6xQRhtNihoouBDtkbdeoqvN
         5nNjhvBdyq07cI+Suz9xw7wL3wP1LIYYNYSOfMKRhPLqj6w6HCSejF0B0OLF4AGSx1
         33f4POteUX7H5ayE1CSNn0vOzmHBeduev4Tqt1SY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158016000991.14818.5553251104978518184.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jan 2020 21:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] SPI bus multiplexing (2020-01-27T21:04:13)
  Superseding: [v2] SPI bus multiplexing (2020-01-23T01:23:15):
    [v2,1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
    [v2,2/2] spi: Add generic SPI multiplexer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
