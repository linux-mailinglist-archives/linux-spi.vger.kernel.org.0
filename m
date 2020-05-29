Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2603E1E796F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2J2L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 05:28:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34851 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2J2L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 05:28:11 -0400
Received: from localhost (unknown [42.109.222.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D76C2240005;
        Fri, 29 May 2020 09:28:04 +0000 (UTC)
Date:   Fri, 29 May 2020 14:57:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com
Subject: Re: [PATCH v4 2/7] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
Message-ID: <20200529092758.ezuyac2r6vmp6tfs@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737775-4798-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/05/20 03:36PM, Mason Yang wrote:
> JESD251, xSPI profile 1.0 table supports octal DTR mode.
> Extract information like the fast read opcode, dummy cycles for various
> frequencies, the number of dummy cycles needed for a Read Status
> Register command, the number of address bytes needed for a Read
> Status Register command, read volatile register command and write
> volatile register command.

Like I said before, please don't re-introduce the functions. My patch 
series already parses the table. Add whatever new feature you want on 
top of it.
 
> According to BFPT 20th DWORD of octal maximum speed, driver get it's
> specific dummy cycles from profile 1.0 table and then could update
> it to device by their fixup hooks.

My patch [0] already find out the dummy cycles from the table as you 
suggested, though it doesn't consult the BFPT. Instead, it uses the 
dummy cycle fields themselves as indication that a speed is supported or 
not.
 
[0] https://lore.kernel.org/linux-mtd/20200525091544.17270-10-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
