Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C51BABC5
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgD0R6H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 13:58:07 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59629 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0R6H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Apr 2020 13:58:07 -0400
X-Originating-IP: 42.111.30.142
Received: from localhost (unknown [42.111.30.142])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6DE7B1C0005;
        Mon, 27 Apr 2020 17:57:52 +0000 (UTC)
Date:   Mon, 27 Apr 2020 23:25:36 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, vigneshr@ti.com,
        tudor.ambarus@microchip.com, juliensu@mxic.com.tw, richard@nod.at,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421092328.129308f6@collabora.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/04/20 09:23AM, Boris Brezillon wrote:
> +Pratyush who's working on a similar patchet [1].
> 
> Hello Mason,
> 
> On Tue, 21 Apr 2020 14:39:42 +0800
> Mason Yang <masonccyang@mxic.com.tw> wrote:
> 
> > Hello,
> > 
> > This is repost of patchset from Boris Brezillon's
> > [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].
> 
> I only quickly went through the patches you sent and saying it's a
> repost of the RFC is a bit of a lie. You completely ignored the state
> tracking I was trying to do to avoid leaving the flash in 8D mode when
> suspending/resetting the board, and I think that part is crucial. If I
> remember correctly, we already had this discussion so I must say I'm a
> bit disappointed.
> 
> Can you sync with Pratyush? I think his series [1] is better in that it
> tries to restore the flash in single-SPI mode before suspend (it's
> missing the shutdown case, but that can be easily added I think). Of
> course that'd be even better to have proper state tracking at the SPI
> NOR level.

Hi Mason,

I posted a re-roll of my series here [0]. Could you please base your 
changes on top of it? Let me know if the series is missing something you 
need.
 
[0]  https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
