Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB31D4665
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEOGz3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 02:55:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56439 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgEOGz3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 02:55:29 -0400
X-Originating-IP: 42.109.214.107
Received: from localhost (unknown [42.109.214.107])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5008920006;
        Fri, 15 May 2020 06:55:20 +0000 (UTC)
Date:   Fri, 15 May 2020 12:25:08 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, juliensu@mxic.com.tw,
        richard@nod.at, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200515065508.6cra7nwt3jpxwvr2@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
 <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
 <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
 <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
 <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw>
 <20200506094028.2asq56goslfd2ngo@yadavpratyush.com>
 <OF03B5329E.56965A70-ON48258569.000878CE-48258569.000D5FFD@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF03B5329E.56965A70-ON48258569.000878CE-48258569.000D5FFD@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 15/05/20 10:26AM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
> > > > > I can't apply your patches to enable xSPI Octal mode for 
> > > > > mx25uw51245g because your patches set up Octal protocol first and 
> > > > > then using Octal protocol to write Configuration Register 2(CFG 
> > > > > Reg2). I think driver
> > > > > should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make 
> sure
> > > > > write CFG Reg 2 is success and then setup Octa protocol in the 
> last.
> > > > 
> > > > Register writes should work in 1S mode, because nor->reg_proto is 
> only 
> > > > set _after_ 8D mode is enabled (see spi_nor_octal_dtr_enable()). In 
> > > > fact, both patch 15 and 16 in my series use register writes in 1S 
> mode.
> > > 
> > > but I didn't see driver roll back "nor->read/write_proto = 1" 
> > > if xxx->octal_dtr_enable() return failed!
> > 
> > I copied what spi_nor_quad_enable() did, and made failure fatal. So if 
> > xxx->octal_dtr_enable() fails, the probe would fail and the flash would 
> > be unusable. You can try your hand at a fallback system where you try 
> 
> IMHO, it's not a good for system booting from SPI-NOR, 
> driver should still keep system alive in SPI 1-1-1 mode in case of 
> enable Octal/Quad failed.

I agree.
 
> Therefore, my patches is to setup nor->read/write_proto = 8 in case 
> driver enable Octal mode is success. And to enable Octal mode in
> spi_nor_late_init_params()rather than as spi_nor_quad_enable()did.

Like I mentioned before, spi_nor_late_init_params() is called _before_ 
we call spi_nor_spimem_adjust_hwcaps(). That call is needed to make sure 
the controller also supports octal mode operations. Otherwise, you'd end 
up enabling octal mode on a controller that doesn't support it with no 
way of going back now.

But we can still have a fallback mechanism even in spi_nor_init() that 
would switch to a "less preferred" mode (like 1-1-1 mode) if "more 
preferred" ones like octal or quad fail.

That said, I think it would be a good idea to not keep tacking features 
on this series. This makes it harder for reviewers because now they are 
trying to shoot a moving target. Let basic 8D support stabilize and get 
merged in, and then a fallback system can be submitted as a separate 
patch series.

-- 
Regards,
Pratyush Yadav
