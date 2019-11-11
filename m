Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B871FF80A6
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2019 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKKTyj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Nov 2019 14:54:39 -0500
Received: from muru.com ([72.249.23.125]:41634 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfKKTyj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Nov 2019 14:54:39 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D77878119;
        Mon, 11 Nov 2019 19:55:14 +0000 (UTC)
Date:   Mon, 11 Nov 2019 11:54:35 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Luhua Xu <luhua.xu@mediatek.com>, wsd_upstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Applied "spi: add power control when set_cs" to the spi tree
Message-ID: <20191111195435.GW5610@atomide.com>
References: <1572426234-30019-1-git-send-email-luhua.xu@mediatek.com>
 <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

* Mark Brown <broonie@kernel.org> [191031 13:24]:
> The patch
> 
>    spi: add power control when set_cs
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

This patch causes a regression for many SPI devices as they
assume spi_setup() return 0 on success and not a positive value.

I've sent a fix for this as:

spi: Fix regression to return zero on success instead of positive value

Regards,

Tony
