Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5BC2AD1E6
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 09:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKJI4O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 03:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJI4O (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Nov 2020 03:56:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604998574;
        bh=Fr08wiIOqNkgjPcP1HQY/YShkDybjT9LCWTvj0cy5uE=;
        h=Subject:From:Date:To:From;
        b=w0d4HG8c6QTji7OEBhULTwP9DbnF0/olvN7dEk2PzoUkqi+cGXgNGMdz7Bf0hy2/G
         +wvOwpQQvbTOHDf2rOMcKCgAfj7hVJ5Fs84C2DqT+Y1D4LTWQOw/20ygtvyqXtSPmF
         9eODIP2gaBrpv0fGXSbNmyglR1/0OlSFh7ok3nu0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160499857390.10796.17382527288855414635.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Nov 2020 08:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Input: ads7846: reduce SPI related CPU load (2020-11-10T08:50:41)
  Superseding: [v1] Input: ads7846: reduce SPI related CPU load (2020-11-04T15:35:28):
    [v1,1/2] Input: ads7846: convert to full duplex
    [v1,2/2] Input: ads7846: convert to one message


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

