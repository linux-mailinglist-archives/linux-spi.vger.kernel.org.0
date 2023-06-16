Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0947335C3
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbjFPQR7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345019AbjFPQRk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 12:17:40 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066C46AD
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 09:15:39 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686932138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5F/RWcmHXxlm2EZb3KACT2rj6ZLFMEn3BsMLoTGYuJU=;
        b=k+BZxRHU/qUDi2X382+shZi7QedN/LrX4yIogLVF7XFERCsvNtWGSKqpirfyqXZLwmHsI4
        wAh21QaCznq5A07tcugVgw5qWi685loVochVk+d2iJbHv5FxlX+zuO9ChhmKIGtTS8gL7e
        pfGKgjVrcCBB6PLUNYNKE1H8rT27biZMpzWjaqlJTitN+DhJMVYLl7FfaIqQx77uEvijhT
        aiSBBpPjvTYdgaG+5/E4YVaH8a2a78HetByjvGWIAJuczwmIN3FZpDJ0tLbxJfzWE1UeaL
        zjpsLw0BL4fk0YEEJzqj2SeCOrUx3v9mjg3L0hpX351Wq2Kz/mk0RWURZI94yQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E078240007;
        Fri, 16 Jun 2023 16:15:37 +0000 (UTC)
Date:   Fri, 16 Jun 2023 18:15:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <20230616181535.032bf9de@xps-13>
In-Reply-To: <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
        <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 16 Jun 2023 15:20:27 +0100:

> On Fri, Jun 16, 2023 at 04:12:25PM +0200, Miquel Raynal wrote:
>=20
> > -#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
> > +#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
> > +#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4)) =20
>=20
> Given that we know the bus speed can't we just calculate this like other
> drivers do (we should probably add a helper TBH)?

I agree we should probably have some kind of easy-to-use helper to
derive a decent timeout value. How do sound the heuristics
proposed here to you ? That would be:

	timeout =3D 1s + 4ms/10k

Thanks,
Miqu=C3=A8l
