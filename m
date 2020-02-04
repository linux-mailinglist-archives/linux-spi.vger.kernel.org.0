Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF81514B0
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 04:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDDkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 22:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgBDDkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 3 Feb 2020 22:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580787610;
        bh=ynXG/6kiKl+MYrDzEEn3dNyIeK66Gk0em7xqoVdvxjM=;
        h=Subject:From:Date:To:From;
        b=PbbxLA2HCsjeO6rWk0dUicrM63ED8W96hVgHzOX7E+vuJshc1Az3n2NW/JNG4Z3eH
         6kGMcnK8EWOBXbN12ygXdoDsijD5gQsnLl+Uxvw7RNYdRqvEEe5ludajNUlTBClTGp
         qPl+On58eJqkEZaNkh+jUyK3Xr5RKSimhdisLsTs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158078761009.17146.4636887958601064500.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 04 Feb 2020 03:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] SPI bus multiplexing (2020-02-04T03:28:38)
  Superseding: [v4] SPI bus multiplexing (2020-01-31T02:34:31):
    [v4,1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
    [v4,2/2] spi: Add generic SPI multiplexer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
