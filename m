Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A229DC83
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 01:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgJ1WdH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Oct 2020 18:33:07 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:36732 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgJ1Wb4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 18:31:56 -0400
X-Greylist: delayed 891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:31:54 EDT
Received: from localhost (ip-94-112-194-201.net.upcbroadband.cz [94.112.194.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 0E59840006C;
        Wed, 28 Oct 2020 17:20:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1603902025;
        bh=FRibDlx3Yp7qZ17lscMO2+sg7G7lVTcO2Z4urA+IPno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e5UA9ya9CDjPccXm0zpAHIs3QLM/9+l5o4JCbiyoMwo/+YI2a9+2jCe1lMhcVcsjr
         3Bdwrutxe++DGbJL1HkJZLAiKIYRLN1tynlSzlfcesBD3WCLUDMierbMOm6TP43GJH
         JuPiHxYogAW/ugfXqp13he4XIZrvhhoudmGFlk0UBRQI0QSdupvUw4p6sSANTAe+Ys
         R8oGw0LF09ln57rgGcpe2jIJZbJmVYtzljIxtukGvpGw2atj+Km9KiYQGml7zt4tNU
         O7bSchZIaBay3h6dad2vlLYsd2/0/TTfFKYFnbLa0uHZkLVIaEsZfnCSU5TnG9GNcU
         6wHyAja9PvleA==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2] serial: max310x: rework RX interrupt handling
Date:   Wed, 28 Oct 2020 17:20:24 +0100
MIME-Version: 1.0
Message-ID: <3841e43b-5f16-4b5c-9b43-4d3a90e57723@cesnet.cz>
In-Reply-To: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
References: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.14.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On =C4=8Dtvrtek 1. =C5=99=C3=ADjna 2020 9:44:15 CEST, Thomas Petazzoni wrote:=

> Currently, the RX interrupt logic uses the RXEMPTY interrupt, with the
> RXEMPTYINV bit set, which means we get an RX interrupt as soon as the
> RX FIFO is non-empty.
>
> However, with the MAX310X having a FIFO of 128 bytes, this makes very
> poor use of the FIFO: we trigger an interrupt as soon as the RX FIFO
> has one byte, which means a lot of interrupts, each only collecting a
> few bytes from the FIFO, causing a significant CPU load.

Thanks for taking the time to write this patch. We're using MAX14830 on a=20
Clearfog Base board via a 26 MHz SPI bus. Our code polls a custom=20
peripheral over UART at 115200 baud ten times a second; the messages are=20
typically shorter than 50 chars. Before this patch, `perf top --sort=20
comm,dso` showed about 28% CPU load for the corresponding SPI kthread,=20
after applying this patch it's between 3 and 5%. That's cool :).

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

(but see below, please)

> +=09/* Enable LSR, RX FIFO trigger, CTS change interrupts */
> +=09val =3D MAX310X_IRQ_LSR_BIT  | MAX310X_IRQ_RXFIFO_BIT |=20
> MAX310X_IRQ_TXEMPTY_BIT;
>  =09max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);=


This comment doesn't fully match that code, and also the effective value=20
that is written to the register is split into two statements. What about=20
just:

+=09/* Enable LSR, RX FIFO trigger, TX FIFO empty, CTS change interrupts */
+ =09max310x_port_write(port, MAX310X_IRQEN_REG, MAX310X_IRQ_LSR_BIT |=20
MAX310X_IRQ_RXFIFO_BIT | MAX310X_IRQ_TXEMPTY_BIT | MAX310X_IRQ_CTS_BIT);

With kind regards,
Jan
