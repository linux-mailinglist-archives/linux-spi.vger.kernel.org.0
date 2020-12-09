Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36692D4B29
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgLIUCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbgLIUCS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:02:18 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FFC0613CF;
        Wed,  9 Dec 2020 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8F3+EPqz0dxBHDJRmRDC3uMMxguu00ELq3fa08RQ0eo=; b=XiVCnKkhEeoXMupclMDczRuUsa
        IG3QZN2hnju4jc5cQ+ke3ZjsK1VaPm4MnyjmKfLBznndhbolGqtzK7/G+OHm6VKJgqd/H2Fvc2P1z
        4zDlwtZqLzTl3ejxY/NIZg0z5x7LyuCBoAyqNhIwWgXu0nZvcRzC/ccTg6X+VYy+wd1Y=;
Received: from p200300ccff0981001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:8100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kn5eY-0000Cz-2v; Wed, 09 Dec 2020 21:01:34 +0100
Date:   Wed, 9 Dec 2020 21:01:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high
 and gpio descriptors
Message-ID: <20201209210133.44ab9c97@aktux>
In-Reply-To: <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
        <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
        <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com>
        <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Dec 2020 14:04:26 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Wed, Dec 9, 2020 at 1:16 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > This is also what made me wonder if that is really intended because then
> > the whole discussion about the cs-gpio-flags and inversion and the fixes
> > would not have been needed. The current code and fixes are all about
> > not ignoring the flags...  
> 
> The inversion you witnessed was a bug caused by spi client drivers that
> simply "plow over" the SPI_CS_HIGH mode flag. This includes the panel driver
> you're using, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c?h=v5.10-rc6#n337
> 
ah, it would be set in spi->mode and is cleared by

spi->mode = SPI_MODE_3;


Hmm, but we have
                      spi-cpol;
                        spi-cpha;
in devicetree. Why do we need that spi->mode line at all?

Regards,
Andreas
