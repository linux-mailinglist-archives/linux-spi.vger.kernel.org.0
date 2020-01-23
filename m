Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8401214606B
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 02:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAWBkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 20:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgAWBkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jan 2020 20:40:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579743611;
        bh=XPKGaZ9LXq7Th40UDsR6IR0vWzNS+SrBct5SmNBS75U=;
        h=Subject:From:Date:To:From;
        b=u1Ow7UKqvTmatu0HXI9RdZePQBpdvTCBYFaTN5A679drj37Ap/6QTigHNMW87w4mV
         0/ycIjQYJQP8JLn7pAU7CRjHoFPEexeeGeeVjXPpq/9y7NuXEyN89jHqvAvxSeJ9LR
         ne6hcPAxkKpkkPg5H6P2jV1sM+Wpnipd2rk+BbTc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157974361119.25162.9694568067655532153.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Jan 2020 01:40:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] SPI bus multiplexing (2020-01-23T01:23:15)
  Superseding: [v1] SPI bus multiplexing (2020-01-14T23:38:54):
    [1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
    [2/2] spi: Add generic SPI multiplexer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
