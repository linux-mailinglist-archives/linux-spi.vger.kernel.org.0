Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33FB78F36
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfG2P3E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 11:29:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57430 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfG2P3E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 11:29:04 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 65B8826D9C2;
        Mon, 29 Jul 2019 16:29:02 +0100 (BST)
Date:   Mon, 29 Jul 2019 17:28:59 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [RFC v1 0/3] *spi-mem: adding setup and callback function
Message-ID: <20190729172859.4374a2ad@collabora.com>
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tomer,

On Mon, 29 Jul 2019 17:25:01 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Lately we have working on Flash interface unit (FIU) SPI driver that 
> using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.
> 
> In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory mapping as follow:
> 
> FIU0 - have 2 chip select and each one have 128MB memory mapping (total 256MB memory mapping)
> FIU1 - have 4 chip select and each one have 128MB memory mapping (total 512MB memory mapping)
> FIU2 - have 4 chip select and each one have 16MB memory mapping (total 32MB memory mapping)
> 
> Totally 800MB memory mapping.
> 
> When the FIU driver probe it don't know the size of each Flash that 
> connected to the FIU, so the entire memory mapping is allocated for each FIU 
> according the FIU device tree memory map parameters.

Do you need those mappings to be active to support simple reg accesses?

> It means, if we enable all three FIU's the drivers will try to allocate totally 800MB.
> 
> In 32bit system it is problematic because the kernel have only 1GB 
> of memory allocation so the vmalloc cannot take 800MB.
> 
> When implementing the FIU driver in the mtd/spi-nor we allocating memory address only 
> for detected Flash with exact size (usually we are not using 128MB Flash), and in that case usually we allocating much less memory.
> 
> To solve this issue we needed to overcome two things:
> 
> 1.	Get argument from the upper layer (spi-mem layer) 
> 2.	Calling the get argument function after SPI_NOR_SCAN function. (the MTD Flash size filled in  SPI_NOR_SCAN function)

That's clearly breaking the layering we've tried to restore with the
spi-nor/spi-mem split, and I don't see why this is needed since we now
have a way to create direct mappings dynamically (with the dirmap API).
Have you tried implementing the dirmap hooks in your driver?

Regards,

Boris
