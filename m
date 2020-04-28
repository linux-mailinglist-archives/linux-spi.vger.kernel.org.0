Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4F1BB8E6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgD1IgC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 04:36:02 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48085 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD1IgC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 04:36:02 -0400
X-Originating-IP: 42.109.192.12
Received: from localhost (unknown [42.109.192.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7009F1BF205;
        Tue, 28 Apr 2020 08:35:54 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:05:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     masonccyang@mxic.com.tw, broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200428083543.fdppjts5cgmyqu52@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
 <20200428083423.4fafd187@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428083423.4fafd187@collabora.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/04/20 08:34AM, Boris Brezillon wrote:
> On Tue, 28 Apr 2020 14:14:31 +0800
> masonccyang@mxic.com.tw wrote:
> > 
> > I quickly went through your patches but can't reply them in each 
> > your patches.
> 
> Why?!! Aren't you registered to the MTD mailing list? Sorry but having
> reviews outside of the original thread is far from ideal. Please find a
> way to reply to the original patchset.

Yes, inline replies to the original patchset would be nice.

FWIW, I'm not subscribed to the list either. I use the NNTP server at 
nntp.lore.kernel.org, and the newsgroup org.infradead.lists.linux-mtd to 
read and reply to the list. Most popular email clients should have NNTP 
support. I use neomutt, but AFAIK, Thunderbird and gnus also have NNTP 
support.

-- 
Regards,
Pratyush Yadav
