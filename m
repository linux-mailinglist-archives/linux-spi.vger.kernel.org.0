Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5301E7558
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 07:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgE2F16 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 01:27:58 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:21142 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2F15 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 01:27:57 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 04T5R3iF028507;
        Fri, 29 May 2020 13:27:03 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id EE1F313970D7BAF9D89B;
        Fri, 29 May 2020 13:27:03 +0800 (CST)
In-Reply-To: <20200528102609.0dbb59a5@collabora.com>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw> <20200528102609.0dbb59a5@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, matthias.bgg@gmail.com,
        miquel.raynal@bootlin.com, p.yadav@ti.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v3 00/14] mtd: spi-nor: add xSPI Octal DTR support
MIME-Version: 1.0
X-KeepSent: 584CB594:BEA39E9B-48258577:001D866D;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF584CB594.BEA39E9B-ON48258577.001D866D-48258577.001DF14F@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 29 May 2020 13:27:03 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/29 PM 01:27:03,
        Serialize complete at 2020/05/29 PM 01:27:03
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 04T5R3iF028507
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Boris,

> > 
> > 
> > Summary of change log
> > v3:
> > Add support command sequences to change octal DTR mode and based on
> > part of Pratyush's patches set.
> > 
> > v2: 
> > Parse BFPT & xSPI table for Octal 8D-8D-8D mode parameters and enable 
Octal
> > mode in spi_nor_late_init_params().
> > Using Macros in spi_nor_spimem_read_data, spi_nor_spimem_write_data 
and
> > so on by Vignesh comments.
> > 
> > v1:
> > Without parsing BFPT & xSPI profile 1.0 table and enter Octal 8D-8D-8D
> > mode directly in spi_nor_fixups hooks.
> > 
> > 
> > thnaks for your time and review.
> > best regards,
> > Mason
> > 
> > --
> > Mason Yang (7):
> >   mtd: spi-nor: sfdp: get octal mode maximum speed from BFPT
> >   mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
> >   mtd: spi-nor: sfdp: parse command sequences to change octal DTR mode
> >   mtd: spi-nor: core: add configuration register 2 read & write 
support
> >   spi: mxic: patch for octal DTR mode support
> >   mtd: spi-nor: core: execute command sequences to change octal DTR 
mode
> >   mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix
> >     mx25uw51245g
> > 
> > Pratyush Yadav (7):
> >   spi: spi-mem: allow specifying whether an op is DTR or not
> >   spi: spi-mem: allow specifying a command's extension
> >   mtd: spi-nor: add support for DTR protocol
> >   mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
> >   mtd: spi-nor: sfdp: get command opcode extension type from BFPT
> >   mtd: spi-nor: core: use dummy cycle and address width info from SFDP
> >   mtd: spi-nor: core: enable octal DTR mode when possible
> 
> Why are you doing that?! This series is being actively worked on by
> Pratyush, and all you gain by sending it on your own is more
> confusion. If you have patches on top of a series that's not been
> merged yet, mention the dependency in the cover letter, but don't
> resend patches that have already been sent and are being reviewed.

okay, much thank for your comments.
Will re-submit and mention the dependency in my cover letter.

Hi Pratyush,
Sorry if these patches make you uncomfortable.

> 
> I think it's time you spend a bit of time learning about the submission
> process, because that's not the first mistake you do, and I'm pretty
> sure I already mentioned that in my previous reviews.

best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

