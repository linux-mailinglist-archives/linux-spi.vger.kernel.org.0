Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980029D2F8
	for <lists+linux-spi@lfdr.de>; Wed, 28 Oct 2020 22:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgJ1VkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 28 Oct 2020 17:40:08 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:44330 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgJ1VkC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 17:40:02 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 9CA283B2661;
        Wed, 28 Oct 2020 17:07:15 +0000 (UTC)
X-Originating-IP: 83.193.246.53
Received: from windsurf.home (lfbn-bay-1-165-53.w83-193.abo.wanadoo.fr [83.193.246.53])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1EC8C20009;
        Wed, 28 Oct 2020 17:06:51 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:06:51 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2] serial: max310x: rework RX interrupt handling
Message-ID: <20201028180651.50ca85d3@windsurf.home>
In-Reply-To: <3841e43b-5f16-4b5c-9b43-4d3a90e57723@cesnet.cz>
References: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
        <3841e43b-5f16-4b5c-9b43-4d3a90e57723@cesnet.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On Wed, 28 Oct 2020 17:20:24 +0100
Jan Kundrát <jan.kundrat@cesnet.cz> wrote:

> Thanks for taking the time to write this patch. We're using MAX14830 on a 
> Clearfog Base board via a 26 MHz SPI bus. Our code polls a custom 
> peripheral over UART at 115200 baud ten times a second; the messages are 
> typically shorter than 50 chars. Before this patch, `perf top --sort 
> comm,dso` showed about 28% CPU load for the corresponding SPI kthread, 
> after applying this patch it's between 3 and 5%. That's cool :).
> 
> Tested-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> Reviewed-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> 
> (but see below, please)

Thanks for your review and testing, and glad to hear that it also
improves the CPU load on your use-case.

> > +	/* Enable LSR, RX FIFO trigger, CTS change interrupts */
> > +	val = MAX310X_IRQ_LSR_BIT  | MAX310X_IRQ_RXFIFO_BIT | 
> > MAX310X_IRQ_TXEMPTY_BIT;
> >  	max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);  
> 
> This comment doesn't fully match that code, and also the effective value 
> that is written to the register is split into two statements. What about 
> just:
> 
> +	/* Enable LSR, RX FIFO trigger, TX FIFO empty, CTS change interrupts */
> + 	max310x_port_write(port, MAX310X_IRQEN_REG, MAX310X_IRQ_LSR_BIT | 
> MAX310X_IRQ_RXFIFO_BIT | MAX310X_IRQ_TXEMPTY_BIT | MAX310X_IRQ_CTS_BIT);

Indeed, the comment should be updated, I'll fix that. Regarding the
effective value computed in two steps, it was already the case in the
current code:

	/* Enable RX, TX, CTS change interrupts */
	val = MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
        max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);

but granted, that's not an excuse not to fix it.

On my way to send a v3 :-)

Thanks again,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
