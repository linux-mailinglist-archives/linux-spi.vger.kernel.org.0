Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0327D1E5AB9
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgE1I0P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 04:26:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51382 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgE1I0O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 04:26:14 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3A37B2A3D3D;
        Thu, 28 May 2020 09:26:12 +0100 (BST)
Date:   Thu, 28 May 2020 10:26:09 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        matthias.bgg@gmail.com, p.yadav@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 00/14] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200528102609.0dbb59a5@collabora.com>
In-Reply-To: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 28 May 2020 15:58:02 +0800
Mason Yang <masonccyang@mxic.com.tw> wrote:

> Hello,
> 
> JESD216C has defined specification for Octal 8S-8S-8S and 8D-8D-8D.
> Based on JEDEC216C Basic Flash Parameter Table (BFPT) driver extract
> DWORD-18: command and command extension type.
> DWORD-20: Maximum operation speed of device in Octal mode.
> 
> xSPI profile 1.0 table:
> DWORD-1: Read Fast command, the number of dummy cycles and address nbytes
> 	 for Read Status Register command.
> DWORD-2: Read/Write volatile Register command for CFG Reg2.
> DWORD-4 and DWORD-5: dummy cycles used for various frequencies based on
> maximum speed of device from BFPT 20th DWORD.
> 
> Ccommand sequences to change to octal DTR mode:
> The length of each command sequence is 8 per byte for single SPI mode and
> patching driver to parse and execute these sequences for octal DTR mode.
> 
> By Vignesh's comments to patch these drivers based on Pratyush's patches
> set [1].
> 
> This series adds support for Macronix mx25uw51245g works in octal DTR mode.
> 
> Tested on Macronix's Zynq PicoZed board with Macronix's SPI controller
> (spi-mxic.c) driver patched on mx25uw51245g Octal flash.
> 
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/cover/20200525091544.17270-1-p.yadav@ti.com/
> 
> 
> Summary of change log
> v3:
> Add support command sequences to change octal DTR mode and based on
> part of Pratyush's patches set.
> 
> v2: 
> Parse BFPT & xSPI table for Octal 8D-8D-8D mode parameters and enable Octal
> mode in spi_nor_late_init_params().
> Using Macros in spi_nor_spimem_read_data, spi_nor_spimem_write_data and
> so on by Vignesh comments.
> 
> v1:
> Without parsing BFPT & xSPI profile 1.0 table and enter Octal 8D-8D-8D
> mode directly in spi_nor_fixups hooks.
> 
> 
> thnaks for your time and review.
> best regards,
> Mason
> 
> --
> Mason Yang (7):
>   mtd: spi-nor: sfdp: get octal mode maximum speed from BFPT
>   mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
>   mtd: spi-nor: sfdp: parse command sequences to change octal DTR mode
>   mtd: spi-nor: core: add configuration register 2 read & write support
>   spi: mxic: patch for octal DTR mode support
>   mtd: spi-nor: core: execute command sequences to change octal DTR mode
>   mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix
>     mx25uw51245g
> 
> Pratyush Yadav (7):
>   spi: spi-mem: allow specifying whether an op is DTR or not
>   spi: spi-mem: allow specifying a command's extension
>   mtd: spi-nor: add support for DTR protocol
>   mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
>   mtd: spi-nor: sfdp: get command opcode extension type from BFPT
>   mtd: spi-nor: core: use dummy cycle and address width info from SFDP
>   mtd: spi-nor: core: enable octal DTR mode when possible

Why are you doing that?! This series is being actively worked on by
Pratyush, and all you gain by sending it on your own is more
confusion. If you have patches on top of a series that's not been
merged yet, mention the dependency in the cover letter, but don't
resend patches that have already been sent and are being reviewed.

I think it's time you spend a bit of time learning about the submission
process, because that's not the first mistake you do, and I'm pretty
sure I already mentioned that in my previous reviews.
