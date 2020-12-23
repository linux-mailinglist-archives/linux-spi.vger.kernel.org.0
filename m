Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333392E1B49
	for <lists+linux-spi@lfdr.de>; Wed, 23 Dec 2020 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLWK53 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Dec 2020 05:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWK52 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Dec 2020 05:57:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 55041221FA;
        Wed, 23 Dec 2020 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608721008;
        bh=C99GWClXuuZ/jIk7LUuBfv8890AURdozu8U/HSl31wc=;
        h=Subject:From:Date:To:From;
        b=hTJS50+Q6G9CxFL85YBSX3jKNYmMhQA+dkx27Wy2b/XXgbUgsi4uake8283EN1/8w
         YYIyc+EDZGZ2cLnk3wnahOiwGp/5c9yF2vijhVxqCSXEBLJHCfQJnnlUBIjrj2tvRl
         ol5mJp/oWodihcbAQQpizqyBhCOikQZ21pOa4t89LMIWtQMijovlZp7Jb3GTYP+r5z
         KcjOZybdAh++7bexMWzXdJv0FqM915NrRORv3yInOGGZi65yP9k7vS8A5AWQCAdpjG
         vQj6fmJ/WnDsRYhc4+cINAm3ePL4XZmXtUBe0eXPL0WIZM0gYkaeaNULtG2qk5mUJ6
         e6ZgoBnqsi/+g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 430EE600EF;
        Wed, 23 Dec 2020 10:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160872100820.27459.17096835619866239406.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 23 Dec 2020 10:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: new feature and fix for Marvell Orion driver (2020-12-23T10:38:25)
  Superseding: [v2] spi: new feature and fix for Marvell Orion driver (2020-12-17T17:09:30):
    [v2,1/2] spi: orion: enable clocks before spi_setup
    [v2,2/2] spi: orion: enable support for switching CS every transferred byte


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

