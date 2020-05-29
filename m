Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD6F1E7917
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2JOA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 05:14:00 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42539 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2JOA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 05:14:00 -0400
X-Originating-IP: 42.109.222.225
Received: from localhost (unknown [42.109.222.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0194720011;
        Fri, 29 May 2020 09:13:49 +0000 (UTC)
Date:   Fri, 29 May 2020 14:43:42 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200529091342.75amqyxwucb3v3vo@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 29/05/20 03:36PM, Mason Yang wrote:
> Mason Yang (7):
>   mtd: spi-nor: sfdp: get octal mode maximum speed from BFPT
>   mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table

I think you've misunderstood what Boris meant. The idea of specifying a 
dependency on a patch set is assuming that entire series is already 
applied to the main branch, and then creating patches on top of those.

So, for example, you can checkout the 'master' branch of linux-next. 
Then apply all 19 of my patches on top of that branch by using 'git am'. 
Then you add your work there and separate it out on a set of commits.

If you'd to that, you won't need to add a separate patch for parsing the 
Profile 1.0 table because I've already done that in my series. All you 
need to do is add the extra things, like adding parsing of a DWORD that 
my series doesn't, or adding support for your Macronix flash.

>   mtd: spi-nor: sfdp: parse command sequences to change octal DTR mode
>   mtd: spi-nor: core: add configuration register 2 read & write support
>   mtd: spi-nor: core: execute command sequences to change octal DTR mode
>   spi: mxic: patch for octal DTR mode support
>   mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix
>     mx25uw51245g
> 
>  drivers/mtd/spi-nor/core.c     | 151 ++++++++++++++++++++++++-
>  drivers/mtd/spi-nor/core.h     |  41 +++++++
>  drivers/mtd/spi-nor/macronix.c |  55 +++++++++
>  drivers/mtd/spi-nor/sfdp.c     | 246 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/sfdp.h     |   4 +
>  drivers/spi/spi-mxic.c         |  98 ++++++++++------
>  6 files changed, 562 insertions(+), 33 deletions(-)
> 

-- 
Regards,
Pratyush Yadav
