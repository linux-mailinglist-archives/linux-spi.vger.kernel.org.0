Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45121CFA2
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 08:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgGMG2d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 02:28:33 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:10345 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMG2d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 02:28:33 -0400
X-Greylist: delayed 2376 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 02:28:32 EDT
Received: from TWHMLLG4.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG4.macronix.com with ESMTP id 06D5muVN014429
        for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2020 13:48:56 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 06D5lxWN013791;
        Mon, 13 Jul 2020 13:47:59 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id CD64D56BB534C3CED3CB;
        Mon, 13 Jul 2020 13:47:59 +0800 (CST)
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
To:     ycllin@mxic.com.tw
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add xSPI Octal DTR support
MIME-Version: 1.0
X-KeepSent: 489B498F:FD7A0610-482585A4:001F9CFA;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF489B498F.FD7A0610-ON482585A4.001F9CFA-482585A4.001FDC15@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 13 Jul 2020 13:47:59 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/07/13 PM 01:47:59,
        Serialize complete at 2020/07/13 PM 01:47:59
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 06D5lxWN013791
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


+ YC Lin in loop,

YC(ycllin@mxic.com.tw)will take over this patch set.


> Subject
> 
> [PATCH v4 0/7] mtd: spi-nor: add xSPI Octal DTR support
> 
> Hello,
> 
> JESD216C has defined specification for Octal 8S-8S-8S and 8D-8D-8D.
> Based on JEDEC216C Basic Flash Parameter Table (BFPT) driver extract
> DWORD-18: command and command extension type.
> DWORD-20: Maximum operation speed of device in Octal mode.
> 
> xSPI profile 1.0 table:
> DWORD-1: Read Fast command, the number of dummy cycles and address 
nbytes
>     for Read Status Register command.
> DWORD-2: Read/Write volatile Register command for CFG Reg2.
> DWORD-4 and DWORD-5: dummy cycles used for various frequencies based on
> maximum speed of device from BFPT 20th DWORD.
> 
> Ccommand sequences to change to octal DTR mode:
> The length of each command sequence is 8 per byte for single SPI mode 
and
> patching driver to parse and execute these sequences for octal DTR mode.
> 
> By Vignesh's comments, this patches set is dependency on Pratyush's
> [1][2][5][7][8] and [10][12].
> 
> Tested on Macronix's Zynq PicoZed board with Macronix's SPI controller
> (spi-mxic.c) driver patched on mx25uw51245g Octal flash.
> 


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

